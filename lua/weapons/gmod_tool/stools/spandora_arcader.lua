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
		local ArcadeTrain=ents.Create(train:GetClass())
		undo.ReplaceEntity(train, ArcadeTrain)
		SafeRemoveEntity(train)
		ArcadeTrain:SetPos(pos-Vector(0, 0, 120))
		ArcadeTrain:SetAngles(ang)
		local defInitializeSounds = ArcadeTrain.InitializeSounds
		function ArcadeTrain:InitializeSounds()
			defInitializeSounds()
			if (not self.SoundNames["horn"]) and self.SoundNames["horn1"] then
				self.SoundNames["horn"] = self.SoundNames["horn1"]
				self.SoundPositions["horn"] = self.SoundPositions["horn1"]
			elseif not (self.SoundNames["horn"] or self.SoundNames["horn1"]) then
				self.SoundNames["horn"] = {
					loop=0.6,
					"subway_trains/common/pneumatic/horn/horn1_start.wav",
					"subway_trains/common/pneumatic/horn/horn1_loop.wav",
					"subway_trains/common/pneumatic/horn/horn1_end.mp3"
				}
				self.SoundPositions["horn"] = {1100,1e9,Vector(0,0,0),1}
			end
		end
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
			[KEY_W] =      "Drive",
			[KEY_S] =      "Brake",
			[KEY_R] =      "Reverse",
			[KEY_L] =      "Horn",
			[KEY_LSHIFT] = "Turbo"
		}
		ArcadeTrain.KeyMap[KEY_RSHIFT] = ArcadeTrain.KeyMap[KEY_LSHIFT] -- навсякий случий
		undo.Create(ArcadeTrain.PrintName.." Arcade")
		undo.AddFunction(function(tab, ArcadeTrain)
			local pos = ArcadeTrain:GetPos()
			local ang = ArcadeTrain:GetAngles()
			local train1=ents.Create(ArcadeTrain:GetClass())
			undo.ReplaceEntity(ArcadeTrain, train1)
			SafeRemoveEntity(ArcadeTrain)
			train1:SetPos(pos-Vector(0, 0, 120))
			train1:SetAngles(ang)
			train1:Spawn()
		end, ArcadeTrain)
		undo.SetPlayer(ply)
		undo.Finish()
	end
end