hook.Add( "OnEntityCreated", "_simf_trailer_addons_hook_929503203509295983925928529385", function(ent)--maded by SupinePandora43 (Андрюха!!)
	if ( ent:GetClass() == "gmod_sent_vehicle_fphysics_base" ) then--мой небольшой скрипт на поддержку Trailers Base for simfphys
		timer.Simple( 2, function()
			if not IsValid(ent) then return end
			if ent:GetModel() == "models/blu/conscript_apc.mdl" then ent:SetCenterposition(Vector(0,-133.6,-27)) end--APC armed
			if ent:GetModel() == "models/crsk_autos/tesla/model_x_2015.mdl" then ent:SetCenterposition(Vector(0,-152,20)) ent:SetSkin( 4 ) end --Tesla Model X
			if ent:GetModel() == "models/dk_cars/tesla/modelsp90d/p90d.mdl" then ent:SetCenterposition(Vector(135,0,-15)) end --Tesla Model S [DK]
			if ent:GetModel() == "models/monowheel.mdl" then ent:SetCenterposition(Vector(0,-40,20)) ent:SetBackFire(true) end --Monowheel Wolfenstein II: TNC Cars
			if ent:GetModel() == "models/props_c17/furniturecouch002a.mdl" then ent:SetCenterposition(Vector(-18,0,0)) end --Base Driveable Couch
			if ent:GetModel() == "models/dk_cars/rc_toys/monster_truck/gtav_monstertruck.mdl" then ent:SetCenterposition(Vector(28,0,5)) ent:SetSkin( 1 ) ent:SetBodygroup(12,1) end -- DK GTA5 RC Liberator
			if ent:GetModel() == "models/tdmcars/del_dmc.mdl" then ent:SetCenterposition(Vector(0,-100,20)) end --Delorean DMC-12
		end) 
	end
end)