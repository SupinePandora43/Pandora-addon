Metrostroi.DefineSystem("Arcade_Systems")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.Drive = 0
	self.Brake = 0
	self.Reverse = 0
	self.Force = 200000
end


function TRAIN_SYSTEM:Inputs()
	return { "Drive", "Brake","Reverse" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
	if self[name] then self[name] = value end
end



--------------------------------------------------------------------------------
function TRAIN_SYSTEM:Think()
	--print("DRIVE",self.Drive)
	self.Train.FrontBogey.MotorForce = self.Force
	self.Train.FrontBogey.MotorPower = self.Drive - self.Brake
	self.Train.FrontBogey.Reversed = (self.Reverse > 0.5)
	self.Train.RearBogey.MotorForce  = self.Force
	self.Train.RearBogey.MotorPower = self.Drive - self.Brake
	self.Train.RearBogey.Reversed = not (self.Reverse > 0.5)
end