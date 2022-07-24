require("ZeroMenuLib/Options/modderDetection")
require("ZeroMenuLib/Options/Vehicles")
require("ZeroMenuLib/Options/Nearby")
require("ZeroMenuLib/Options/Self")
require("ZeroMenuLib/Options/Grief")
require("ZeroMenuLib/Options/Protection")
require("ZeroMenuLib/Options/ChatCommands")
require("ZeroMenuLib/Options/World")

require("ZeroMenuLib/util/config")

require("ZeroMenuLib/enums/VehicleHash")


local ignoreplayers
configpath = os.getenv("APPDATA") .. "\\PopstarDevs\\2Take1Menu\\scripts\\ZeroMenuLib\\data\\config.cfg"

function zeroMenuMain()

  config = Config:create(configpath)

-- Main Feature
	zeroMenu = menu.add_feature("ZeroMenu", "parent", 0, nil)	
	--load Settings
	loadSetting(zeroMenu,config)
	--load Vehicle Options
	loadVehicleMenu(zeroMenu,config)	
	--Load Modder Detection	
	createModderDetectionMenuEntry(zeroMenu,config)
	--Load Nearby
	createNearbyMenu(zeroMenu,config)
		
	createSelfMenuEntry(zeroMenu,config)
	
  createGriefEntry(config)
  
  createProtectionMenu(zeroMenu,config)
	
	createWorldMenu(zeroMenu,config)
	
	createChatCommands(zeroMenu,config)
	
end

function loadSetting(parent,config)
  settings = menu.add_feature("Settings", "parent",parent.id, nil)
  settings.threaded = false
  --Nearby Settings  
  loadNearbySettings(settings,config)
  loadVehicleSetting(settings,config)
  
  settings = menu.add_feature("Save", "action",settings.id, 
  function()
    config.saveConfig()
    ui.notify_above_map("saving config","ZeroMenu",140)
  end)
end
zeroMenuMain()