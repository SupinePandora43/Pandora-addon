spandora = spandora or {}
spandora.scp = spandora.scp or {}
spandora.scp.classes = spandora.scp.classes or {}
spandora.BlackList = spandora.BlackList or {}
spandora.scp.Enemy = spandora.scp.Enemy or {}
spandora.scp.Category = "SupinePandora's SCP's"
spandora.scp.TouchRadius = 40
spandora.debug = false
spandora.lang = {}
function spandora.scp:IsEnemy(self1,ent)
	local self = self1
	if (ent==self or ent:GetClass()==self:GetClass() or table.HasValue(spandora.scp.classes, ent:GetClass())) then
		return false
	end
	if(ent:GetClass()=="npc_zombie" or ent:GetClass()=="npc_headcrab") then
		return false
	end
	if(table.HasValue(spandora.BlackList, ent)) then
		return false
	end
	if((GetConVarNumber("ai_ignoreplayers")==1) and ent:IsPlayer())then
		return false
	end
	if IsValid(ent) and (ent:IsPlayer() or ent:IsNPC()) and (ent:Health()>0) then -- and (not ent==self) and (not ent:GetClass()==self:GetClass())
		return true
	end
	return false
end
if true then
	local function initLanguage(cvar, old, new)
		spandora.lang = {}
		if file.Exists("spandora_lang/en.lua", "LUA") then
			if SERVER then
				AddCSLuaFile("spandora_lang/en.lua")
			end
			if CLIENT then
				for k, v in pairs(include("spandora_lang/en.lua")) do
					spandora.lang[k] = phrase
					print("KEY: " .. k .. ", PHRASE: " .. v)
				end
			end
		end
		if file.Exists("spandora_lang/"..new..".lua", "LUA") then
			if SERVER then
				AddCSLuaFile("spandora_lang/en.lua")
			end
			if CLIENT then
				for k, v in pairs(include("spandora_lang/"..new..".lua")) do
					spandora.lang[k] = phrase
					print("KEY: " .. k .. ", PHRASE: " .. v)
				end
			end
		end
	end
	initLanguage("gmod_language", nil, GetConVar("gmod_language"):GetString())
	cvars.AddChangeCallback("gmod_language", initLanguage, "SupinePandora43_Language")
end
if SERVER then
	local timeBLC = CurTime()
	hook.Add("Think", "SupinePandora43_Hook_BlackListClear", function()
		if(CurTime()<(timeBLC+100)) then return end
		timeBLC=CurTime()
		spandora.BlackList = {}
	end)
end
---DMG_PREVENT_PHYSICS_FORCE for 173
CreateConVar("pandora_debug", "0", {FCVAR_ARCHIVE}, spandora.lang.debug)
concommand.Add("pandora_blacklist_clear", function(ply, cmd, args)
	if(ply:IsAdmin() or ply:IsSuperAdmin()) then
		spandora.BlackList = {}
	else
		ply:PrintMessage(HUD_PRINTCONSOLE, spandora.lang.not_admin) 
	end
end, nil, spandora.lang.blclear, {FCVAR_ARCHIVE, FCVAR_LUA_SERVER})