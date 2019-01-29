AddCSLuaFile()
TDM_dollys = TDM_dollys or {}
if file.Exists("autorun/simftrailers_shared.lua", "LUA") then--edited simf_trailer_main_code for dolly support
	hook.Add("Think", "_simf_trailer_to_trailer", function()--Cyka Blyat
		for k,dolly in pairs(TDM_dollys) do if not IsValid(dolly) then table.remove(TDM_dollys, k) end end
		for _,dolly in pairs(TDM_dollys) do 
			for _, ent in pairs( ents.FindInSphere( dolly:LocalToWorld(dolly:GetCenterposition()), 30 ) ) do
				local dollyphys=dolly:GetPhysicsObject()
				if ( ent:GetClass() == "gmod_sent_vehicle_fphysics_base" ) then
					if not ent == dolly then 
						if ent:SimfIsTrailer() then
							if dolly:LocalToWorld(dolly:GetCenterposition()):Distance(ent:LocalToWorld(ent:GetTrailerCenterposition())) <= 3 then
								if not ent:GetNWBool("_is_trailer_was_connected_", false) then
									--if dolly:VehicleGetCanConnect() then 
										constraint.Ballsocket( ent, dolly,  0, 0, dolly:GetCenterposition(), 0, 0, 0 )
										dollyphys:ApplyForceCenter( Vector( ent:GetTrailerCenterposition() ) )
										ent:SetNWBool("_is_trailer_was_connected_", true)
										ent:SetNWEntity("connected_dolly", dolly)
										dolly.coupledTrailer=ent
									--end
								elseif not IsValid(constraint.FindConstraintEntity(ent, "Ballsocket")) then--ent:GetNWEntity("connected_dolly", nil)
									ent:SetNWBool("_is_trailer_was_connected_", false)
									--constraint.RemoveConstraints( ply:GetVehicle():GetParent(), "Ballsocket" )
								end
							end
							--if dolly:LocalToWorld(dolly:GetCenterposition()):Distance(ent:LocalToWorld(ent:GetTrailerCenterposition())) <= 10 then
							if IsValid(dolly.coupledTrailer) then
								if dolly:GetLightsEnabled() then
									dolly.coupledTrailer:SetLightsEnabled(true)
								else
									dolly.coupledTrailer:SetLightsEnabled(false)
								end
								if dolly:GetIsBraking() then
									dolly.coupledTrailer:SetEMSEnabled(true)
								else
									dolly.coupledTrailer.PressedKeys["joystick_handbrake"] = 0
									dolly.coupledTrailer:SetHandBrakeEnabled(false)
									dolly.coupledTrailer:SetEMSEnabled(false)
								end
								if dolly:GetFogLightsEnabled() then
									dolly.coupledTrailer:SetFogLightsEnabled(true)
								else
									dolly.coupledTrailer:SetFogLightsEnabled(false)
								end

								if dolly:GetGear() == 1 then
									dolly.coupledTrailer:SetNWBool("zadnyaya_gear", true)
								elseif dolly:GetGear() >= 2 then
									dolly.coupledTrailer:SetNWBool("zadnyaya_gear", false)
								end
								local turnmode=dolly.signal_left and (dolly.signal_right and 1 or 2) or (dolly.signal_right and 3 or 0)--wow
								turnmode=2
								if turnmode == 2 then
									net.Start( "simfphys_turnsignal" )
									net.WriteEntity( dolly.coupledTrailer )
									net.WriteInt( 2, 32 )
									net.Broadcast()
								elseif turnmode == 3 then
									net.Start( "simfphys_turnsignal" )
									net.WriteEntity( dolly.coupledTrailer )
									net.WriteInt( 3, 32 )
									net.Broadcast()
								elseif turnmode == 1 then
									net.Start( "simfphys_turnsignal" )
									net.WriteEntity( dolly.coupledTrailer )
									net.WriteInt( 1, 32 )
									net.Broadcast()
								elseif turnmode == 0 then
									net.Start( "simfphys_turnsignal" )
									net.WriteEntity( dolly.coupledTrailer )
									net.WriteInt( 0, 32 )
									net.Broadcast()
								end
								net.Start( "simfphys_turnsignal" )
									net.WriteEntity( dolly.coupledTrailer )
									net.WriteInt( 3, 32 )
									net.Broadcast()
								dolly.coupledTrailer:SetRightSignalEnabled(true)
								print(dolly.coupledTrailer.signal_left)
								--print(dolly.signal_left)
								--[[if dolly:GetLeftSignalEnabled() and not dolly:GetRightSignalEnabled() then
									net.Start( "simfphys_turnsignal" )
									net.WriteEntity( ent )
									net.WriteInt( 2, 32 )
									net.Broadcast()
								elseif dolly:GetRightSignalEnabled() and not dolly:GetLeftSignalEnabled() then
									net.Start( "simfphys_turnsignal" )
									net.WriteEntity( ent )
									net.WriteInt( 3, 32 )
									net.Broadcast()
								elseif dolly:GetLeftSignalEnabled() and dolly:GetRightSignalEnabled() then
									net.Start( "simfphys_turnsignal" )
									net.WriteEntity( ent )
									net.WriteInt( 1, 32 )
									net.Broadcast()
								elseif not dolly:GetLeftSignalEnabled() or not dolly:GetRightSignalEnabled() then
									net.Start( "simfphys_turnsignal" )
									net.WriteEntity( ent )
									net.WriteInt( 0, 32 )
									net.Broadcast()
								end]]
							end
						end
						--[[local Time = CurTime()
						if  ent:IsInitialized() then
							ent:SetColors()
							ent:SimulateVehicle( Time )
							ent:ControlLighting( Time )
							ent:ControlHorn()
							
							if istable( WireLib ) then
								ent:UpdateWireOutputs()
							end
							
							ent.NextWaterCheck = dolly.NextWaterCheck or 0
							if ent.NextWaterCheck < Time then
								ent.NextWaterCheck = Time + 0.5
								ent:WaterPhysics()
							end
							
							if ent:GetActive() then
								ent:SetPhysics( ((math.abs(ent.ForwardSpeed) < 50) and (ent.Brake > 0 or ent.HandBrake > 0)) )
							else
								ent:SetPhysics( true )
							end
						end]]
					end
				end
			end

		end
	end)
end

--Reefer 3000R -not long
local light_table = {
	ModernLights = true,

	L_RearLampPos = Vector(96,-23.6,3.3), -- расположение задних фар
	L_RearLampAng = Angle(0,0,0), -- угол поворота фар

	R_RearLampPos = Vector(96,23.6,3.3), -- расположение задних фар
    R_RearLampAng = Angle(0,0,0), -- угол поворота фар
    FogLight_sprites = {
		{pos = Vector( -51, 238.4, 52.46 ),size = 25,color = Color(255,134,74,255)},
		{pos = Vector( -51, 143.93, 52.46 ),size = 25,color = Color(255,134,74,255)},
		{pos = Vector( -51, 1.84, 52.46 ),size = 25,color = Color(255,134,74,255)},
		{pos = Vector( -50.5, 1, 47 ),size = 25,color = Color(255,134,74,255)},
		{pos = Vector( -51, -137.57, 52.46 ),size = 25,color = Color(255,134,74,255)},
		{pos = Vector( -51, -251.19, 52.46 ),size = 25,color = Color(255,134,74,255)},

		{pos = Vector(-45.233,-313.704 +51 ,157.484),size = 25,color = Color(255,134,74,255)},
		{pos = Vector(45.233, -313.704 +51 ,157.484),size = 25,color = Color(255,134,74,255)},
		{pos = Vector(-13.46, -313.704 +51 ,157.484),size = 25,color = Color(255,134,74,255)},
		{pos = Vector(13.46,  -313.704 +51 ,157.484),size = 25,color = Color(255,134,74,255)},
		{pos = Vector(0,      -313.704 +51 ,157.484),size = 25,color = Color(255,134,74,255)},
		{pos = Vector(-50.728,-302.523 +52,157.336),size = 25,color = Color(255,134,74,255)},
		{pos = Vector( 50.728,-302.523 +52,157.336),size = 25,color = Color(255,134,74,255)},

		{pos = Vector( -51, 238.56, 157.03 ),size = 25,color = Color(255,134,74,255)},
		{pos = Vector( -51, 144.31, 157.03 ),size = 25,color = Color(255,134,74,255)},
		{pos = Vector( -51, 2.25, 157.03 ),size = 25,color = Color(255,134,74,255)},
		{pos = Vector( -51, -137.54, 157.03 ),size = 25,color = Color(255,134,74,255)},

		{pos = Vector( 51, 238.56, 157.03 ),size = 25,color = Color(255,134,74,255)},
		{pos = Vector( 51, 144.31, 157.03 ),size = 25,color = Color(255,134,74,255)},
		{pos = Vector( 51, 2.25, 157.03 ),size = 25,color = Color(255,134,74,255)},
		{pos = Vector( 51, -137.54, 157.03 ),size = 25,color = Color(255,134,74,255)},

		{pos = Vector( 51, 238.4, 52.46 ),size = 25,color = Color(255,134,74,255)},
		{pos = Vector( 51, 143.93, 52.46 ),size = 25,color = Color(255,134,74,255)},
		{pos = Vector( 51, 1.84, 52.46 ),size = 25,color = Color(255,134,74,255)},
		{pos = Vector( 50.5, 1, 47 ),size = 25,color = Color(255,134,74,255)},
		{pos = Vector( 51, -137.57, 52.46 ),size = 25,color = Color(255,134,74,255)},
		{pos = Vector( 51, -251.19, 52.46 ),size = 25,color = Color(255,134,74,255)},
	},
	Rearlight_sprites = { -- задние фары
		{pos = Vector( 39.829,-313.244 +49.7,48.38),size = 30},
		{pos = Vector( 32.891,-313.244 +49.7,48.38),size = 30},
		{pos = Vector(-39.829,-313.244 +49.7,48.38),size = 30},
		{pos = Vector(-32.891,-313.244 +49.7,48.38),size = 30},
	},
	ems_sprites = { -- тормозные огни
		{pos = Vector(32.891, -313.244 +49.7,48.38),size = 30,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04,},
		{pos = Vector(-32.891,-313.244 +49.7,48.38),size = 30,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04,},
	},
	Turnsignal_sprites = { -- поворотники
		Left = { -- левый
		{pos = Vector(-39.829,-313.244 +49.7,48.38),size = 30},
		},
		Right = { -- правый
		{pos = Vector(39.829,-313.244 +49.7,48.38),size = 30},
		},
	
	},
}
list.Set( "simfphys_lights", "tdm_trailer_refeer", light_table) -- здесь тебе нужно изменить "test" на любое другое название, например "myfirstsimfcar"

local DKCAR = {

	Name = "Reefer 3000R", -- название машины в меню
    Model = "models/tdmcars/trailers/reefer3000r.mdl", -- модель машины (в вкладке дополнения и проп авто)
    Category = "TDM Trailers", -- категория в которой будет машина
    SpawnOffset = Vector(0,0,0),
    SpawnAngleOffset = 0,
 
    Members = {
        Mass = 1150, -- масса авто

        OnSpawn = function(ent)
	        if not ent.SimfIsTrailer == nil then 
	        	ent:SetActive( true ) -- makes avtive
	        	ent:SetSimfIsTrailer(true)  -- Is traieler?true - yes, false - no
	        	ent:SetTrailerCenterposition(Vector(0,216.2,37)) -- position of center ballsocket for trailer hook 33
				ent:SetCenterposition(Vector(0,-96.5,21.2)) -- position of center ballsocket for tow hitch(trailer coupling)
				
				--[[ent:SetLightsEnabled(true)
				ent:SetFogLightsEnabled(true)
				ent:SetEMSEnabled(true)]]
	        else
        		print("This trailer support trailers BASE, but you don't installed it")
        	end
        end,
		OnTick = function(ent) 
			local phys = ent:GetPhysicsObject()
            local physMass = 1150
	        if ent:GetBodygroup(1) == 1 then
                physMass =physMass+700
            end
            if ent:GetBodygroup(2) == 1 then
                physMass=physMass+700
            end
            phys:SetMass(physMass)
            if not ent.SimfIsTrailer == nil then 
	        	ent:Lock() -- locks trailer
	        	if not ent:GetIsBraking() then
	        		ent.ForceTransmission = 1
		        	if ent:GetNWBool("zadnyaya_gear", false) then
		        		ent.PressedKeys["joystick_throttle"] = 0 -- makes thottle to 0 when reverse, for remove handbrake
		        		ent.PressedKeys["joystick_brake"] = 1 -- makes brake to 1, for turn on reverse
		        	else
		        		ent.PressedKeys["joystick_throttle"] = 1 -- makes thottle to 1, for remove handbrake
		        		ent.PressedKeys["joystick_brake"] = 0 -- makes brake to 0, for turn off reverse
		        	end
	        	end 
			end
        end,

        LightsTable = "tdm_trailer_refeer", -- название light_table

        BulletProofTires = false,
 
        CustomSteerAngle = 0,
 
        AirFriction = -3000,
 
        FrontWheelRadius = 21,--радиус переднего колеса
        RearWheelRadius = 21,--радиус заднего колеса
 
        CustomMassCenter = Vector(0,0,23.3),
 
		SeatOffset = Vector(226.4,-32.1,30), -- положение водительского сидения
        SeatPitch = 0,
        SeatYaw = -90,

        MaxHealth = 9999999999,
        IsArmored = false,
 
        EnginePos = Vector(0,0,0),

        StrengthenSuspension = true, -- жесткая подвеска.

		FrontHeight = 4, -- высота передней подвески
		FrontWheelMass = 200,
		FrontConstant = 25000,
		FrontDamping = 2000,
		FrontRelativeDamping = 2500,

		RearHeight = 4, -- высота задней подвески
		RearWheelMass = 200,
		RearConstant = 25000,
		RearDamping = 2000,
		RearRelativeDamping = 2500,

		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,

		TurnSpeed = 4,

		MaxGrip = 79,
		Efficiency = 0.9,
		GripOffset = -3,
		BrakePower = 0, -- сила торможения

		IdleRPM = 0, -- мин. кол-во оборотов
		LimitRPM = 0, -- макс. кол-во оборотов
		Revlimiter = false, -- Если true - Когда стрелка спидометра доходит до красного обозначения, она не проходит дальше, если false - это игнорируется
		PeakTorque = 0, -- крутящий момент
		PowerbandStart = 0,
		PowerbandEnd = 0,
		Turbocharged = false, -- турбо false = нет, true = да
		Supercharged = false, -- супер заряд
		Backfire = false, -- стреляющий выхлоп

		FuelFillPos = Vector(59.5,55,11.1), -- положение заправки
		FuelType = FUELTYPE_NONE, -- тип топлива
		FuelTankSize = 0, -- размер бака

		PowerBias = 1,

		EngineSoundPreset = 1,
--
		snd_pitch = 0.5,
		snd_idle = "common/null.wav",

		snd_low = "common/null.wav",
		snd_low_revdown = "common/null.wav", -- это всё звук
		snd_low_pitch = 1,

		snd_mid = "common/null.wav",
		snd_mid_gearup = "common/null.wav",
		snd_mid_geardown = "common/null.wav",
		snd_mid_pitch = 2,

		snd_horn = "common/null.wav",

		snd_blowoff = "common/null.wav",
		snd_backfire = "common/null.wav",
--
		DifferentialGear = 0.4,
		Gears = {-0.2,0,0.1} -- кол-во передач и "мощность"
	}
}
if (file.Exists( "models/tdmcars/trailers/reefer3000r.mdl", "GAME" )) then -- путь модели (".mdl")
    list.Set( "simfphys_vehicles", "reefer3000r_tdm", DKCAR ) -- изменить на люброе название(например sim_fphys_lalala)
end
--dolly
local light_table = {
	ModernLights = true,

	L_RearLampPos = Vector(96,-23.6,3.3), -- расположение задних фар
	L_RearLampAng = Angle(0,0,0), -- угол поворота фар

	R_RearLampPos = Vector(96,23.6,3.3), -- расположение задних фар
    R_RearLampAng = Angle(0,0,0), -- угол поворота фар
    Rearlight_sprites = { -- задние фары
		--{pos = Vector( -38.29, -63.3, 28.12 ),size = 30,color=Color(255,0,0,100),material="sprites/light_ignorez"},

		--{pos = Vector( 38.29, -63.3, 28.12 ),size = 30,color=Color(255,0,0,100),material="sprites/light_ignorez"},

		{pos = Vector( -31.88, -63.3, 28.12 ),size = 30,color=Color(255,0,0,100),material="sprites/light_ignorez"},
		{pos = Vector( -35.04, -63.3, 28.12 ),size = 30,color=Color(255,0,0,100),material="sprites/light_ignorez"},
		{pos = Vector( -38.29, -63.3, 28.12 ),size = 30,color=Color(255,0,0,100),material="sprites/light_ignorez"},

		{pos = Vector( 31.88, -63.3, 28.12 ),size = 30 ,color=Color(255,0,0,100),material="sprites/light_ignorez"},
		{pos = Vector( 35.04, -63.3, 28.12 ),size = 30 ,color=Color(255,0,0,100),material="sprites/light_ignorez"},
		{pos = Vector( 38.29, -63.3, 28.12 ),size = 30 ,color=Color(255,0,0,100),material="sprites/light_ignorez"},
	},
	Reverselight_sprites = { -- фары заднего хода
		{pos = Vector( -28.79, -63.3, 30 ),size = 15},
		{pos = Vector( -28.79, -63.3, 29 ),size = 15},
		{pos = Vector( -28.79, -63.3, 28.12 ),size = 15},
		{pos = Vector( -28.79, -63.3, 27 ),size = 15},
		{pos = Vector( -28.79, -63.3, 26 ),size = 15},

		{pos = Vector( 28.79, -63.3, 30 ),size = 15},
		{pos = Vector( 28.79, -63.3, 29 ),size = 15},
		{pos = Vector( 28.79, -63.3, 28.12 ),size = 15},
		{pos = Vector( 28.79, -63.3, 27 ),size = 15},
		{pos = Vector( 28.79, -63.3, 26 ),size = 15},
	},
	ems_sprites = { -- тормозные огни
		{pos = Vector( -31.88, -63.3, 28.12 ),size = 30,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04,material="sprites/light_ignorez"},
		{pos = Vector( -35.04, -63.3, 28.12 ),size = 30,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04,material="sprites/light_ignorez"},
		{pos = Vector( -38.29, -63.3, 28.12 ),size = 30,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04,material="sprites/light_ignorez"},

		{pos = Vector( 31.88, -63.3, 28.12 ),size = 30,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04,material="sprites/light_ignorez"},
		{pos = Vector( 35.04, -63.3, 28.12 ),size = 30,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04,material="sprites/light_ignorez"},
		{pos = Vector( 38.29, -63.3, 28.12 ),size = 30,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04,material="sprites/light_ignorez"},
	},
	Turnsignal_sprites = { -- поворотники
		Left = { -- левый
			{pos = Vector( -43, -63.3, 30 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( -43, -63.3, 29 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( -43, -63.3, 28.12 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( -43, -63.3, 27 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( -43, -63.3, 26 ),size = 20,color=Color(255,120,0,255)},

			{pos = Vector( -42, -63.3, 30 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( -42, -63.3, 29 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( -42, -63.3, 28.12 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( -42, -63.3, 27 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( -42, -63.3, 26 ),size = 20,color=Color(255,120,0,255)},
		},
		Right = { -- правый
			{pos = Vector( 43, -63.3, 30 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( 43, -63.3, 29 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( 43, -63.3, 28.12 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( 43, -63.3, 27 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( 43, -63.3, 26 ),size = 20,color=Color(255,120,0,255)},

			{pos = Vector( 42, -63.3, 30 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( 42, -63.3, 29 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( 42, -63.3, 28.12 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( 42, -63.3, 27 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( 42, -63.3, 26 ),size = 20,color=Color(255,120,0,255)},
		},
	
	},
}
list.Set( "simfphys_lights", "tdm_trailer_dolly", light_table) -- здесь тебе нужно изменить "test" на любое другое название, например "myfirstsimfcar"

local DKCAR = {

	Name = "Pup trailer dolly", -- название машины в меню
    Model = "models/tdmcars/trailers/dolly.mdl", -- модель машины (в вкладке дополнения и проп авто)
    Category = "TDM Trailers", -- категория в которой будет машина
    SpawnOffset = Vector(0,0,0),
    SpawnAngleOffset = 0,
 
    Members = {
        Mass = 700, -- масса авто

        OnSpawn = function(ent)
	        if not ent.SimfIsTrailer == nil then 
	        	ent:SetActive( true ) -- makes avtive
	        	ent:SetSimfIsTrailer(true)  -- Is traieler?true - yes, false - no
	        	ent:SetTrailerCenterposition(Vector(0,147,39)) -- position of center ballsocket for trailer hook 33
				ent:SetCenterposition(Vector(0,-11,46)) -- position of center ballsocket for tow hitch(trailer coupling)

				
				table.insert(TDM_dollys, ent)
	        else
        		print("This trailer support trailers BASE, but you don't installed it")
        	end
        end,
		OnTick = function(ent) 
            if not ent.SimfIsTrailer == nil then 
	        	ent:Lock() -- locks trailer
	        	if not ent:GetIsBraking() then
	        		ent.ForceTransmission = 1
		        	if ent:GetNWBool("zadnyaya_gear", false) then
		        		ent.PressedKeys["joystick_throttle"] = 0 -- makes thottle to 0 when reverse, for remove handbrake
		        		ent.PressedKeys["joystick_brake"] = 1 -- makes brake to 1, for turn on reverse
		        	else
		        		ent.PressedKeys["joystick_throttle"] = 1 -- makes thottle to 1, for remove handbrake
		        		ent.PressedKeys["joystick_brake"] = 0 -- makes brake to 0, for turn off reverse
		        	end
	        	end 
			end
        end,

        LightsTable = "tdm_trailer_dolly", -- название light_table

        BulletProofTires = false,
 
        CustomSteerAngle = 0,
 
        AirFriction = -3000,
 
        FrontWheelRadius = 21,--радиус переднего колеса
        RearWheelRadius = 21,--радиус заднего колеса
 
        CustomMassCenter = Vector(0,-11,46),
 
		SeatOffset = Vector(226.4,-32.1,30), -- положение водительского сидения
        SeatPitch = 0,
        SeatYaw = -90,

        MaxHealth = 9999999999,
        IsArmored = false,
 
        EnginePos = Vector(0,0,0),

        StrengthenSuspension = true, -- жесткая подвеска.

		FrontHeight = 4, -- высота передней подвески
		FrontWheelMass = 200,
		FrontConstant = 25000,
		FrontDamping = 2000,
		FrontRelativeDamping = 2500,

		RearHeight = 4, -- высота задней подвески
		RearWheelMass = 200,
		RearConstant = 25000,
		RearDamping = 2000,
		RearRelativeDamping = 2500,

		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,

		TurnSpeed = 4,

		MaxGrip = 79,
		Efficiency = 0.9,
		GripOffset = -3,
		BrakePower = 0, -- сила торможения

		IdleRPM = 0, -- мин. кол-во оборотов
		LimitRPM = 0, -- макс. кол-во оборотов
		Revlimiter = false, -- Если true - Когда стрелка спидометра доходит до красного обозначения, она не проходит дальше, если false - это игнорируется
		PeakTorque = 0, -- крутящий момент
		PowerbandStart = 0,
		PowerbandEnd = 0,
		Turbocharged = false, -- турбо false = нет, true = да
		Supercharged = false, -- супер заряд
		Backfire = false, -- стреляющий выхлоп

		FuelFillPos = Vector(59.5,55,11.1), -- положение заправки
		FuelType = FUELTYPE_NONE, -- тип топлива
		FuelTankSize = 0, -- размер бака

		PowerBias = 1,

		EngineSoundPreset = 1,
--
		snd_pitch = 0.5,
		snd_idle = "common/null.wav",

		snd_low = "common/null.wav",
		snd_low_revdown = "common/null.wav", -- это всё звук
		snd_low_pitch = 1,

		snd_mid = "common/null.wav",
		snd_mid_gearup = "common/null.wav",
		snd_mid_geardown = "common/null.wav",
		snd_mid_pitch = 2,

		snd_horn = "common/null.wav",

		snd_blowoff = "common/null.wav",
		snd_backfire = "common/null.wav",
--
		DifferentialGear = 0.4,
		Gears = {-0.2,0,0.1} -- кол-во передач и "мощность"
	}
}
if (file.Exists( "models/tdmcars/trailers/dolly.mdl", "GAME" )) then -- путь модели (".mdl")
    list.Set( "simfphys_vehicles", "dollytdm", DKCAR ) -- изменить на люброе название(например sim_fphys_lalala)
end
--dolly (without lights!!!)
local DKCAR = {

	Name = "Single Axle dolly 2", -- название машины в меню
    Model = "models/tdmcars/trailers/dolly2.mdl", -- модель машины (в вкладке дополнения и проп авто)
    Category = "TDM Trailers", -- категория в которой будет машина
    SpawnOffset = Vector(0,0,61),
    SpawnAngleOffset = 0,
 
    Members = {
        Mass = 700, -- масса авто

        OnSpawn = function(ent)
	        if not ent.SimfIsTrailer == nil then 
	        	ent:SetActive( true ) -- makes avtive
				ent:SetSimfIsTrailer(true)  -- Is traieler?true - yes, false - no
	        	ent:SetTrailerCenterposition(Vector(0,118,36)) -- position of center ballsocket for trailer hook 33
				ent:SetCenterposition(Vector(0,8,40)) -- position of center ballsocket for tow hitch(trailer coupling)
				--timer.Simple(1.3, function() list.Add("trailer_to_trailer_list", ent) print("sas") end)
				table.insert(TDM_dollys, ent)
	        else
        		print("This trailer support trailers BASE, but you don't installed it")
        	end
        end,
		OnTick = function(ent) 
            if not ent.SimfIsTrailer == nil then 
	        	ent:Lock() -- locks trailer
	        	if not ent:GetIsBraking() then
	        		ent.ForceTransmission = 1
		        	if ent:GetNWBool("zadnyaya_gear", false) then
		        		ent.PressedKeys["joystick_throttle"] = 0 -- makes thottle to 0 when reverse, for remove handbrake
		        		ent.PressedKeys["joystick_brake"] = 1 -- makes brake to 1, for turn on reverse
		        	else
		        		ent.PressedKeys["joystick_throttle"] = 1 -- makes thottle to 1, for remove handbrake
		        		ent.PressedKeys["joystick_brake"] = 0 -- makes brake to 0, for turn off reverse
		        	end
	        	end 
			end
        end,

        BulletProofTires = false,
 
        CustomSteerAngle = 0,
 
        AirFriction = -3000,
 
        FrontWheelRadius = 21,--радиус переднего колеса
        RearWheelRadius = 21,--радиус заднего колеса
 
        CustomMassCenter = Vector(0,16,40),--Vector(0,-40,23.3)
 
		SeatOffset = Vector(226.4,-32.1,30), -- положение водительского сидения
        SeatPitch = 0,
        SeatYaw = -90,

        MaxHealth = 9999999999,
        IsArmored = false,
 
        EnginePos = Vector(0,0,0),

        StrengthenSuspension = true, -- жесткая подвеска.

		FrontHeight = 4, -- высота передней подвески
		FrontWheelMass = 200,
		FrontConstant = 25000,
		FrontDamping = 2000,
		FrontRelativeDamping = 2500,

		RearHeight = 4, -- высота задней подвески
		RearWheelMass = 200,
		RearConstant = 25000,
		RearDamping = 2000,
		RearRelativeDamping = 2500,

		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,

		TurnSpeed = 4,

		MaxGrip = 79,
		Efficiency = 0.9,
		GripOffset = -3,
		BrakePower = 0, -- сила торможения

		IdleRPM = 0, -- мин. кол-во оборотов
		LimitRPM = 0, -- макс. кол-во оборотов
		Revlimiter = false, -- Если true - Когда стрелка спидометра доходит до красного обозначения, она не проходит дальше, если false - это игнорируется
		PeakTorque = 0, -- крутящий момент
		PowerbandStart = 0,
		PowerbandEnd = 0,
		Turbocharged = false, -- турбо false = нет, true = да
		Supercharged = false, -- супер заряд
		Backfire = false, -- стреляющий выхлоп

		FuelFillPos = Vector(59.5,55,11.1), -- положение заправки
		FuelType = FUELTYPE_NONE, -- тип топлива
		FuelTankSize = 0, -- размер бака

		PowerBias = 1,

		EngineSoundPreset = 1,
--
		snd_pitch = 0.5,
		snd_idle = "common/null.wav",

		snd_low = "common/null.wav",
		snd_low_revdown = "common/null.wav", -- это всё звук
		snd_low_pitch = 1,

		snd_mid = "common/null.wav",
		snd_mid_gearup = "common/null.wav",
		snd_mid_geardown = "common/null.wav",
		snd_mid_pitch = 2,

		snd_horn = "common/null.wav",

		snd_blowoff = "common/null.wav",
		snd_backfire = "common/null.wav",
--
		DifferentialGear = 0.4,
		Gears = {-0.2,0,0.1} -- кол-во передач и "мощность"
	}
}
if (file.Exists( "models/tdmcars/trailers/dolly2.mdl", "GAME" )) then -- путь модели (".mdl")
    list.Set( "simfphys_vehicles", "dolly2tdm", DKCAR ) -- изменить на люброе название(например sim_fphys_lalala)
end
