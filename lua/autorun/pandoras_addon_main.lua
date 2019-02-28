AddCSLuaFile()
spandora = spandora or {}
spandora.scp = spandora.scp or {}
spandora.scp.classes = spandora.scp.classes or {}
spandora.BlackList = spandora.BlackList or {}
spandora.scp.Enemy = spandora.scp.Enemy or {}
spandora.scp.Category = "SupinePandora's SCP's"
spandora.scp.TouchRadius = 40
spandora.lang = {}
function spandora.scp:IsEnemy(self1, ent)
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
if SERVER and Metrostroi then
	local OldENT
	local function AddTatraWheels()
        OldENT = ENT
        local ent = scripted_ents.GetStored("gmod_train_bogey")
		if not ent then
			return
		end
        ENT = ent.t
		ENT.Types.tatra={
			"models/metrostroi/tatra_t3/tatra_bogey.mdl",
			Vector(0,0.0,-3),Angle(0,0,0),"models/metrostroi/tatra_t3/tatra_wheels.mdl", --Motovz/tatra wheels fix
			Vector(0,-61,-14),Vector(0,61,-14),
			nil,
			Vector(4.3,-63,-3.3),Vector(4.3,63,-3.3),
		}
        ENT = OldENT
    end
    hook.Add("OnGamemodeLoaded", "SupinePandora43_Hook_TatraFix", AddTatraWheels)
end
local function initLanguage(cvar, old, new)
	spandora.lang = {}
	if SERVER then
		for _, f in pairs(file.Find("spandora_lang/*.lua", "LUA")) do
			AddCSLuaFile("spandora_lang/"..f)
		end
	end
	if file.Exists("spandora_lang/en.lua", "LUA") then
		table.Merge(spandora.lang, include("spandora_lang/en.lua"))
	end
	if file.Exists("spandora_lang/"..new..".lua", "LUA") then
		table.Merge(spandora.lang, include("spandora_lang/"..new..".lua"))
	end
end
initLanguage("gmod_language", nil, GetConVar("gmod_language"):GetString())
cvars.AddChangeCallback("gmod_language", initLanguage, "SupinePandora43_Language")
if SERVER then
	local timeBLC = CurTime()
	hook.Add("Think", "SupinePandora43_Hook_BlackListClear", function()
		if(CurTime()<(timeBLC+100)) then return end
		timeBLC=CurTime()
		spandora.BlackList = {}
	end)
end
---DMG_PREVENT_PHYSICS_FORCE for 173
CreateConVar("spandora_debug", "0", {FCVAR_ARCHIVE}, spandora.lang.debugf)
concommand.Add("spandora_blacklist_clear", function(ply, cmd, args)
	if(ply:IsAdmin() or ply:IsSuperAdmin()) then
		spandora.BlackList = {}
	else
		ply:PrintMessage(HUD_PRINTCONSOLE, spandora.lang.not_admin) 
	end
end, nil, spandora.lang.blclear, {FCVAR_ARCHIVE, FCVAR_LUA_SERVER})

spandora.debug = GetConVar("spandora_debug"):GetBool()