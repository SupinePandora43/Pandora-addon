Metrostroi.DefineSystem("Arcade_Systems")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.Drive = 0
	self.Brake = 0
	self.Reverse = 0
	self.Force = 200000
	self.Horn = 0
	self.Turbo = 0
	if (not self.Train.SoundNames["horn"]) and self.Train.SoundNames["horn1"] then
		self.Train.SoundNames["horn"] = self.Train.SoundNames["horn1"]
		self.Train.SoundPositions["horn"] = self.Train.SoundPositions["horn1"]
	elseif not (self.Train.SoundNames["horn"] or self.Train.SoundNames["horn1"]) then
		self.Train.SoundNames["horn"] = {
			loop=0.6,
			"subway_trains/common/pneumatic/horn/horn1_start.wav",
			"subway_trains/common/pneumatic/horn/horn1_loop.wav",
			"subway_trains/common/pneumatic/horn/horn1_end.mp3"
		}
		self.Train.SoundPositions["horn"] = {1100,1e9,Vector(100,0,0),1}
	end
end

function TRAIN_SYSTEM:Inputs()
	return {
		"Drive",
		"Brake",
		"Reverse",
		"Horn",
		"Turbo"
	}
end

function TRAIN_SYSTEM:TriggerInput(name, value)
	if self[name] then self[name] = value end
end

function TRAIN_SYSTEM:Think()
	self.Train:SetPackedBool("Horn", self.Horn == 1)
	self.Train.FrontBogey.MotorForce = self.Force
	self.Train.FrontBogey.MotorPower = self.Drive - self.Brake
	self.Train.FrontBogey.Reversed = (self.Reverse > 0.5)
	self.Train.RearBogey.MotorForce  = self.Force
	self.Train.RearBogey.MotorPower = self.Drive - self.Brake
	self.Train.RearBogey.Reversed = not (self.Reverse > 0.5)
	if self.Turbo and self.Turbo > 0.5 then -- турбо, уиииии
		self.Train.FrontBogey.MotorForce = self.Train.FrontBogey.MotorForce*2--тли
		self.Train.RearBogey.MotorForce = self.Train.RearBogey.MotorForce*2
	end
end
function TRAIN_SYSTEM:ClientThink(dT) --not work :(
	self.Train:SetSoundState("horn",self.Train:GetPackedBool("Horn",false) and 1 or 0,1)
end