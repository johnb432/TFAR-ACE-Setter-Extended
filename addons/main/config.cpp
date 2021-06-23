#include "script_component.hpp"

class CfgPatches {
				class ADDON {
								name = COMPONENT_NAME;
								author = "johnb43";
								authors[] = {"johnb43", "Chatter", "M3ales", "Tirpitz93"};
								//url = "https://github.com/RTO-Chatter/CHTR_TFAR_QoL";
								requiredAddons[] = {
												"cba_settings",
												"ace_interact_menu",
												"task_force_radio",
												"zen_main"
								};
								units[] = {};
								weapons[] = {};
				};
};

class CfgMods {
    class PREFIX {
        name = "TFAR - ACE Radio Setter - Extended";
        hideName = 1;
        actionName = "GitHub";
        //action = "https://github.com/johnb432/Zeus-Additions";
        description = "TFAR - ACE Radio Setter - Extended";
    };
};

#include "CfgVehicles.hpp"
#include "CfgEventHandlers.hpp"
