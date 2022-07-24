local Paths, threads, kick_param = {}, {}, {}
MoistScript_thread = 0
math.randomseed(utils.time_ms())
Paths.Root = utils.get_appdata_path("PopstarDevs", "2Take1Menu")
utils.make_dir(Paths.Root .. "\\Blacklist")
utils.make_dir(Paths.Root .. "\\lualogs")
utils.make_dir(Paths.Root .. "\\scripts\\MoistsLUA_cfg")
Paths.scidFile = Paths.Root .. "\\Blacklist\\scid.ini"
Paths.Cfg = Paths.Root .. "\\scripts\\MoistsLUA_cfg"
Paths.Settings = Paths.Cfg .. "\\MoistsScript_settings.ini"
Paths.Logs = Paths.Root .. "\\lualogs"
Paths.debugfile = Paths.Logs .. "\\Moists_debug.log"
Paths.Player_DB = Paths.Logs .. "\\PlayerDB.txt"
Paths.kickdata = Paths.Root .. "\\scripts\\MoistsLUA_cfg\\Moist_Kicks.ini"
Paths.kickdata2 = Paths.Root .. "\\scripts\\MoistsLUA_cfg\\Moist_Kicks2.ini"
Paths.kickdata3 = Paths.Root .. "\\scripts\\MoistsLUA_cfg\\Moist_Kicks3.ini"
Paths.kickparam = Paths.Root .. "\\scripts\\MoistsLUA_cfg\\Moist_KickParam.ini"
Paths.interiorpos = Paths.Cfg .. "\\interiors.lua"
Paths.Spamtxt_Data = Paths.Cfg .. "\\Moists_Spamset.ini"

local Settings = {}
Settings["MoistScript"] = "2.0.3.8"
Settings["OSD.modvehspeed_osd"] = false
Settings["OSD.Player_bar"] = false
Settings["aimDetonate_control"] = false
Settings["osd_date_time"] = false
Settings["force_wPara"] = false
Settings["force_wBPH"] = false
Settings["lag_out"] = true
Settings["global_func.mk1boostrefill"] = false
Settings["global_func.mk2boostrefill"] = true
Settings["global_func.veh_rapid_fire"] = false
Settings["global_func.rapidfire_hotkey1"] = true
Settings["showSpawns"] = false
Settings["NotifyColorDefault"] = 123
Settings["NotifyVarDefault"] = 6
Settings["Weapon_Recticle"] = false
Settings["no_peds"] = false
Settings["no_traffic"] = false
Settings["net_log"] = false
Settings["chat_log"] = true
Settings["Chat_Command"] = false
Settings["chat_debug"] = false
Settings["script_check_logger"] = false
Settings["NetEventHook"] = false
Settings["Blacklist_ON"] = false
Settings["Blacklist_Mark"] = false
Settings["Blacklist_kick"] = false
Settings["global_func.thermal_stat_switch_hotkey"] = true
Settings["osd_My_speed1"] = false
Settings["osd_My_speed2"] = true
Settings["RPG_HOTFIRE"] = false
Settings["counter_Hotkey"] = false
Settings["spam_wait"] = 0
Settings["GodCheck"] = true
Settings["GodCheckNotif"] = true
Settings["force_pPara"] = false
Settings["force_pBPH"] = false
Settings["Notify_Me"] = true
Settings["playerscriptinfo"] = true
Settings["OSDDebug2"] = false
Settings["playerlist_loop"] = 50
Settings["loop_feat_delay"] = 100
Settings["hotkey_loop_delay"] = 10
Settings["ScriptEvent_delay"] = 100
Settings["RagDollHotKey"] = false
Settings["NotifyLimitON"] = false
Settings["NotifyLimit"] = 30


function SaveSettings()
    local file = io.open(Paths.Settings, "w")
    for k,v in pairs(Settings) do
        file:write(tostring(k) .. "=" .. tostring(v) .. "\n")
    end

    file:close()
end

function LoadSettings()
    if not utils.file_exists(Paths.Settings) then
       print("No saved settings")
        return
    end
    for line in io.lines(Paths.Settings) do
        local separator = line:find("=", 1, true)
        if separator then
            local key = line:sub(1, separator - 1)
            local value = line:sub(separator + 1)
            Settings[key] = value
        end
    end
end


function Load_Settings()
    if not utils.file_exists(Paths.Settings) then
        --No saved settings
        return
    end
    for line in io.lines(Paths.Settings) do
        local separator = line:find("=", 1, true)
        if separator then
            local key = line:sub(1, separator - 1)
            local value = line:sub(separator + 1)
            if value == string.format("true") then
            value = true
            elseif value == string.format("false") then
            value = false
            else value = value
            end
            Settings[key] = value
        end
    end
    -- Edit feature values based on new Settings values
end


function VersionCheck()
    if Settings["MoistScript"] ~= "2.0.3.8" then
    print("version Mismatch")
        local file = io.open(Paths.Settings, "w")
        file:write(tostring(""))
        file:close()
Settings["MoistScript"] = "2.0.3.8"
Settings["lag_out"] = true
Settings["global_func.mk1boostrefill"] = false
Settings["global_func.mk2boostrefill"] = false
Settings["global_func.veh_rapid_fire"] = false
Settings["NotifyColorDefault"] = 128
Settings["NotifyVarDefault"] = 1
Settings["chat_log"] = true
Settings["Chat_Command"] = false
Settings["chat_debug"] = false
Settings["Blacklist_ON"] = true
Settings["GodCheck"] = true
Settings["GodCheckNotif"] = true
Settings["playerlist_loop"] = 10
Settings["loop_feat_delay"] = 15
Settings["ScriptEvent_delay"] = 20

SaveSettings()
    end
Load_Settings()

end
Load_Settings()
VersionCheck()

function Debug_Out(text)

    local txt = Cur_Date_Time()
    local file = io.open(Paths.debugfile, "a")
    io.output(file)
    io.write("\n" .. txt .. "|")
    io.write(text)
    io.close()
end

function Print(text)
    print(text)
    local txt = Cur_Date_Time()
    local file = io.open(Paths.Root .. "\\2Take1Menu.log", "a")
    io.output(file)
    io.write("\n" .. txt .. "\t")
    io.write(text)
    io.close()
end

local ScriptLocals = {}
Active_menu = nil
local function netlog_out(text)

    local d, dtime, dt, CurDateTime, file

    d = os.date()
    dtime = string.match(d, "%d%d:%d%d:%d%d")
    dt = os.date("%d/%m/%y%y")
    CurDateTime = (string.format(dt .. " | " .. dtime .. " | "))

    local file = io.open(Paths.Logs .. "\\netevent_logger.log", "a")
    io.output(file)
    io.write("\n" .. CurDateTime .. text)
    io.close()
end

function interiors_load()
    if not utils.file_exists(Paths.interiorpos) then
        return
    end
    f = assert(loadfile(Paths.interiorpos))
    return f()

end
interiors_load()

local data, data2, data3, kick_param_data = {}, {}, {}, {}

--[[
Credits & Thanks to Kektram for help with OTR Code and code Advice
Thanks to haekkzer for his help and advice over time i was a tester for the menu

Big thanks goes Proddy for all his coding help advice and work to get shit done which without him alot of this
script would  not exist!
--]]

-- output Features
function Cur_Date_Time()
    local d, dtime, dt
    d = os.date()
    dtime = string.match(d, "%d%d:%d%d:%d%d")
    dt = os.date("%d/%m/%y")
    return (string.format("[" .. dt .. "]" .. "[" .. dtime .. "]"))
end

function dataload()
    if not utils.file_exists(Paths.kickdata) then
        return
    end
    for line in io.lines(Paths.kickdata) do
        data[#data + 1] = line
    end
    -- moist_notify("Moists Kick Data File 1 Loaded\n",  "Kick Type 1 Now Available")
end
dataload()

function dataload2()
    if not utils.file_exists(Paths.kickdata2) then
        return
    end
    for line in io.lines(Paths.kickdata2) do
        data2[#data2 + 1] = line
    end
    -- moist_notify("Moists Kick Data File 2 Loaded\n", "Kick Type 2 Now Available")
end
dataload2()

function dataload3()
    if not utils.file_exists(Paths.kickdata3) then
        return
    end
    for line in io.lines(Paths.kickdata3) do
        data3[#data3 + 1] = line
    end
    -- moist_notify("Moists Kick Data File 2 Loaded\n", "Kick Type 2 Now Available")
end
dataload3()

function paramload()
    if not utils.file_exists(Paths.kickparam) then
        return
    end
    for line in io.lines(Paths.kickparam) do
        kick_param_data[#kick_param_data + 1] = line
    end
    -- moist_notify("Moists Kick Data File 2 Loaded\n", "Kick Type 2 Now Available")
end
paramload()

function dupe_param()
    for i = 1, #kick_param_data do
        for y = 1, #kick_param_data do
            kick_param[y] = kick_param_data[i]
        end
    end
end
dupe_param()

-- TODO: Arrays for function variables
local OSD, OptionsVar, PlyTracker, tracking, ply_veh, ply_ped = {}, {}, {}, {}, {}, {}
tracking.playerped_posi, tracking.playerped_speed1, tracking.playerped_speed2, tracking.playerped_speed3 = {}, {}, {}, {}
Modders_DB = {{
    flag = {},
    flags = {},
    ismod = {}
}}
SessionPlayers = {{
    Name = {},
    Tags = {},
    tags = {},
    Scid = {}
}}
Players = {{
    isHost = {},
    isScHost = {},
    isOTR = {},
    OTRBlipID = {},
    pulse = {},
    bounty = {},
    bountyvalue = {},
    isUnDead = {},
    isPassive = {},
    flag = {},
    flags = {},
    ismod = {},
    isgod = {},
    isvgod = {},
    isint = {},
    isvis = {},
    speedK = {},
    speedM = {}
}}

-- TODO: Function Data & Entity Arrays
AttachedCunt = {}
AttachedCunt2 = {}
escort, escortveh, spawned_cunts, groupIDs, allpeds, allveh, allobj, allpickups, alkonost, kosatka, scids, spawned_cunt1, spawned_cunt2, spawned_cunt3, spawned_cunt, BlipIDs, EntityHash, EntityHash2, Thread2Id, Thread1Id, Esp_pid, markID = {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}
scidN = 0
local size_marker, marker_type, offsetz_marker = 1.0, 0, 1.5

-- TODO: Function Localisation
local Online, me = network.is_session_started(), player.player_id()

-- TODO: Function Variables
local SessionHost, ScriptHost, pped, pos_bool, myplygrp, plygrp, RemoveBlacklistFeature, MainEntityHash, orbit_pid, Degree, mk_id, mod_flag_1, mod_flag_2, mod_flag_3, mod_flag_4, mod_flag_5, dist

EntityHash.pid, EntityHash2.pid = {}, {}
markID.z = {}
markID.s = {}
markID.BOB = {}
markID.ROT = {}
highlight_set = {}
BobUPnDown = true
ROTMRK = true

local loop_logsent, spam_wait, preset_color, notifytype, isInterior
loop_logsent = false
spam_wait = Settings["spam_wait"]
preset_color = Settings["NotifyColorDefault"]
notifytype = Settings["NotifyVarDefault"]

local AnonymousBounty, trigger_time, cleanup_done, world_dumped, kicklogsent, logsent, spawnoptions_loaded = true, nil, true, true, false, false, false

-- TODO: Function return values

function Get_Last_MP(stat)
    local text = stat
    local hash = gameplay.get_hash_key("MPPLY_LAST_MP_CHAR")
    local MP = stats.stat_get_int(hash, 1)
    return (string.format("MP" .. MP .. "_" .. text))
end

-- Get Offset to self POS
local SelfoffsetPos = v3()
local offsetPos = v3()

function Self_offsetPos(pos, heading, distance)
    heading = math.rad((heading - 180) * -1)
    return v3(pos.x + (math.sin(heading) * -distance), pos.y + (math.cos(heading) * -distance), pos.z)
end

function get_offset2me(dist)
    local pos = player.get_player_coords(me)
    print(string.format("%s, %s, %s", pos.x, pos.y, pos.z))
    SelfoffsetPos = Self_offsetPos(pos, player.get_player_heading(player.player_id()), dist)
    print(string.format("%s, %s, %s", SelfoffsetPos.x, SelfoffsetPos.y, SelfoffsetPos.z))
    return SelfoffsetPos
end

-- TODO: offset to player calculation

function OffsetCoords(pos, heading, distance)
    heading = math.rad((heading - 180) * -1)
    return v3(pos.x + (math.sin(heading) * -distance), pos.y + (math.cos(heading) * -distance), pos.z)
end

function get_offset(pid, dist)
    local pos = player.get_player_coords(pid)
    --  print(string.format("%s, %s, %s", pos.x, pos.y, pos.z))
    offsetPos = OffsetCoords(pos, player.get_player_heading(pid), dist)

    -- print(string.format("%s, %s, %s", offsetPos.x, offsetPos.y, offsetPos.z))
    return offsetPos
end

function Get_Distance(pid)
    local pped = PlyPed(pid)
    local playerCoord = player.get_player_coords(player.player_id())
    local coord = entity.get_entity_coords(pped)
    local xDis = playerCoord.x - coord.x;
    local yDis = playerCoord.y - coord.y;
    local distance = math.sqrt(xDis * xDis + yDis * yDis);
    return distance
end

function Get_Distance3D(pid)
    local pped = PlyPed(pid)
    local playerCoord = player.get_player_coords(player.player_id(0))
    local coord = entity.get_entity_coords(pped)
    local xDis = playerCoord.x - coord.x -- PED
    local yDis = playerCoord.y - coord.y -- PED
    local zDis = playerCoord.z - coord.z -- PED
    local distance = math.sqrt(xDis * xDis + yDis * yDis + zDis * zDis);
    return distance

end

-- TODO: interior Check

interior_thread = {
    pid = {}
}

function Get_Dist3D(pid, v3pos)
    local pped = player.get_player_ped(pid)
    local playerCoord = v3pos
    local coord = entity.get_entity_coords(pped)
    local xDis = playerCoord.x - coord.x
    local yDis = playerCoord.y - coord.y
    local zDis = playerCoord.z - coord.z
    local distance = math.sqrt(xDis * xDis + yDis * yDis + zDis * zDis)
    return distance

end

function interiorcheckpid(pid)
    interior_thread[pid] = {}
    player_id = pid
    pid = player_id
    interior_thread[pid] = menu.create_thread(interiorcheck_thread, {
        pid = player_id
    })
    local i = #feat + 1
    feat[i] = menu.add_feature("Delete interior Check Thread: " .. pid, "action", God_Threads_Created.id, delete_God_thread)
    feat[i].data = {
        thread = interior_thread[pid]
    }
end

interiorcheck_thread = function(context)

    while true do
        if player.is_player_valid(context.pid) ~= false then
            pped = player.get_player_ped(context.pid)
            if interior.get_interior_from_entity(pped) == 0 then
                local apartmen
                if player.is_player_god(context.pid) or player.is_player_vehicle_god(context.pid) then
                    for i = 1, #interiors do
                        apartmen = Get_Dist3D(context.pid, interiors[i][2])
                        if apartmen < 200 then
                            Players[context.pid].isint = true
                        end
                        if apartmen >= 200 then
                            Players[context.pid].isint = false
                        end
                        local zbool, gz = gameplay.get_ground_z(player.get_player_coords(context.pid))
                        pos = player.get_player_coords(context.pid)
                        if pos.z < gz then
                            Players[context.pid].isint = true
                        end
                        if pos.z >= gz then
                            Players[context.pid].isint = false
                        end
                        system.yield(10)
                    end

                end
            elseif player.is_player_god(context.pid) and interior.get_interior_from_entity(pped) ~= 0 then
                Players[context.pid].isint = false
            elseif interior.get_interior_from_entity(pped) ~= 0 then
                Players[context.pid].isint = true
            end

        end
        system.wait(20)

    end
    return HANDLER_CONTINUE
end

-- Player IP
function GetIP(pid)
    ip = player.get_player_ip(pid)
    return ip
end
-- Player Ped ID / Entity ID
function PlyPed(pid)
    local PlayerPed = player.get_player_ped(pid)
    return PlayerPed
end

function GetSCID(pid)

    return player.get_player_scid(pid)
end

function spawn_object_onp(hash, pid)
    local pos, rot, rot2 = v3(), v3(180.00, 0.0, 0.0), v3(180.00, 0.0, 90.00)
    local offset, arot = v3(0.0, 0.0, 1.0), v3(180.0, 0.0, 90.00)
    pos = player.get_player_coords(pid)
    pos.z = pos.z + 7.0
    local Spawn, Spawn2
    Spawn = object.create_object(hash, pos, true, true)
    Spawn2 = object.create_object(hash, pos, true, true)
    entity.set_entity_as_mission_entity(Spawn2, true, 1)
    entity.set_entity_collision(Spawn2, false, false, false)
    entity.set_entity_as_mission_entity(Spawn, true, 1)
    entity.set_entity_collision(Spawn, false, false, false)

    entity.set_entity_rotation(Spawn, rot)

    -- entity.set_entity_rotation(Spawn2, rot2)
    entity.attach_entity_to_entity(Spawn2, Spawn, 0, offset, arot, true, false, false, 0, true)

    return Spawn, Spawn2

end

function Player_Check(pid)
    local pped, health, heldwep, heldammotype, vped, playern, plygrp, plyteam
    curweap = tostring("none")
    expsnipe = ""
    plyteam = player.get_player_team(pid)
    plygrp = player.get_player_group(pid)
    playern = network.network_hash_from_player(pid)
    pped = PlyPed(pid)
    attached = entity.is_entity_attached(pped)
    health = player.get_player_health(pid)
    maxhp = player.get_player_max_health(pid)
    armo = player.get_player_armour(pid)
    local dist = Get_Distance3D(pid)
    if dist > 900 or player.is_player_in_any_vehicle(pid) or attached then

        return ("~h~~r~H.~o~P~w~ | ~y~A:~r~\t\t " .. health .. "~w~ / ~o~" .. maxhp .. "~h~~w~ | ~y~" .. armo .. "\nWeapon:"), ("\n\t\t~h~~w~Player is in a Vehicle " .. "~p~No Check Done" .. "\n~b~Team~w~ | ~y~Group:~b~ \t " .. plyteam .. "~w~ |~y~ " .. plygrp), ("~w~\nNetHash:\t\t " .. playern)
    else
        heldwep = ped.get_current_ped_weapon(pped) or "none"
        curweap = weapon.get_weapon_name(heldwep) or "none"
        heldammotype = weapon.get_ped_ammo_type_from_weapon(pped, heldwep)
        expsnipe = Get_AmmoType(heldammotype) or "Normal"
        return ("~h~~r~H.~o~P~w~ | ~y~A:~r~\t\t " .. health .. "~w~ / ~o~" .. maxhp .. "~h~~w~ | ~y~" .. armo .. "\n~b~Weapon: ~w~"), ("\n\t\t" .. curweap .. "\n~p~Ammo: ~w~~h~" .. expsnipe .. "\n~b~Team~w~ | ~y~Group:~b~ \t " .. plyteam .. "~w~ |~y~ " .. plygrp), ("~w~\n\nNetHash:\t\t " .. playern)
    end
end

local ammois = "Normal"
function Get_AmmoType(ammohash)
    local ammo
    for i = 1, #AmmoType do
        if AmmoType[i][2] == ammohash then
            ammo = AmmoType[i][1]
            return ammo
        end

    end
end

-- Features
function dec2ip(decip)
    local div, quote, ip;
    for i = 3, 0, -1 do
        div = 2 ^ (i * 8)
        quote, decip = math.floor(decip / div), math.fmod(decip, div)
        if nil == ip then
            ip = quote
        else
            ip = ip .. "." .. quote
        end
    end
    return ip
end

function notify_above_map(msg)
    ui.notify_above_map(tostring("~l~~y~" .. msg), "~r~~h~Ω MoistsScript 2.0.3.7\n~p~~h~Moist Edition", 175)
end

function moist_notify(msg1, msg2)

    local color = preset_color
    msg1 = msg1 or " ~h~~o~~ex_r*~"
    msg2 = msg2 or " ~h~~w~~ex_r*~"

    if notifytype == 1 then
        ui.notify_above_map("~h~~r~" .. msg1 .. "~y~" .. msg2, "~r~~h~Ω MoistsScript 2.0.3.7\n~p~~h~Moist Edition", color)
    end
    if notifytype == 2 then
        ui.notify_above_map("~h~" .. msg1 .. "~h~~l~" .. msg2, "~r~~h~Ω MoistsScript 2.0.3.7\n~p~~h~Moist Edition", color)
    end

    if notifytype == 3 then
        ui.notify_above_map("~h~~y~" .. msg1 .. "~w~" .. msg2, "~r~~h~Ω MoistsScript 2.0.3.7\n~p~~h~Moist Edition", color)
    end
    if notifytype == 4 then
        ui.notify_above_map("~h~~b~" .. msg1 .. "~y~" .. msg2, "~r~~h~Ω MoistsScript 2.0.3.7\n~p~~h~Moist Edition", color)
    end

    if notifytype == 5 then
        ui.notify_above_map("~h~~g~" .. msg1 .. "~b~" .. msg2, "~r~~h~Ω MoistsScript 2.0.3.7\n~b~~h~Moist Edition", color)
    end
    if notifytype == 6 then
        ui.notify_above_map(msg1 .. "~h~" .. msg2, "~y~~h~Ω MoistsScript 2.0.3.7\n~w~~h~Moist Edition", color)
    end

end

-- TODO: Preset Data Arrays

local presets, escort_ped, veh_list, ped_wep, missions, BountyPresets, ssb_wep, StrikeGive, eject, heiststat_setup, decorators, int_flags
local spam_presets, spamm, spammRU = {}, {}, {}
spamm.var, spammRU.var = {}, {}
eject = {0, 1, 16, 64, 256, 4160, 262144, 320, 512, 131072}
spam_preset = {{"Love Me", "Love Me"}, {"Eat Dick", "EAT D I C K  !"}, {"Chingchong boxes", "�� ��� � ���� �� � �� ���� ��� �� � �� �� �"}, {"Chingchong Sell Bot", "� ��� ��\nGTA5:� �� ��� ����� Discord:���#��� ����"}, {"Fuck You! MassSpam",
                                                                                                                                                                                                                                                                                                                                              "Fuck You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You!\nFuck You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You! Fuck  You!"},
               {"Suck Cum Drip Cunt MassSpam",
                "SUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \nSUCK MY C U M DRIPPING C U N T ! YOU F U C K ! \n"},
               {"FAGGOT", "F A G G O T"}, {"Cry", "CRY"}, {"Suck", "SUCK"}, {"You Suck MassSpam",
                                                                             "YOU SUCK \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n YOU SUCK  \n "},
               {"Insert Space", " "}, {"Big ! ScreenSpam", string.format("!			!			!			!			!			!			!			!			!			\n!			!			!			!			!			!			!			!			!			!			!			!			\n!			!			!			!			!			!			\n!			!			!			!			!			!			\n!			!			!			!			!			!			\n!			!			!			!			!			!			\n!			!			!			!			!			!			\n!			!			!			!			!			!			\n!			!			!			!			!			!			\n!			!			!			!			!			!			\n!			!			!			")},
               {"Weird Ascii line", "��������������������������������������������������������������������������͹"}}
russian_spam = {{"Russia sucks", "Россия отстой"}, {"iwill pleasure your mom", "Я собираюсь, порадовать твою маму! Потом твою сестру! Потм обоих одновременно на твоей кровати."}, {"Death to Russia", "Смерть в Россию"}, {"Kill all Russians", "Убить всех русских"}, {"Suck Russia", "Соси, Россия"}, {"Pussy", "киска"}, {"Cunt", "пизда"},
                {"Learn English russian Sucks", "Учите английский! Русский отстой! !"}, {"I'm going to kill all russians!", "Я собираюсь убить все русские! Пожалуйста Идентифицировать себя! Готовься к смерти"}}

presets = {{"beyond_limits", -173663.281250, 915722.000000, 362299.750000}, {"God Mode Death (Kill Barrier)", -1387.175, -618.242, 30.362}, {"Ocean God Mode Death\n(Outside Limits Deep Ocean)", -5784.258301, -8289.385742, -136.411270}, {"Chiliad", 491.176, 5529.808, 777.503}, {"Lesters House", 1275.544, -1721.774, 53.967}, {"arena", -264.297, -1877.562, 27.756}, {"ElysianIslandBridge", -260.923, -2414.139, 124.008}, {"LSIAFlightTower", -983.292, -2636.995, 89.524},
           {"TerminalCargoShip", 983.303, -2881.645, 21.619}, {"ElBurroHeights", 1583.022, -2243.034, 93.265}, {"CypressFlats", 552.672, -2218.876, 68.981}, {"LaMesa", 1116.815, -1539.787, 52.146}, {"SupplyStreet", 777.631, -695.813, 28.763}, {"Noose", 2438.874, -384.409, 92.993}, {"TatavianMountains", 2576.999, 445.654, 108.456}, {"PowerStation", 2737.046, 1526.873, 57.494}, {"WindFarm", 2099.765, 1766.219, 102.698}, {"Prison", 1693.473, 2652.971, 61.335},
           {"SandyShoresRadioTower", 1847.034, 3772.019, 33.151}, {"AlamoSea", 719.878, 4100.993, 39.154}, {"RebelRadioTower", 744.500, 2644.334, 44.400}, {"GreatChaparral", -291.035, 2835.124, 55.530}, {"ZancudoControlTower", -2361.625, 3244.962, 97.876}, {"NorthChumash(Hookies)", -2205.838, 4298.805, 48.270}, {"AltruistCampRadioTower", -1036.141, 4832.858, 251.595}, {"CassidyCreek", -509.942, 4425.454, 89.828}, {"MountChiliad", 462.795, 5602.036, 781.400},
           {"PaletoBayFactory", -125.284, 6204.561, 40.164}, {"GreatOceanHwyCafe", 1576.385, 6440.662, 24.654}, {"MountGordoRadioTower", 2784.536, 5994.213, 354.275}, {"MountGordoLighthouse", 3285.519, 5153.820, 18.527}, {"GrapeSeedWaterTower", 1747.518, 4814.711, 41.666}, {"TatavianMountainsDam", 1625.209, -76.936, 166.651}, {"VinewoodHillsTheater", 671.748, 512.226, 133.446}, {"VinewoodSignRadioTowerTop", 751.179, 1245.13, 353.832}, {"Hawik", 472.588, -96.376, 123.705},
           {"PacificSrandardBank", 195.464, 224.341, 143.946}, {"WestVinewoodCrane", -690.273, 219.728, 137.518}, {"ArcadiasRadioTower", -170.232, -586.307, 200.138}, {"HookahPalaceSign", -1.414, -1008.324, 89.189}, {"MarinaAirportRadioTower", -697.010, -1419.530, 5.001}, {"DelperoFerrisWheel", -1644.193, -1114.271, 13.029}, {"VespucciCanalsClockTower", -1238.729, -853.861, 77.758}, {"DelPeroNrMazebankwest", -1310.777, -428.985, 103.465},
           {"pacifficBluffs", -2254.199, 326.088, 192.606}, {"GWC&GolfingSociety", -1292.052, 286.209, 69.407}, {"Burton", -545.979, -196.251, 84.733}, {"LosSantosMedicalCenter", 431.907, -1348.709, 44.673}, {"BanhamCanyon", -3085.451, 774.426, 20.237}, {"TongvaHills", -1874.280, 2064.565, 150.852}, {"SanChianskiMountainRange", 2900.166, 4325.987, 102.101}, {"HumaineLabs", 3537.104, 3689.238, 45.228}, {"YouToolStoreSanChianski", 2761.944, 3466.951, 55.679},
           {"GalileoObservatory", -422.917, 1133.272, 325.855}, {"GrndSeroraDesertCementwks", 1236.649, 1869.214, 84.824}}
escort_ped = {{"juggalo_01", 0xDB134533}, {"topless_01", 0x9CF26183}, {"juggalo_02", 0x91CA3E2C}, {"lester crest", 0xB594F5C3}, {"cop", 0x9AB35F63}, {"mp_agent14", 0x6DBBFC8B}, {"ramp_marine", 0x616C97B9}, {"trafficwarden", 0xDE2937F3}, {"lestercrest_2", 0x6E42FD26}, {"lestercrest", 0x4DA6E849}, {"agent14", 0xFBF98469}, {"m_pros_01", 0x6C9DD7C9}, {"waremech_01", 0xF7A74139}, {"weapexp_01", 0x36EA5B09}, {"weapwork_01", 0x4186506E}, {"securoguard_01", 0xDA2C984E},
              {"armoured_01", 0xCDEF5408}, {"armoured_01", 0x95C76ECD}, {"armoured_02", 0x63858A4A}, {"marine_01", 0xF2DAA2ED}, {"marine_02", 0xF0259D83}, {"security_01", 0xD768B228}, {"snowcop_01", 0x1AE8BB58}, {"prisguard_01", 0x56C96FC6}, {"pilot_01", 0xE75B4B1C}, {"pilot_02", 0xF63DE8E1}, {"blackops_01", 0xB3F3EE34}, {"blackops_02", 0x7A05FA59}, {"blackops_03", 0x5076A73B}, {"hwaycop_01", 0x739B1EF5}, {"marine_01", 0x65793043}, {"marine_02", 0x58D696FE},
              {"marine_03", 0x72C0CAD2}, {"ranger_01", 0xEF7135AE}, {"robber_01", 0xC05E1399}, {"sheriff_01", 0xB144F9B9}, {"pilot_01", 0xAB300C07}, {"swat_01", 0x8D8F1B10}, {"fibmugger_01", 0x85B9C668}, {"juggernaut_01", 0x90EF5134}, {"rsranger_01", 0x3C438CD2}, {"mp_m_niko_01", 4007317449}}
missions = {"Force to Severe Weather", "Force to Half Track", "Force to Night Shark AAT", "Force to APC Mission", "Force to MOC Mission", "Force to Tampa Mission", "Force to Opressor Mission1", "Force to Opressor Mission2"}
ped_wep = {{"unarmed", 0xA2719263}, {"parachute", 0xfbab5776}, {"weapon_handcuffs", 0xD04C944D}, {"Garbage Bag", 0xE232C28C}, {"WEAPON_FIREWORK", 0x7F7497E5}, {"stone_hatchet", 0x3813FC08}, {"knife", 0x99B507EA}, {"bat", 0x958A4A8F}, {"weapon_machinepistol", 0xDB1AA450}, {"raypistol", 0xAF3696A1}, {"stungun", 0x3656C8C1}, {"weapon_gadgetpistol", 0x57A4368C}, {"raycarbine", 0x476BF15}, {"combatmg_mk2", 0xDBBD7280}, {"Special RPG", 1752584910}, {"Standard RPG", 2982836145},
           {"railgun", 0x6D544C99}, {"minigun", 0x42BF8A85}, {"Smoke GrenadeLauncher", 0x4DD2DC56}, {"WEAPON_REMOTESNIPER", 0x33058E22}, {"rayminigun", 0xB62D1F6}}
veh_list = {{"buzzard", 0x2F03547B, nil, nil}, {"savage", 0xFB133A17, nil, nil}, {"seasparrow", 0xD4AE63D9, 10, 1}, {"valkyrie2", 0x5BFA5C4B, nil, nil}, {"valkyrie", 0xA09E15FD, nil, nil}, {"boxville5", 0x28AD20E1, nil, nil}, {"apc", 0x2189D250, 10, 0}, {"oppressor2", 0x7B54A9D3, 10, 1}, {"oppressor", 0x34B82784, 10, 0}, {"ruiner2", 0x381E10BD, nil, nil}, {"scramjet", 0xD9F0503D, 10, 0}, {"stromberg", 0x34DBA661}, {"tampa3", 0xB7D9F7F1}, {"khanjali", 0xAA6F980A, nil, nil},
            {"insurgent3", 0x8D4B7A8A, nil, nil}, {"insurgent", 0x9114EADA, nil, nil}, {"limo2", 0xF92AEC4D, nil, nil}, {"mower", 0x6A4BD8F6, nil, nil}, {"police2", 0x9F05F101, nil, nil}, {"police3", 0x71FA16EA, nil, nil}, {"police4", 0x8A63C7B9, nil, nil}, {"police", 0x79FBB0C5, nil, nil}, {"policeb", 0xFDEFAEC3, nil, nil}, {"policeold1", 0xA46462F7, nil, nil}, {"policeold2", 0x95F4C618, nil, nil}, {"policet", 0x1B38E955, nil, nil}, {"polmav", 0x1517D4D9, nil, nil},
            {"sheriff2", 0x72935408, nil, nil}, {"sheriff", 0x9BAA707C, nil, nil}, {"phantom2", 0x9DAE1398, nil, nil}, {"ruiner3", 0x2E5AFD37, nil, nil}, {"scorcher", 0xF4E1AA15, nil, nil}, {"bmx", 0x43779C54, nil, nil}}
BountyPresets = {0, 1, 10, 50, 70, 100, 250, 500, 600, 750, 800, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000}
ssb_wep = {"WEAPON_SNIPERRIFLE", "WEAPON_HEAVYSNIPER", "WEAPON_REMOTESNIPER", "WEAPON_GRENADELAUNCHER", "VEHICLE_WEAPON_TRAILER_DUALAA", "VEHICLE_WEAPON_PLAYER_BULLET", "VEHICLE_WEAPON_PLAYER_LAZER", "WEAPON_AIRSTRIKE_ROCKET", "VEHICLE_WEAPON_SPACE_ROCKET", "VEHICLE_WEAPON_PLANE_ROCKET", "VEHICLE_WEAPON_AVENGER_CANNON", "WEAPON_AIR_DEFENCE_GUN"}
StrikeGive = {"WEAPON_AIRSTRIKE_ROCKET", "VEHICLE_WEAPON_AVENGER_CANNON", "VEHICLE_WEAPON_KHANJALI_CANNON_HEAVY", "WEAPON_GRENADELAUNCHER", "VEHICLE_WEAPON_PLAYER_LAZER", "VEHICLE_WEAPON_AKULA_BARRAGE", "VEHICLE_WEAPON_SPACE_ROCKET", "VEHICLE_WEAPON_PLANE_ROCKET", "WEAPON_AIR_DEFENCE_GUN", "WEAPON_GRENADELAUNCHER_SMOKE", "WEAPON_FIREWORK", "VEHICLE_WEAPON_RUINER_ROCKET", "VEHICLE_WEAPON_DELUXO_MISSILE", "WEAPON_HOMINGLAUNCHER", "WEAPON_STINGER", "WEAPON_STICKYBOMB",
              "WEAPON_PROXMINE"}
heiststat_setup = {{"H3_COMPLETEDPOSIX", -1}, {"H3OPT_APPROACH", 1}, {"H3_HARD_APPROACH", 3}, {"H3OPT_TARGET", 3}, {"H3OPT_POI", 1023}, {"H3OPT_ACCESSPOINTS", 2047}, {"H3OPT_BITSET1", -1}, {"H3OPT_CREWWEAP", 1}, {"H3OPT_CREWDRIVER", 1}, {"H3OPT_CREWHACKER", 5}, {"H3OPT_WEAPS", 1}, {"H3OPT_VEHS", 3}, {"H3OPT_DISRUPTSHIP", 3}, {"H3OPT_BODYARMORLVL", 3}, {"H3OPT_KEYLEVELS", 2}, {"H3OPT_MASKS", math.ceil(math.random(0, 12))}, {"H3OPT_BITSET0", -1}}
AmmoType = {{"FullMetalJacket", 1586900444}, {"FullMetalJacket", 4126262806}, {"FullMetalJacket", 234717365}, {"FullMetalJacket", 758230489}, {"FullMetalJacket", 3162174467}, {"Tracer", 3101486635}, {"Tracer", 1226421483}, {"Tracer", 1569785553}, {"Tracer", 1184011213}, {"HollowPoint", 670318226}, {"HollowPoint", 3458447638}, {"HollowPoint", 2089185906}, {"Explosive", 2916183225}, {"Explosive", 3985664341}, {"Incendiary", 2878251257}, {"Incendiary", 1461941360},
            {"Incendiary", 2465278413}, {"Incendiary", 3685537684}, {"Incendiary", 3962074599}, {"Incendiary", 796697766}, {"ArmourPiercing", 784861712}, {"ArmourPiercing", 2797387177}, {"ArmourPiercing", 423744068}, {"ArmourPiercing", 423744068}, {"ArmourPiercing", 1923327840}}

decorators = {{"RespawnVeh", 3}, {"GBMissionFire", 3}, {"MPBitset", 3}, {"RandomID", 3}, {"noPlateScan", 2}, {"CreatedByPegasus", 2}, {"IgnoredByQuickSave", 3}, {"Player_Vehicle", 3}, {"PV_Slot", 3}, {"Veh_Modded_By_Player", 3}, {"PYV_Yacht", 3}, {"Player_Truck", 3}, {"Player_Avenger", 3}, {"Player_Hacker_Truck", 3}, {"Previous_Owner", 3}, {"Not_Allow_As_Saved_Veh", 3}, {"cashondeadbody", 3}, {"BBCarrier", 3}, {"FMDeliverableID", 3}, {"GBCVehicle", 3}, {"GangBackup", 3},
              {"BlockFriendGrab", 3}, {"Bought_Drugs", 2}, {"AttributeDamage", 3}, {"CokeInPossession", 1}, {"ContrabandDeliveryType", 3}, {"ContrabandOwner", 3}, {"Creator_Trailer", 3}, {"CrowdControlSetUp", 3}, {"Darts_name", 3}, {"EnableVehLuxeActs", 3}, {"ExportVehicle", 3}, {"GetawayVehicleValid", 3}, {"Getaway_Winched", 3}, {"Heist_Veh_ID", 3}, {"HeliTaxi", 3}, {"HeroinInPossession", 1}, {"LUXE_VEH_INSTANCE_ID", 3}, {"MC_ChasePedID", 3}, {"MC_EntityID", 3},
              {"MC_Team0_VehDeliveredRules", 3}, {"MC_Team1_VehDeliveredRules", 3}, {"MC_Team2_VehDeliveredRules", 3}, {"MC_Team3_VehDeliveredRules", 3}, {"MapGauntlet", 3}, {"MatchId", 3}, {"MethInPossession", 1}, {"MissionType", 3}, {"PYV_Owner", 3}, {"PYV_Vehicle", 3}, {"PYV_WarpFrom", 3}, {"Player_Boss", 3}, {"Player_Goon", 3}, {"Previous_Boss", 3}, {"RampageCarExploded", 3}, {"Skill_Blocker", 2}, {"Sprayed_Vehicle_Decorator", 2}, {"Sprayed_Vehicle_Timer_Dec", 5},
              {"Carwash_Vehicle_Decorator", 3}, {"TargetPlayerForTeam", 3}, {"TeamId", 3}, {"TeamId", 1}, {"UsingForTimeTrial", 3}, {"Vehicle_Reward", 3}, {"Vehicle_Reward_Teams", 3}, {"WeedInPossession", 1}, {"XP_Blocker", 2}, {"bombdec1", 3}, {"bombdec", 3}, {"bombowner", 3}, {"doe_elk", 3}, {"hunt_chal_weapon", 3}, {"hunt_kill_time", 3}, {"hunt_nocall", 3}, {"hunt_score", 3}, {"hunt_undetected", 3}, {"hunt_weapon", 3}, {"prisonBreakBoss", 2}, {"BeforeCorona_0", 2}}
decoratorType = {"DECOR_TYPE_FLOAT", "DECOR_TYPE_BOOL", "DECOR_TYPE_INT", "DECOR_TYPE_UNK", "DECOR_TYPE_TIME"}

Decorators = {"AttributeDamage", "BBCarrier", "BlockFriendGrab", "bombdec", "bombdec1", "bombowner", "Carwash_Vehicle_Decorator", "cashondeadbody", "ContrabandDeliveryType", "ContrabandOwner", "CreatedByPegasus", "Creator_Trailer", "Darts_name", "doe_elk", "EnableVehLuxeActs", "ExportVehicle", "FMDeliverableID", "GBCVehicle", "GBMissionFire", "Getaway_Winched", "GetawayVehicleValid", "Heist_Veh_ID", "HeliTaxi", "hunt_chal_weapon", "hunt_kill_time", "hunt_nocall",
              "hunt_score", "hunt_undetected", "hunt_weapon", "IgnoredByQuickSave", "LUXE_VEH_INSTANCE_ID", "MapGauntlet", "MatchId", "MC_ChasePedID", "MC_EntityID", "MissionType", "MPBitset", "Not_Allow_As_Saved_Veh", "Player_Avenger", "Player_Boss", "Player_Goon", "Player_Hacker_Truck", "Player_Truck", "Player_Vehicle", "Previous_Boss", "Previous_Owner", "PV_Slot", "PYV_Owner", "PYV_Vehicle", "PYV_WarpFrom", "PYV_Yacht", "RampageCarExploded", "RandomID", "RespawnVeh",
              "Skill_Blocker", "Sprayed_Vehicle_Decorator", "Sprayed_Vehicle_Timer_Dec", "TeamId", "UsingForTimeTrial", "Veh_Modded_By_Player", "XP_Blocker", "Player_Vehicle", "PV_Slot", "Previous_Owner", "Sprayed_Vehicle_Decorator", "Sprayed_Vehicle_Timer_Dec", "Vehicle_Reward", "Vehicle_Reward_Teams", "Skill_Blocker", "TargetPlayerForTeam", "XP_Blocker", "CrowdControlSetUp", "Bought_Drugs", "HeroinInPossession", "CokeInPossession", "WeedInPossession", "MethInPossession",
              "bombdec", "bombdec1", "bombowner", "noPlateScan", "prisonBreakBoss", "cashondeadbody", "MissionType", "MatchId", "TeamId", "Not_Allow_As_Saved_Veh", "Veh_Modded_By_Player", "MPBitset", "MC_EntityID", "MC_ChasePedID", "MC_Team0_VehDeliveredRules", "MC_Team1_VehDeliveredRules", "MC_Team2_VehDeliveredRules", "MC_Team3_VehDeliveredRules", "AttributeDamage", "GangBackup", "CreatedByPegasus", "BeforeCorona_0"}

int_flags = {65536, 131072, 262144, 524288, 1048576, 2097152, 4194304}
boneid = {57597, 24818, 24817, 24816, 23553, 11816, 38180, 40269, 51826, 57005, 28252, 52301, 10706, 36864, 17916, 53251, 11816, 24532, 39317, 45509, 58271, 18905, 61163, 14201, 64729, 63931, 65068, 31086, 12844}
ped_hashes = {{"a_c_panther", 3877461608}, {"a_f_y_beach_02", 3105934379}, {"a_f_y_bevhills_05", 2464671085}, {"a_f_y_clubcust_01", 1744231373}, {"a_f_y_clubcust_02", 357447289}, {"a_f_y_clubcust_03", 10751269}, {"a_f_y_clubcust_04", 786557344}, {"a_f_y_gencaspat_01", 2434503858}, {"a_f_y_smartcaspat_01", 279228114}, {"a_m_m_mlcrisis_01", 1561088805}, {"a_m_o_beach_02", 3243462130}, {"a_m_y_beach_04", 3105523388}, {"a_m_y_clubcust_01", 2813792322},
              {"a_m_y_clubcust_02", 3324988722}, {"a_m_y_clubcust_03", 3572886207}, {"a_m_y_clubcust_04", 3793814805}, {"a_m_y_gencaspat_01", 2600762591}, {"a_m_y_smartcaspat_01", 553826858}, {"cs_jimmydisanto2", 1836024091}, {"cs_lestercrest_2", 191074589}, {"cs_lestercrest_3", 496317824}, {"cs_patricia_02", 788179139}, {"cs_taocheng2", 650034742}, {"cs_taostranslator2", 3017289007}, {"csb_agatha", 756308504}, {"csb_alan", 1925887591}, {"csb_ary", 3059505486},
              {"csb_avery", 1427949869}, {"csb_avon", 406009421}, {"csb_bogdan", 1594283837}, {"csb_brucie2", 3361779221}, {"csb_bryony", 2006035933}, {"csb_celeb_01", 592225333}, {"csb_dix", 3957337349}, {"csb_djblamadon", 1835399538}, {"csb_englishdave", 3533210174}, {"csb_englishdave_02", 3713623407}, {"csb_georginacheng", 345107131}, {"csb_gustavo", 2331262242}, {"csb_helmsmanpavel", 2675868152}, {"csb_huang", 1064198787}, {"csb_isldj_00", 2053038501},
              {"csb_isldj_01", 887084708}, {"csb_isldj_02", 1712601360}, {"csb_isldj_03", 2440761309}, {"csb_isldj_04", 2998686303}, {"csb_jio", 2727058989}, {"csb_juanstrickler", 3612049721}, {"csb_miguelmadrazo", 3685838978}, {"csb_mjo", 2700978005}, {"csb_mrs_r", 2642001958}, {"csb_sol", 1324952405}, {"csb_sss", 3772505184}, {"csb_talcc", 3392144504}, {"csb_talmm", 3785408493}, {"csb_thornton", 4086880849}, {"csb_tomcasino", 3488666811}, {"csb_tonyprince", 1566545691},
              {"csb_vincent", 520636071}, {"csb_vincent_2", 2782957088}, {"csb_wendy", 1437043119}, {"g_f_importexport_01", 2225189146}, {"g_m_importexport_01", 3164785898}, {"g_m_m_cartelguards_01", 2127932792}, {"g_m_m_cartelguards_02", 1821116645}, {"g_m_m_casrn_01", 1020431539}, {"ig_agatha", 1855569864}, {"ig_ary", 3473698871}, {"ig_avery", 3088269167}, {"ig_avon", 4242698434}, {"ig_brucie2", 3893268832}, {"ig_celeb_01", 3676106820}, {"ig_dix", 4207997581},
              {"ig_djblamadon", 4219210853}, {"ig_djblamrupert", 914073350}, {"ig_djblamryanh", 400495475}, {"ig_djblamryans", 3057799231}, {"ig_djdixmanager", 4221366718}, {"ig_djgeneric_01", 2580849741}, {"ig_djsolfotios", 1241432569}, {"ig_djsoljakob", 2486302027}, {"ig_djsolmanager", 2123514453}, {"ig_djsolmike", 795497466}, {"ig_djsolrobt", 1194880004}, {"ig_djtalaurelia", 2972453492}, {"ig_djtalignazio", 2787461577}, {"ig_englishdave", 205318924},
              {"ig_englishdave_02", 905946442}, {"ig_georginacheng", 4014713647}, {"ig_gustavo", 3045437975}, {"ig_helmsmanpavel", 3619807921}, {"ig_huang", 3218252083}, {"ig_isldj_00", 3802345064}, {"ig_isldj_01", 1866942414}, {"ig_isldj_02", 1562223483}, {"ig_isldj_03", 322310057}, {"ig_isldj_04", 2154719772}, {"ig_isldj_04_d_01", 2979249514}, {"ig_isldj_04_d_02", 4260779566}, {"ig_isldj_04_e_01", 590182749}, {"ig_jackie", 2040422902}, {"ig_jimmyboston_02", 1135976220},
              {"ig_jimmydisanto2", 2217591510}, {"ig_jio", 1937203007}, {"ig_juanstrickler", 507392637}, {"ig_kaylee", 2810251555}, {"ig_kerrymcintosh_02", 3628252818}, {"ig_lacey_jones_02", 3426139884}, {"ig_lazlow_2", 2231650028}, {"ig_lestercrest_2", 1849883942}, {"ig_lestercrest_3", 2013139108}, {"ig_malc", 4055673113}, {"ig_miguelmadrazo", 2781707480}, {"ig_mjo", 761115490}, {"ig_oldrichguy", 1006915658}, {"ig_patricia_02", 3272690865}, {"ig_pilot", 2253313678},
              {"ig_sacha", 1476581877}, {"ig_sol", 3786117468}, {"ig_sss", 991486725}, {"ig_talcc", 3828621987}, {"ig_talmm", 1182156569}, {"ig_taocheng2", 1506159504}, {"ig_taostranslator2", 3828553631}, {"ig_thornton", 2482949079}, {"ig_tomcasino", 55858852}, {"ig_tonyprince", 761829301}, {"ig_tylerdix_02", 1511543927}, {"ig_vincent", 736659122}, {"ig_vincent_2", 197443027}, {"ig_wendy", 1850188817}, {"mp_f_bennymech_01", 2139205821}, {"mp_f_cardesign_01", 606876839},
              {"mp_f_chbar_01", 3287737221}, {"mp_f_cocaine_01", 1264941816}, {"mp_f_counterfeit_01", 3079205365}, {"mp_f_execpa_01", 1126998116}, {"mp_f_forgery_01", 2014985464}, {"mp_f_helistaff_01", 431423238}, {"mp_f_meth_01", 3534913217}, {"mp_f_weed_01", 2992993187}, {"mp_m_avongoon", 2618542997}, {"mp_m_bogdangoon", 1297520375}, {"mp_m_cocaine_01", 1456705429}, {"mp_m_counterfeit_01", 2555758964}, {"mp_m_execpa_01", 1048844220}, {"mp_m_forgery_01", 1631482011},
              {"mp_m_meth_01", 3988008767}, {"mp_m_securoguard_01", 3660355662}, {"mp_m_waremech_01", 4154933561}, {"mp_m_weapexp_01", 921328393}, {"mp_m_weapwork_01", 1099321454}, {"mp_m_weed_01", 2441008217}, {"s_f_y_beachbarstaff_01", 3269663242}, {"s_f_y_casino_01", 3163733717}, {"s_f_y_clubbar_01", 3240507723}, {"s_f_y_clubbar_02", 1438999163}, {"s_m_m_bouncer_02", 1376128402}, {"s_m_m_drugprocess_01", 1547070595}, {"s_m_m_fieldworker_01", 2423573072},
              {"s_m_m_highsec_03", 518696223}, {"s_m_m_highsec_04", 1442749254}, {"s_m_y_casino_01", 337826907}, {"s_m_y_clubbar_01", 1299424319}, {"s_m_y_waretech_01", 1221043248}, {"s_m_y_westsec_01", 2719478597}, {"s_m_y_westsec_02", 3200789669}, {"s_m_y_xmech_02_mp", 1762949645}, {"u_f_m_casinocash_01", 3138220789}, {"u_f_m_casinoshop_01", 338154536}, {"u_f_m_debbie_01", 223828550}, {"u_f_m_miranda_02", 3954904244}, {"u_f_o_carol", 1415150394},
              {"u_f_o_eileen", 2630685688}, {"u_f_y_beth", 2503965067}, {"u_f_y_danceburl_01", 222643882}, {"u_f_y_dancelthr_01", 130590395}, {"u_f_y_dancerave_01", 2900533745}, {"u_f_y_lauren", 967594628}, {"u_f_y_poppymich_02", 1823868411}, {"u_f_y_taylor", 450271392}, {"u_m_m_blane", 2543361176}, {"u_m_m_curtis", 4161104501}, {"u_m_m_vince", 2526968950}, {"u_m_o_dean", 4188740747}, {"u_m_y_caleb", 4150317356}, {"u_m_y_corpse_01", 2495782975},
              {"u_m_y_croupthief_01", 2145640135}, {"u_m_y_danceburl_01", 1443057394}, {"u_m_y_dancelthr_01", 4202382694}, {"u_m_y_dancerave_01", 2145639711}, {"u_m_y_gabriel", 1278330017}, {"u_m_y_juggernaut_01", 2431602996}, {"u_m_y_smugmech_01", 3446096293}, {"u_m_y_ushi", 4218162071}, {"a_c_boar", 3462393972}, {"a_c_cat_01", 1462895032}, {"a_c_chickenhawk", 2864127842}, {"a_c_chimp", 2825402133}, {"a_c_chop", 351016938}, {"a_c_cormorant", 1457690978},
              {"a_c_cow", 4244282910}, {"a_c_coyote", 1682622302}, {"a_c_crow", 402729631}, {"a_c_deer", 3630914197}, {"a_c_dolphin", 2344268885}, {"a_c_fish", 802685111}, {"a_c_hen", 1794449327}, {"a_c_humpback", 1193010354}, {"a_c_husky", 1318032802}, {"a_c_killerwhale", 2374682809}, {"a_c_mtlion", 307287994}, {"a_c_pig", 2971380566}, {"a_c_pigeon", 111281960}, {"a_c_poodle", 1125994524}, {"a_c_pug", 1832265812}, {"a_c_rabbit_01", 3753204865}, {"a_c_rat", 3283429734},
              {"a_c_retriever", 882848737}, {"a_c_rhesus", 3268439891}, {"a_c_rottweiler", 2506301981}, {"a_c_seagull", 3549666813}, {"a_c_sharkhammer", 1015224100}, {"a_c_sharktiger", 113504370}, {"a_c_shepherd", 1126154828}, {"a_c_stingray", 2705875277}, {"a_c_westy", 2910340283}, {"a_f_m_beach_01", 808859815}, {"a_f_m_bevhills_01", 3188223741}, {"a_f_m_bevhills_02", 2688103263}, {"a_f_m_bodybuild_01", 1004114196}, {"a_f_m_business_02", 532905404},
              {"a_f_m_downtown_01", 1699403886}, {"a_f_m_eastsa_01", 2638072698}, {"a_f_m_eastsa_02", 1674107025}, {"a_f_m_fatbla_01", 4206136267}, {"a_f_m_fatcult_01", 3050275044}, {"a_f_m_fatwhite_01", 951767867}, {"a_f_m_ktown_01", 1388848350}, {"a_f_m_ktown_02", 1090617681}, {"a_f_m_prolhost_01", 379310561}, {"a_f_m_salton_01", 3725461865}, {"a_f_m_skidrow_01", 2962707003}, {"a_f_m_soucent_01", 1951946145}, {"a_f_m_soucent_02", 4079145784},
              {"a_f_m_soucentmc_01", 3454621138}, {"a_f_m_tourist_01", 1347814329}, {"a_f_m_tramp_01", 1224306523}, {"a_f_m_trampbeac_01", 2359345766}, {"a_f_o_genstreet_01", 1640504453}, {"a_f_o_indian_01", 3134700416}, {"a_f_o_ktown_01", 1204772502}, {"a_f_o_salton_01", 3439295882}, {"a_f_o_soucent_01", 1039800368}, {"a_f_o_soucent_02", 2775443222}, {"a_f_y_beach_01", 3349113128}, {"a_f_y_bevhills_01", 1146800212}, {"a_f_y_bevhills_02", 1546450936},
              {"a_f_y_bevhills_03", 549978415}, {"a_f_y_bevhills_04", 920595805}, {"a_f_y_business_01", 664399832}, {"a_f_y_business_02", 826475330}, {"a_f_y_business_03", 2928082356}, {"a_f_y_business_04", 3083210802}, {"a_f_y_eastsa_01", 4121954205}, {"a_f_y_eastsa_02", 70821038}, {"a_f_y_eastsa_03", 1371553700}, {"a_f_y_epsilon_01", 1755064960}, {"a_f_y_femaleagent", 1348537411}, {"a_f_y_fitness_01", 1165780219}, {"a_f_y_fitness_02", 331645324},
              {"a_f_y_genhot_01", 793439294}, {"a_f_y_golfer_01", 2111372120}, {"a_f_y_hiker_01", 813893651}, {"a_f_y_hippie_01", 343259175}, {"a_f_y_hipster_01", 2185745201}, {"a_f_y_hipster_02", 2549481101}, {"a_f_y_hipster_03", 2780469782}, {"a_f_y_hipster_04", 429425116}, {"a_f_y_indian_01", 153984193}, {"a_f_y_juggalo_01", 3675473203}, {"a_f_y_runner_01", 3343476521}, {"a_f_y_rurmeth_01", 1064866854}, {"a_f_y_scdressy_01", 3680420864}, {"a_f_y_skater_01", 1767892582},
              {"a_f_y_soucent_01", 744758650}, {"a_f_y_soucent_02", 1519319503}, {"a_f_y_soucent_03", 2276611093}, {"a_f_y_tennis_01", 1426880966}, {"a_f_y_topless_01", 2633130371}, {"a_f_y_tourist_01", 1446741360}, {"a_f_y_tourist_02", 2435054400}, {"a_f_y_vinewood_01", 435429221}, {"a_f_y_vinewood_02", 3669401835}, {"a_f_y_vinewood_03", 933092024}, {"a_f_y_vinewood_04", 4209271110}, {"a_f_y_yoga_01", 3290105390}, {"a_m_m_acult_01", 1413662315},
              {"a_m_m_afriamer_01", 3513928062}, {"a_m_m_beach_01", 1077785853}, {"a_m_m_beach_02", 2021631368}, {"a_m_m_bevhills_01", 1423699487}, {"a_m_m_bevhills_02", 1068876755}, {"a_m_m_business_01", 2120901815}, {"a_m_m_eastsa_01", 4188468543}, {"a_m_m_eastsa_02", 131961260}, {"a_m_m_farmer_01", 2488675799}, {"a_m_m_fatlatin_01", 1641152947}, {"a_m_m_genfat_01", 115168927}, {"a_m_m_genfat_02", 330231874}, {"a_m_m_golfer_01", 2850754114}, {"a_m_m_hasjew_01", 1809430156},
              {"a_m_m_hillbilly_01", 1822107721}, {"a_m_m_hillbilly_02", 2064532783}, {"a_m_m_indian_01", 3721046572}, {"a_m_m_ktown_01", 3512565361}, {"a_m_m_malibu_01", 803106487}, {"a_m_m_mexcntry_01", 3716251309}, {"a_m_m_mexlabor_01", 2992445106}, {"a_m_m_og_boss_01", 1746653202}, {"a_m_m_paparazzi_01", 3972697109}, {"a_m_m_polynesian_01", 2849617566}, {"a_m_m_prolhost_01", 2534589327}, {"a_m_m_rurmeth_01", 1001210244}, {"a_m_m_salton_01", 1328415626},
              {"a_m_m_salton_02", 1626646295}, {"a_m_m_salton_03", 2995538501}, {"a_m_m_salton_04", 2521108919}, {"a_m_m_skater_01", 3654768780}, {"a_m_m_skidrow_01", 32417469}, {"a_m_m_socenlat_01", 193817059}, {"a_m_m_soucent_01", 1750583735}, {"a_m_m_soucent_02", 2674735073}, {"a_m_m_soucent_03", 2346291386}, {"a_m_m_soucent_04", 3271294718}, {"a_m_m_stlat_02", 3265820418}, {"a_m_m_tennis_01", 1416254276}, {"a_m_m_tourist_01", 3365863812}, {"a_m_m_tramp_01", 516505552},
              {"a_m_m_trampbeac_01", 1404403376}, {"a_m_m_tranvest_01", 3773208948}, {"a_m_m_tranvest_02", 4144940484}, {"a_m_o_acult_01", 1430544400}, {"a_m_o_acult_02", 1268862154}, {"a_m_o_beach_01", 2217202584}, {"a_m_o_genstreet_01", 2908022696}, {"a_m_o_ktown_01", 355916122}, {"a_m_o_salton_01", 539004493}, {"a_m_o_soucent_01", 718836251}, {"a_m_o_soucent_02", 1082572151}, {"a_m_o_soucent_03", 238213328}, {"a_m_o_tramp_01", 390939205}, {"a_m_y_acult_01", 3043264555},
              {"a_m_y_acult_02", 2162532142}, {"a_m_y_beach_01", 3523131524}, {"a_m_y_beach_02", 600300561}, {"a_m_y_beach_03", 3886638041}, {"a_m_y_beachvesp_01", 2114544056}, {"a_m_y_beachvesp_02", 3394697810}, {"a_m_y_bevhills_01", 1982350912}, {"a_m_y_bevhills_02", 1720428295}, {"a_m_y_breakdance_01", 933205398}, {"a_m_y_busicas_01", 2597531625}, {"a_m_y_business_01", 3382649284}, {"a_m_y_business_02", 3014915558}, {"a_m_y_business_03", 2705543429},
              {"a_m_y_cyclist_01", 4257633223}, {"a_m_y_dhill_01", 4282288299}, {"a_m_y_downtown_01", 766375082}, {"a_m_y_eastsa_01", 2756120947}, {"a_m_y_eastsa_02", 377976310}, {"a_m_y_epsilon_01", 2010389054}, {"a_m_y_epsilon_02", 2860711835}, {"a_m_y_gay_01", 3519864886}, {"a_m_y_gay_02", 2775713665}, {"a_m_y_genstreet_01", 2557996913}, {"a_m_y_genstreet_02", 891398354}, {"a_m_y_golfer_01", 3609190705}, {"a_m_y_hasjew_01", 3782053633}, {"a_m_y_hiker_01", 1358380044},
              {"a_m_y_hippy_01", 2097407511}, {"a_m_y_hipster_01", 587703123}, {"a_m_y_hipster_02", 349505262}, {"a_m_y_hipster_03", 1312913862}, {"a_m_y_indian_01", 706935758}, {"a_m_y_jetski_01", 767028979}, {"a_m_y_juggalo_01", 2445950508}, {"a_m_y_ktown_01", 452351020}, {"a_m_y_ktown_02", 696250687}, {"a_m_y_latino_01", 321657486}, {"a_m_y_methhead_01", 1768677545}, {"a_m_y_mexthug_01", 810804565}, {"a_m_y_motox_01", 1694362237}, {"a_m_y_motox_02", 2007797722},
              {"a_m_y_musclbeac_01", 1264920838}, {"a_m_y_musclbeac_02", 3374523516}, {"a_m_y_polynesian_01", 2206530719}, {"a_m_y_roadcyc_01", 4116817094}, {"a_m_y_runner_01", 623927022}, {"a_m_y_runner_02", 2218630415}, {"a_m_y_salton_01", 3613420592}, {"a_m_y_skater_01", 3250873975}, {"a_m_y_skater_02", 2952446692}, {"a_m_y_soucent_01", 3877027275}, {"a_m_y_soucent_02", 2896414922}, {"a_m_y_soucent_03", 3287349092}, {"a_m_y_soucent_04", 2318861297},
              {"a_m_y_stbla_01", 3482496489}, {"a_m_y_stbla_02", 2563194959}, {"a_m_y_stlat_01", 2255803900}, {"a_m_y_stwhi_01", 605602864}, {"a_m_y_stwhi_02", 919005580}, {"a_m_y_sunbathe_01", 3072929548}, {"a_m_y_surfer_01", 3938633710}, {"a_m_y_vindouche_01", 3247667175}, {"a_m_y_vinewood_01", 1264851357}, {"a_m_y_vinewood_02", 1561705728}, {"a_m_y_vinewood_03", 534725268}, {"a_m_y_vinewood_04", 835315305}, {"a_m_y_yoga_01", 2869588309}, {"cs_amandatownley", 2515474659},
              {"cs_andreas", 3881194279}, {"cs_ashley", 650367097}, {"cs_bankman", 2539657518}, {"cs_barry", 1767447799}, {"cs_beverly", 3027157846}, {"cs_brad", 4024807398}, {"cs_bradcadaver", 1915268960}, {"cs_carbuyer", 2362341647}, {"cs_casey", 3935738944}, {"cs_chengsr", 819699067}, {"cs_chrisformage", 3253960934}, {"cs_clay", 3687553076}, {"cs_dale", 216536661}, {"cs_davenorton", 2240226444}, {"cs_debra", 3973074921}, {"cs_denise", 1870669624}, {"cs_devin", 788622594},
              {"cs_dom", 1198698306}, {"cs_dreyfuss", 1012965715}, {"cs_drfriedlander", 2745392175}, {"cs_fabien", 1191403201}, {"cs_fbisuit_01", 1482427218}, {"cs_floyd", 103106535}, {"cs_guadalope", 261428209}, {"cs_gurk", 3272931111}, {"cs_hunter", 1531218220}, {"cs_janet", 808778210}, {"cs_jewelass", 1145088004}, {"cs_jimmyboston", 60192701}, {"cs_jimmydisanto", 3100414644}, {"cs_joeminuteman", 4036845097}, {"cs_johnnyklebitz", 4203395201}, {"cs_josef", 1167549130},
              {"cs_josh", 1158606749}, {"cs_karen_daniels", 1269774364}, {"cs_lamardavis", 1162230285}, {"cs_lazlow", 949295643}, {"cs_lestercrest", 3046438339}, {"cs_lifeinvad_01", 1918178165}, {"cs_magenta", 1477887514}, {"cs_manuel", 4222842058}, {"cs_marnie", 1464721716}, {"cs_martinmadrazo", 1129928304}, {"cs_maryann", 161007533}, {"cs_michelle", 1890499016}, {"cs_milton", 3077190415}, {"cs_molly", 1167167044}, {"cs_movpremf_01", 1270514905},
              {"cs_movpremmale", 2372398717}, {"cs_mrk", 3284966005}, {"cs_mrs_thornhill", 1334976110}, {"cs_mrsphillips", 3422397391}, {"cs_natalia", 1325314544}, {"cs_nervousron", 2023152276}, {"cs_nigel", 3779566603}, {"cs_old_man1a", 518814684}, {"cs_old_man2", 2566514544}, {"cs_omega", 2339419141}, {"cs_orleans", 2905870170}, {"cs_paper", 1798879480}, {"cs_patricia", 3750433537}, {"cs_priest", 1299047806}, {"cs_prolsec_02", 512955554}, {"cs_russiandrunk", 1179785778},
              {"cs_siemonyetarian", 3230888450}, {"cs_solomon", 4140949582}, {"cs_stevehains", 2766184958}, {"cs_stretch", 2302502917}, {"cs_tanisha", 1123963760}, {"cs_taocheng", 2288257085}, {"cs_taostranslator", 1397974313}, {"cs_tenniscoach", 1545995274}, {"cs_terry", 978452933}, {"cs_tom", 1776856003}, {"cs_tomepsilon", 2349847778}, {"cs_tracydisanto", 101298480}, {"cs_wade", 3529955798}, {"cs_zimbor", 3937184496}, {"csb_abigail", 2306246977}, {"csb_agent", 3614493108},
              {"csb_anita", 117698822}, {"csb_anton", 2781317046}, {"csb_ballasog", 2884567044}, {"csb_bride", 2193587873}, {"csb_burgerdrug", 2363277399}, {"csb_car3guy1", 71501447}, {"csb_car3guy2", 327394568}, {"csb_chef", 2739391114}, {"csb_chef2", 2925257274}, {"csb_chin_goon", 2831296918}, {"csb_cletus", 3404326357}, {"csb_cop", 2595446627}, {"csb_customer", 2756669323}, {"csb_denise_friend", 3045926185}, {"csb_fos_rep", 466359675}, {"csb_g", 2727244247},
              {"csb_groom", 2058033618}, {"csb_grove_str_dlr", 3898166818}, {"csb_hao", 3969814300}, {"csb_hugh", 1863555924}, {"csb_imran", 3812756443}, {"csb_jackhowitzer", 1153203121}, {"csb_janitor", 3254803008}, {"csb_maude", 3166991819}, {"csb_money", 2560490906}, {"csb_mp_agent14", 1841036427}, {"csb_mweather", 1631478380}, {"csb_ortega", 3235579087}, {"csb_oscar", 4095687067}, {"csb_paige", 1528799427}, {"csb_popov", 1635617250}, {"csb_porndudes", 793443893},
              {"csb_prologuedriver", 4027271643}, {"csb_prolsec", 2141384740}, {"csb_ramp_gang", 3263172030}, {"csb_ramp_hic", 2240582840}, {"csb_ramp_hipster", 569740212}, {"csb_ramp_marine", 1634506681}, {"csb_ramp_mex", 4132362192}, {"csb_rashcosvki", 411081129}, {"csb_reporter", 776079908}, {"csb_roccopelosi", 2858686092}, {"csb_screen_writer", 2346790124}, {"csb_stripper_01", 2934601397}, {"csb_stripper_02", 2168724337}, {"csb_tonya", 1665391897},
              {"csb_trafficwarden", 3727243251}, {"csb_undercover", 4017642090}, {"csb_vagspeak", 1224690857}, {"g_f_importexport_01", 2225189146}, {"g_f_y_ballas_01", 361513884}, {"g_f_y_families_01", 1309468115}, {"g_f_y_lost_01", 4250220510}, {"g_f_y_vagos_01", 1520708641}, {"g_m_importexport_01", 3164785898}, {"g_m_m_armboss_01", 4058522530}, {"g_m_m_armgoon_01", 4255728232}, {"g_m_m_armlieut_01", 3882958867}, {"g_m_m_chemwork_01", 4128603535},
              {"g_m_m_chiboss_01", 3118269184}, {"g_m_m_chicold_01", 275618457}, {"g_m_m_chigoon_01", 2119136831}, {"g_m_m_chigoon_02", 4285659174}, {"g_m_m_korboss_01", 891945583}, {"g_m_m_mexboss_01", 1466037421}, {"g_m_m_mexboss_02", 1226102803}, {"g_m_y_armgoon_02", 3310258058}, {"g_m_y_azteca_01", 1752208920}, {"g_m_y_ballaeast_01", 4096714883}, {"g_m_y_ballaorig_01", 588969535}, {"g_m_y_ballasout_01", 599294057}, {"g_m_y_famca_01", 3896218551},
              {"g_m_y_famdnf_01", 3681718840}, {"g_m_y_famfor_01", 2217749257}, {"g_m_y_korean_01", 611648169}, {"g_m_y_korean_02", 2414729609}, {"g_m_y_korlieut_01", 2093736314}, {"g_m_y_lost_01", 1330042375}, {"g_m_y_lost_02", 1032073858}, {"g_m_y_lost_03", 850468060}, {"g_m_y_mexgang_01", 3185399110}, {"g_m_y_mexgoon_01", 653210662}, {"g_m_y_mexgoon_02", 832784782}, {"g_m_y_mexgoon_03", 2521633500}, {"g_m_y_pologoon_01", 1329576454}, {"g_m_y_pologoon_02", 2733138262},
              {"g_m_y_salvaboss_01", 2422005962}, {"g_m_y_salvagoon_01", 663522487}, {"g_m_y_salvagoon_02", 846439045}, {"g_m_y_salvagoon_03", 62440720}, {"g_m_y_strpunk_01", 4246489531}, {"g_m_y_strpunk_02", 228715206}, {"hc_driver", 994527967}, {"hc_gunman", 193469166}, {"hc_hacker", 2579169528}, {"ig_abigail", 1074457665}, {"ig_agent", 610988552}, {"ig_amandatownley", 1830688247}, {"ig_andreas", 1206185632}, {"ig_ashley", 2129936603}, {"ig_avon", 4242698434},
              {"ig_ballasog", 2802535058}, {"ig_bankman", 2426248831}, {"ig_barry", 797459875}, {"ig_benny", 3300333010}, {"ig_bestmen", 1464257942}, {"ig_beverly", 3181518428}, {"ig_brad", 3183167778}, {"ig_bride", 1633872967}, {"ig_car3guy1", 2230970679}, {"ig_car3guy2", 1975732938}, {"ig_casey", 3774489940}, {"ig_chef", 1240128502}, {"ig_chef2", 2240322243}, {"ig_chengsr", 2867128955}, {"ig_chrisformage", 678319271}, {"ig_clay", 1825562762}, {"ig_claypain", 2634057640},
              {"ig_cletus", 3865252245}, {"ig_dale", 1182012905}, {"ig_davenorton", 365775923}, {"ig_denise", 2181772221}, {"ig_devin", 1952555184}, {"ig_dom", 2620240008}, {"ig_dreyfuss", 3666413874}, {"ig_drfriedlander", 3422293493}, {"ig_fabien", 3499148112}, {"ig_fbisuit_01", 988062523}, {"ig_floyd", 2981205682}, {"ig_g", 2216405299}, {"ig_groom", 4274948997}, {"ig_hao", 1704428387}, {"ig_hunter", 3457361118}, {"ig_janet", 225287241}, {"ig_jay_norris", 2050158196},
              {"ig_jewelass", 257763003}, {"ig_jimmyboston", 3986688045}, {"ig_jimmydisanto", 1459905209}, {"ig_joeminuteman", 3189787803}, {"ig_johnnyklebitz", 2278195374}, {"ig_josef", 3776618420}, {"ig_josh", 2040438510}, {"ig_karen_daniels", 3948009817}, {"ig_kerrymcintosh", 1530648845}, {"ig_lamardavis", 1706635382}, {"ig_lazlow", 3756278757}, {"ig_lestercrest_2", 1849883942}, {"ig_lestercrest", 1302784073}, {"ig_lifeinvad_01", 1401530684},
              {"ig_lifeinvad_02", 666718676}, {"ig_magenta", 4242313482}, {"ig_malc", 4055673113}, {"ig_manuel", 4248931856}, {"ig_marnie", 411185872}, {"ig_maryann", 2741999622}, {"ig_maude", 1005070462}, {"ig_michelle", 3214308084}, {"ig_milton", 3408943538}, {"ig_molly", 2936266209}, {"ig_money", 939183526}, {"ig_mp_agent14", 4227433577}, {"ig_mrk", 3990661997}, {"ig_mrs_thornhill", 503621995}, {"ig_mrsphillips", 946007720}, {"ig_natalia", 3726105915},
              {"ig_nervousron", 3170921201}, {"ig_nigel", 3367442045}, {"ig_old_man1a", 1906124788}, {"ig_old_man2", 4011150407}, {"ig_omega", 1625728984}, {"ig_oneil", 768005095}, {"ig_orleans", 1641334641}, {"ig_ortega", 648372919}, {"ig_paige", 357551935}, {"ig_paper", 2577072326}, {"ig_patricia", 3312325004}, {"ig_popov", 645279998}, {"ig_priest", 1681385341}, {"ig_prolsec_02", 666086773}, {"ig_ramp_gang", 3845001836}, {"ig_ramp_hic", 1165307954},
              {"ig_ramp_hipster", 3740245870}, {"ig_ramp_mex", 3870061732}, {"ig_rashcosvki", 940330470}, {"ig_roccopelosi", 3585757951}, {"ig_russiandrunk", 1024089777}, {"ig_screen_writer", 4293277303}, {"ig_siemonyetarian", 1283141381}, {"ig_solomon", 2260598310}, {"ig_stevehains", 941695432}, {"ig_stretch", 915948376}, {"ig_talina", 3885222120}, {"ig_tanisha", 226559113}, {"ig_taocheng", 3697041061}, {"ig_taostranslator", 2089096292}, {"ig_tenniscoach", 2721800023},
              {"ig_terry", 1728056212}, {"ig_tomepsilon", 3447159466}, {"ig_tonya", 3402126148}, {"ig_tracydisanto", 3728026165}, {"ig_trafficwarden", 1461287021}, {"ig_tylerdix", 1382414087}, {"ig_vagspeak", 4194109068}, {"ig_wade", 2459507570}, {"ig_zimbor", 188012277}, {"mp_f_boatstaff_01", 848542158}, {"mp_f_cardesign_01", 606876839}, {"mp_f_chbar_01", 3287737221}, {"mp_f_cocaine_01", 1264941816}, {"mp_f_counterfeit_01", 3079205365}, {"mp_f_deadhooker", 1943971979},
              {"mp_f_execpa_01", 1126998116}, {"mp_f_execpa_02", 1500695792}, {"mp_f_forgery_01", 2014985464}, {"mp_f_freemode_01", 2627665880}, {"mp_f_helistaff_01", 431423238}, {"mp_f_meth_01", 3534913217}, {"mp_f_misty_01", 3509125021}, {"mp_f_stripperlite", 695248020}, {"mp_f_weed_01", 2992993187}, {"mp_g_m_pros_01", 1822283721}, {"mp_m_avongoon", 2618542997}, {"mp_m_boatstaff_01", 3361671816}, {"mp_m_bogdangoon", 1297520375}, {"mp_m_claude_01", 3237179831},
              {"mp_m_cocaine_01", 1456705429}, {"mp_m_counterfeit_01", 2555758964}, {"mp_m_exarmy_01", 1161072059}, {"mp_m_execpa_01", 1048844220}, {"mp_m_famdd_01", 866411749}, {"mp_m_fibsec_01", 1558115333}, {"mp_m_forgery_01", 1631482011}, {"mp_m_freemode_01", 1885233650}, {"mp_m_g_vagfun_01", 3299219389}, {"mp_m_marston_01", 943915367}, {"mp_m_meth_01", 3988008767}, {"mp_m_niko_01", 4007317449}, {"mp_m_securoguard_01", 3660355662}, {"mp_m_shopkeep_01", 416176080},
              {"mp_m_waremech_01", 4154933561}, {"mp_m_weapexp_01", 921328393}, {"mp_m_weapwork_01", 1099321454}, {"mp_m_weed_01", 2441008217}, {"mp_s_m_armoured_01", 3455013896}, {"player_one", 2602752943}, {"player_two", 2608926626}, {"player_zero", 225514697}, {"s_f_m_fembarber", 373000027}, {"s_f_m_maid_01", 3767780806}, {"s_f_m_shop_high", 2923947184}, {"s_f_m_sweatshop_01", 824925120}, {"s_f_y_airhostess_01", 1567728751}, {"s_f_y_bartender_01", 2014052797},
              {"s_f_y_baywatch_01", 1250841910}, {"s_f_y_cop_01", 368603149}, {"s_f_y_factory_01", 1777626099}, {"s_f_y_hooker_01", 42647445}, {"s_f_y_hooker_02", 348382215}, {"s_f_y_hooker_03", 51789996}, {"s_f_y_migrant_01", 3579522037}, {"s_f_y_movprem_01", 587253782}, {"s_f_y_ranger_01", 2680682039}, {"s_f_y_scrubs_01", 2874755766}, {"s_f_y_sheriff_01", 1096929346}, {"s_f_y_shop_low", 2842568196}, {"s_f_y_shop_mid", 1055701597}, {"s_f_y_stripper_01", 1381498905},
              {"s_f_y_stripper_02", 1846523796}, {"s_f_y_stripperlite", 1544875514}, {"s_f_y_sweatshop_01", 2231547570}, {"s_m_m_ammucountry", 233415434}, {"s_m_m_armoured_01", 2512875213}, {"s_m_m_armoured_02", 1669696074}, {"s_m_m_autoshop_01", 68070371}, {"s_m_m_autoshop_02", 4033578141}, {"s_m_m_bouncer_01", 2681481517}, {"s_m_m_ccrew_01", 3387290987}, {"s_m_m_chemsec_01", 788443093}, {"s_m_m_ciasec_01", 1650288984}, {"s_m_m_cntrybar_01", 436345731},
              {"s_m_m_dockwork_01", 349680864}, {"s_m_m_doctor_01", 3564307372}, {"s_m_m_fiboffice_01", 3988550982}, {"s_m_m_fiboffice_02", 653289389}, {"s_m_m_fibsec_01", 2072724299}, {"s_m_m_gaffer_01", 2841034142}, {"s_m_m_gardener_01", 1240094341}, {"s_m_m_gentransport", 411102470}, {"s_m_m_hairdress_01", 1099825042}, {"s_m_m_highsec_01", 4049719826}, {"s_m_m_highsec_02", 691061163}, {"s_m_m_janitor", 2842417644}, {"s_m_m_lathandy_01", 2659242702},
              {"s_m_m_lifeinvad_01", 3724572669}, {"s_m_m_linecook", 3684436375}, {"s_m_m_lsmetro_01", 1985653476}, {"s_m_m_mariachi_01", 2124742566}, {"s_m_m_marine_01", 4074414829}, {"s_m_m_marine_02", 4028996995}, {"s_m_m_migrant_01", 3977045190}, {"s_m_m_movalien_01", 1684083350}, {"s_m_m_movprem_01", 3630066984}, {"s_m_m_movspace_01", 3887273010}, {"s_m_m_paramedic_01", 3008586398}, {"s_m_m_pilot_01", 3881519900}, {"s_m_m_pilot_02", 4131252449},
              {"s_m_m_postal_01", 1650036788}, {"s_m_m_postal_02", 1936142927}, {"s_m_m_prisguard_01", 1456041926}, {"s_m_m_scientist_01", 1092080539}, {"s_m_m_security_01", 3613962792}, {"s_m_m_snowcop_01", 451459928}, {"s_m_m_strperf_01", 2035992488}, {"s_m_m_strpreach_01", 469792763}, {"s_m_m_strvend_01", 3465614249}, {"s_m_m_trucker_01", 1498487404}, {"s_m_m_ups_01", 2680389410}, {"s_m_m_ups_02", 3502104854}, {"s_m_o_busker_01", 2912874939},
              {"s_m_y_airworker", 1644266841}, {"s_m_y_ammucity_01", 2651349821}, {"s_m_y_armymech_01", 1657546978}, {"s_m_y_autopsy_01", 2988916046}, {"s_m_y_barman_01", 3852538118}, {"s_m_y_baywatch_01", 189425762}, {"s_m_y_blackops_01", 3019107892}, {"s_m_y_blackops_02", 2047212121}, {"s_m_y_blackops_03", 1349953339}, {"s_m_y_busboy_01", 3640249671}, {"s_m_y_chef_01", 261586155}, {"s_m_y_clown_01", 71929310}, {"s_m_y_construct_01", 3621428889},
              {"s_m_y_construct_02", 3321821918}, {"s_m_y_cop_01", 1581098148}, {"s_m_y_dealer_01", 3835149295}, {"s_m_y_devinsec_01", 2606068340}, {"s_m_y_dockwork_01", 2255894993}, {"s_m_y_doorman_01", 579932932}, {"s_m_y_dwservice_01", 1976765073}, {"s_m_y_dwservice_02", 4119890438}, {"s_m_y_factory_01", 1097048408}, {"s_m_y_fireman_01", 3065114024}, {"s_m_y_garbage", 4000686095}, {"s_m_y_grip_01", 815693290}, {"s_m_y_hwaycop_01", 1939545845},
              {"s_m_y_marine_01", 1702441027}, {"s_m_y_marine_02", 1490458366}, {"s_m_y_marine_03", 1925237458}, {"s_m_y_mime", 1021093698}, {"s_m_y_pestcont_01", 1209091352}, {"s_m_y_pilot_01", 2872052743}, {"s_m_y_prismuscl_01", 1596003233}, {"s_m_y_prisoner_01", 2981862233}, {"s_m_y_ranger_01", 4017173934}, {"s_m_y_robber_01", 3227390873}, {"s_m_y_sheriff_01", 2974087609}, {"s_m_y_shop_mask", 1846684678}, {"s_m_y_strvend_01", 2457805603}, {"s_m_y_swat_01", 2374966032},
              {"s_m_y_uscg_01", 3389018345}, {"s_m_y_valet_01", 999748158}, {"s_m_y_waiter_01", 2907468364}, {"s_m_y_winclean_01", 1426951581}, {"s_m_y_xmech_01", 1142162924}, {"s_m_y_xmech_02_mp", 1762949645}, {"s_m_y_xmech_02", 3189832196}, {"u_f_m_corpse_01", 773063444}, {"u_f_m_drowned_01", 3623056905}, {"u_f_m_miranda", 1095737979}, {"u_f_m_promourn_01", 2718472679}, {"u_f_o_moviestar", 894928436}, {"u_f_o_prolhost_01", 3306347811}, {"u_f_y_bikerchic", 4198014287},
              {"u_f_y_comjane", 3064628686}, {"u_f_y_corpse_01", 2624589981}, {"u_f_y_corpse_02", 228356856}, {"u_f_y_hotposh_01", 2526768638}, {"u_f_y_jewelass_01", 4040474158}, {"u_f_y_mistress", 1573528872}, {"u_f_y_poppymich", 602513566}, {"u_f_y_princess", 3538133636}, {"u_f_y_spyactress", 1535236204}, {"u_m_m_aldinapoli", 4042020578}, {"u_m_m_bankman", 3272005365}, {"u_m_m_bikehire_01", 1984382277}, {"u_m_m_doa_01", 1646160893}, {"u_m_m_edtoh", 712602007},
              {"u_m_m_fibarchitect", 874722259}, {"u_m_m_filmdirector", 728636342}, {"u_m_m_glenstank_01", 1169888870}, {"u_m_m_griff_01", 3293887675}, {"u_m_m_jesus_01", 3459037009}, {"u_m_m_jewelsec_01", 2899099062}, {"u_m_m_jewelthief", 3872144604}, {"u_m_m_markfost", 479578891}, {"u_m_m_partytarget", 2180468199}, {"u_m_m_prolsec_01", 1888624839}, {"u_m_m_promourn_01", 3465937675}, {"u_m_m_rivalpap", 1624626906}, {"u_m_m_spyactor", 2886641112},
              {"u_m_m_streetart_01", 1813637474}, {"u_m_m_willyfist", 2423691919}, {"u_m_o_filmnoir", 732742363}, {"u_m_o_finguru_01", 1189322339}, {"u_m_o_taphillbilly", 2585681490}, {"u_m_o_tramp_01", 1787764635}, {"u_m_y_abner", 4037813798}, {"u_m_y_antonb", 3479321132}, {"u_m_y_babyd", 3658575486}, {"u_m_y_baygor", 1380197501}, {"u_m_y_burgerdrug_01", 2340239206}, {"u_m_y_chip", 610290475}, {"u_m_y_corpse_01", 2495782975}, {"u_m_y_cyclist_01", 755956971},
              {"u_m_y_fibmugger_01", 2243544680}, {"u_m_y_guido_01", 3333724719}, {"u_m_y_gunvend_01", 3005388626}, {"u_m_y_hippie_01", 4030826507}, {"u_m_y_imporage", 880829941}, {"u_m_y_juggernaut_01", 2431602996}, {"u_m_y_justin", 2109968527}, {"u_m_y_mani", 3367706194}, {"u_m_y_militarybum", 1191548746}, {"u_m_y_paparazzi", 1346941736}, {"u_m_y_party_01", 921110016}, {"u_m_y_pogo_01", 3696858125}, {"u_m_y_prisoner_01", 2073775040}, {"u_m_y_proldriver_01", 2237544099},
              {"u_m_y_rsranger_01", 1011059922}, {"u_m_y_sbike", 1794381917}, {"u_m_y_staggrm_01", 2442448387}, {"u_m_y_tattoo_01", 2494442380}, {"u_m_y_zombie_01", 2890614022}}

SoundAnnoy = {{"CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"TIME_LAPSE_MASTER", "0"}, {"TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"Timer_10s", "DLC_HALLOWEEN_FVJ_Sounds"}, {"TIMER_STOP", "HUD_MINI_GAME_SOUNDSET"}, {"5s_To_Event_Start_Countdown", "GTAO_FM_Events_Soundset"}, {"10s", "MP_MISSION_COUNTDOWN_SOUNDSET"}, {"5s", "MP_MISSION_COUNTDOWN_SOUNDSET"}, {"5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"}, {"5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET"},
              {"3_2_1_NON_RACE", "HUD_MINI_GAME_SOUNDSET"}, {"3_2_1", "HUD_MINI_GAME_SOUNDSET"}, {"WIND", "EXTREME_01_SOUNDSET"}, {"HOUSE_FIRE", "JOSH_03_SOUNDSET"}, {"Hot_Tub_Loop", "GTAO_Yacht_SoundSet"}, {"Arming_Countdown", "GTAO_Speed_Convoy_Soundset"}, {"Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset"}, {"Boss_Blipped", "GTAO_Magnate_Hunt_Boss_SoundSet"}, {"Boss_Message_Orange", "GTAO_Boss_Goons_FM_Soundset"}, {"1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET"},
              {"Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet"}, {"ARM_WRESTLING_WHOOSH_MASTER", "0"}, {"ASSASSINATIONS_HOTEL_TIMER_COUNTDOWN", "ASSASSINATION_MULTI"}, {"ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"BASE_JUMP_PASSED", "HUD_AWARDS"}, {"Bed", "WastedSounds"}, {"Beep_Green", "DLC_HEIST_HACKING_SNAKE_SOUNDS"}, {"Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS"}, {"Blade_Appear", "APT_BvS_Soundset"}, {"BOATS_PLANES_HELIS_BOOM", "MP_LOBBY_SOUNDS"},
              {"Breaker_01", "DLC_HALLOWEEN_FVJ_Sounds"}, {"Breaker_02", "DLC_HALLOWEEN_FVJ_Sounds"}, {"Bus_Schedule_Pickup", "DLC_PRISON_BREAK_HEIST_SOUNDS"}, {"CABLE_SNAPS", "CONSTRUCTION_ACCIDENT_1_SOUNDS"}, {"CAM_PAN_DARTS", "HUD_MINI_GAME_SOUNDSET"}, {"Camera_Shoot", "Phone_Soundset_Franklin"}, {"CANCEL", "HUD_FREEMODE_SOUNDSET"}, {"CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS"}, {"CHALLENGE_UNLOCKED", "HUD_AWARDS"}, {"CHECKPOINT_AHEAD", "HUD_MINI_GAME_SOUNDSET"},
              {"CHECKPOINT_BEHIND", "HUD_MINI_GAME_SOUNDSET"}, {"Checkpoint_Cash_Hit", "GTAO_FM_Events_Soundset"}, {"Checkpoint_Hit", "GTAO_FM_Events_Soundset"}, {"CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET"}, {"CHECKPOINT_NORMAL", "HUD_MINI_GAME_SOUNDSET"}, {"CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET"}, {"Checkpoint_Teammate", "GTAO_Shepherd_Sounds"}, {"CHECKPOINT_UNDER_THE_BRIDGE", "HUD_MINI_GAME_SOUNDSET"}, {"Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
              {"CLICK_BACK", "WEB_NAVIGATION_SOUNDS_PHONE"}, {"Click_Fail", "WEB_NAVIGATION_SOUNDS_PHONE"}, {"Click_Special", "WEB_NAVIGATION_SOUNDS_PHONE"}, {"CLOSED", "MP_PROPERTIES_ELEVATOR_DOORS"}, {"CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET"}, {"CONTINUE", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"Continue_Accepted", "DLC_HEIST_PLANNING_BOARD_SOUNDS"}, {"Continue_Appears", "DLC_HEIST_PLANNING_BOARD_SOUNDS"}, {"Crash", "DLC_HEIST_HACKING_SNAKE_SOUNDS"},
              {"Criminal_Damage_High_Value", "GTAO_FM_Events_Soundset"}, {"Criminal_Damage_Kill_Player", "GTAO_FM_Events_Soundset"}, {"Criminal_Damage_Low_Value", "GTAO_FM_Events_Soundset"}, {"Cycle_Item", "DLC_Dmod_Prop_Editor_Sounds"}, {"DELETE", "HUD_DEATHMATCH_SOUNDSET"}, {"Delete_Placed_Prop", "DLC_Dmod_Prop_Editor_Sounds"}, {"Deliver_Pick_Up", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS"}, {"DiggerRevOneShot", "BulldozerDefault"}, {"Door_Open", "DOCKS_HEIST_FINALE_2B_SOUNDS"},
              {"Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET"}, {"Dropped", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS"}, {"EDIT", "HUD_DEATHMATCH_SOUNDSET"}, {"Start_Squelch", "CB_RADIO_SFX"}, {"End_Squelch", "CB_RADIO_SFX"}, {"Enemy_Capture_Start", "GTAO_Magnate_Yacht_Attack_Soundset"}, {"Enemy_Deliver", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS"}, {"Enemy_Pick_Up", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS"}, {"Enter_1st", "GTAO_FM_Events_Soundset"},
              {"Enter_Area", "DLC_Lowrider_Relay_Race_Sounds"}, {"Enter_Capture_Zone", "DLC_Apartments_Drop_Zone_Sounds"}, {"ERROR", "HUD_AMMO_SHOP_SOUNDSET"}, {"Event_Message_Purple", "GTAO_FM_Events_Soundset"}, {"Event_Start_Text", "GTAO_FM_Events_Soundset"}, {"EXIT", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"Exit_Capture_Zone", "DLC_Apartments_Drop_Zone_Sounds"}, {"Failure", "DLC_HEIST_HACKING_SNAKE_SOUNDS"}, {"Falling_Crates", "EXILE_1"},
              {"Faster_Bar_Full", "RESPAWN_ONLINE_SOUNDSET"}, {"Faster_Click", "RESPAWN_ONLINE_SOUNDSET"}, {"FestiveGift", "Feed_Message_Sounds"}, {"FIRST_PLACE", "HUD_MINI_GAME_SOUNDSET"}, {"FLIGHT_SCHOOL_LESSON_PASSED", "HUD_AWARDS"}, {"FLYING_STREAM_END_INSTANT", "FAMILY_5_SOUNDS"}, {"FocusIn", "HintCamSounds"}, {"FocusOut", "HintCamSounds"}, {"Friend_Deliver", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS"}, {"Friend_Pick_Up", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS"},
              {"GO", "HUD_MINI_GAME_SOUNDSET"}, {"Goal", "DLC_HEIST_HACKING_SNAKE_SOUNDS"}, {"GOLF_BIRDIE", "HUD_AWARDS"}, {"GOLF_EAGLE", "HUD_AWARDS"}, {"GOLF_HUD_HOLE_IN_ONE_MASTER", "0"}, {"GOLF_HUD_SCORECARD_MASTER", "0"}, {"GOLF_NEW_RECORD", "HUD_AWARDS"}, {"Goon_Paid_Small", "GTAO_Boss_Goons_FM_Soundset"}, {"Grab_Parachute", "BASEJUMPS_SOUNDS"}, {"Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"}, {"Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"},
              {"BBQ_EXPLODE", "JOSH_03_SOUNDSET"}, {"HACKING_CLICK", "0"}, {"HACKING_CLICK_BAD", "0"}, {"HACKING_CLICK_GOOD", "0"}, {"HACKING_MOVE_CURSOR", "0"}, {"Hang_Up", "Phone_SoundSet_Michael"}, {"HIGHLIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"Highlight_Accept", "DLC_HEIST_PLANNING_BOARD_SOUNDS"}, {"Highlight_Cancel", "DLC_HEIST_PLANNING_BOARD_SOUNDS"}, {"Highlight_Error", "DLC_HEIST_PLANNING_BOARD_SOUNDS"}, {"Highlight_Move", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
              {"HIGHLIGHT_NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"Hit", "RESPAWN_ONLINE_SOUNDSET"}, {"Hit_1", "LONG_PLAYER_SWITCH_SOUNDS"}, {"Hit_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET"}, {"Hit_Out", "PLAYER_SWITCH_CUSTOM_SOUNDSET"}, {"HORDE_COOL_DOWN_TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"HUD_FREEMODE_CANCEL_MASTER", "0"}, {"Kill_List_Counter", "GTAO_FM_Events_Soundset"}, {"LEADERBOARD", "HUD_MINI_GAME_SOUNDSET"}, {"Lights_On", "GTAO_MUGSHOT_ROOM_SOUNDS"},
              {"LIMIT", "DLC_APT_YACHT_DOOR_SOUNDS"}, {"Load_Scene", "DLC_Dmod_Prop_Editor_Sounds"}, {"LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"}, {"LOCAL_PLYR_CASH_COUNTER_INCREASE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"}, {"LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET"}, {"Lose_1st", "GTAO_FM_Events_Soundset"}, {"LOSER", "HUD_AWARDS"}, {"Map_Roll_Down", "DLC_HEIST_PLANNING_BOARD_SOUNDS"}, {"Map_Roll_Up", "DLC_HEIST_PLANNING_BOARD_SOUNDS"},
              {"MARKER_ERASE", "HEIST_BULLETIN_BOARD_SOUNDSET"}, {"MARTIN1_DISTANT_TRAIN_HORNS_MASTER", "0"}, {"MEDAL_BRONZE", "HUD_AWARDS"}, {"MEDAL_GOLD", "HUD_AWARDS"}, {"MEDAL_SILVER", "HUD_AWARDS"}, {"MEDAL_UP", "HUD_MINI_GAME_SOUNDSET"}, {"Menu_Accept", "Phone_SoundSet_Default"}, {"Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"}, {"MP_5_SECOND_TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"MP_AWARD", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
              {"MP_Flash", "WastedSounds"}, {"MP_IDLE_KICK", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"MP_IDLE_TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"MP_Impact", "WastedSounds"}, {"MP_RANK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"MP_WAVE_COMPLETE", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"NAV", "HUD_AMMO_SHOP_SOUNDSET"}, {"Nav_Arrow_Ahead", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"}, {"Nav_Arrow_Behind", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"},
              {"Nav_Arrow_Left", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"}, {"Nav_Arrow_Right", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"}, {"NAV_LEFT_RIGHT", "HUD_FREEMODE_SOUNDSET"}, {"NAV_UP_DOWN", "HUD_FREEMODE_SOUNDSET"}, {"Near_Miss_Counter_Reset", "GTAO_FM_Events_Soundset"}, {"NO", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"Object_Collect_Player", "GTAO_FM_Events_Soundset"}, {"Object_Dropped_Remote", "GTAO_FM_Events_Soundset"}, {"Off_High", "MP_RADIO_SFX"},
              {"OK", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"ON", "NOIR_FILTER_SOUNDS"}, {"On_Call_Player_Join", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"}, {"Oneshot_Final", "MP_MISSION_COUNTDOWN_SOUNDSET"}, {"OOB_Cancel", "GTAO_FM_Events_Soundset"}, {"OOB_Start", "GTAO_FM_Events_Soundset"}, {"OPEN_WINDOW", "LESTER1A_SOUNDS"}, {"OPENED", "MP_PROPERTIES_ELEVATOR_DOORS"}, {"OTHER_TEXT", "HUD_AWARDS"}, {"Out_Of_Area", "DLC_Lowrider_Relay_Race_Sounds"},
              {"Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"}, {"Paper_Shuffle", "DLC_HEIST_PLANNING_BOARD_SOUNDS"}, {"Parcel_Vehicle_Lost", "GTAO_FM_Events_Soundset"}, {"Payment_Non_Player", "DLC_HEISTS_GENERIC_SOUNDS"}, {"Payment_Player", "DLC_HEISTS_GENERIC_SOUNDS"}, {"Pen_Tick", "DLC_HEIST_PLANNING_BOARD_SOUNDS"}, {"PERSON_SCROLL", "HEIST_BULLETIN_BOARD_SOUNDSET"}, {"PERSON_SELECT", "HEIST_BULLETIN_BOARD_SOUNDSET"},
              {"Phone_Generic_Key_02", "HUD_MINIGAME_SOUNDSET"}, {"PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"Pin_Bad", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"}, {"PIN_BUTTON", "ATM_SOUNDS"}, {"Pin_Centred", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"}, {"Pin_Good", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"}, {"PIPES_LAND", "CONSTRUCTION_ACCIDENT_1_SOUNDS"}, {"Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds"}, {"Place_Prop_Success", "DLC_Dmod_Prop_Editor_Sounds"},
              {"Player_Collect", "DLC_PILOT_MP_HUD_SOUNDS"}, {"Player_Enter_Line", "GTAO_FM_Cross_The_Line_Soundset"}, {"Player_Exit_Line", "GTAO_FM_Cross_The_Line_Soundset"}, {"Power_Down", "DLC_HEIST_HACKING_SNAKE_SOUNDS"}, {"Pre_Screen_Stinger", "DLC_HEISTS_FAILED_SCREEN_SOUNDS"}, {"PS2A_MONEY_LOST", "PALETO_SCORE_2A_BANK_SS"}, {"PURCHASE", "HUD_LIQUOR_STORE_SOUNDSET"}, {"Put_Away", "Phone_SoundSet_Michael"}, {"QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
              {"QUIT_WHOOSH", "HUD_MINI_GAME_SOUNDSET"}, {"RACE_PLACED", "HUD_AWARDS"}, {"RAMP_DOWN", "TRUCK_RAMP_DOWN"}, {"RAMP_UP", "TRUCK_RAMP_DOWN"}, {"RANK_UP", "HUD_AWARDS"}, {"REMOTE_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"}, {"REMOTE_PLYR_CASH_COUNTER_INCREASE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS"}, {"Reset_Prop_Position", "DLC_Dmod_Prop_Editor_Sounds"}, {"RESTART", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"RETRY", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
              {"ROBBERY_MONEY_TOTAL", "HUD_FRONTEND_CUSTOM_SOUNDSET"}, {"ROPE_CUT", "ROPE_CUT_SOUNDSET"}, {"ROUND_ENDING_STINGER_CUSTOM", "CELEBRATION_SOUNDSET"}, {"Save_Scene", "DLC_Dmod_Prop_Editor_Sounds"}, {"SCOPE_UI_MASTER", "0"}, {"ScreenFlash", "WastedSounds"}, {"SCREEN_SWIPE", "CELEBRATION_SWIPE"}, {"SELECT", "HUD_FREEMODE_SOUNDSET"}, {"Select_Placed_Prop", "DLC_Dmod_Prop_Editor_Sounds"}, {"Shard_Disappear", "GTAO_FM_Events_Soundset"},
              {"SHOOTING_RANGE_ROUND_OVER", "HUD_AWARDS"}, {"Short_Transition_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET"}, {"Short_Transition_Out", "PLAYER_SWITCH_CUSTOM_SOUNDSET"}, {"SKIP", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"Start", "DLC_HEIST_HACKING_SNAKE_SOUNDS"}, {"STUN_COLLECT", "MINUTE_MAN_01_SOUNDSET"}, {"Success", "DLC_HEIST_HACKING_SNAKE_SOUNDS"}, {"Swap_Sides", "DLC_HALLOWEEN_FVJ_Sounds"}, {"SWING_SHUT", "GTAO_APT_DOOR_DOWNSTAIRS_GLASS_SOUNDS"},
              {"Tattooing_Oneshot", "TATTOOIST_SOUNDS"}, {"Tattooing_Oneshot_Remove", "TATTOOIST_SOUNDS"}, {"Team_Capture_Start", "GTAO_Magnate_Yacht_Attack_Soundset"}, {"TENNIS_MATCH_POINT", "HUD_AWARDS"}, {"TENNIS_POINT_WON", "HUD_AWARDS"}, {"TextHit", "WastedSounds"}, {"TOGGLE_ON", "HUD_FRONTEND_DEFAULT_SOUNDSET"}, {"Turn", "DLC_HEIST_HACKING_SNAKE_SOUNDS"}, {"UNDER_THE_BRIDGE", "HUD_AWARDS"}, {"WAYPOINT_SET", "HUD_FRONTEND_DEFAULT_SOUNDSET"},
              {"WEAPON_ATTACHMENT_EQUIP", "HUD_AMMO_SHOP_SOUNDSET"}, {"WEAPON_ATTACHMENT_UNEQUIP", "HUD_AMMO_SHOP_SOUNDSET"}, {"WEAPON_PURCHASE", "HUD_AMMO_SHOP_SOUNDSET"}, {"WEAPON_SELECT_ARMOR", "HUD_AMMO_SHOP_SOUNDSET"}, {"Whistle", "DLC_TG_Running_Back_Sounds"}, {"Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS"}, {"Whoosh_1s_R_to_L", "MP_LOBBY_SOUNDS"}, {"WIN", "HUD_AWARDS"}, {"Zone_Enemy_Capture", "DLC_Apartments_Drop_Zone_Sounds"},
              {"Zone_Neutral", "DLC_Apartments_Drop_Zone_Sounds"}, {"Zone_Team_Capture", "DLC_Apartments_Drop_Zone_Sounds"}, {"Zoom_In", "DLC_HEIST_PLANNING_BOARD_SOUNDS"}, {"Zoom_Left", "DLC_HEIST_PLANNING_BOARD_SOUNDS"}, {"Zoom_Out", "DLC_HEIST_PLANNING_BOARD_SOUNDS"}, {"Zoom_Right", "DLC_HEIST_PLANNING_BOARD_SOUNDS"}}

-- TODO: Modder Flagging
function modflag_set()
    for i = 1, #int_flags do
        if player.get_modder_flag_text(int_flags[i]) == "Moist Protex you" then
            mod_flag_1 = int_flags[i]
        end
        if player.get_modder_flag_text(int_flags[i]) == "You Kicked" then
            mod_flag_2 = int_flags[i]
        end
        if player.get_modder_flag_text(int_flags[i]) == "Spectating(with Mod)" then
            mod_flag_3 = int_flags[i]
        end
        if player.get_modder_flag_text(int_flags[i]) == "Blacklist" then
            mod_flag_4 = int_flags[i]
        end
        if player.get_modder_flag_text(int_flags[i]) == "Player is a CUNT!" then
            mod_flag_5 = int_flags[i]
        end
    end

    if mod_flag_1 == nil then
        mod_flag_1 = player.add_modder_flag("Moist Protex you")
    end

    if mod_flag_2 == nil then
        mod_flag_2 = player.add_modder_flag("You Kicked")
    end

    if mod_flag_3 == nil then
        mod_flag_3 = player.add_modder_flag("Spectating(with Mod)")
    end

    if mod_flag_4 == nil then
        mod_flag_4 = player.add_modder_flag("Blacklist")
    end

    if mod_flag_5 == nil then
        mod_flag_5 = player.add_modder_flag("Player is a CUNT!")
    end
end
modflag_set()


-- TODO: --------------Setup Player ARRAY------------
function modstart()
    for pid = 0, 32 do
        Modders_DB[pid] = {}
        Modders_DB[pid].flag = nil
        Modders_DB[pid].flags = nil
        Modders_DB[pid].ismod = false
        SessionPlayers[pid] = {}
        SessionPlayers[pid].Name = "nil"
        SessionPlayers[pid].Tags = {}
        SessionPlayers[pid].Scid = 4294967295
        Players[pid] = {}
        -- Tags[pid + 1] = {}
        Players[pid].isHost = false
        Players[pid].isScHost = false
        Players[pid].pulse = false
        Players[pid].isOTR = false
        Players[pid].OTRBlipID = nil
        Players[pid].bounty = false
        Players[pid].bountyvalue = nil
        Players[pid].isUnDead = false
        Players[pid].isPassive = false
        Players[pid].flag = nil
        Players[pid].flags = nil
        Players[pid].ismod = false
        Players[pid].isgod = false
        Players[pid].isvgod = false
        Players[pid].isint = false
        Players[pid].isvis = false
        Players[pid].speed = 0.00
    end
end
modstart()

-- TODO: Feature & Variable Arrays

global_func, globalFeatures, playerFeatures, playerfeatVars = {}, {}, {}, {}
playerFeat = {}
playerFeatParent = {}
playerFeatParent2 = {}
playerFeat1 = {}
playerFeat2 = {}
playerFeat3 = {}
playerFeat4 = {}
Active_menu = nil

-- local Menu Features
globalFeatures.parent = menu.add_feature("Moists Script 2.0.3.7", "parent", 0).id
globalFeatures.Online_Session = menu.add_feature("Online Features", "parent", globalFeatures.parent).id

-- TODO: Feature Parents
playersFeature = menu.add_feature("Online Players", "parent", globalFeatures.Online_Session, function(feat)
    Active_menu = nil
    OSD_Debug2.on = false

end)

Recent = menu.add_feature("Recent Players", "parent", globalFeatures.Online_Session).id
God_Threads_Created = menu.add_feature("PlayerCheck threads", "parent", globalFeatures.Online_Session)
God_Threads_Created.hidden = true

globalFeatures.lobby = menu.add_feature("Online Session", "parent", globalFeatures.Online_Session).id
globalFeatures.protex = menu.add_feature("Online Protection", "parent", globalFeatures.Online_Session).id
-- session
globalFeatures.kick = menu.add_feature("Session Kicks", "parent", globalFeatures.Online_Session).id
globalFeatures.troll = menu.add_feature("Troll Features", "parent", globalFeatures.lobby).id
SoundAnnoyances = menu.add_feature("Sound Annoyances", "parent", globalFeatures.troll)
globalFeatures.parentID = menu.add_feature("Blacklist", "parent", globalFeatures.protex).id
globalFeatures.orbital = menu.add_feature("Orbital Room Block", "parent", globalFeatures.protex).id
globalFeatures.glitch = menu.add_feature("Block Glitch Spots", "parent", globalFeatures.protex).id

-- Player
globalFeatures.self = menu.add_feature("Player Features", "parent", globalFeatures.parent).id
globalFeatures.self_ped_combat = menu.add_feature("Combat Features", "parent", globalFeatures.parent).id
globalFeatures.self_ped = menu.add_feature("Ped Features", "parent", globalFeatures.self).id
globalFeatures.self_veh = menu.add_feature("Vehicle Features", "parent", globalFeatures.self).id
globalFeatures.self_quickstat = menu.add_feature("Player Stats", "parent", globalFeatures.self).id
globalFeatures.self_options = menu.add_feature("Player Options", "parent", globalFeatures.self).id
globalFeatures.self_wep = menu.add_feature("Player Weapons", "parent", globalFeatures.self_ped).id
-- stats
globalFeatures.self_statcheck = menu.add_feature("Player Stat Checks", "parent", globalFeatures.self_quickstat).id

globalFeatures.self_statsetup = menu.add_feature("Player Stat Setup", "parent", globalFeatures.self_quickstat, function()

    local stat_hash, curval, valu, value_set, stat
    stat = Get_Last_MP("PLAYER_MENTAL_STATE")
    stat_hash = gameplay.get_hash_key(stat)
    curval = stats.stat_get_float(stat_hash, 0)
    valu = math.ceil(curval)
    value_set = tonumber(valu)

    mental_statset.value = value_set
end).id

globalFeatures.quick_stats = menu.add_feature("Quick Stat Setups", "parent", globalFeatures.self_quickstat, function(feat)
    moist_notify("for casino heist quick stat setup\n", "ensure to pay for heist setup first")
    moist_notify("cooldown can be removed running the setup first\n", "ensure to reapply after paying for it")

end).id

-- world
globalFeatures.cleanup = menu.add_feature("Clean Shit Up!", "parent", globalFeatures.Online_Session).id
globalFeatures.entity_removal = menu.add_feature("World Clean-up", "parent", globalFeatures.cleanup).id
globalFeatures.World = menu.add_feature("World Options", "parent", globalFeatures.Online_Session).id
globalFeatures.Weather = menu.add_feature("Weather Overide", "parent", globalFeatures.World).id

menu.add_feature("Reset Override Weather", "action", globalFeatures.Weather, function(feat)
    gameplay.clear_cloud_hat()
    gameplay.clear_override_weather()
end)

menu.add_feature("Clear Cloud Hat", "action", globalFeatures.Weather, function(feat)
    gameplay.clear_cloud_hat()
end)

weather = {"FUCK", "Extra Sunny", "Clear", "Clouds", "Smog", "Fog", "Clouds", "Rain", "Thunder", "Clearing", "Neutral", "Snow", "Blizzard", "Snow Light", "Xmas", "Halloween", "Psychedelic Screen Fuck"}

for i = 1, #weather do
    menu.add_feature(weather[i], "action", globalFeatures.Weather, function(feat)
        local i = i - 2
        gameplay.set_override_weather(i)
    end)
end

globalFeatures.Wave = menu.add_feature("World Wave Modifiers", "parent", globalFeatures.World).id

-- spam

globalFeatures.Moist_Spam = menu.add_feature("Chat Spam", "parent", globalFeatures.Online_Session).id
globalFeatures.Preset_Chat = menu.add_feature("Preset Spam", "parent", globalFeatures.Moist_Spam).id
globalFeatures.custom_Chat = menu.add_feature("Your Custom Spam", "parent", globalFeatures.Moist_Spam).id
globalFeatures.Preset_RUS = menu.add_feature("Russian Spam", "parent", globalFeatures.Moist_Spam).id
globalFeatures.Spam_Options = menu.add_feature("Spam Options", "parent", globalFeatures.Moist_Spam).id
globalFeatures.Script_loader = menu.add_feature("Other Scripts", "parent", globalFeatures.parent).id
globalFeatures.moist_test = menu.add_feature("Function Testing", "parent", globalFeatures.parent)
globalFeatures.moist_test.hidden = true
-- options
globalFeatures.moistopt = menu.add_feature("Options", "parent", globalFeatures.parent).id

-- TODO: save settings
menu.add_feature("Save settings", "action", globalFeatures.moistopt, function(feat)
    SaveSettings()
    moist_notify("Settings: ", "saved!")
end)

menu.add_feature("Clear all Queued Notifys", "action", globalFeatures.moistopt, function(feat)
    if ui.get_current_notification() ~= -1 then
        -- if y >= v then
        print("count before removal: " .. ui.get_current_notification())
        for i = 0, ui.get_current_notification() do
            ui.remove_notification(i)

        end
        print("Post Removal Count: " .. ui.get_current_notification())
    end

end)

globalFeatures.moist_hotkeys = menu.add_feature("Hotkeys", "parent", globalFeatures.moistopt).id

-- TODO: Save Settings Hotkey	
SaveOptions_Hotkey = menu.add_feature("Options Save HotKey", "toggle", globalFeatures.moist_hotkeys, function(feat)
    if not feat.on then
        return HANDLER_POP
    end

    local key = MenuKey()

    key:push_str("LCONTROL")

    key:push_str("LSHIFT")

    key:push_str("s")
    if key:is_down() then
        SaveSettings()
        moist_notify("Current Settings\n", "Saved")
        system.wait(1200)
    end
    system.yield(10)
    return HANDLER_CONTINUE
end)
SaveOptions_Hotkey.on = true

clearNotifyLimit = menu.add_feature("Notify Limiter", "toggle", globalFeatures.moistopt, function(feat)
    if feat.on then
        if ui.get_current_notification() ~= -1 then
            ui.remove_notification(ui.get_current_notification())
        end
        system.yield(10)
        return HANDLER_CONTINUE
    end

end)
clearNotifyLimit.on = Settings["NotifyLimitON"]

notifyclear_hotkey = menu.add_feature("clear Spammed notifications Hotkey", "toggle", globalFeatures.moist_hotkeys, function(feat)
    if not feat.on then
        return HANDLER_POP
    end

    local keys = {"LCONTROL", "c", "n"}
    local key = MenuKey()

    key:push_str(keys[1])
    if key:is_down() then
        key:push_str(keys[2])
        if key:is_down() then
            key:push_str(keys[3])
            if key:is_down() then
                SpamNotifyClear()
            end
        end
    end
    system.wait(1000)
    return HANDLER_CONTINUE

end)
notifyclear_hotkey.on = true

globalFeatures.moist_perf = menu.add_feature("Performance Options", "parent", globalFeatures.moistopt).id

playerlistloop = menu.add_feature("Player List Loop Delay ms:", "autoaction_value_i", globalFeatures.moist_perf, function(feat)
    Settings["playerlist_loop"] = feat.value
    print(feat.value)
end)
playerlistloop.max = 50
playerlistloop.min = 0
playerlistloop.mod = 1
playerlistloop.value = Settings["playerlist_loop"]

loopfeatdelay = menu.add_feature("Other FeatureLoops Delay ms:", "autoaction_value_i", globalFeatures.moist_perf, function(feat)
    Settings["loop_feat_delay"] = feat.value
end)
loopfeatdelay.max = 600
loopfeatdelay.min = 0
loopfeatdelay.mod = 1
loopfeatdelay.value = Settings["loop_feat_delay"]

ScriptEvent_delay = menu.add_feature("Scriptevent Delay ms:", "autoaction_value_i", globalFeatures.moist_perf, function(feat)
    Settings["ScriptEvent_delay"] = feat.value
end)
ScriptEvent_delay.max = 500
ScriptEvent_delay.min = 0
ScriptEvent_delay.mod = 1
ScriptEvent_delay.value = Settings["ScriptEvent_delay"]

ToBeNotify = menu.add_feature("Script Notify Me", "toggle", globalFeatures.moistopt, function(feat)
    if not feat.on then
        Settings["Notify_Me"] = false
        return HANDLER_POP
    end
    Settings["Notify_Me"] = true
end)
ToBeNotify.on = Settings["Notify_Me"]

-- TODO: ---------------------Moist Test Shit-----------------
globalFeatures.moist_tools = menu.add_feature("Moist Test Shit", "parent", globalFeatures.moistopt)
globalFeatures.moist_tools.hidden = true

ply_seat = menu.add_feature("Set your seat (default front)", "action_value_i", globalFeatures.self_veh, function(feat)
    local pid = player.player_id()
    local pped = player.get_player_ped(pid)
    local veh = ped.get_vehicle_ped_is_using(pped)
    if veh == nil or 0 then
        veh = player.get_player_vehicle(player.player_id())
        ped.set_ped_into_vehicle(pped, veh, feat.value)
    end
end)
ply_seat.max = 14
ply_seat.min = -1
ply_seat.value = -1

local health, infoA, infoB
text1, text2, text3, text4 = "", "", "", ""
Active_scriptmenu = menu.add_feature("Active Script item Player info", "toggle", globalFeatures.moistopt, function(feat)
    Settings["playerscriptinfo"] = true
    if feat.on then
        local pid, intchk = Active_menu, ""
        if Active_menu ~= nil then

            dist = Get_Distance3D(pid)
            if dist < 1000.00 then
                dist = "~r~~h~" .. dist
            end
            local info = tostring(infoB .. "\nDistance:\t\t " .. dist)
            update_osd_text2(health, infoA, info)
            if Players[pid].isint == false then
                intchk = "~h~~g~False"
            end
            if Players[pid].isint == true then
                intchk = "~h~~r~True"
            end
            text4 = "~h~~b~Interior Check:~w~ " .. intchk
        end

        system.yield(Settings["loop_feat_delay"])
        return HANDLER_CONTINUE
    end
    Settings["playerscriptinfo"] = false
    return HANDLER_POP
end)
Active_scriptmenu.on = Settings["playerscriptinfo"]

moist_tools_hotkey = menu.add_feature("Moist Test Shit Hotkey", "toggle", globalFeatures.moist_tools.id, function(feat)
    if feat.on then

        local key = MenuKey()
        key:push_str("LCONTROL")
        key:push_str("LSHIFT")
        key:push_str("h")
        if key:is_down() then
            globalFeatures.moist_tools.hidden = not globalFeatures.moist_tools.hidden
            system.wait(1200)
        end
        system.yield(10)
        return HANDLER_CONTINUE
    end
    return HANDLER_POP
end)
moist_tools_hotkey.on = true

globalFeatures.moistMkropt = menu.add_feature("Marker options", "parent", globalFeatures.moistopt).id
globalFeatures.notifyParent = menu.add_feature("Notify Customisation", "parent", globalFeatures.moistopt).id
logging = menu.add_feature("Logging Shit", "parent", globalFeatures.moistopt)

-- TODO: Modder Flag logs

Auto_Off_RAC = menu.add_feature("Disable RAC Detection Experimental", "toggle", globalFeatures.moistopt)
Auto_Off_RAC.on = False

function RAC_OFF(pid)
    if not Auto_Off_RAC.on then
        return
    end
    local flags = player.get_player_modder_flags(pid)
    local flag_ends = player.get_modder_flag_ends(player.get_player_modder_flags(pid))
    local flag_name = player.get_modder_flag_text(flags)
    if flag_name == "RAC" then
        player.unset_player_as_modder(pid, 512)
    end
end

-- TODO: God Check Thread Shit

NotifyGod = menu.add_feature("Notify God Player/Vehicle", "toggle", globalFeatures.moistopt, function(feat)
    if not feat.on then
        Settings["GodCheckNotif"] = false
        return HANDLER_POP
    end
    Settings["GodCheckNotif"] = true
    notifyclear.on = true
    return HANDLER_POP
end)
NotifyGod.on = Settings["GodCheckNotif"]

function clearnotif()
    for pid = 0, 32 do
        Players[pid].isvgod = false
        Players[pid].isgod = false
    end
end

notifyclear = menu.add_feature("clear notify", "toggle", globalFeatures.moistopt, function(feat)
    Settings["GodCheckNotif"] = true
    if feat.on then
        clearnotif()
        local delay = 0
        repeat
            delay = delay + 1
            system.wait(40000)
        until delay == 10
        clearnotif()
        system.yield(Settings["loop_feat_delay"])
        return HANDLER_CONTINUE
    end
    Settings["GodCheckNotif"] = false
    return HANDLER_POP
end)
notifyclear.on = Settings["GodCheckNotif"]
notifyclear.hidden = false

God_thread, God_thread1 = {
    pid = {}
}, {
    pid = {}
}
feat = {}

delete_God_thread = function(feat, data)

    menu.create_thread(function(id)
        menu.delete_feature(id)
    end, feat.id)
end

function God_Check_pid(pid)
    God_thread[pid] = {}
    local player_id = pid
    God_thread[pid] = menu.create_thread(God_Check_pid_thread, {
        pid = player_id
    })
    local i = #feat + 1
    feat[i] = menu.add_feature("Delete God Check Thread: " .. pid, "action", God_Threads_Created.id, delete_God_thread)
    feat[i].data = {
        thread = God_thread[pid]
    }
end

function God_Check1_pid(pid)
    God_thread1[pid] = {}
    local player_id = pid
    God_thread1[pid] = menu.create_thread(God_Check1_pid_thread, {
        pid = player_id
    })
    local i = #feat + 1
    feat[i] = menu.add_feature("Delete God Check 2 Thread: " .. pid, "action", God_Threads_Created.id, delete_God_thread)
    feat[i].data = {
        thread = God_thread1[pid]
    }
end

God_Check1_pid_thread = function(context)
    while true do
        local pped = player.get_player_ped(context.pid)
        if player.is_player_valid(context.pid) ~= false and context.pid ~= player.player_id() then

            if ped.is_ped_shooting(pped) then
                if player.is_player_god(context.pid) or player.is_player_vehicle_god(context.pid) and player.is_player_playing(context.pid) and not entity.is_entity_dead(pped) then
                    system.wait(10)
                    if NotifyGod.on and not Players[context.pid].isgod then
                        ui.notify_above_map("~h~~b~" .. SessionPlayers[context.pid].Name .. "~h~~r~God Check fail\n~y~Shooting While God Mode", "~l~~h~Ω MoistsScript 2.0.3.7\n~p~~h~Moist Edition", 119)
                        Players[context.pid].isgod = true
                    end
                end
            end
        end
        system.wait(10)
    end
    return HANDLER_CONTINUE
end

God_Check_pid_thread = function(context)

    while true do
        if player.is_player_valid(context.pid) ~= false and context.pid ~= player.player_id() then
            local pped, plyveh
            if player.is_player_god(context.pid) or player.is_player_vehicle_god(context.pid) then
                system.wait(20)
                local Entity = ""
                pped = player.get_player_ped(context.pid)
                if pped ~= nil or pped ~= 0 then
                    local pos = v3()
                    plyveh = player.get_player_vehicle(context.pid)
                    if Players[context.pid].isint then
                        return
                    end
                    if player.is_player_god(context.pid) or player.is_player_vehicle_god(context.pid) then
                        system.wait(1000)
                        if not Players[context.pid].isint then
                            if player.is_player_god(context.pid) or player.is_player_vehicle_god(context.pid) then
                                if tracking.playerped_speed1[context.pid + 1] >= 21 then
                                    if NotifyGod.on and not Players[context.pid].isgod then
                                        Entity = "Player God mode"
                                        Players[context.pid].isgod = true
                                        ui.notify_above_map("~h~~b~" .. Entity .. "\n~y~" .. context.pid .. " : " .. SessionPlayers[context.pid].Name, "~l~~h~Ω MoistsScript 2.0.3.7\n~p~~h~Moist Edition", 119)
                                    end
                                end
                            end
                            plyveh = player.get_player_vehicle(context.pid)
                            if plyveh ~= nil or plyveh ~= 0 then
                                if Players[context.pid].isint then
                                    return
                                end
                                if player.is_player_vehicle_god(context.pid) then
                                    if tracking.playerped_speed1[context.pid + 1] >= 21 then
                                        system.wait(1000)
                                        if player.is_player_vehicle_god(context.pid) then
                                            if NotifyGod.on and not Players[context.pid].isvgod then
                                                Entity = "Player Vehicle God mode"
                                                Players[context.pid].isvgod = true
                                                ui.notify_above_map("~h~~b~" .. Entity .. "\n~y~" .. context.pid .. " : " .. SessionPlayers[context.pid].Name, "~l~~h~Ω MoistsScript 2.0.3.7\n~p~~h~Moist Edition", 119)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        system.wait(10)
    end
    return HANDLER_CONTINUE
end

-- TODO: *************MODDER FLAG LOGS
function modderflag(pid)
    if not Modders_DB[pid].ismod then
        local flags = player.get_player_modder_flags(pid)
        local flaghex = string.format("%x", flags)
        print(flaghex)
        local flag_ends = player.get_modder_flag_ends(player.get_player_modder_flags(pid))
        local flag_name = player.get_modder_flag_text(flags)

        Modders_DB[pid].flag = flag_name
        Modders_DB[pid].flags = flags
        print(Modders_DB[pid].flags)
        Modders_DB[pid].ismod = true
        local name = player.get_player_name(pid)
        Debug_Out(string.format("Modder:" .. name .. "\nmodder Flags:" .. flag_name))
    elseif Modders_DB[pid].ismod then
        test = player.get_player_modder_flags(pid)
        -- print(test)
        -- print(Modders_DB[pid].flags)
        if Modders_DB[pid].flags ~= test then
            player.unset_player_as_modder(pid, Modders_DB[pid].flags)
            -- return end
            local flags = player.get_player_modder_flags(pid)
            local flaghex = string.format("%x", flags)
            print(flaghex)
            local flag_ends = player.get_modder_flag_ends(player.get_player_modder_flags(pid))
            local flag_name = player.get_modder_flag_text(flags)

            Modders_DB[pid].flag = flag_name
            Modders_DB[pid].flags = flags
            Modders_DB[pid].ismod = true
            local name = player.get_player_name(pid)
            Debug_Out(string.format("Modder:" .. name .. "\nmodder Flags:" .. flag_name))
        end
    end
    return HANDLER_POP
end

-- TODO: Player Feature Parents
playerfeatVars.parent = menu.add_player_feature("Moists Script 2.0.3.7", "parent", 0).id
local Player_Tools = menu.add_player_feature("Player Tools", "parent", playerfeatVars.parent).id
local vehicle_Tools = menu.add_player_feature("Vehicle Tools", "parent", playerfeatVars.parent).id
local BountyId = menu.add_player_feature("Bounty Options", "parent", playerfeatVars.parent).id
playerfeatVars.fm = menu.add_player_feature("Force Player to Mission", "parent", playerfeatVars.parent).id
playerfeatVars.spam_sms = menu.add_player_feature("SMS Spam", "parent", playerfeatVars.parent).id
playerfeatVars.Preset_sms = menu.add_player_feature("SMS Spam Presets", "parent", playerfeatVars.spam_sms).id
playerfeatVars.Preset_RUS = menu.add_player_feature("Russian Spam Presets", "parent", playerfeatVars.Preset_sms).id

-- TODO: Chat Spam

ChatSpamOn = false

function load_SpamData()
    if not utils.file_exists(Paths.Spamtxt_Data) then
        return
    end
    for line in io.lines(Paths.Spamtxt_Data) do
        spam_presets[#spam_presets + 1] = {line:sub(1, 12), line}
    end
end
load_SpamData()

for i = 1, #russian_spam do
    menu.add_player_feature("sms: " .. russian_spam[i][1], "toggle", playerfeatVars.Preset_RUS, function(feat, pid)
        if feat.on then
            text = tostring(russian_spam[i][2])

            player.send_player_sms(pid, text)

            return HANDLER_CONTINUE
        end
    end)
end

for i = 1, #russian_spam do

    spammRU.var[i] = menu.add_feature(i .. ": " .. russian_spam[i][1], "value_i", globalFeatures.Preset_RUS, function(feat)
        if feat.on then
            ChatSpamOn = true
            text = tostring(russian_spam[i][2])

            network.send_chat_message(text, false)
            system.wait(feat.value)
            return HANDLER_CONTINUE
        end
        ChatSpamOn = false
        return HANDLER_POP
    end)
    spammRU.var[i].max = 1000
    spammRU.var[i].min = 0
    spammRU.var[i].value = Settings["spam_wait"]

end

for i = 1, #spam_preset do
    menu.add_player_feature("sms: " .. spam_preset[i][1], "toggle", playerfeatVars.spam_sms, function(feat, pid)
        if feat.on then
            text = tostring(spam_preset[i][2])

            player.send_player_sms(pid, text)

            return HANDLER_CONTINUE
        end
    end)
end

for i = 1, #spam_preset do

    spamm.var[i] = menu.add_feature(i .. ": " .. spam_preset[i][1], "value_i", globalFeatures.Preset_Chat, function(feat)
        if feat.on then
            ChatSpamOn = true
            text = tostring(spam_preset[i][2])

            network.send_chat_message(text, false)
            system.wait(feat.value)
            return HANDLER_CONTINUE
        end
        ChatSpamOn = false
        return HANDLER_POP
    end)
    spamm.var[i].max = 1000
    spamm.var[i].min = 0
    spamm.var[i].value = Settings["spam_wait"]

end

for i = 1, #spam_presets do

    menu.add_player_feature("sms: " .. spam_presets[i][1], "toggle", playerfeatVars.spam_sms, function(feat, pid)
        if feat.on then
            text = tostring(spam_presets[i][2])

            player.send_player_sms(pid, text)

            return HANDLER_CONTINUE
        end
    end)
end

for i = 1, #spam_presets do

    local pfeat = string.format("preset" .. i)
    pfeat = menu.add_feature(i .. ": " .. spam_presets[i][1], "parent", globalFeatures.custom_Chat)
    pfeat.hidden = false

    spamm.var[i] = menu.add_feature("Send Chat Spam", "value_i", pfeat.id, function(feat)
        if feat.on then
            ChatSpamOn = true

            text = tostring(spam_presets[i][2])

            network.send_chat_message(text, false)
            system.wait(feat.value)
            return HANDLER_CONTINUE
        end
        ChatSpamOn = false
        return HANDLER_POP
    end)
    spamm.var[i].max = 1000
    spamm.var[i].min = 0
    spamm.var[i].value = Settings["spam_wait"]

    spamm.var[i] = menu.add_feature("Delete Chat Spam", "action", pfeat.id, function(feat)
        spam_presets[i][1] = nil
        spam_presets[i][2] = nil

        moist_notify("remember to rewrite presets to save", "\nFound in spam options")
        pfeat.hidden = true
    end)

end

menu.add_feature("no text spam", "toggle", globalFeatures.Moist_Spam, function(feat)
    if feat.on then
        ChatSpamOn = true

        network.send_chat_message(" ", false)

        return HANDLER_CONTINUE
    end
    ChatSpamOn = false
    return HANDLER_POP
end)

menu.add_feature("3-2-1-GO", "action", globalFeatures.Moist_Spam, function(feat)

    local count = 4
    for i = 0, 3 do
        count = count - 1
        if count == 0 then
            count = "GO"
        end
        network.send_chat_message(count, false)
        system.yield(1000)

    end
    return HANDLER_POP
end)

menu.add_feature("Send Clipboard Contents", "action", globalFeatures.Moist_Spam, function(feat)
    ChatSpamOn = true
    text = utils.from_clipboard()
    network.send_chat_message(text, false)

    ChatSpamOn = false
    return HANDLER_POP

end)

menu.add_feature("String Char randomised spam", "toggle", globalFeatures.Moist_Spam, function(feat)
    ChatSpamOn = true
    if feat.on then
        local a, b, c
        a = math.random(1, 254)

        local a1 = math.random(1, 254)

        local text = string.char(a, 255, 255) .. " " .. string.char(a, a1, 255) .. " " .. string.char(a, a1, a1)
        network.send_chat_message(text, false)
        return HANDLER_CONTINUE
    end
    ChatSpamOn = false
    return HANDLER_POP

end)

menu.add_feature("String Char randomised delayspam", "toggle", globalFeatures.Moist_Spam, function(feat)
    ChatSpamOn = true
    if feat.on then
        local a, b, c
        a = math.random(1, 254)

        local a1 = math.random(1, 254)

        local text = string.char(a, 255, 255) .. " " .. string.char(a, a1, 255) .. " " .. string.char(a, a1, a1)
        network.send_chat_message(text, false)
        system.wait(100)
        return HANDLER_CONTINUE
    end
    ChatSpamOn = false
    return HANDLER_POP

end)

spam_delay = menu.add_feature("Set Delay in ms", "action_value_i", globalFeatures.Spam_Options, function(feat)

    Settings["spam_wait"] = feat.value

end)
spam_delay.max = 1000
spam_delay.min = 0
spam_delay.value = Settings["spam_wait"]

menu.add_feature("Add Custom Preset", "action", globalFeatures.Spam_Options, function(feat)

    local r, s = input.get("Input Spam Preset Text 96 characters max", "", 96, 0)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end

    text = tostring(s .. "\n")
    system.wait(1)
    local file = io.open(Paths.Cfg .. "\\Moists_Spamset.ini", "a")
    system.wait(1)
    io.output(file)

    io.write(text)
    io.close()
    spam_presets[#spam_presets + 1] = {text:sub(1, 12), text}

    local y = #spam_presets
    for i = y, #spam_presets do
        local pfeat = string.format("preset" .. i)
        pfeat = menu.add_feature(i .. ": " .. spam_presets[i][1], "parent", globalFeatures.custom_Chat)
        pfeat.hidden = false

        spamm.var[i] = menu.add_feature("Send Chat Spam", "value_i", pfeat.id, function(feat)
            if feat.on then
                ChatSpamOn = true

                text = tostring(spam_presets[i][2])

                network.send_chat_message(text, false)
                system.wait(feat.value)
                return HANDLER_CONTINUE
            end
            ChatSpamOn = false
            return HANDLER_POP
        end)
        spamm.var[i].max = 1000
        spamm.var[i].min = 0
        spamm.var[i].value = Settings["spam_wait"]

        spamm.var[i] = menu.add_feature("Delete Chat Spam", "action", pfeat.id, function(feat)
            spam_presets[i][1] = nil
            spam_presets[i][2] = nil

            moist_notify("rember to rewrite presets to save", "\nFound in spam options")
            pfeat.hidden = true
        end)
        menu.add_player_feature("sms: " .. spam_presets[i][1], "toggle", playerfeatVars.spam_sms, function(feat, pid)
            if feat.on then
                text = tostring(spam_presets[i][2])

                player.send_player_sms(pid, text)

                return HANDLER_CONTINUE
            end
        end)
    end
end)

spam_cus_long = menu.add_feature("Rewrite Preset file", "action", globalFeatures.Spam_Options, function(feat)
    local file = io.open(Paths.Cfg .. "\\Moists_Spamset.ini", "w+")
    system.wait(1)
    io.output(file)
    io.write("")
    io.close()
    local File = io.open(Paths.Cfg .. "\\Moists_Spamset.ini", "a")
    io.output(File)
    for i = 1, #spam_presets do
        if spam_presets[i][1] or spam_presets[i][2] ~= nil then
            io.write(string.format(spam_presets[i][2] .. "\n"))
        end
    end
    io.close()
end)

-- TODO: ScriptLoader

function scriptloader()
    ScriptFiles = {}
    ScriptFeat = {}
    loadedScripts = {}
    local scriptload = Paths.Cfg .. "\\scriptloader.ini"

    if not utils.file_exists(scriptload) then
        io.open(scriptload, "w+")
        io.output(scriptload)
        io.write("")
        io.close()
    end

    menu.add_feature("Save Loaded Scripts", "action", globalFeatures.Script_loader, function(feat)
        io.open(scriptload, "w+")
        io.output(scriptload)
        for i = 1, #loadedScripts do
            io.write(loadedScripts[i] .. "\n")
        end
        io.close()
    end)

    function GetScripts()
        local files = utils.get_all_files_in_directory(Paths.Root .. "\\scripts\\", "lua")
        for i = 1, #files do

            ScriptFiles[#ScriptFiles + 1] = files[i]
        end
    end
    GetScripts()

    for i = 1, #ScriptFiles do
        local feat_name, featname, funcname
        feat_name = string.format(ScriptFiles[i])
        featname = {feat_name:sub(1, 6), feat_name}
        ScriptFeat[i] = menu.add_feature(ScriptFiles[i], "action", globalFeatures.Script_loader, function(feat)
            funcname = featname
            LoadScript(ScriptFiles[i], ScriptFeat[i])

        end)
        ScriptFeat[i].hidden = false

    end

    function LoadScript(scriptname, feature)
        local file = Paths.Root .. "\\scripts\\" .. scriptname
        loadedScripts[#loadedScripts + 1] = scriptname

        moist_notify("Script Loaded:", file .. "\nUse Save for autoload next script start")
        local a = assert(loadfile(file))
        feature.hidden = true

        return a()
    end

    for line in io.lines(scriptload) do
        local file = Paths.Root .. "\\scripts\\" .. line
        if utils.file_exists(file) then
            local f = assert(loadfile(file))
            return f()
        end
    end

end
scriptloader()
-- TODO: Recent Player Features
function recentplayerslist()
    Recent_Players = {{
        name = {},
        count = {},
        rid = {},
        nid = {},
        htoken = {},
        DecIP = {}
    }}
    RecentPlayers = {}
    TempBlacklist = {{
        name = {},
        scid = {},
        decip = {},
        nameON = {},
        scidON = {},
        decipON = {}
    }}
    RecentPlayer = {
        Features = {}
    }

    Join_Event_Check = event.add_event_listener("player_join", function(e)
        playerRDB(e.player)
        TempBlacklistCheck(e.player)
        return

    end)

    function TempBlacklistCheck(pid)

        local scid, name, decip
        scid = GetSCID(pid)
        name = player.get_player_name(pid)
        decip = player.get_player_ip(pid)
        for i = 1, #TempBlacklist do
            if TempBlacklist[i].name == name and TempBlacklist[i].nameON == true then
                TempBlacklist_Kick(pid)
            elseif TempBlacklist[i].scid == scid and TempBlacklist[i].scidON == true then
                TempBlacklist_Kick(pid)
            elseif TempBlacklist[i].decip == decip and TempBlacklist[i].decipON == true then
                TempBlacklist_Kick(pid)
            end
        end
    end

    function TempBlacklist_Kick(pid)
        if pid == player.player_id() then
            return
        end
        system.wait(10)
        if network.network_is_host() then
            network.network_session_kick_player(pid)
        elseif not network.network_is_host() then
            script.trigger_script_event(-2120750352, pid, {pid, script.get_global_i(1630317 + (1 + (pid * 595)) + 506)})
            script.trigger_script_event(0xE6116600, pid, {pid, script.get_global_i(1630317 + (1 + (pid * 595)) + 506)})
        end
        network.network_session_kick_player(pid)

    end

    function playerRDB(pid)

        local scid, name, token, tokeen, count, PlyIP
        PlyIP = player.get_player_ip(pid)
        scid = GetSCID(pid)
        playername = player.get_player_name(pid)
        count = 0

        token = player.get_player_host_token(pid)
        tokhex = string.format("%x", token)
        tokeen = tostring(tokhex:sub(1, 8))
        local i = #Recent_Players + 1
        for y = 1, #Recent_Players do

            if Recent_Players[y].rid == scid then
                count = Recent_Players[y].count + 1
                Recent_Players[y].count = count
                ui.notify_above_map("~h~~w~Recently Seen Player:\n~h~~u~" .. playername .. "\n~w~SCID:~h~~u~ " .. scid .. "\nΩ Player Seen Ω " .. count .. " times today", "Recent", 218)
                return
            end
        end

        if i > 1000 then
            Recent_Players = {{
                name = {},
                count = {},
                rid = {},
                nid = {},
                htoken = {},
                DecIP = {}
            }}
        end

        Recent_Players[i] = {}
        RecentPlayer[i] = {}
        RecentPlayer[i].Features = {}
        Recent_Players[i].name = playername
        Recent_Players[i].count = 1
        Recent_Players[i].rid = scid
        Recent_Players[i].DecIP = PlyIP
        Recent_Players[i].nid = network.network_hash_from_player(pid)
        Recent_Players[i].htoken = tokeen

        TempBlacklist[i] = {}
        TempBlacklist[i].nameON = false
        TempBlacklist[i].scidON = false
        TempBlacklist[i].nameON = false
        TempBlacklist[i].decipON = false
        TempBlacklist[i].name = playername
        TempBlacklist[i].scid = scid
        TempBlacklist[i].decip = PlyIP
        Recent_Player(pid, i)
    end

    function Recent_Player(pid, spid)
        if player.is_player_valid(pid) then
            rpid = spid
            local count = spid + 1

            local id = Recent_Players[rpid].rid
            name = tostring(count .. ": " .. Recent_Players[rpid].name)
            id = menu.add_feature(name, "parent", Recent).id
            local scid = Recent_Players[spid].rid
            local npid = Recent_Players[spid].nid
            local i = #RecentPlayer + 1
            menu.add_feature("Players SCID = " .. scid, "action", id, nil)
            menu.add_feature("Players nethash = " .. npid, "action", id, nil)
            menu.add_feature("Copy SCID to Clipboard", "action", id, function(feat)
                utils.to_clipboard(scid)
            end)

            local scid, name, token = (Recent_Players[rpid].rid), (Recent_Players[rpid].name), (Recent_Players[rpid].htoken)

            menu.add_feature("Add Player to Blacklist", "action", id, function(feat)

                AddScid(scid, name)
                LoadBlacklist()
            end)

            RecentPlayer[spid].Features = menu.add_feature("Temp BlacklistPlayer", "parent", id)

            menu.add_feature("Blacklist IP", "toggle", RecentPlayer[spid].Features.id, function(feat)
                if not feat.on then
                    TempBlacklist[spid].decipON = false
                    return HANDLER_POP
                end
                CheckIF_INSession()
                if feat.on then
                    TempBlacklist[spid].decipON = true
                    system.wait(3000)
                    return HANDLER_CONTINUE
                end
            end)

            menu.add_feature("Blacklist SCID", "toggle", RecentPlayer[spid].Features.id, function(feat)
                if not feat.on then
                    TempBlacklist[spid].scidON = false
                    return HANDLER_POP
                end
                CheckIF_INSession()
                if feat.on then
                    TempBlacklist[spid].scidON = true
                    system.wait(3000)
                    return HANDLER_CONTINUE
                end
            end)

            menu.add_feature("Blacklist Name", "toggle", RecentPlayer[spid].Features.id, function(feat)
                if not feat.on then
                    TempBlacklist[spid].nameON = false
                    return HANDLER_POP
                end
                CheckIF_INSession()
                if feat.on then
                    TempBlacklist[spid].nameON = true
                    system.wait(3000)
                    return HANDLER_CONTINUE
                end
            end)

        end

    end

    function CheckIF_INSession()
        for pid = 0, 32 do
            if player.is_player_valid(pid) then
                TempBlacklistCheck(pid)
            end
        end
    end

end
recentplayerslist()

menu.add_player_feature("Save Players Current POS to file", "action", Player_Tools, function(feat, pid)

    local pos, name, r, s
    pos = v3()
    pos = player.get_player_coords(pid)
    name = player.get_player_name(pid)

    r, s = input.get("Enter a Name to Label POS", "Pos from : " .. name, 64, 0)
    if r == 1 then
        return HANDLER_CONTINUE
    end
    if r == 2 then
        return HANDLER_POP
    end
    ui.notify_above_map(string.format("%f, %f, %f", pos.x, pos.y, pos.z), "Players Position", 213)

    savepos(string.format("\nPosition Saved From Player: " .. name .. "\n" .. s .. ",	" .. '{' .. pos.x .. ", " .. pos.y .. ", " .. pos.z .. '}'))
    return HANDLER_POP

end)

savepos = function(text)

    local file = io.open(Paths.Logs .. "\\saveposoutput.txt", "a")
    io.output(file)
    io.write(text)
    io.close()
end

-- TODO: Notify settings
globalFeatures.nottyp = menu.add_feature("Set Notify Variant", "autoaction_value_i", globalFeatures.notifyParent, function(feat)

    notifytype = feat.value
    Settings["NotifyVarDefault"] = feat.value
    notifytype = feat.value
    moist_notify("Test Variant Set:\n", feat.value)
    return HANDLER_POP
end)
globalFeatures.nottyp.max = 6
globalFeatures.nottyp.min = 1
globalFeatures.nottyp.value = Settings["NotifyVarDefault"]

globalFeatures.notify = menu.add_feature("Set Default Notify Color", "autoaction_value_i", globalFeatures.notifyParent, function(feat)
    Settings["NotifyColorDefault"] = feat.value

    preset_color = feat.value
    moist_notify("Test Color:\n", feat.value)
    return HANDLER_POP
end)
globalFeatures.notify.max = 215
globalFeatures.notify.min = 000
globalFeatures.notify.value = Settings["NotifyColorDefault"]

-- TODO: Online Features

menu.add_player_feature("Force Player to Island", "action", 0, function(feat, pid)

    script.trigger_script_event(0x4d8b1e65, pid, {1300962917})

    return HANDLER_POP
end)

-- TODO: Show Spawn option

local Show_Spawn_Options = menu.add_feature("Show & Load SpawnOptions", "toggle", globalFeatures.moistopt, function(feat)
    if not feat.on then
        Settings["showSpawns"] = false
        -- spawnoptions_loaded = false
        return HANDLER_POP
    end
    Settings["showSpawns"] = true
    if not spawnoptions_loaded then
        spawn_parent = menu.add_player_feature("Spawn Options", "parent", playerfeatVars.parent)
        playerfeatVars.b = menu.add_player_feature("Ped Spawns", "parent", spawn_parent.id).id
        load_spawn_options()
        spawn_groups()
        spawnoptions_loaded = true

    end
    system.yield(Settings["loop_feat_delay"])
    return HANDLER_CONTINUE
end)
Show_Spawn_Options.on = Settings["showSpawns"]

local ip_clip = menu.add_player_feature("Copy IP to Clipboard", "action", 0, function(feat, pid)
    ip = GetIP(pid)
    utils.to_clipboard(dec2ip(ip))
end)

local mod_off = menu.add_player_feature("ToggleOFF  Modder Mark", "toggle", playerfeatVars.parent, function(feat, pid)
    while feat.on do
        if player.is_player_modder(pid, -1) == true then
            player.unset_player_as_modder(pid, -1)

        end
        system.yield(Settings["loop_feat_delay"])
        return HANDLER_CONTINUE
    end
    return HANDLER_POP
end)

-- TODO: Orbital Room Protection
menu.add_feature("Teleport to block location?", "action", globalFeatures.orbital, function(feat)

    local pos = v3()
    pos.x = 339.379
    pos.y = 4836.629
    pos.z = -58.999
    heading = 136.27784729004
    entity.set_entity_coords_no_offset(PlyPed(player.player_id()), pos)
    entity.set_entity_heading(PlyPed(player.player_id()), heading)
    return HANDLER_POP
end)

-- block orbital doorway with wall
local orbital_blastdoor = menu.add_feature("New Orbital Block Blast Door", "action", globalFeatures.orbital, function(feat)

    local pos, rot = v3(), v3()
    local hash = gameplay.get_hash_key("xm_prop_base_blast_door_02_l")
    pos.x = 337.73406982422
    pos.y = 4833.0112304688
    pos.z = -60.003131866455
    rot.x = 5.0000038146973
    rot.y = -5.0000038146973
    rot.z = 164.99998474121

    spawned_cunts[#spawned_cunts + 1] = object.create_object(hash, pos, true, true)
    entity.freeze_entity(spawned_cunts[#spawned_cunts], true)
    entity.set_entity_as_mission_entity(spawned_cunts[#spawned_cunts], true, true)
    entity.set_entity_rotation(spawned_cunts[#spawned_cunts], rot)
    BlipIDs[#BlipIDs + 1] = ui.add_blip_for_entity(spawned_cunts[#spawned_cunts])
end)

local block_orbital = menu.add_feature("Moving Wall Orbital Block", "action", globalFeatures.orbital, function(feat)

    local pos, rot = v3(), v3()
    pos.x = 342.69586181641
    pos.y = 4832.3774414062
    pos.z = -61.000000
    rot.x = 0.0
    rot.y = 0.0
    rot.z = 60.000003814697

    spawned_cunts[#spawned_cunts + 1] = object.create_object(472547144, pos, true, false)

    entity.set_entity_as_mission_entity(spawned_cunts[#spawned_cunts], true, false)
    entity.set_entity_rotation(spawned_cunts[#spawned_cunts], rot)
    BlipIDs[#BlipIDs + 1] = ui.add_blip_for_entity(spawned_cunts[#spawned_cunts])

    pos.x = 343.01234960938
    pos.y = 4833.3774414062
    pos.z = -58.619457244873
    pos.x = 350.26750854492
    pos.y = 4828.8745117188
    pos.z = -58.487403869629
    rot.x = -25.000011444092
    rot.y = -0.0
    rot.z = 150.0
    spawned_cunts[#spawned_cunts + 1] = object.create_object(2895140982, pos, true, false)
    BlipIDs[#BlipIDs + 1] = ui.add_blip_for_entity(spawned_cunts[#spawned_cunts])
    entity.set_entity_rotation(spawned_cunts[#spawned_cunts], rot)
    entity.set_entity_as_mission_entity(spawned_cunts[#spawned_cunts], true, 1)

    pos.x = 347.04141235352
    pos.y = 4830.7163085938
    pos.z = -58.487403869629
    rot.x = -25.000011444092
    rot.y = -0.0
    rot.z = 150.0

    spawned_cunts[#spawned_cunts + 1] = object.create_object(2895140982, pos, true, false)
    BlipIDs[#BlipIDs + 1] = ui.add_blip_for_entity(spawned_cunts[#spawned_cunts])
    entity.set_entity_rotation(spawned_cunts[#spawned_cunts], rot)
    entity.set_entity_as_mission_entity(spawned_cunts[#spawned_cunts], true, 1)
    pos.x = 343.0749206543
    pos.y = 4832.9965820312
    pos.z = -58.487403869629
    rot.x = -25.000011444092
    rot.y = -0.0
    rot.z = 150.0

    spawned_cunts[#spawned_cunts + 1] = object.create_object(2895140982, pos, true, false)
    BlipIDs[#BlipIDs + 1] = ui.add_blip_for_entity(spawned_cunts[#spawned_cunts])
    entity.set_entity_rotation(spawned_cunts[#spawned_cunts], rot)
    entity.set_entity_as_mission_entity(spawned_cunts[#spawned_cunts], true, 1)

    pos.x = 339.48446655273
    pos.y = 4835.1568554686
    pos.z = -58.487403869629
    rot.x = -25.000011444092
    rot.y = -0.0
    rot.z = 150.0

    spawned_cunts[#spawned_cunts + 1] = object.create_object(2895140982, pos, true, false)
    BlipIDs[#BlipIDs + 1] = ui.add_blip_for_entity(spawned_cunts[#spawned_cunts])
    entity.set_entity_rotation(spawned_cunts[#spawned_cunts], rot)
    entity.set_entity_as_mission_entity(spawned_cunts[#spawned_cunts], true, 1)

    pos.x = 335.99624633789
    pos.y = 4837.0795898438
    pos.z = -58.487403869629
    rot.x = -25.000011444092
    rot.y = -0.0
    rot.z = 150.000

    spawned_cunts[#spawned_cunts + 1] = object.create_object(2895140982, pos, true, false)
    BlipIDs[#BlipIDs + 1] = ui.add_blip_for_entity(spawned_cunts[#spawned_cunts])
    entity.set_entity_rotation(spawned_cunts[#spawned_cunts], rot)
    entity.set_entity_as_mission_entity(spawned_cunts[#spawned_cunts], true, 1)

    return HANDLER_POP
end)

local blockplaces03 = menu.add_feature("Block Orbital Entrance with Wall", "action", globalFeatures.orbital, function(feat)

    local pos, rot, pos1, rot1 = v3(), v3(), v3(), v3()
    pos.x = 335.719
    pos.y = 4834.571
    pos.z = -60.206
    rot.x = 0.000
    rot.y = -0.000
    rot.z = 125.000
    pos1.x = 335.71899414062
    pos1.y = 4834.5708007812
    pos1.z = -60.206390380859
    rot1.x = 0.0
    rot1.y = -0.0
    rot1.z = 125.0
    spawned_cunts[#spawned_cunts + 1] = object.create_object(561365155, pos1, true, false)
    entity.set_entity_as_mission_entity(spawned_cunts[#spawned_cunts], true, false)
    entity.set_entity_rotation(spawned_cunts[#spawned_cunts], rot1)
    BlipIDs[#BlipIDs + 1] = ui.add_blip_for_entity(spawned_cunts[#spawned_cunts])
    return HANDLER_POP
end)
-- Inactive Orbital Screens over blocked doorway

orbscreens = menu.add_feature("Orbital Inactive Screens over Block", "action", globalFeatures.orbital, function(feat)

    local pos1, pos2, pos3, pos4, pos5, rot1, rot2, rot3, rot4, rot5 = v3(), v3(), v3(), v3(), v3(), v3(), v3(), v3(), v3(), v3()

    pos1.x = 336.016083
    pos1.y = 4834.12988
    pos1.z = -58.0754662
    rot1.x = -25.160162
    rot1.y = 2.82980454e-06
    rot1.z = 122.541527
    pos2.x = 336.016083
    pos2.y = 4834.12988
    pos2.z = -58.9853134
    rot2.x = -25.160162
    rot2.y = 2.82980454e-06
    rot2.z = 122.541527
    pos3.x = 336.016083
    pos3.y = 4834.12988
    pos3.z = -59.5252228
    rot3.x = -25.160162
    rot3.y = 2.82980454e-06
    rot3.z = 122.541527
    pos4.x = 336.016083
    pos4.y = 4834.12988
    pos4.z = -57.5355568
    rot4.x = -25.160162
    rot4.y = 2.82980454e-06
    rot4.z = 122.541527
    pos5.x = 336.28463745117
    pos5.y = 4833.7241210938
    pos5.z = -80.422435760498
    rot5.x = 25.0
    rot5.y = 5.0000004768372
    rot5.z = -94.999992370605
    spawned_cunts[#spawned_cunts + 1] = object.create_object(3544215092, pos5, true, false)
    entity.set_entity_as_mission_entity(spawned_cunts[#spawned_cunts], true, false)

    entity.set_entity_rotation(spawned_cunts[#spawned_cunts], rot5)
    BlipIDs[#BlipIDs + 1] = ui.add_blip_for_entity(spawned_cunts[#spawned_cunts])
    spawned_cunts[#spawned_cunts + 1] = object.create_object(2895140982, pos1, true, false)
    entity.set_entity_as_mission_entity(spawned_cunts[#spawned_cunts], true, false)

    entity.set_entity_rotation(spawned_cunts[#spawned_cunts], rot1)
    BlipIDs[#BlipIDs + 1] = ui.add_blip_for_entity(spawned_cunts[#spawned_cunts])
    spawned_cunts[#spawned_cunts + 1] = object.create_object(2895140982, pos2, true, false)
    entity.set_entity_as_mission_entity(spawned_cunts[#spawned_cunts], true, false)
    entity.set_entity_rotation(spawned_cunts[#spawned_cunts], rot2)

    BlipIDs[#BlipIDs + 1] = ui.add_blip_for_entity(spawned_cunts[#spawned_cunts])
    spawned_cunts[#spawned_cunts + 1] = object.create_object(-1399826314, pos3, true, true)
    entity.set_entity_as_mission_entity(spawned_cunts[#spawned_cunts], true, false)
    entity.set_entity_rotation(spawned_cunts[#spawned_cunts], rot3)

    BlipIDs[#BlipIDs + 1] = ui.add_blip_for_entity(spawned_cunts[#spawned_cunts])
    spawned_cunts[#spawned_cunts + 1] = object.create_object(2895140982, pos4, true, false)
    entity.set_entity_as_mission_entity(spawned_cunts[#spawned_cunts], true, false)

    entity.set_entity_rotation(spawned_cunts[#spawned_cunts], rot4)
    BlipIDs[#BlipIDs + 1] = ui.add_blip_for_entity(spawned_cunts[#spawned_cunts])
    return HANDLER_POP
end)

menu.add_feature("Teleport to Casino God Mode Glitch location?", "action", globalFeatures.glitch, function(feat)
    local pos = v3()
    pos.x = 980.99298095703
    pos.y = 67.855430603027
    pos.z = 117.94748687744
    heading = -1.1678575901897e-006
    entity.set_entity_coords_no_offset(PlyPed(player.player_id()), pos)
    entity.set_entity_heading(PlyPed(player.player_id()), heading)
    return HANDLER_POP
end)

casinoglitch = menu.add_feature("Block Casino God Mode Glitch area", "action", globalFeatures.glitch, function(feat)
    local pos, rot = v3(), v3()
    pos.x = 980.99298095703
    pos.y = 67.855430603027
    pos.z = 117.94748687744
    rot.x = 25.000011444092
    rot.y = 90.0
    rot.z = 0.0

    spawned_cunts[#spawned_cunts + 1] = object.create_object(2765198545, pos, true, false)
    BlipIDs[#BlipIDs + 1] = ui.add_blip_for_entity(spawned_cunts[#spawned_cunts])
    network.request_control_of_entity(spawned_cunts[#spawned_cunts])
    entity.set_entity_as_mission_entity(spawned_cunts[#spawned_cunts], true, false)
    entity.set_entity_rotation(spawned_cunts[#spawned_cunts], rot)
    -- entity.set_entity_heading(spawned_cunts[#spawned_cunts], -1.1678575901897e-006)

    return HANDLER_POP
end)

local delete_cunt = menu.add_feature("Delete Spawned Cunts", "action", globalFeatures.cleanup, function(feat)

    for i = 1, #spawned_cunts do
        network.request_control_of_entity(spawned_cunts[i])
        entity.delete_entity(spawned_cunts[i])
    end
    for i = 1, #spawned_cunt do
        network.request_control_of_entity(spawned_cunt[i])
        entity.delete_entity(spawned_cunt[i])
    end

end)

-- **BLACK LIST SHIT**

local joining_players_logger = event.add_event_listener("player_join", function(e)

    local pid, scid, schx, name
    pid = e.player
    scid = player.get_player_scid(pid)
    schx = string.format("%x", scid)
    name = tostring(player.get_player_name(pid))

    local ip, sip, token, tohex, prior
    token = player.get_player_host_token(pid)
    tokhex = string.format("%x", token)
    prior = player.get_player_host_priority(pid)
    if player.get_player_ip(pid) == 1162167621 then
        KickPid(pid)
    end

    ip = GetIP(pid)
    sip = dec2ip(ip)

    joined_data(name .. ":" .. schx .. "|" .. pid .. "|" .. scid .. "|" .. token .. "|" .. tokhex .. "|" .. prior .. "|" .. ip .. "|" .. sip .. "\n")
    joined_csv(name .. ',' .. schx .. ',' .. pid .. ',' .. scid .. ',' .. token .. ',' .. tokhex .. ',' .. prior .. ',' .. ip .. ',' .. sip)

    playerDB(pid, player.get_player_ip(pid))
    blacklist_check(pid)
    return
end)

function joined_data(text)
    local d, dtime, dt, CurDateTime, file

    d = os.date()
    dtime = string.match(d, "%d%d:%d%d:%d%d")
    dt = os.date("%d/%m/%y")
    CurDateTime = (string.format(dt .. "|" .. dtime .. "|"))
    file = io.open(Paths.Logs .. "\\PlayerJoins.txt", "a")

    io.output(file)
    io.write("\n" .. CurDateTime .. text)
    io.close()
end

function joined_csv(text)
    local d, dtime, dt, CurDateTime, file

    d = os.date()
    dtime = string.match(d, "%d%d:%d%d:%d%d")
    dt = os.date("%d/%m/%y%y")
    CurDateTime = (string.format(dt .. ',' .. dtime .. ','))
    file = io.open(Paths.Logs .. "\\PlayerJoins.csv", "a")

    io.output(file)
    io.write("\n" .. CurDateTime .. text)
    io.close()
end

function playerDB(pid, ip)
    if player.is_player_valid(pid) then

        local scid, name, token, file1, file2, tokeen
        scid = GetSCID(pid)
        name = player.get_player_name(pid)
        token = string.format("%x", player.get_player_host_token(pid))

        file1 = io.open(Paths.Logs .. "\\PlayerDB.txt", "a")
        io.output(file1)
        tokeen = tostring(token:sub(1, 8))

        io.write("\n" .. tokeen .. "|" .. name .. ", " .. scid .. "|" .. name .. ", " .. ip)
        io.close()

        file2 = io.open(Paths.Logs .. "\\IP_LIST.txt", "a")
        io.output(file2)
        io.write(ip .. "\n")
        io.close()
    end

end

-- TODO: Blacklist
function ValidScid(scid)
    return scid ~= -1 and scid ~= 4294967295
end

function RemoveScid(scid)
    name = scids[scid]
    if scids[scid] then
        scids[scid] = nil
        local file = io.open(Paths.scidFile, "w+")
        io.output(file)
        for k, v in pairs(scids) do
            if v then
                io.write(k .. "|" .. v .. "\n")
            end
        end
        io.close()
        for i = RemoveBlacklistFeature.child_count, 1, -1 do
            local f = RemoveBlacklistFeature.children[i]
            if f.data == scid then
                menu.delete_feature(f.id)
                break
            end
        end
        scidN = scidN - 1
        Debug_Out(string.format("Removed " .. scid .. " : " .. name .. " from blacklist."))
        print("Removed " .. scid .. " from blacklist.")
    end
end

function RemoveScidByPid(pid)
    if pid == player.player_id() then
        return
    end
    local scid = GetSCID(pid)
    if ValidScid(scid) then
        RemoveScid(scid)
    end
end

function RemoveScidByFeature(f)
    menu.create_thread(RemoveScid, f.data)
end

function AddScid(scid, name)
    if scids[scid] then
        return
    end
    name = name or "Unknown"
    scids[scid] = name
    local file = io.open(Paths.scidFile, "a")

    io.output(file)
    io.write(scid .. "|" .. name .. "\n")
    io.close()
    scidN = scidN + 1
    menu.add_feature(scidN .. ": " .. scid .. " (" .. name .. ")", "action", RemoveBlacklistFeature.id, RemoveScidByFeature).data = scid
    Debug_Out(string.format("Added " .. scid .. " (" .. name .. ")" .. "to blacklist"))
    print("Added " .. scid .. " (" .. name .. ") to blacklist.")
    LoadBlacklist()
end

function AddScidByPid(pid)
    if pid == player.player_id() then
        return
    end
    local scid = GetSCID(pid)
    if ValidScid(scid) then
        AddScid(scid, player.get_player_name(pid))
    end
end

function LoadBlacklist()
    scids = {}
    scidN = 0
    for i = RemoveBlacklistFeature.child_count, 1, -1 do
        menu.delete_feature(RemoveBlacklistFeature.children[i].id)
    end
    if not utils.file_exists(Paths.scidFile) then
        return
    end
    for line in io.lines(Paths.scidFile) do
        local scid, name = line:match("(%x+)|?(.-)$")
        name = name or "Unknown"
        if scid then
            local scid = tonumber(scid) or tonumber(scid, 16)
            if scid then
                scids[scid] = name
                menu.add_feature(scidN .. ": " .. scid .. " (" .. name .. ")", "action", RemoveBlacklistFeature.id, RemoveScidByFeature).data = scid
                scidN = scidN + 1
            end
        end
    end
    print("Loaded blacklist with " .. scidN .. " entries.")
end

-- TODO: Blacklist kick
function KickPid(pid)
    if pid == player.player_id() then
        return
    end
    SessionPlayers.Name = player.get_player_name(pid)
    system.wait(10)
    if network.network_is_host() then
        network.network_session_kick_player(pid)
        Debug_Out(string.format("Black List: Host kicked " .. pid .. " (" .. SessionPlayers.Name .. ")"))
        print("Black List: Host kicked " .. pid .. " (" .. SessionPlayers.Name .. ").")
    else
        script.trigger_script_event(-2120750352, pid, {pid, script.get_global_i(1630317 + (1 + (pid * 595)) + 506)})
        script.trigger_script_event(0xE6116600, pid, {pid, script.get_global_i(1630317 + (1 + (pid * 595)) + 506)})
        Debug_Out(string.format("Black List: Non-Host kicked " .. pid .. " (" .. SessionPlayers.Name .. ")"))
        print("Non-Host kicked " .. pid .. " (" .. SessionPlayers.Name .. ").")

    end
    network.network_session_kick_player(pid)

end

function MarkPidAsModder(pid)
    if pid == player.player_id() then
        return
    end
    SessionPlayers.Name = player.get_player_name(pid)
    system.wait(10)
    player.set_player_as_modder(pid, mod_flag_4)
    Debug_Out(string.format("Black List: Marked " .. pid .. " (" .. SessionPlayers.Name .. ") as modder"))
end

menu.add_feature("Reload blacklist", "action", globalFeatures.parentID, function()
    LoadBlacklist()
    moist_notify("Blacklist Loaded ", scidN .. " entries")
end)

EnabledBlacklistFeature = menu.add_feature("Enable blacklist", "toggle", globalFeatures.parentID, function(feat)
    if not feat.on then
        Settings["Blacklist_ON"] = false
        return HANDLER_POP
    end

    Settings["Blacklist_ON"] = true
    if feat.on then
        local lp = player.player_id()
        for pid = 0, 32 do
            if pid ~= lp then
                local scid = GetSCID(pid)
                if ValidScid(scid) and scids[scid] then
                    if MarkAsModderFeature.on then
                        MarkPidAsModder(pid)
                    end
                    if KickFeature.on then
                        KickPid(pid)
                    end
                end
            end
        end
    end
end)
EnabledBlacklistFeature.on = Settings["Blacklist_ON"]

MarkAsModderFeature = menu.add_feature("Mark As Modder", "toggle", globalFeatures.parentID, function(feat)
    if not feat.on then
        Settings["Blacklist_Mark"] = false
        return HANDLER_POP
    end
    Settings["Blacklist_Mark"] = true
    return HANDLER_POP
end)
MarkAsModderFeature.on = Settings["Blacklist_Mark"]

KickFeature = menu.add_feature("Kick Player", "toggle", globalFeatures.parentID, function(feat)
    if not feat.on then
        Settings["Blacklist_kick"] = false
        return HANDLER_POP
    end
    Settings["Blacklist_kick"] = true
    return HANDLER_POP
end)
KickFeature.on = Settings["Blacklist_kick"]

menu.add_feature("Manually add scid", "action", globalFeatures.parentID, function(feat)
    local r, s = input.get("Enter SCID to add", "", 64, 3)
    if r == 1 then
        return HANDLER_CONTINUE
    end

    if r == 2 then
        return HANDLER_POP
    end

    AddScid(tonumber(s), "Manual add")
    ui.notify_above_map("Added " .. s .. " to blacklist.", "Blacklist", 140)
end)

RemoveBlacklistFeature = menu.add_feature("Remove blacklist", "parent", globalFeatures.parentID)

globalFeatures.addtoblacklist = menu.add_player_feature("Add Player to blacklist", "action", 0, function(feat, pid)
    AddScidByPid(pid)

    if EnabledBlacklistFeature.on then
        if MarkAsModderFeature.on then
            MarkPidAsModder(pid)
        end
        if KickFeature.on then
            KickPid(pid)
        end
    end
end)
for i = 1, #globalFeatures.addtoblacklist.feats do
    globalFeatures.addtoblacklist.feats[i].hidden = false
end

globalFeatures.removefromblacklist = menu.add_player_feature("Remove from Blacklist", "action", 0, function(feat, pid)
    RemoveScidByPid(pid)
    player.unset_player_as_modder(pid, mod_flag_4)
end)
for i = 1, #globalFeatures.removefromblacklist.feats do
    globalFeatures.removefromblacklist.feats[i].hidden = false
end

-- TODO: Blacklist Player Join

function blacklist_check(pid)
    if not EnabledBlacklistFeature.on then
        return
    end

    local scid = GetSCID(pid)
    if ValidScid(scid) and scids[scid] then
        SessionPlayers.Name = player.get_player_name(pid)
        system.wait(10)
        ui.notify_above_map(string.format("Black List Player Joining:\n" .. name .. "\n" .. scid), "~h~Ω MoistsScript 2.0.3.7\nBlack List", 024)
        if MarkAsModderFeature.on then
            MarkPidAsModder(pid)
        end
        if KickFeature.on then
            KickPid(pid)
        end
    end
end
LoadBlacklist()

-- TODO: Chat Logger
function chat(name, text)
    if not chat_log.on then
        return
    end
    local d = os.date()
    local t = string.match(d, "%d%d:%d%d:%d%d")
    local dt = os.date("%d/%m/%y%y")
    local file = io.open(Paths.Logs .. "\\chat.txt", "a")
    io.output(file)
    io.write("\n" .. dt .. " | " .. t .. " | " .. name .. " | " .. text)
    io.close()
end

function Console_chat(name, text)
    if not Settings["chat_debug"] then
        return
    end
    local d = os.date()
    local t = string.match(d, "%d%d:%d%d:%d%d")
    print(t .. " [ " .. name .. " ] " .. text)
end

local ChatEventID = event.add_event_listener("chat", function(e)
    local sender
    -- if PlyPed(e.player) == 0 then return end
    if not player.is_player_valid(e.player) then
        sender = "UNKNOWN JOINING"
    elseif player.is_player_valid(e.player) then
        sender = player.get_player_name(e.player)
    end
    if not ChatSpamOn then
        chat(sender, e.body)
        Console_chat(sender, e.body)
        Chat_Command(e.player, e.body)
    elseif ChatSpamOn then
        if e.player ~= me then
            chat(sender, e.body)
            Console_chat(sender, e.body)
            Chat_Command(e.player, e.body)
        end
    end

end)

local comm, playername
function Chat_Command(playerid, text)
    local chat_clear = 0

    if not ChatCommand.on then
        return
    end
    if not player.is_player_friend(playerid) then
        return
    end
    comm = text:sub(1, 5)
    Name = text:sub(7, 25)
    playername = string.lower(Name)

    if comm == "@kick" then
        repeat
            chat_clear = (chat_clear + 1)
            network.send_chat_message(string.format(chat_clear), false)
        until (chat_clear == 30)

        for i = 0, 32 do

            if i ~= player.player_id() then
                Name = tostring(player.get_player_name(i))
                name = string.lower(string.format(Name))
                if name == playername then
                    if not player.is_player_host(me) then
                        player.send_player_sms(playerid, "I'm Not Currently Host Let Me see if i can remove him")
                        send_SE_Kick(i)
                    end
                    if player.is_player_host(me) then
                        player.send_player_sms(playerid, "Sending Host Kick Now!")
                        network.network_session_kick_player(i)
                    end

                end

            end

        end
        return HANDLER_POP
    end
end

event.add_event_listener("exit", function()
    event.remove_event_listener("chat", ChatEventID)
end)

function send_SE_Kick(pid)
    script.trigger_script_event(0xF5CB92DB, pid, {0, 0, 46190868, 0, 2})
    script.trigger_script_event(0xF5CB92DB, pid, {46190868, 0, 46190868, 46190868, 2})
    script.trigger_script_event(0xF5CB92DB, pid, {1337, -1, 1, 1, 0, 0, 0})
    script.trigger_script_event(0xF5CB92DB, pid, {pid, 1337, -1, 1, 1, 0, 0, 0})
    script.trigger_script_event(0xc5bc4c4b, pid, {-72614, 63007, 59027, -12012, -26996, 33399})
    script.trigger_script_event(-2122716210, pid, {91645, -99683, 1788, 60877, 55085, 72028})
    script.trigger_script_event(-2120750352, pid, {pid, script.get_global_i(1630317 + (1 + (pid * 595)) + 506)})
    script.trigger_script_event(0xE6116600, pid, {pid, script.get_global_i(1630317 + (1 + (pid * 595)) + 506)})
    script.trigger_script_event(-977515445, pid, {-1, 500000, 849451549, -1, -1})
    script.trigger_script_event(767605081, pid, {-1, 500000, 849451549, -1, -1})
    script.trigger_script_event(-1949011582, pid, {-1139568479, -1, 1, 100099})
    script.trigger_script_event(-2122716210, pid, {-1139568479, -1, 1, 100099, -1, 500000, 849451549, -1, -1, 91645, -99683, 1788, 60877, 55085, 72028})
    script.trigger_script_event(-922075519, pid, {-1, -1, -1, -1, -1139568479, -1, 1, 100099, -1, 500000, 849451549, -1, -1, 91645, -99683, 1788, 60877, 55085, 72028})
    script.trigger_script_event(-1975590661, pid, {-1139568479, -1, 1, 100099, -1, 500000, 849451549, -1, -1, 91645, -99683, 1788, 60877, 55085, 72028})
end

chat_log = menu.add_feature("Log in Game Chat", "toggle", logging.id, function(feat)
    if not feat.on then
        Settings["chat_log"] = false
        return HANDLER_POP
    end
    Settings["chat_log"] = true
    return HANDLER_POP
end)
chat_log.on = Settings["chat_log"]

-- TODO: Chat Command Thread Feature
ChatCommand = menu.add_feature("Chat Command", "toggle", logging.id, function(feat)
    if not feat.on then
        Settings["Chat_Command"] = false
        return HANDLER_POP
    end

    Settings["Chat_Command"] = true
    return HANDLER_POP
end)
ChatCommand.on = Settings["Chat_Command"]

chat_console = menu.add_feature("Ouput Game Chat to Debug Console", "toggle", logging.id, function(feat)
    if not feat.on then
        Settings["chat_debug"] = false
        return HANDLER_POP
    end
    Settings["chat_debug"] = true
    return HANDLER_POP
end)
chat_console.on = Settings["chat_debug"]

-- TODO: player Features --Griefing
function griefing()

    menu.add_player_feature("Attach Big dildo on every bone", "action", playerfeatVars.parent, function(feat, pid)
        moist_notify("WARNING! OVER USE:\n", "WILL CRASH GTA")
        pped = PlyPed(pid)

        local pos = v3()
        local hash = gameplay.get_hash_key("v_res_d_dildo_f")
        streaming.request_model(hash)
        while (not streaming.has_model_loaded(hash)) do
            system.wait(10)
        end
        for i = 1, #boneid do
            bone_idx = ped.get_ped_bone_index(pped, boneid[i])
            spawned_cunts[#spawned_cunts + 1] = object.create_object(hash, pos, true, false)
            entity.attach_entity_to_entity(spawned_cunts[#spawned_cunts], pped, bone_idx, pos, pos, true, true, false, 0, false)
        end
        moist_notify("ensure to Delete:\n", "Spawned Cunts in Cleanup")
    end)

    menu.add_player_feature("Attach dildo on every bone", "action", playerfeatVars.parent, function(feat, pid)
        moist_notify("WARNING! OVER USE:\n", "WILL CRASH GTA")
        pped = PlyPed(pid)

        local pos = v3()
        for i = 1, #boneid do
            bone_idx = ped.get_ped_bone_index(pped, boneid[i])
            spawned_cunts[#spawned_cunts + 1] = object.create_object(-422877666, pos, true, false)
            entity.attach_entity_to_entity(spawned_cunts[#spawned_cunts], pped, bone_idx, pos, pos, true, true, false, 0, false)
        end

        moist_notify("ensure to Delete:\n", "Spawned Cunts in Cleanup")

    end)

    menu.add_player_feature("Attach dildo in Skeleton root", "action", playerfeatVars.parent, function(feat, pid)

        pped = PlyPed(pid)

        local pos = v3()

        spawned_cunts[#spawned_cunts + 1] = object.create_object(-422877666, pos, true, false)
        entity.attach_entity_to_entity(spawned_cunts[#spawned_cunts], pped, 0, pos, pos, true, true, false, 0, false)
    end)

    menu.add_player_feature("Script Host Crash Kick", "action", 0, function(feat, pid)

        local pos = v3()
        pos = player.get_player_coords(pid)
        pos.x = math.floor(pos.x)
        pos.y = math.floor(pos.y)
        pos.z = math.floor(pos.z)
        -- script.trigger_script_event(-1975590661, pid, {pid, pos.x, pos.y, pos.z, 0, 0, 2147483647, 0, script.get_global_i(1590682 + (pid * 883) + 99 + 28), 1})
        script.trigger_script_event(-1975590661, pid, {pid, pos.x, pos.y, pos.z, 0, 0, 1000, 0, script.get_global_i(1590682 + (pid * 883) + 99 + 28), 1})

    end)

    menu.add_player_feature("CEO BAN", "action", playerfeatVars.parent, function(feat, pid)

        script.trigger_script_event(0xD3FE818F, pid, {0, 1, 5, 0})
    end)

    menu.add_player_feature("CEO DISMISS", "action", playerfeatVars.parent, function(feat, pid)
        script.trigger_script_event(0x9DB77399, pid, {0, 1, 5})
    end)

    menu.add_player_feature("CEO TERMINATE", "action", playerfeatVars.parent, function(feat, pid)
        script.trigger_script_event(0x9DB77399, pid, {1, 1, 6})
        script.trigger_script_event(0x9DB77399, pid, {0, 1, 6, 0})
    end)

    for i = 1, #missions do
        local y = #missions - 1
        menu.add_player_feature("Force to Mission" .. missions[i], "action", playerfeatVars.fm, function(feat, pid)

            script.trigger_script_event(0xdf7de926, pid, {y})
            script.trigger_script_event(1115000764, pid, {y})
            script.trigger_script_event(-545396442, pid, {y})

        end)

    end

    function AddBounty(pid, value, anonymous)
        -- if not network.is_session_started() then return end
        local npc_bit = anonymous and 1 or 0
        for i = 0, 32 do
            if not player.is_player_valid(i) then
                return
            end
            local scid = GetSCID(i)
            if scid ~= 4294967295 then

                script.trigger_script_event(0xf90cc891, i, {-1, pid, 1, value, 0, npc_bit, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})

            end
        end
    end

    menu.add_player_feature("Anonymous Bounty", "toggle", BountyId, function(feat, pid)
        if feat.on ~= AnonymousBounty then
            AnonymousBounty = feat.on
            local pf = menu.get_player_feature(feat.id)
            for i = 1, #pf.feats do
                if pf.feats[i].on ~= AnonymousBounty then
                    pf.feats[i].on = AnonymousBounty
                end
            end
        end
        return HANDLER_POP
    end)

    menu.add_player_feature("Custom Value", "action", BountyId, function(feat, pid)
        local r, s = input.get("Custom Bounty Value", "", 64, 3)
        if r == 1 then
            return HANDLER_CONTINUE
        end

        if r == 2 then
            return HANDLER_POP
        end

        local value = tonumber(s)
        value = math.max(0, value)
        value = math.min(10000, value)
        AddBounty(pid, value, AnonymousBounty)
        notify_above_map("I've placed a $" .. value .. " bounty on " .. (pid == player.player_id() and "your" or player.get_player_name(pid) .. "'s") .. " head.")
    end)

    for i = 1, #BountyPresets do
        menu.add_player_feature("$" .. BountyPresets[i], "action", BountyId, function(feat, pid)
            AddBounty(pid, BountyPresets[i], AnonymousBounty)
            -- notify_above_map("I've placed a $" .. BountyPresets[i] .. " bounty on " .. (pid == player.player_id() and "your" or player.get_player_name(pid) .. "'s") ..  " head.")
        end)
    end
end
griefing()
-- TODO: Features
function playervehspd(pid, speed)

    local plyveh = player.get_player_vehicle(pid)
    entity.set_entity_max_speed(plyveh, speed)
    network.request_control_of_entity(plyveh)
    vehicle.modify_vehicle_top_speed(plyveh, speed)
    entity.set_entity_max_speed(plyveh, speed)
end

function playvehspdboost(pid, reftime)
    --- lag 100000.000010
    --- fast 0.000010
    local plyveh
    plyveh = player.get_player_vehicle(pid)
    network.request_control_of_entity(plyveh)
    vehicle.set_vehicle_rocket_boost_refill_time(plyveh, reftime)
end

-- Options Toggles etc

global_func.lag_out = menu.add_feature("Lag Self out of session", "toggle", globalFeatures.moist_hotkeys, function(feat)
    Settings["lag_out"] = true
    if feat.on then
        local key = MenuKey()
        key:push_str("LCONTROL")
        key:push_str("LSHIFT")
        key:push_str("l")
        if key:is_down() then
            local time = utils.time_ms() + 8500
            while time > utils.time_ms() do
            end
            system.wait(1200)
        end
        system.yield(10)
        return HANDLER_CONTINUE
    end
    Settings["lag_out"] = false
    return HANDLER_POP
end)
global_func.lag_out.on = Settings["lag_out"]

-- TODO: World Features

global_func.no_traffic = menu.add_feature("No World Traffic", "toggle", globalFeatures.moistopt, function(feat)

    Settings["no_traffic"] = true
    if feat.on then
        vehicle.set_vehicle_density_multipliers_this_frame(0)
        return HANDLER_CONTINUE
    end
    Settings["no_traffic"] = false
    return HANDLER_POP
end)
global_func.no_traffic.on = Settings["no_traffic"]

global_func.no_peds = menu.add_feature("No World Peds", "toggle", globalFeatures.moistopt, function(feat)

    Settings["no_peds"] = true
    if feat.on then
        ped.set_ped_density_multiplier_this_frame(0)
        return HANDLER_CONTINUE
    end
    Settings["no_peds"] = false
    return HANDLER_POP
end)
global_func.no_peds.on = Settings["no_peds"]

-- TODO: Self Features

-- Self modifiers --Max Health 0:0 1: 2: 3: 4: 5: 6:
HP_modifiers = {{"Set max Health 0 (UnDead OTR)", 0}, {"Set Health to 500", 500}, {"Set Health to 10000", 1000}, {"Set Health Freemode Beast 2500", 2500}, {"Set Health BallisticArmour 2600", 2600}, {"Set Health to 10000", 10000}, {"Set Health to 90000", 90000}, {"Set Health to 328 (lvl 120)", 328}}

globalFeatures.self_ped_modify = menu.add_feature("Health Modifiers", "parent", globalFeatures.self_ped).id
globalFeatures.self_ped_modalify = menu.add_feature("Ped Modifiers", "parent", globalFeatures.self_ped).id

for i = 1, #HP_modifiers do

    menu.add_feature("set: " .. HP_modifiers[i][1], "action", globalFeatures.self_ped_modify, function(feat)

        chp0 = ped.get_ped_max_health(PlyPed(player.player_id()))
        ped.set_ped_max_health(PlyPed(player.player_id()), HP_modifiers[i][2])

        chp1 = ped.get_ped_max_health(PlyPed(player.player_id()))
        if chp1 ~= 0 then
            ped.set_ped_health(PlyPed(player.player_id()), HP_modifiers[i][2])
        else
        end
        moist_notify(string.format("Max Health Now:~y~~h~ " .. chp1 .. "~r~\n From:~y~~h~ " .. chp0, chp0))

        return HANDLER_POP
    end)
end

for i = 1, #ped_hashes do

    menu.add_feature("set: " .. ped_hashes[i][1], "action", globalFeatures.self_ped_modalify, function(feat)

        local model = ped_hashes[i][2]
        streaming.request_model(model)
        while (not streaming.has_model_loaded(model)) do
            system.wait(0)
        end

        player.set_player_model(model)
        streaming.set_model_as_no_longer_needed(model)
        moist_notify(string.format("model now Set", ped_hashes[i][1]))

        return HANDLER_POP
    end)
end

-- TODO: Combat Features

-- TODO: Combat Features

globalFeatures.self_ped_combat_POI = menu.add_feature("WayPoint Weapon Strike", "parent", globalFeatures.self_ped_combat).id
local BlameMe, StrikeSpeed = 0, 1000.00

Blame_Me = menu.add_feature("Blame Strike on Me!", "toggle", globalFeatures.self_ped_combat_POI, function(feat)
    if feat.on then
        BlameMe = PlyPed(player.player_id())
    end
    if not feat.on then
        BlameMe = 0
        return HANDLER_POP
    end
end)
Blame_Me.on = false

Strike_projSpeed = menu.add_feature("Strike Projectiles Speed: ", "autoaction_value_i", globalFeatures.self_ped_combat_POI, function(feat)
    StrikeSpeed = tonumber(feat.value .. "." .. "00")
end)
Strike_projSpeed.max = 100000
Strike_projSpeed.min = 100
Strike_projSpeed.value = 1000
Strike_projSpeed.mod = 25

Waypoint_Air_Strike = menu.add_feature("WeaponStrike (Better for Hills)", "action_value_i", globalFeatures.self_ped_combat_POI, function(feat)

    OSD_Debug_text(string.format("Current Weapon Strike: " .. StrikeGive[feat.value]))
    local coord, Coord, offset, Pos, pos, num = v3(), v3(), v3(), v3(), v2(), 0
    offset = player.get_player_coords(me)
    pos = ui.get_waypoint_coord()
    if pos.x and pos.y then
        coord.x = pos.x
        coord.y = pos.y
        coord.z = offset.z
    end
    streaming.request_model(3040635986)
    while (not streaming.has_model_loaded(3040635986)) do
        system.wait(10)
    end
    local P_O_S = v3()
    ground_test = vehicle.create_vehicle(3040635986, player.get_player_coords(me), 0.0, true, true)
    entity.set_entity_alpha(ground_test, 0, true)
    vehicle.set_vehicle_on_ground_properly(ground_test)
    entity.freeze_entity(ground_test, true)
    entity.set_entity_coords_no_offset(ground_test, coord)
    vehicle.set_vehicle_on_ground_properly(ground_test)
    system.wait(10)
    P_O_S = entity.get_entity_coords(ground_test)
    system.wait(1)
    b, z = gameplay.get_ground_z(P_O_S)
    streaming.set_model_as_no_longer_needed(3040635986)
    entity.delete_entity(ground_test)
    local hash = gameplay.get_hash_key(StrikeGive[feat.value])

    Pos.x = pos.x
    Pos.y = pos.y
    Pos.z = z + 225.0
    repeat
        num = num + 1
        Coord.x = pos.x
        Coord.y = pos.y
        Coord.z = z
        Coord.x = Coord.x + math.random(-5.0, 10.0)
        Coord.y = Coord.y + math.random(-5.0, 10.0)
        gameplay.shoot_single_bullet_between_coords(Pos, Coord, 10000.00, hash, BlameMe, true, false, StrikeSpeed)
        system.wait(1)
        Coord.x = pos.x
        Coord.y = pos.y
        Coord.x = Coord.x + math.random(-5.0, 10.0)
        Coord.y = Coord.y + math.random(-5.0, 10.0)
        gameplay.shoot_single_bullet_between_coords(Pos, Coord, 10000.00, hash, BlameMe, true, false, StrikeSpeed)
        system.wait(1)
        Coord.x = pos.x
        Coord.y = pos.y
        Coord.x = Coord.x + math.random(-5.0, 10.0)
        Coord.y = Coord.y + math.random(-5.0, 10.0)
        gameplay.shoot_single_bullet_between_coords(Pos, Coord, 10000.00, hash, BlameMe, true, false, StrikeSpeed)
        system.wait(1)
    until num == 20

    system.wait(50)

end)
Waypoint_Air_Strike.max = #StrikeGive
Waypoint_Air_Strike.min = 1
Waypoint_Air_Strike.value = 1

Waypoint_Air_Strike = menu.add_feature("Weapon Strike (Lower StartPOS)", "action_value_i", globalFeatures.self_ped_combat_POI, function(feat)
    local coord, Coord, offset, Pos, pos, num = v3(), v3(), v3(), v3(), v2(), 0
    pos = ui.get_waypoint_coord()
    if pos.x and pos.y then
        coord.x = pos.x
        coord.y = pos.y
        coord.z = 1000.0
        b, coord.z = gameplay.get_ground_z(coord)

        local hash = gameplay.get_hash_key(StrikeGive[feat.value])
        OSD_Debug_text(string.format("Current Weapon Strike: " .. StrikeGive[feat.value]))

        offset.x = 0.0
        offset.y = 0.0
        offset.z = coord.z

        Pos.x = pos.x + 10.0
        Pos.y = pos.y + 10.0
        Pos.z = coord.z + 25.0
        repeat
            num = num + 1
            Coord.x = pos.x
            Coord.y = pos.y
            Coord.z = coord.z
            Coord.x = Coord.x + math.random(-15.0, 30.0)
            Coord.y = Coord.y + math.random(-15.0, 30.0)
            gameplay.shoot_single_bullet_between_coords(Pos, Coord, 10000.00, hash, BlameMe, true, false, StrikeSpeed)
            system.wait(1)
            Coord.x = pos.x
            Coord.y = pos.y
            Coord.z = coord.z
            Coord.x = Coord.x + math.random(-15.0, 30.0)
            Coord.y = Coord.y + math.random(-15.0, 30.0)
            gameplay.shoot_single_bullet_between_coords(Pos, Coord, 10000.00, hash, BlameMe, true, false, StrikeSpeed)
            system.wait(1)
            Coord.x = pos.x
            Coord.y = pos.y
            Coord.z = coord.z
            Coord.x = Coord.x + math.random(-15.0, 30.0)
            Coord.y = Coord.y + math.random(-15.0, 30.0)
            gameplay.shoot_single_bullet_between_coords(Pos, Coord, 10000.00, hash, BlameMe, true, false, StrikeSpeed)
            system.wait(1)
        until num == 20
    end
    system.wait(50)

end)
Waypoint_Air_Strike.max = #StrikeGive
Waypoint_Air_Strike.min = 1
Waypoint_Air_Strike.value = 1

Waypoint_Air_Strike = menu.add_feature("Weapon Strike (inverted)", "action_value_i", globalFeatures.self_ped_combat_POI, function(feat)
    local coord, Coord, offset, Pos, pos, num = v3(), v3(), v3(), v3(), v2(), 0
    pos = ui.get_waypoint_coord()
    if pos.x and pos.y then
        coord.x = pos.x
        coord.y = pos.y
        coord.z = -100.0
        b, z = gameplay.get_ground_z(v3(pos.x, pos.y, 100.00))
        -- print(z)
        local hash = gameplay.get_hash_key(StrikeGive[feat.value])

        OSD_Debug_text(string.format("Current Weapon Strike: " .. StrikeGive[feat.value]))

        offset.x = 0.0
        offset.y = 0.0
        offset.z = Coord.z

        Pos.x = pos.x + 10.0
        Pos.y = pos.y + 10.0
        Pos.z = Coord.z + 25.0
        repeat
            num = num + 1
            Coord.x = pos.x
            Coord.y = pos.y
            Coord.z = z
            Coord.x = Coord.x + math.random(-15.0, 30.0)
            Coord.y = Coord.y + math.random(-15.0, 30.0)
            gameplay.shoot_single_bullet_between_coords(Pos, Coord, 10000.00, hash, BlameMe, true, false, StrikeSpeed)
            system.wait(1)
            Coord.x = pos.x
            Coord.y = pos.y
            Coord.z = coord.z
            Coord.x = Coord.x + math.random(-15.0, 30.0)
            Coord.y = Coord.y + math.random(-15.0, 30.0)
            gameplay.shoot_single_bullet_between_coords(Pos, Coord, 10000.00, hash, BlameMe, true, false, StrikeSpeed)
            system.wait(1)
            Coord.x = pos.x
            Coord.y = pos.y
            Coord.z = coord.z
            Coord.x = Coord.x + math.random(-15.0, 30.0)
            Coord.y = Coord.y + math.random(-15.0, 30.0)
            gameplay.shoot_single_bullet_between_coords(Pos, Coord, 10000.00, hash, BlameMe, true, false, StrikeSpeed)
            system.wait(1)
        until num == 20
    end
    system.wait(50)

end)
Waypoint_Air_Strike.max = #StrikeGive
Waypoint_Air_Strike.min = 1
Waypoint_Air_Strike.value = 1

Grenade_Strike = menu.add_feature("grenadelauncher Waypoint", "action", globalFeatures.self_ped_combat, function(feat)
    local coord, Coord, offset, Pos, pos, num = v3(), v3(), v3(1.00, 0.50, 2.5), v3(), v2(), 0
    local hash = gameplay.get_hash_key("WEAPON_GRENADELAUNCHER")

    pos = ui.get_waypoint_coord()
    if pos.x and pos.y then
        coord.x = pos.x
        coord.y = pos.y
        coord.z = 100.0
        b, coord.z = gameplay.get_ground_z(coord)
        Pos.x = coord.x
        Pos.y = coord.y
        Pos.z = coord.z + 25.0

        repeat
            num = num + 1
            gameplay.shoot_single_bullet_between_coords(Pos, coord, 100000.00, hash, BlameMe, true, false, 10000.00)
            system.wait(100)

        until num == 6
        system.wait(50)
    end
end)

damage = 200
dam_multi = menu.add_feature("unfair aim Damage", "autoaction_value_i", globalFeatures.self_ped_combat, function(feat)
    damage = tonumber(feat.value)
    -- print(damage)
end)
dam_multi.max = 10000
dam_multi.min = 0
dam_multi.value = 200
dam_multi.mod = 2

local notify_sent = false
local aimhash, aimd, pped
local unfair_aimbot = menu.add_feature("unfair aim/Ped Head shot", "value_i", globalFeatures.self_ped_combat, function(feat)
    OSD_Debug_text(ssb_wep[feat.value], 0)

    if feat.on then

        local offset, offset2 = v3(), v3(0.0, 0.0, 2.8)
        pped = PlyPed(player.player_id())

        if ped.is_ped_shooting(pped) then
            aimhash = gameplay.get_hash_key(ssb_wep[feat.value])
            aimd = player.get_entity_player_is_aiming_at(me)
            if entity.is_entity_a_ped(aimd) then
                -- ped.get_ped_bone_index(aimd, 31086)
                local bonebool, pos = ped.get_ped_bone_coords(pped, 57005, offset)
                local bonebool2, pos2 = ped.get_ped_bone_coords(aimd, 12844, offset)
                -- print(pos)
                -- print(pos2)

                gameplay.shoot_single_bullet_between_coords(pos + offset2, pos2, damage, aimhash, pped, true, false, 10000.00)

            end
        end

        system.yield(0)
        return HANDLER_CONTINUE
    end
    return HANDLER_POP

end)

unfair_aimbot.max = #ssb_wep
unfair_aimbot.min = 1
unfair_aimbot.value = 1

local pos, ImpactPos = v3(), v3()
weapon_impact_pos = menu.add_feature("Get last Weapon impact POS", "toggle", globalFeatures.self_ped_combat, function(feat)
    if feat.on then
        local pped = PlyPed(player.player_id())
        local success, pos = ped.get_ped_last_weapon_impact(pped, v3())
        if success then
            ImpactPos = pos
            OSD_Debug_text(string.format("Impact POS: " .. "%s, %s, %s", pos.x, pos.y, pos.z), 0)
        else

        end
        return HANDLER_CONTINUE
    end

    return HANDLER_POP
end)
weapon_impact_pos.on = false

impact_strike = menu.add_feature("Air strike last Weapon impact POS", "value_i", globalFeatures.self_ped_combat, function(feat)
    OSD_Debug_text(string.format("Weapon Strike: " .. ssb_wep[feat.value]))
    if feat.on then
        weapon_impact_pos.on = true
        pped = PlyPed(player.player_id())
        if ped.is_ped_shooting(pped) then
            system.yield(100)

            local posm = v3()
            posm = player.get_player_coords(me)
            posm.z = posm.z + 100

            local hash = gameplay.get_hash_key(ssb_wep[feat.value])
            pos_off = v3()
            pos_off.x = pos.x + math.random(1, 5)
            pos_off.y = pos.y + math.random(1, 8)

            local playerz, zPos = gameplay.get_ground_z(pos)
            pos_off.z = zPos
            gameplay.shoot_single_bullet_between_coords(posm, ImpactPos, 1000.00, hash, BlameMe, true, false, StrikeSpeed)
            system.yield(100)
            ImpactPos.x = ImpactPos.x + 5
            gameplay.shoot_single_bullet_between_coords(posm, ImpactPos, 10000.00, hash, BlameMe, true, false, StrikeSpeed)
            system.yield(100)
            ImpactPos.y = ImpactPos.y - 5
            gameplay.shoot_single_bullet_between_coords(posm, ImpactPos, 10000.00, hash, BlameMe, true, false, StrikeSpeed)
            system.yield(100)
            ImpactPos.x = ImpactPos.x - 10
            gameplay.shoot_single_bullet_between_coords(posm, ImpactPos, 10000.00, hash, BlameMe, true, false, StrikeSpeed)
            system.yield(100)
            ImpactPos.y = ImpactPos.y + 10
            gameplay.shoot_single_bullet_between_coords(posm, ImpactPos, 10000.00, hash, BlameMe, true, false, StrikeSpeed)
            system.yield(100)
        end
        return HANDLER_CONTINUE

    end

    weapon_impact_pos.on = false
    return HANDLER_POP

end)
impact_strike.max = #ssb_wep
impact_strike.min = 1
impact_strike.on = false

impact_strike2 = menu.add_feature("2nd wep impact POS", "value_i", globalFeatures.self_ped_combat, function(feat)
    OSD_Debug_text(string.format("Weapon Strike: " .. ssb_wep[feat.value]))
    if feat.on then
        weapon_impact_pos.on = true
        local hash = gameplay.get_hash_key(ssb_wep[feat.value])
        pped = PlyPed(player.player_id())
        if ped.is_ped_shooting(pped) then

            system.wait(100)
            local bonebool, pos = ped.get_ped_bone_coords(pped, 57005, offset)

            gameplay.shoot_single_bullet_between_coords(pos, ImpactPos, 10000.00, hash, pped, true, false, 10000.0)
            system.yield(0)
        end
        return HANDLER_CONTINUE

    end

    weapon_impact_pos.on = false
    return HANDLER_POP
end)
impact_strike2.max = #ssb_wep
impact_strike2.min = 1
impact_strike2.on = false

impact_strike = menu.add_feature("Air strike Array 2 last impact POS", "value_i", globalFeatures.self_ped_combat, function(feat)
    OSD_Debug_text(string.format("Weapon Strike: " .. StrikeGive[feat.value]))
    weapon_impact_pos.on = true
    if feat.on then
        pped = PlyPed(player.player_id())
        if ped.is_ped_shooting(pped) then
            system.wait(100)

            local posm = v3()
            posm = player.get_player_coords(player.player_id())
            posm.z = posm.z + 100

            local hash = gameplay.get_hash_key(StrikeGive[feat.value])
            pos_off = v3()
            pos_off.x = pos.x + math.random(1, 5)
            pos_off.y = pos.y + math.random(1, 8)

            local playerz, zPos = gameplay.get_ground_z(pos)
            pos_off.z = zPos
            gameplay.shoot_single_bullet_between_coords(posm, ImpactPos, 1000.00, hash, BlameMe, true, false, 10000.0)
            system.wait(100)
            ImpactPos.x = ImpactPos.x + 5
            gameplay.shoot_single_bullet_between_coords(posm, ImpactPos, 10000.00, hash, BlameMe, true, false, 10000.0)
            system.wait(100)
            ImpactPos.y = ImpactPos.y - 5
            gameplay.shoot_single_bullet_between_coords(posm, ImpactPos, 10000.00, hash, BlameMe, true, false, 10000.0)
            system.wait(100)
            ImpactPos.x = ImpactPos.x - 10
            gameplay.shoot_single_bullet_between_coords(posm, ImpactPos, 10000.00, hash, BlameMe, true, false, 10000.0)
            system.wait(100)
            ImpactPos.y = ImpactPos.y + 10
            gameplay.shoot_single_bullet_between_coords(posm, ImpactPos, 10000.00, hash, BlameMe, true, false, 10000.0)
            system.wait(100)
            --  system.yield(Settings["loop_feat_delay"])
        end
        return HANDLER_CONTINUE

    end
    weapon_impact_pos.on = false
    return HANDLER_POP
end)

impact_strike.max = #StrikeGive
impact_strike.min = 1
impact_strike.on = false

impact_strike2 = menu.add_feature("Weapon Array 2 2nd Impact POS", "value_i", globalFeatures.self_ped_combat, function(feat)

    OSD_Debug_text(string.format("Weapon Strike: " .. StrikeGive[feat.value]))
    weapon_impact_pos.on = true
    if feat.on then
        local hash = gameplay.get_hash_key(StrikeGive[feat.value])
        pped = PlyPed(player.player_id())
        if ped.is_ped_shooting(pped) then

            system.wait(100)
            local bonebool, pos = ped.get_ped_bone_coords(pped, 57005, offset)

            gameplay.shoot_single_bullet_between_coords(pos, ImpactPos, 10000.00, hash, pped, true, false, 100000.0)
            -- system.yield(Settings["loop_feat_delay"])
        end
        return HANDLER_CONTINUE

    end

    weapon_impact_pos.on = false
    return HANDLER_POP
end)
impact_strike2.max = #StrikeGive
impact_strike2.min = 1
impact_strike2.on = false

aim_strike = menu.add_feature("Air strike aim entity (D pad R)", "toggle", globalFeatures.self_ped_combat, function(feat)
    if feat.on then
        if controls.is_control_pressed(6, 54) then
            local hash
            pped = PlyPed(player.player_id())

            local target = player.get_entity_player_is_aiming_at(me)

            local pos, posz, posm = v3(), v3(), v3()

            pos = entity.get_entity_coords(target)

            posz, pos.z = gameplay.get_ground_z(pos)

            posm = v3()
            posm = player.get_player_coords(me)
            posm.z = posm.z + 100

            hash = gameplay.get_hash_key("weapon_airstrike_rocket")
            pos_off = v3()
            pos_off.x = pos.x + math.random(1, 5)
            pos_off.y = pos.y + math.random(1, 8)

            playerz, zPos = gameplay.get_ground_z(pos)
            pos_off.z = zPos
            gameplay.shoot_single_bullet_between_coords(posm, pos, 1000.00, hash, pped, true, false, 10000.0)
            system.wait(100)
            pos.x = pos.x + 5
            gameplay.shoot_single_bullet_between_coords(posm, pos, 1000.00, hash, pped, true, false, 10000.0)
            system.wait(100)
            pos.y = pos.y - 5
            gameplay.shoot_single_bullet_between_coords(posm, pos, 1000.00, hash, pped, true, false, 10000.0)
            system.wait(100)

        end
        system.yield(Settings["loop_feat_delay"])
        return HANDLER_CONTINUE
    end
    return HANDLER_POP
end)
aim_strike.on = false

-- TODO: Ragdoll Control

function MoistsRagdollControl()

    Ragdoll_Sel = 0

    ragdolltyp = {{"Normal ragdoll", 0}, {"Falls with stiff legs/body", 1}, {"Narrow leg stumble(may not fall)", 2}, {"Wide leg stumble(may not fall)", 3}}
    Ragdoll_Control = menu.add_feature("Moists RagDoll Control", "parent", globalFeatures.self_ped)

    Ragdoll_set = menu.add_feature("Set Ragdoll Type", "action_value_i", Ragdoll_Control.id, function(feat)

        Ragdoll_Sel = ragdolltyp[feat.value][2]

        ui.notify_above_map("Ragdoll Type Set to: " .. ragdolltyp[feat.value][2] .. "\n(" .. ragdolltyp[feat.value][1] .. ")", "Moists Ragdoll Control", 140)
    end)
    Ragdoll_set.max = #ragdolltyp
    Ragdoll_set.min = 1
    Ragdoll_set.value = 1

    function Ragdoll0_3(feat)
        Number1, Number2, Number3, Number4, Number5 = 1900, 2000, 2000, 3000, 99999

        pped = PlyPed(player.player_id())
        ped.set_ped_to_ragdoll(pped, Number1, Number5, 0)
        pped = PlyPed(player.player_id())
        ped.set_ped_to_ragdoll(pped, Number5, Number5, Ragdoll_Sel)
        entity.apply_force_to_entity(PlyPed(player.player_id()), 1, 12, 20, 10.5, 31, 12.1, 10.3, true, true)
    end

    function RagdollButton(feat)
        Number1, Number2, Number3, Number4 = 1900, 2000, 2000, 3000

        entity.apply_force_to_entity(PlyPed(player.player_id()), 4, 10.0, 0.0, 10.0, 3.0, 0.0, 10.3, true, true)
        pped = PlyPed(player.player_id())
        ped.set_ped_to_ragdoll(pped, Number1, Number2, 0)
        entity.apply_force_to_entity(PlyPed(player.player_id()), 4, 2, 0, 0.8, 3, 2.1, 10.3, false, true)
        pped = PlyPed(player.player_id())
        ped.set_ped_to_ragdoll(pped, Number3, Number4, Ragdoll_Sel)
        -- end
        return HANDLER_POP
    end

    function RagdollButtontoggle(feat)
        while (feat.on) do

            Number1, Number2, Number3, Number4 = 1900, 2000, 2000, 3000

            pped = PlyPed(player.player_id())
            ped.set_ped_to_ragdoll(pped, Number1, Number2, 3)
            entity.apply_force_to_entity(PlyPed(player.player_id()), 5, 2, 2, 5.8, 3, 2.1, 10.3, true, true)
            pped = PlyPed(player.player_id())
            ped.set_ped_to_ragdoll(pped, Number3, Number4, Ragdoll_Sel)
            -- end
            return HANDLER_CONTINUE
        end
        return HANDLER_POP
    end

    function Ragdolltoggle(feat)
        while (feat.on) do
            Number1, Number2, Number3, Number4, Number5 = 1900, 2000, 2000, 3000, 99999

            pped = PlyPed(player.player_id())
            ped.set_ped_to_ragdoll(pped, Number1, Number2, Ragdoll_Sel)
            system.wait(100)
            entity.apply_force_to_entity(PlyPed(player.player_id()), 1, 2, 0, 0.8, 3, 2.1, 10.3, true, false)
            system.wait(100)
            pped = PlyPed(player.player_id())
            ped.set_ped_to_ragdoll(pped, Number3, Number4, Ragdoll_Sel)
            system.wait(100)
            entity.apply_force_to_entity(PlyPed(player.player_id()), 1, 2, 0, 0.8, 3, 2.1, 10.3, true, false)
            system.wait(100)
            pped = PlyPed(player.player_id())
            ped.set_ped_to_ragdoll(pped, Number4, Number5, Ragdoll_Sel)
            system.wait(100)
            -- end
            return HANDLER_CONTINUE
        end
        return HANDLER_POP
    end

    function Ragdolltoggle1(feat)
        while (feat.on) do

            Number1, Number2, Number3, Number4, Number5 = 1900, 2000, 2000, 3000, 99999
            pped = PlyPed(player.player_id())
            ped.set_ped_to_ragdoll(pped, Number1, Number2, Ragdoll_Sel)
            -- system.wait(100)
            -- entity.apply_force_to_entity(pped, 4, 2,0, 0.8, 3, 2.1, 10.3, true, false)
            -- system.wait(100)
            pped = PlyPed(player.player_id())
            ped.set_ped_to_ragdoll(pped, Number3, Number4, Ragdoll_Sel)
            -- system.wait(100)
            -- entity.apply_force_to_entity(pped, 4, 2,0, 0.8, 3, 2.1, 10.3, true, false)
            -- system.wait(100)

            pped = PlyPed(player.player_id())
            ped.set_ped_to_ragdoll(pped, Number4, Number5, Ragdoll_Sel)
            -- system.wait(100)
            -- end
            return HANDLER_CONTINUE
        end
        return HANDLER_POP
    end

    ragdoll_key = menu.add_feature("Ragdoll HotKey LCTRL+X ", "toggle", globalFeatures.moist_hotkeys, function(feat)
        Settings["RagDollHotKey"] = true
        if feat.on then

            local key = MenuKey()
            key:push_str("LCONTROL")
            key:push_str("x")
            if key:is_down() then
                rag_self.on = not rag_self.on
                ui.notify_above_map(string.format("Switching %s\n%s Ragdoll on your ped", rag_self.on and "ON" or "OFF", rag_self.on and "Setting" or "Ending"), "Moists Ragdoll Control", 140)
                system.wait(1200)
            end
            return HANDLER_CONTINUE
        end
        Settings["RagDollHotKey"] = false
        return HANDLER_POP

    end)
    ragdoll_key.on = Settings["RagDollHotKey"]

    set_rag_self = menu.add_feature("Set Self to Ragdoll", "action", Ragdoll_Control.id, RagdollButton)

    tw2rag_self = menu.add_feature("Set Ragdoll", "toggle", Ragdoll_Control.id, Ragdolltoggle1)

    force_rag_self = menu.add_feature("Set Ragdoll Apply force", "action", Ragdoll_Control.id, Ragdoll0_3)

    twrag_self = menu.add_feature("Twitching Ragdoll", "toggle", Ragdoll_Control.id, RagdollButtontoggle)

    tw1rag_self = menu.add_feature("Twitching Ragdoll v1", "toggle", Ragdoll_Control.id, Ragdolltoggle)

    rag_self = menu.add_feature("Lifeless Ragdoll(Hotkey Preset)", "toggle", Ragdoll_Control.id, function(feat)
        if feat.on then

            local Number1, Number2, Number3, Number4 = 1900, 2000, 2000, 3000
            pped = PlyPed(player.player_id());

            ped.set_ped_to_ragdoll(pped, Number1, Number2, 0)
            entity.apply_force_to_entity(pped, 4, 2, 0, 0.8, 3, 2.1, 10.3, false, true)
            ped.set_ped_to_ragdoll(pped, Number3, Number4, 4)
        end
        return HANDLER_CONTINUE
    end)
    rag_self.on = false

end
MoistsRagdollControl()

-- TODO: player ped options
function self_func()

    menu.add_feature("give self glowstick", "action", globalFeatures.self_ped, function(feat)
        local pos, offset, rot = v3(), v3(), v3()

        offset.x = 0.12
        offset.y = 0.0
        offset.z = -0.26
        rot.x = -181.0
        rot.y = 0.0
        rot.z = 0.0

        bone = ped.get_ped_bone_index(PlyPed(player.player_id()), 18905)
        spawned_cunts[#spawned_cunts + 1] = object.create_object(3324004640, pos, true, false)

        entity.attach_entity_to_entity(spawned_cunts[#spawned_cunts], PlyPed(player.player_id()), bone, offset, rot, true, false, true, 0, true)

    end)

    global_func.self = menu.add_feature("Put Handcuffs on Self", "action", globalFeatures.self_ped, function(feat)
        pped = PlyPed(player.player_id())
        if ped.get_ped_drawable_variation(pped, 7) == 25 then
            ped.set_ped_component_variation(pped, 7, 0, 0, 0)
        else
            ped.set_ped_component_variation(pped, 7, 25, 0, 0)
        end
    end)

    global_func.self = menu.add_feature("Set Handcuffs Locked Position", "action", globalFeatures.self_ped, function(feat)
        pped = PlyPed(player.player_id())
        ped.set_ped_component_variation(pped, 7, 25, 0, 0)
        weapon.give_delayed_weapon_to_ped(pped, ped_wep[2][2], 0, 1)
    end)

    global_func.self = menu.add_feature("White Team parachute Pack", "action", globalFeatures.self_ped, function(feat)

        pped = PlyPed(player.player_id())
        ped.get_ped_drawable_variation(pped, 5)
        ped.set_ped_component_variation(pped, 5, 58, 8, 0)

    end)

    -- TODO: Self Options

    local ewo_key = menu.add_feature("Self Suicide EWO", "toggle", globalFeatures.moist_hotkeys, function(feat)
        if feat.on then
            local pos = v3()
            local key = MenuKey()
            key:push_str("LALT")
            key:push_str("x")

            if key:is_down() then
                ui.notify_above_map("Suicide EWO", "KYS TRYHARD WANNABE!", 75)
                pped = PlyPed(player.player_id())

                pos = player.get_player_coords(me)
                fire.add_explosion(pos, 2, true, false, 1, pped)
                system.wait(100)
            end
            system.yield(10)
            return HANDLER_CONTINUE
        end
        return HANDLER_POP
    end)
    ewo_key.on = true

    global_func.force_wPara = menu.add_feature("Force White parachute On", "toggle", globalFeatures.self_options, function(feat)
        Settings["force_wPara"] = true
        if feat.on then
            local pped = PlyPed(player.player_id())
            ped.get_ped_drawable_variation(pped, 5)
            ped.set_ped_component_variation(pped, 5, 58, 8, 0)

            return HANDLER_CONTINUE
        end
        Settings["force_wPara"] = false
        return HANDLER_POP

    end)
    global_func.force_wPara.on = Settings["force_wPara"]

    global_func.force_pPara = menu.add_feature("Force pink parachute On", "toggle", globalFeatures.self_options, function(feat)
        Settings["force_pPara"] = true
        if feat.on then
            local pped = PlyPed(player.player_id())
            ped.get_ped_drawable_variation(pped, 5)
            ped.set_ped_component_variation(pped, 5, 58, 3, 0)

            return HANDLER_CONTINUE
        end
        Settings["force_pPara"] = false
        return HANDLER_POP

    end)
    global_func.force_pPara.on = Settings["force_pPara"]

    global_func.force_wBPH = menu.add_feature("Force White BPH On", "toggle", globalFeatures.self_options, function(feat)
        Settings["force_wBPH"] = true
        if feat.on then
            local pped = PlyPed(player.player_id())
            ped.get_ped_prop_index(pped, 0)
            ped.set_ped_prop_index(pped, 0, 59, 8, 0)


            return HANDLER_CONTINUE
        end
        Settings["force_wBPH"] = false
        return HANDLER_POP

    end)
    global_func.force_wBPH.on = Settings["force_wBPH"]

    global_func.force_pBPH = menu.add_feature("Force Pink BPH On", "toggle", globalFeatures.self_options, function(feat)
        Settings["force_pBPH"] = true
        if feat.on then
            local pped = PlyPed(player.player_id())
            if ped.get_ped_prop_index(pped, 0) ~= 59 then
                ped.get_ped_prop_index(pped, 0)
                ped.set_ped_prop_index(pped, 0, 59, 3, 0)
            end
            return HANDLER_CONTINUE
        end
        Settings["force_pBPH"] = false
        return HANDLER_POP

    end)
    global_func.force_pBPH.on = Settings["force_pBPH"]

    -- TODO: Self Options
    function vehicle_hash()
        local filepath = Paths.Root .. "\\scripts\\MoistsLUA_cfg\\"

        local luafiles = {"vehicle-hashes.lua"}
        for i = 1, #luafiles do
            dofile(string.format(filepath .. luafiles[i]))
        end
        function dofile(filename)
            local f = assert(loadfile(filename))
            return f()
        end
    end
    vehicle_hash()

    local spawn_cunt = {}
    -- TODO: Hydra Triplets

    local tripletfun = menu.add_feature("Spawn Triplet Vehicles", "parent", globalFeatures.self, function(feat)
        triplethash = nil
    end).id

    for i = 1, #vehicle_hashes do
        local feature = tostring("globalFeatures." .. "spawn" .. i)
        feature = menu.add_feature("Veh: " .. vehicle_hashes[i][1], "parent", tripletfun, function()
            triplethash = vehicle_hashes[i][2]
        end).id

        menu.add_feature("Spawn Vehicle", "action", feature, function(feat)
            TripletVeh(triplethash)
        end)

        menu.add_feature("Spawn Vehicle + Bodyguard", "action", feature, function(feat)
            TripletVeh_WithPed(triplethash)
        end)
    end

    local triplet1fun = menu.add_feature("Spawn Triplet Vehicles2", "parent", globalFeatures.self, function(feat)
        triplethash = nil
    end).id

    vehicle_hashe = {}
    vehicle_hashe = vehicle.get_all_vehicle_model_hashes()
    for i = 1, #vehicle_hashes do
        local feature = tostring("globalFeatures." .. "spawn" .. i)
        feature = menu.add_feature("Veh: " .. vehicle_hashe[i], "parent", triplet1fun, function()
            triplethash = vehicle_hashe[i]
        end).id

        menu.add_feature("Spawn Vehicle", "action", feature, function(feat)
            TripletVeh(triplethash)
        end)

        menu.add_feature("Spawn Vehicle + Bodyguard", "action", feature, function(feat)
            TripletVeh_WithPed(triplethash)
        end)
    end

    function TripletVeh(hash)
        pped = PlyPed(player.player_id())
        local bid = ped.get_ped_bone_index(pped, 17916)
        local rot, offset, pos = v3(0.0, 0.0, 0.0), v3(15.0, 0.0, 0.0), v3()
        local head = player.get_player_heading(me)
        pos = player.get_player_coords(me)
        pos.x = pos.x + 10.0
        local i = #spawned_cunts + 1

        streaming.request_model(hash)
        while (not streaming.has_model_loaded(hash)) do
            system.wait(0)
        end

        spawned_cunts[i] = vehicle.create_vehicle(hash, pos, head, true, false)
        decorator.decor_set_int(spawned_cunts[i], "MPBitset", 1 << 10)
        local attacha = spawned_cunts[i]
        local i = #spawned_cunts + 1
        spawned_cunts[i] = vehicle.create_vehicle(hash, pos, head, true, false)
        decorator.decor_set_int(spawned_cunts[i], "MPBitset", 1 << 10)
        entity.attach_entity_to_entity(spawned_cunts[i], attacha, bid, offset, rot, true, true, false, 0, true)
        vehicle.control_landing_gear(spawned_cunts[i], 3)
        local attachb = spawned_cunts[i]
        local offset = v3(-15.0, 0.0, 0.0)
        local i = #spawned_cunts + 1
        spawned_cunts[i] = vehicle.create_vehicle(hash, pos, pos.z, true, false)
        decorator.decor_set_int(spawned_cunts[i], "MPBitset", 1 << 10)
        entity.attach_entity_to_entity(spawned_cunts[i], attacha, bid, offset, rot, true, true, false, 0, true)
        vehicle.control_landing_gear(spawned_cunts[i], 3)
    end

    function TripletVeh_WithPed(hash)
        pped = PlyPed(player.player_id())
        local bid = ped.get_ped_bone_index(pped, 17916)
        local rot, offset, pos = v3(0.0, 0.0, 0.0), v3(15.0, 0.0, 0.0), v3()
        local head = player.get_player_heading(me)
        pos = player.get_player_coords(me)
        pos.x = pos.x + 10.0
        local i = #spawned_cunts + 1
        local myplygrp = player.get_player_group(me)
        local model = 0x6E42FD26
        streaming.request_model(hash)
        while (not streaming.has_model_loaded(hash)) do
            system.wait(10)
        end

        spawned_cunts[i] = vehicle.create_vehicle(hash, pos, head, true, false)
        decorator.decor_set_int(spawned_cunts[i], "MPBitset", 1 << 10)
        vehicle.set_vehicle_mod_kit_type(spawned_cunts[i], 0)
        vehicle.get_vehicle_mod(spawned_cunts[i], 10)
        vehicle.set_vehicle_mod(spawned_cunts[i], 10, 1, false)
        ped.set_ped_into_vehicle(pped, spawned_cunts[i], -1)

        local attacha = spawned_cunts[i]
        local i = #spawned_cunts + 1
        spawned_cunts[i] = vehicle.create_vehicle(hash, pos, head, true, false)
        entity.set_entity_god_mode(spawned_cunts[i], true)
        decorator.decor_set_int(spawned_cunts[i], "MPBitset", 1 << 10)
        vehicle.set_vehicle_mod_kit_type(spawned_cunts[i], 0)
        vehicle.get_vehicle_mod(spawned_cunts[i], 10)
        vehicle.set_vehicle_mod(spawned_cunts[i], 10, 1, false)
        entity.attach_entity_to_entity(spawned_cunts[i], attacha, bid, offset, rot, true, true, false, 0, true)
        vehicle.control_landing_gear(spawned_cunts[i], 3)

        local attachb = spawned_cunts[i]

        streaming.request_model(model)

        while not streaming.has_model_loaded(model) do
            system.wait(10)
        end
        local y = #spawn_cunt + 1

        spawn_cunt[y] = ped.create_ped(26, model, pos + offset, 0, true, false)

        ped.set_ped_as_group_member(spawn_cunt[y], myplygrp)
        ped.set_ped_never_leaves_group(spawn_cunt[y], true)
        ped.set_ped_can_switch_weapons(spawn_cunt[y], true)
        ped.set_ped_combat_attributes(spawn_cunt[y], 46, true)
        ped.set_ped_combat_attributes(spawn_cunt[y], 52, true)
        ped.set_ped_combat_attributes(spawn_cunt[y], 1, true)
        ped.set_ped_combat_attributes(spawn_cunt[y], 2, true)
        ped.set_ped_combat_range(spawn_cunt[y], 2)
        ped.set_ped_combat_ability(spawn_cunt[y], 2)
        ped.set_ped_combat_movement(spawn_cunt[y], 2)
        ped.set_ped_into_vehicle(spawn_cunt[y], spawned_cunts[i], -1)

        local offset = v3(-15.0, 0.0, 0.0)
        local i = #spawned_cunts + 1
        spawned_cunts[i] = vehicle.create_vehicle(hash, pos, pos.z, true, false)
        entity.set_entity_god_mode(spawned_cunts[i], true)
        decorator.decor_set_int(spawned_cunts[i], "MPBitset", 1 << 10)
        vehicle.set_vehicle_mod_kit_type(spawned_cunts[i], 0)
        vehicle.get_vehicle_mod(spawned_cunts[i], 10)
        vehicle.set_vehicle_mod(spawned_cunts[i], 10, 1, false)
        entity.attach_entity_to_entity(spawned_cunts[i], attacha, bid, offset, rot, true, true, false, 0, true)
        local y = #spawn_cunt + 1

        spawn_cunt[y] = ped.create_ped(26, model, pos + offset, 0, true, false)

        ped.set_ped_as_group_member(spawn_cunt[y], myplygrp)
        ped.set_ped_never_leaves_group(spawn_cunt[y], true)
        ped.set_ped_can_switch_weapons(spawn_cunt[y], true)
        ped.set_ped_combat_attributes(spawn_cunt[y], 46, true)
        ped.set_ped_combat_attributes(spawn_cunt[y], 52, true)
        ped.set_ped_combat_attributes(spawn_cunt[y], 1, true)
        ped.set_ped_combat_attributes(spawn_cunt[y], 2, true)
        ped.set_ped_combat_range(spawn_cunt[y], 2)
        ped.set_ped_combat_ability(spawn_cunt[y], 2)
        ped.set_ped_combat_movement(spawn_cunt[y], 2)
        ped.set_ped_into_vehicle(spawn_cunt[y], spawned_cunts[i], -1)

        for x = 0, 32 do
            if x ~= me then
                ped.set_relationship_between_groups(5, player.get_player_group(x), myplygrp)
                ped.set_relationship_between_groups(5, myplygrp, player.get_player_group(x))
            end
        end
    end

    -- TODO: Countermeasure Hotkey

    local Counter_key = menu.add_feature("Flare Countermeasures", "value_i", globalFeatures.moist_hotkeys, function(feat)

        Settings["counter_Hotkey"] = true

        if feat.on then

            local key = MenuKey()
            key:push_str("LCONTROL")
            -- key:push_str("RCONTROL")
            if key:is_down() then

                pped = PlyPed(player.player_id())

                local pos = v3()
                pos = player.get_player_coords(me)
                pos.z = pos.z + 20.00

                -- local posz
                -- posz, pos.z = gameplay.get_ground_z(pos)

                local offset = v3()
                offset.x = 15.0
                offset.y = -15.0
                offset.z = -5.0

                local speed = feat.value

                local hash = gameplay.get_hash_key("WEAPON_FLAREGUN")
                gameplay.shoot_single_bullet_between_coords(pos, pos + offset, 1000.00, hash, pped, false, true, speed)
                system.wait(10)

            end
            system.yield(10)
            return HANDLER_CONTINUE
        end
        Settings["counter_Hotkey"] = false
        return HANDLER_POP
    end)
    Counter_key.on = Settings["counter_Hotkey"]
    Counter_key.max = 10000
    Counter_key.min = 1
    Counter_key.value = 1550
    Counter_key.mod = 75

    global_func.BailExit = menu.add_feature("Bail/Exit Vehicle", "action_value_i", globalFeatures.self_veh, function(feat)
        pped = PlyPed(player.player_id())

        local eject = {0, 1, 16, 64, 256, 4160, 262144, 320, 512, 131072}
        ai.task_leave_vehicle(pped, player.get_player_vehicle(me), eject[feat.value])

        return HANDLER_POP
    end)
    global_func.BailExit.max = #eject
    global_func.BailExit.min = 1
    global_func.BailExit.value = 6

    global_func.Veh_no_col = menu.add_feature("Vehicle has no collision", "toggle", globalFeatures.self_veh, function(feat)
        if not feat.on then
            local myped = PlyPed(player.player_id())
            if ped.is_ped_in_any_vehicle(myped) then
                local Curveh = ped.get_vehicle_ped_is_using(myped)
                network.request_control_of_entity(Curveh)
                entity.set_entity_collision(Curveh, true, true, true)
            end
            return HANDLER_POP
        end

        local myped = PlyPed(player.player_id())
        if ped.is_ped_in_any_vehicle(myped) then
            local Curveh = ped.get_vehicle_ped_is_using(myped)
            network.request_control_of_entity(Curveh)
            entity.set_entity_collision(Curveh, false, true, true)
        end
        system.yield(Settings["loop_feat_delay"])
        return HANDLER_CONTINUE
    end)

    global_func.mk1boostrefill = menu.add_feature("VolticBoost Delayed Refill(MK1)", "toggle", globalFeatures.self_veh, function(feat)
        Settings["global_func.mk1boostrefill"] = true
        if feat.on then
            local myped = PlyPed(player.player_id())
            if ped.is_ped_in_any_vehicle(myped) == true then
                local Curveh = ped.get_vehicle_ped_is_using(myped)
                if vehicle.is_vehicle_rocket_boost_active(Curveh) == false then
                    return HANDLER_CONTINUE
                end
                system.wait(5000)
                vehicle.set_vehicle_rocket_boost_percentage(Curveh, 100.00)
            end
            system.yield(Settings["loop_feat_delay"])
            return HANDLER_CONTINUE
        end
        Settings["global_func.mk1boostrefill"] = false
        return HANDLER_POP
    end)

    global_func.mk1boostrefill.on = Settings["global_func.mk1boostrefill"]

    global_func.mk2boostrefill = menu.add_feature("VolticBoost Instant Recharge(MK2)", "toggle", globalFeatures.self_veh, function(feat)
        Settings["global_func.mk2boostrefill"] = true

        if feat.on then
            local myped = PlyPed(player.player_id())
            if ped.is_ped_in_any_vehicle(myped) == true then
                local Curveh = ped.get_vehicle_ped_is_using(myped)
                vehicle.set_vehicle_rocket_boost_refill_time(Curveh, 0.000001)
            end
            system.yield(Settings["loop_feat_delay"])
            return HANDLER_CONTINUE
        end
        Settings["global_func.mk2boostrefill"] = false
        return HANDLER_POP

    end)
    global_func.mk2boostrefill.on = Settings["global_func.mk2boostrefill"]

    global_func.veh_rapid_fire = menu.add_feature("RapidFire RepairLoop Glitch", "toggle", globalFeatures.self_veh, function(feat)
        Settings["global_func.veh_rapid_fire"] = true
        if feat.on then
            local myped = PlyPed(player.player_id())
            if ped.is_ped_in_any_vehicle(myped) == true then
                local Curveh = ped.get_vehicle_ped_is_using(myped)
                vehicle.set_vehicle_fixed(Curveh)
                vehicle.set_vehicle_deformation_fixed(Curveh)
            end
            return HANDLER_CONTINUE
        end
        Settings["global_func.veh_rapid_fire"] = false
        return HANDLER_POP
    end)
    global_func.veh_rapid_fire.on = Settings["global_func.veh_rapid_fire"]

    global_func.rapidfire_hotkey1 = menu.add_feature("RapidFire RepairLoop Hotkey", "toggle", globalFeatures.moist_hotkeys, function(feat)
        Settings["global_func.rapidfire_hotkey1"] = true
        if feat.on then
            local key = MenuKey()
            key:push_str("LCONTROL")
            key:push_str("r")
            if key:is_down() then
                global_func.veh_rapid_fire.on = not global_func.veh_rapid_fire.on
                moist_notify("Switching Rapid Fire for your Current Vehicle", global_func.veh_rapid_fire.on and "ON" or "OFF", global_func.veh_rapid_fire.on and "Glitch On" or "Set Repaired")
                system.wait(1200)
            end
            return HANDLER_CONTINUE
        end
        Settings["global_func.rapidfire_hotkey1"] = false
        return HANDLER_POP
    end)
    global_func.rapidfire_hotkey1.on = Settings["global_func.rapidfire_hotkey1"]

    -- TODO: Self Stat Hotkey Switches

    global_func.thermal_stat_switch_hotkey = menu.add_feature("Switch Thermal/NV Hotkey", "toggle", globalFeatures.moist_hotkeys, function(feat)
        Settings["global_func.thermal_stat_switch_hotkey"] = true
        local stat = Get_Last_MP("HAS_DEACTIVATE_NIGHTVISION")
        local thermalstat_hash = gameplay.get_hash_key(stat)
        if feat.on then
            local key = MenuKey()
            key:push_str("LCONTROL")
            key:push_str("F11")
            if key:is_down() then

                local state = stats.stat_get_bool(thermalstat_hash, 0)
                local setstate = not state
                stats.stat_set_bool(thermalstat_hash, setstate, true)
                moist_notify("Thermal/Nightvision State:\n", "Switched")
                system.wait(1200)
            end
            return HANDLER_CONTINUE
        end
        Settings["global_func.thermal_stat_switch_hotkey"] = false
        return HANDLER_POP
    end)
    global_func.thermal_stat_switch_hotkey.on = Settings["global_func.thermal_stat_switch_hotkey"]

    local cross_hair = menu.add_feature("Show Weapon Recticle", "toggle", globalFeatures.self_options, function(feat)
        Settings["Weapon_Recticle"] = true
        if feat.on then
            ui.show_hud_component_this_frame(14)
            return HANDLER_CONTINUE
        end
        Settings["Weapon_Recticle"] = false
        return HANDLER_POP
    end)
    cross_hair.on = Settings["Weapon_Recticle"]
end

self_func()

function set_waypoint(pid)
    local pos = v3()
    pos = player.get_player_coords(pid)
    if pos.x and pos.y then
        local coord = v2()
        coord.x = pos.x
        coord.y = pos.y
        ui.set_new_waypoint(coord)
    end

end

-- TODO: Player stats

local activecharacter_stat = menu.add_feature("Get Active Character", "action", globalFeatures.self_statcheck, function(feat)
    local stat_hash = gameplay.get_hash_key("MPPLY_LAST_MP_CHAR")

    local stat_result = stats.stat_get_int(stat_hash, 0)
    moist_notify("Last Used Character:\n", stat_result)
end)

local activecharacter_stat = menu.add_feature("is Active Character", "action", globalFeatures.self_statcheck, function(feat)
    local stat_hash = gameplay.get_hash_key("MP0_CHAR_ISACTIVE")

    local stat_result = tostring(stats.stat_get_bool(stat_hash, 0))
    moist_notify("Last Used Character:\n", stat_result)
end)

local mental_stat = menu.add_feature("Get Mental State", "action", globalFeatures.self_statcheck, function(feat)
    local stat = Get_Last_MP("PLAYER_MENTAL_STATE")
    local stat_hash = gameplay.get_hash_key(stat)
    local stat_result = stats.stat_get_float(stat_hash, 0)
    moist_notify("Current Mental State:\n", stat_result)
end)

local parachute_stat1 = menu.add_feature("Get Parachute Current Tint", "action", globalFeatures.self_statcheck, function(feat)
    local stat = Get_Last_MP("PARACHUTE_CURRENT_TINT")
    local stat_hash = gameplay.get_hash_key(stat)
    local stat_result = stats.stat_get_int(stat_hash, 0)
    moist_notify("Current Tint:\n", stat_result)
end)

local parachute_stat2 = menu.add_feature("Get Parachute Current Smoke", "action", globalFeatures.self_statcheck, function(feat)

    local stat = Get_Last_MP("PARACHUTE_CURRENT_SMOKE")
    local stat_hash = gameplay.get_hash_key(stat)
    local stat_result = stats.stat_get_int(stat_hash, 0)
    moist_notify("Current Smoke:\n", stat_result)
end)

local parachute_stat3 = menu.add_feature("Get Parachute Current Pack", "action", globalFeatures.self_statcheck, function(feat)
    local stat = Get_Last_MP("PARACHUTE_CURRENT_PACK")
    local stat_hash = gameplay.get_hash_key(stat)
    local stat_result = stats.stat_get_int(stat_hash, 1)
    moist_notify("Current Pack:\n", stat_result)
end)

local parachute_stat3 = menu.add_feature("Get Parachute Last Used", "action", globalFeatures.self_statcheck, function(feat)

    local stat = Get_Last_MP("LAST_USED_PARACHUTE")
    local stat_hash = gameplay.get_hash_key(stat)

    local stat_result = stats.stat_get_int(stat_hash, 1)
    moist_notify("Last Used Pack:\n", stat_result)
end)

local thermal = menu.add_feature("Check Thermal/NV State", "action", globalFeatures.self_statcheck, function(feat)
    local stat = Get_Last_MP("HAS_DEACTIVATE_NIGHTVISION")
    local stat_hash = gameplay.get_hash_key(stat)
    local stat_result = stats.stat_get_bool(stat_hash, 0)
    local state
    if stat_result == true then
        state = "OFF"
    else
        state = "ON"
    end
    moist_notify("Thermal/Nightvision State:\n", state)
end)

local helmet_visor = menu.add_feature("Helmet Visor State", "action", globalFeatures.self_statcheck, function(feat)
    local stat = Get_Last_MP("IS_VISOR_UP")
    local stat_hash = gameplay.get_hash_key(stat)
    local stat_result = stats.stat_get_bool(stat_hash, 0)
    if stat_result == true then
        state = "UP"
    else
        state = "DOWN"
    end
    moist_notify("Helmet Visor State:\n", state)
end)

local Defenses_forceon = menu.add_feature("Force Yacht Defences ON Assosiates", "toggle", globalFeatures.self_statsetup, function(feat)
    if feat.on then
        local stat = Get_Last_MP("YACHT_DEFENCE_SETTING")
        local stat_hash = gameplay.get_hash_key(stat)

        stats.stat_set_int(stat_hash, 7, true)
        return HANDLER_CONTINUE
    end

end)

local ClubPop = menu.add_feature("Auto Popular Nightclub", "toggle", globalFeatures.self_statsetup, function(feat)
    if feat.on then
        local stat = Get_Last_MP("CLUB_POPULARITY")
        local stat_hash = gameplay.get_hash_key(stat)
        local result = stats.stat_get_int(stat_hash, 1)
        if result < 900 then
            stats.stat_set_int(stat_hash, 1000, true)
            system.yield(20000)
        end
        system.yield(Settings["loop_feat_delay"])
        return HANDLER_CONTINUE
    end

end)

local Orb_cool = menu.add_feature("Auto Reset Orbital Cooldown", "toggle", globalFeatures.self_statsetup, function(feat)
    if feat.on then
        local stat = Get_Last_MP("ORBITAL_CANNON_COOLDOWN")
        local stat_hash = gameplay.get_hash_key(stat)
        local result = stats.stat_get_int(stat_hash, 1)
        if result ~= 0 then
            stats.stat_set_int(stat_hash, 0, true)
            system.yield(20000)
        end
        system.yield(Settings["loop_feat_delay"])
        return HANDLER_CONTINUE
    end

end)

local parachute_setstat1 = menu.add_feature("Set Parachute Current Pack", "action_value_i", globalFeatures.self_statsetup, function(feat)

    local stat = Get_Last_MP("PARACHUTE_CURRENT_PACK")
    local stat_hash = gameplay.get_hash_key(stat)

    local i = tonumber(feat.value)

    stats.stat_set_int(stat_hash, i, true)

    local stat_result = stats.stat_get_int(stat_hash, 1)
    moist_notify("Current Pack:\n", stat_result)
end)
parachute_setstat1.max = 100
parachute_setstat1.min = 0

local parachute_setstat2 = menu.add_feature("Set Parachute Current Tint", "action_value_i", globalFeatures.self_statsetup, function(feat)
    local stat = Get_Last_MP("PARACHUTE_CURRENT_TINT")
    local stat_hash = gameplay.get_hash_key(stat)

    local i = tonumber(feat.value)

    stats.stat_set_int(stat_hash, i, true)

    local stat_result = stats.stat_get_int(stat_hash, 1)
    moist_notify("Current Pack:\n", stat_result)
end)
parachute_setstat2.max = 80
parachute_setstat2.min = 0

-- TODO: Force Mental State
mental_statset = menu.add_feature("Set Mental State", "action_value_i", globalFeatures.self_statsetup, function(feat)
    local stat = Get_Last_MP("PLAYER_MENTAL_STATE")
    local stat_hash = gameplay.get_hash_key(stat)

    local i = tonumber(feat.value)
    local stat_result1 = stats.stat_get_float(stat_hash, 0)
    stats.stat_set_float(stat_hash, i, true)
    local stat_result2 = stats.stat_get_float(stat_hash, 0)
    moist_notify("Previous Mental State: " .. stat_result1, "\nNow: " .. stat_result2)

end)
mental_statset.max = 100
mental_statset.min = 0
mental_statset.value = 0

local thermal_set = menu.add_feature("Switch Helmet Visor State", "action", globalFeatures.self_statsetup, function(feat)

    local stat = Get_Last_MP("IS_VISOR_UP")
    local stat_hash = gameplay.get_hash_key(stat)

    local statenow
    local state = stats.stat_get_bool(stat_hash, 0)
    local setstate = not state

    stats.stat_set_bool(stat_hash, setstate, true)
    local stat_result = stats.stat_get_bool(stat_hash, 0)
    if stat_result == true then
        statenow = "UP"
    else
        statenow = "DOWN"
    end

    moist_notify("Switch Helmet Visor State:\n", statenow)

end)

local helmet_visor_set = menu.add_feature("Switch Thermal/NV State", "action", globalFeatures.self_statsetup, function(feat)

    local stat = Get_Last_MP("HAS_DEACTIVATE_NIGHTVISION")
    local stat_hash = gameplay.get_hash_key(stat)
    local state = stats.stat_get_bool(stat_hash, 0)
    local setstate = not state
    local statenow
    stats.stat_set_bool(stat_hash, setstate, true)

    local stat_result = stats.stat_get_bool(stat_hash, 0)
    if stat_result == true then
        statenow = "OFF"
    else
        statenow = "ON"
    end

    moist_notify("Thermal / Nightvision State:\n", statenow)

end)

-- TODO: Quick Stat Setups

local em_rec = {}

local setup_casinostats = menu.add_feature("Setup Casino Heist Stealth Diamonds", "action", globalFeatures.quick_stats, function(feat)

    for i = 1, #heiststat_setup do

        local stat = Get_Last_MP(heiststat_setup[i][1])
        local stat_hash = gameplay.get_hash_key(stat)
        em_rec[#em_rec + 1] = stats.stat_get_int(stat_hash, 0)

        stats.stat_set_int(stat_hash, heiststat_setup[i][2], true)
    end
    moist_notify("Stats Setup", "\nFinished")
    moist_notify("Now Creating Stat Recovery Script\n", "Saved in scripts folder")
    Create_stat_RecoveryScript()
    moist_notify("Stats Recovery Script", "\ndone")

end)
script_recovery = menu.add_feature("Recovery/Transfer", "parent", globalFeatures.self_statsetup)

local character_design = {"MESH_HEADBLEND", "MESH_TEXBLEND", "MESH_VARBLEND", "HEADBLEND_OVER_BLEMISH_PC", "HEADBLEND_OVERLAY_BEARD_PC", "HEADBLEND_OVERLAY_EYEBRW_PC", "HEADBLEND_OVERLAY_WETHR_PC", "HEADBLEND_OVERLAY_MAKEUP_PC", "HEADBLEND_OVERLAY_DAMAGE_PC", "HEADBLEND_OVERLAY_BASE_PC", "HEADBLEND_GEOM_BLEND", "HEADBLEND_TEX_BLEND", "HEADBLEND_VAR_BLEND", "HEADBLEND_DOM", "FEATURE_0", "FEATURE_1", "FEATURE_2", "FEATURE_3", "FEATURE_4", "FEATURE_5", "FEATURE_6", "FEATURE_7",
                          "FEATURE_8", "FEATURE_9", "FEATURE_10", "FEATURE_11", "FEATURE_12", "FEATURE_13", "FEATURE_14", "FEATURE_15", "FEATURE_16", "FEATURE_17", "FEATURE_18", "FEATURE_19", "FEATURE_20", "HEADBLENDOVERLAYCUTS_PC", "HEADBLENDOVERLAYMOLES_PC", "HEADBLEND_OVERLAY_BLUSHER", "OVERLAY_BODY_2", "OVERLAY_BODY_3", "OVERLAY_BODY_1"}
local des_rec = {}

char_design = menu.add_feature("Create Character Design Script", "action", script_recovery.id, function(feat)

    local design_value = {"1.0", "0.0", "1.0", "1.0", "1.0", "1.0", "1.0", "0.050000000745058", "0.83787792921066", "0.0", "0.0"}
    for i = 1, #character_design do
        local stat = Get_Last_MP(character_design[i])
        local stat_hash = gameplay.get_hash_key(stat)
        des_rec[i] = stats.stat_get_float(stat_hash, 0)

    end
    Create_stat_Script()

end)

function write_recScript(text)
    local file = io.open(Paths.Root .. "\\scripts\\Moists_statrecovery.lua", "a")
    io.output(file)
    io.write(text)
    io.close()
end

function write_stat(text)
    local file = io.open(Paths.Root .. "\\scripts\\Moists_stat_out.lua", "a")
    io.output(file)
    io.write(text)
    io.close()
end

function Create_stat_Script()
    local txt = Cur_Date_Time()
    write_stat('function Get_Last_MP(a)local b=a;local c=gameplay.get_hash_key("MPPLY_LAST_MP_CHAR")local d=stats.stat_get_int(c,1)return string.format("MP"..d.."_"..b)end;function Get_Hash(e)return gameplay.get_hash_key(e)end\n\n')
    write_stat('menu.add_feature("statwriter Player Design' .. txt .. '", "action", 0, function(feat)\n\n')
    for i = 1, #character_design do

        write_stat('local stat = Get_Hash(Get_Last_MP("' .. character_design[i] .. '"))\n')

        write_stat('stats.stat_set_float(stat, ' .. des_rec[i] .. ', ' .. 'true)\n')
    end
    write_stat('end)\n\n')

    des_rec = {}

end

function Create_stat_RecoveryScript()

    for i = 1, #heiststat_setup do

        local stat = Get_Last_MP(heiststat_setup[i][1])
        local stat_hash = gameplay.get_hash_key(stat)

    end
    local txt = Cur_Date_Time()
    write_recScript('menu.add_feature("Stat Recovery' .. txt .. '", "action", 0, function(feat)\n\n')
    for i = 1, #em_rec do
        local stat, statval = heiststat_setup[i][2], em_rec[i]

        write_recScript('stats.stat_set_int(' .. stat .. ', ' .. statval .. ', ' .. 'true)\n')
    end
    write_recScript('end)\n\n')
    em_rec = {}

end

-- TODO: local session Features

otr_all = menu.add_feature("Give everyone OTR", "action", globalFeatures.lobby, function(feat)
    for pid = 0, 32 do
        script.trigger_script_event(575518757, pid, {pid, utils.time() - 60, utils.time(), 1, 1, script.get_global_i(1630317 + (1 + (pid * 595)) + 506)})

    end
end)

nocops_all = menu.add_feature("Give everyone Cop Bribe", "action", globalFeatures.lobby, function(feat)
    for pid = 0, 32 do
        script.trigger_script_event(392501634, pid, {pid, utils.time() - 60, utils.time(), script.get_global_i(2540384 + 4624), 1, script.get_global_i(1630317 + (1 + (pid * 595)) + 506)})

    end
end)

blip_all = menu.add_feature("Give everyone Enemy Blips", "action", globalFeatures.lobby, function(feat)
    for i = 0, 32 do
        local scid = GetSCID(i)
        if scid ~= 4294967295 then
            local pped = PlyPed(i)
            local oldblip = ui.get_blip_from_entity(pped)
            ui.set_blip_colour(oldblip, 80)
            BlipIDs[#BlipIDs + 1] = ui.add_blip_for_entity(pped)
            ui.set_blip_colour(BlipIDs[#BlipIDs], i)
        end
    end
end)

function blockpassiveall()

    for i = 0, 32 do
        fnd = player.is_player_friend(i)
        if i ~= player.player_id() or i ~= fnd then
            script.trigger_script_event(0xC9CC4F80, i, {1, 1})
            script.trigger_script_event(3385610112, i, {1, 1})

        end
    end
end

local notmarkall = function()

    for i = 0, 32 do
        if i ~= player.player_id() then

        end
        player.unset_player_as_modder(i, -1)
    end
end

local notallmod = menu.add_feature("UnMark all Players as Modder", "action", globalFeatures.protex, function(feat)
    notmarkall()
end)

-- TODO: Session Kicks

local NetBail_SHF_Kick = menu.add_feature("ScriptHost Fuckarino", "toggle", globalFeatures.kick, function(feat)
    if feat.on then

        for i = 0, 32 do
            if player.is_player_valid(i) then
                local fnd = player.is_player_friend(i)
                if i ~= player.player_id() or i ~= fnd then
                    script.trigger_script_event(-2122716210, i, {91645, -99683, 1788, 60877, 55085, 72028})
                    script.trigger_script_event(-2120750352, i, {i, script.get_global_i(1630317 + (1 + (i * 595)) + 506)})
                    script.trigger_script_event(0xE6116600, i, {i, script.get_global_i(1630317 + (1 + (i * 595)) + 506)})
                    script.trigger_script_event(-977515445, i, {-1, 500000, 849451549, -1, -1})
                    script.trigger_script_event(767605081, i, {-1, 500000, 849451549, -1, -1})
                    script.trigger_script_event(-1949011582, i, {-1139568479, -1, 1, 100099})
                    script.trigger_script_event(-2122716210, i, {-1139568479, -1, 1, 100099, -1, 500000, 849451549, -1, -1, 91645, -99683, 1788, 60877, 55085, 72028})
                    script.trigger_script_event(-922075519, i, {-1, -1, -1, -1, -1139568479, -1, 1, 100099, -1, 500000, 849451549, -1, -1, 91645, -99683, 1788, 60877, 55085, 72028})
                    script.trigger_script_event(-1975590661, i, {-1139568479, -1, 1, 100099, -1, 500000, 849451549, -1, -1, 91645, -99683, 1788, 60877, 55085, 72028})
                end
                if Settings["ScriptEvent_delay"] ~= 0 then
                    system.yield(Settings["ScriptEvent_delay"])
                end
            end
        end
        return HANDLER_CONTINUE
    end
    return HANDLER_POP
end)

local Kick2Session = menu.add_feature("Session Kick Data2 Type2", "toggle", globalFeatures.kick, function(feat)
    if feat.on then
        for pid = 0, 32 do
            if player.is_player_valid(pid) then
                local fnd = player.is_player_friend(pid)
                if pid ~= player.player_id() or pid ~= fnd then

                    local pos = v3()
                    pos = player.get_player_coords(pid)
                    pos.x = math.floor(pos.x)
                    pos.y = math.floor(pos.y)
                    pos.z = math.floor(pos.z)
                    par1 = math.random(104574922, 9999999999)
                    par2 = math.random(-99999999999999, -1)
                    par3 = math.random(461908681885, 99999999999999)
                    par4 = math.random(-999999999999, -1)
                    par5 = math.random(9999999999999, 46190868453454)
                    spc1 = math.random(1090682, 2590682)
                    spc2 = math.floor(math.random(100, 900))
                    spc3 = math.floor(math.random(400, 900))
                    spc4 = math.floor(math.random(100, 400))
                    spc5 = math.floor(math.random(10, 100))

                    for i = 1, #data2 do
                        script.trigger_script_event(data2[i], pid, {par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1})
                        script.trigger_script_event(data2[i], pid, {pid, pos.x, pos.y, pos.z, 0, 0, spc3, 0, script.get_global_i(spc1 + (pid * spc2) + spc5 + spc5), 1})
                        script.trigger_script_event(data2[i], pid, {pid, pos.x, pos.y, pos.z, 0, 0, spc2, 0, script.get_global_i(spc1 + (pid * spc3) + spc4 + spc5), 1})

                    end
                end
                if Settings["ScriptEvent_delay"] ~= 0 then
                    system.yield(Settings["ScriptEvent_delay"])
                end
            end
        end

        return HANDLER_CONTINUE
    end
    return HANDLER_POP
end)

passive_players = {}

function Set_PassiveTracker()
    for i = 1, 32 do
        passive_players[i] = false
    end
end
Set_PassiveTracker()

Passive_trackerIN = event.add_event_listener("player_join", function(e)
    local pid = tonumber(e.player)
    passive_players[pid + 1] = false
    return
end)

Passive_trackerOUT = event.add_event_listener("player_leave", function(e)
    local pid = tonumber(e.player)
    Modders_DB[pid + 1].flag = nil
    Modders_DB[pid + 1].ismod = false
    passive_players[pid + 1] = false
    Players[pid].bounty = false
    Players[pid].bountyvalue = nil
    Players[pid].isvgod = false
    Players[pid].isgod = false
    Players[pid].isint = false
    Players[pid].isvis = false
    SessionPlayers[pid].scid = 4294967295
    SessionPlayers[pid].Name = "nil"
    return
end)

-- TODO: Bounty SEP
local bountyhook_id = 0
bountyhook_event = function(source, target, params, count)

    local player_source = player.get_player_name(source)
    if params[1] == 0xf90cc891 then
        Players[source].bounty = true
        Players[source].bountyvalue = params[5]

        return false
    elseif params[1] == 0x7ab43bfa then
        Players[source].bounty = false
        Players[source].bountyvalue = nil
        return false
    end
    return
end

sep1 = function(feat)
    if bountyhook.on then
        bountyhook_id = hook.register_script_event_hook(bountyhook_event)
        return HANDLER_POP
    end

    if bountyhook_id ~= 0 then
        hook.remove_script_event_hook(bountyhook_id)
        bountyhook_id = 0
    end
end

bountyhook = menu.add_feature("SEP Bounty Value", "toggle", globalFeatures.moist_tools.id, sep1)
bountyhook.on = true

local testhook_id = 0
testhook_event = function(source, target, params, count)

    local player_source = player.get_player_name(source)
    if params[1] == 0xB0886E20 then

        return false
    end
    return
end

sep2 = function(feat)
    if bountyhook.on then
        bountyhook_id = hook.register_script_event_hook(testhook_event)
        return HANDLER_POP
    end

    if testhook_id ~= 0 then
        hook.remove_script_event_hook(testhook_id)
        testhook_id = 0
    end
end

testhook = menu.add_feature("SEP Bounty Value", "toggle", globalFeatures.moist_tools.id, sep2)
testhook.on = true

local passivehook_id = 0
local passivehook_event = function(source, target, params, count)

    local player_source = player.get_player_name(source)
    if params[1] == 2098987581 then
        passive_players[source + 1] = true
        return false
    elseif params[1] == 465570678 then
        passive_players[source + 1] = false
        return false
    end
    return false
end

sep = function(feat)
    if passivehook_Alert.on then
        passivehook_id = hook.register_script_event_hook(passivehook_event)
        return HANDLER_POP
    end

    if passivehook_id ~= 0 then
        hook.remove_script_event_hook(passivehook_id)
        passivehook_id = 0
    end
end

passivehook_Alert = menu.add_feature("Custom SEP Passive", "toggle", globalFeatures.moist_tools.id, sep)
passivehook_Alert.on = true

local SECrash = {-977515445, 767605081, -1730227041, -1949011582, -2122716210, -1882923979}

function build_params(argcnt)
    local ParaMs = {}

    for i = 1, argcnt do
        local y = math.random(1, #kick_param_data)
        ParaMs[i] = kick_param_data[y]
    end
    return ParaMs
end

local SEC_SESS = menu.add_feature("Script Event Crash Session", "toggle", globalFeatures.kick, function(feat)
    local Params = build_params(120)
    if feat.on then
        for i = 0, 32 do

            if player.is_player_valid(i) then
                local fnd = player.is_player_friend(i)
                if i ~= player.player_id() or i ~= fnd then
                    for y = 1, #SECrash do
                        script.trigger_script_event(SECrash[y], i, Params)
                    end
                end
            end

            if Settings["ScriptEvent_delay"] ~= 0 then
                system.yield(Settings["ScriptEvent_delay"])
            end
        end
        return HANDLER_CONTINUE
    end
    return HANDLER_POP
end)

-- TODO: Force host

local hostnow

HostForce = menu.add_feature("Kick Host until Session host", "toggle", globalFeatures.kick, function(feat)

    if feat.on then
        -- HostForce_togglecheck.on = true
        hostnow = player.get_host()
        fnd = player.is_player_friend(hostnow)
        if not network.network_is_host() then
            if hostnow ~= player.player_id() or hostnow ~= fnd then
                player.unset_player_as_modder(hostnow, -1)
                script.trigger_script_event(-2120750352, hostnow, {hostnow, script.get_global_i(1630317 + (1 + (hostnow * 595)) + 506)})
                script.trigger_script_event(0xE6116600, hostnow, {hostnow, script.get_global_i(1630317 + (1 + (hostnow * 595)) + 506)})
                system.yield(10)
                script.trigger_script_event(0xc5bc4c4b, hostnow, {-72614, 63007, 59027, -12012, -26996, 33399})
                script.trigger_script_event(-2122716210, hostnow, {91645, -99683, 1788, 60877, 55085, 72028})
                script.trigger_script_event(-2120750352, hostnow, {hostnow, script.get_global_i(1630317 + (1 + (hostnow * 595)) + 506)})
                script.trigger_script_event(0xE6116600, hostnow, {hostnow, script.get_global_i(1630317 + (1 + (hostnow * 595)) + 506)})
                script.trigger_script_event(-977515445, hostnow, {-1, 500000, 849451549, -1, -1})
                script.trigger_script_event(767605081, hostnow, {-1, 500000, 849451549, -1, -1})
                script.trigger_script_event(-1949011582, hostnow, {-1139568479, -1, 1, 100099})
                script.trigger_script_event(-2122716210, hostnow, {-1139568479, -1, 1, 100099, -1, 500000, 849451549, -1, -1, 91645, -99683, 1788, 60877, 55085, 72028})
                script.trigger_script_event(-922075519, hostnow, {-1, -1, -1, -1, -1139568479, -1, 1, 100099, -1, 500000, 849451549, -1, -1, 91645, -99683, 1788, 60877, 55085, 72028})
                script.trigger_script_event(-1975590661, hostnow, {-1139568479, -1, 1, 100099, -1, 500000, 849451549, -1, -1, 91645, -99683, 1788, 60877, 55085, 72028})
            end
        end
        if network.network_is_host() then
            HostForce.on = false
            return
        end
        if Settings["ScriptEvent_delay"] ~= 0 then
            system.yield(Settings["ScriptEvent_delay"])
        end
        return HANDLER_CONTINUE
    end
    return HANDLER_POP
end)
HostForce.on = false

local netbailkick = menu.add_feature("Network Bail Kick", "toggle", globalFeatures.kick, function(feat)
    if feat.on then

        for i = 0, 32 do

            if player.is_player_valid(i) then
                local fnd = player.is_player_friend(i)
                if i ~= player.player_id() or i ~= fnd then
                    script.trigger_script_event(-81613951, i, {i, script.get_global_i(1630317 + (1 + (i * 595)) + 506)})
                    script.trigger_script_event(-1292453789, i, {i, script.get_global_i(1630317 + (1 + (i * 595)) + 506)})
                    script.trigger_script_event(1623637790, i, {i, script.get_global_i(1630317 + (1 + (i * 595)) + 506)})
                    script.trigger_script_event(-1905128202, i, {i, script.get_global_i(1630317 + (1 + (i * 595)) + 506)})
                    script.trigger_script_event(1160415507, i, {i, script.get_global_i(1630317 + (1 + (i * 595)) + 506)})
                    script.trigger_script_event(-2120750352, i, {i, script.get_global_i(1630317 + (1 + (i * 595)) + 506)})
                    script.trigger_script_event(0xe6116600, i, {i, script.get_global_i(1630317 + (1 + (i * 595)) + 506)})

                end
            end
            if Settings["ScriptEvent_delay"] ~= 0 then
                system.yield(Settings["ScriptEvent_delay"])
            end
        end
        return HANDLER_CONTINUE
    end
    return HANDLER_POP
end)

local netbail_kick = menu.add_feature("Session Bail except Host", "toggle", globalFeatures.kick, function(feat)
    if feat.on then

        for i = 0, 32 do
            if player.is_player_valid(i) then
                local fnd = player.is_player_friend(i)
                if i ~= player.player_id() or i ~= fnd then
                    if i ~= network.network_is_host() then

                        script.trigger_script_event(0xe6116600, i, {i, script.get_global_i(1630317 + (1 + (i * 595)) + 506)})
                    end

                end

                if Settings["ScriptEvent_delay"] ~= 0 then
                    system.yield(Settings["ScriptEvent_delay"])
                end
            end
        end
        return HANDLER_CONTINUE
    end
    return HANDLER_POP
end)

local hostnotify = false
function hostkickall(pid)

    network.network_session_kick_player(pid)
end

local hostkick = menu.add_feature("Host Kick All", "toggle", globalFeatures.kick, function(feat)
    if feat.on then
        if not network.network_is_host() then
            if not hostnotify then
                moist_notify("You are not Session Host Yet!", "\nTake Host first")
                hostnotify = true
            end
        end

        if network.network_is_host() then
            hostnotify = false
            for i = 0, 32 do
                if player.is_player_valid(i) then

                    if i ~= player.player_id() then
                        if i ~= player.is_player_friend(i) then
                            hostkickall(i)
                        end
                    end
                end
            end
            if Settings["ScriptEvent_delay"] ~= 0 then
                system.yield(Settings["ScriptEvent_delay"])
            end
        end
        return HANDLER_CONTINUE
    end
    hostnotify = false
    return HANDLER_POP
end)

local all_mod = menu.add_feature("Mark all Players as Modder", "toggle", globalFeatures.protex, function(feat)
    if feat.on then

        for i = 0, 32 do
            for i = 0, 32 do
                local Me = me
                if i ~= Me then
                    if i ~= player.is_player_friend(i) then
                        player.set_player_as_modder(i, 1)
                        player.set_player_as_modder(i, mod_flag_1)
                        player.set_player_as_modder(i, mod_flag_2)
                    end
                end
            end
        end
        system.yield(Settings["loop_feat_delay"])
        return HANDLER_CONTINUE
    end
    return HANDLER_POP
end)
all_mod.on = false

-- TODO: World stuff
-- **WATER WAVE MODIFIERS (local)**

local Moists_Wave_Mod = function()
    local wave_int_cur = tostring("~q~~h~" .. water.get_waves_intensity())

    function Moist_WaveMod()

        CurrentIntensity = tostring(wave_int_cur)
        -- ui.notify_above_map("~w~~h~Current Wave Intensity is:".." " ..wave_int_cur.." ", "Moists Wave Mod", 212)
    end

    wave_int_osd = menu.add_feature("Get Current Wave Intensity", "toggle", globalFeatures.Wave, function(feat)

        if feat.on then

            local pos = v2()
            pos.x = .05
            pos.y = .0006
            ui.set_text_scale(0.25)
            ui.set_text_font(0)
            ui.set_text_centre(0)
            ui.set_text_color(255, 0, 0, 255)
            ui.set_text_outline(1)
            ui.draw_text("Wave Intensity: " .. wave_int_cur, pos)
            return HANDLER_CONTINUE
        end

        return HANDLER_POP
    end)
    wave_int_osd.on = false

    waveintmodifiers = menu.add_feature("Persistant Wave Intensity", "value_i", globalFeatures.Wave, function(feat)

        if feat.on then
            local x = feat.value / 10
            water.set_waves_intensity(x)
            Moist_WaveMod()
            system.yield(Settings["loop_feat_delay"])
            return HANDLER_CONTINUE
        end
        return HANDLER_POP
    end)
    waveintmodifiers.max = 500000
    waveintmodifiers.min = -200
    waveintmodifiers.mod = 1

    waveintmodifiers = menu.add_feature("Change Wave Intensity", "action_value_i", globalFeatures.Wave, function(feat)

        local x = feat.value / 10
        water.set_waves_intensity(x)
        Moist_WaveMod()
    end)
    waveintmodifiers.max = 500000
    waveintmodifiers.min = -200
    waveintmodifiers.mod = 1

    menu.add_feature("Change step Size", "autoaction_i", globalFeatures.Wave, function(feat)
        waveintmodifiers.mod = f.value_i
    end)

    local wavemodifiers = menu.add_feature("Reset Intensity", "action", globalFeatures.Wave, function(feat)
        water.reset_waves_intensity()
    end)
end
Moists_Wave_Mod()

local World_Clean = function()
    local cleanup_done = true

    clear_World_ent = menu.add_feature("Fetched World Entities Move & Delete", "action", globalFeatures.entity_removal, function(feat)
        if not cleanup_done == true then
            return
        end
        cleanup_done = false

        moist_notify("Trying to Removal All\nCunts in the World\n", " Cleanups Disabled until Done!")
        get_everything()
        system.wait(500)
        clear_world()
        moist_notify("Cunts Removed only Cunt Left: ", "~y~is you!~y~\nCleanups Enabled")

    end)

    clear_peds = menu.add_feature("Fetch all Peds Move & Delete", "action", globalFeatures.entity_removal, function(feat)
        if not cleanup_done == true then
            return
        end
        cleanup_done = false

        moist_notify("Ped Clearing Started\n", " Cleanups Disabled until Done!")

        get_allpeds()
        system.wait(250)
        move_delete_peds()
        moist_notify("Only Peds left are Cunts\n", " Cleanups Enabled")
    end)

    fetch_obj = menu.add_feature("Fetch all objects Move & Delete", "action", globalFeatures.entity_removal, function(feat)
        if not cleanup_done == true then
            return
        end
        cleanup_done = false

        moist_notify("Cunt Cleaning Started: \n", " Cleanups Disabled until Done!")
        get_allobj()
        system.wait(250)
        move_delete_obj()
        moist_notify("Cuntish Objects Removed\n", " Cleanups Enabled")
    end)

    fetch_veh = menu.add_feature("Fetch all Vehicles Move & Delete", "action", globalFeatures.entity_removal, function(feat)
        if not cleanup_done == true then
            return
        end
        cleanup_done = false
        moist_notify("Cunt Cleanup Started\n", " Cleanups Disabled until Done!")
        get_allveh()
        system.wait(250)
        move_delete_veh()
        moist_notify("Vehicles Cleared\n", " Cleanups Enabled")
    end)

    fetch_veh = menu.add_feature("Fetch all Pickups Move & Delete", "action", globalFeatures.entity_removal, function(feat)
        if not cleanup_done == true then
            return
        end
        cleanup_done = false
        moist_notify("Cunt Cleanup Started\n", " Cleanups Disabled until Done!")
        get_all_pickups()
        system.wait(250)
        move_delete_pickups()
        moist_notify("Vehicles Cleared\n", " Cleanups Enabled")
    end)

    function get_allpeds()
        allpeds = ped.get_all_peds()
    end
    function get_allveh()
        allveh = vehicle.get_all_vehicles()
    end
    function get_allobj()
        allobj = object.get_all_objects()
    end
    function get_all_pickups()
        allpickups = object.get_all_pickups()
    end

    function get_everything()

        get_all_pickups()
        get_allveh()
        get_allobj()
        get_allpeds()
        object.get_all_pickups()
    end

    function clear_world()
        local pos = v3()
        pos.x = -5784.258301
        pos.y = -8289.385742
        pos.z = -136.411270

        get_all_pickups()
        get_allveh()
        get_allobj()
        get_allpeds()
        object.get_all_pickups()

        if not (#allpeds) == nil or 0 then
            for i = 1, #allpeds do
                if not ped.is_ped_a_player(allpeds[i]) then
                    network.request_control_of_entity(allpeds[i])
                    entity.set_entity_coords_no_offset(allpeds[i], pos)
                    entity.set_entity_as_no_longer_needed(allpeds[i])
                    entity.delete_entity(allpeds[i])
                    system.wait(25)
                end
            end
        end
        allpeds = {}
        if not (#allpickups) == nil or 0 then
            for i = 1, #allpickups do
                network.request_control_of_entity(allpickups[i])
                entity.set_entity_coords_no_offset(allpickups[i], pos)
                entity.set_entity_as_no_longer_needed(allpickups[i])
                entity.delete_entity(allpickups[i])
                system.wait(10)
            end
        end
        allpickups = {}
        if not (#allveh) == nil or 0 then
            for i = 1, #allveh do
                if entity.is_an_entity(allveh[i]) then
                    if not decorator.decor_exists_on(allveh[i], "Player_Vehicle") then
                        network.request_control_of_entity(allveh[i])
                        entity.set_entity_coords_no_offset(allveh[i], pos)
                        entity.set_entity_as_no_longer_needed(allveh[i])
                        entity.delete_entity(allveh[i])
                        system.wait(25)
                    end
                end
            end
        end
        allveh = {}
        if not (#allobj) == nil or 0 then
            for i = 1, #allobj do
                network.request_control_of_entity(allobj[i])
                entity.set_entity_coords_no_offset(allobj[i], pos)
                entity.set_entity_as_no_longer_needed(allobj[i])
                entity.delete_entity(allobj[i])
                system.wait(25)
            end
        end
        allobj = {}
        cleanup_done = true
        return HANDLER_POP
    end

    function move_delete_obj()

        local pos = v3()
        pos.x = -5784.258301
        pos.y = -8289.385742
        pos.z = -136.411270
        for i = 1, #allobj do
            if not #allobj == nil or 0 then
                network.request_control_of_entity(allobj[i])
                entity.set_entity_coords_no_offset(allobj[i], pos)
                entity.set_entity_as_no_longer_needed(allobj[i])
                entity.delete_entity(allobj[i])
                system.wait(25)
            end
        end
        allobj = {}
        cleanup_done = true
        return HANDLER_POP
    end

    function move_delete_peds()

        local pos = v3()
        pos.x = -5784.258301
        pos.y = -8289.385742
        pos.z = -136.411270

        for i = 1, #allpeds do
            if not #allpeds == nil or 0 then
                if not ped.is_ped_a_player(allpeds[i]) then
                    network.request_control_of_entity(allpeds[i])
                    entity.set_entity_coords_no_offset(allpeds[i], pos)
                    entity.set_entity_as_no_longer_needed(allpeds[i])
                    entity.delete_entity(allpeds[i])
                    system.wait(25)
                end
            end

        end
        allpeds = {}
        cleanup_done = true
        return HANDLER_POP
    end

    function move_delete_veh()

        local pos = v3()
        pos.x = -5784.258301
        pos.y = -8289.385742
        pos.z = -136.411270

        for i = 1, #allveh do
            if entity.is_an_entity(allveh[i]) then
                if not decorator.decor_exists_on(allveh[i], "Player_Vehicle") then

                    network.request_control_of_entity(allveh[i])
                    entity.set_entity_coords_no_offset(allveh[i], pos)
                    entity.set_entity_as_no_longer_needed(allveh[i])
                    entity.delete_entity(allveh[i])
                    system.wait(25)
                end
            end
        end

        allveh = {}

        cleanup_done = true
        return HANDLER_POP

    end

    function move_delete_pickups()

        local pos = v3()
        pos.x = -5784.258301
        pos.y = -8289.385742
        pos.z = -136.411270

        for i = 1, #allpickups do
            if entity.is_an_entity(allpickups[i]) then
                network.request_control_of_entity(allpickups[i])
                entity.set_entity_coords_no_offset(allpickups[i], pos)
                entity.set_entity_as_no_longer_needed(allpickups[i])
                entity.delete_entity(allpickups[i])
                system.wait(25)
            end
        end
    end

    allpickups = {}

    cleanup_done = true
    return HANDLER_POP

end
World_Clean()

-- TODO: --------------------------Session Troll------------------
local PedHaters, player_groups, player_peds = {}, {}, {}
local GroupHate

function Peds_hateWorld(pid, weap)
    PedHaters, player_groups, player_peds = {}, {}, {}

    player_groups[pid + 1] = player.get_player_group(pid)
    player_peds[pid + 1] = PlyPed(pid)

    PedHaters = ped.get_all_peds()

    system.wait(100)

    GroupHate = ped.create_group()

    for y = 1, #player_groups do

        ped.set_relationship_between_groups(5, player_groups[y], GroupHate)

        ped.set_relationship_between_groups(5, GroupHate, player_groups[y])
    end

    for i = 1, #PedHaters do
        if not ped.is_ped_a_player(PedHaters[i]) then
            network.request_control_of_entity(PedHaters[i])
            ped.set_ped_max_health(PedHaters[i], 7000)
            ped.set_ped_health(PedHaters[i], 7000)
            entity.set_entity_god_mode(PedHaters[i], true)
            ped.set_ped_as_group_member(PedHaters[i], GroupHate)
            ped.set_ped_never_leaves_group(PedHaters[i], true)
            ped.set_ped_can_switch_weapons(PedHaters[i], true)
            ped.set_ped_combat_attributes(PedHaters[i], 46, true)
            ped.set_ped_combat_attributes(PedHaters[i], 52, true)
            ped.set_ped_combat_attributes(PedHaters[i], 1, true)
            ped.set_ped_combat_attributes(PedHaters[i], 2, true)
            ped.set_ped_combat_range(PedHaters[i], 2)
            ped.set_ped_combat_ability(PedHaters[i], 2)
            ped.set_ped_combat_movement(PedHaters[i], 2)
            weapon.give_delayed_weapon_to_ped(PedHaters[i], ped_wep[weap][2], 0, 1)
            weapon.set_ped_ammo(PedHaters[i], ped_wep[weap][2], 1000000)
            if ped.is_ped_in_any_vehicle(PedHaters[i]) then
                pedveh = ped.get_vehicle_ped_is_using(PedHaters[i])
                system.wait(0)
                ai.task_leave_vehicle(PedHaters[i], pedveh, 4160)
                system.wait(500)
                --  ped.clear_ped_tasks_immediately(PedHaters[i])
                system.wait(250)
            end
            --  entity.set_entity_god_mode(PedHaters[i], true)

            ai.task_combat_ped(PedHaters[i], player_peds[pid + 1], 0, 16)

        end
    end
end

function Ped_eject(pid, ejtyp)
    PedHaters, player_groups, player_peds = {}, {}, {}

    player_groups[pid + 1] = player.get_player_group(pid)
    player_peds[pid + 1] = PlyPed(pid)

    PedHaters = ped.get_all_peds()

    system.wait(100)

    GroupHate = ped.create_group()

    for y = 1, #player_groups do

        ped.set_relationship_between_groups(5, player_groups[y], GroupHate)

        ped.set_relationship_between_groups(5, GroupHate, player_groups[y])
    end

    for i = 1, #PedHaters do
        if not ped.is_ped_a_player(PedHaters[i]) then
            network.request_control_of_entity(PedHaters[i])
            ped.set_ped_max_health(PedHaters[i], 700)
            ped.set_ped_health(PedHaters[i], 700)
            ped.set_ped_as_group_member(PedHaters[i], GroupHate)
            ped.set_ped_never_leaves_group(PedHaters[i], true)
            ped.set_ped_can_switch_weapons(PedHaters[i], true)
            ped.set_ped_combat_attributes(PedHaters[i], 46, true)
            ped.set_ped_combat_attributes(PedHaters[i], 52, true)
            ped.set_ped_combat_attributes(PedHaters[i], 1, true)
            ped.set_ped_combat_attributes(PedHaters[i], 2, true)
            ped.set_ped_combat_range(PedHaters[i], 2)
            ped.set_ped_combat_ability(PedHaters[i], 2)
            ped.set_ped_combat_movement(PedHaters[i], 2)
            weapon.give_delayed_weapon_to_ped(PedHaters[i], ped_wep[8][2], 0, 1)
            weapon.set_ped_ammo(PedHaters[i], ped_wep[8][2], 1000000)
            if ped.is_ped_in_any_vehicle(PedHaters[i]) then
                pedveh = ped.get_vehicle_ped_is_using(PedHaters[i])
                system.wait(0)
                ai.task_leave_vehicle(PedHaters[i], pedveh, ejtyp)
                system.wait(200)
                --    ped.clear_ped_tasks_immediately(PedHaters[i])
                system.wait(150)
            end
            --  entity.set_entity_god_mode(PedHaters[i], true)

            --   ai.task_combat_ped(PedHaters[i], player_peds[pid + 1], 0, 16)

        end
    end
end

-- TODO: Heart beat
local heart_beat = menu.add_feature("Heart Beat", "toggle", globalFeatures.troll, function(feat)
    if (feat.on) then
        pped = PlyPed(player.player_id())
        system.wait(400)
        fire.add_explosion(v3(0, -1500, 100), 58, true, false, 0, pped)
        system.wait(200)
        fire.add_explosion(v3(0, -1500, 100), 58, true, false, 0, pped)
        return HANDLER_CONTINUE
    end
end)

local delay_beat = 0

local heart_beat2 = menu.add_feature("Random Exp", "value_i", globalFeatures.troll, function(feat)

    if feat.on then

        pos.x = math.random(-2700, 2700)
        pos.y = math.random(-3300, 7500)
        pos.z = math.random(30, 90)
        pped = PlyPed(player.player_id())

        fire.add_explosion(pos, feat.value, true, false, 0, pped)
        system.wait(delay_beat)
        return HANDLER_CONTINUE
    end

end)
heart_beat2.max = 74
heart_beat2.min = 0
heart_beat2.value = 0

local hb_delay = menu.add_feature("Exp delay", "value_i", globalFeatures.troll, function(feat)
    delay_beat = tonumber(feat.value)
end)
hb_delay.max = 1000
hb_delay.min = 0
hb_delay.value = 0

local bountyallplayerses = menu.add_feature("set Bounty on Lobby", "action", globalFeatures.troll, function(feat)

    for pid = 0, 32 do
        if not player.is_player_valid(pid) then
            return
        end
        local pped = player.get_player_ped(pid)
        if pped ~= 0 then
            decorator.decor_set_int(pped, "MPBitset", 1)
        end

        for j = 0, 32 do
            if not player.is_player_valid(j) then
                return
            end
            script.trigger_script_event(0xf90cc891, j, {j, pid, 1, 10000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})

        end

    end
end)

local pasivall = menu.add_feature("Block all players Passive", "action", globalFeatures.troll, function(feat)
    blockpassiveall()
end)

function AudioAnnoyance(Snd, Aud)
    local pos = v3()
    for i = 0, 32 do
        pped = PlyPed(i)
        local scid = GetSCID(i)
        if (scid ~= -1 or scid ~= 4294967295 and pped ~= 0) then
            pos = entity.get_entity_coords(pped)
            audio.play_sound_frontend(-1, Snd, Aud, true)
            audio.play_sound_from_entity(-1, Snd, pped, Aud)

        end
    end
    audio.play_sound_from_coord(-1, Snd, pos, Aud, true, 1000, true)

end

for i = 1, #SoundAnnoy do
    local FeatID = string.format("Sound_ID" .. i)
    FeatID = menu.add_feature(i .. ": " .. SoundAnnoy[i][1], "action", SoundAnnoyances.id, function(feat)
        local Snd, Aud
        Snd = tostring(SoundAnnoy[i][1])
        Aud = tostring(SoundAnnoy[i][2])
        AudioAnnoyance(Snd, Aud)
    end)
end

local session_soundRape = function()

    sndrape_00 = menu.add_feature("all Water Splashes", "action", globalFeatures.troll, function(feat)

        local pos = v3()
        for i = 0, 32 do
            pped = PlyPed(i)
            local scid = GetSCID(i)
            if (scid ~= -1 or scid ~= 4294967295 and i ~= player.player_id()) then

                audio.play_sound_from_entity(-1, "FallingInWaterSmall", pped, "GTAO_Hot_Tub_PED_INSIDE_WATER", true)
                system.wait(250)
                audio.play_sound_from_entity(-1, "FallingInWaterMedium", pped, "GTAO_Hot_Tub_PED_INSIDE_WATER", true)
                system.wait(120)
                audio.play_sound_from_entity(-1, "FallingInWaterHeavy", pped, "GTAO_Hot_Tub_PED_INSIDE_WATER", true)
                system.wait(300)
                audio.play_sound_from_entity(-1, "DiveInWater", pped, "GTAO_Hot_Tub_PED_INSIDE_WATER", true)
                system.wait(250)
                audio.play_sound_from_coord(-1, "Hot_Tub_Loop", pos, "GTAO_Yacht_SoundSet", true, 1000000, false)

            end
        end
    end)

    sndrape_01 = menu.add_feature("all Horn", "action", globalFeatures.troll, function(feat)

        local pos = v3()
        for i = 0, 32 do
            pped = PlyPed(i)
            local scid = GetSCID(i)
            if (scid ~= -1 or scid ~= 4294967295 and i ~= player.player_id()) then

                pos = entity.get_entity_coords(pped)

                audio.play_sound_from_entity(-1, "HORN", pped, "DLC_Apt_Yacht_Ambient_Soundset", true)
                audio.play_sound_from_coord(-1, "HORN", pos, "DLC_Apt_Yacht_Ambient_Soundset", true, 1000000, false)

            end
        end
    end)

    local sndrape_02 = menu.add_feature("all Air Drop", "action", globalFeatures.troll, function(feat)

        local pos = v3()
        for i = 0, 32 do
            local scid = GetSCID(i)
            if (scid ~= -1 or scid ~= 4294967295 and i ~= player.player_id()) then
                pped = PlyPed(i)
                pos = entity.get_entity_coords(pped)

                audio.play_sound_from_entity(-1, "Air_Drop_Package", pped, "DLC_SM_Generic_Mission_Sounds", true)

            end
        end
    end)

    local sndrape_3 = menu.add_feature("all Explosion Countdown", "action", globalFeatures.troll, function(feat)

        local pos = v3()
        for i = 0, 32 do
            local scid = GetSCID(i)
            if (scid ~= -1 or scid ~= 4294967295 and i ~= player.player_id()) then
                pped = PlyPed(i)
                pos = entity.get_entity_coords(pped)
                audio.play_sound_from_coord(-1, "Explosion_Countdown", pos, "GTAO_FM_Events_Soundset", true, 1000, false)
                audio.play_sound_from_entity(-1, "Explosion_Countdown", pped, "GTAO_FM_Events_Soundset", true)

            end
        end
    end)

    local sndrape_4 = menu.add_feature("Annoying sound! CANT BE UNDONE!", "action", globalFeatures.troll, function(feat)

        local pos = v3()
        for i = 0, 32 do
            local scid = GetSCID(i)
            if (scid ~= -1 and i ~= player.player_id()) then
                pped = PlyPed(i)
                pos = entity.get_entity_coords(pped)
                audio.play_sound_from_coord(-1, "Frontend_Beast_Frozen_Screen_Loop", pos, "FM_Events_Sasquatch_Sounds", true, 1000, false)
            end
        end
    end)

    local sndrape_1 = menu.add_feature("allBomb Armed", "value_i", globalFeatures.troll, function(feat)
        if feat.on then

            local delaytime = feat.value

            local pos = v3()
            for i = 0, 32 do
                local scid = GetSCID(i)
                if (scid ~= -1 and i ~= player.player_id()) then
                    pped = PlyPed(i)
                    pos = entity.get_entity_coords(pped)
                    audio.play_sound_from_entity(-1, "Bomb_Armed", pped, "GTAO_Speed_Convoy_Soundset", true)
                    system.wait(delaytime)
                end
            end
            return HANDLER_CONTINUE
        end
        return HANDLER_POP
    end)
    sndrape_1.max = 1000
    sndrape_1.min = 0
    sndrape_1.mod = 5

    local sndrape_2 = menu.add_feature("all Bomb Disarmed", "value_i", globalFeatures.troll, function(feat)
        if feat.on then

            local delaytime = feat.value

            local pos = v3()
            for i = 0, 32 do
                local scid = GetSCID(i)
                if (scid ~= -1 and i ~= player.player_id()) then

                    pped = PlyPed(i)
                    pos = entity.get_entity_coords(pped)

                    audio.play_sound_from_entity(-1, "Bomb_Disarmed", pped, "GTAO_Speed_Convoy_Soundset", true)
                    system.wait(delaytime)
                end
            end
            return HANDLER_CONTINUE
        end
        return HANDLER_POP
    end)
    sndrape_2.max = 1000
    sndrape_2.min = 0
    sndrape_2.mod = 5

end
session_soundRape()

menu.add_feature("Illuminate Everyone", "action", globalFeatures.troll, function(feat)

    for i = 0, 32 do

        pped = PlyPed(i)
        if pped ~= 0 then

            local pos, offset, rot = v3(), v3(), v3()

            offset.x = 1.0
            offset.y = 0.1
            offset.z = -0.1

            rot.x = 1.0
            rot.y = 1.0
            rot.z = 1.0

            local bid = ped.get_ped_bone_index(pped, 65068)

            local hash = gameplay.get_hash_key("prop_dummy_light")
            spawned_cunts[#spawned_cunts + 1] = object.create_object(hash, pos, true, false)
            entity.attach_entity_to_entity(spawned_cunts[#spawned_cunts], pped, bid, offset, rot, false, false, false, 0, false)

            offset.x = 0.010
            offset.y = 0.01
            offset.z = 0.001

            rot.x = 1.0
            rot.y = 1.0
            rot.z = 1.0
            local hash = gameplay.get_hash_key("prop_air_lights_02a")
            spawned_cunts[#spawned_cunts + 1] = object.create_object(hash, pos, true, true)
            entity.attach_entity_to_entity(spawned_cunts[#spawned_cunts], pped, bid, offset, rot, true, false, false, 0, false)

        end
    end
    return HANDLER_POP
end)

menu.add_feature("Everyone is a Dick Head!", "action", globalFeatures.troll, function(feat)

    for i = 0, 32 do

        pped = PlyPed(i)
        if pped ~= 0 then

            local pos, rot, offset = v3(), v3(), v3()

            offset.x = 0.08
            offset.y = 0.0
            offset.z = 0.0

            rot.x = 40
            rot.y = -83
            rot.z = -134

            local bid = ped.get_ped_bone_index(pped, 65068)

            local hash = gameplay.get_hash_key("v_res_d_dildo_f")
            spawned_cunts[#spawned_cunts + 1] = object.create_object(hash, pos, true, false)
            entity.attach_entity_to_entity(spawned_cunts[#spawned_cunts], pped, bid, offset, rot, true, false, false, 0, true)
        end
    end
    return HANDLER_POP
end)

menu.add_feature("Give all Dildo Dicks", "action", globalFeatures.troll, function(feat)

    for i = 0, 32 do

        pped = PlyPed(i)
        if pped ~= 0 then

            local pos, rot, offset = v3(), v3(), v3()

            offset.x = 0.0
            offset.y = 0.0
            offset.z = 0.0

            rot.x = 293.0
            rot.y = 28.0
            rot.z = 24.0

            local bid = ped.get_ped_bone_index(pped, 23553)

            local hash = gameplay.get_hash_key("v_res_d_dildo_f")
            spawned_cunts[#spawned_cunts + 1] = object.create_object(hash, pos, true, true)
            entity.attach_entity_to_entity(spawned_cunts[#spawned_cunts], pped, bid, offset, rot, true, false, false, 0, true)
        end
    end
    return HANDLER_POP
end)

local world_force = menu.add_feature("Apply force to world entities", "action", globalFeatures.lobby, function(feat)
    get_everything()
    system.wait(100)
    local vel, velo = v3(), v3()
    velo.x = 0.0
    velo.y = 0.0
    velo.z = 1000.00
    vel.x = math.random(1000.0, 10000.0)
    vel.y = math.random(1000.0, 10000.0)
    vel.z = math.random(1000.0, 7500.0)

    local myveh = player.get_player_vehicle(player.player_id())

    for i = 1, #allpeds do

        if not ped.is_ped_a_player(allpeds[i]) then
            entity.freeze_entity(allpeds[i], false)

            entity.apply_force_to_entity(allpeds[i], 5, 100.0, 100.0, 100.0, 100.0, 100.0, 100.0, true, true)

            entity.set_entity_velocity(allpeds[i], vel)
        end
    end

    for y = 1, #allveh do

        if y ~= myveh then
            entity.freeze_entity(allveh[y], false)
            entity.set_entity_gravity(allveh[y], false)

            entity.set_entity_velocity(allveh[y], velo)

            system.wait(25)
            entity.set_entity_velocity(allveh[y], vel)
        end
    end

    for x = 1, #allobj do
        entity.freeze_entity(allobj[x], false)
        entity.set_entity_velocity(allobj[x], vel)
    end
end)

-- TODO: Spawn Features

-- spawn variables defaults
model = 0xDB134533
vehhash = 788747387
wephash = 0xA2719263
local mod, modvalue, pedspawns

-- TODO: Ped Spawn Features
local Ped_Haters, playergroups, playerpeds = {}, {}, {}
local Group_Hate

function spawn_groups()

    for pid = 0, 32 do
        playergroups[pid + 1] = player.get_player_group(pid)
        playerpeds[pid + 1] = PlyPed(pid)

    end

    system.wait(100)

    Group_Hate = ped.create_group()

    for y = 1, #player_groups do

        ped.set_relationship_between_groups(5, player_groups[y], Group_Hate)

        ped.set_relationship_between_groups(5, Group_Hate, player_groups[y])
    end
end

function spawn_ped(pid, pedhash, offdist, attack, Posoff)
    hash = pedhash
    pped = PlyPed(pid)
    local offset = v3()
    OffSet = offdist

    if not Posoff then
        pos = player.get_player_coords(pid)
        heading = player.get_player_heading(pid)
        heading = math.rad((heading - 180) * -1)
        offset = v3(pos.x + (math.sin(heading) * -offdist), pos.y + (math.cos(heading) * -offdist), pos.z)
    else
        offset = offdist
    end

    local headtype = math.random(0, 2)

    streaming.request_model(hash)
    while not streaming.has_model_loaded(hash) do
        system.wait(10)
    end
    local p = #escort + 1

    escort[p] = ped.create_ped(26, hash, offset, 0, true, false)
    Ped_Haters[#Ped_Haters + 1] = escort[p]
    print(escort[p])
    entity.set_entity_god_mode(escort[p], true)
    BlipIDs[#BlipIDs + 1] = ui.add_blip_for_entity(escort[p])

    ped.set_ped_component_variation(escort[p], 0, 1, 0, 0)
    ped.set_ped_component_variation(escort[p], 2, 0, 0, 0)
    ped.set_ped_component_variation(escort[p], 3, 1, 0, 0)
    ped.set_ped_component_variation(escort[p], 4, 1, 0, 0)
    ped.set_ped_component_variation(escort[p], 0, 2, 2, 0)
    ped.set_ped_component_variation(escort[p], 8, 1, 0, 0)

    ped.set_ped_can_switch_weapons(escort[p], true)
    ped.set_ped_combat_attributes(escort[p], 46, true)
    ped.set_ped_combat_attributes(escort[p], 52, true)
    ped.set_ped_combat_attributes(escort[p], 1, true)
    ped.set_ped_combat_attributes(escort[p], 2, true)
    ped.set_ped_combat_range(escort[p], 2)
    ped.set_ped_combat_ability(escort[p], 2)
    ped.set_ped_combat_movement(escort[p], 2)

    if not attack == true then
        ped.set_ped_combat_attributes(escort[p], 1424, false)

        ped.set_ped_as_group_member(escort[p], Group_Hate)

        ped.set_ped_never_leaves_group(escort[p], true)

    else
    end
    -- streaming.set_model_as_no_longer_needed(hash)
end

function spawn_ped_v2(pid, pedhash, attack)
    local hash, parachute = pedhash, 0xfbab5776
    plygrp = player.get_player_group(pid)
    pped = PlyPed(pid)
    local pos, offset, offset2, rot = v3(), v3(), v3(), v3()
    pos = player.get_player_coords(pid)
    pos.x = pos.x + 10
    pos.y = pos.y + 20

    local offset_z, headtype
    offset_z = math.random(10, 40)
    offset.z = offset_z
    headtype = math.random(0, 2)

    rot = entity.get_entity_rotation(pped)
    streaming.request_model(hash)
    while not streaming.has_model_loaded(hash) do

        system.wait(10)
    end
    local p = #escort + 1

    escort[p] = ped.create_ped(26, hash, pos + offset, 0, true, false)
    print(escort[p])

    entity.set_entity_god_mode(escort[p], true)
    BlipIDs[#BlipIDs + 1] = ui.add_blip_for_entity(escort[p])

    ped.set_ped_component_variation(escort[p], 0, 1, 0, 0)
    ped.set_ped_component_variation(escort[p], 2, 0, 0, 0)
    ped.set_ped_component_variation(escort[p], 3, 1, 0, 0)
    ped.set_ped_component_variation(escort[p], 4, 1, 0, 0)
    ped.set_ped_component_variation(escort[p], 0, 2, 2, 0)
    ped.set_ped_component_variation(escort[p], 8, 1, 0, 0)

    ped.set_ped_can_switch_weapons(escort[p], true)
    ped.set_ped_combat_attributes(escort[p], 46, true)
    ped.set_ped_combat_attributes(escort[p], 52, true)
    ped.set_ped_combat_attributes(escort[p], 1, true)
    ped.set_ped_combat_attributes(escort[p], 2, true)
    ped.set_ped_combat_attributes(escort[p], 3, false)
    ped.set_ped_combat_range(escort[p], 2)
    ped.set_ped_combat_ability(escort[p], 2)
    ped.set_ped_combat_movement(escort[p], 2)
    ped.set_ped_can_switch_weapons(escort[p], true)
    weapon.give_delayed_weapon_to_ped(escort[p], parachute, 1, 0)

    if not attack == true then
        ped.set_ped_combat_attributes(escort[p], 1424, false)
        pedgroup = ped.get_ped_group(escort[p])
        ped.set_ped_as_group_member(escort[p], plygrp)
        pedgroup = ped.get_ped_group(escort[p])
        ped.set_ped_never_leaves_group(escort[p], true)

    else
    end
    streaming.set_model_as_no_longer_needed(hash)
end

function spawn_veh(pid, vehhash, offdist, mod, modvalue, Posoff)
    local hash, OffSet = vehhash, offdist

    if not Posoff then
        local pos, heading = player.get_player_coords(pid), player.get_player_heading(pid)

        heading = math.rad((heading - 180) * -1)
        offset = v3(pos.x + (math.sin(heading) * -offdist), pos.y + (math.cos(heading) * -offdist), pos.z)
    else
        offset = offdist
    end

    streaming.request_model(hash)
    while not streaming.has_model_loaded(hash) do

        system.wait(10)
    end

    local y = #escortveh + 1
    if streaming.is_model_a_heli(hash) then
        offset = v3(-73.31681060791, -820.26013183594, 326.17517089844)
    end
    escortveh[y] = vehicle.create_vehicle(hash, offset, player.get_player_heading(pid), true, false)

    print(escortveh[y])
    vehicle.set_vehicle_mod_kit_type(escortveh[y], 0)
    vehicle.get_vehicle_mod(escortveh[y], mod)
    vehicle.set_vehicle_mod(escortveh[y], mod, modvalue, false)
    BlipIDs[#BlipIDs + 1] = ui.add_blip_for_entity(escortveh[y])
    vehicle.set_vehicle_on_ground_properly(escortveh[y])
    entity.set_entity_god_mode(escortveh[y], true)
    vehicle.set_vehicle_doors_locked(escortveh[y], 5)

    network.request_control_of_entity(escortveh[y])
    -- streaming.set_model_as_no_longer_needed(hash)
    return escortveh[y]

end

-- TODO: Spawn Cleanups

local Blip_Cleanup = menu.add_feature("Delete Blips Added", "action", globalFeatures.cleanup, function(feat)

    if #BlipIDs == 0 or nil then
        return
    end
    for i = 1, #BlipIDs do
        ui.remove_blip(BlipIDs[i])
    end
end)

local alk_cleanup = menu.add_feature("Delete alkonost lag Spawns", "action", globalFeatures.cleanup, function(feat)

    if #alkonost == 0 or nil then
        return
    end
    local pos = v3()
    pos.x = presets[1][2]
    pos.y = presets[1][3]
    pos.z = presets[1][4]

    for i = 1, #alkonost do

        entity.detach_entity(alkonost[i])

        entity.set_entity_coords_no_offset(alkonost[i], pos)

        entity.set_entity_as_no_longer_needed(alkonost[i])
        entity.delete_entity(alkonost[i])
    end
end)

local ped_cleanup = menu.add_feature("Delete Ped Spawns", "action", globalFeatures.cleanup, function(feat)

    if #escort == 0 or nil then
        return
    end
    local pos = v3()
    pos.x = presets[1][2]
    pos.y = presets[1][3]
    pos.z = presets[1][4]

    for i = 1, #escort do

        ped.clear_ped_tasks_immediately(escort[i])
        entity.detach_entity(escort[i])

        entity.set_entity_coords_no_offset(escort[i], pos)

        entity.set_entity_as_no_longer_needed(escort[i])
        entity.delete_entity(escort[i])
    end
end)

local Freeze_obj = menu.add_feature("Freeze World Vehicles & Objects", "action", globalFeatures.lobby, function(feat)

    allobj = object.get_all_objects()
    system.wait(200)
    allveh = vehicle.get_all_vehicles()
    system.wait(200)
    system.wait(400)
    for i = 1, #allobj do
        entity.freeze_entity(allobj[i], false)
        network.request_control_of_entity(allobj[i])
        -- 	entity.set_entity_coords_no_offset(allobj[i], pos)
        entity.freeze_entity(allobj[i], true)
        -- entity.set_entity_as_no_longer_needed(allobj[i])
        -- entity.delete_entity(allobj[i])
    end
    system.wait(400)
    for i = 1, #allveh do
        network.request_control_of_entity(allveh[i])
        -- entity.freeze_entity(allveh[i], false)
        --	entity.set_entity_coords_no_offset(allveh[i], pos)
        entity.freeze_entity(allveh[i], true)
        -- entity.set_entity_as_no_longer_needed(allveh[i])
        -- entity.delete_entity(allveh[i])
    end
end)

local pedveh_cleanup = menu.add_feature("Delete Ped Spawns + Vehicles", "action", globalFeatures.cleanup, function(feat)
    spawn_cleanup()
end)

function spawn_cleanup()
    if #escort == 0 or nil then
        return
    end
    local pos = v3()
    pos.x = presets[1][2]
    pos.y = presets[1][3]
    pos.z = presets[1][4]

    for i = 1, #escort do
        network.request_control_of_entity(escort[i])
        ped.clear_ped_tasks_immediately(escort[i])

        entity.set_entity_coords_no_offset(escort[i], pos)

        entity.set_entity_as_no_longer_needed(escort[i])
        entity.delete_entity(escort[i])
    end
    if #escortveh == 0 or nil then
        return
    end
    for y = 1, #escortveh do

        network.request_control_of_entity(escortveh[y])
        entity.detach_entity(escortveh[y])

        entity.set_entity_coords_no_offset(escortveh[y], pos)

        entity.set_entity_as_no_longer_needed(escortveh[y])
        entity.delete_entity(escortveh[y])
    end
end

function delayed_spawn_cleanup()
    system.wait(2000)
    allveh = vehicle.get_all_vehicles()
    allpeds = ped.get_all_peds()
    if #allveh == 0 or nil then
        return
    end
    for y = 1, #allveh do
        if entity.get_entity_model_hash(allveh[y]) == 0xD9F0503D then
            entity.delete_entity(allveh[y])
            entity.set_entity_as_no_longer_needed(allveh[y])
        end
    end
    if #escort == 0 or nil then
        return
    end
    local pos = v3()
    pos.x = presets[1][2]
    pos.y = presets[1][3]
    pos.z = presets[1][4]

    for i = 1, #allpeds do
        if entity.get_entity_model_hash(allpeds[i]) == 0x6E42FD26 then
            ped.clear_ped_tasks_immediately(allpeds[i])

            network.request_control_of_entity(allpeds[i])

            entity.delete_entity(allpeds[i])
            entity.set_entity_as_no_longer_needed(allpeds[i])
        end
    end
end

-- TODO: CUNT DUMP

local dump_pickups_onplayer = function(pid, pos)
    world_dumped = false
    moist_notify("Going to Fetch all~h~ ~r~ Pickups!~o~ \nWill dump on target", "!")
    moist_notify("~h~~w~ 3 Seconds\n", "Until ~r~~h~Pickup Cunt Dump ~g~~h~Starts")

    system.wait(1000)
    moist_notify("Pickup Cunt Dump Starts in: ", "~y~~h~2 ~r~Seconds")
    system.wait(1000)

    moist_notify("Pickup Cunt Dump Starts in: ", "~y~~h~1 ~r~Second")
    system.wait(1000)
    moist_notify("Pickup Cunt Dump Initiated", "\nFeel the Cunt & Pick it up Enjoy")

    allpickups = object.get_all_pickups()
    system.wait(400)

    for i = 1, #allpickups do
        if entity.is_an_entity(allpickups[i]) then
            network.request_control_of_entity(allpickups[i])
            entity.set_entity_coords_no_offset(allpickups[i], pos)
            entity.set_entity_as_no_longer_needed(allpickups[i])
        end

        system.wait(200)
    end
    moist_notify("World Pickups have been Cunt Dumped!\n GG <font size='12'>~ex_r*~ ", "\nEnjoy The Moisture inside")
    world_dumped = true
end

function dumpfreeze_onplayer(pid, pos)
    local allpeds, allveh, allobj, allpickups = {}, {}, {}, {}
    world_dumped = false
    moist_notify("Ensure you are ~h~ ~r~ NOT!~o~ \nSpectating Player", "!")
    moist_notify("~h~~w~ 3 Seconds\n", "Until ~r~~h~Cunt Dump ~g~~h~Starts")

    system.wait(1000)
    moist_notify("Cunt Dump Starts in: ", "~y~~h~2 ~r~Seconds")
    system.wait(1000)

    moist_notify("Cunt Dump Starts in: ", "~y~~h~1 ~r~Second")
    system.wait(1000)
    moist_notify("Cunt Dump Initiated", "\n Spectating now could crash you")
    allpeds = ped.get_all_peds()
    system.wait(200)
    allveh = vehicle.get_all_vehicles()
    system.wait(200)
    allobj = object.get_all_objects()
    system.wait(200)
    allpickups = object.get_all_pickups()
    system.wait(400)

    for i = 1, #allpickups do
        if entity.is_an_entity(allpickups[i]) then
            network.request_control_of_entity(allpickups[i])
            entity.freeze_entity(allpickups[i], false)
            entity.set_entity_coords_no_offset(allpickups[i], pos)
            entity.freeze_entity(allpickups[i], true)

        end
    end
    system.wait(400)
    for i = 1, #allobj do
        if entity.is_an_entity(allobj[i]) then
            entity.freeze_entity(allobj[i], false)
            network.request_control_of_entity(allobj[i])
            entity.set_entity_coords_no_offset(allobj[i], pos)
            entity.freeze_entity(allobj[i], true)

        end
    end
    system.wait(400)
    for i = 1, #allveh do
        if entity.is_an_entity(allveh[i]) then
            if not decorator.decor_exists_on(allveh[i], "Player_Vehicle") then
                network.request_control_of_entity(allveh[i])
                entity.freeze_entity(allveh[i], false)
                entity.set_entity_coords_no_offset(allveh[i], pos)
                entity.freeze_entity(allveh[i], true)
            end
        end

    end
    system.wait(400)
    for i = 1, #allpeds do
        if entity.is_an_entity(allpeds[i]) then
            if not ped.is_ped_a_player(allpeds[i]) then
                entity.freeze_entity(allpeds[i], false)
                network.request_control_of_entity(allpeds[i])
                entity.set_entity_coords_no_offset(allpeds[i], pos)
                entity.freeze_entity(allpeds[i], true)
            end

        end
        system.wait(400)
    end
    moist_notify("WorldDumped On That Cunt!\n GG <font size='12'> ~ex_r*~ ", "\nCarefull Spectating")
    world_dumped = true
    allpeds, allveh, allobj, allpickups = {}, {}, {}, {}
end

function dumpfreeze_ped_onplayer(pid, pos)
    local allpeds, allveh, allobj, allpickups = {}, {}, {}, {}
    world_dumped = false
    moist_notify("Ensure you are ~h~ ~r~ NOT!~o~ \nSpectating Player", "!")
    moist_notify("~h~~w~ 3 Seconds\n", "Until ~r~~h~Cunt Dump ~g~~h~Starts")

    system.wait(1000)
    moist_notify("Cunt Dump Starts in: ", "~y~~h~2 ~r~Seconds")
    system.wait(1000)

    moist_notify("Cunt Dump Starts in: ", "~y~~h~1 ~r~Second")
    system.wait(1000)
    moist_notify("Cunt Dump Initiated", "\n Spectating now could crash you")
    allpeds = ped.get_all_peds()
    system.wait(200)
    allveh = vehicle.get_all_vehicles()
    system.wait(200)
    -- allobj = object.get_all_objects()
    system.wait(200)
    allpickups = object.get_all_pickups()
    system.wait(400)

    -- for i = 1, #allpickups do
    -- if entity.is_an_entity(allpickups[i]) then
    -- network.request_control_of_entity(allpickups[i])
    -- --entity.freeze_entity(allpickups[i], false)
    -- entity.set_entity_coords_no_offset(allpickups[i], pos)
    -- -- entity.freeze_entity(allpickups[i], true)

    -- end
    -- end
    -- system.wait(400)
    -- for i = 1, #allobj do
    -- if entity.is_an_entity(allobj[i]) then
    -- entity.freeze_entity(allobj[i], false)
    -- network.request_control_of_entity(allobj[i])
    -- entity.set_entity_coords_no_offset(allobj[i], pos)
    -- entity.freeze_entity(allobj[i], true)

    -- end
    -- end
    -- system.wait(400)
    for i = 1, #allveh do
        if entity.is_an_entity(allveh[i]) then
            if not decorator.decor_exists_on(allveh[i], "Player_Vehicle") then
                network.request_control_of_entity(allveh[i])
                -- entity.freeze_entity(allveh[i], false)
                entity.set_entity_coords_no_offset(allveh[i], pos)
                -- entity.freeze_entity(allveh[i], true)
            end
        end

    end
    system.wait(400)
    for i = 1, #allpeds do
        if entity.is_an_entity(allpeds[i]) then
            if not ped.is_ped_a_player(allpeds[i]) then
                -- entity.freeze_entity(allpeds[i], false)
                network.request_control_of_entity(allpeds[i])
                entity.set_entity_coords_no_offset(allpeds[i], pos)
                -- entity.freeze_entity(allpeds[i], true)
            end

        end
        system.wait(400)
    end
    moist_notify("World Ped + Vehicle Dumped on Player", "\nHave Fun!")
    world_dumped = true
    allpeds, allveh, allobj, allpickups = {}, {}, {}, {}
end

-- TODO: Option Features
--[[
21	INPUT_Sprint	LEFT SHIFT			A
22	INPUT_JUMP		SPACEBAR			X
24	INPUT_ATTACK	LEFT MOUSE BUTTON	RT
25	INPUT_AIM		RIGHT MOUSE BUTTON	LT
]]

hud_comp = menu.add_feature("Show hud_comp", "value_i", globalFeatures.moistopt, function(feat)
    if feat.on then
        ui.show_hud_component_this_frame(feat.value)
    end
    return HANDLER_CONTINUE
end)
hud_comp.max = 255
hud_comp.min = 0

local entity_control

OptionsVar.aim_control = menu.add_feature("DetonateVehicle Aiming@(LShift or PS:X XBC:A)", "toggle", globalFeatures.moistopt, function(feat)
    Settings["aimDetonate_control"] = true
    if feat.on then

        if player.is_player_free_aiming(player.player_id()) and controls.is_control_pressed(1, 21) then

            entity_control = player.get_entity_player_is_aiming_at(player.player_id())

            if entity.is_entity_a_ped(entity_control) then
                if entity.is_entity_dead(entity_control) then
                    moist_notify("Entity is a Dead Ped", "\nResurrecting Ped Now!")
                    network.request_control_of_entity(entity_control)
                    ped.resurrect_ped(entity_control)
                    network.request_control_of_entity(entity_control)
                    ped.set_ped_max_health(entity_control, 400)
                    network.request_control_of_entity(entity_control)
                    ped.set_ped_health(entity_control, 300)
                    local pedhp1 = ped.get_ped_health(entity_control)
                    local pedhp2 = ped.get_ped_max_health(entity_control)

                    moist_notify("Current Health: " .. pedhp1, "\nMax Health: " .. pedhp2)
                    ped.clear_ped_tasks_immediately(entity_control)

                end
                if entity.get_entity_god_mode(entity_control) then
                    moist_notify("Entity God Mode!!", "\nDisabling God Mode")
                    network.request_control_of_entity(entity_control)
                    entity.set_entity_god_mode(entity_control, false)
                end
                if entity.is_entity_attached(entity_control) then
                    entity_control = entity.get_entity_attached_to(entity_control)
                end
                network.request_control_of_entity(entity_control)
            end
            if entity.get_entity_god_mode(entity_control) then
                moist_notify("Attached Entity is God Mode!!", "\nDisabling God Mode")
                network.request_control_of_entity(entity_control)
                entity.set_entity_god_mode(entity_control, false)
            end
            if entity.is_entity_a_vehicle(entity_control) then
                network.request_control_of_entity(entity_control)
                moist_notify("Vehicle God Mode!! Removing it from this CUNT!", "\nNow Giving it a Remote Bomb!!")
                vehicle.add_vehicle_phone_explosive_device(entity_control)
                system.wait(25)
            end

            network.request_control_of_entity(entity_control)
            if vehicle.has_vehicle_phone_explosive_device() then
                moist_notify("RIP CUNT! DETONATING BOMB!!", "\nFUCK YOU\nGG ~ex_r*~")
                vehicle.detonate_vehicle_phone_explosive_device()
            end
            system.yield(10)
            return HANDLER_CONTINUE
        end
        system.yield(Settings["loop_feat_delay"])
        return HANDLER_CONTINUE
    end
    Settings["aimDetonate_control"] = false
    return HANDLER_POP
end)

OptionsVar.aim_control.on = Settings["aimDetonate_control"]

-- TODO: Player Tracking
PlyTracker.track_all = menu.add_feature("Track all Players Speed", "toggle", globalFeatures.moistopt, function(feat)
    if feat.on then

        for i = 0, 32 do
            local y = i + 1

            local ent
            local ent1 = PlyPed(i)
            local ent2 = ped.get_vehicle_ped_is_using(ent1)

            if ped.is_ped_in_any_vehicle(ent1) then
                ent = ent2
            else
                ent = ent1
            end
            local speed = entity.get_entity_speed(ent)
            local speedcalc = speed * 3.6 -- kmph
            -- local speedcalc =  speed * 2.236936 --mph
            tracking.playerped_speed1[y] = math.ceil(speedcalc)
        end
        system.yield(100)
        return HANDLER_CONTINUE
    end
    return HANDLER_POP
end)
PlyTracker.track_all.on = true
PlyTracker.track_all.hidden = true

-- TODO: OSD STUFF
-- TODO: Speed Tracking
OSD.modvehspeed_osd = menu.add_feature("High Player Speed OSD", "toggle", globalFeatures.moistopt, function(feat)
    Settings["OSD.modvehspeed_osd"] = true
    if feat.on then
        for i = 1, 32 do
            if tracking.playerped_speed1[i + 1] > 325 then
                OSD.mod_vehspeed_osd.on = true
                system.yield(13000)
            else
                OSD.mod_vehspeed_osd.on = false
            end
        end
        return HANDLER_CONTINUE
    end
    Settings["OSD.modvehspeed_osd"] = false
    return HANDLER_POP
end)
OSD.modvehspeed_osd.on = Settings["OSD.modvehspeed_osd"]

OSD.mod_vehspeed_osd = menu.add_feature("High Player Speed OSD", "toggle", globalFeatures.moistopt, function(feat)
    if feat.on then
        local pos = v2()
        pos.x = 0.001
        pos.y = .0300

        local name
        for i = 0, 32 do
            if PlyPed(i) ~= 0 then
                pos.x = 0.001

                if tracking.playerped_speed1[i + 1] > 325 then
                    name = player.get_player_name(i)
                    ui.set_text_scale(0.235)
                    ui.set_text_font(0)
                    ui.set_text_color(255, 0, 0, 255)
                    ui.set_text_centre(false)
                    ui.set_text_outline(true)

                    ui.draw_text("HighSpeed: ", pos)
                    pos.x = 0.035

                    ui.set_text_scale(0.235)
                    ui.set_text_font(0)
                    ui.set_text_color(255, 255, 255, 255)
                    ui.set_text_centre(false)
                    ui.set_text_outline(true)
                    ui.draw_text(name, pos)
                    pos.x = 0.089

                    ui.set_text_scale(0.235)
                    ui.set_text_font(0)
                    ui.set_text_color(0, 255, 255, 255)
                    ui.set_text_centre(false)
                    ui.set_text_outline(true)
                    ui.draw_text(" <" .. tracking.playerped_speed1[i + 1] .. ">", pos)

                    pos.y = pos.y + 0.040
                end
            end
        end
        return HANDLER_CONTINUE
    end

    return HANDLER_POP

end)
OSD.mod_vehspeed_osd.on = false
OSD.mod_vehspeed_osd.hidden = true

function TakeHost(pid)
    script.trigger_script_event(-81613951, pid, {pid, script.get_global_i(1630317 + (1 + (pid * 595)) + 506)})
    script.trigger_script_event(-1292453789, pid, {pid, script.get_global_i(1630317 + (1 + (pid * 595)) + 506)})
    script.trigger_script_event(1623637790, pid, {pid, script.get_global_i(1630317 + (1 + (pid * 595)) + 506)})
    script.trigger_script_event(-1905128202, pid, {pid, script.get_global_i(1630317 + (1 + (pid * 595)) + 506)})
    script.trigger_script_event(1160415507, pid, {pid, script.get_global_i(1630317 + (1 + (pid * 595)) + 506)})
    script.trigger_script_event(-2120750352, pid, {pid, script.get_global_i(1630317 + (1 + (pid * 595)) + 506)})
    script.trigger_script_event(0xE6116600, pid, {pid, script.get_global_i(1630317 + (1 + (pid * 595)) + 506)})

end
local PCR, PCG, PCB, PCA
local PCR1, PCG1, PCB1, PCA1 = 255, 255, 255, 255
local PCR2, PCG2, PCB2, PCA2 = 0, 0, 0, 255
playerpulse = menu.add_feature("Pulse PlayerBar Names", "value_i", globalFeatures.moistopt, function(feat)
    if feat.on then
        for pid = 0, 32 do
            if player.is_player_valid(pid) and pid ~= player.player_id() then
                pped = player.get_player_ped(pid)
                if Players[pid].isint then
                    goto next
                elseif interior.get_interior_from_entity(pped) == 0 or Players[pid].isint == false then
                    --  system.wait(feat.value)
                    Players[pid].pulse = true
                    system.wait(feat.value)
                    Players[pid].pulse = false
                    system.wait(feat.value)
                end
                --   system.wait(feat.value)
            end
            ::next::
        end
        return HANDLER_CONTINUE
    end
    return HANDLER_POP
end)
playerpulse.on = true
playerpulse.max = 800
playerpulse.min = 1
playerpulse.value = 95
playerpulse.mod = 1

notifysent = {}
OSD.Player_bar = menu.add_feature("Player Bar OSD", "toggle", globalFeatures.moistopt, function(feat)
    Settings["OSD.Player_bar"] = true
    if feat.on then

        ui.draw_rect(0.001, 0.001, 2.5, 0.075, 0, 0, 0, 225)
        local pos = v2()
        pos.x = 0.0001
        pos.y = 0.000001

        for pid = 0, 32 do
            pped = player.get_player_ped(pid)

            local i = pid
            local name, scid = SessionPlayers[pid].Name, SessionPlayers[pid].Scid
            if scid ~= 4294967295 and name ~= nil then
                local PlayerName = SessionPlayers[pid].Name

                PCR, PCG, PCB, PCA = 255, 255, 255, 255

                if player.is_player_god(i) and player.is_player_vehicle_god(i) and Players[pid].isint == true then
                    if Players[pid].pulse then
                        PCR, PCG, PCB, PCA = 255, 0, 255, 190
                    else

                        PCR, PCG, PCB, PCA = 255, 0, 255, 190
                    end
                end
                if player.is_player_god(i) and player.is_player_vehicle_god(i) and Players[pid].isint == false then
                    if Players[pid].pulse then
                        PCR, PCG, PCB, PCA = 255, 255, 255, 190
                    else

                        PCR, PCG, PCB, PCA = 255, 0, 255, 255
                    end
                end
                if player.is_player_vehicle_god(i) and not player.is_player_god(i) and Players[pid].isint == true then
                    if Players[pid].pulse then
                        PCR, PCG, PCB, PCA = 255, 170, 0, 190
                    else
                        PCR, PCG, PCB, PCA = 255, 170, 0, 190
                    end
                end
                if player.is_player_vehicle_god(i) and not player.is_player_god(i) and Players[pid].isint == false then
                    if Players[pid].pulse then
                        PCR, PCG, PCB, PCA = 255, 255, 255, 80
                    else
                        PCR, PCG, PCB, PCA = 255, 170, 0, 255
                    end
                end
                if player.is_player_god(i) and not player.is_player_vehicle_god(i) and Players[pid].isint == true then
                    if Players[pid].pulse then
                        PCR, PCG, PCB, PCA = 255, 0, 0, 190
                    else
                        PCR, PCG, PCB, PCA = 255, 0, 0, 190
                    end
                end
                if player.is_player_god(i) and not player.is_player_vehicle_god(i) and Players[pid].isint == false then
                    if Players[pid].pulse then
                        PCR, PCG, PCB, PCA = 255, 255, 255, 80
                    else
                        PCR, PCG, PCB, PCA = 255, 0, 0, 255
                    end
                end
                if (script.get_global_i(2426097 + (1 + (pid * 443)) + 204) == 1) and Players[pid].isint == true then
                    if Players[pid].pulse then
                        PCR, PCG, PCB, PCA = 0, 255, 0, 255
                    else
                        PCR, PCG, PCB, PCA = 0, 255, 0, 190
                    end
                end
                if (script.get_global_i(2426097 + (1 + (pid * 443)) + 204) == 1) and Players[pid].isint == false then
                    if Players[pid].pulse then
                        PCR, PCG, PCB, PCA = 0, 255, 0, 120
                    else
                        PCR, PCG, PCB, PCA = 0, 255, 0, 255
                    end
                end

                if passive_players[i + 1] then
                    PCA = 150
                end
                if player.is_player_friend(pid) then
                    PCR, PCG, PCB, PCA = 255, 255, 0, 255
                end

                if pos.x > 0.95 then
                    pos.y = .015
                    pos.x = 0.0001
                end

                ui.set_text_color(PCR, PCG, PCB, PCA)

                if pos.x > 0.95 then
                    pos.y = .015
                    pos.x = 0.0001
                else
                end
                ui.set_text_scale(0.18)
                ui.set_text_font(0)

                ui.set_text_centre(false)
                ui.set_text_outline(true)

                ui.draw_text(" " .. PlayerName .. " ", pos)

                pos.x = pos.x + 0.065
            end

        end
        return HANDLER_CONTINUE
    end

    Settings["OSD.Player_bar"] = false
    return HANDLER_POP
end)
OSD.Player_bar.on = Settings["OSD.Player_bar"]

-- TODO: -------- Moist Tools

local ScreenText, ScreenText2, ScreenTextdebug = " ", " ", ""

function update_osd_text(text, append)
    if append then
        local screentext = ScreenText .. "\n"
        ScreenText = string.format(screentext .. " : " .. text)
    end
    if not append then
        ScreenText = " "
        ScreenText = text
    end
end

function updateosd_text(text, append)
    if append then
        local Screen_Text = ScreenText .. "\n"
        Screen_Text = string.format(Screen_Text .. " : " .. text)
    end
    if not append then
        Screen_Text = " "
        Screen_Text = text
    end
end

function update_osd_text2(Text1, Text2, Text3)
    text1 = Text1
    text2 = Text2
    text3 = Text3
end

OSD_Debug = menu.add_feature("Debug OSD", "toggle", globalFeatures.moist_tools.id, function(feat)

    if feat.on then
        ScreenText2 = ' ` ‟ '
        ui.draw_rect(0.001, 0.090, 2.0, 0.075, 0, 0, 0, 125)
        --	ui.draw_rect(.38, .006, 0.250, 0.100, 0, 0, 0, 100)

        local pos = v2()

        pos.x = .5
        pos.y = 0.06

        ui.set_text_scale(0.40)
        ui.set_text_font(0)
        ui.set_text_color(255, 255, 255, 255)
        ui.set_text_centre(true)
        ui.set_text_outline(1)

        ui.draw_text(Screen_Text, pos)

        pos.x = .5
        pos.y = 0.06

        ui.set_text_scale(0.40)
        ui.set_text_font(0)
        ui.set_text_color(255, 255, 255, 255)
        ui.set_text_centre(true)
        ui.set_text_outline(1)

        return HANDLER_CONTINUE
    end

    return HANDLER_POP

end)
OSD_Debug.on = false
OSD_Debug.hidden = false

local Screen_TeXt, Screen_Text = "", ""
Debug_Font = false

function OSD_Debug_text(Text)

    local TeXt = Text or "These Functions are Experimental use at your own risk"
    updateosd_text(Text, false)
    OSD_Debug.on = true
    if not Debug_Font then
        system.wait(4500)
        OSD_Debug.on = false
    end

    local idx, idx2 = 0, 0
    while OSD_Debug.on and Debug_Font do
        idx = idx + 1
        Screen_TeXt = TeXt:sub(1, idx)
        updateosd_text(Screen_TeXt, false)
        idx2 = idx2 + 1
        if idx > #TeXt then
            idx = 0
            system.wait(50)
        elseif idx2 == 95 then
            idx2 = 0
            OSD_Debug.on = false
        end
        system.wait(35)
    end
    system.wait(30000)
    OSD_Debug.on = false

    return HANDLER_POP

end

OSD1_Debug = menu.add_feature("Debug OSD", "toggle", globalFeatures.moist_tools.id, function(feat)

    if feat.on then
        ScreenText2 = ' ` ‟ '
        ui.draw_rect(0.001, 0.090, 2.0, 0.075, 0, 0, 0, 125)
        --	ui.draw_rect(.38, .006, 0.250, 0.100, 0, 0, 0, 100)

        local pos = v2()

        pos.x = .5
        pos.y = 0.06

        ui.set_text_scale(0.40)
        ui.set_text_font(2)
        ui.set_text_color(255, 80, 80, 255)
        ui.set_text_centre(true)
        ui.set_text_outline(1)

        ui.draw_text(Screen_Text, pos)

        return HANDLER_CONTINUE
    end

    return HANDLER_POP

end)
OSD1_Debug.on = false
OSD1_Debug.hidden = false

OSD2_Debug = menu.add_feature("Debug OSD", "toggle", globalFeatures.moist_tools.id, function(feat)

    if feat.on then

        ui.draw_rect(0.001, 0.090, 2.0, 0.075, 0, 0, 0, 125)
        --	ui.draw_rect(.38, .006, 0.250, 0.100, 0, 0, 0, 100)
        local osdPos = v2(.5, 0.06)

        ui.set_text_scale(0.40)
        ui.set_text_font(0)
        ui.set_text_color(255, 80, 80, 255)
        ui.set_text_centre(true)
        ui.set_text_outline(1)

        ui.draw_text(Screen_Text, osdPos)

        return HANDLER_CONTINUE
    end

    return HANDLER_POP

end)
OSD2_Debug.on = false
OSD2_Debug.hidden = false

text_scale = 0.0
OSD_Debug2 = menu.add_feature("Debug OSD2", "toggle", globalFeatures.moist_tools.id, function(feat)
    if not Settings["playerscriptinfo"] then
        return
    end
    local Scr_x, Scr_y = graphics.get_screen_width(), graphics.get_screen_height()

    if feat.on then
        text_scale = 0.28
        if Scr_x == 1920 and Scr_y > 1020 then
            text_scale = 0.18
        end
        ui.draw_rect(0.001, 0.990, 0.325, 0.200, 0, 0, 0, 180)

        local pos = v2()

        pos.x = 0.001
        pos.y = .890

        ui.set_text_scale(text_scale)
        ui.set_text_font(0)
        ui.set_text_color(255, 255, 255, 255)
        ui.set_text_centre(false)
        ui.set_text_outline(1)
        if text1 == nil then
            text1 = "NaN"
        end
        ui.draw_text(text1, pos)
        ui.set_text_scale(text_scale)
        ui.set_text_font(0)
        ui.set_text_color(255, 255, 255, 255)
        ui.set_text_centre(false)
        ui.set_text_outline(1)

        pos.x = 0.001
        pos.y = .890
        ui.draw_text(text2, pos)
        ui.set_text_scale(text_scale)
        ui.set_text_font(0)
        ui.set_text_color(255, 255, 255, 255)
        ui.set_text_centre(false)
        ui.set_text_outline(1)

        pos.x = 0.001
        pos.y = .925
        ui.draw_text(text3, pos)

        ui.set_text_scale(text_scale)
        ui.set_text_font(0)
        ui.set_text_color(255, 255, 255, 255)
        ui.set_text_centre(false)
        ui.set_text_outline(1)

        pos.x = 0.081
        pos.y = .925
        ui.draw_text(text4, pos)

        return HANDLER_CONTINUE
    end
    ScreenText = ""
    text1 = ""
    text2 = ""
    text3 = ""
    return HANDLER_POP

end)
OSD_Debug2.on = false
OSD_Debug2.hidden = false

OSD.date_time_OSD = menu.add_feature("Date & Time OSD", "toggle", globalFeatures.moistopt, function(feat)
    Settings["osd_date_time"] = true
    while feat.on do

        local pos = v2()

        local d = os.date()

        local dtime = string.match(d, "%d%d:%d%d:%d%d")

        local dt = os.date("%d/%m/%y%y")

        pos.x = .5
        pos.y = 0.0395

        local d = os.date()

        local dtime = os.date("%a %d %b %I:%M:%S: %p")
        -- local dtime = string.match(d, "%d%d:%d%d:%d%d")

        local dt = os.date("%d/%m/%y%y")

        local osd_Cur_Time = (string.format(dtime))
        ui.set_text_scale(0.175)
        ui.set_text_font(0)
        ui.set_text_color(0, 0, 0, 255)
        ui.set_text_centre(true)
        ui.set_text_outline(1)
        ui.draw_text(osd_Cur_Time, pos)
        pos.x = .5
        pos.y = 0.0375

        local d = os.date()

        --    local dtime = string.match(d, "%d%d:%d%d:%d%d")

        local dtime = os.date("%a %d %b %I:%M:%S: %p")

        local osd_Cur_Time = (string.format(dtime))
        ui.set_text_scale(0.18)
        ui.set_text_font(0)
        ui.set_text_color(255, 255, 255, 255)
        ui.set_text_centre(true)
        ui.set_text_outline(1)
        ui.draw_text(osd_Cur_Time, pos)

        return HANDLER_CONTINUE
    end
    Settings["osd_date_time"] = false
    return HANDLER_POP

end)
OSD.date_time_OSD.on = Settings["osd_date_time"]

OSD.osd_My_speed1 = menu.add_feature("Show My Speed in Kmph", "toggle", globalFeatures.moistopt, function(feat)
    Settings["osd_My_speed1"] = true
    while feat.on do

        local pos = v2()
        pos.x = .970
        pos.y = 0.0600001

        local ent
        local ent1 = PlyPed(player.player_id())
        local ent2 = ped.get_vehicle_ped_is_using(PlyPed(player.player_id()))

        if ped.is_ped_in_any_vehicle(ent1) then
            ent = ent2
        else
            ent = ent1
        end
        local speed = entity.get_entity_speed(ent)
        local speedcalc = speed * 3.6 -- kmph
        local speedcalcm = speed * 2.236936 -- mph
        myspeed1 = math.ceil(speedcalc)
        myspeed2 = math.ceil(speedcalcm)

        ui.set_text_scale(0.22)
        ui.set_text_font(0)
        ui.set_text_color(0, 0, 0, 255)
        ui.set_text_centre(false)
        ui.set_text_outline(1)
        ui.draw_text(myspeed1 .. " kmph", pos)
        pos.x = .971
        pos.y = 0.060002

        ui.set_text_scale(0.22)
        ui.set_text_font(0)
        ui.set_text_color(255, 255, 255, 255)
        ui.set_text_centre(false)
        ui.set_text_outline(1)
        ui.draw_text(myspeed1 .. " kmph", pos)

        return HANDLER_CONTINUE
    end
    Settings["osd_My_speed1"] = false
    return HANDLER_POP

end)
OSD.osd_My_speed1.on = Settings["osd_My_speed1"]

OSD.osd_My_speed2 = menu.add_feature("Show My Speed in Mph", "toggle", globalFeatures.moistopt, function(feat)
    Settings["osd_My_speed2"] = true
    while feat.on do

        local pos = v2()
        pos.x = .970
        pos.y = 0.0600001

        local ent
        local ent1 = PlyPed(player.player_id())
        local ent2 = ped.get_vehicle_ped_is_using(PlyPed(player.player_id()))

        if ped.is_ped_in_any_vehicle(ent1) then
            ent = ent2
        else
            ent = ent1
        end
        local speed = entity.get_entity_speed(ent)
        local speedcalc = speed * 3.6 -- kmph
        local speedcalcm = speed * 2.236936 -- mph
        myspeed1 = math.ceil(speedcalc)
        myspeed2 = math.ceil(speedcalcm)

        ui.set_text_scale(0.22)
        ui.set_text_font(0)
        ui.set_text_color(0, 0, 0, 255)
        ui.set_text_centre(false)
        ui.set_text_outline(1)
        ui.draw_text(myspeed2 .. " mph", pos)
        pos.x = .971
        pos.y = 0.0600002

        ui.set_text_scale(0.22)
        ui.set_text_font(0)
        ui.set_text_color(255, 255, 255, 255)
        ui.set_text_centre(false)
        ui.set_text_outline(1)
        ui.draw_text(myspeed2 .. " mph", pos)

        return HANDLER_CONTINUE
    end
    Settings["osd_My_speed2"] = false
    return HANDLER_POP

end)
OSD.osd_My_speed2.on = Settings["osd_My_speed2"]

function SpamNotifyClear()

    local notifycount = ui.get_current_notification()
    for i = 0, notifycount do
        ui.remove_notification(i)
    end

end

-- TODO: Player Ped Weapons
local weap, weaponz
weap = {}
weaponz = {}

function getwephashes()
    weap = weapon.get_all_weapon_hashes()

    for i = 1, #weap do
        weaponz[i] = {weap[i], weapon.get_weapon_name(weap[i])}

    end

    weaponz[#weaponz + 1] = {1305664598, "Smoke GrenadeLauncher"}
end
getwephashes()

function give_weapon()

    for i = 1, #weaponz do
        local wid = weaponz[i][1]
        wid = menu.add_feature("Give: " .. weaponz[i][2], "action", globalFeatures.self_wep, function(feat)

            pped = PlyPed(player.player_id())
            weapon.give_delayed_weapon_to_ped(PlyPed(player.player_id()), weaponz[i][1], 1, 1)
            weapon.set_ped_ammo(PlyPed(player.player_id()), weaponz[i][1], 1000000)
            weapon.give_delayed_weapon_to_ped(pped, weaponz[i][1], 1, 1)
            weapon.set_ped_ammo(pped, weaponz[i][1], 1000000)
        end)

    end
end
give_weapon()

-- TODO: RPG

local wephash
local RPG_HOTFIRE = menu.add_feature("Rapid RPG Switch", "toggle", globalFeatures.self_options, function(feat)

    Settings["RPG_HOTFIRE"] = true
    if feat.on then
        local pped = player.get_player_ped(player.player_id())
        if ped.is_ped_shooting(pped) and not player.is_player_in_any_vehicle(player.player_id()) or ped.get_vehicle_ped_is_using == 0 or ped.get_vehicle_ped_is_using == nil then

            if ped.get_current_ped_weapon(pped) == 2982836145 then
                weapon.remove_weapon_from_ped(pped, 2982836145)
                weapon.give_delayed_weapon_to_ped(pped, 2982836145, 0, 1)
                weapon.set_ped_ammo(pped, 2982836145, 1000000)
            end
        end
        return HANDLER_CONTINUE
    end
    Settings["RPG_HOTFIRE"] = false
    return HANDLER_POP
end)
RPG_HOTFIRE.on = Settings["RPG_HOTFIRE"]

Mark_WeapImpPOS = menu.add_feature("Mark Weapon Impact POS", "toggle", globalFeatures.self_ped_combat, function(feat)
    if feat.on then
        pped = PlyPed(player.player_id())

        local success, pos = ped.get_ped_last_weapon_impact(pped, v3())
        if success then
            if pos.x and pos.y then
                local coord = v2()
                coord.x = pos.x
                coord.y = pos.y
                ui.set_new_waypoint(coord)
            end
        end

    end
    system.yield(0)
    return HANDLER_CONTINUE
end)
Mark_WeapImpPOS.on = false

-- TODO: Markers

RGB_A_A = 255
RGB_A_R = 255
RGB_A_G = 255
RGB_A_B = 255
RGB = {255, 0}
changeR = 255
changeG = 0
changeB = 0
changeA = 255
RGBA_R = 255
RGBA_G = 255
RGBA_B = 255
RGBA_A = 255

changRGB = menu.add_feature("fading red white Marker3 RGBA Changer", "toggle", globalFeatures.moistMkropt, function(feat)

    if feat.on then
        RGBA_G = RGB[1]
        RGBA_B = RGB[1]
        system.wait(100)
        RGBA_A = 180
        system.wait(75)
        RGBA_A = 100
        system.wait(75)
        RGBA_A = 25
        system.wait(25)
        RGBA_A = 0
        RGBA_G = RGB[2]
        RGBA_B = RGB[2]
        system.wait(25)
        RGBA_A = 25
        system.wait(75)
        RGBA_A = 100
        system.wait(75)
        RGBA_A = 180
        system.wait(25)
        RGBA_A = 255
        system.wait(100)
        return HANDLER_CONTINUE
    end
    return HANDLER_POP
end)
changRGB.on = false

chang_RGBA = menu.add_feature("flash red white Marker3 RGBA Changer", "toggle", globalFeatures.moistMkropt, function(feat)

    if feat.on then
        RGBA_G = RGB[1]
        RGBA_B = RGB[1]
        system.wait(500)
        RGBA_G = RGB[2]
        RGBA_B = RGB[2]
        system.wait(500)
        return HANDLER_CONTINUE
    end
    return HANDLER_POP
end)
chang_RGBA.on = false

changRGBA = menu.add_feature("multi fading colors Marker 1 2 5 RGB Changer", "toggle", globalFeatures.moistMkropt, function(feat)
    if feat.on then
        changeR = RGB[1]
        changeG = RGB[2]
        changeB = RGB[2]
        system.wait(100)
        changeA = 180
        system.wait(75)
        changeA = 100
        system.wait(75)
        changeA = 25
        system.wait(25)
        changeA = 0
        changeR = RGB[1]
        changeG = RGB[1]
        changeB = RGB[2]
        system.wait(5)
        changeA = 25
        system.wait(75)
        changeA = 100
        system.wait(75)
        changeA = 180
        system.wait(25)
        changeA = 255
        system.wait(100)
        changeA = 180
        system.wait(75)
        changeA = 100
        system.wait(75)
        changeA = 25
        system.wait(25)
        changeA = 0
        changeR = RGB[2]
        changeG = RGB[1]
        changeB = RGB[2]
        system.wait(5)
        changeA = 25
        system.wait(75)
        changeA = 100
        system.wait(75)
        changeA = 180
        system.wait(25)
        changeA = 255
        system.wait(100)
        changeA = 180
        system.wait(75)
        changeA = 100
        system.wait(75)
        changeA = 25
        system.wait(25)
        changeA = 0
        changeR = RGB[2]
        changeG = RGB[2]
        changeB = RGB[1]

        system.wait(5)
        changeA = 25
        system.wait(75)
        changeA = 100
        system.wait(75)
        changeA = 180
        system.wait(25)
        changeA = 255
        system.wait(100)
        changeA = 180
        system.wait(75)
        changeA = 100
        system.wait(75)
        changeA = 25
        system.wait(25)
        changeA = 0
        changeR = RGB[1]
        changeG = RGB[1]
        changeB = RGB[1]
        system.wait(5)
        changeA = 25
        system.wait(75)
        changeA = 100
        system.wait(75)
        changeA = 180
        system.wait(25)
        changeA = 255

        return HANDLER_CONTINUE
    end
    return HANDLER_POP
end)
changRGBA.on = false

changeRGB = menu.add_feature("Marker 1 2 5 RGB Changer", "toggle", globalFeatures.moistMkropt, function(feat)

    if feat.on then
        changeG = RGB[1]
        changeB = RGB[1]
        system.wait(100)
        changeA = 180
        system.wait(75)
        changeA = 100
        system.wait(75)
        changeA = 25
        system.wait(25)
        changeA = 0
        changeG = RGB[2]
        changeB = RGB[2]
        system.wait(25)
        changeA = 25
        system.wait(75)
        changeA = 100
        system.wait(75)
        changeA = 180
        system.wait(25)
        changeA = 255
        system.wait(100)
        return HANDLER_CONTINUE
    end
    return HANDLER_POP
end)
changeRGB.on = false

change_RGBA = menu.add_feature("Marker 1 2 5 RGB Changer", "toggle", globalFeatures.moistMkropt, function(feat)

    if feat.on then
        changeG = RGB[1]
        changeB = RGB[1]
        system.wait(500)
        changeG = RGB[2]
        changeB = RGB[2]
        system.wait(500)
        return HANDLER_CONTINUE
    end
    return HANDLER_POP
end)
change_RGBA.on = false

changeRGBA = menu.add_feature("Marker3 RGBA Changer", "toggle", globalFeatures.moistMkropt, function(feat)
    if feat.on then
        RGBA_R = RGB[1]
        RGBA_G = RGB[2]
        RGBA_B = RGB[2]
        system.wait(100)
        RGBA_A = 180
        system.wait(75)
        RGBA_A = 100
        system.wait(75)
        RGBA_A = 25
        system.wait(25)
        RGBA_A = 0
        RGBA_R = RGB[1]
        RGBA_G = RGB[1]
        RGBA_B = RGB[2]
        system.wait(5)
        RGBA_A = 25
        system.wait(75)
        RGBA_A = 100
        system.wait(75)
        RGBA_A = 180
        system.wait(25)
        RGBA_A = 255
        system.wait(100)
        RGBA_A = 180
        system.wait(75)
        RGBA_A = 100
        system.wait(75)
        RGBA_A = 25
        system.wait(25)
        RGBA_A = 0
        RGBA_R = RGB[2]
        RGBA_G = RGB[1]
        RGBA_B = RGB[2]
        system.wait(5)
        RGBA_A = 25
        system.wait(75)
        RGBA_A = 100
        system.wait(75)
        RGBA_A = 180
        system.wait(25)
        RGBA_A = 255
        system.wait(100)
        RGBA_A = 180
        system.wait(75)
        RGBA_A = 100
        system.wait(75)
        RGBA_A = 25
        system.wait(25)
        RGBA_A = 0
        RGBA_R = RGB[2]
        RGBA_G = RGB[2]
        RGBA_B = RGB[1]

        system.wait(5)
        RGBA_A = 25
        system.wait(75)
        RGBA_A = 100
        system.wait(75)
        RGBA_A = 180
        system.wait(25)
        RGBA_A = 255
        system.wait(100)
        RGBA_A = 180
        system.wait(75)
        RGBA_A = 100
        system.wait(75)
        RGBA_A = 25
        system.wait(25)
        RGBA_A = 0
        RGBA_R = RGB[1]
        RGBA_G = RGB[1]
        RGBA_B = RGB[1]
        system.wait(5)
        RGBA_A = 25
        system.wait(75)
        RGBA_A = 100
        system.wait(75)
        RGBA_A = 180
        system.wait(25)
        RGBA_A = 255
        return HANDLER_CONTINUE
    end
    return HANDLER_POP
end)
changeRGBA.on = false

rgb_rand = menu.add_feature("rand rgb 3 on (delay)", "value_i", globalFeatures.moistMkropt, function(feat)
    if feat.on then

        RGBA_G = math.random(0, 255)

        system.wait(feat.value)

        RGBA_R = math.random(0, 255)

        system.wait(feat.value)

        RGBA_B = math.random(0, 255)

        system.wait(feat.value)

        return HANDLER_CONTINUE
    end
end)
rgb_rand.on = false
rgb_rand.max = 500
rgb_rand.min = 1
rgb_rand.value = 5

rgb_rand1 = menu.add_feature("rand rgb 4 on (delay)", "value_i", globalFeatures.moistMkropt, function(feat)
    if feat.on then

        RGB_A_A = math.random(0, 255)

        system.wait(feat.value / 2)

        RGB_A_G = math.random(0, 255)

        system.wait(feat.value)

        RGB_A_R = math.random(0, 255)

        system.wait(feat.value)

        RGB_A_B = math.random(0, 255)

        system.wait(feat.value)

        return HANDLER_CONTINUE
    end
end)
rgb_rand1.on = false
rgb_rand1.max = 500
rgb_rand1.min = 1
rgb_rand1.value = 15

marker1_rgbd = menu.add_feature("rgb 4 on", "toggle", globalFeatures.moistMkropt, function(feat)
    if feat.on then
        local RGB_A = {255, 0}

        RGB_A_R = RGB_A[1]
        RGB_A_G = RGB_A[2]
        RGB_A_B = RGB_A[2]
        system.wait(100)
        RGB_A_A = 180
        system.wait(75)
        RGB_A_A = 100
        system.wait(75)
        RGB_A_A = 25
        system.wait(25)
        RGB_A_A = 0
        RGB_A_R = RGB_A[1]
        RGB_A_G = RGB_A[1]
        RGB_A_B = RGB_A[2]
        system.wait(5)
        RGB_A_A = 25
        system.wait(75)
        RGB_A_A = 100
        system.wait(75)
        RGB_A_A = 180
        system.wait(25)
        RGB_A_A = 255
        system.wait(100)
        RGB_A_A = 180
        system.wait(75)
        RGB_A_A = 100
        system.wait(75)
        RGB_A_A = 25
        system.wait(25)
        RGB_A_A = 0
        RGB_A_R = RGB_A[2]
        RGB_A_G = RGB_A[1]
        RGB_A_B = RGB_A[2]
        system.wait(5)
        RGB_A_A = 25
        system.wait(75)
        RGB_A_A = 100
        system.wait(75)
        RGB_A_A = 180
        system.wait(25)
        RGB_A_A = 255
        system.wait(100)
        RGB_A_A = 180
        system.wait(75)
        RGB_A_A = 100
        system.wait(75)
        RGB_A_A = 25
        system.wait(25)
        RGB_A_A = 0
        RGB_A_R = RGB_A[2]
        RGB_A_G = RGB_A[2]
        RGB_A_B = RGB_A[1]
        system.wait(5)
        RGB_A_A = 25
        system.wait(75)
        RGB_A_A = 100
        system.wait(75)
        RGB_A_A = 180
        system.wait(25)
        RGB_A_A = 255
        system.wait(100)
        RGB_A_A = 180
        system.wait(75)
        RGB_A_A = 100
        system.wait(75)
        RGB_A_A = 25
        system.wait(25)
        RGB_A_A = 0
        RGB_A_R = RGB_A[1]
        RGB_A_G = RGB_A[1]
        RGB_A_B = RGB_A[1]
        system.wait(5)
        RGB_A_A = 25
        system.wait(75)
        RGB_A_A = 100
        system.wait(75)
        RGB_A_A = 180
        system.wait(25)
        RGB_A_A = 255

        return HANDLER_CONTINUE
    end
    return HANDLER_POP
end)
marker1_rgbd.on = false

-- TODO: Online Player Spawn Features
-- TODO: Player Features

function load_spawn_options()

    for i = 1, #escort_ped do
        playerFeat1[i] = menu.add_player_feature("Ped: " .. escort_ped[i][1], "parent", playerfeatVars.b, function()
            model = escort_ped[i][2]
        end).id

    end

    for i = 1, #playerFeat1 do

        playerFeatParent[#playerFeatParent + 1] = menu.add_player_feature("Ped + Weapon", "parent", playerFeat1[i]).id
    end

    for i = 1, #playerFeat1 do
        playerFeatParent2[#playerFeatParent2 + 1] = menu.add_player_feature("Ped + Vehicle", "parent", playerFeat1[i]).id
    end

    for i = 1, #playerFeatParent do
        for y = 1, #ped_wep do

            playerFeat2[#playerFeat2 + 1] = menu.add_player_feature("Wep: " .. ped_wep[y][1], "parent", playerFeatParent[i], function()
                wephash = ped_wep[y][2]

            end).id
        end
    end

    for i = 1, #playerFeat2 do
        menu.add_player_feature("Send Attacker via Parachute", "action", playerFeat2[i], function(feat, pid)

            pped = PlyPed(pid)

            spawn_ped_v2(pid, model, true)

            system.wait(100)
            local i = #escort
            pos = player.get_player_coords(pid)
            ai.task_parachute_to_target(escort[i], pos)

            system.wait(12000)
            weapon.give_delayed_weapon_to_ped(escort[i], wephash, 0, 1)

            ai.task_combat_ped(escort[i], pped, 0, 16)
        end)
    end

    for i = 1, #playerFeat2 do
        menu.add_player_feature("Spawn Attacker & Task", "action", playerFeat2[i], function(feat, pid)

            pped = PlyPed(pid)

            spawn_ped(pid, model, -15, true, nil)

            system.wait(100)
            local i = #escort
            entity.set_entity_god_mode(escort[i], true)
            ped.set_ped_combat_attributes(escort[i], 52, true)
            ped.set_ped_combat_attributes(escort[i], 1, true)
            ped.set_ped_combat_attributes(escort[i], 46, true)
            ped.set_ped_combat_attributes(escort[i], 2, true)
            ped.set_ped_combat_range(escort[i], 2)
            ped.set_ped_combat_ability(escort[i], 2)
            ped.set_ped_combat_movement(escort[i], 2)
            weapon.give_delayed_weapon_to_ped(escort[i], wephash, 0, 1)
            weapon.set_ped_ammo(escort[i], wephash, 1000000)
            ped.set_ped_can_switch_weapons(escort[i], true)
            ai.task_combat_ped(escort[i], pped, 0, 16)

        end)
    end

    for i = 1, #playerFeat2 do
        menu.add_player_feature("Spawn Support Ped", "action", playerFeat2[i], function(feat, pid)

            pped = PlyPed(pid)

            spawn_ped(pid, model, 5, false, nil)

            system.wait(100)
            local i = #escort
            entity.set_entity_god_mode(escort[i], true)
            ped.set_ped_combat_attributes(escort[i], 52, true)
            ped.set_ped_combat_attributes(escort[i], 1, true)
            ped.set_ped_combat_attributes(escort[i], 46, true)
            ped.set_ped_combat_attributes(escort[i], 2, true)
            ped.set_ped_combat_range(escort[i], 2)
            ped.set_ped_combat_ability(escort[i], 2)
            ped.set_ped_combat_movement(escort[i], 2)
            weapon.give_delayed_weapon_to_ped(escort[i], wephash, 0, 1)
            weapon.set_ped_ammo(escort[i], wephash, 1000000)
            ped.set_ped_can_switch_weapons(escort[i], true)

        end)
    end

    for i = 1, #playerFeatParent2 do
        for y = 1, #veh_list do

            playerFeat3[#playerFeat3 + 1] = menu.add_player_feature("Veh: " .. veh_list[y][1], "parent", playerFeatParent2[i], function()
                vehhash = veh_list[y][2]
                if veh_list[y][3] == nil then
                    mod = 10
                    modvalue = -1
                else
                    mod = veh_list[y][3]
                    modvalue = veh_list[y][4]

                end

            end).id
        end
    end

    for i = 1, #playerFeat3 do
        menu.add_player_feature("Spawn as Escort & Task", "action", playerFeat3[i], function(feat, pid)
            spawn_ped(pid, model, -10, false, nil)
            groupIDs = {}
            local i = #groupIDs + 1
            groupIDs[i] = ped.create_group()
            local y = #groupIDs + 1
            groupIDs[y] = ped.create_group()
            ped.set_relationship_between_groups(0, groupIDs[i], groupIDs[y])
            ped.set_relationship_between_groups(0, groupIDs[y], groupIDs[i])
            system.wait(100)
            spawn_veh(pid, vehhash, -10, mod, modvalue)
            system.wait(100)
            local p, y, x
            p = #escort
            y = #escortveh

            ped.set_ped_as_group_member(escort[p], groupIDs[i])
            ped.set_ped_never_leaves_group(escort[p], true)

            ped.set_ped_into_vehicle(escort[p], escortveh[y], -1)
            pped = PlyPed(pid)
            ai.task_vehicle_follow(escort[p], escortveh[y], pped, 250.00, 262144, 25)

            if vehhash == 0x2189D250 then
                spawn_ped(pid, model, 10, false, nil)
                x = #escort
                ped.set_ped_as_group_member(escort[x], groupIDs[i])
                ped.set_ped_never_leaves_group(escort[x], true)
                ped.set_ped_into_vehicle(escort[x], escortveh[y], 0)
            end
            if vehhash == 0xF92AEC4D then
                spawn_ped(pid, model, 10, false, nil)
                x = #escort
                ped.set_ped_as_group_member(escort[x], groupIDs[i])
                ped.set_ped_never_leaves_group(escort[x], true)
                ped.set_ped_into_vehicle(escort[x], escortveh[y], 3)
            end
            if vehhash == 0xA09E15FD then
                spawn_ped(pid, model, 10, false, nil)
                x = #escort
                ped.set_ped_as_group_member(escort[x], groupIDs[i])
                ped.set_ped_never_leaves_group(escort[x], true)
                ped.set_ped_into_vehicle(escort[x], escortveh[y], 1)
                spawn_ped(pid, model, 10, false, nil)
                x = #escort
                ped.set_ped_as_group_member(escort[x], groupIDs[i])
                ped.set_ped_never_leaves_group(escort[x], true)
                ped.set_ped_into_vehicle(escort[x], escortveh[y], 2)
            end
            if vehhash == 0x5BFA5C4B then
                spawn_ped(pid, model, 10, false, nil)
                x = #escort
                ped.set_ped_as_group_member(escort[x], groupIDs[i])
                ped.set_ped_never_leaves_group(escort[x], true)
                ped.set_ped_into_vehicle(escort[x], escortveh[y], 1)

                spawn_ped(pid, model, 10, false, nil)
                x = #escort
                ped.set_ped_as_group_member(escort[x], groupIDs[i])
                ped.set_ped_never_leaves_group(escort[x], true)
                ped.set_ped_into_vehicle(escort[x], escortveh[y], 2)
            end
            if vehhash == 0x9114EADA then
                spawn_ped(pid, model, 10, false, nil)
                x = #escort
                ped.set_ped_as_group_member(escort[x], groupIDs[i])
                ped.set_ped_never_leaves_group(escort[x], true)
                ped.set_ped_into_vehicle(escort[x], escortveh[y], 7)
            end
            if vehhash == 0x8D4B7A8A then
                spawn_ped(pid, model, 10, false, nil)
                x = #escort
                ped.set_ped_as_group_member(escort[x], groupIDs[i])
                ped.set_ped_never_leaves_group(escort[x], true)
                ped.set_ped_into_vehicle(escort[x], escortveh[y], 7)
            end

        end)
    end

    for i = 1, #playerFeat3 do
        menu.add_player_feature("Spawn as Attacker & Task", "action", playerFeat3[i], function(feat, pid)
            pped = PlyPed(pid)
            spawn_ped(pid, model, 10, true, nil)
            system.wait(100)
            spawn_veh(pid, vehhash, -10, mod, modvalue)
            local p, y, x
            p = #escort
            y = #escortveh

            ped.set_ped_into_vehicle(escort[p], escortveh[y], -1)
            ai.task_combat_ped(escort[p], pped, 0, 16)

            if vehhash == 0x2189D250 then
                spawn_ped(pid, model, 10, true, nil)
                x = #escort
                ped.set_ped_into_vehicle(escort[x], escortveh[y], 0)
                ai.task_combat_ped(escort[x], pped, 0, 16)
            end
            if vehhash == 0xF92AEC4D then
                spawn_ped(pid, model, 10, true, nil)
                x = #escort
                ped.set_ped_into_vehicle(escort[x], escortveh[y], 3)
                ai.task_combat_ped(escort[x], pped, 0, 16)
            end
            if vehhash == 0xA09E15FD then
                spawn_ped(pid, model, 10, true, nil)
                x = #escort
                ped.set_ped_into_vehicle(escort[x], escortveh[y], 1)
                ai.task_combat_ped(escort[x], pped, 0, 16)
                spawn_ped(pid, model, 10, true, nil)
                x = #escort
                ped.set_ped_into_vehicle(escort[x], escortveh[y], 2)
                ai.task_combat_ped(escort[x], pped, 0, 16)
            end
            if vehhash == 0x5BFA5C4B then
                spawn_ped(pid, model, 10, true, nil)
                x = #escort
                ped.set_ped_into_vehicle(escort[x], escortveh[y], 1)
                ai.task_combat_ped(escort[x], pped, 0, 16)
                spawn_ped(pid, model, 10, true, nil)
                x = #escort
                ped.set_ped_into_vehicle(escort[x], escortveh[y], 2)
                ai.task_combat_ped(escort[x], pped, 0, 16)
            end
            if vehhash == 0x9114EADA then
                spawn_ped(pid, model, 10, true, nil)
                x = #escort
                ped.set_ped_into_vehicle(escort[x], escortveh[y], 7)
                ai.task_combat_ped(escort[x], pped, 0, 16)
            end
            if vehhash == 0x8D4B7A8A then
                spawn_ped(pid, model, 10, true, nil)
                x = #escort
                ped.set_ped_into_vehicle(escort[x], escortveh[y], 7)
                ai.task_combat_ped(escort[x], pped, 0, 16)
            end

        end)
    end

end

-- TODO: Online Friends Checker

menu.add_feature("Any Friends Online?", "action", globalFeatures.lobby, function(feat)
    for i = 0, network.get_friend_count() - 1 do
        local friendName, friendScid, friendOnline, friendMplay
        friendName = network.get_friend_index_name(i)
        friendScid = network.get_friend_scid(friendName)
        friendOnline = network.is_friend_index_online(i)
        friendMplay = network.is_friend_in_multiplayer(friendName)

        print(string.format("Friend index %s %s (%s) is %s", i, friendName, friendScid, friendOnline and "online" or "offline"))
        if friendOnline then
            Debug_Out("Online Friends Found: \n" .. i .. ": " .. friendName .. " (" .. friendScid .. ")")
            if friendMplay then
                ui.notify_above_map("~h~~u~ Online ~u~Friend : " .. friendName .. "~h~~u~\nis Playing Online", "~u~Network ~u~Presence", 172)
            else
                ui.notify_above_map("~h~~u~ Online ~u~Friend : " .. friendName, "~u~Network Presence", 47)
            end
            system.wait(100)
        end
    end
end)

-- TODO: Orbitor Features

Degree = 0

function Orbit2(Distance)

    while not streaming.has_model_loaded(2906806882) do
        streaming.request_model(2906806882)
        system.wait(1)
    end

    local RootPos = player.get_player_coords(orbit_pid)
    RootPos.z = RootPos.z + 3.500
    EntityHash.pid[#EntityHash.pid + 1] = object.create_object(2906806882, RootPos + Distance, true, false)

    entity.set_entity_gravity(EntityHash.pid[#EntityHash.pid], 0)
    entity.freeze_entity(EntityHash.pid[#EntityHash.pid], false)
    while true do
        Degree = Degree + 3.75
        if Degree > 360 then
            Degree = -360
        end
        local rad = math.rad(Degree)
        RootPos = player.get_player_coords(orbit_pid)
        local x = Distance * math.cos(rad) + RootPos.x
        local y = Distance * math.sin(rad) + RootPos.y
        local zz = Distance * math.sin(rad) + RootPos.z

        -- entity.set_entity_coords_no_offset(EntityHash.pid[#EntityHash.pid], v3(x + 1.0, y + 1.0, RootPos.z + 0.5))
        entity.set_entity_coords_no_offset(EntityHash.pid[#EntityHash.pid], v3(x, y, RootPos.z))
        entity.set_entity_rotation(EntityHash.pid[#EntityHash.pid], v3(x, y, zz))

        system.wait(1)
    end
end

function Orbit1(Distance)

    while not streaming.has_model_loaded(2906806882) do
        streaming.request_model(2906806882)
        system.wait(1)
    end

    RootPos = player.get_player_coords(orbit_pid)
    RootPos.z = RootPos.z + 3.500
    EntityHash2.pid[#EntityHash2.pid + 1] = object.create_object(2906806882, RootPos + Distance, true, false)

    entity.set_entity_gravity(EntityHash2.pid[#EntityHash2.pid], 0)
    entity.freeze_entity(EntityHash2.pid[#EntityHash2.pid], false)
    while true do
        local rad, RootPos, x, y, zz
        Degree = Degree + 3.75
        if Degree > 360 then
            Degree = -360
        end
        rad = math.rad(Degree)
        RootPos = player.get_player_coords(orbit_pid)
        x = Distance * math.cos(rad) + RootPos.x
        y = Distance * math.sin(rad) + RootPos.y
        zz = Distance * math.sin(rad) + RootPos.z

        entity.set_entity_coords_no_offset(EntityHash2.pid[#EntityHash2.pid], v3(x + 1.0, y + 1.0, RootPos.z + 0.5))
        -- entity.set_entity_coords_no_offset(EntityHash.pid[#EntityHash.pid], v3(x, y, RootPos.z))
        entity.set_entity_rotation(EntityHash2.pid[#EntityHash2.pid], v3(x, y, zz))

        system.wait(1)
    end
end

function spawn_attach(hash, bone, pos, rot, col, pid)

    streaming.request_model(hash)
    while (not streaming.has_model_loaded(hash)) do
        system.wait(10)
    end

    local i = #spawned_cunts + 1
    spawned_cunts[i] = object.create_object(hash, pos, true, false)

    pped = PlyPed(pid)
    entity.attach_entity_to_entity(spawned_cunts[i], pped, bone, pos, rot, true, col, false, 0, true)
end

function ped_groups()
    local a, b
    groupIDs[#groupIDs + 1] = ped.create_group()
    groupIDs[#groupIDs + 1] = ped.create_group()

    a = #groupIDs
    b = #groupIDs - 1
    ped.set_relationship_between_groups(0, groupIDs[a], groupIDs[b])
    ped.set_relationship_between_groups(0, groupIDs[b], groupIDs[a])
end

OSD_Debugon = function()
    if not OSD_Debug.on then
        OSD_Debug.on = true
    else
        OSD_Debug.on = not OSD_Debug.on
        system.yield(25000)
    end
end
OSD_Debugon_on = false

function OSDDebugTurnOn()
    if OSD_Debug.on == false then
        OSD_Debug.on = true
        system.yield(25000)
        OSD_Debug.on = false
    elseif OSD_Debug.on == true then
        system.yield(25000)
        OSD_Debug.on = false
    end
end

-- TODO: Player list
Playerz = {}
for pid = 0, 32 do
    Playerz[pid + 1] = string.format("Player " .. pid)
end
ScriptLocals["playerlist"] = function()
    local pos, PlyImpactPos, offset, ply_veh, ply_ped = v3(), v3(), v3(), {}, {}
    for pid = 0, 32 do

        ScriptLocals["featureVars"] = featureVars
        featureVars = {}

        OSD_Debug2.on = false
        featureVars.f = menu.add_feature("Player " .. pid, "parent", playersFeature.id, function(feat)
            Active_menu = pid
            health, infoA, infoB = Player_Check(pid)
            OSD_Debug2.on = true
            ply_veh[pid + 1] = player.get_player_vehicle(pid)
            ply_ped[pid + 1] = PlyPed(pid)
            return HANDLER_POP
        end)

        featureVars.k = menu.add_feature("Remove Player Options", "parent", featureVars.f.id)
        featureVars.v = menu.add_feature("Vehicle Options", "parent", featureVars.f.id, function(feat)

            OSD_Debug.on = false
            Debug_Font = false

        end)
        featureVars.vd = menu.add_feature("Experimental Decor's", "parent", featureVars.v.id, function(feat)
            Debug_Font = true
            OSD_Debug_text("These Functions are Experimental use at your own risk")

        end)
        featureVars.t = menu.add_feature("Teleport Options", "parent", featureVars.f.id)

        featureVars.h = menu.add_feature("Highlight Options", "parent", featureVars.f.id, function(feat)
            if not highlight_set[pid + 1] then

                markID.z[pid + 5] = 1.0
                markID.s[pid + 5] = 1.0
                markID.ROT[pid + 5] = true
                markID.BOB[pid + 5] = true
                markID.z[pid + 4] = 1.0
                markID.s[pid + 4] = 1.0
                markID.BOB[pid + 4] = true
                markID.ROT[pid + 4] = true
                markID.z[pid + 2] = -2.0
                markID.s[pid + 2] = 2.5
                markID.BOB[pid + 2] = true
                markID.ROT[pid + 2] = true
                markID.z[pid + 3] = 1.0
                markID.s[pid + 3] = 1.0
                markID.BOB[pid + 3] = true
                markID.ROT[pid + 3] = true
                markID.z[pid + 6] = 1.0
                markID.s[pid + 6] = 1.0
                markID.BOB[pid + 6] = true
                markID.ROT[pid + 6] = true

                highlight_set[pid + 1] = true
            end

        end)

        featureVars.ch = menu.add_feature("Custom Options", "parent", featureVars.h.id)
        featureVars.chc = menu.add_feature("Custom Color Change", "parent", featureVars.ch.id)
        featureVars.tr = menu.add_feature("Troll Options", "parent", featureVars.f.id)
        featureVars.str = menu.add_feature("Sound Features", "parent", featureVars.tr.id)
        featureVars.at = menu.add_feature("Attachment Options", "parent", featureVars.f.id)
        featureVars.g = menu.add_feature("Griefing Options", "parent", featureVars.f.id)
        featureVars.lgr = menu.add_feature("Lester Griefer", "parent", featureVars.g.id)
        featureVars.gr = menu.add_feature("Lester Ramjet", "parent", featureVars.lgr.id)
        featureVars.n = menu.add_feature("Info Options", "parent", featureVars.f.id)

        features = {}
        -- TODO: Vehicle Options

        local decorator_typetable = {"DECOR_TYPE_FLOAT", "DECOR_TYPE_BOOL", "DECOR_TYPE_INT", "DECOR_TYPE_UNK", "DECOR_TYPE_TIME"}
        local DecorAddFeat, DecorFeat, Bool_Value, Bool_Bool = {}, {}, {"true", "false"}, {true, false}
        local function vehdecor()
            for i = 1, #decorators do
                local decor_typetable = decorator_typetable
                local DecorType, typenum = decoratorType[decorators[i][2]], decorators[i][2]
                local decor = tostring(decorators[i][1])
                if DecorType == "DECOR_TYPE_FLOAT" then
                    decor_typetable = {"DECOR_TYPE_FLOAT", "DECOR_TYPE_BOOL", "DECOR_TYPE_INT", "DECOR_TYPE_UNK", "DECOR_TYPE_TIME"}
                elseif DecorType == "DECOR_TYPE_BOOL" then
                    decor_typetable = {"DECOR_TYPE_BOOL", "DECOR_TYPE_FLOAT", "DECOR_TYPE_INT", "DECOR_TYPE_UNK", "DECOR_TYPE_TIME"}
                elseif DecorType == "DECOR_TYPE_INT" or DecorType == "DECOR_TYPE_UNK" then
                    decor_typetable = {"DECOR_TYPE_INT", "DECOR_TYPE_FLOAT", "DECOR_TYPE_BOOL", "DECOR_TYPE_UNK", "DECOR_TYPE_TIME"}
                elseif DecorType == "DECOR_TYPE_TIME" then
                    decor_typetable = {"DECOR_TYPE_TIME", "DECOR_TYPE_FLOAT", "DECOR_TYPE_BOOL", "DECOR_TYPE_INT", "DECOR_TYPE_UNK"}
                end
                local y = #DecorFeat + 1
                local Decor_feat = DecorFeat[y]
                Decor_feat = menu.add_feature(i .. ": " .. decor, "parent", featureVars.vd.id).id
                local DecorCheckCustype = menu.add_feature("Check for Decorator", "action_value_str", Decor_feat, function(feat)
                    local decor, Type, exists, decorval
                    local plyveh = player.get_player_vehicle(pid)
                    if plyveh ~= nil or plyveh ~= 0 then
                        decor = tostring(decorators[i][1])
                        Type = decoratorType[decorators[i][2]]
                        exists = decorator.decor_exists_on(plyveh, decor)
                        if exists == true and Type == "DECOR_TYPE_FLOAT" then
                            decorval = decorator.decor_get_float(plyveh, decor)
                            moist_notify(decor .. " Exists on Vehicle\n", string.lower(Type) .. " Value is: " .. decorval)
                        elseif exists == true and Type == "DECOR_TYPE_BOOL" then
                            decorval = tostring(decorator.decor_get_bool(plyveh, decor))
                            moist_notify(decor .. " Exists on Vehicle\n", string.lower(Type) .. " Value is: " .. decorval)
                        elseif exists == true and Type == "DECOR_TYPE_INT" then
                            local nethash, name
                            decorval = decorator.decor_get_int(plyveh, decor)
                            moist_notify(decor .. " Exists on Vehicle\n", string.lower(Type) .. " Value is: " .. decorval)
                            for pid = 0, 32 do
                                nethash = network.network_hash_from_player(pid)
                                if nethash == decorval then
                                    name = player.get_player_name(pid)
                                    moist_notify(decor .. " = Hash of Player: ", name)
                                end
                            end

                        elseif exists == true and Type == "DECOR_TYPE_TIME" then
                            decorval = decorator.decor_get_int(plyveh, decor)
                            moist_notify(decor .. " Exists on Vehicle\n", string.lower(Type) .. " Value is: " .. decorval)
                        elseif exists == true and Type == "DECOR_TYPE_UNK" then
                            moist_notify(decor .. "This Decorator is Type UNK! Function for this Type", "Does not exist in the api Yet!")
                        end
                    end
                end)
                DecorCheckCustype:set_str_data(decor_typetable)

                -- if decorators[i][2] == 2 then
                local f = menu.add_feature("Set Decorator on Vehicle as: ", "action_value_str", Decor_feat, function(feat)
                    local decor, Type, exists, decorval, nplyhash, plyveh
                    plyveh = player.get_player_vehicle(pid)
                    if plyveh ~= nil or plyveh ~= 0 then
                        decor = tostring(decorators[i][1])
                        Type = decoratorType[decorators[i][2]]
                        nplyhash = network.network_hash_from_player(pid)
                        network.request_control_of_entity(plyveh)
                        decorator.decor_register(decor, 2)
                        network.request_control_of_entity(plyveh)
                        decorator.decor_set_bool(plyveh, decor, Bool_Bool[feat.value + 1])
                        decorval = tostring(decorator.decor_get_bool(plyveh, decor))
                        moist_notify(decor .. " Exists on Vehicle\n", decorval)
                    end
                end)
                f:set_str_data(Bool_Value)
                --  end
                menu.add_feature("Remove Decorator from Vehicle", "action", Decor_feat, function(feat)
                    local plyveh, decor
                    decor = decorators[i][1]
                    plyveh = player.get_player_vehicle(pid)
                    network.request_control_of_entity(plyveh)
                    decorator.decor_remove(plyveh, decor)
                    moist_notify(decor .. " Exists on Vehicle\n", "Now its Been Removed")
                end)

                if decorators[i][2] ~= 2 then
                    menu.add_feature("Add Decorator to Vehicle", "action", Decor_feat, function(feat)
                        local decor, Type, exists, decorval, nplyhash, plyveh
                        plyveh = player.get_player_vehicle(pid)
                        if plyveh ~= nil or plyveh ~= 0 then
                            decor = tostring(decorators[i][1])
                            Type = decoratorType[decorators[i][2]]
                            nplyhash = network.network_hash_from_player(pid)

                            if Type == "DECOR_TYPE_FLOAT" then

                                local r, s = input.get("Input Decorator Float Value", "", 96, 5)
                                if r == 1 then
                                    return HANDLER_CONTINUE
                                end
                                if r == 2 then
                                    return HANDLER_POP
                                end

                                network.request_control_of_entity(plyveh)
                                decorator.decor_register(decor, 1)
                                decorator.decor_set_float(plyveh, decor, s)

                            elseif Type == "DECOR_TYPE_INT" then
                                local r, s = input.get("Input Decorator INT Value", "", 96, 3)
                                if r == 1 then
                                    return HANDLER_CONTINUE
                                end
                                if r == 2 then
                                    return HANDLER_POP
                                end
                                network.request_control_of_entity(plyveh)
                                decorator.decor_register(decor, 3)
                                decorator.decor_set_int(plyveh, decor, 1 << tonumber(s))

                            elseif Type == "DECOR_TYPE_TIME" then
                                network.request_control_of_entity(plyveh)
                                decorator.decor_register(decor, 5)
                                decorator.decor_set_time(plyveh, decor, utils.time())
                            elseif Type == "DECOR_TYPE_UNK" then
                                moist_notify(decor .. "This Decorator is Type UNK! Function for this Type", "Does not exist in the api Yet!")
                            else
                                moist_notify(decor .. "Set on Vehicle\n", s or utils.time())
                            end
                        end
                    end)
                    local add_decor_custype = menu.add_feature("Add Decorator to Vehicle", "action_value_str", Decor_feat, function(feat)
                        local decor, Type, exists, decorval, nplyhash, plyveh
                        plyveh = player.get_player_vehicle(pid)
                        if plyveh ~= nil or plyveh ~= 0 then
                            decor = tostring(decorators[i][1])
                            Type = decoratorType[feat.value + 1]
                            nplyhash = network.network_hash_from_player(pid)

                            local r, s = input.get("Input DecorValue:int:Num(1234)|float:NumDot(1234.5678)|Bool:(<true|false>)", utils.time(), 96, 2)
                            if r == 1 then
                                return HANDLER_CONTINUE
                            end
                            if r == 2 then
                                return HANDLER_POP
                            end
                            if feat.value == 0 then
                                network.request_control_of_entity(plyveh)
                                decorator.decor_register(decor, 1)
                                decorator.decor_set_float(plyveh, decor, s)
                            end
                            if feat.value == 1 then
                                network.request_control_of_entity(plyveh)
                                decorator.decor_register(decor, 2)
                                decorator.decor_set_bool(plyveh, decor, s)
                            end
                            if feat.value == 2 then
                                network.request_control_of_entity(plyveh)
                                decorator.decor_register(decor, 3)
                                decorator.decor_set_int(plyveh, decor, tonumber(s))
                            end

                            if feat.value == 3 then
                                network.request_control_of_entity(plyveh)
                                decorator.decor_register(decor, 4)
                                decorator.decor_set_int(plyveh, decor, tonumber(s))
                            end

                            if feat.value == 4 then
                                network.request_control_of_entity(plyveh)
                                decorator.decor_register(decor, 5)
                                decorator.decor_set_time(plyveh, decor, tonumber(s))
                            end

                        end
                    end)
                    add_decor_custype:set_str_data(decoratorType)
                end
                --  DecorAddBool:set_str_data({"true","false"})
            end
        end
        vehdecor()

        features["godvehoff"] = {
            feat = menu.add_feature("Player Vehicle God Mode OFF", "action", featureVars.v.id, function(feat)

                plyveh = player.get_player_vehicle(pid)
                while not network.has_control_of_entity(plyveh) do
                    network.request_control_of_entity(plyveh)
                    return HANDLER_CONTINUE
                end
                entity.set_entity_god_mode(plyveh, false)

                return HANDLER_POP
            end),
            type = "action",
            callback = function()
            end
        }

        features["LockOn"] = {
            feat = menu.add_feature("Vehicle Targetable", "action", featureVars.v.id, function(feat)
                plyveh = player.get_player_vehicle(pid)
                while not network.has_control_of_entity(plyveh) do
                    network.request_control_of_entity(plyveh)
                    return HANDLER_CONTINUE
                end
                vehicle.set_vehicle_can_be_locked_on(plyveh, true, true)
                return HANDLER_POP
            end),
            type = "action",
            callback = function()
            end
        }

        features["LockOFF"] = {
            feat = menu.add_feature("Vehicle Not Targetable", "action", featureVars.v.id, function(feat)
                plyveh = player.get_player_vehicle(pid)
                while not network.has_control_of_entity(plyveh) do
                    network.request_control_of_entity(plyveh)
                    return HANDLER_CONTINUE
                end
                vehicle.set_vehicle_can_be_locked_on(plyveh, false, false)
                return HANDLER_POP
            end),
            type = "action",
            callback = function()
            end
        }

        features["set_Boost"] = {
            feat = menu.add_feature("Set Boost & Forward Speed", "action", featureVars.v.id, function(feat)
                plyveh = player.get_player_vehicle(pid)
                if plyveh ~= nil then
                    network.request_control_of_entity(plyveh)
                    vehicle.set_vehicle_rocket_boost_active(plyveh, true)
                    vehicle.set_vehicle_forward_speed(plyveh, 200000.00)

                end

                network.request_control_of_entity(plyveh)
                vehicle.set_vehicle_rocket_boost_active(plyveh, true)
                vehicle.set_vehicle_forward_speed(plyveh, 200000.00)
            end),
            type = "action"
        }

        features["set_Boost2"] = {
            feat = menu.add_feature("Set Boost & Forward Speed v2", "action", featureVars.v.id, function(feat)
                plyveh = player.get_player_vehicle(pid)
                if plyveh ~= nil then
                    network.request_control_of_entity(plyveh)

                    vehicle.set_vehicle_forward_speed(plyveh, 200000.00)

                end

                network.request_control_of_entity(plyveh)

                vehicle.set_vehicle_forward_speed(plyveh, 200000.00)
            end),
            type = "action"
        }

        features["set_speed"] = {
            feat = menu.add_feature("Force Forward Speed: 90000", "action", featureVars.v.id, function(feat)
                plyveh = player.get_player_vehicle(pid)
                if plyveh ~= nil then
                    network.request_control_of_entity(plyveh)
                    system.wait(10)
                    vehicle.set_vehicle_undriveable(player.get_player_vehicle(pid), true)
                    vehicle.set_vehicle_forward_speed(plyveh, 90000.00)
                    vehicle.set_vehicle_undriveable(player.get_player_vehicle(pid), false)
                    --
                    vehicle.set_vehicle_forward_speed(plyveh, 9000.00)

                end
                vehicle.set_vehicle_forward_speed(plyveh, 9000.00)
            end),
            type = "action"
        }

        features["vehicleexplode1"] = {
            feat = menu.add_feature("Vehicle Explode OnImpact", "toggle", featureVars.v.id, function(feat)
                if feat.on then

                    pped = PlyPed(pid)

                    plyveh = player.get_player_vehicle(pid)
                    if plyveh ~= nil then
                        network.request_control_of_entity(plyveh)
                        vehicle.set_vehicle_out_of_control(plyveh, false, true)
                    end
                    network.request_control_of_entity(plyveh)
                    vehicle.set_vehicle_rocket_boost_percentage(plyveh, 100)
                    vehicle.set_vehicle_rocket_boost_active(plyveh, true)
                    vehicle.set_vehicle_out_of_control(plyveh, false, true)
                    vehicle.set_vehicle_forward_speed(plyveh, 200000.00)
                end
                return HANDLER_CONTINUE
            end),
            type = "toggle",
            callback = function()
            end
        }

        features["vehicleexplode2"] = {
            feat = menu.add_feature("Vehicle Explode OnImpact v2", "toggle", featureVars.v.id, function(feat)
                if feat.on then

                    pped = PlyPed(pid)

                    plyveh = player.get_player_vehicle(pid)
                    if plyveh ~= nil then
                        network.request_control_of_entity(plyveh)
                        vehicle.set_vehicle_out_of_control(plyveh, false, true)
                    end
                    network.request_control_of_entity(plyveh)
                    vehicle.set_vehicle_out_of_control(plyveh, false, true)
                    vehicle.set_vehicle_forward_speed(plyveh, 200000.00)
                end
                return HANDLER_CONTINUE
            end),
            type = "toggle",
            callback = function()
            end
        }

        features["vehspdslow"] = {
            feat = menu.add_feature("Set Max Speed 5", "action", featureVars.v.id, function(feat)
                vehicle.set_vehicle_undriveable(player.get_player_vehicle(pid), true)
                playervehspd(pid, 5.0)
                vehicle.set_vehicle_undriveable(player.get_player_vehicle(pid), false)
            end),
            type = "action"
        }

        features["vehspdcust"] = {
            feat = menu.add_feature("Input Custom Max Speed", "action", featureVars.v.id, function(feat)
                local r, s = input.get("Enter a Speed value:", "0.0001", 64, 5)
                if r == 1 then
                    return HANDLER_CONTINUE
                end
                if r == 2 then
                    return HANDLER_POP
                end
                vehicle.set_vehicle_undriveable(player.get_player_vehicle(pid), true)
                playervehspd(pid, s)
                vehicle.set_vehicle_undriveable(player.get_player_vehicle(pid), false)
            end),
            type = "action"
        }

        features["vehspdfast"] = {
            feat = menu.add_feature("Reset Max Speed", "action", featureVars.v.id, function(feat)
                vehicle.set_vehicle_undriveable(player.get_player_vehicle(pid), true)
                playervehspd(pid, 9000000.0)
                vehicle.set_vehicle_undriveable(player.get_player_vehicle(pid), false)
            end),
            type = "action"
        }

        features["vehaddexpl"] = {
            feat = menu.add_feature("Add Explosive Device", "action", featureVars.v.id, function(feat)

                plyveh = player.get_player_vehicle(pid)
                if plyveh == 0 or nil then
                    return
                end
                while not network.has_control_of_entity(plyveh) do
                    network.request_control_of_entity(plyveh)
                    return HANDLER_CONTINUE
                end
                vehicle.add_vehicle_phone_explosive_device(plyveh)

            end),
            type = "action"
        }

        features["vehdetonate"] = {
            feat = menu.add_feature("Detonate Explosive Device (named)", "action", featureVars.v.id, function(feat)

                plyveh = player.get_player_vehicle(pid)
                network.request_control_of_entity(plyveh)
                print(vehicle.has_vehicle_phone_explosive_device())
                if vehicle.has_vehicle_phone_explosive_device() then
                    vehicle.detonate_vehicle_phone_explosive_device()

                end
            end),
            type = "action"
        }

        features["timedexp"] = {
            feat = menu.add_feature("Set Vehicle Timed Explosion", "action", featureVars.v.id, function(feat)

                pos = v3()
                pos = player.get_player_coords(pid)
                pped = PlyPed(pid)
                plyveh = player.get_player_vehicle(pid)
                audio.play_sound_from_coord(-1, "Explosion_Countdown", pos, "GTAO_FM_Events_Soundset", true, 10000, false)
                audio.play_sound_from_entity(-1, "Explosion_Countdown", pped, "GTAO_FM_Events_Soundset")
                while not network.has_control_of_entity(plyveh) do
                    network.request_control_of_entity(plyveh)
                    return HANDLER_CONTINUE
                end

                vehicle.set_vehicle_timed_explosion(plyveh, pped, true)
            end),
            type = "action"
        }

        features["boostlag"] = {
            feat = menu.add_feature("Lag Vehicle Boost Refill", "action", featureVars.v.id, function(feat)

                plyveh = player.get_player_vehicle(pid)
                network.request_control_of_entity(plyveh)
                vehicle.set_vehicle_rocket_boost_active(plyveh, true)
                vehicle.set_vehicle_rocket_boost_refill_time(plyveh, 999999.999999999999)
            end),
            type = "action"
        }
        features["boostrefill"] = {
            feat = menu.add_feature("Fast Vehicle Boost Refill", "action", featureVars.v.id, function(feat)

                plyveh = player.get_player_vehicle(pid)
                network.request_control_of_entity(plyveh)
                vehicle.set_vehicle_rocket_boost_refill_time(plyveh, 0.0000010)
            end),
            type = "action"
        }

        features["nomissmk2"] = {
            feat = menu.add_feature("Set MK2 Machineguns Only", "action", featureVars.v.id, function(feat)

                pped = PlyPed(pid)

                plyveh = player.get_player_vehicle(pid)
                if plyveh ~= nil then
                    network.request_control_of_entity(plyveh)
                end
                network.request_control_of_entity(plyveh)
                vehicle.set_vehicle_mod_kit_type(plyveh, 0)
                vehicle.get_vehicle_mod(plyveh, 10)
                vehicle.set_vehicle_mod(plyveh, 10, -1, false)
            end),
            type = "action"
        }
        features["rapidmk2"] = {
            feat = menu.add_feature("MK2 Rapid fire", "toggle", featureVars.v.id, function(feat)
                if feat.on then

                    pped = PlyPed(pid)

                    plyveh = player.get_player_vehicle(pid)
                    if plyveh ~= nil then
                        network.request_control_of_entity(plyveh)
                    end
                    vehicle.set_vehicle_fixed(plyveh)
                    vehicle.set_vehicle_deformation_fixed(plyveh)
                end
                return HANDLER_CONTINUE
            end),
            type = "toggle",
            callback = function()
            end
        }

        -- TODO: Highight Controls

        features["RGB1"] = {
            feat = menu.add_feature("fading red white Marker3 on/off", "action", featureVars.chc.id, function(feat)

                changRGB.on = not changRGB.on

            end),
            type = "action"
        }
        features["RGB1"].feat.on = false

        features["RGB2"] = {
            feat = menu.add_feature("flash red white Marker3 on/off", "action", featureVars.chc.id, function(feat)

                chang_RGBA.on = not chang_RGBA.on

            end),
            type = "action"
        }
        features["RGB2"].feat.on = false

        features["RGB3"] = {
            feat = menu.add_feature("multi fading colors Marker 1 2 5 on/off", "action", featureVars.chc.id, function(feat)

                changRGBA.on = not changRGBA.on

            end),
            type = "action"
        }
        features["RGB3"].feat.on = false

        features["RGB4"] = {
            feat = menu.add_feature("Marker 1 2 5 RGB on/off", "action", featureVars.chc.id, function(feat)

                changeRGB.on = not changeRGB.on

            end),
            type = "action"
        }
        features["RGB4"].feat.on = false

        features["RGB5"] = {
            feat = menu.add_feature("Marker 1 2 5 RGB2 on/off", "action", featureVars.chc.id, function(feat)

                change_RGBA.on = not change_RGBA.on

            end),
            type = "action"
        }
        features["RGB5"].feat.on = false

        features["RGB6"] = {
            feat = menu.add_feature("Marker3 RGBA on/off", "action", featureVars.chc.id, function(feat)

                changeRGBA.on = not changeRGBA.on
            end),
            type = "action"
        }
        features["RGB6"].feat.on = false

        features["RGB7"] = {
            feat = menu.add_feature("rand rgb Marker3 on/off", "action", featureVars.chc.id, function(feat)

                rgb_rand.on = not rgb_rand.on

            end),
            type = "action"
        }
        features["RGB7"].feat.on = false

        features["RGB8"] = {
            feat = menu.add_feature("rand rgb Marker4 on/off", "action", featureVars.chc.id, function(feat)

                rgb_rand1.on = not rgb_rand1.on

            end),
            type = "action"
        }
        features["RGB8"].feat.on = false

        features["RGB9"] = {
            feat = menu.add_feature("RGB Marker4 on/off", "action", featureVars.chc.id, function(feat)

                marker1_rgbd.on = not marker1_rgbd.on
            end),
            type = "action"
        }
        features["RGB9"].feat.on = false

        -- TODO: active marker
        features["Mark_Control"] = {
            feat = menu.add_feature("Marker ID  to Control", "value_i", featureVars.ch.id, function(feat)
                if feat.on then

                    actM = feat.value + pid + 1
                    return HANDLER_CONTINUE
                end
            end),
            type = "toggle"
        }
        features["Mark_Control"].feat.on = false
        features["Mark_Control"].feat.max = 5
        features["Mark_Control"].feat.min = 1

        features["RGB_OFF"] = {
            feat = menu.add_feature("Turn off all RGB Changers", "action", featureVars.h.id, function(feat)
                changeRGBA.on = false
                change_RGBA.on = false
                changeRGB.on = false
                changRGBA.on = false
                chang_RGBA.on = false
                changRGB.on = false

            end),
            type = "action"
        }

        features["cprecision"] = {
            feat = menu.add_feature("Precision Multipliers", "toggle", featureVars.ch.id, function(feat)
            end),
            type = "toggle"
        }

        features["MarkSize"] = {
            feat = menu.add_feature("Marker Size Muliplier", "action_value_i", featureVars.ch.id, function(feat)
                if features["cprecision"].feat.on then

                    size_marker = tonumber(feat.value / 100)
                    markID.s[actM] = size_marker
                else
                    size_marker = tonumber(feat.value / 2)
                    markID.s[actM] = size_marker
                end
            end),
            type = "action_value_i"
        }
        features["MarkSize"].feat.max = 30000
        features["MarkSize"].feat.min = 1
        features["MarkSize"].feat.value = 2

        features["MarkZoff"] = {
            feat = menu.add_feature("Marker Z Offset Multiplier", "action_value_i", featureVars.ch.id, function(feat)
                if features["cprecision"].feat.on then
                    offsetz_marker = tonumber(feat.value / 100)
                    markID.z[actM] = offsetz_marker
                else
                    offsetz_marker = tonumber(feat.value / 2)
                    markID.z[actM] = offsetz_marker
                end
            end),
            type = "action_value_i"
        }
        features["MarkZoff"].feat.max = 30000
        features["MarkZoff"].feat.min = -30000
        features["MarkZoff"].feat.value = 1

        features["BOB_Marker"] = {
            feat = menu.add_feature("Bob Marker Up & Down", "toggle", featureVars.ch.id, function(feat)
                BobUPnDown = true
                local i = actM
                markID.BOB[i] = BobUPnDown
                if feat.on then
                    return HANDLER_CONTINUE
                end
                BobUPnDown = false
                markID.BOB[i] = BobUPnDown
                return HANDLER_POP
            end),
            type = "toggle"
        }

        features["ROT_Marker"] = {
            feat = menu.add_feature("Rotate Marker", "toggle", featureVars.ch.id, function(feat)

                ROTMRK = true
                local i = actM
                markID.ROT[i] = ROTMRK
                if feat.on then
                    return HANDLER_CONTINUE
                end
                ROTMRK = false
                markID.ROT[i] = ROTMRK
                return HANDLER_POP
            end)
        }

        featureVars.blip = menu.add_feature("Radar Blips", "parent", featureVars.h.id)

        features["Blipcol"] = {
            feat = menu.add_feature("Update Current Blip Colour", "autoaction_value_i", featureVars.blip.id, function(feat)
                local pped = PlyPed(pid)
                local oldblip = ui.get_blip_from_entity(pped)
                ui.set_blip_colour(oldblip, feat.value)

            end),
            type = "autoaction_value_i"
        }
        features["Blipcol"].feat.max = 85
        features["Blipcol"].feat.min = 1
        features["Blipcol"].feat.value = 1

        features["Blip2col"] = {
            feat = menu.add_feature("Add Coloured Blip", "action_value_i", featureVars.blip.id, function(feat)
                local pped = PlyPed(pid)
                local oldblip = ui.get_blip_from_entity(pped)
                ui.set_blip_colour(oldblip, 85)
                BlipIDs[#BlipIDs + 1] = ui.add_blip_for_entity(pped)
                ui.set_blip_colour(BlipIDs[#BlipIDs], feat.value)

            end),
            type = "action_value_i"
        }
        features["Blip2col"].feat.max = 85
        features["Blip2col"].feat.min = 1
        features["Blip2col"].feat.value = 1

        features["Blip"] = {
            feat = menu.add_feature("Add Radar Blip", "action", featureVars.blip.id, function(feat)

                pped = PlyPed(pid)
                BlipIDs[#BlipIDs + 1] = ui.add_blip_for_entity(pped)

            end),
            type = "action"
        }

        local blip

        features["Blipv2"] = {
            feat = menu.add_feature("Radial Radar Blip", "action_value_i", featureVars.blip.id, function(feat)
                if blip ~= nil then
                    ui.remove_blip(blip)
                    blip = nil
                end
                local bliprad = tonumber(feat.value) + 0.001
                blip = ui.add_blip_for_radius(player.get_player_coords(pid), bliprad)
                BlipIDs[#BlipIDs + 1] = blip
                ui.set_blip_colour(blip, 79)
                playerFeatures[pid].features["RadBlipUpdate"].feat.on = true
                return HANDLER_POP
            end),
            type = "action"
        }
        features["Blipv2"].feat.max = 1000
        features["Blipv2"].feat.min = 1
        features["Blipv2"].feat.value = 25

        features["Blip_v2"] = {
            feat = menu.add_feature("Radial Radar Blip v2", "action_value_i", featureVars.blip.id, function(feat)

                local bliprad = tonumber(feat.value) + 0.001
                blip = ui.add_blip_for_radius(player.get_player_coords(pid), bliprad)
                BlipIDs[#BlipIDs + 1] = blip
                ui.set_blip_colour(BlipIDs[#BlipIDs], 79)
                playerFeatures[pid].features["RadBlipUpdate"].feat.on = true
                return HANDLER_POP
            end),
            type = "action"
        }
        features["Blip_v2"].feat.max = 1000
        features["Blip_v2"].feat.min = 1
        features["Blip_v2"].feat.value = 25

        features["Blip_v3"] = {
            feat = menu.add_feature("Radial Blip v3 Vehicle", "action_value_i", featureVars.blip.id, function(feat)

                local bliprad = tonumber(feat.value) + 0.001
                plyveh = player.get_player_vehicle(pid)
                blip = ui.add_blip_for_radius(entity.get_entity_coords(plyveh), bliprad)
                BlipIDs[#BlipIDs + 1] = blip
                ui.set_blip_colour(BlipIDs[#BlipIDs], 79)

                return HANDLER_POP
            end),
            type = "action"
        }
        features["Blip_v3"].feat.max = 10000
        features["Blip_v3"].feat.min = 1
        features["Blip_v3"].feat.value = 3500
        features["Blip_v3"].feat.mod = 50

        features["Blipv2col"] = {
            feat = menu.add_feature("Update Radial Blip Colour", "action_value_i", featureVars.blip.id, function(feat)
                if blip ~= nil then
                    for i = 1, #BlipIDs do
                        ui.set_blip_colour(BlipIDs[i], feat.value)
                    end
                end

            end),
            type = "action_value_i"
        }
        features["Blipv2col"].feat.max = 120
        features["Blipv2col"].feat.min = 1
        features["Blipv2col"].feat.value = 1

        features["Blipv2col"] = {
            feat = menu.add_feature("Update Radial Blip Colour v2", "autoaction_value_i", featureVars.blip.id, function(feat)
                if blip ~= nil then
                    ui.set_blip_colour(blip, feat.value)
                end
            end),
            type = "autoaction_value_i"
        }
        features["Blipv2col"].feat.max = 85
        features["Blipv2col"].feat.min = 1
        features["Blipv2col"].feat.value = 1

        features["RadBlipUpdate"] = {
            feat = menu.add_feature("Update Blip v2 Pos", "toggle", featureVars.blip.id, function(feat)
                if feat.on then
                    if blip ~= nil then
                        ui.set_blip_coord(blip, entity.get_entity_coords(player.get_player_vehicle(pid)))
                    end
                    return HANDLER_CONTINUE
                end
                if blip ~= nil then
                    ui.remove_blip(blip)
                    blip = nil
                end
                return HANDLER_POP
            end),
            type = "toggle"
        }
        features["RadBlipUpdate"].feat.on = false

        features["RadBlipvehUpdate"] = {
            feat = menu.add_feature("Update Blip v2 Pos", "toggle", featureVars.blip.id, function(feat)
                if feat.on then
                    if blip ~= nil then
                        ui.set_blip_coord(blip, player.get_player_coords(pid))
                    end
                    return HANDLER_CONTINUE
                end
                if blip ~= nil then
                    ui.remove_blip(blip)
                    blip = nil
                end
                return HANDLER_POP
            end),
            type = "toggle"
        }
        features["RadBlipvehUpdate"].feat.on = false

        features["marker_active1"] = {
            feat = menu.add_feature("Marker 1 Type:", "value_i", featureVars.h.id, function(feat)

                if feat.on then

                    local offset, pos = v3(), v3()
                    offset.z = markID.z[pid + 2]
                    local size = markID.s[pid + 2]
                    local posbool, pped
                    pped = PlyPed(pid)
                    posbool, pos = ped.get_ped_bone_coords(pped, 31086, offset)

                    graphics.draw_marker(feat.value, pos + offset, v3(), v3(), v3(size), changeR, changeG, changeB, changeA, BobUPnDown, true, 2, ROTMRK, nil, nil, false)

                    return HANDLER_CONTINUE
                end
            end),
            type = "value_i"
        }
        features["marker_active1"].feat.max = 44
        features["marker_active1"].feat.min = 0
        features["marker_active1"].feat.value = 1
        features["marker_active1"].feat.on = false

        features["marker_active2"] = {
            feat = menu.add_feature("Marker 2 Type:", "value_i", featureVars.h.id, function(feat)

                if feat.on then

                    local offset = v3()
                    offset.z = markID.z[pid + 3]
                    local size = markID.s[pid + 3]
                    local pos = v3()
                    local posbool, pped
                    pped = PlyPed(pid)
                    posbool, pos = ped.get_ped_bone_coords(pped, 31086, offset)

                    graphics.draw_marker(feat.value, pos + offset, v3(), v3(), v3(size), changeR, changeG, changeB, changeA, BobUPnDown, true, 2, ROTMRK, nil, nil, false)

                    return HANDLER_CONTINUE
                end
            end),
            type = "value_i"
        }
        features["marker_active2"].feat.max = 44
        features["marker_active2"].feat.min = 0
        features["marker_active2"].feat.value = 43
        features["marker_active2"].feat.on = false

        features["marker_active3"] = {
            feat = menu.add_feature("Marker 3 Type:", "value_i", featureVars.h.id, function(feat)

                if feat.on then

                    local offset = v3()
                    offset.z = markID.z[pid + 4]
                    local size = markID.s[pid + 4]
                    local pos = v3()
                    local posbool, pped
                    pped = PlyPed(pid)
                    posbool, pos = ped.get_ped_bone_coords(pped, 31086, offset)

                    graphics.draw_marker(feat.value, pos + offset, v3(), v3(), v3(size), RGBA_R, RGBA_G, RGBA_B, RGBA_A, BobUPnDown, true, 2, ROTMRK, nil, nil, false)

                    return HANDLER_CONTINUE
                end
            end),
            type = "value_i"
        }
        features["marker_active3"].feat.max = 44
        features["marker_active3"].feat.min = 0
        features["marker_active3"].feat.value = 0
        features["marker_active3"].feat.on = false

        features["marker_active4"] = {
            feat = menu.add_feature("Marker 4 Type:", "value_i", featureVars.h.id, function(feat)

                if feat.on then

                    local offset = v3()
                    offset.z = markID.z[pid + 5]
                    local size = markID.s[pid + 5]
                    local pos = v3()
                    local posbool, pped
                    pped = PlyPed(pid)
                    posbool, pos = ped.get_ped_bone_coords(pped, 31086, offset)

                    graphics.draw_marker(feat.value, pos + offset, v3(), v3(), v3(size), RGB_A_R, RGB_A_G, RGB_A_B, RGB_A_A, BobUPnDown, true, 2, ROTMRK, nil, nil, false)

                    return HANDLER_CONTINUE
                end
            end),
            type = "value_i"
        }
        features["marker_active4"].feat.max = 44
        features["marker_active4"].feat.min = 0
        features["marker_active4"].feat.value = 29
        features["marker_active4"].feat.on = false

        features["marker_active5"] = {
            feat = menu.add_feature("Marker 5 (Drawn on Entity) Type:", "value_i", featureVars.h.id, function(feat)

                if feat.on then

                    local offset = v3()
                    offset.z = markID.z[pid + 6]
                    local size = markID.s[pid + 6]
                    local pos = v3()
                    local posbool, pped
                    pped = PlyPed(pid)
                    posbool, pos = ped.get_ped_bone_coords(pped, 31086, offset)

                    graphics.draw_marker(feat.value, pos + offset, v3(), v3(), v3(size), changeR, changeG, changeB, changeA, BobUPnDown, true, 2, ROTMRK, nil, nil, true)

                    return HANDLER_CONTINUE
                end
            end),
            type = "value_i"
        }
        features["marker_active5"].feat.max = 44
        features["marker_active5"].feat.min = 0
        features["marker_active5"].feat.value = 28
        features["marker_active5"].feat.on = false

        -- TODO: CEO Money
        featureVars.ceo = menu.add_feature("CEO Money Shit", "parent", featureVars.f.id)

        features["ceo_money_a1"] = {
            feat = menu.add_feature("CEO 10k v1", "action", featureVars.ceo.id, function(feat)

                script.trigger_script_event(-2029779863, pid, {player.player_id(), 10000, -1292453789, 0, script.get_global_i(1630317 + (1 + (pid * 595)) + 506), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})
                script.trigger_script_event(-2029779863, pid, {player.player_id(), 10000, -1292453789, 1, script.get_global_i(1630317 + (1 + (pid * 595)) + 506), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})

                return HANDLER_POP
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["ceo_money_a1"].feat.on = false

        features["ceo_money_a01"] = {
            feat = menu.add_feature("CEO 10k v2", "action", featureVars.ceo.id, function(feat)

                script.trigger_script_event(-2029779863, pid, {player.player_id(), 10000, 198210293, 0, script.get_global_i(1630317 + (1 + (pid * 595)) + 506), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})
                script.trigger_script_event(-2029779863, pid, {player.player_id(), 10000, 198210293, 1, script.get_global_i(1630317 + (1 + (pid * 595)) + 506), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})

                return HANDLER_POP
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["ceo_money_a01"].feat.on = false

        features["ceo_money_a2"] = {
            feat = menu.add_feature("CEO 30k 1 shot", "action", featureVars.ceo.id, function(feat)

                script.trigger_script_event(-2029779863, pid, {player.player_id(), 10000, -1292453789, 0, script.get_global_i(1630317 + (1 + (pid * 595)) + 506), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})
                script.trigger_script_event(-2029779863, pid, {player.player_id(), 20000, 198210293, 1, script.get_global_i(1630317 + (1 + (pid * 595)) + 506), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})
                return HANDLER_POP
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["ceo_money_a2"].feat.on = false

        features["ceo_money_a02"] = {
            feat = menu.add_feature("CEO 30k v1", "value_i", featureVars.ceo.id, function(feat)
                if feat.on then
                    script.trigger_script_event(-2029779863, pid, {player.player_id(), 10000, -1292453789, 0, script.get_global_i(1630317 + (1 + (pid * 595)) + 506), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})
                    script.trigger_script_event(-2029779863, pid, {player.player_id(), 20000, 198210293, 1, script.get_global_i(1630317 + (1 + (pid * 595)) + 506), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})
                    system.wait(feat.value)
                    return HANDLER_CONTINUE
                end
                return HANDLER_POP
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["ceo_money_a02"].feat.on = false
        features["ceo_money_a02"].feat.max = 200000
        features["ceo_money_a02"].feat.min = 30000
        features["ceo_money_a02"].feat.value = 30000
        features["ceo_money_a02"].feat.mod = 1000
        features["ceo_money1"] = {
            feat = menu.add_feature("CEO 10k money loop", "toggle", featureVars.ceo.id, function(feat)
                while feat.on do
                    print("Money Trigger loop")
                    print(os.date())

                    script.trigger_script_event(-2029779863, pid, {player.player_id(), 10000, -1292453789, 0, script.get_global_i(1630317 + (1 + (pid * 595)) + 506), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})
                    system.wait(31000)
                    print(os.date())
                    return HANDLER_CONTINUE
                end
                print("loop end")

                return HANDLER_POP
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["ceo_money1"].feat.on = false

        features["ceo_money1"] = {
            feat = menu.add_feature("CEO 10k money loop", "toggle", featureVars.ceo.id, function(feat)
                while feat.on do
                    print("Money Trigger loop")
                    print(os.date())

                    script.trigger_script_event(-2029779863, pid, {player.player_id(), 10000, -1292453789, 0, script.get_global_i(1630317 + (1 + (pid * 595)) + 506), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})
                    system.wait(31000)
                    print(os.date())
                    return HANDLER_CONTINUE
                end
                print("loop end")

                return HANDLER_POP
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["ceo_money1"].feat.on = false

        features["ceo_money2"] = {
            feat = menu.add_feature("CEO 20k money loop", "toggle", featureVars.ceo.id, function(feat)
                while feat.on do
                    print("20k Money Trigger loop")
                    print(os.date())

                    script.trigger_script_event(-2029779863, pid, {player.player_id(), 10000, -1292453789, 1, script.get_global_i(1630317 + (1 + (pid * 595)) + 506), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})
                    system.wait(1200)

                    script.trigger_script_event(-2029779863, pid, {player.player_id(), 10000, -1292453789, 0, script.get_global_i(1630317 + (1 + (pid * 595)) + 506), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})

                    system.wait(31000)
                    script.trigger_script_event(-2029779863, pid, {player.player_id(), 10000, 198210293, 1, script.get_global_i(1630317 + (1 + (pid * 595)) + 506), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})
                    system.wait(1200)

                    script.trigger_script_event(-2029779863, pid, {player.player_id(), 10000, 198210293, 0, script.get_global_i(1630317 + (1 + (pid * 595)) + 506), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})

                    system.wait(31000)

                    print(os.date())
                    return HANDLER_CONTINUE
                end
                print("loop end")

                return HANDLER_POP

            end),
            type = "toggle",
            callback = function()
            end
        }
        features["ceo_money2"].feat.on = false

        features["ceo_money3"] = {
            feat = menu.add_feature("Quick CEO Money", "toggle", featureVars.ceo.id, function(feat)
                while feat.on do
                    print("Money Trigger loop")
                    print(os.date())
                    print("ceo 10k sell")
                    -- transaction id:1
                    script.trigger_script_event(-2029779863, pid, {player.player_id(), 10000, -1292453789, 1, script.get_global_i(1630317 + (1 + (pid * 595)) + 506), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})
                    system.wait(1200)
                    print("10k sell Complete")
                    print(os.date())

                    print("Money Trigger 10k Wage")
                    print(os.date())
                    -- transaction id:2
                    script.trigger_script_event(-2029779863, pid, {player.player_id(), 10000, -1292453789, 0, script.get_global_i(1630317 + (1 + (pid * 595)) + 506), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})
                    system.wait(1200)
                    system.wait(31000)
                    print("10k Wage Complete")
                    print(os.date())
                    system.wait(1200)
                    print("Money Trigger 20k sell")
                    print(os.date())
                    -- transaction id:3
                    script.trigger_script_event(-2029779863, pid, {player.player_id(), 20000, 198210293, 1, script.get_global_i(1630317 + (1 + (pid * 595)) + 506), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})
                    system.wait(1200)

                    system.wait(31000)
                    print("20k Sell Complete")
                    print(os.date())

                    print("Money Trigger 10k Wage")
                    print(os.date())

                    script.trigger_script_event(-2029779863, pid, {player.player_id(), 10000, -1292453789, 0, script.get_global_i(1630317 + (1 + (pid * 595)) + 506), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})
                    system.wait(1200)
                    system.wait(31000)
                    system.wait(1200)

                    print("20k sell Complete")
                    print(os.date())

                    return HANDLER_CONTINUE
                end
                print("loop end")

                return HANDLER_POP

            end),
            type = "toggle",
            callback = function()
            end
        }
        features["ceo_money3"].feat.on = false

        features["ceo_money4"] = {
            feat = menu.add_feature("Fast 10k CEO Money", "toggle", featureVars.ceo.id, function(feat)
                while feat.on do
                    print("Money Trigger loop")
                    print(os.date())
                    print("ceo 10k sell")
                    -- transaction id:1

                    script.trigger_script_event(-2029779863, pid, {player.player_id(), 10000, -1292453789, 1, script.get_global_i(1630317 + (1 + (pid * 595)) + 506), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})
                    system.wait(1200)
                    print("10k sell Complete")
                    print(os.date())

                    print("Money Trigger 10k Wage")
                    print(os.date())
                    -- transaction id:2

                    script.trigger_script_event(-2029779863, pid, {player.player_id(), 10000, -1292453789, 0, script.get_global_i(1630317 + (1 + (pid * 595)) + 506), script.get_global_i(1652336 + 9), script.get_global_i(1652336 + 10)})
                    system.wait(1200)
                    system.wait(31000)

                    return HANDLER_CONTINUE
                end
                print("loop end")

                return HANDLER_POP

            end),
            type = "toggle",
            callback = function()
            end
        }
        features["ceo_money4"].feat.on = false

        features["ceo_otr"] = {
            feat = menu.add_feature("OTR", "action", featureVars.f.id, function(feat)

                -- globals.send_script_event("Give OTR or ghost organization", pid, {pid, utils.time() - 60, utils.time(), 1, 1, globals.generic_player_global(pid)}, true)
                -- script.get_global_i(2424073 + (1 + (spid * 421)) + 200) == 1
                -- script.get_global_i(2426097 + (1 + (pid * 443)) + 204) == 1
                -- script.get_global_i(1630317 + (1 + (pid * 595) + 506))
                script.trigger_script_event(575518757, pid, {pid, utils.time() - 60, utils.time(), 1, 1, script.get_global_i(1630317 + (1 + (pid * 595) + 506))})

                return HANDLER_POP
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["ceo_otr"].feat.on = false

        features["give_nocops"] = {
            feat = menu.add_feature("Give Long Cop Bribe", "action", featureVars.f.id, function(feat)

                script.trigger_script_event(392501634, pid, {pid, utils.time() - 60, utils.time(), script.get_global_i(2540384 + 4624), 1, script.get_global_i(1630317 + (1 + (pid * 595)) + 506)})
                return HANDLER_POP
            end),
            type = "action",
            callback = function()
            end
        }

        -- TODO: teleport

        features["TeleportPlayernext2me"] = {
            feat = menu.add_feature("Teleport Next 2 Me(old Version)", "toggle", featureVars.t.id, function(feat)
                if feat.on then
                    local plyveh

                    pped = PlyPed(pid)

                    local pos = v3()
                    pos = player.get_player_coords(player.player_id())
                    pos.x = pos.x + 3
                    if player.get_player_vehicle(pid) ~= 0 or player.get_player_vehicle(pid) ~= nil then
                        plyveh = player.get_player_vehicle(pid)
                        network.request_control_of_entity(plyveh)
                        entity.set_entity_coords_no_offset(plyveh, pos)
                        -- vehicle.set_vehicle_on_ground_properly(plyveh)
                    end

                    return HANDLER_CONTINUE
                end
                return HANDLER_POP

            end),
            type = "toggle",
            callback = function()
            end
        }
        features["TeleportPlayernext2me"].feat.on = false

        features["TeleportPlayerinfront"] = {
            feat = menu.add_feature("Teleport in front of Me", "toggle", featureVars.t.id, function(feat)
                if feat.on then
                    local plyveh, pped, pos
                    pped = PlyPed(pid)
                    get_offset2me(player.player_id(), 3)
                    pos = SelfoffsetPos

                    if player.get_player_vehicle(pid) ~= 0 or player.get_player_vehicle(pid) ~= nil then
                        plyveh = player.get_player_vehicle(pid)
                        network.request_control_of_entity(plyveh)
                        entity.set_entity_coords_no_offset(plyveh, pos)
                        vehicle.set_vehicle_on_ground_properly(plyveh)
                    end

                    return HANDLER_CONTINUE
                end
                return HANDLER_POP

            end),
            type = "toggle",
            callback = function()
            end
        }
        features["TeleportPlayerinfront"].feat.on = false

        features["TeleportPlayerBeyondLimits"] = {
            feat = menu.add_feature("Teleport Beyond World Limits", "toggle", featureVars.t.id, function(feat)
                if feat.on then
                    local plyveh, pped
                    local pos = v3()
                    pos.x = presets[1][2]
                    pos.y = presets[1][3]
                    pos.z = presets[1][4]
                    pped = PlyPed(pid)

                    if player.get_player_vehicle(pid) ~= 0 or player.get_player_vehicle(pid) ~= nil then
                        plyveh = player.get_player_vehicle(pid)
                        network.request_control_of_entity(plyveh)
                        entity.set_entity_coords_no_offset(plyveh, pos)
                    end
                    return HANDLER_CONTINUE
                end
                return HANDLER_POP
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["TeleportPlayerBeyondLimits"].feat.on = false

        features["Teleport_God-mode_Death"] = {
            feat = menu.add_feature("Teleport to Death (Ocean Out of World Limits)", "toggle", featureVars.t.id, function(feat)
                if feat.on then
                    local plyveh, pped
                    local pos = v3()
                    pos.x = presets[3][2]
                    pos.y = presets[3][3]
                    pos.z = presets[3][4]
                    pped = PlyPed(pid)
                    if player.get_player_vehicle(pid) ~= 0 or player.get_player_vehicle(pid) ~= nil then
                        plyveh = player.get_player_vehicle(pid)
                        network.request_control_of_entity(plyveh)
                        entity.set_entity_coords_no_offset(plyveh, pos)
                    end
                end
                return HANDLER_CONTINUE

            end),
            type = "toggle",
            callback = function()
            end
        }
        features["Teleport_God-mode_Death"].feat.on = false

        features["Teleport_God-mode_Death_2"] = {
            feat = menu.add_feature("Teleport to Death (KillBarrier)", "toggle", featureVars.t.id, function(feat)
                if feat.on then
                    local plyveh, pped
                    local pos = v3()
                    pos.x = presets[2][2]
                    pos.y = presets[2][3]
                    pos.z = presets[2][4]
                    pped = PlyPed(pid)
                    if player.get_player_vehicle(pid) ~= 0 or player.get_player_vehicle(pid) ~= nil then
                        plyveh = player.get_player_vehicle(pid)
                        network.request_control_of_entity(plyveh)
                        entity.set_entity_coords_no_offset(plyveh, pos)
                    end
                end
                return HANDLER_CONTINUE

            end),
            type = "toggle",
            callback = function()
            end
        }
        features["Teleport_God-mode_Death_2"].feat.on = false

        -- TODO: Sound Troll

        features["sound_troll1"] = {
            feat = menu.add_feature("Annoy With Air Drop Sounds", "action", featureVars.str.id, function(feat)

                local pos = v3()
                pos = entity.get_entity_coords(PlyPed(pid))
                pped = PlyPed(pid)
                audio.play_sound_from_entity(-1, "Air_Drop_Package", pped, "DLC_SM_Generic_Mission_Sounds", true)
            end),
            type = "action"
        }

        features["sound_troll2"] = {
            feat = menu.add_feature("Annoy With Countdown sound", "action", featureVars.str.id, function(feat)

                local pos = v3()
                pos = entity.get_entity_coords(PlyPed(pid))
                pped = PlyPed(pid)
                audio.play_sound_from_coord(-1, "Explosion_Countdown", pos, "GTAO_FM_Events_Soundset", true, 1000, false)
                audio.play_sound_from_entity(-1, "Explosion_Countdown", pped, "GTAO_FM_Events_Soundset", true)

            end),
            type = "action"
        }

        features["sound_troll3"] = {
            feat = menu.add_feature("Annoy With Yacht Horn Sound", "action", featureVars.str.id, function(feat)

                local pos = v3()
                pos = entity.get_entity_coords(PlyPed(pid))
                pped = PlyPed(pid)
                audio.play_sound_from_entity(-1, "HORN", pped, "DLC_Apt_Yacht_Ambient_Soundset", true)
                audio.play_sound_from_coord(-1, "HORN", pos, "DLC_Apt_Yacht_Ambient_Soundset", true, 1000000, false)

            end),
            type = "action"
        }

        features["sound_troll4"] = {
            feat = menu.add_feature("Annoy With Chaff Sound", "action", featureVars.str.id, function(feat)

                local pos = v3()
                pos = entity.get_entity_coords(PlyPed(pid))
                pped = PlyPed(pid)
                audio.play_sound_from_entity(-1, "chaff_released", pped, "DLC_SM_Countermeasures_Sounds", true)
            end),
            type = "action"
        }

        features["sound_troll5"] = {
            feat = menu.add_feature("Annoy With Flare sound", "action", featureVars.str.id, function(feat)

                local pos = v3()
                pos = entity.get_entity_coords(PlyPed(pid))
                pped = PlyPed(pid)
                audio.play_sound_from_entity(-1, "flares_released", pped, "DLC_SM_Countermeasures_Sounds", true)

            end),
            type = "action"
        }

        features["sound_troll6"] = {
            feat = menu.add_feature("Annoy With Remote KeyFob Sound", "action", featureVars.str.id, function(feat)

                pped = PlyPed(pid)
                audio.play_sound_from_entity(-1, "Remote_Control_Fob", pped, "PI_Menu_Sounds", true)

            end),
            type = "action"
        }

        features["sound_troll7"] = {
            feat = menu.add_feature("Annoy With Remote Close Sound", "action", featureVars.str.id, function(feat)

                pped = PlyPed(pid)
                audio.play_sound_from_entity(-1, "Remote_Control_Close", pped, "PI_Menu_Sounds", true)

            end),
            type = "action"
        }

        features["sound_troll8"] = {
            feat = menu.add_feature("Annoy With Remote Open Sound", "action", featureVars.str.id, function(feat)

                pped = PlyPed(pid)
                audio.play_sound_from_entity(-1, "Remote_Control_Open", pped, "PI_Menu_Sounds", true)

            end),
            type = "action"
        }

        features["sound_troll9"] = {
            feat = menu.add_feature("Annoy With Light Toggle Sound", "action", featureVars.str.id, function(feat)

                pped = PlyPed(pid)
                audio.play_sound_from_entity(-1, "Toggle_Lights", pped, "PI_Menu_Sounds", true)

            end),
            type = "action"
        }

        features["sound_troll10"] = {
            feat = menu.add_feature("Annoy With Water Sounds", "action", featureVars.str.id, function(feat)

                pped = PlyPed(pid)

                audio.play_sound_from_entity(-1, "FallingInWaterSmall", pped, "GTAO_Hot_Tub_PED_INSIDE_WATER", true)
                system.wait(120)
                audio.play_sound_from_entity(-1, "FallingInWaterMedium", pped, "GTAO_Hot_Tub_PED_INSIDE_WATER", true)
                system.wait(120)
                audio.play_sound_from_entity(-1, "FallingInWaterHeavy", pped, "GTAO_Hot_Tub_PED_INSIDE_WATER", true)
                system.wait(120)
                audio.play_sound_from_entity(-1, "DiveInWater", pped, "GTAO_Hot_Tub_PED_INSIDE_WATER", true)
                system.wait(120)

            end),
            type = "action"
        }

        features["arrowindicator"] = {
            feat = menu.add_feature("Bouncing Arrow above Player", "action", featureVars.tr.id, function(feat)

                if playerFeatures[pid].features["arrow_indicator2"].feat.on then
                    playerFeatures[pid].features["arrow_indicator2"].feat.on = false
                    system.wait(1000)
                end
                local hash = gameplay.get_hash_key("prop_mk_arrow_flat")
                AttachedCunt[pid + 1], AttachedCunt2[pid + 1] = spawn_object_onp(hash, pid)
                spawned_cunts[#spawned_cunts + 1] = AttachedCunt[pid + 1]
                spawned_cunts[#spawned_cunts + 1] = AttachedCunt2[pid + 1]
                system.wait(100)
                playerFeatures[pid].features["arrow_indicator"].feat.hidden = false
                playerFeatures[pid].features["arrow_indicator"].feat.on = true
                return HANDLER_POP
            end),
            type = "action",
            callback = function()
            end
        }
        features["arrowindicator"].feat.hidden = false

        features["arrow_indicator"] = {
            feat = menu.add_feature("Arrow move & Bounce with Player", "toggle", featureVars.tr.id, function(feat)

                playerFeatures[pid].features["arrowindicator"].feat.hidden = true
                if feat.on then
                    local pos, offset
                    pos = v3()
                    pos = player.get_player_coords(pid)
                    offset = v3(0.0, 0.0, 2.0)
                    local z = 0
                    local ent = AttachedCunt[pid + 1]

                    repeat
                        z = z + 1
                        pos = player.get_player_coords(pid)
                        network.request_control_of_entity(ent)
                        entity.set_entity_coords_no_offset(AttachedCunt[pid + 1], pos + offset)
                        system.wait(1)
                        network.request_control_of_entity(ent)
                    until z == 10
                    z = 0

                    offset.z = 3.0
                    repeat
                        z = z + 1
                        network.request_control_of_entity(ent)
                        pos = player.get_player_coords(pid)
                        entity.set_entity_coords_no_offset(AttachedCunt[pid + 1], pos + offset)
                        system.wait(1)
                        network.request_control_of_entity(ent)
                    until z == 10
                    z = 0
                    offset.z = 4.0
                    repeat
                        z = z + 1
                        network.request_control_of_entity(ent)
                        pos = player.get_player_coords(pid)
                        entity.set_entity_coords_no_offset(AttachedCunt[pid + 1], pos + offset)
                        system.wait(1)
                        network.request_control_of_entity(ent)
                    until z == 10
                    z = 0
                    return HANDLER_CONTINUE
                end
                playerFeatures[pid].features["arrowindicator"].feat.hidden = false
                playerFeatures[pid].features["arrow_indicator"].feat.hidden = true
                network.request_control_of_entity(AttachedCunt[pid + 1])
                entity.delete_entity(AttachedCunt[pid + 1])
                network.request_control_of_entity(AttachedCunt2[pid + 1])
                entity.delete_entity(AttachedCunt2[pid + 1])
                return HANDLER_POP
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["arrow_indicator"].feat.on = false
        features["arrow_indicator"].feat.hidden = true

        features["arrowindicator2"] = {
            feat = menu.add_feature("Arrow Indicator above Player", "action", featureVars.tr.id, function(feat)

                if playerFeatures[pid].features["arrow_indicator"].feat.on then
                    playerFeatures[pid].features["arrow_indicator"].feat.on = false
                    system.wait(1000)
                end
                local hash = gameplay.get_hash_key("prop_mk_arrow_flat")
                AttachedCunt[pid + 1], AttachedCunt2[pid + 1] = spawn_object_onp(hash, pid)
                spawned_cunts[#spawned_cunts + 1] = AttachedCunt[pid + 1]
                spawned_cunts[#spawned_cunts + 1] = AttachedCunt2[pid + 1]
                system.wait(100)
                playerFeatures[pid].features["arrow_indicator2"].feat.hidden = false
                playerFeatures[pid].features["arrow_indicator2"].feat.on = true
                return HANDLER_POP
            end),
            type = "action",
            callback = function()
            end
        }
        features["arrowindicator2"].feat.hidden = false

        features["arrow_indicator2"] = {
            feat = menu.add_feature("Arrow update move with Player", "toggle", featureVars.tr.id, function(feat)
                playerFeatures[pid].features["arrowindicator2"].feat.hidden = true
                if feat.on then
                    local pos, offset
                    pos = v3()
                    pos = player.get_player_coords(pid)
                    offset = v3(0.0, 0.0, 5.0)
                    network.request_control_of_entity(AttachedCunt[pid + 1])
                    entity.set_entity_coords_no_offset(AttachedCunt[pid + 1], pos + offset)
                    return HANDLER_CONTINUE
                end
                playerFeatures[pid].features["arrowindicator2"].feat.hidden = false
                playerFeatures[pid].features["arrow_indicator2"].feat.hidden = true
                network.request_control_of_entity(AttachedCunt[pid + 1])
                entity.delete_entity(AttachedCunt[pid + 1])
                network.request_control_of_entity(AttachedCunt2[pid + 1])
                entity.delete_entity(AttachedCunt2[pid + 1])
                return HANDLER_POP
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["arrow_indicator2"].feat.on = false
        features["arrow_indicator2"].feat.hidden = true

        features["LightPOS1way"] = {
            feat = menu.add_feature("Update Lights POS(move with Player", "toggle", featureVars.tr.id, function(feat)
                if feat.on then
                    local i, y, t = #spawned_cunt, (#spawned_cunt - 1), #spawned_cunt3
                    if not entity.is_an_entity(spawned_cunt[i]) or entity.is_an_entity(spawned_cunt[y]) then
                        playerFeatures[pid].features["LightPOSway"].feat.on = false
                        return
                    end
                    local pos, offset, offset2, offset3
                    pos = v3()
                    pos = player.get_player_coords(pid)
                    offset = v3()
                    offset2 = v3()
                    offset3 = v3()
                    offset.x = 0.2
                    offset.y = 0.5
                    offset.z = 0.0

                    entity.set_entity_coords_no_offset(spawned_cunt[i], pos + offset)
                    offset2.x = 1.0
                    offset2.y = 0.3
                    offset2.z = 0.0

                    entity.set_entity_coords_no_offset(spawned_cunt[y], pos + offset2)
                    offset3.x = -1.0
                    offset3.y = -0.3
                    offset3.z = -0.0

                    entity.set_entity_coords_no_offset(spawned_cunt3[t], pos + offset3)

                    return HANDLER_CONTINUE
                end
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["LightPOS1way"].feat.on = false
        features["LightPOS1way"].feat.hidden = true

        features["LightPOSway"] = {
            feat = menu.add_feature("Update Lights POS(move with Player", "toggle", featureVars.tr.id, function(feat)
                if feat.on then
                    local pos, offset, offset2
                    pos = v3()
                    pos = player.get_player_coords(pid)
                    offset = v3()
                    offset2 = v3()
                    local heading, heading2

                    heading = player.get_player_heading(pid)
                    heading = math.rad((heading - 180) * -1)
                    offset = v3(pos.x + (math.sin(heading) * -0.8), pos.y + (math.cos(heading) * -0.8), pos.z)
                    offset.z = offset.z + 1.0
                    offset.x = offset.x + 1.0
                    for i = 1, #spawned_cunt1 do

                        entity.set_entity_coords_no_offset(spawned_cunt1[i], offset)

                    end
                    heading2 = player.get_player_heading(pid)
                    heading2 = math.rad((heading2 - 180) * -1)
                    offset2 = v3(pos.x + (math.sin(heading2) * -(-1.8)), pos.y + (math.cos(heading2) * -(-1.8)), pos.z)
                    offset2.z = offset2.z + 1.2
                    offset2.x = offset2.x - 3.0
                    for y = 1, #spawned_cunt2 do

                        entity.set_entity_coords_no_offset(spawned_cunt2[y], offset2)
                    end
                    return HANDLER_CONTINUE
                end
            end),
            type = "toggle",
            callback = function()
            end
        }

        features["LightPOSway"].feat.on = false
        features["LightPOSway"].feat.hidden = true
        -- TODO: Lights

        features["Lightway"] = {
            feat = menu.add_feature("Set Lights around player", "action", featureVars.tr.id, function(feat)

                local offset, pos
                offset = v3()
                pos = v3()
                pos = player.get_player_coords(pid)

                spawned_cunt1[#spawned_cunt1 + 1] = object.create_object(2906806882, pos, true, true)
                entity.set_entity_as_mission_entity(spawned_cunt1[#spawned_cunt1], true, true)

                spawned_cunt2[#spawned_cunt2 + 1] = object.create_object(2906806882, pos, true, true)
                entity.set_entity_as_mission_entity(spawned_cunt2[#spawned_cunt2], true, true)

                spawned_cunt3[#spawned_cunt3 + 1] = object.create_object(2906806882, pos, true, true)
                entity.set_entity_as_mission_entity(spawned_cunt3[#spawned_cunt3], true, true)

                spawned_cunt[#spawned_cunt + 1] = object.create_object(2906806882, pos, true, true)
                entity.set_entity_as_mission_entity(spawned_cunt[#spawned_cunt], true, true)

                spawned_cunt[#spawned_cunt + 1] = object.create_object(2906806882, pos, true, true)
                entity.set_entity_as_mission_entity(spawned_cunt[#spawned_cunt], true, true)
                playerFeatures[pid].features["LightPOS1way"].feat.on = true

                playerFeatures[pid].features["LightPOSway"].feat.on = true
            end),
            type = "action"
        }

        features["RotatingLights"] = {
            feat = menu.add_feature("Rotating Lights", "value_i", featureVars.tr.id, function(feat)

                if Thread2Id[pid + 1] then
                    menu.delete_thread(Thread2Id[pid + 1])
                    Thread2Id[pid + 1] = nil
                end
                if EntityHash.pid then
                    for i = 1, #EntityHash.pid do
                        entity.delete_entity(EntityHash.pid[i])
                        EntityHash.pid[i] = nil
                    end
                end
                if feat.on then
                    orbit_pid = pid
                    Thread2Id[pid + 1] = menu.create_thread(Orbit2, feat.value)
                end
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["RotatingLights"].feat.min = 1
        features["RotatingLights"].feat.max = 10
        features["RotatingLights"].feat.mod = 1
        features["RotatingLights"].feat.value = 1

        features["RotatingLights2"] = {
            feat = menu.add_feature("Rotating Lights", "value_i", featureVars.tr.id, function(feat)

                if Thread1Id[pid + 1] then
                    menu.delete_thread(Thread1Id[pid + 1])
                    Thread1Id[pid + 1] = nil
                end
                if EntityHash2.pid then
                    for i = 1, #EntityHash2.pid do
                        entity.delete_entity(EntityHash2.pid[i])
                        EntityHash2.pid[i] = nil
                    end
                end
                if feat.on then
                    orbit_pid = pid
                    Thread1Id[pid + 1] = menu.create_thread(Orbit1, feat.value)
                end
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["RotatingLights2"].feat.min = 1
        features["RotatingLights2"].feat.max = 20
        features["RotatingLights2"].feat.mod = 1
        features["RotatingLights2"].feat.value = 6

        menu.add_feature("Attach with Physics? (PhysicsGlitch) 0=OFF|1=ON", "action", featureVars.at.id, nil)

        features["Broken_ufo"] = {
            feat = menu.add_feature("Attach Broken ufo Physics? 0|1", "action_value_i", featureVars.at.id, function(feat)

                local pos, rot, offset = v3(), v3(0.0, 0.0, 0.0), v3(0.0, 0.0, 0.0)
                pped = PlyPed(pid)
                phys = false
                pos = player.get_player_coords(pid)
                local i = #spawned_cunts + 1
                spawned_cunts[i] = object.create_object(3974683782, pos, true, false)
                system.wait(25)
                if feat.value == 1 then
                    phys = true
                end

                entity.attach_entity_to_entity(spawned_cunts[i], pped, 0, offset, rot, true, phys, false, 0, true)

            end),
            type = "action"
        }
        features["Broken_ufo"].feat.max = 1
        features["Broken_ufo"].feat.min = 0
        features["Broken_ufo"].feat.value = 1

        features["Attacch_building"] = {
            feat = menu.add_feature("Attach ArenaWar Building", "action_value_i", featureVars.at.id, function(feat)

                local pos, rot, offset = v3(), v3(0.0, 0.0, 0.0), v3(0.0, 0.0, 0.0)
                pped = PlyPed(pid)
                phys = false
                pos = player.get_player_coords(pid)
                local i = #spawned_cunts + 1
                spawned_cunts[i] = object.create_object(2047051359, pos, true, false)
                system.wait(25)
                if feat.value == 1 then
                    phys = true
                end
                entity.attach_entity_to_entity(spawned_cunts[i], pped, 0, offset, rot, true, phys, false, 0, true)

            end),
            type = "action"
        }
        features["Attacch_building"].feat.max = 1
        features["Attacch_building"].feat.min = 0
        features["Attacch_building"].feat.value = 1

        features["BeachFire"] = {
            feat = menu.add_feature("Attach Beach Fires", "action_value_i", featureVars.at.id, function(feat)

                pped = PlyPed(pid)
                local pos, offset = v3(), v3(0.0, 0.0, 10.0)
                local bid1, bid2
                bid1 = ped.get_ped_bone_index(pped, 31086)
                bid2 = ped.get_ped_bone_index(pped, 11816)
                phys = false
                if feat.value == 1 then
                    phys = true
                end

                spawned_cunts[#spawned_cunts + 1] = object.create_object(3229200997, pos, true, false)
                entity.attach_entity_to_entity(spawned_cunts[#spawned_cunts], pped, bid1, pos, offset, true, phys, false, 0, false)
                local offset = v3(0.0, 0.0, -10.0)
                spawned_cunts[#spawned_cunts + 1] = object.create_object(3229200997, pos, true, false)
                entity.attach_entity_to_entity(spawned_cunts[#spawned_cunts], pped, bid2, pos, offset, true, phys, false, 0, false)

                return HANDLER_POP
            end),
            type = "action"
        }
        features["BeachFire"].feat.max = 1
        features["BeachFire"].feat.min = 0
        features["BeachFire"].feat.value = 1

        features["attach_room"] = {
            feat = menu.add_feature("Room Attachment", "action", featureVars.at.id, function(feat)

                local pos, rot = v3(), v3()
                pos.z = -0.5

                spawn_attach(879487762, 0, pos, rot, true, pid)
                rot.x = 180
                spawn_attach(879487762, 0, pos, rot, true, pid)
                pos.z = 1.5
                rot.x = 0
                spawn_attach(879487762, 0, pos, rot, true, pid)
                rot.x = 180
                spawn_attach(879487762, 0, pos, rot, true, pid)
                pos.z = 0
                pos.x = 1.5
                rot.x = 0
                rot.y = 90
                spawn_attach(879487762, 0, pos, rot, true, pid)
                rot.x = 180
                spawn_attach(879487762, 0, pos, rot, true, pid)
                pos.x = -1.5
                spawn_attach(879487762, 0, pos, rot, true, pid)
                rot.x = 0
                spawn_attach(879487762, 0, pos, rot, true, pid)
                pos.x = 0
                pos.y = 1.5
                rot.y = 0
                rot.x = 90
                spawn_attach(879487762, 0, pos, rot, true, pid)
                rot.x = 270
                spawn_attach(879487762, 0, pos, rot, true, pid)
                pos.y = -1.5
                spawn_attach(879487762, 0, pos, rot, true, pid)
                rot.x = 90
                spawn_attach(879487762, 0, pos, rot, true, pid)
            end),
            type = "action"
        }

        features["attach_room1"] = {
            feat = menu.add_feature("Room Attachment v2", "action", featureVars.at.id, function(feat)

                local pos, rot = v3(), v3()
                pos.z = -0.5

                spawn_attach(1313069551, 0, pos, rot, true, pid)
                rot.x = 180
                spawn_attach(1313069551, 0, pos, rot, true, pid)
                pos.z = 1.5
                rot.x = 0
                spawn_attach(1313069551, 0, pos, rot, true, pid)
                rot.x = 180
                spawn_attach(1313069551, 0, pos, rot, true, pid)
                pos.z = 0
                pos.x = 1.5
                rot.x = 0
                rot.y = 90
                spawn_attach(1313069551, 0, pos, rot, true, pid)
                rot.x = 180
                spawn_attach(1313069551, 0, pos, rot, true, pid)
                pos.x = -1.5
                spawn_attach(1313069551, 0, pos, rot, true, pid)
                rot.x = 0
                spawn_attach(1313069551, 0, pos, rot, true, pid)
                pos.x = 0
                pos.y = 1.5
                rot.y = 0
                rot.x = 90
                spawn_attach(1313069551, 0, pos, rot, true, pid)
                rot.x = 270
                spawn_attach(1313069551, 0, pos, rot, true, pid)
                pos.y = -1.5
                spawn_attach(1313069551, 0, pos, rot, true, pid)
                rot.x = 90
                spawn_attach(1313069551, 0, pos, rot, true, pid)
            end),
            type = "action"
        }

        features["attach_room2"] = {
            feat = menu.add_feature("Room Attachment v3", "action", featureVars.at.id, function(feat)

                local pos, rot = v3(), v3()
                pos.z = -0.5

                spawn_attach(3136319403, 0, pos, rot, true, pid)
                rot.x = 180
                spawn_attach(3136319403, 0, pos, rot, true, pid)
                pos.z = 1.5
                rot.x = 0
                spawn_attach(3136319403, 0, pos, rot, true, pid)
                rot.x = 180
                spawn_attach(3136319403, 0, pos, rot, true, pid)
                pos.z = 0
                pos.x = 1.5
                rot.x = 0
                rot.y = 90
                spawn_attach(3136319403, 0, pos, rot, true, pid)
                rot.x = 180
                spawn_attach(3136319403, 0, pos, rot, true, pid)
                pos.x = -1.5
                spawn_attach(3136319403, 0, pos, rot, true, pid)
                rot.x = 0
                spawn_attach(3136319403, 0, pos, rot, true, pid)
                pos.x = 0
                pos.y = 1.5
                rot.y = 0
                rot.x = 90
                spawn_attach(3136319403, 0, pos, rot, true, pid)
                rot.x = 270
                spawn_attach(3136319403, 0, pos, rot, true, pid)
                pos.y = -1.5
                spawn_attach(3136319403, 0, pos, rot, true, pid)
                rot.x = 90
                spawn_attach(3136319403, 0, pos, rot, true, pid)
            end),
            type = "action"
        }

        features["scramdeer"] = {
            feat = menu.add_feature("scramjet Deer", "action", featureVars.tr.id, function(feat)

                pped = PlyPed(pid)
                local pos, heading, blipid, i, y, vehhash
                pos = v3()
                heading = v3()
                heading = player.get_player_heading(pid)
                pos = player.get_player_coords(pid)
                distance = -5
                heading = math.rad((heading - 180) * -1)
                pose = v3(pos.x + (math.sin(heading) * -distance), pos.y + (math.cos(heading) * -distance), pos.z)
                model = 0xD86B5A95
                streaming.request_model(model)
                while (not streaming.has_model_loaded(model)) do
                    system.wait(10)
                end

                i = #escort + 1
                escort[i] = ped.create_ped(6, model, pose, heading, true, false)

                entity.set_entity_god_mode(escort[i], true)
                streaming.set_model_as_no_longer_needed(model)

                vehhash = gameplay.get_hash_key("scramjet")
                streaming.request_model(vehhash)
                while (not streaming.has_model_loaded(vehhash)) do
                    system.wait(10)
                end

                y = #escortveh + 1
                escortveh[y] = vehicle.create_vehicle(vehhash, pose, heading, true, false)

                network.request_control_of_entity(escortveh[y])
                vehicle.set_vehicle_mod_kit_type(escortveh[y], 0)
                vehicle.get_vehicle_mod(escortveh[y], 10)
                vehicle.set_vehicle_mod(escortveh[y], 10, 0, false)
                BlipIDs[#BlipIDs + 1] = ui.add_blip_for_entity(escortveh[y])

                blipid = ui.get_blip_from_entity(escortveh[y])
                ui.set_blip_sprite(blipid, 634)
                vehicle.set_vehicle_on_ground_properly(escortveh[y])
                entity.set_entity_god_mode(escortveh[y], true)
                vehicle.set_vehicle_doors_locked(escortveh[y], 5)

                ped.set_ped_into_vehicle(escort[i], escortveh[y], -1)
                if ai.task_vehicle_drive_wander(escort[i], escortveh[y], 180, 262144) then
                    system.wait(10)
                end
                vehicle.set_vehicle_doors_locked(escortveh[y], 6)
                vehicle.set_vehicle_doors_locked(escortveh[y], 2)
                entity.set_entity_coords_no_offset(escortveh[y], pose)
                ai.task_vehicle_follow(escort[i], escortveh[y], pped, 220, 262144, 25)
                streaming.set_model_as_no_longer_needed(vehhash)
            end),
            type = "action"
        }

        -- TODO: Lester Ramjet

        features["Ram_Jet_cleanup"] = {
            feat = menu.add_feature("Run Delayed Cleanup?", "toggle", featureVars.gr.id, function(feat)

                features["RamJet_cleanup"].feat.on = true

            end),
            type = "toggle",
            callback = function()
                features["RamJet_cleanup"].feat.on = false
            end
        }
        features["Ram_Jet_cleanup"].feat.on = false

        features["RamJet2"] = {
            feat = menu.add_feature("Lester RamJet Attack Player", "action_value_i", featureVars.gr.id, function(feat)

                pped = PlyPed(pid)
                local pos = v3()
                local heading, heading2 = player.get_player_heading(pid), player.get_player_heading(pid)

                pos = player.get_player_coords(pid)
                distance = tonumber(feat.value)
                heading = math.rad((heading - 180) * -1)
                pose = v3(pos.x + (math.sin(heading) * -distance), pos.y + (math.cos(heading) * -distance), pos.z)
                model = 0x6E42FD26
                streaming.request_model(model)
                while (not streaming.has_model_loaded(model)) do
                    system.wait(10)
                end

                escort[#escort + 1] = ped.create_ped(29, model, pos, heading2, true, false)

                entity.set_entity_god_mode(#escort, true)
                ped.set_ped_can_switch_weapons(escort[#escort], true)
                ped.set_ped_combat_attributes(escort[#escort], 46, true)
                ped.set_ped_combat_attributes(escort[#escort], 52, true)
                ped.set_ped_combat_attributes(escort[#escort], 1, true)
                ped.set_ped_combat_attributes(escort[#escort], 2, true)
                ped.set_ped_combat_range(escort[#escort], 2)
                ped.set_ped_combat_ability(escort[#escort], 2)
                ped.set_ped_combat_movement(escort[#escort], 2)
                ai.task_combat_ped(escort[#escort], pped, 0, 16)
                streaming.set_model_as_no_longer_needed(model)

                vehhash = gameplay.get_hash_key("scramjet")
                streaming.request_model(vehhash)
                while (not streaming.has_model_loaded(vehhash)) do
                    system.wait(10)
                end

                escortveh[#escortveh + 1] = vehicle.create_vehicle(vehhash, pose, heading2, true, false)
                network.request_control_of_entity(escortveh[#escortveh])
                entity.set_entity_god_mode(escortveh[#escortveh], true)
                network.request_control_of_entity(escortveh[#escortveh])
                vehicle.set_vehicle_doors_locked(escortveh[#escortveh], 5)
                ped.set_ped_into_vehicle(escort[#escort], escortveh[#escortveh], -1)
                vehicle.set_vehicle_doors_locked(escortveh[#escortveh], 6)
                vehicle.set_vehicle_doors_locked(escortveh[#escortveh], 2)
                vehicle.set_vehicle_mod_kit_type(escortveh[#escortveh], 0)
                vehicle.get_vehicle_mod(escortveh[#escortveh], 10)
                vehicle.set_vehicle_mod(escortveh[#escortveh], 10, 0, false)
                BlipIDs[#BlipIDs + 1] = ui.add_blip_for_entity(escortveh[#escortveh])
                local blipid = ui.get_blip_from_entity(escortveh[#escortveh])
                ui.set_blip_sprite(blipid, 634)
                ai.task_vehicle_aim_at_ped(escort[#escort], pped)
                ai.task_combat_ped(escort[#escort], pped, 0, 16)
                vehicle.set_vehicle_rocket_boost_active(escortveh[#escortveh], true)

                return HANDLER_POP
            end),
            type = "action"
        }
        features["RamJet2"].feat.max = -10
        features["RamJet2"].feat.min = -200
        features["RamJet2"].feat.value = -20

        features["RamJet3"] = {
            feat = menu.add_feature("Lester RamJet Impact Player", "action_value_i", featureVars.gr.id, function(feat)

                pped = PlyPed(pid)
                local pos = v3()
                local heading, heading2 = player.get_player_heading(pid), player.get_player_heading(pid)

                pos = player.get_player_coords(pid)
                local distance = tonumber(feat.value)
                heading = math.rad((heading - 180) * -1)
                local pose = v3(pos.x + (math.sin(heading) * -distance), pos.y + (math.cos(heading) * -distance), pos.z)
                local model = 0x6E42FD26
                streaming.request_model(model)
                while (not streaming.has_model_loaded(model)) do
                    system.wait(10)
                end

                local i = #escort + 1
                escort[i] = ped.create_ped(29, model, pos, heading2, true, false)

                -- entity.set_entity_god_mode(escort[i], true)
                ped.set_ped_can_switch_weapons(escort[i], true)
                ped.set_ped_combat_attributes(escort[i], 46, true)
                ped.set_ped_combat_attributes(escort[i], 52, true)
                ped.set_ped_combat_attributes(escort[i], 1, true)
                ped.set_ped_combat_attributes(escort[i], 2, true)
                ped.set_ped_combat_range(escort[i], 2)
                ped.set_ped_combat_ability(escort[i], 2)
                ped.set_ped_combat_movement(escort[i], 2)
                ai.task_combat_ped(escort[i], pped, 0, 16)
                -- streaming.set_model_as_no_longer_needed(model)

                local vehhash = gameplay.get_hash_key("scramjet")
                streaming.request_model(vehhash)
                while (not streaming.has_model_loaded(vehhash)) do
                    system.wait(10)
                end

                escortveh[#escortveh + 1] = vehicle.create_vehicle(vehhash, pose, heading2, true, false)
                ped.set_ped_into_vehicle(escort[i], escortveh[#escortveh], -1)
                network.request_control_of_entity(escortveh[#escortveh])
                -- entity.set_entity_god_mode(escortveh[#escortveh], true)

                vehicle.set_vehicle_doors_locked(escortveh[#escortveh], 5)
                vehicle.set_vehicle_doors_locked(escortveh[#escortveh], 6)
                vehicle.set_vehicle_doors_locked(escortveh[#escortveh], 2)
                vehicle.set_vehicle_mod_kit_type(escortveh[#escortveh], 0)
                vehicle.get_vehicle_mod(escortveh[#escortveh], 10)
                vehicle.set_vehicle_mod(escortveh[#escortveh], 10, 0, false)
                BlipIDs[#BlipIDs + 1] = ui.add_blip_for_entity(escortveh[#escortveh])
                local blipid = ui.get_blip_from_entity(escortveh[#escortveh])
                ui.set_blip_sprite(blipid, 634)
                ai.task_vehicle_aim_at_ped(escort[i], pped)
                ai.task_combat_ped(escort[i], pped, 0, 16)
                vehicle.set_vehicle_out_of_control(escortveh[#escortveh], true, true)
                vehicle.set_vehicle_rocket_boost_active(escortveh[#escortveh], true)

                return HANDLER_POP
            end),
            type = "action"
        }
        features["RamJet3"].feat.max = -10
        features["RamJet3"].feat.min = -200
        features["RamJet3"].feat.value = -20

        features["Ramjet_Attach"] = {
            feat = menu.add_feature("Attach all RamJets offset", "value_i", featureVars.gr.id, function(feat)
                if feat.on then
                    pped = PlyPed(pid)

                    local offset = v3()
                    offset.x = 0.0
                    offset.y = 0.0
                    offset.z = 0.0
                    local y = tonumber(feat.value)
                    offset.x = y
                    local rot = v3(0.0, 0.0, 0.0)

                    for i = 1, #escort do
                        network.request_control_of_entity(escort[i])
                        entity.attach_entity_to_entity(escort[i], pped, 0, offset, rot, true, true, true, 0, true)
                    end

                    for i = 1, #escortveh do
                        network.request_control_of_entity(escortveh[i])
                        entity.attach_entity_to_entity(escortveh[i], pped, 0, offset, rot, true, true, false, 0, true)
                    end

                    return HANDLER_CONTINUE
                end
                for i = 1, #escortveh do
                    entity.set_entity_as_no_longer_needed(escortveh[i])
                    entity.delete_entity(escortveh[i])
                end
                for i = 1, #escort do
                    entity.set_entity_as_no_longer_needed(escort[i])
                    entity.delete_entity(escort[i])
                end

                return HANDLER_POP
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["Ramjet_Attach"].feat.on = false
        features["Ramjet_Attach"].feat.max = 50
        features["Ramjet_Attach"].feat.min = -50
        features["Ramjet_Attach"].feat.value = -1

        features["RamJet_cleanup"] = {
            feat = menu.add_feature("Run Delayed Ramjet Cleanup", "toggle", featureVars.gr.id, function(feat)
                if feat.on then
                    system.wait(10000)
                    delayed_spawn_cleanup()

                    return HANDLER_CONTINUE
                end
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["RamJet_cleanup"].feat.on = false
        features["RamJet_cleanup"].feat.hidden = true

        features["sendlesmonster"] = {
            feat = menu.add_feature("Arenawar Monster Lester", "action_value_i", featureVars.lgr.id, function(feat)

                ped_groups()
                local attack, modd, pped, e, d, c
                local pos = v3()
                attack = feat.value
                modd = 1
                pped = PlyPed(pid)
                pos = player.get_player_coords(pid)
                e = #escort * 3
                d = 15
                c = d + e
                pos.x = pos.x + c
                pos.y = pos.y + 10
                ground, pos.z = gameplay.get_ground_z(pos)

                local model = gameplay.get_hash_key("ig_lestercrest_2")
                streaming.request_model(model)
                while (not streaming.has_model_loaded(model)) do
                    system.wait(10)
                end

                local i = #escort + 1
                escort[i] = ped.create_ped(6, model, pos, pos.z, true, false)
                if #groupIDs == nil then
                    ped_groups()
                else
                end
                if #escort >= 8 then
                    local t = #escort / 8
                    local j = #groupIDs
                    if t > j then
                        ped_groups()
                        local j = #groupIDs
                        local escort_group = groupIDs[j]
                    else
                    end

                    local escort_group = groupIDs[j]
                else

                    local j = #groupIDs - 1

                    local escort_group = groupIDs[j]
                    ped.set_ped_as_group_member(escort[i], escort_group)
                    ped.set_ped_never_leaves_group(escort[i], true)
                    if i == 1 or 9 then
                        if i == 1 then
                            ped.set_ped_as_group_leader(escort[i], groupIDs[#groupIDs - 1])
                        end
                    elseif i == 9 then
                        ped.set_ped_as_group_leader(escort[i], groupIDs[#groupIDs])
                    end
                end
                entity.set_entity_god_mode(escort[i], true)
                streaming.set_model_as_no_longer_needed(model)

                local vehhash = 1721676810
                streaming.request_model(vehhash)
                while (not streaming.has_model_loaded(vehhash)) do
                    system.wait(10)
                end

                local y = #escortveh + 1
                escortveh[y] = vehicle.create_vehicle(vehhash, pos, pos.z, true, false)
                BlipIDs[#BlipIDs + 1] = ui.add_blip_for_entity(escortveh[y])
                vehicle.set_vehicle_mod_kit_type(escortveh[y], 0)
                vehicle.get_vehicle_mod(escortveh[y], 42)
                vehicle.set_vehicle_mod(escortveh[y], 42, 1, false)
                vehicle.set_vehicle_mod_kit_type(escortveh[y], 0)
                vehicle.get_vehicle_mod(escortveh[y], 45)
                vehicle.set_vehicle_mod(escortveh[y], 45, 0, false)
                vehicle.set_vehicle_mod_kit_type(escortveh[y], 0)
                vehicle.get_vehicle_mod(escortveh[y], 34)
                vehicle.set_vehicle_mod(escortveh[y], 34, -1, false)
                vehicle.set_vehicle_mod_kit_type(escortveh[y], 0)
                vehicle.get_vehicle_mod(escortveh[y], 48)
                vehicle.set_vehicle_mod(escortveh[y], 48, 1, false)
                vehicle.set_vehicle_mod_kit_type(escortveh[y], 0)
                vehicle.get_vehicle_mod(escortveh[y], 40)
                vehicle.set_vehicle_mod(escortveh[y], 40, 2, false)
                vehicle.set_vehicle_mod_kit_type(escortveh[y], 0)
                vehicle.get_vehicle_mod(escortveh[y], 41)
                vehicle.set_vehicle_mod(escortveh[y], 41, 2, false)
                vehicle.set_vehicle_mod_kit_type(escortveh[y], 0)
                vehicle.get_vehicle_mod(escortveh[y], 11)
                vehicle.set_vehicle_mod(escortveh[y], 11, 3, false)
                vehicle.set_vehicle_mod_kit_type(escortveh[y], 0)
                vehicle.get_vehicle_mod(escortveh[y], 9)
                vehicle.set_vehicle_mod(escortveh[y], 9, 0, false)
                vehicle.set_vehicle_mod_kit_type(escortveh[y], 0)
                vehicle.get_vehicle_mod(escortveh[y], 11)
                vehicle.set_vehicle_mod(escortveh[y], 11, 3, false)
                vehicle.set_vehicle_mod_kit_type(escortveh[y], 0)
                vehicle.get_vehicle_mod(escortveh[y], 16)
                vehicle.set_vehicle_mod(escortveh[y], 16, 4, false)
                ui.add_blip_for_entity(escortveh[y])

                ui.set_blip_sprite(BlipIDs[#BlipIDs], 666)
                vehicle.set_vehicle_on_ground_properly(escortveh[y])
                entity.set_entity_god_mode(escortveh[y], true)
                vehicle.set_vehicle_doors_locked(escortveh[y], 5)
                network.request_control_of_entity(escortveh[y])
                ped.set_ped_combat_attributes(escort[i], 46, true)
                ped.set_ped_combat_attributes(escort[i], 52, true)
                ped.set_ped_combat_attributes(escort[i], 1, true)
                ped.set_ped_combat_attributes(escort[i], 2, true)
                ped.set_ped_combat_range(escort[i], 2)
                ped.set_ped_combat_ability(escort[i], 2)
                ped.set_ped_combat_movement(escort[i], 2)
                ped.set_ped_into_vehicle(escort[i], escortveh[y], -1)
                if ai.task_vehicle_drive_wander(escort[i], escortveh[y], 180, 262144) then
                    system.wait(10)
                end
                vehicle.set_vehicle_doors_locked(escortveh[y], 6)
                vehicle.set_vehicle_doors_locked(escortveh[y], 2)
                entity.set_entity_coords_no_offset(escortveh[y], pos)
                if attack == 1 then
                    ai.task_combat_ped(escort[i], pped, 0, 16)
                else
                    if attack == 2 then
                        playerFeatures[pid].features["hunter_taskloop"].feat.on = true
                        ai.task_vehicle_follow(escort[i], escortveh[y], pped, 220, 262144, 25)
                    end
                end
                streaming.set_model_as_no_longer_needed(vehhash)
            end),
            type = "action_value_i"
        }
        features["sendlesmonster"].feat.max = 2
        features["sendlesmonster"].feat.min = 0
        features["sendlesmonster"].feat.value = 0

        features["weapon_impact"] = {
            feat = menu.add_feature("Get last Weapon impact POS", "toggle", featureVars.f.id, function(feat)
                if feat.on then
                    pped = PlyPed(pid)
                    local success, pos = ped.get_ped_last_weapon_impact(pped, v3())
                    if success then
                        PlyImpactPos = pos
                    else

                    end
                    return HANDLER_CONTINUE
                end
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["weapon_impact"].feat.on = false
        features["weapon_impact"].feat.hidden = false

        features["Give_Airstrike"] = {
            feat = menu.add_feature("Give last Weapon Impact Strike", "value_i", featureVars.f.id, function(feat)

                playerFeatures[pid].features["weapon_impact"].feat.on = true
                if feat.on then
                    local posm, playerz, zPos, hash
                    if not notify_sent then
                        moist_notify("Weapon Projectile Selected:\n", StrikeGive[feat.value])
                        notify_sent = true
                    end

                    pped = PlyPed(pid)
                    if not ped.is_ped_shooting(pped) then
                        return HANDLER_CONTINUE
                    end

                    posm = v3()
                    posm = player.get_player_coords(pid)

                    if feat.value == 5 then
                        posm.z = posm.z + 10
                    else
                        posm.z = posm.z + 100
                    end

                    hash = gameplay.get_hash_key(StrikeGive[feat.value])
                    pos_off = v3()
                    pos_off.x = pos.x + math.random(1, 5)
                    pos_off.y = pos.y + math.random(1, 8)

                    playerz, zPos = gameplay.get_ground_z(pos)
                    pos_off.z = zPos
                    gameplay.shoot_single_bullet_between_coords(posm, PlyImpactPos, 1000.00, hash, 0, true, false, 100000.0)
                    system.wait(50)
                    PlyImpactPos.x = PlyImpactPos.x + 5
                    gameplay.shoot_single_bullet_between_coords(posm, PlyImpactPos, 10000.00, hash, 0, true, false, 100000.0)
                    system.wait(50)
                    PlyImpactPos.y = PlyImpactPos.y - 5
                    gameplay.shoot_single_bullet_between_coords(posm, PlyImpactPos, 10000.00, hash, 0, true, false, 100000.0)
                    system.wait(50)
                    PlyImpactPos.x = PlyImpactPos.x - 6
                    gameplay.shoot_single_bullet_between_coords(posm, PlyImpactPos, 10000.00, hash, 0, true, false, 100000.0)
                    system.wait(50)
                    PlyImpactPos.y = PlyImpactPos.y + 6
                    gameplay.shoot_single_bullet_between_coords(posm, PlyImpactPos, 10000.00, hash, 0, true, false, 100000.0)
                    system.wait(50)
                    gameplay.shoot_single_bullet_between_coords(posm, PlyImpactPos, 1000.00, hash, 0, true, false, 100000.0)
                    system.wait(50)
                    PlyImpactPos.x = PlyImpactPos.x + 5
                    gameplay.shoot_single_bullet_between_coords(posm, PlyImpactPos, 10000.00, hash, 0, true, false, 100000.0)
                    system.wait(50)
                    PlyImpactPos.y = PlyImpactPos.y - 5
                    gameplay.shoot_single_bullet_between_coords(posm, PlyImpactPos, 10000.00, hash, 0, true, false, 100000.0)
                    system.wait(50)
                    PlyImpactPos.x = PlyImpactPos.x - 4
                    gameplay.shoot_single_bullet_between_coords(posm, PlyImpactPos, 10000.00, hash, 0, true, false, 100000.0)
                    system.wait(50)
                    PlyImpactPos.y = PlyImpactPos.y + 4
                    gameplay.shoot_single_bullet_between_coords(posm, PlyImpactPos, 10000.00, hash, 0, true, false, 100000.0)
                    system.wait(50)

                    -- print(PlyImpactPos)
                    return HANDLER_CONTINUE
                end

                playerFeatures[pid].features["weapon_impact"].feat.on = false
                notify_sent = false
                return HANDLER_POP

            end),
            type = "toggle",
            callback = function()

            end
        }
        features["Give_Airstrike"].feat.on = false
        features["Give_Airstrike"].feat.max = #StrikeGive
        features["Give_Airstrike"].feat.min = 1

        features["World_PickupDump"] = {
            feat = menu.add_feature("Dump World Pickups on this Cunt!", "action", featureVars.tr.id, function(feat)
                if world_dumped then
                    local pos = v3()
                    pos = player.get_player_coords(pid)
                    dump_pickups_onplayer(pid, pos)
                end
                return HANDLER_POP
            end),
            type = "action"
        }

        features["Block Passive"] = {
            feat = menu.add_feature("Block Passive Mode", "action", featureVars.f.id, function(feat)

                script.trigger_script_event(0xC9CC4F80, pid, {1, 1})
                script.trigger_script_event(3385610112, pid, {1, 1})
                local scid = GetSCID(pid)
                local name = tostring(player.get_player_name(pid))
                Debug_Out(string.format("Player: " .. name .. " [" .. scid .. "]" .. "Blocked Passive"))
            end),
            type = "action"
        }

        features["Unblock Passive"] = {
            feat = menu.add_feature("Unblock Passive Mode", "action", featureVars.f.id, function(feat)

                script.trigger_script_event(0xC9CC4F80, pid, {2, 0})
                script.trigger_script_event(3385610112, pid, {2, 0})
                scid = GetSCID(pid)
                name = tostring(player.get_player_name(pid))
                Debug_Out(string.format("Player: " .. name .. " [" .. scid .. "]" .. "Passive Unblocked"))

            end),
            type = "action"
        }

        features["DisableJumping"] = {
            feat = menu.add_feature("Fuck Ability to Play", "action", featureVars.f.id, function(feat)
                script.trigger_script_event(0xf5cb92db, pid, {1, 2, 4294967295, 1, 115, 0, 0, 0})
                script.trigger_script_event(-171207973, pid, {1, 2, 4294967295, 1, 115, 0, 0, 0})
                script.trigger_script_event(4123759323, pid, {1, 2, -1, 1, 115, 0, 0, 0})

            end),
            type = "action"
        }

        -- TODO: Grief
        featureVars.lag = menu.add_feature("Lag Player with Entity Spam", "parent", featureVars.g.id)
        menu.add_feature("Value = Spawn Amount", "action", featureVars.lag.id)
        menu.add_feature("Spawns Delete When you Unattach", "action", featureVars.lag.id)

        local blame = 0

        features["blamer"] = {
            feat = menu.add_feature("Own The Blame For this shit?", "toggle", featureVars.g.id, function(feat)
                if not feat.on then
                    blame = 0
                    return HANDLER_POP
                end
                if not blame == 0 or nil then
                    blame = PlayerPed

                end
                return HANDLER_CONTINUE
            end),
            type = "toggle"
        }

        features["blamedorbital"] = {
            feat = menu.add_feature("Orbital Player Blaming: ", "action_value_str", featureVars.f.id, function(feat)

                local pos = v3()
                pped = PlyPed(pid)
                myped = PlyPed(feat.value)

                pos = entity.get_entity_coords(pped)
                offset = v3(0.0, 0.0, -2000.00)

                script.get_global_f(1694982)
                graphics.set_next_ptfx_asset("scr_xm_orbital")
                while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
                    graphics.request_named_ptfx_asset("scr_xm_orbital")
                    system.wait(0)
                end
                gameplay.set_override_weather(3)
                gameplay.clear_cloud_hat()

                fire.add_explosion(pos, 59, true, false, 1.5, myped)
                fire.add_explosion(pos + offset, 60, true, false, 1.8, myped)

                fire.add_explosion(pos + offset, 62, true, false, 2.0, myped)
                fire.add_explosion(pos + v3(100.0, 100.0, 7000.00), 50, true, false, 1.0, myped)
                fire.add_explosion(pos, 50, true, false, 1.0, myped)
                graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos, v3(0, 0, 0), 100.000, false, false, true)
                audio.play_sound_from_coord(-1, "BOATS_PLANES_HELIS_BOOM", v3(-910000.00, -10000.0, -19000.00), "MP_LOBBY_SOUNDS", true, 0, false)
                --  audio.play_sound_from_coord(-1, "DLC_XM_Explosions_Orbital_Cannon", pos, "MP_LOBBY_SOUNDS", true, 99999990, false)
                audio.play_sound_from_coord(myped, "DLC_XM_Explosions_Orbital_Cannon", pos, 0, true, 0, false)
                audio.play_sound_from_coord(-1, "DLC_XM_Explosions_Orbital_Cannon", pos, myped, true, 0, false)
                audio.play_sound_from_coord(-1, "DLC_XM_Explosions_Orbital_Cannon", pos, 0, true, 0, false)

                script.get_global_i(1694982)
                graphics.set_next_ptfx_asset("scr_xm_orbital")
                while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
                    graphics.request_named_ptfx_asset("scr_xm_orbital")
                    system.wait(0)
                end
                gameplay.set_override_weather(3)
                gameplay.clear_cloud_hat()

                fire.add_explosion(pos, 59, false, true, 1.5, myped)
                fire.add_explosion(pos + offset, 60, true, false, 1.8, myped)

                fire.add_explosion(pos + offset, 62, true, false, 2.0, myped)
                fire.add_explosion(pos + v3(100.0, 100.0, 7000.00), 50, true, false, 1.0, myped)
                fire.add_explosion(pos, 50, true, false, 1.0, myped)
                fire.add_explosion(pos, 50, true, false, 1.0, myped)
                graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos, v3(0, 0, 0), 100.000, false, false, true)
                --  audio.play_sound_from_coord(-1, "BOATS_PLANES_HELIS_BOOM", pos + v3(0.0,0.0,20000), "MP_LOBBY_SOUNDS", true, 0, false)
                audio.play_sound_from_coord(-1, "DLC_XM_Explosions_Orbital_Cannon", pos, "o", true, 0, false)
                audio.play_sound(-1, "DLC_XM_Explosions_Orbital_Cannon", 0, true, 0, false)
                audio.play_sound(-1, "DLC_XM_Explosions_Orbital_Cannon", 0, true, 0, false)
                audio.play_sound_from_coord(-1, "MP_Impact", pos, 0, true, 0, false)
                audio.play_sound(-1, "MP_Impact", 0, true, 0, false)

                graphics.set_next_ptfx_asset("scr_xm_orbital")
                while not graphics.has_named_ptfx_asset_loaded("scr_xm_orbital") do
                    graphics.request_named_ptfx_asset("scr_xm_orbital")
                    system.wait(0)
                end
                graphics.start_networked_ptfx_non_looped_at_coord("scr_xm_orbital_blast", pos, v3(0, 0, 0), 10.000, false, false, true)

            end),
            type = "action"
        }
        -- features["blamedorbital"].feat:set_str_data(Playerz)

        features["Dildo_Dick"] = {
            feat = menu.add_feature("Dildo Dick The Cunt", "action", featureVars.at.id, function(feat)

                pped = PlyPed(pid)
                local pos = v3()
                local offset = v3()
                offset.x = 0.08
                offset.y = 0.0
                offset.z = 0.0
                local rot = v3()
                rot.x = 40
                rot.y = -83
                rot.z = -134
                local bid = ped.get_ped_bone_index(pped, 65068)
                local hashb = gameplay.get_hash_key("v_res_d_dildo_f")
                spawned_cunts[#spawned_cunts + 1] = object.create_object(hashb, pos, true, false)
                entity.attach_entity_to_entity(spawned_cunts[#spawned_cunts], pped, bid, offset, rot, true, false, false, 0, true)
                local offset = v3()
                offset.x = 0.0
                offset.y = 0.0
                offset.z = 0.0
                local rot = v3()
                rot.x = 293.0
                rot.y = 28.0
                rot.z = 24.0
                local bid = ped.get_ped_bone_index(pped, 23553)
                spawned_cunts[#spawned_cunts + 1] = object.create_object(hashb, pos, true, true)
                entity.attach_entity_to_entity(spawned_cunts[#spawned_cunts], pped, bid, offset, rot, true, false, false, 0, true)
                local bid = ped.get_ped_bone_index(pped, 65068)
                local offset = v3()
                offset.x = 0.010
                offset.y = 0.01
                offset.z = 0.001
                local rot = v3()
                rot.x = 1.0
                rot.y = 1.0
                rot.z = 1.0
                return HANDLER_POP
            end),
            type = "action"
        }

        features["Dildo_Dick"] = {
            feat = menu.add_feature("Dildo Illuminate Cunt", "action", featureVars.at.id, function(feat)

                pped = PlyPed(pid)
                local pos = v3()
                local offset = v3()
                offset.x = 0.08
                offset.y = 0.0
                offset.z = 0.0
                local rot = v3()
                rot.x = 40
                rot.y = -83
                rot.z = -134
                local bid = ped.get_ped_bone_index(pped, 65068)
                local hashb = gameplay.get_hash_key("v_res_d_dildo_f")
                spawned_cunts[#spawned_cunts + 1] = object.create_object(hashb, pos, true, false)
                entity.attach_entity_to_entity(spawned_cunts[#spawned_cunts], pped, bid, offset, rot, true, false, false, 0, true)
                local offset = v3()
                offset.x = 0.0
                offset.y = 0.0
                offset.z = 0.0
                local rot = v3()
                rot.x = 293.0
                rot.y = 28.0
                rot.z = 24.0
                local bid = ped.get_ped_bone_index(pped, 23553)
                spawned_cunts[#spawned_cunts + 1] = object.create_object(hashb, pos, true, true)
                entity.attach_entity_to_entity(spawned_cunts[#spawned_cunts], pped, bid, offset, rot, true, false, false, 0, true)
                local bid = ped.get_ped_bone_index(pped, 65068)
                local offset = v3()
                offset.x = 0.010
                offset.y = 0.01
                offset.z = 0.001
                local rot = v3()
                rot.x = 1.0
                rot.y = 1.0
                rot.z = 1.0
                local hasha = gameplay.get_hash_key("prop_air_lights_02a")
                spawned_cunts[#spawned_cunts + 1] = object.create_object(hasha, pos, true, true)
                entity.attach_entity_to_entity(spawned_cunts[#spawned_cunts], pped, bid, offset, rot, true, false, false, 0, false)
                local pos = v3()
                local offset = v3()
                local rot = v3()
                offset.x = 0.12
                offset.y = 0.0
                offset.z = -0.26
                rot.x = -181.0
                rot.y = 0.0
                rot.z = 0.0

                pped = PlyPed(pid)
                local bone = ped.get_ped_bone_index(pped, 18905)
                spawned_cunts[#spawned_cunts + 1] = object.create_object(3324004640, pos, true, false)

                entity.attach_entity_to_entity(spawned_cunts[#spawned_cunts], pped, bone, offset, rot, true, false, true, 0, true)

                return HANDLER_POP
            end),
            type = "action"
        }

        features["Firework_ply"] = {
            feat = menu.add_feature("Fireworks Around Player Delay: ", "value_i", featureVars.tr.id, function(feat)

                if feat.on then
                    local pos, Pos, Rpos1, Rpos2
                    pos, Pos = v3(), v3()
                    pos = player.get_player_coords(pid)
                    Pos = player.get_player_coords(pid)

                    Pos.x = pos.x + math.random(-10, 20)
                    Pos.y = pos.y + math.random(-10, 20)
                    Pos.z = pos.z + math.random(5, 50)
                    fire.add_explosion(Pos, 38, true, false, 0, blame)
                    system.wait(feat.value)

                    Pos.x = pos.x + math.random(-10, 20)
                    Pos.y = pos.y + math.random(-10, 20)
                    Pos.z = pos.z + math.random(5, 50)

                    fire.add_explosion(Pos, 38, true, false, 0, blame)
                    system.wait(feat.value)
                    pos = player.get_player_coords(pid)
                    Pos.x = pos.x + math.random(-100, 200)
                    Pos.y = pos.y + math.random(-100, 200)
                    Pos.z = pos.z + math.random(5, 50)

                    fire.add_explosion(Pos, 38, true, false, 0, blame)
                    system.wait(feat.value)

                    Pos.x = pos.x + math.random(1, 200)
                    Pos.y = pos.y + math.random(1, 200)
                    Pos.z = pos.z + math.random(5, 50)
                    fire.add_explosion(Pos, 38, true, false, 0, blame)
                    system.wait(feat.value)

                    return HANDLER_CONTINUE
                end

            end),
            type = "toggle"
        }
        features["Firework_ply"].feat.max = 2000
        features["Firework_ply"].feat.min = 0
        features["Firework_ply"].feat.value = 100
        features["Firework_ply"].feat.mod = 10

        features["explodeply"] = {
            feat = menu.add_feature("Explosions Around Player", "value_i", featureVars.g.id, function(feat)

                if feat.on then
                    local pos, Pos, Rpos1, Rpos2
                    pos, Pos = v3(), v3()
                    pos = player.get_player_coords(pid)
                    Pos = player.get_player_coords(pid)

                    Pos.x = pos.x + math.random(1, 5)
                    Pos.y = pos.y + math.random(1, 8)
                    fire.add_explosion(Pos, feat.value, true, false, 0, blame)
                    system.wait(25)
                    Pos.x = pos.x - math.random(1, 5)
                    Pos.y = pos.y - math.random(1, 8)
                    fire.add_explosion(Pos, feat.value, true, false, 0, blame)
                    system.wait(25)
                    fire.add_explosion(pos, feat.value, true, false, 0, blame)
                    return HANDLER_CONTINUE
                end

            end),
            type = "toggle"
        }
        features["explodeply"].feat.max = 74
        features["explodeply"].feat.min = -1
        features["explodeply"].feat.value = 0

        features["explode_ply"] = {
            feat = menu.add_feature("Explosions Around Player", "action_value_i", featureVars.g.id, function(feat)

                local pos, Pos, Rpos1, Rpos2
                pos, Pos = v3(), v3()
                pos = player.get_player_coords(pid)
                Pos = player.get_player_coords(pid)

                Pos.x = pos.x + math.random(1, 5)
                Pos.y = pos.y + math.random(1, 8)
                fire.add_explosion(Pos, feat.value, true, false, 0, blame)
                system.wait(25)
                Pos.x = pos.x - math.random(1, 5)
                Pos.y = pos.y - math.random(1, 8)
                fire.add_explosion(Pos, feat.value, true, false, 0, blame)
                system.wait(25)
                fire.add_explosion(pos, feat.value, true, false, 0, blame)

            end),
            type = "toggle"
        }
        features["explode_ply"].feat.max = 74
        features["explode_ply"].feat.min = -1
        features["explode_ply"].feat.value = 0

        features["dildobombs"] = {
            feat = menu.add_feature("Dildo Bombs From Ass", "action", featureVars.g.id, function(feat)

                pped = PlyPed(pid)
                ped.get_ped_bone_coords(pped, 0, offset)
                local pedbool
                local pos = v3()
                local offset = v3()
                offset.x = 0.0
                offset.y = -0.001
                offset.z = 0.0

                pedbool, pos = ped.get_ped_bone_coords(pped, 0, offset)
                spawned_cunts[#spawned_cunts + 1] = object.create_object(-422877666, pos, true, true)

                entity.apply_force_to_entity(spawned_cunts[#spawned_cunts], 5, 0, 0, 100, 0, 0, 0, true, true)
                pedbool, pos = ped.get_ped_bone_coords(pped, 0, offset)
                offset.y = offset.y + -0.001
                system.wait(10)

                spawned_cunts[#spawned_cunts + 1] = object.create_object(-422877666, pos, true, true)

                entity.apply_force_to_entity(spawned_cunts[#spawned_cunts], 5, 0, 0, -100, -2, 0, 0, true, true)
                pedbool, pos = ped.get_ped_bone_coords(pped, 0, offset)
                system.wait(10)
                offset.y = offset.y + -0.001

                spawned_cunts[#spawned_cunts + 1] = object.create_object(-422877666, pos, true, true)

                entity.apply_force_to_entity(spawned_cunts[#spawned_cunts], 3, 0, 0, 100, 1, 0, 0, true, true)
                system.wait(10)
                pedbool, pos = ped.get_ped_bone_coords(pped, 0, offset)
                offset.y = offset.y + -0.001

                spawned_cunts[#spawned_cunts + 1] = object.create_object(-422877666, pos, true, true)
                system.wait(10)
                entity.apply_force_to_entity(spawned_cunts[#spawned_cunts], 5, 0, 0, -100, 0, 0, 0, true, true)

                system.wait(100)
                for i = 1, #spawned_cunts do
                    pos = entity.get_entity_coords(spawned_cunts[i])
                    offset.x = -0.5
                    offset.y = 0.5
                    fire.add_explosion(pos + offset, 60, true, false, 5, blame)

                    fire.add_explosion(pos + offset, 59, true, false, 1, blame)
                    offset.x = 0.5
                    offset.y = -0.5
                    pos = entity.get_entity_coords(spawned_cunts[i])
                    fire.add_explosion(pos + offset, 59, true, false, 1, blame)

                    fire.add_explosion(pos + offset, 60, true, false, 1, blame)
                    offset.x = -0.5
                    offset.y = -0.5
                    fire.add_explosion(pos + offset, 59, true, false, 5, blame)
                    system.wait(10)
                    fire.add_explosion(pos + offset, 60, true, false, 5, blame)
                    offset.x = 0.5
                    offset.y = 0.5
                    fire.add_explosion(pos + offset, 58, true, false, 5, blame)

                    fire.add_explosion(pos + offset, 59, true, false, 1, blame)
                    offset.x = -1.0
                    offset.y = 1.0

                    fire.add_explosion(pos + offset, 60, true, false, 1, blame)

                    fire.add_explosion(pos + offset, 59, true, false, 1, blame)
                    offset.x = 0.0
                    offset.y = 0.0
                    system.wait(10)
                    fire.add_explosion(pos + offset, 59, true, false, 5, blame)

                    fire.add_explosion(pos + offset, 60, true, false, 5, blame)

                    system.wait(100)
                    entity.set_entity_as_no_longer_needed(spawned_cunts[i])
                    entity.delete_entity(spawned_cunts[i])

                end

            end),
            type = "action"
        }

        features["HomingFlare"] = {
            feat = menu.add_feature("Flare assisted Homing", "action", featureVars.g.id, function(feat)

                pped = PlyPed(player.player_id())

                local pos = v3()
                pos = player.get_player_coords(pid)
                pos.z = pos.z + 50.00

                -- local posz
                -- posz, pos.z = gameplay.get_ground_z(pos)

                local offset = v3()
                offset = get_offset(pid, 55)
                -- offset.z =  offset.z + 20.00

                local speed = 300000

                local hash = gameplay.get_hash_key("WEAPON_FLAREGUN")
                gameplay.shoot_single_bullet_between_coords(pos, offset, 1000.00, hash, pped, false, true, speed)
                system.wait(0)

                local hash = gameplay.get_hash_key(StrikeGive[12])
                local pos = v3()
                pos = player.get_player_coords(pid)
                pos.z = pos.z + 750.0
                local offset = v3()
                offset = get_offset(pid, -200)
                offset.z = offset.z + 75.0
                gameplay.shoot_single_bullet_between_coords(offset, get_offset(pid, 50), 10000.00, hash, blame, true, false, 10000.0)
                system.wait(10)
                local hash = gameplay.get_hash_key(StrikeGive[12])
                local pos = v3()
                pos = player.get_player_coords(pid)
                pos.z = pos.z + 75.0
                local offset = v3()
                offset = get_offset(pid, -200)
                offset.z = offset.z + 100.0
                gameplay.shoot_single_bullet_between_coords(offset, get_offset(pid, 50), 10000.00, hash, blame, true, false, 10000.0)
                system.wait(10)
                local hash = gameplay.get_hash_key(StrikeGive[13])
                local pos = v3()
                pos = player.get_player_coords(pid)
                pos.z = pos.z + 75.0
                local offset = v3()
                offset = get_offset(pid, -200)
                offset.z = offset.z + 100.0
                gameplay.shoot_single_bullet_between_coords(offset, get_offset(pid, 50), 10000.00, hash, blame, true, false, 10000.0)
                system.wait(10)

            end),
            type = "action"
        }

        features["Homing_Flare"] = {
            feat = menu.add_feature("Flare assisted Homing v2", "action", featureVars.g.id, function(feat)

                pped = PlyPed(player.player_id())

                local pos = v3()
                pos = player.get_player_coords(pid)

                -- local posz
                -- posz, pos.z = gameplay.get_ground_z(pos)

                local offset = v3()
                offset = get_offset(pid, 50)
                offset.z = offset.z + 30.00

                local speed = 300000

                local hash = gameplay.get_hash_key("WEAPON_FLAREGUN")
                gameplay.shoot_single_bullet_between_coords(pos, offset, 1000.00, hash, pped, false, true, speed)
                system.wait(0)

                local hash = gameplay.get_hash_key(StrikeGive[12])
                local pos = v3()
                pos = player.get_player_coords(pid)
                local offset = v3()
                offset = get_offset(pid, -20)
                offset.z = offset.z + 150.0
                gameplay.shoot_single_bullet_between_coords(offset, get_offset(pid, 100), 10000.00, hash, blame, true, false, 100000.0)

                gameplay.shoot_single_bullet_between_coords(offset, pos, 10000.00, hash, blame, true, false, 100000.0)

            end),
            type = "action"
        }

        features["airstrike"] = {
            feat = menu.add_feature("Airstrike player", "action", featureVars.g.id, function(feat)

                local hash = gameplay.get_hash_key("weapon_airstrike_rocket")
                local pos = v3()
                pos = player.get_player_coords(pid)
                pos.z = pos.z + 10.0
                local offset = v3()
                offset.x = 0.0
                offset.y = 0.0
                offset.z = -1.0
                gameplay.shoot_single_bullet_between_coords(pos, player.get_player_coords(pid) + offset, 10000.00, hash, blame, true, false, 10000.0)

            end),
            type = "action"
        }

        features["multishoot"] = {
            feat = menu.add_feature("Snipe for all Directions", "action", featureVars.g.id, function(feat)

                local hash = gameplay.get_hash_key("weapon_heavysniper")
                local pos = v3()
                pos = player.get_player_coords(pid)
                pos.z = pos.z + 5.0
                offset = v3()
                offset.x = 10.0
                offset.y = 0.0
                offset.z = 0.0
                local boolpos, bonepos = ped.get_ped_bone_coords(PlyPed(pid), 12844, offset)

                gameplay.shoot_single_bullet_between_coords(pos + offset, bonepos, 1000.00, hash, blame, true, false, 10000.0)
                offset.x = -10.0
                offset.y = 0.0
                offset.z = 0.0
                gameplay.shoot_single_bullet_between_coords(pos + offset, bonepos, 1000.00, hash, blame, true, false, 10000.0)
                offset.x = 0.0
                offset.y = 10.0
                offset.z = 0.0
                gameplay.shoot_single_bullet_between_coords(pos + offset, bonepos, 1000.00, hash, blame, true, false, 10000.0)
                offset.x = 0.0
                offset.y = -10.0
                offset.z = 0.0
                gameplay.shoot_single_bullet_between_coords(pos + offset, bonepos, 1000.00, hash, blame, true, false, 10000.0)

            end),
            type = "action"
        }

        features["Ped_hate"] = {
            feat = menu.add_feature("PedsHate & AttackPlayer Weap:", "action_value_i", featureVars.g.id, function(feat)

                local weap = feat.value

                moist_notify("Peds Attack With:\n", ped_wep[feat.value][1])

                Peds_hateWorld(pid, weap)

            end),
            type = "action_value_i",
            callback = function()
            end
        }
        features["Ped_hate"].feat.max = #ped_wep
        features["Ped_hate"].feat.min = 1
        features["Ped_hate"].feat.value = 10

        features["Peds_eject"] = {
            feat = menu.add_feature("Task NearbyPeds Bail/Exit Veh", "action_value_i", featureVars.tr.id, function(feat)

                moist_notify("Peds around Target Player\n", "Will Exit Vehicle or Bail from it")

                Ped_eject(pid, eject[feat.value])

            end),
            type = "action_value_i",
            callback = function()
            end
        }
        features["Peds_eject"].feat.max = #eject
        features["Peds_eject"].feat.min = 1
        features["Peds_eject"].feat.value = 6

        features["Send_HunterLester"] = {
            feat = menu.add_feature("Send Lester Hunt them in savage", "action", featureVars.lgr.id, function(feat)

                playerFeatures[pid].features["hunter_taskloop"].feat.on = true
                local pos = v3(-73.31681060791, -820.26013183594, 326.17517089844)

                local vehhash = veh_list[2][2]
                mod = 10
                modvalue = -1
                pped = PlyPed(pid)
                spawn_ped(pid, 0x6E42FD26, pos, true, true)
                system.wait(100)
                local huntv = spawn_veh(pid, vehhash, pos, mod, modvalue, true)

                local blipid = ui.get_blip_from_entity(huntv)
                ui.set_blip_sprite(blipid, 43)

                local p = #escort
                local y = #escortveh

                ped.set_ped_into_vehicle(escort[p], escortveh[y], -1)
                ai.task_combat_ped(escort[p], pped, 0, 16)
                system.wait(4000)
                vehicle.control_landing_gear(escortveh[y], 3)
                system.wait(4000)
                entity.set_entity_collision(escortveh[y], false, false, false)

                moist_notify("Lester Savage Hunter", "\nSent from Maze Tower to Target")

            end),
            type = "action"
        }

        features["Send_HunterLester1"] = {
            feat = menu.add_feature("Lester Thruster Hunter 2:weap", "action_value_i", featureVars.lgr.id, function(feat)
                playerFeatures[pid].features["hunter_taskloop"].feat.on = true
                local pos = v3(-73.31681060791, -820.26013183594, 326.17517089844)

                local vehhash = 0x58CDAF30

                pped = PlyPed(pid)
                spawn_ped(pid, 0x6E42FD26, pos, true, true)
                system.wait(100)
                local i = feat.value
                local mod, modvalue = 10, -1
                local huntv = spawn_veh(pid, vehhash, pos, mod, modvalue, true)
                entity.set_entity_as_mission_entity(huntv, true, false)

                if feat.value == 2 then
                    local modds = {{10, 1}, {4, 0}, {11, 3}, {12, 2}, {16, 4}, {18, 1}, {20, 0}, {22, 0}, {48, 23}}

                    for i = 1, #modds do

                        vehicle.set_vehicle_mod_kit_type(huntv, 0)
                        vehicle.get_vehicle_mod(huntv, modds[i][1])
                        vehicle.set_vehicle_mod(huntv, modds[i][1], modds[i][2], false)
                    end
                end

                local p = #escort
                local y = #escortveh
                entity.set_entity_as_mission_entity(escort[p], true, false)
                ped.set_ped_into_vehicle(escort[p], escortveh[y], -1)
                local blipid = ui.get_blip_from_entity(escortveh[y])
                ui.set_blip_sprite(blipid, 597)
                ai.task_combat_ped(escort[p], pped, 0, 16)
                system.wait(4000)
                network.request_control_of_entity(huntv)
                entity.set_entity_collision(huntv, false, false, false)

                network.request_control_of_entity(escortveh[y])
                entity.set_entity_collision(escortveh[y], false, false, false)
                moist_notify("Thruster Lester Hunter", "\nSent from Maze Tower to Target")

            end),
            type = "action"
        }
        features["Send_HunterLester1"].feat.max = 2
        features["Send_HunterLester1"].feat.min = 1
        features["Send_HunterLester1"].feat.value = 1

        features["hunter_taskloop"] = {
            feat = menu.add_feature("Retask Lester on Death", "toggle", featureVars.lgr.id, function(feat)
                if feat.on then
                    pped = PlyPed(pid)
                    if not entity.is_entity_dead(pped) then
                        return HANDLER_CONTINUE
                    end
                    system.wait(4000)
                    for i = 1, #escort do

                        -- if #escortveh == nil or 0 then
                        -- goto next
                        -- end
                        ped.set_ped_into_vehicle(escort[i], escortveh[i], -1)
                        -- ::next::
                        ai.task_combat_ped(escort[i], pped, 0, 16)
                    end
                    return HANDLER_CONTINUE
                end
                for i = 1, #escortveh do
                    entity.set_entity_as_no_longer_needed(escortveh[i])
                    entity.delete_entity(escortveh[i])
                end

                for i = 1, #escort do
                    entity.set_entity_as_no_longer_needed(escort[i])
                    entity.delete_entity(escort[i])
                end

                return HANDLER_POP

            end),
            type = "toggle",
            callback = function()
            end
        }
        features["hunter_taskloop"].feat.on = false
        features["hunter_taskloop"].feat.hidden = false

        -- TODO: World Dump Run Check

        features["World_Dump1"] = {
            feat = menu.add_feature("Dump World on this Cunt!(Frozen)", "action", featureVars.g.id, function(feat)
                if world_dumped then
                    local pos = v3()
                    pos = player.get_player_coords(pid)
                    dumpfreeze_onplayer(pid, pos)
                end
                return HANDLER_POP
            end),
            type = "action"
        }

        features["World_Dump1"] = {
            feat = menu.add_feature("Dump peds n vehicles on player(Un-Frozen)", "action", featureVars.tr.id, function(feat)
                if world_dumped then
                    local pos = v3()
                    pos = player.get_player_coords(pid)
                    dumpfreeze_ped_onplayer(pid, pos)
                end
                return HANDLER_POP
            end),
            type = "action"
        }

        -- TODO: Alkonostlag

        features["alkonost_lag"] = {
            feat = menu.add_feature("Alkonost Lag Area", "action_value_i", featureVars.lag.id, function(feat)
                pped = PlyPed(pid)
                local heading, pos, hash
                heading = player.get_player_heading(pid)
                pos = v3()
                local offset, rot = v3(0.0, 0.0, 0.0), v3(0.0, 0.0, 0.0)
                pos = player.get_player_coords(pid)
                hash = 3929093893
                streaming.request_model(hash)
                while (not streaming.has_model_loaded(hash)) do
                    system.wait(10)
                end
                for y = 1, feat.value do
                    pos.x = pos.x + 1.0
                    alkonost[#alkonost + 1] = vehicle.create_vehicle(hash, pos, heading, true, false)
                end
                streaming.set_model_as_no_longer_needed(hash)

                return HANDLER_POP
            end),
            type = "action_value_i",
            callback = function()
            end
        }
        features["alkonost_lag"].feat.min = 1
        features["alkonost_lag"].feat.max = 100
        features["alkonost_lag"].feat.value = 15

        features["alkonost_lagattach"] = {
            feat = menu.add_feature("Attach Alkonost's to player", "toggle", featureVars.lag.id, function(feat)
                if feat.on then
                    pped = PlyPed(pid)

                    local pos = v3()
                    local offset, rot = v3(0.0, 0.0, 0.0), v3(0.0, 0.0, 0.0)
                    pos = player.get_player_coords(pid)

                    for i = 1, #alkonost do
                        entity.attach_entity_to_entity(alkonost[i], pped, 0, offset, rot, true, true, false, 0, true)
                    end
                    return HANDLER_CONTINUE
                end
                for i = 1, #alkonost do
                    entity.set_entity_as_no_longer_needed(alkonost[i])
                    entity.delete_entity(alkonost[i])
                end

                return HANDLER_POP
            end),
            type = "toggle",
            callback = function()
            end
        }

        -- TODO: kosatkalag

        features["kosatka_lag"] = {
            feat = menu.add_feature("kosatka Lag Area", "action_value_i", featureVars.lag.id, function(feat)
                pped = PlyPed(pid)
                local heading, pos, hash
                heading = player.get_player_heading(pid)
                pos = v3()
                local offset, rot = v3(0.0, 0.0, 0.0), v3(0.0, 0.0, 0.0)
                pos = player.get_player_coords(pid)
                hash = 1336872304
                streaming.request_model(hash)
                while (not streaming.has_model_loaded(hash)) do
                    system.wait(10)
                end
                for y = 1, feat.value do
                    pos.x = pos.x + 1.0
                    kosatka[#kosatka + 1] = vehicle.create_vehicle(hash, pos, heading, true, false)
                    spawned_cunts[#spawned_cunts + 1] = object.create_object(-422877666, pos, true, false)
                    entity.attach_entity_to_entity(spawned_cunts[#spawned_cunts], kosatka[#kosatka], 0, pos, pos, true, true, false, 0, false)
                end
                streaming.set_model_as_no_longer_needed(hash)

                return HANDLER_POP
            end),
            type = "action_value_i",
            callback = function()
            end
        }
        features["kosatka_lag"].feat.min = 1
        features["kosatka_lag"].feat.max = 100
        features["kosatka_lag"].feat.value = 15

        features["kosatka_lagattach"] = {
            feat = menu.add_feature("Attach Kosatka's to player", "toggle", featureVars.lag.id, function(feat)
                if feat.on then
                    pped = PlyPed(pid)

                    local pos = v3()
                    local offset = v3(0.0, 0.0, 0.0)
                    local rot = v3(0.0, 0.0, 0.0)
                    pos = player.get_player_coords(pid)

                    for i = 1, #kosatka do
                        entity.attach_entity_to_entity(kosatka[i], pped, 0, offset, rot, true, true, false, 0, true)
                    end
                    return HANDLER_CONTINUE
                end
                for i = 1, #kosatka do
                    entity.set_entity_as_no_longer_needed(kosatka[i])
                    entity.delete_entity(kosatka[i])
                end

                return HANDLER_POP
            end),
            type = "toggle",
            callback = function()
            end
        }

        -- TODO: Kick System
        featureVars.ses = menu.add_feature("Script Event Spam", "parent", featureVars.k.id)
        features["EventSpam_toggle"] = {
            feat = menu.add_feature("Spam Them ALL!", "toggle", featureVars.ses.id, function(feat)
                if not feat.on then

                    playerFeatures[pid].features["Kick1_Type1"].feat.on = false
                    playerFeatures[pid].features["Kick1_Type2"].feat.on = false
                    playerFeatures[pid].features["Kick1_Type3"].feat.on = false
                    playerFeatures[pid].features["Kick2_Type1"].feat.on = false
                    playerFeatures[pid].features["Kick2_Type2"].feat.on = false
                    playerFeatures[pid].features["Kick2_Type3"].feat.on = false
                    playerFeatures[pid].features["Kick3_Type1"].feat.on = false
                    playerFeatures[pid].features["SE_CRASH_DATA1"].feat.on = false
                    playerFeatures[pid].features["Kick3_Type2"].feat.on = false
                    return HANDLER_POP
                end

            end),
            type = "toggle",
            callback = function()
                playerFeatures[pid].features["Kick1_Type1"].feat.on = true
                playerFeatures[pid].features["Kick1_Type2"].feat.on = true
                playerFeatures[pid].features["Kick1_Type3"].feat.on = true
                playerFeatures[pid].features["Kick2_Type1"].feat.on = true
                playerFeatures[pid].features["Kick2_Type2"].feat.on = true
                playerFeatures[pid].features["Kick2_Type3"].feat.on = true
                playerFeatures[pid].features["Kick3_Type1"].feat.on = true
                playerFeatures[pid].features["SE_CRASH_DATA1"].feat.on = true
                playerFeatures[pid].features["Kick3_Type2"].feat.on = true
                return HANDLER_POP

            end
        }
        features["EventSpam_toggle"].feat.on = false

        features["SE_CRASH_DATA1"] = {
            feat = menu.add_feature("SEKick Custom Arg Count:", "value_i", featureVars.k.id, function(feat)
                local Args = {}
                if feat.on then
                    Args = build_params(feat.value)

                    -- player.unset_player_as_modder(pid, -1)

                    for i = 1, #data do
                        par1 = math.random(-1000, 99999999)
                        par2 = math.random(20000, 99999999)
                        par3 = math.random(-1, 1)
                        par4 = math.random(-1, 9)
                        par5 = math.random(-1, 1)

                        script.trigger_script_event(data[i], pid, Args)
                        --   system.wait(200)				
                        script.trigger_script_event(data[i], pid, Args)
                        --   system.wait(200)	
                        script.trigger_script_event(data[i], pid, Args)
                        -- system.wait(200)				
                        script.trigger_script_event(data[i], pid, {par1, par2, par3, par4, par5, par1, par2, par3, par2})
                        -- system.wait(200)
                        if Settings["ScriptEvent_delay"] ~= 0 then
                            system.yield(Settings["ScriptEvent_delay"])
                        end
                    end

                    return HANDLER_CONTINUE
                end
                return HANDLER_POP
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["SE_CRASH_DATA1"].feat.max = 100
        features["SE_CRASH_DATA1"].feat.min = 1
        features["SE_CRASH_DATA1"].feat.on = false

        features["Kick1_Type1"] = {
            feat = menu.add_feature("Kick Data 1 Type 1", "toggle", featureVars.ses.id, function(feat)
                if feat.on then
                    -- player.unset_player_as_modder(pid, -1)

                    for i = 1, #data do
                        par1 = math.random(-1000, 99999999)
                        par2 = math.random(-1, 9)
                        par3 = math.random(-1, 1)
                        par4 = math.random(-1, 9)
                        par5 = math.random(-1, 1)

                        script.trigger_script_event(data[i], pid, {par3, par5, par2, par3, par2})
                        system.wait(0)
                        script.trigger_script_event(data[i], pid, {par3, par5, par2, par3, par2, par1, par3, par1})
                        if Settings["ScriptEvent_delay"] ~= 0 then
                            system.yield(Settings["ScriptEvent_delay"])
                        end
                    end
                    return HANDLER_CONTINUE
                end
                return HANDLER_POP
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["Kick1_Type1"].feat.on = false

        features["Kick1_Type2"] = {
            feat = menu.add_feature("Kick Data 1 Type 2", "toggle", featureVars.ses.id, function(feat)
                if feat.on then
                    -- player.unset_player_as_modder(pid, -1)

                    for i = 1, #data do

                        par1 = math.random(-1000, 99999999)
                        par2 = math.random(-99999999999999, -9)
                        par3 = math.random(46190868, 999999999)
                        par4 = math.random(-1, 9)
                        par5 = math.random(-99999999999999, -46190868)
                        par6 = math.random(9999999999, 9999999899990868)
                        script.trigger_script_event(data[i], pid, {par3, par5, par2, par3, par2, par1, par3, par1})
                        system.wait(0)
                        script.trigger_script_event(data[i], pid, {par1, par4, par3, par5, par6, par2, par3, par2, par1, par3, par1})
                        if Settings["ScriptEvent_delay"] ~= 0 then
                            system.yield(Settings["ScriptEvent_delay"])
                        end
                    end
                    return HANDLER_CONTINUE
                end
                return HANDLER_POP

            end),
            type = "toggle",
            callback = function()
            end
        }
        features["Kick1_Type2"].feat.on = false

        features["Kick1_Type3"] = {
            feat = menu.add_feature("Kick Data 1 Type 3", "toggle", featureVars.ses.id, function(feat)
                if feat.on then
                    for i = 1, #data do
                        par1 = kick_param_data[math.random(1, #kick_param_data)]
                        par2 = kick_param_data[math.random(1, #kick_param_data)]
                        par3 = kick_param_data[math.random(1, #kick_param_data)]
                        par4 = kick_param_data[math.random(1, #kick_param_data)]
                        par5 = kick_param_data[math.random(1, #kick_param_data)]
                        par6 = kick_param_data[math.random(1, #kick_param_data)]
                        script.trigger_script_event(data[i], pid, {par3, par5, par2, par3, par2, par1, par3, par1})
                        system.wait(0)
                        script.trigger_script_event(data[i], pid, {par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par6, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par6, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par6})
                        system.wait(0)
                        script.trigger_script_event(data[i], pid, {par1, par4, par3, par5, par6, par2, par3, par2, par1, par3, par1})

                        if Settings["ScriptEvent_delay"] ~= 0 then
                            system.yield(Settings["ScriptEvent_delay"])
                        end
                    end

                    return HANDLER_CONTINUE
                end
                return HANDLER_POP

            end),
            type = "toggle",
            callback = function()
            end
        }
        features["Kick1_Type3"].feat.on = false

        features["Kick2_Type1"] = {
            feat = menu.add_feature("Kick Data 2 Type 1", "toggle", featureVars.ses.id, function(feat)
                if feat.on then
                    for i = 1, #data2 do
                        par1 = math.random(-1000, 99999999)
                        par2 = math.random(-1, 9)
                        par3 = math.random(-1, 1)
                        par4 = math.random(-1, 9)
                        par5 = math.random(-1, 1)

                        script.trigger_script_event(data2[i], pid, {par3, par5, par2, par3, par2})
                        if Settings["ScriptEvent_delay"] ~= 0 then
                            system.yield(Settings["ScriptEvent_delay"])
                        end
                    end
                    return HANDLER_CONTINUE
                end
                return HANDLER_POP

            end),
            type = "toggle",
            callback = function()
            end
        }
        features["Kick2_Type1"].feat.on = false

        features["Kick2_Type2"] = {
            feat = menu.add_feature("Kick Data 2 Type 2", "toggle", featureVars.ses.id, function(feat)
                if feat.on then
                    for i = 1, #data2 do
                        par1 = math.random(-1000, 99999999)
                        par2 = math.random(-99999999999999, -9)
                        par3 = math.random(46190868, 999999999)
                        par4 = math.random(-1, 9)
                        par5 = math.random(-99999999999999, -46190868)

                        script.trigger_script_event(data2[i], pid, {par3, par5, par2, par3, par2, par1, par3, par1})
                        if Settings["ScriptEvent_delay"] ~= 0 then
                            system.yield(Settings["ScriptEvent_delay"])
                        end
                    end
                    return HANDLER_CONTINUE
                end
                return HANDLER_POP
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["Kick2_Type2"].feat.on = false

        features["Kick2_Type3"] = {
            feat = menu.add_feature("Kick Data 2 Type 3", "toggle", featureVars.ses.id, function(feat)
                if feat.on then
                    for i = 1, #data2 do

                        par1 = math.random(104574922, 9999999999)
                        par2 = math.random(-99999999999999, -1)
                        par3 = math.random(461908681885, 99999999999999)
                        par4 = math.random(-999999999999, -1)
                        par5 = math.random(9999999999999, 46190868453454)

                        script.trigger_script_event(data2[i], pid, {par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1})
                        system.yield(Settings["ScriptEvent_delay"])
                    end
                    return HANDLER_CONTINUE
                end
                return HANDLER_POP
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["Kick2_Type3"].feat.on = false

        features["Kick3_Type1"] = {
            feat = menu.add_feature("Kick Data 3 Type 1", "toggle", featureVars.ses.id, function(feat)
                if feat.on then
                    for i = 1, #data3 do
                        par1 = math.random(-1000, 99999999)
                        par2 = math.random(-1, 9999999999)
                        par3 = math.random(4904904, 100000000000)
                        par4 = math.random(4000, 9999999)
                        par5 = math.random(-1, 1)

                        script.trigger_script_event(data3[i], pid, {par3, par5, par2, par3, par2})
                        if Settings["ScriptEvent_delay"] ~= 0 then
                            system.yield(Settings["ScriptEvent_delay"])
                        end
                    end
                    return HANDLER_CONTINUE
                end
                return HANDLER_POP

            end),
            type = "toggle",
            callback = function()
            end
        }
        features["Kick3_Type1"].feat.on = false

        features["Kick3_Type2"] = {
            feat = menu.add_feature("Kick Data 3 Type 2", "toggle", featureVars.ses.id, function(feat)
                if feat.on then
                    for i = 1, #data3 do

                        par1 = math.random(-1000, 99999999)
                        par2 = math.random(-99999999999999, -9)
                        par3 = math.random(46190868, 999999999)
                        par4 = math.random(-1, 9)
                        par5 = math.random(-99999999999999, -46190868)

                        script.trigger_script_event(data3[i], pid, {par3, par5, par2, par3, par2, par1, par3, par1})
                        if Settings["ScriptEvent_delay"] ~= 0 then
                            system.yield(Settings["ScriptEvent_delay"])
                        end

                    end
                    return HANDLER_CONTINUE
                end
                return HANDLER_POP
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["Kick3_Type2"].feat.on = false

        features["Kick3_Type3"] = {
            feat = menu.add_feature("Kick from data3 index: ", "value_i", featureVars.ses.id, function(feat)
                if feat.on then
                    -- player.unset_player_as_modder(pid, -1)

                    local i = feat.value

                    par1 = math.random(-1000, 99999999)
                    par2 = math.random(-99999999999999, -9)
                    par3 = math.random(46190868, 999999999)
                    par4 = math.random(-1, 9)
                    par5 = math.random(-99999999999999, -46190868)

                    script.trigger_script_event(data3[i], pid, {-1, par3, par5, par2, par3, -1, par2, par1, par3, par1})
                    if Settings["ScriptEvent_delay"] ~= 0 then
                        system.yield(Settings["ScriptEvent_delay"])
                    end
                    return HANDLER_CONTINUE
                end
                return HANDLER_POP
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["Kick3_Type3"].feat.max = #data3
        features["Kick3_Type3"].feat.min = 1
        features["Kick3_Type3"].feat.value = 1
        features["Kick3_Type3"].feat.mod = 1
        features["Kick3_Type3"].feat.on = false

        features["net-kick"] = {
            feat = menu.add_feature("Network Bail Kick", "action", featureVars.k.id, function(feat)
                -- player.unset_player_as_modder(pid, -1)
                local scid = GetSCID(pid)
                local name = tostring(player.get_player_name(pid))

                script.trigger_script_event(-2120750352, pid, {pid, script.get_global_i(1630317 + (1 + (pid * 595)) + 506)})
                script.trigger_script_event(0xE6116600, pid, {pid, script.get_global_i(1630317 + (1 + (pid * 595)) + 506)})
                script.trigger_script_event(-720040631, pid, {})
                Debug_Out(string.format("Player: " .. name .. " [" .. scid .. "]" .. " Network Bail Kicked"))

            end),
            type = "action",
            callback = function()
            end
        }

        features["net-kick2"] = {
            feat = menu.add_feature("Network Bail Kick ScriptFuck", "action", featureVars.k.id, function(feat)

                script.trigger_script_event(-922075519, pid, {pid, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, -1})
                script.trigger_script_event(-1975590661, pid, {84857178, 61749268, -80053711, -78045655, 56341553, -78686524, -46044922, -22412109, 29388428, -56335450})

                local pos = v3()
                pos = player.get_player_coords(pid)
                pos.x = math.floor(pos.x)
                pos.y = math.floor(pos.y)
                pos.z = math.floor(pos.z)
                local scid = GetSCID(pid)
                local name = tostring(player.get_player_name(pid))
                script.trigger_script_event(-1975590661, pid, {pid, pos.x, pos.y, pos.z, 0, 0, 2147483647, 0, script.get_global_i(1590682 + (pid * 883) + 99 + 28), 1})
                script.trigger_script_event(-1975590661, pid, {pid, pos.x, pos.y, pos.z, 0, 0, 1000, 0, script.get_global_i(1590682 + (pid * 883) + 99 + 28), 1})
                script.trigger_script_event(-2122716210, pid, {91645, -99683, 1788, 60877, 55085, 72028})
                script.trigger_script_event(-2120750352, pid, {pid, script.get_global_i(1630317 + (1 + (pid * 595)) + 506)})
                script.trigger_script_event(-2122716210, pid, {91645, -99683, 1788, 60877, 55085, 72028})
                script.trigger_script_event(0xE6116600, pid, {pid, script.get_global_i(1630317 + (1 + (pid * 595)) + 506)})

                Debug_Out(string.format("Player: " .. name .. " [" .. scid .. "]" .. " Network Bail Kicked"))

            end),
            type = "action",
            callback = function()
            end
        }

        features["SE-kick"] = {
            feat = menu.add_feature("SE Kick", "action", featureVars.k.id, function(feat)

                -- player.unset_player_as_modder(pid, -1)
                local scid = GetSCID(pid)
                script.trigger_script_event(0xB0886E20, pid, {0, 30583, 0, 0, 0, 1061578342, 1061578342, 4})
                script.trigger_script_event(0xB0886E20, pid, {0, 30583, 0, 0, 0, 1061578342, 1061578342, 4})
                script.trigger_script_event(0x9DB77399, pid, {50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 999999999999999, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
                script.trigger_script_event(0x9DB77399, pid, {50, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 999999999999999, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
                local name = tostring(player.get_player_name(pid))
                script.trigger_script_event(0xB0886E20, pid, {-1, 0, 0, 0})
                script.trigger_script_event(0xB0886E20, pid, {0, -1, -1, 0})
                script.trigger_script_event(0x9DB77399, pid, {-1, 0, -1, 0})
                Debug_Out(string.format("Player: " .. name .. " [" .. scid .. "]" .. " Network Bail Kicked"))

            end),
            type = "action",
            callback = function()
            end
        }

        features["SPE-kick"] = {
            feat = menu.add_feature("SPECIAL KICK", "action", featureVars.k.id, function(feat)

                -- player.unset_player_as_modder(pid, -1)
                local scid = GetSCID(pid)
                script.trigger_script_event(0xF5CB92DB, pid, {0, 0, 46190868, 0, 2})
                script.trigger_script_event(0xF5CB92DB, pid, {46190868, 0, 46190868, 46190868, 2})
                script.trigger_script_event(0xF5CB92DB, pid, {1337, -1, 1, 1, 0, 0, 0})
                script.trigger_script_event(0xF5CB92DB, pid, {pid, 1337, -1, 1, 1, 0, 0, 0})
                local name = tostring(player.get_player_name(pid))
                Debug_Out(string.format("Player: " .. name .. " [" .. scid .. "]" .. " Special SE Kicked"))

            end),
            type = "action",
            callback = function()
            end
        }

        features["SEC-kick"] = {
            feat = menu.add_feature("Script Event Crash", "toggle", featureVars.k.id, function(feat)

                if feat.on then

                    par1 = kick_param_data[math.random(1, #kick_param_data)]
                    par2 = kick_param_data[math.random(1, #kick_param_data)]
                    par3 = kick_param_data[math.random(1, #kick_param_data)]
                    par4 = kick_param_data[math.random(1, #kick_param_data)]
                    par5 = kick_param_data[math.random(1, #kick_param_data)]

                    script.trigger_script_event(data[math.random(1, #data)], pid, {pid, par5, par3, par1, par5, par3, par1, par5, par3, pid, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, pid, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1})

                    script.trigger_script_event(data2[math.random(1, #data2)], pid, {pid, par5, par3, par1, par5, par3, par1, par5, par3, pid, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, pid, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1})

                    script.trigger_script_event(data3[math.random(1, #data3)], pid, {pid, par5, par3, par1, par5, par3, par1, par5, par3, pid, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, pid, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1})
                    if Settings["ScriptEvent_delay"] ~= 0 then
                        system.yield(Settings["ScriptEvent_delay"])
                    end
                end
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["SEC-kick"].feat.on = false

        features["Apt_Inv_Spam"] = {
            feat = menu.add_feature("Spam Random Apt Invites", "toggle", featureVars.k.id, function(feat)
                if feat.on then

                    par5 = kick_param_data[math.random(1, #kick_param_data)]

                    script.trigger_script_event(0xf5cb92db, pid, {24, 24, 1, 0, par5, 1, 1, 1})

                    script.trigger_script_event(-171207973, pid, {24, 24, 1, 0, par5, 1, 1, 1})
                    if Settings["ScriptEvent_delay"] ~= 0 then
                        system.yield(Settings["ScriptEvent_delay"])
                    end
                    return HANDLER_CONTINUE
                end
                return HANDLER_POP
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["Apt_Inv_Spam"].feat.on = false

        features["AptInv_Spam"] = {
            feat = menu.add_feature("Disable Players Game & Give God", "action", featureVars.f.id, function(feat)
                if feat.on then

                    par5 = kick_param_data[math.random(1, #kick_param_data)]

                    script.trigger_script_event(0xf5cb92db, pid, {24, 24, 1, 0, 115, 1, 1, 1})
                    script.trigger_script_event(-171207973, pid, {24, 24, 1, 0, 115, 1, 1, 1})
                    if Settings["ScriptEvent_delay"] ~= 0 then
                        system.yield(Settings["ScriptEvent_delay"])
                    end
                    return HANDLER_CONTINUE
                end
                return HANDLER_POP
            end),
            type = "action",
            callback = function()
            end
        }

        features["AptInv_Spam"] = {
            feat = menu.add_feature("Spam Random Apt Invites v2", "toggle", featureVars.k.id, function(feat)
                if feat.on then

                    par5 = math.ceil(math.random(1, 100))

                    script.trigger_script_event(0xf5cb92db, pid, {24, 24, 1, 0, par5, 1, 1, 1})
                    script.trigger_script_event(-171207973, pid, {24, 24, 1, 0, par5, 1, 1, 1})
                    system.yield(6000)
                    return HANDLER_CONTINUE
                end
                return HANDLER_POP
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["AptInv_Spam"].feat.on = false

        features["PSE-Crash"] = {
            feat = menu.add_feature("Script Event Crash / Kick", "toggle", featureVars.k.id, function(feat)
                if feat.on then
                    local event = {-977515445, -2122716210, 767605081, -1949011582, -1882923979, -1975590661, -922075519, 1120313136, -435067392, -171207973, -1212832151, 1317868303, -1054826273, 1620254541, 1401831542, -1491386500, -1070934291, -1949011582, -720040631, 523402757, -1279955769, 162639435, 1331862851, 2086111581, 860051171, -2069242129, -1125804155, -1495195128, 94936514, -751761218, 761687265, 2136412382, 1456429682, 1503592133, -487923362}
                    par1 = kick_param_data[math.random(1, #kick_param_data)]
                    par2 = kick_param_data[math.random(1, #kick_param_data)]
                    par3 = kick_param_data[math.random(1, #kick_param_data)]
                    par4 = kick_param_data[math.random(1, #kick_param_data)]
                    par5 = kick_param_data[math.random(1, #kick_param_data)]
                    for i = 1, #event do
                        script.trigger_script_event(event[i], pid, {-1, par5, par3, par1, par5, par3, par1, par5, par3, pid, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, pid, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1, par5, par3, par1})
                    end
                    if Settings["ScriptEvent_delay"] ~= 0 then
                        system.yield(Settings["ScriptEvent_delay"])
                    end
                    return HANDLER_CONTINUE
                end
                return HANDLER_POP
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["PSE-Crash"].feat.on = false

        features["SE-Crash"] = {
            feat = menu.add_feature("Script Event Crash Player", "toggle", featureVars.k.id, function(feat)
                if feat.on then
                    local Params = build_params(80)
                    for i = 1, #SECrash do
                        script.trigger_script_event(SECrash[i], pid, Params)
                    end
                    if Settings["ScriptEvent_delay"] ~= 0 then
                        system.yield(Settings["ScriptEvent_delay"])
                    end
                    return HANDLER_CONTINUE
                end
                return HANDLER_POP
            end),
            type = "toggle",
            callback = function()
            end
        }
        features["SE-Crash"].feat.on = false

        playerFeatures[pid] = {
            feat = featureVars.f,
            scid = -1,
            features = features
        }
        featureVars.f.hidden = false

    end

    local loop_logsent = false
    loopFeat = menu.add_feature("Loop", "toggle", globalFeatures.moist_tools.id, function(feat)
        if feat.on then

            local Online = network.is_session_started()
            if not Online then
                SessionHost = nil
                ScriptHost = nil
                loop_logsent = false
                Active_menu = nil
            end
            local lpid = player.player_id()
            for pid = 0, 32 do
                playerFeatures[pid].features["blamedorbital"].feat:set_str_data(Playerz)
                pped = PlyPed(pid)
                local tbl = playerFeatures[pid]
                local f = tbl.feat
                local scid = player.get_player_scid(pid)
                SessionPlayers[pid].Scid = scid
                playerFeatures[pid].scid = scid
                if scid ~= 4294967295 then
                    if f.hidden then
                        f.hidden = false
                    end
                    Playerz[pid + 1] = player.get_player_name(pid)

                    local name = player.get_player_name(pid)
                    local toname = ""
                    local isYou = lpid == pid
                    local tags, tagz = {}, {}
                    if Online then
                        if isYou then
                            tags[#tags + 1] = "Y"
                        end
                        if player.is_player_friend(pid) then
                            tags[#tags + 1] = "F"
                        end
                        if player.is_player_host(pid) then
                            tags[#tags + 1] = "H"
                            toname = tostring(toname .. "~h~~b~[H]")
                            if SessionHost ~= pid then
                                SessionHost = pid
                                moist_notify("The session host is now ", (isYou and " you " or name) .. "  ")
                                Debug_Out(string.format("Session Host is Now : " .. (isYou and " you " or name)))
                            end
                        end
                        if pid == script.get_host_of_this_script() then
                            tags[#tags + 1] = "S"
                            toname = tostring(toname .. "~h~~y~[S]")
                            if ScriptHost ~= pid then
                                ScriptHost = pid
                                moist_notify("The script host is now ", (isYou and " you " or name) .. "  ")
                                Debug_Out(string.format("Script Host is Now : " .. (isYou and " you " or name)))
                            end
                        end
                        if player.is_player_playing(pid) and player.is_player_god(pid) then
                            tags[#tags + 1] = "G"
                        end
                        if player.is_player_god(pid) and (tracking.playerped_speed1[pid + 1] >= 28) and Players[pid].isint ~= true then
                            tagz[#tagz + 1] = "~h~~r~[G]"
                            Players[pid].pulse = not Players[pid].pulse
                            if not Players[pid].isgod and pid ~= player.player_id() then
                                ui.notify_above_map("~h~~b~God Mode Player: " .. "\n~y~" .. pid .. " : ~w~ " .. SessionPlayers[pid].Name, "~l~~h~Ω MoistsScript 2.0.3.7\n~r~~h~Modder Detection", 119)
                                Players[pid].isgod = true
                            end

                        end
                        if player.is_player_playing(pid) and player.is_player_vehicle_god(pid) then
                            tags[#tags + 1] = "V"
                        end
                        if player.is_player_vehicle_god(pid) and logsent ~= true then
                            Debug_Out(string.format("Player: " .. name .. " [Vehicle Godmode]"))
                            logsent = true
                        end
                        if player.is_player_vehicle_god(pid) and (tracking.playerped_speed1[pid + 1] >= 28) and Players[pid].isint ~= true then
                            tagz[#tagz + 1] = "~h~~o~[V]"
                            Players[pid].pulse = not Players[pid].pulse
                            if not Players[pid].isvgod and pid ~= player.player_id() then
                                ui.notify_above_map("~h~~b~God Mode Vehicle: " .. "\n~y~" .. pid .. " : ~w~ " .. SessionPlayers[pid].Name, " ~l~~h~Ω MoistsScript 2.0.3.7\n~r~~h~Modder Detection", 119)
                                Players[pid].isvgod = true
                            end

                        end
                        if Players[pid].isint ~= true then
                            if player.is_player_spectating(pid) and player.is_player_playing(pid) then
                                tags[#tags + 1] = ".SPEC."
                            end
                        end
                        if Players[pid].isint == true then
                            Players[pid].pulse = false
                        end

                        if not isYou then
                            if (script.get_global_i(2426097 + (1 + (pid * 443)) + 204) == 1) then
                                tags[#tags + 1] = "O"
                                tagz[#tagz + 1] = "~h~~g~[O]"
                                toname = tostring(toname .. "~h~~g~[O]")
                                if Players[pid].OTRBlipID == nil then
                                    Players[pid].OTRBlipID = ui.add_blip_for_entity(pped)
                                    ui.set_blip_colour(Players[pid].OTRBlipID, 2)
                                end
                            end

                            if (script.get_global_i(2426097 + (1 + (pid * 443)) + 204) == 0) then
                                if Players[pid].OTRBlipID ~= nil then
                                    ui.remove_blip(Players[pid].OTRBlipID)
                                    Players[pid].OTRBlipID = ui.get_blip_from_entity(pped)
                                    ui.remove_blip(Players[pid].OTRBlipID)
                                    Players[pid].OTRBlipID = nil
                                end
                            end
                        end

                        if not player.is_player_modder(pid, -1) then
                            if (player.get_player_health(pid) > 100) and not (player.get_player_max_health(pid) > 0) then
                                tags[#tags + 1] = "U"
                                tagz[#tagz + 1] = "~h~~q~[U]"
                                -- toname = tostring(toname .. "~h~~q~[U]")
                            end
                        end
                        if Players[pid].bounty then
                            tags[#tags + 1] = "[B:" .. Players[pid].bountyvalue .. "]"
                            tagz[#tagz + 1] = "~h~~p~[B: " .. Players[pid].bountyvalue .. "]"
                            -- toname = tostring(toname .. "~h~~p~[B: " .. Players[pid].bountyvalue .. "]")
                        end
                        if player.is_player_modder(pid, -1) then
                            tags[#tags + 1] = "M"
                            RAC_OFF(pid)

                            modderflag(pid)

                        elseif not player.is_player_modder(pid, -1) then
                            Modders_DB[pid].ismod = false
                        end
                        if tbl.scid ~= scid then
                            for cf_name, cf in pairs(tbl.features) do
                                if cf.type == "toggle" and cf.feat.on then
                                    cf.feat.on = false
                                end
                            end
                            tbl.scid = scid
                            if not isYou then
                                -- TODO: Modder shit

                            end

                        end
                    end
                    if player.is_player_host(pid) or pid == script.get_host_of_this_script() then
                        SessionPlayers[pid].Name = name .. " " .. toname
                        system.wait(100)
                        if #tagz > 0 then
                            SessionPlayers[pid].Name = name .. " " .. toname .. table.concat(tagz)
                        end
                    else
                        SessionPlayers[pid].Name = name
                        system.wait(100)
                        if #tagz > 0 then
                            SessionPlayers[pid].Name = name .. " " .. table.concat(tagz)
                        end
                    end

                    if #tags > 0 then
                        name = name .. " [" .. table.concat(tags) .. "]"

                    end
                    if f.name ~= name then
                        f.name = name
                    end
                    for cf_name, cf in pairs(tbl.features) do
                        if (cf.type ~= "toggle" or cf.feat.on) and cf.callback then
                            local status, err = pcall(cf.callback)
                            if not status then
                                moist_notify("Error running feature " .. i, "\non pid " .. pid)
                                Print(status .. err)
                            end
                        end
                    end
                else
                    if not f.hidden then
                        f.hidden = true
                        for cf_name, cf in pairs(tbl.features) do
                            if cf.type == "toggle" and cf.feat.on then
                                cf.feat.on = false
                            end
                        end
                    end
                    Playerz[pid + 1] = string.format("Player " .. pid)
                end
            end
            system.yield(Settings["playerlist_loop"])
            return HANDLER_CONTINUE
        end
        for i = 0, 32 do
            playerFeatures[i].feat.hidden = false
        end
        return HANDLER_POP
    end)
    loopFeat.hidden = false
    loopFeat.on = true

    Debug_Out("MoistScript Playerlist Loop executed")
end
ScriptLocals["playerlist"]()

function OnlineResetCheck()
    for pid = 0, 32 do
        if player.is_player_valid(pid) ~= false then
            playerRDB(pid)
        end
        interiorcheckpid(pid)
        God_Check_pid(pid)
        God_Check1_pid(pid)
    end
end
OnlineResetCheck()