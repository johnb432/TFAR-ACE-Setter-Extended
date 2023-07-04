#include "script_component.hpp"

GVAR(crewStatus) = GVAR(crewStatusDefault);

// Add radio range sorting
[[[5, 12], []], QGVAR(radioRangeSort), "Sort by radio range", {
    params ["_itemCfg"];

    // If the LR is disabled, filter it out immediately; However, SRs don't have it, so check if config entry exists
    if (isNumber (_itemCfg >> "tf_hasLRradio") && {getNumber (_itemCfg >> "tf_hasLRradio") == 0}) exitWith {0};

    getNumber (_itemCfg >> "tf_range")
}] call ace_arsenal_fnc_addSort;

// If not multiplayer, exit
if (!isMultiplayer) exitWith {};

#include "EventHandlersArsenal.sqf"

// Add changed unit EH; This also triggers on respawn
["unit", {
    params ["_newUnit", "_oldUnit"];

    if (!isNull _oldUnit) then {
        private _ehIDs = _oldUnit getVariable QGVAR(vehicleEhIDs);

        // Remove old EH
        if (!isNil "_ehIDs") then {
            _ehIDs params ["_getInEhID", "_switchSeatEhID", "_getOutEhID"];

            _oldUnit removeEventHandler ["GetInMan", _getInEhID];
            _oldUnit removeEventHandler ["SeatSwitchedMan", _switchSeatEhID];
            _oldUnit removeEventHandler ["GetOutMan", _getOutEhID];

            _oldUnit setVariable [QGVAR(vehicleEhIDs), nil];
        };

        if (!GVAR(enableArsenalAutoSettings)) exitWith {};

        // On respawn
        private _data = _oldUnit getVariable [QGVAR(radioLoadout), [[], [], [], false]];

        if (isNil "_data" || {_data isEqualTo [[], [], [], false]}) exitWith {};

        // Load the SW settings when a SW is detected; However, there is a 10s timeout timer, in case a SW is never found
        [{
           call TFAR_fnc_haveSWRadio
        }, {
            _this params ["_SR", "", "", "_headset"];

            if (_SR isNotEqualTo []) then {
                [call FUNC(activeSwRadio), _SR] call TFAR_fnc_setSwSettings;
            };

            _headset call TFAR_fnc_setHeadsetLowered;
        }, _data, 10] call CBA_fnc_waitUntilAndExecute;

        // Load the LR settings when a LR is detected; However, there is a 10s timeout timer, in case a LR is never found
        [{
           !isNil {(_this select 1) call TFAR_fnc_backpackLR}
        }, {
            (_this select 0) params ["", "_LR", "", "_headset"];

            if (_LR isNotEqualTo []) then {
                [(_this select 1) call TFAR_fnc_backpackLR, _LR] call TFAR_fnc_setLrSettings;
            };

            _headset call TFAR_fnc_setHeadsetLowered;
        }, [_data, _newUnit], 10] call CBA_fnc_waitUntilAndExecute;
    };

    _newUnit call FUNC(eventHandlersVehicle);
}, true] call CBA_fnc_addPlayerEventHandler;

// Zeus actions
[
    ["ACE_ZeusActions"], [
        QGVAR(radiosCurator), // Action name
        localize "STR_TFAR_CORE_RADIOS", // Display name
        "z\tfar\addons\core\ui\ACE_Interaction_Radio_Icon.paa", // Icon
        {}, // Statement
        { // Condition
            TFAR_currentUnit call TFAR_fnc_isForcedCurator && {(TFAR_currentUnit call TFAR_fnc_radiosList) isNotEqualTo [] || (TFAR_currentUnit call TFAR_fnc_LRRadiosList) isNotEqualTo []};
        },
        { // Children actions
            private _unit = TFAR_currentUnit;

            // Add Stereo actions
            private _actions = _unit call TFAR_core_fnc_getOwnRadiosChildren;

            // Add Save actions
            _actions pushBack [[
                QGVAR(radiosCuratorSave),
                "Save",
                ICON_SAVE,
                {},
                {GVAR(enableSRInteractions) || GVAR(enableLRInteractions)},
                {
                    private _unit = _this select 2;
                    private _actions = _unit call FUNC(interactSaveSR);
                    private _radioType = "";

                    _actions append ((_unit call TFAR_fnc_LRRadiosList) apply {
                        _radioType = typeOf (_x select 0);

                        [[
                            format [QGVAR(radiosCuratorInteractSaveLR_%1), _radioType],
                            [_radioType, "displayName"] call TFAR_fnc_getVehicleConfigProperty,
                            [_radioType, "picture"] call TFAR_fnc_getVehicleConfigProperty,
                            {},
                            {GVAR(enableLRInteractions)},
                            {
                                private _args = _this select 2;

                                [_args select 0, [false, true, false], nil, nil, _args select 1] call FUNC(profileMenusSave);
                            },
                            [_unit, _x]
                        ] call ace_interact_menu_fnc_createAction, [], _unit];
                    });

                    _actions
                },
                _unit
            ] call ace_interact_menu_fnc_createAction, [], _unit];

            // Add Load actions
            _actions pushBack [[
                QGVAR(radiosCuratorLoad),
                "Load",
                ICON_LOAD,
                {},
                {GVAR(enableSRInteractions) || GVAR(enableLRInteractions)},
                {
                    private _unit = _this select 2;
                    private _actions = _unit call FUNC(interactLoadSR);
                    private _radioType = "";

                    _actions append ((_unit call TFAR_fnc_LRRadiosList) apply {
                        _radioType = typeOf (_x select 0);

                        [[
                            format [QGVAR(radiosCuratorInteractLoadLR_%1), _radioType],
                            [_radioType, "displayName"] call TFAR_fnc_getVehicleConfigProperty,
                            [_radioType, "picture"] call TFAR_fnc_getVehicleConfigProperty,
                            {},
                            {GVAR(enableLRInteractions)},
                            {
                                private _args = _this select 2;

                                [_args select 0, [false, true, false], nil, nil, _args select 1] call FUNC(profileMenusLoad);
                            },
                            [_unit, _x]
                        ] call ace_interact_menu_fnc_createAction, [], _unit];
                    });

                    _actions
                },
                _unit
            ] call ace_interact_menu_fnc_createAction, [], _unit];

            // Add Profile actions
            _actions pushBack [[
                QGVAR(radiosCuratorDeleteProfile),
                "Delete Profile",
                ICON_DELETE,
                {DELETE_PROFILE spawn FUNC(selectProfileGUI)},
                {GETPRVAR(QGVAR(profileNames),[]) isNotEqualTo []}
            ] call ace_interact_menu_fnc_createAction, [], _unit];

            _actions pushBack [[
                QGVAR(radiosCuratorNewProfile),
                "Create/Import Profile",
                ICON_ADD,
                {[] spawn FUNC(createProfileGUI)},
                {true}
            ] call ace_interact_menu_fnc_createAction, [], _unit];

            _actions pushBack [[
                QGVAR(radiosCuratorExportProfile),
                "Export Profile",
                ICON_ADD,
                {EXPORT_PROFILE spawn FUNC(selectProfileGUI)},
                {GETPRVAR(QGVAR(profileNames),[]) isNotEqualTo []}
            ] call ace_interact_menu_fnc_createAction, [], _unit];

            _actions
        }
    ] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToZeus;
