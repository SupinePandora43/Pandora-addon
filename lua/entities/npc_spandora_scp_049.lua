AddCSLuaFile()
--ENT.Type = "ai"--anim
ENT.Base = "base_nextbot"-- base_ai
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Friendly = false
ENT.Category = spandora.scp.Category
ENT.PrintName = "SCP - 049"
ENT.Author = "SupinePandora43"
ENT.Contact = "SupinePandora43"
ENT.Purpose = "Creates zombies"
ENT.Instructions = "Euclid"

table.insert(spandora.scp.classes, "npc_spandora_049")

list.Set( "NPC", "npc_spandora_scp_049", {
	Name = "SCP - 049",
	Class = "npc_spandora_scp_049",
	Category = spandora.scp.Category,
	Model = "models/vinrax/player/scp049_player.mdl"
} )
function ENT:Initialize()
	if SERVER then
		if(file.Exists("models/vinrax/player/scp049_player.mdl", "GAME")) then
			self:SetModel("models/vinrax/player/scp049_player.mdl")
		elseif(file.Exists("models/cpthazama/scp/049.mdl", "GAME")) then
			self:SetModel("models/cpthazama/scp/049.mdl")
		else
			self:SetModel("models/gman.mdl")
			self:SetColor(Color(255, 50, 50, 255))
		end
		self.LoseTargetDist = 2000
		self.SearchRadius = 2000
		self.AttackRadius = 40
		self.Enemy = nil
		self.Zombies = {}
		self:SetHealth(1700/2)--scp secret laboratory
		undo.Create(self:GetClass())
			--undo.AddFunction(self:RemoveZombies())
			undo.AddFunction(function()
				for k,zombie in pairs(self.Zombies) do
				SafeRemoveEntity(zombie)
			end end)
			undo.SetPlayer(self:GetOwner())
		undo.Finish()
	end
end
if SERVER then
	function ENT:SetEnemy( ent )
		self.Enemy = ent
	end
	function ENT:GetEnemy(  )
		return self.Enemy
	end
	function ENT:HaveEnemy()
		self:FindEnemy()
		if GetConVarNumber("ai_disabled") == 1 then return false end
		if(self:GetEnemy() and IsValid(self:GetEnemy()) and spandora.scp:IsEnemy(self, self:GetEnemy())) then
			if(self:GetRangeTo(self:GetEnemy():GetPos()) > self.LoseTargetDist) then
				return self:FindEnemy()
			elseif(self:GetEnemy():IsPlayer() and not self:GetEnemy():Alive()) then
				return self:FindEnemy()
			end
			return true
		else
			return self:FindEnemy()
		end
	end
	function ENT:RunBehaviour()
		while ( true ) do
			self.loco:SetDesiredSpeed(240)
			if( self:HaveEnemy() and GetConVarNumber("ai_disabled") == 0)then
				self:StartActivity(ACT_RUN)
				self:ChaseEnemy()
			else
				self:StartActivity(ACT_WALK)
				self:ResetSequence("idle_all_01")
			end
			coroutine.wait(0.3)
		end
	end
	function ENT:ChaseEnemy(ops)
		local ops = ops or {}
		local path = Path("Follow")
		path:SetMinLookAheadDistance(ops.lookahead or 300)
		path:SetGoalTolerance(ops.tolerance or 20)
		path:Compute(self, self:GetEnemy():GetPos())
		if(not path:IsValid()) then return "failed" end
		while (path:IsValid() and self:HaveEnemy()) do
			if (path:GetAge() > 0.1) then
				path:Compute(self, self:GetEnemy():GetPos())
			end
			path:Update( self )
			if(spandora.cvars.debug) then path:Draw() end
			if (self.loco:IsStuck()) then
				self:HandleStuck()
				return "stuck"
			end
			coroutine.yield()
		end
		return "ok"
	end
	function ENT:Think()
		if IsValid(self:GetEnemy()) then
			if self:GetEnemy():GetPos():Distance(self:GetPos())<spandora.scp.TouchRadius then
				--self:Attack(self:GetEnemy())
			end
		end
		for k,ent in pairs(ents.FindInSphere(self:GetPos(), self.AttackRadius) or {}) do
			if(spandora.scp:IsEnemy(self, ent)) then
				self:Attack(ent)
			end
		end
	end
	function ENT:Attack(ent)
		if(not self:GetTouchTrace().Entity) then return end
		local ang = ent:GetAngles()
		local pos = ent:GetPos()
		local vel = ent:GetVelocity()
		local dmgInfo = DamageInfo()
		dmgInfo:SetDamage(ent:Health())
		dmgInfo:SetAttacker(self)
		dmgInfo:SetDamageType(DMG_REMOVENORAGDOLL)--DMG_DISSOLVE
		ent:TakeDamageInfo(dmgInfo)
		if ent:Health() > 0 then
			table.insert(spandora.BlackList, ent)
			return
		end
		local zombie = ents.Create("npc_spandora_scp_049_2")
		zombie:SetPos(pos)
		zombie:SetAngles(ang)
		zombie:SetVelocity(vel)
		zombie:SetEnemy(self:GetEnemy())
		zombie.scp049 = self
		zombie:Spawn()
		--zombie:SetBodygroup(1, 0)
		table.insert(self.Zombies, zombie)
	end
	function ENT:RemoveZombies()
		for k,zombie in pairs(self.Zombies) do
			SafeRemoveEntity(zombie)
		end
	end
	function ENT:FindEnemy()
		local enems = {}
		for k, ent in pairs(ents.FindInSphere(self:GetPos(), self.SearchRadius)) do
			if(spandora.scp:IsEnemy(self, ent))then
				table.insert( enems, ent )
			end
		end
		table.sort(enems, function(enemy1, enemy2)
			local distanceP
			if(self:GetPos():Distance(enemy1:GetPos())<self:GetPos():Distance(enemy2:GetPos())) then
				distanceP = 1
			else
				distanceP = 2
			end
			if(distanceP==1)then return true
			else return false end
		end)
		self:SetEnemy(enems[1])
		for _,ent in pairs(enems) do
			if(not table.HasValue(spandora.scp.Enemy, ent))then
				table.Add(spandora.scp.Enemy, enems)
			end
		end
		return enems[1] and true or false
	end
end