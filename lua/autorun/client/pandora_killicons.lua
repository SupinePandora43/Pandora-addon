killicon.AddAlias( "weapon_physgun", "weapon_physcannon" )--killing npc using physgun with icon!
--killicon.AddFont("weapon_chimera", "HL2MPTypeDeath", ".", Color(255,80,0,255)) --just exapmple
killicon.AddAlias( "weapon_chimera", "weapon_357" )--toybox
killicon.AddAlias( "weapon_gunstrumental", "weapon_smg1" )
killicon.AddAlias( "weapon_papshotgun", "weapon_shotgun" )
killicon.AddAlias( "weapon_rpg", "rpg_missile" )--adding killicon to rpg(weapon) from missile
killicon.AddAlias( "weapon_electrocannon", "rpg_missile" )--adding killicon to electrocannon(toybox)
killicon.AddAlias( "electromissile", "weapon_electrocannon" )--adding killicon to electromissle(electrocannon)
local files, _ = file.Find("materials/spandora/killicons/*","GAME")
for _ , file1 in pairs(files) do
	if string.EndsWith(file1, ".vtf") then continue end
	print("-------------------------------------------")
	file1=string.Replace(file1, ".vmt", "")
	print(file1 .. ", spandora/killicons/" .. file1)
	killicon.Add(file1, "spandora/killicons/" .. file1, Color(255,80,0,255))
	print("-------------------------------------------")
end
if file.Exists("autorun/cl_killicons.lua", "LUA") then
	killicon.Add("default", "killicons/sent_default_killicon", Color(255,80,0,255))
	killicon.Add("worldspawn", "killicons/worldspawn_killicon", Color(255,80,0,255))
	killicon.Add("pill_proj_magnade", "killicons/weapon_striderbuster_killicon", Color(255,80,0,255))--pill pack
	killicon.Add("weapon_burnmaster6000", "killicons/env_fire_killicon", Color(255,80,0,255))--toybox
	killicon.Add("combine_mine","killicons/combine_mine_killicon", Color(255,80,0,255))
end