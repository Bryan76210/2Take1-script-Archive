commandList = {
	["repair"] = "local.vehicle_options.repair",
	["fix"] = "local.vehicle_options.repair",
	["upgrade"] = "local.vehicle_options.upgrade",
	["flip"] = "local.vehicle_options.flip",
	["vehgod"] = "local.vehicle_options.god",
	["vehicledemi"] = "local.vehicle_options.demi_god",
	["vehicledemigod"] = "local.vehicle_options.demi_god",
	["autorepair"] = "local.vehicle_options.auto_repair",
	["keepitrunning"] = "local.vehicle_options.keep_it_running",
	["upgradeperformance"] = "local.vehicle_options.performance_upgrade",
	["performanceupgrade"] = "local.vehicle_options.performance_upgrade",
	["sticktoground"] = "local.vehicle_options.stick_to_ground",
	["invisveh"] = "local.vehicle_options.invisible",
	["invisvehicle"] = "local.vehicle_options.invisible",
	["boost"] = "local.vehicle_options.boost",
	["superdrive"] = "local.vehicle_options.super_drive",
	["hornjump"] = "local.vehicle_options.horn_jump",
	["hornboost"] = "local.vehicle_options.horn_boost",
	["stopveh"] = "local.vehicle_options.stop",
	["stopvehicle"] = "local.vehicle_options.stop",
	["stop"] = "local.vehicle_options.stop",
	["rainbow"] = "local.vehicle_options.rainbow",
	["rgbveh"] = "local.vehicle_options.rainbow",
	["deformation"] = "local.vehicle_options.deformation",
	["acceleration"] = "local.vehicle_options.acceleration",
	["upshiftrate"] = "local.vehicle_options.up_shift_rate",
	["brakeforce"] = "local.vehicle_options.brake_force",
	["traction"] = "local.vehicle_options.traction",
	["suspension"] = "local.vehicle_options.suspension_force",
	["gravity"] = "local.vehicle_options.gravity",
	["nolockon"] = "local.vehicle_options.prevent_lock_on",
	["preventlockon"] = "local.vehicle_options.prevent_lock_on",
	["noboostrecharge"] = "local.vehicle_options.instant_boost_recharge",
	["infiniterockets"] = "local.vehicle_options.infinite_rockets",
	["infinitecounter"] = "local.vehicle_options.infinite_countermeasures",
	["changeplate"] = "local.vehicle_options.change_license",
	["nocollision"] = "local.vehicle_options.no_collision",
	["markvehicle"] = "local.vehicle_options.mark_vehicle",
	["opendoors"] = "local.vehicle_options.door_control.open_all",
	["closedoors"] = "local.vehicle_options.door_control.open_all",
	["godmode"] = "local.player_options.god",
	["demigod"] = "local.player_options.demi_god",
	["quickregen"] = "local.player_options.quick_regen",
	["givehealth"] = "local.player_options.give_health",
	["clean"] = "local.player_options.clean",
	["autoclean"] = "local.player_options.auto_clean",
	["lawless"] = "local.player_options.lawless_mode",
	["invis"] = "local.player_options.invisible",
	["localvisible"] = "local.player_options.player_visible_locally",
	["antinpc"] = "local.player_options.anti_npc",
	["superrun"] = "local.player_options.super_run",
	["runspeed"] = "local.player_options.run_speed",
	["swimspeed"] = "local.player_options.swim_speed",
	["superjump"] = "local.player_options.super_jump",
	["superflight"] = "local.player_options.super_flight",
	["explosivemelee"] = "local.player_options.explosive_melee",
	["seatbelt"] = "local.player_options.seatbelt",
	["noragdoll"] = "local.player_options.no_ragdoll",
	["infinitestamina"] = "local.player_options.infinite_stamina",
	["clonebodyguard"] = "local.player_options.clone_bodyguard",
	["tinyplayer"] = "local.player_options.tiny_player",
	["damagemod"] = "local.player_options.damage_mod",
	["meleedamage"] = "local.player_options.melee_damage_mod",
	["vehicledamage"] = "local.player_options.vehicle_damage_mod",
	["airwalk"] = "local.player_options.air_walk",
	["onfire"] = "local.player_options.on_fire",
	["suicide"] = "local.player_options.suicide",
	["pausetime"] = "local.weather_and_time.pause_clock",
	["sethour"] = "local.weather_and_time.set_hour",
	["setmin"] = "local.weather_and_time.set_minute",
	["quickreload"] = "local.weapons.weapon_modifiers.quick_reload",
	["infiniteammo"] = "local.weapons.weapon_modifiers.infinite_ammo",
	["noreload"] = "local.weapons.weapon_modifiers.no_reload",
	["rapidfire"] = "local.weapons.weapon_modifiers.rapid_fire",
	["nospinup"] = "local.weapons.weapon_modifiers.no_spin_up",
	["explosiveammo"] = "local.weapons.weapon_modifiers.explosive_ammo",
	["fireammo"] = "local.weapons.weapon_modifiers.fire_ammo",
	["ammo"] = "local.weapons.refill_ammo",
	["refillammo"] = "local.weapons.refill_ammo",
	["autorefillammo"] = "local.weapons.auto_refill_ammo",
	["teleportgun"] = "local.weapons.teleport_gun",
	["tpgun"] = "local.weapons.teleport_gun",
	["vehiclegun"] = "local.weapons.vehicle_gun",
	["driveby"] = "local.weapons.drive_by_with_two_handed_weapons",
	["nospread"] = "local.aim_assist.no_spread",
	["norecoil"] = "local.aim_assist.no_recoil",
	["triggerbot"] = "local.aim_assist.triggerbot",
	["aimbot"] = "local.aim_assist.aimbot",
	["aimbotfov"] = "local.aim_assist.aimbot_fov",
	["skipcutscene"] = "local.misc.skip_cutscene",
	["modeljesus"] = "local.model_changer.misc.jesus",
	["manager"] = "online.business.enable_manager",
	["playeresp"] = "online.esp.player_options.enable_esp",
	["esponself"] = "online.esp.player_options.esp_on_self",
	["radar"] = "online.radar.enable_radar",
	["searchfriends"] = "online.fake_friends.search",
	["redirect"] = "online.join_redirect.join_redirect",
	["redirectscid"] = "online.join_redirect.scid_input",
	["timeout"] = "online.join_timeout.enable",
	["timeoutall"] = "online.join_timeout.block_all",
	["insurancefraud"] = "online.services.personal_vehicles.claim_all_destroyed_vehicles",
	["returnvehicle"] = "online.services.personal_vehicles.return_current_vehicle",
	["currentvehicle"] = "online.services.personal_vehicles.request_current_vehicle",
	["otr"] = "online.services.off_the_radar",
	["offtheradar"] = "online.services.off_the_radar",
	["airstrike"] = "online.services.request_airstrike",
	["helibackup"] = "online.services.request_heli_backup",
	["helipickup"] = "online.services.request_heli_pickup",
	["ammodrop"] = "online.services.request_ammo_drop",
	["minigun"] = "online.services.request_minigun",
	["bst"] = "online.services.bull_shark_testosterone",
	["removeceoban"] = "online.services.remove_ceo_ban",
	["bail"] = "online.lobby.bail_netsplit",
	["joinlobby"] = "online.lobby.join_new_lobby",
	["scidjoin"] = "online.lobby.scid_join",
	["fastjoin"] = "online.lobby.speed_up_joining",
	["scripthost"] = "online.lobby.force_script_host",
	["clearentities"] = "online.lobby.clear_area.clear_entities_in_radius",
	["massinterrupt"] = "online.lobby.mass_player_interrupt",
	["explodeall"] = "online.all_players.explode",
	["explodeallblamed"] = "online.all_players.explode_blamed",
	["giveweapons"] = "online.all_players.give_all_weapon",
	["removeweapons"] = "online.all_players.remove_all_weapons",
	["revealotr"] = "online.all_players.force_reveal_otr_players",
	["prison"] = "online.all_players.prison.teleport_self_to_prison",
	["buildprison"] = "online.all_players.prison.build_prison",
	["alltoprison"] = "online.all_players.prison.teleport_targets_to_prison",
	["vehiclekickall"] = "online.all_players.vehicle_kick",
	["ceobanall"] = "online.all_players.dismiss_ceo",
	["killallpassive"] = "online.all_players.kill_all_passive",
	["kickall"] = "online.all_players.kick_all",
	["crashall"] = "online.all_players.crash_all",
}

for k,v in pairs(commandList) do
	commandList[k] = menu.get_feature_by_hierarchy_key(v)
end