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
if CLIENT then
	local function initLanguageAdd(key, phrase)
		local key = key or ""
		if(string.StartWith(phrase, "#")) then
			phrase=string.sub(phrase, 2)
			language.Add(key, phrase)
		end
		spandora.lang[key] = phrase
	end
	local function initLanguage(cvar, old, new) --I'm not use language.add, because in my gmod, ALL menu languages is empty: #LoadingScreen_LoadResources
		spandora.lang = {}
		for k, v in pairs(file.Exists("spandora_lang/en.lua", "LUA") and include("spandora_lang/en.lua") or {}) do
			initLanguageAdd(k, v)
		end
		for k, v in pairs(file.Exists("spandora_lang/"..new..".lua", "LUA") and include("spandora_lang/"..new..".lua") or {}) do
			initLanguageAdd(k, v)
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
if istable(DecentVehicleDestination) then
	--CreateClientConVar("pandora_decent_precache", "1", true, false, spandora.lang.decent_precache)
	CreateConVar("pandora_decent_precache", "0", {FCVAR_ARCHIVE, FCVAR_LUA_CLIENT}, spandora.lang.decent_precache)
	local function decent_precache()
		if GetConVar("pandora_decent_precache"):GetBool() then
			hook.Add("OnEntityCreated", "SupinePandora43_Hook_DecentPrecache", function(ent)
				if ent:GetClass() == "npc_decentvehicle" and not spandora.precached then
					for _, modelPath in pairs(DecentVehicleDestination.DefaultDriverModel) do
						util.PrecacheModel(modelPath)
					end
					spandora.precached = true
				end
			end)
		else
			hook.Remove("OnEntityCreated", "SupinePandora43_Hook_DecentPrecache")
		end
	end
	decent_precache()
	cvars.AddChangeCallback("pandora_decent_precache", decent_precache)
end