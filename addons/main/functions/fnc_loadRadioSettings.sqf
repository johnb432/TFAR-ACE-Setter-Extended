#include "script_component.hpp"
/*
 * Authors: johnb43
	* Loads select radio configurations from a chosen profile.
 *
 * Arguments:
 * 0: Which radios should be loaded <ARRAY>
	* 1: Load other type of radio (only works for LR and VLR) <BOOLEAN>
	* 2: Which profile is selected <STRING>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_loadFromRadios", "_loadSameType", "_profile"];
_loadFromRadios params ["_doSR", "_doLR", "_doVLR"];

GETPRVAR(FORMAT_1(QGVAR(profile%1),_profile),[]) params ["_SR", "_LR", "_VLR", "_headsetStatus"];

private _text = "SR";

// For SR
if (_doSR) then {
				// Don't load anything if nothing is present
				if (_SR isEqualTo []) exitWith {};

				[call TFAR_fnc_activeSwRadio, _SR] call TFAR_fnc_setSwSettings;
};

if (_doLR) then {
				// Don't load anything if nothing is present
				if (_LR isEqualTo []) exitWith {};

				// If loading from a LR to a LR, saveSameType == true, if loading from VLR to LR, then not
				[[player call TFAR_fnc_vehicleLR, player call TFAR_fnc_backpackLR] select _loadSameType, _LR] call TFAR_fnc_setLrSettings;

				// Change text accordingly
				_text = ["LR", "SR and LR"] select _doSR;
};

if (_doVLR) then {
				// Don't load anything if nothing is present
				if (_VLR isEqualTo []) exitWith {};

				// If loading from a VLR to a VLR, saveSameType == true, if loading from LR to VLR, then not
				[[player call TFAR_fnc_backpackLR, player call TFAR_fnc_vehicleLR] select _loadSameType, _VLR] call TFAR_fnc_setLrSettings;

				// Change text accordingly
				_text = [[["VLR", "SR and VLR"] select _doSR, "LR and VLR"] select _doLR, "SR, LR and VLR"] select (_doSR && _doLR);
};

// Set the headset up or down
if (!isNil "_headsetStatus") then {
				_headsetStatus call TFAR_fnc_setHeadsetLowered;
};

[format ["Loaded %1 settings from %2", _text, _profile], ICON_LOAD] call ace_common_fnc_displayTextPicture;
