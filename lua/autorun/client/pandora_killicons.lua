killicon.Add("weapon_vfirethrower", "HUD/killicons/vfirethrower_icon", Color(255,80,0,255))
killicon.AddAlias( "weapon_physgun", "weapon_physcannon" )--killing npc using physgun with icon!
--killicon.AddFont("weapon_chimera", "HL2MPTypeDeath", ".", Color(255,80,0,255)) --just exapmple
killicon.AddAlias( "weapon_chimera", "weapon_357" )--toybox
killicon.AddAlias( "weapon_gunstrumental", "weapon_smg1" )
killicon.AddAlias( "weapon_papshotgun", "weapon_shotgun" )
killicon.AddAlias( "weapon_pixelsword", "weapon_fists" )--adding KI to pixelsword(toybox) from fists(i know fists without KI but...)
killicon.AddAlias( "weapon_rpg", "rpg_missile" )--adding killicon to rpg(weapon) from missile
killicon.AddAlias( "weapon_electrocannon", "rpg_missile" )--adding killicon to electrocannon(toybox)
killicon.AddAlias( "electromissile", "weapon_electrocannon" )--adding killicon to electromissle(electrocannon)

if file.Exists("autorun/cl_killicons.lua", "LUA") then
	killicon.Add("default", "killicons/sent_default_killicon", Color(255,80,0,255))
	--killicon.AddAlias( "suicide", "default" )--fix for not changed icon 
	killicon.Add("suicide", "HUD/killicons/suicide_killicon", Color(255,80,0,255))
	killicon.Add("worldspawn", "killicons/worldspawn_killicon", Color(255,80,0,255))
	killicon.Add("pill_proj_magnade", "killicons/weapon_striderbuster_killicon", Color(255,80,0,255))--pill pack
	killicon.Add("weapon_burnmaster6000", "killicons/env_fire_killicon", Color(255,80,0,255))--toybox
	killicon.Add("combine_mine","killicons/combine_mine_killicon", Color(255,80,0,255))

	if file.Exists("autorun/client/killicons.lua","LUA")then timer.Simple(1,function()include("autorun/cl_killicons.lua")end) end
else 
	print("additionalKillIcons not installed, not requied but recommended")
end

hook.Add("OnEntityCreated", "sent_portal_rocket_killicon", function(ent)
	if IsValid(ent) and ent:GetClass()=="sent_portal_rocket" then
		killicon.Add("sent_portal_rocket", "HUD/killicons/sent_portal_rocket", Color(255,80,0,255))
	end
end)