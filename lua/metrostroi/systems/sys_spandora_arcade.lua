Metrostroi.DefineSystem("Arcade_Systems")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.Drive = 0
	self.Brake = 0
	self.Reverse = 0
	self.Force = 200000
	self.Horn = 0
	self.Turbo = 0
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
	if self.Horn then
		self.Train:SetPackedBool("Horn", self.Horn == 1)
	end
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
function TRAIN_SYSTEM:ClientThink(dT)
	self:SetSoundState("horn1",self.Train:GetPackedBool("Horn",false) and 1 or 0,1)
end