local a={}a[0]="OBJECT_ID_FREED_EVENT"a[1]="OBJECT_ID_REQUEST_EVENT"a[2]="ARRAY_DATA_VERIFY_EVENT"a[3]="SCRIPT_ARRAY_DATA_VERIFY_EVENT"a[4]="REQUEST_CONTROL_EVENT"a[5]="GIVE_CONTROL_EVENT"a[6]="WEAPON_DAMAGE_EVENT"a[7]="REQUEST_PICKUP_EVENT"a[8]="REQUEST_MAP_PICKUP_EVENT"a[9]="GAME_CLOCK_EVENT"a[10]="GAME_WEATHER_EVENT"a[11]="RESPAWN_PLAYER_PED_EVENT"a[12]="GIVE_WEAPON_EVENT"a[13]="REMOVE_WEAPON_EVENT"a[14]="REMOVE_ALL_WEAPONS_EVENT"a[15]="VEHICLE_COMPONENT_CONTROL_EVENT"a[16]="FIRE_EVENT"a[17]="EXPLOSION_EVENT"a[18]="START_PROJECTILE_EVENT"a[19]="UPDATE_PROJECTILE_TARGET_EVENT"a[21]="BREAK_PROJECTILE_TARGET_LOCK_EVENT"a[20]="REMOVE_PROJECTILE_ENTITY_EVENT"a[22]="ALTER_WANTED_LEVEL_EVENT"a[23]="CHANGE_RADIO_STATION_EVENT"a[24]="RAGDOLL_REQUEST_EVENT"a[25]="PLAYER_TAUNT_EVENT"a[26]="PLAYER_CARD_STAT_EVENT"a[27]="DOOR_BREAK_EVENT"a[28]="SCRIPTED_GAME_EVENT"a[29]="REMOTE_SCRIPT_INFO_EVENT"a[30]="REMOTE_SCRIPT_LEAVE_EVENT"a[31]="MARK_AS_NO_LONGER_NEEDED_EVENT"a[32]="CONVERT_TO_SCRIPT_ENTITY_EVENT"a[33]="SCRIPT_WORLD_STATE_EVENT"a[40]="INCIDENT_ENTITY_EVENT"a[34]="CLEAR_AREA_EVENT"a[35]="CLEAR_RECTANGLE_AREA_EVENT"a[36]="NETWORK_REQUEST_SYNCED_SCENE_EVENT"a[37]="NETWORK_START_SYNCED_SCENE_EVENT"a[39]="NETWORK_UPDATE_SYNCED_SCENE_EVENT"a[38]="NETWORK_STOP_SYNCED_SCENE_EVENT"a[41]="GIVE_PED_SCRIPTED_TASK_EVENT"a[42]="GIVE_PED_SEQUENCE_TASK_EVENT"a[43]="NETWORK_CLEAR_PED_TASKS_EVENT"a[44]="NETWORK_START_PED_ARREST_EVENT"a[45]="NETWORK_START_PED_UNCUFF_EVENT"a[46]="NETWORK_SOUND_CAR_HORN_EVENT"a[47]="NETWORK_ENTITY_AREA_STATUS_EVENT"a[48]="NETWORK_GARAGE_OCCUPIED_STATUS_EVENT"a[49]="PED_CONVERSATION_LINE_EVENT"a[50]="SCRIPT_ENTITY_STATE_CHANGE_EVENT"a[51]="NETWORK_PLAY_SOUND_EVENT"a[52]="NETWORK_STOP_SOUND_EVENT"a[53]="NETWORK_PLAY_AIRDEFENSE_FIRE_EVENT"a[54]="NETWORK_BANK_REQUEST_EVENT"a[55]="NETWORK_AUDIO_BARK_EVENT"a[56]="REQUEST_DOOR_EVENT"a[58]="NETWORK_TRAIN_REQUEST_EVENT"a[57]="NETWORK_TRAIN_REPORT_EVENT"a[59]="NETWORK_INCREMENT_STAT_EVENT"a[60]="MODIFY_VEHICLE_LOCK_WORD_STATE_DATA"a[61]="MODIFY_PTFX_WORD_STATE_DATA_SCRIPTED_EVOLVE_EVENT"a[62]="REQUEST_PHONE_EXPLOSION_EVENT"a[63]="REQUEST_DETACHMENT_EVENT"a[64]="KICK_VOTES_EVENT"a[65]="GIVE_PICKUP_REWARDS_EVENT"a[66]="NETWORK_CRC_HASH_CHECK_EVENT"a[67]="BLOW_UP_VEHICLE_EVENT"a[68]="NETWORK_SPECIAL_FIRE_EQUIPPED_WEAPON"a[69]="NETWORK_RESPONDED_TO_THREAT_EVENT"a[70]="NETWORK_SHOUT_TARGET_POSITION"a[71]="VOICE_DRIVEN_MOUTH_MOVEMENT_FINISHED_EVENT"a[72]="PICKUP_DESTROYED_EVENT"a[73]="UPDATE_PLAYER_SCARS_EVENT"a[74]="NETWORK_CHECK_EXE_SIZE_EVENT"a[75]="NETWORK_PTFX_EVENT"a[76]="NETWORK_PED_SEEN_DEAD_PED_EVENT"a[77]="REMOVE_STICKY_BOMB_EVENT"a[78]="NETWORK_CHECK_CODE_CRCS_EVENT"a[79]="INFORM_SILENCED_GUNSHOT_EVENT"a[80]="PED_PLAY_PAIN_EVENT"a[81]="CACHE_PLAYER_HEAD_BLEND_DATA_EVENT"a[82]="REMOVE_PED_FROM_PEDGROUP_EVENT"a[83]="REPORT_MYSELF_EVENT"a[84]="REPORT_CASH_SPAWN_EVENT"a[85]="ACTIVATE_VEHICLE_SPECIAL_ABILITY_EVENT"a[86]="BLOCK_WEAPON_SELECTION"a[87]="NETWORK_CHECK_CATALOG_CRC"local b={}function b.GetEventName(c)return a[c]or"Unknown ("..c..")"end;return b