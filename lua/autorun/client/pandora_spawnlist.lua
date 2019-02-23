hook.Add("PopulatePropMenu", "SupinePandora43_Hook_SpawnList", function()
	local contents = {}
	table.insert(
		contents,
		{
			type = "header",
			text = "Hello World!"
		}
	)
	table.insert(
		contents,
		{
			type = "model",
			model = "models/props_c17/oildrum001.mdl"
		}
	)
	if CustomizableWeaponry then
		table.insert(
			contents,
			{
				type = "weapon",
				spawnname = "cw_ak74",
				nicename = "Kalash", 
				material = "entities/weapon_crowbar.png"
			}
		)
		table.insert(
			contents,
			{
				type = "entity",
				spawnname = "cw_ammo_545x39",
				nicename = "Ammo",
				material = "entities/sent_ball.png"
			}
		)
	end
	table.insert(
		contents,
		{
			type = "entity",
			spawnname = "combine_mine",
			nicename = "Hopper Mine",
			material = "entities/combine_mine.png"
		}
	)
	-- Vehicles
	table.insert(
		contents,
		{
			type = "vehicle",
			spawnname = "Airboat",
			nicename = "Half-Life 2 Airboat",
			material = "entities/Airboat.png"
		}
	)
	table.insert(
		contents,
		{
			type = "vehicle",
			spawnname = "Chair_Office2",
			nicename = "Executive's Chair",
			material = "entities/Chair_Office2.png"
		}
	)
	-- NPCs
	table.insert(
		contents,
		{
			type = "npc",
			spawnname = "npc_citizen",
			nicename = "A random citizen",
			material = "entities/npc_citizen.png",
			weapon = {"weapon_smg1", "weapon_crowbar"}
		}
	)
	table.insert(
		contents,
		{
			type = "npc",
			spawnname = "npc_headcrab",
			nicename = "Headhumper",
			material = "entities/npc_headcrab.png"
		}
	)
	-- Weapons
	
	table.insert(
		contents,
		{
			type = "weapon",
			spawnname = "weapon_smg1",
			nicename = "SMG",
			material = "entities/weapon_smg1.png"
		}
	)
	spawnmenu.AddPropCategory("SupinePandora43_PropCategory_SpawnList", "IDK", contents, "icon16/page.png")
end)