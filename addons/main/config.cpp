#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "cba_main",
            "cba_xeh",
            "ace_interact_menu",
            "task_force_radio"
        };
        author = "johnb43";
        authors[] = {"johnb43", "Chatter", "M3ales", "Tirpitz93"};
        url = "https://github.com/johnb432/ACE-TFAR-Setter-Extended";
        VERSION_CONFIG;
    };
};

#include "CfgVehicles.hpp"
#include "CfgEventHandlers.hpp"

/*
    TFAR radio settings (array):
    0: active channel <NUMBER>
    1: Volume <NUMBER>
    2: Frequencies for channels <ARRAY>
    3: Stereo setting <NUMBER>
    4: Encryption code <STRING>
    5: Additional active channel <NUMBER>
    6: Additional active channel stereo mode <NUMBER>
    7: Owner's UID <STRING>
    8: Speaker mode <NUMBER>
    9: turned on <BOOL>
*/

/*
    Profile: [[], [], [], false]:
    0: SR settings (from TFAR_fnc_getSwSettings; see above for layout)
    1: LR settings (from TFAR_fnc_getLrSettings; see above for layout)
    2: VLR settings (from TFAR_fnc_getLrSettings; see above for layout)
    3: Headset status (from missionNamespace getVariable ["TFAR_core_isHeadsetLowered", false])
*/
