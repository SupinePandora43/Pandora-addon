TOOL.Category = "Metro"
TOOL.Name = "Arcader"
TOOL.Command = nil
TOOL.ConfigName = ""
if CLIENT then
	language.Add("Tool.spandora_arcader.name", "Train Arcader Tool")
	language.Add("Tool.spandora_arcader.desc", "Arcade Trains")
	language.Add("Tool.spandora_arcader.0", "Primary: Arcade")
end
function TOOL:LeftClick(trace)
	if CLIENT then return true end
	local ply = self:GetOwner()
	if (ply:IsValid()) and (not ply:IsAdmin()) then return false end
	if not trace then return false end
	if not IsValid(trace.Entity) then return false end
	if trace.Entity.InitializeSystems then --типа если это поезд
		local train = trace.Entity
		local pos = train:GetPos()
		local ang = train:GetAngles()
		--[[if train.FrontCouple then--защита
			train.RearCouple:Decouple()
		end
		if train.RearBogey then
			train.RearCouple:Decouple()
		end]]
		local ArcadeTrain=ents.Create(train:GetClass())
		SafeRemoveEntity(train)
		ArcadeTrain:SetPos(pos-Vector(0, 0, 120))
		ArcadeTrain:SetAngles(ang)
		function ArcadeTrain:InitializeSystems()
			self:LoadSystem("Arcade_Systems")
		end
		function ArcadeTrain:Think()
			self.BaseClass.Think(self)
			for k, v in pairs(self.Lights) do
				self:SetLightPower(k, true)
			end
		end
		function ArcadeTrain:TrainSpawnerUpdate() end
		function ArcadeTrain:OnButtonPress(button,ply) end
		function ArcadeTrain:PostInitializeSystems() end
		function ArcadeTrain:OnButtonRelease() end
		function ArcadeTrain:NonSupportTrigger() end
		ArcadeTrain:Spawn()
		ArcadeTrain.Plombs = {}
		ArcadeTrain.KeyMap = {
		[KEY_W] = "Drive",
		[KEY_S] = "Brake",
		[KEY_R] = "Reverse",
		[KEY_L] = "Horn",
		[KEY_F] = "Turbo"
		}
		undo.Create(ArcadeTrain.PrintName.." Arcade")
		--undo.AddEntity(ArcadeTrain)
		undo.AddFunction(function(tab, ArcadeTrain)
			local pos = ArcadeTrain:GetPos()
			local ang = ArcadeTrain:GetAngles()
			local train1=ents.Create(ArcadeTrain:GetClass())
			--[[if ArcadeTrain.FrontCouple then--защита
				ArcadeTrain.RearCouple:Decouple()
			end
			if ArcadeTrain.RearBogey then
				ArcadeTrain.RearCouple:Decouple()
			end]]
			SafeRemoveEntity(ArcadeTrain)
			train1:SetPos(pos-Vector(0, 0, 120))
			train1:SetAngles(ang)
			train1:Spawn()
			--не затестеный код
			undo.Create(train1.PrintName)
			undo.AddEntity(train1)
			undo.SetPlayer(tab.Owner)
			undo.Finish()
		end, ArcadeTrain)
		undo.SetPlayer(ply)
		undo.Finish()
	end
end