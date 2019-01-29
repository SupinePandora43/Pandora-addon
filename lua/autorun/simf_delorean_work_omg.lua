AddCSLuaFile()

local light_table = {
	ModernLights = false, -- грубо говоря, ксенон или старые фары. True - ксенон, false - старые
	L_HeadLampPos = Vector(-22, 95.5, 30.5), -- рассположение обычных фар (левых - L)
	L_HeadLampAng = Angle(180, -90, 0), -- угол поворота фар
	R_HeadLampPos = Vector(22, 95.5, 30.5), -- рассположение обычных фар (правых - R)
	R_HeadLampAng = Angle(180, -90, 0), -- угол поворота фар
	L_RearLampPos = Vector(28, -111, 31.5), -- расположение задних фар
	L_RearLampAng = Angle(0, -90, 0), -- угол поворота фар
	R_RearLampPos = Vector(-28, -111, 31.5), -- расположение задних фар
	R_RearLampAng = Angle(0, -90, 0), -- угол поворота фар
	Headlight_sprites = {
		-- Обычные фары
		{pos = Vector(29, 95.5, 30.5), size = 35, material = "sprites/light_ignorez"},
		{pos = Vector(31, 95.5, 30.5), size = 45, material = "sprites/light_ignorez"},
		{pos = Vector(33, 95.5, 30.5), size = 35, material = "sprites/light_ignorez"},
		{pos = Vector(19.8, 95.5, 30.5), size = 35, material = "sprites/light_ignorez"},
		{pos = Vector(21.8, 95.5, 30.5), size = 45, material = "sprites/light_ignorez"},
		{pos = Vector(23.8, 95.5, 30.5), size = 35, material = "sprites/light_ignorez"},
		{pos = Vector(-29, 95.5, 30.5), size = 35, material = "sprites/light_ignorez"},
		{pos = Vector(-31, 95.5, 30.5), size = 45, material = "sprites/light_ignorez"},
		{pos = Vector(-33, 95.5, 30.5), size = 35, material = "sprites/light_ignorez"},
		{pos = Vector(-19.8, 95.5, 30.5), size = 35, material = "sprites/light_ignorez"},
		{pos = Vector(-21.8, 95.5, 30.5), size = 45, material = "sprites/light_ignorez"},
		{pos = Vector(-23.8, 95.5, 30.5), size = 35, material = "sprites/light_ignorez"},
		{pos = Vector(-18.05, 16.5, 39.45), size = 1.5, material = "sprites/light_ignorez", color = Color(35, 255, 0, 255)}
	},
	Headlamp_sprites = {
		-- дальние
		{pos = Vector(22, 95.5, 30.5), size = 50, material = "sprites/light_ignorez"},
		{pos = Vector(-22, 95.5, 30.5), size = 50, material = "sprites/light_ignorez"},
		{pos = Vector(-19.7, 16.5, 39.4), size = 1.5, material = "sprites/light_ignorez", color = Color(0, 180, 255, 255)}
	},
	FogLight_sprites = {
		-- противотуманки
		{pos = Vector(41.8, 78.5, 26.7), size = 15, material = "sprites/light_ignorez", color = Color(255, 120, 0, 150)},
		{pos = Vector(41.4, 80.5, 26.7), size = 15, material = "sprites/light_ignorez", color = Color(255, 120, 0, 150)},
		{pos = Vector(41, 82.5, 26.7), size = 15, material = "sprites/light_ignorez", color = Color(255, 120, 0, 150)},
		{pos = Vector(40.6, 84.5, 26.7), size = 15, material = "sprites/light_ignorez", color = Color(255, 120, 0, 150)},
		{pos = Vector(40.2, 86.5, 26.7), size = 15, material = "sprites/light_ignorez", color = Color(255, 120, 0, 150)},
		{pos = Vector(41, 82.5, 26.7), size = 100, material = "sprites/light_ignorez", color = Color(255, 120, 0, 30)},
		{pos = Vector(43.2, -83.7, 32.4), size = 15, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(43, -85.7, 32.4), size = 15, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(42.6, -87.7, 32.4), size = 15, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(42.2, -89.7, 32.4), size = 15, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(41.8, -91.7, 32.4), size = 15, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(42.6, -87.7, 32.4), size = 100, material = "sprites/light_ignorez", color = Color(255, 40, 0, 40)},
		{pos = Vector(-41.8, 78.5, 26.7), size = 15, material = "sprites/light_ignorez", color = Color(255, 120, 0, 150)},
		{pos = Vector(-41.4, 80.5, 26.7), size = 15, material = "sprites/light_ignorez", color = Color(255, 120, 0, 150)},
		{pos = Vector(-41, 82.5, 26.7), size = 15, material = "sprites/light_ignorez", color = Color(255, 120, 0, 150)},
		{pos = Vector(-40.6, 84.5, 26.7), size = 15, material = "sprites/light_ignorez", color = Color(255, 120, 0, 150)},
		{pos = Vector(-40.2, 86.5, 26.7), size = 15, material = "sprites/light_ignorez", color = Color(255, 120, 0, 150)},
		{pos = Vector(-41, 82.5, 26.7), size = 100, material = "sprites/light_ignorez", color = Color(255, 120, 0, 30)},
		{pos = Vector(-43.2, -83.7, 32.4), size = 15, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(-43, -85.7, 32.4), size = 15, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(-42.6, -87.7, 32.4), size = 15, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(-42.2, -89.7, 32.4), size = 15, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(-41.8, -91.7, 32.4), size = 15, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(-42.6, -87.7, 32.4), size = 100, material = "sprites/light_ignorez", color = Color(255, 40, 0, 40)}
	},
	Rearlight_sprites = {
		-- задние фары
		{pos = Vector(23.3, -101, 38.5), size = 20, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(23.3, -100.5, 40.5), size = 20, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(23.3, -100, 43), size = 20, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(23.3, -100.5, 40.5), size = 75, material = "sprites/light_ignorez", color = Color(255, 40, 0, 40)},
		{pos = Vector(-23.3, -101, 38.5), size = 20, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(-23.3, -100.5, 40.5), size = 20, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(-23.3, -100, 43), size = 20, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(-23.3, -100.5, 40.5), size = 75, material = "sprites/light_ignorez", color = Color(255, 40, 0, 40)}
	},
	Brakelight_sprites = {
		-- тормозные огни
		{pos = Vector(19, -101, 38.5), size = 20, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(19, -100.5, 40.5), size = 20, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(19, -100, 43), size = 20, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(19, -100.5, 40.5), size = 75, material = "sprites/light_ignorez", color = Color(255, 40, 0, 40)},
		{pos = Vector(27.8, -101, 38.5), size = 20, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(27.8, -100.5, 40.5), size = 20, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(27.8, -100, 43), size = 20, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(27.8, -100.5, 40.5), size = 75, material = "sprites/light_ignorez", color = Color(255, 40, 0, 40)},
		{pos = Vector(-19, -101, 38.5), size = 20, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(-19, -100.5, 40.5), size = 20, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(-19, -100, 43), size = 20, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(-19, -100.5, 40.5), size = 75, material = "sprites/light_ignorez", color = Color(255, 40, 0, 40)},
		{pos = Vector(-27.8, -101, 38.5), size = 20, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(-27.8, -100.5, 40.5), size = 20, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(-27.8, -100, 43), size = 20, material = "sprites/light_ignorez", color = Color(255, 60, 0)},
		{pos = Vector(-27.8, -100.5, 40.5), size = 75, material = "sprites/light_ignorez", color = Color(255, 40, 0, 40)}
	},
	Reverselight_sprites = {
		-- фары заднего хода
		{pos = Vector(15.2, -101, 38.2), size = 20, material = "sprites/light_ignorez", color = Color(255, 255, 200)},
		{pos = Vector(15.2, -100.5, 40.9), size = 20, material = "sprites/light_ignorez", color = Color(255, 255, 200)},
		{pos = Vector(15.2, -100, 43.5), size = 20, material = "sprites/light_ignorez", color = Color(255, 255, 200)},
		{pos = Vector(15.2, -100.5, 40.9), size = 75, material = "sprites/light_ignorez", color = Color(255, 255, 200, 30)},
		{pos = Vector(-15.2, -101, 38.2), size = 20, material = "sprites/light_ignorez", color = Color(255, 255, 200)},
		{pos = Vector(-15.2, -100.5, 40.9), size = 20, material = "sprites/light_ignorez", color = Color(255, 255, 200)},
		{pos = Vector(-15.2, -100, 43.5), size = 20, material = "sprites/light_ignorez", color = Color(255, 255, 200)},
		{pos = Vector(-15.2, -100.5, 40.9), size = 75, material = "sprites/light_ignorez", color = Color(255, 255, 200, 30)}
	},
	Turnsignal_sprites = {
		-- поворотники
		Left = {
			-- левый
			{pos = Vector(-27, 98, 23.7), size = 25, material = "sprites/light_ignorez", color = Color(255, 120, 0)},
			{pos = Vector(-24, 98.15, 23.7), size = 25, material = "sprites/light_ignorez", color = Color(255, 120, 0)},
			{pos = Vector(-21, 98.3, 23.7), size = 25, material = "sprites/light_ignorez", color = Color(255, 120, 0)},
			{pos = Vector(-24, 100, 23.7), size = 100, material = "sprites/light_ignorez", color = Color(255, 120, 0, 40)},
			{pos = Vector(-41.8, 78.5, 26.7), size = 15, material = "sprites/light_ignorez", color = Color(255, 120, 0, 150)},
			{pos = Vector(-41.4, 80.5, 26.7), size = 15, material = "sprites/light_ignorez", color = Color(255, 120, 0, 150)},
			{pos = Vector(-41, 82.5, 26.7), size = 15, material = "sprites/light_ignorez", color = Color(255, 120, 0, 150)},
			{pos = Vector(-40.6, 84.5, 26.7), size = 15, material = "sprites/light_ignorez", color = Color(255, 120, 0, 150)},
			{pos = Vector(-40.2, 86.5, 26.7), size = 15, material = "sprites/light_ignorez", color = Color(255, 120, 0, 150)},
			{pos = Vector(-41, 82.5, 26.7), size = 100, material = "sprites/light_ignorez", color = Color(255, 120, 0, 30)},
			{pos = Vector(-31.5, -100, 38.5), size = 20, material = "sprites/light_ignorez", color = Color(255, 120, 0, 255)},
			{pos = Vector(-31.5, -100, 40.5), size = 20, material = "sprites/light_ignorez", color = Color(255, 120, 0, 255)},
			{pos = Vector(-31.5, -100, 43), size = 20, material = "sprites/light_ignorez", color = Color(255, 120, 0, 255)},
			{pos = Vector(-34.3, -100, 38.5), size = 20, material = "sprites/light_ignorez", color = Color(255, 120, 0, 255)},
			{pos = Vector(-34.3, -100, 40.5), size = 15, material = "sprites/light_ignorez", color = Color(255, 120, 0, 255)},
			{pos = Vector(-32.4, -100, 40.5), size = 100, material = "sprites/light_ignorez", color = Color(255, 120, 0, 40)},
			{pos = Vector(-22.42, 16.5, 39.4), size = 1.5, material = "sprites/light_ignorez", color = Color(0, 255, 30, 255)}
		},
		Right = {
			-- правый
			{pos = Vector(27, 98, 23.7), size = 25, material = "sprites/light_ignorez", color = Color(255, 120, 0)},
			{pos = Vector(24, 98.15, 23.7), size = 25, material = "sprites/light_ignorez", color = Color(255, 120, 0)},
			{pos = Vector(21, 98.3, 23.7), size = 25, material = "sprites/light_ignorez", color = Color(255, 120, 0)},
			{pos = Vector(24, 100, 23.7), size = 100, material = "sprites/light_ignorez", color = Color(255, 120, 0, 40)},
			{pos = Vector(41.8, 78.5, 26.7), size = 15, material = "sprites/light_ignorez", color = Color(255, 120, 0, 150)},
			{pos = Vector(41.4, 80.5, 26.7), size = 15, material = "sprites/light_ignorez", color = Color(255, 120, 0, 150)},
			{pos = Vector(41, 82.5, 26.7), size = 15, material = "sprites/light_ignorez", color = Color(255, 120, 0, 150)},
			{pos = Vector(40.6, 84.5, 26.7), size = 15, material = "sprites/light_ignorez", color = Color(255, 120, 0, 150)},
			{pos = Vector(40.2, 86.5, 26.7), size = 15, material = "sprites/light_ignorez", color = Color(255, 120, 0, 150)},
			{pos = Vector(41, 82.5, 26.7), size = 100, material = "sprites/light_ignorez", color = Color(255, 120, 0, 30)},
			{pos = Vector(31.5, -100, 38.5), size = 20, material = "sprites/light_ignorez", color = Color(255, 120, 0, 255)},
			{pos = Vector(31.5, -100, 40.5), size = 20, material = "sprites/light_ignorez", color = Color(255, 120, 0, 255)},
			{pos = Vector(31.5, -100, 43), size = 20, material = "sprites/light_ignorez", color = Color(255, 120, 0, 255)},
			{pos = Vector(34.3, -100, 38.5), size = 20, material = "sprites/light_ignorez", color = Color(255, 120, 0, 255)},
			{pos = Vector(34.3, -100, 40.5), size = 15, material = "sprites/light_ignorez", color = Color(255, 120, 0, 255)},
			{pos = Vector(32.4, -100, 40.5), size = 100, material = "sprites/light_ignorez", color = Color(255, 120, 0, 40)},
			{pos = Vector(-15.2, 16.5, 39.4), size = 1.5, material = "sprites/light_ignorez", color = Color(0, 255, 30, 255)}
		}
	},
	SubMaterials = {
		off = {
			Base = {
				[28] = "sim_fphys_dmc12/int_off"
			}
		},
		on_lowbeam = {
			Base = {
				[28] = "sim_fphys_dmc12/int"
			}
		},
		on_highbeam = {
			Base = {
				[28] = "sim_fphys_tesla_model_x/d_paddle_on"
			}
		}
	}
}
list.Set("simfphys_lights", "dmc12workomg", light_table)
local function FLY_delorean(ent)--IN_ATTACK IN_ATTACK2 IN_ALT1
	if (ent.deloreanI) then
		return
	end
	ent.deloreanI = true
	ent.flying=not ent.flying
	print("----------------------")
	for i = 1, 5 do
		print("FLY!!!!!!!!!!!!!!!!!!!!!!!")
	end
	print("----------------------")


	


	timer.Simple(
		2,
		function()
			ent.deloreanI = false
		end
	)
end
local V = {
	Name = "Delorean DMC-12 (WORK)",
	Model = "models/tdmcars/del_dmc.mdl",
	Category = "Back To The Future",
	Members = {
		Mass = 1300, -- масса авто
		OnSpawn = function(ent)
			ent:SetSubMaterial(28, "sim_fphys_dmc12/int_off")
			ent.deloreanI = false
			ent.flying = false
			hook.Add(
				"Tick",
				"simf_delorean_work_omg_buttons",
				function()
					if not IsValid(ent) then
						hook.Remove("Tick", "simf_delorean_work_omg_buttons")
						return
					end
					if not IsValid(ent:GetDriver()) then
						return
					end

					if (ent:GetDriver():KeyPressed(IN_ATTACK)) then
						FLY_delorean(ent)
					end
				end
			)
		end,
		OnTick = function(ent)
			if not IsValid(ent) then
				return
			end
			if not IsValid(ent:GetDriver()) then
				return
			end
			if (ent:GetDriver():KeyPressed(IN_ATTACK)) then
				FLY_delorean(ent)
			end
		end,
		LightsTable = "dmc12workomg", -- название light_table
		AirFriction = -3000,
		FrontWheelRadius = 15,
		--радиус переднего колеса
		RearWheelRadius = 15,
		--радиус заднего колеса
		CustomMassCenter = Vector(0, 0, -1),
		SeatOffset = Vector(-2, 0, -6), -- положение водительского сидения
		SeatPitch = 0,
		SpeedoMax = 130, -- какая максималка на спидометре(может работать криво)
		ModelInfo = {
			Skin = 1,
			Color = Color(150, 150, 150, 255)
		},
		PassengerSeats = {
			-- пассажирские места
			{
				pos = Vector(20, -14, 12),
				ang = Angle(0, 0, 14) -- Vector(ширина, длина, высота),
			}
		},
		ExhaustPositions = {
			-- позиция выхлопа
			{
				pos = Vector(25.2, -107, 22),
				ang = Angle(90, -90, 0)
			},
			{
				pos = Vector(-25.2, -107, 22),
				ang = Angle(90, -90, 0)
			}
		},
		StrengthenSuspension = false, -- жесткая подвеска.
		FrontHeight = 8, -- высота передней подвески
		FrontConstant = 43000,
		FrontDamping = 3000,
		FrontRelativeDamping = 3000,
		RearHeight = 7, -- высота задней подвески
		RearConstant = 43000,
		RearDamping = 3000,
		RearRelativeDamping = 3000,
		FastSteeringAngle = 20,
		SteeringFadeFastSpeed = 1000,
		TurnSpeed = 6,
		MaxGrip = 45,
		Efficiency = 1,
		GripOffset = -3,
		BrakePower = 55, -- сила торможения
		IdleRPM = 800, -- мин. кол-во оборотов
		LimitRPM = 8000, -- макс. кол-во оборотов
		Revlimiter = true, -- Если true - Когда стрелка спидометра доходит до красного обозначения, она не проходит дальше, если false - это игнорируется
		PeakTorque = 100, -- крутящий момент
		PowerbandStart = 850, -- какие обороты на нейтральной передаче
		PowerbandEnd = 6500, -- ограничение по оборотам
		Turbocharged = false, -- турбо false = нет, true = да
		Supercharged = false, -- супер заряд
		Backfire = false, -- стреляющий выхлоп
		FuelFillPos = Vector(45, -85, 40), -- положение заправки
		FuelType = FUELTYPE_PETROL, -- тип топлива
		FuelTankSize = 51, -- размер бака
		PowerBias = 1, -- привод. 1 - задний, 0 - полный, -1 - передний
		EngineSoundPreset = -1,
		snd_pitch = 1,
		snd_idle = "vehicles/sim_fphys_dmc12/idle.wav",
		snd_low = "vehicles/sim_fphys_dmc12/low.wav",
		snd_low_revdown = "vehicles/sim_fphys_dmc12/low.wav", -- это всё звук
		snd_low_pitch = 0.65,
		snd_mid = "vehicles/sim_fphys_dmc12/mid.wav",
		snd_mid_gearup = "vehicles/sim_fphys_dmc12/second.wav",
		snd_mid_geardown = "vehicles/sim_fphys_dmc12/second.wav",
		snd_mid_pitch = 0.65,
		snd_horn = "simulated_vehicles/horn_7.wav",
		snd_blowoff = "vehicles/tdmcars/s5/s5_throttle_off.wav",
		DifferentialGear = 0.3,
		Gears = {-0.2, 0, 0.2, 0.3, 0.4, 0.5, 0.6} -- кол-во передач и "мощность"
	}
}
if (file.Exists("models/tdmcars/del_dmc.mdl", "GAME")) then
	list.Set("simfphys_vehicles", "sim_fphys_dmc12_work_omg", V)
end
