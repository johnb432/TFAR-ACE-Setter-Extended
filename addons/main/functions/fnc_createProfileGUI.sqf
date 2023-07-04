#include "script_component.hpp"

/*
 * Author: johnb43
 * Creates the UI for making a new profile.
 * See https://community.bistudio.com/wiki/ctrlCreate, example 5 as main source.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] spawn tfar_ace_extended_main_fnc_createProfileGUI;
 *
 * Public: No
 */

disableSerialization;

private _calc = (safezoneW / safezoneH) min 1.2;
private _xOff = safezoneX + (safezoneW - _calc) / 2;
private _yOff = safezoneY + (safezoneH - (_calc / 1.2)) / 2;
private _wOff = _calc / 40;
private _hOff = _calc / 30; // (_calc / 1.2) / 25

// Open in Zeus interface if needed
private _displayParent = findDisplay IDD_RSCDISPLAYCURATOR;

if (isNull _displayParent) then {
    _displayParent = findDisplay IDD_MISSION;
};

// Display creation
private _display = _displayParent createDisplay "RscDisplayEmpty";

// Create group control
private _ctrlGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
_ctrlGroup ctrlSetPosition [POS_X(13), POS_Y(8), POS_W(16.7), POS_H(8)];
_ctrlGroup ctrlCommit 0;

// Title background
private _ctrlBackgroundTitle = _display ctrlCreate ["RscTextMulti", -1, _ctrlGroup];
_ctrlBackgroundTitle ctrlSetText "CREATE/IMPORT RADIO PRESET";
_ctrlBackgroundTitle ctrlSetPosition [0, 0, POS_W(16.7), POS_H(1)];
_ctrlBackgroundTitle ctrlSetBackgroundColor [GETPRVAR("GUI_BCG_RGB_R",0.13), GETPRVAR("GUI_BCG_RGB_G",0.54), GETPRVAR("GUI_BCG_RGB_B",0.21), GETPRVAR("GUI_BCG_RGB_A",0.8)];
_ctrlBackgroundTitle ctrlEnable false;
_ctrlBackgroundTitle ctrlCommit 0;

// Main background
private _ctrlBackground = _display ctrlCreate ["RscTextMulti", -1, _ctrlGroup];
_ctrlBackground ctrlSetPosition [0, POS_Y(1.1), POS_W(16.7), POS_H(3.4)];
_ctrlBackground ctrlSetBackgroundColor [0, 0, 0, 0.5];
_ctrlBackground ctrlEnable false;
_ctrlBackground ctrlCommit 0;

// Edit boxes and their backgrounds
private _ctrlEditName = _display ctrlCreate ["RscEdit", IDD_EDIT_BOX_NAME, _ctrlGroup];
_ctrlEditName ctrlSetPosition [POS_X(9), POS_Y(1.5), POS_W(10.5), POS_H(1.2)];
_ctrlEditName ctrlSetBackgroundColor [0, 0, 0, 0.6];
_ctrlEditName ctrlCommit 0;

private _ctrlBackgroundName = _display ctrlCreate ["RscTextMulti", -1, _ctrlGroup];
_ctrlBackgroundName ctrlSetPosition [POS_X(4), POS_Y(1.5), POS_W(4.9), POS_H(1.2)];
_ctrlBackgroundName ctrlSetBackgroundColor [0, 0, 0, 0.6];
_ctrlBackgroundName ctrlSetText "Preset name:";
_ctrlBackgroundName ctrlSetTooltip "Allows you to store multiple radio presets. Whitespaces will be removed. Profiles names are case insensitive. DO NOT USE PUNCTUATION MARKS.";
_ctrlBackgroundName ctrlEnable false;
_ctrlBackgroundName ctrlCommit 0;

private _ctrlEditSettings = _display ctrlCreate ["RscEdit", IDD_EDIT_BOX_SETTINGS, _ctrlGroup];
_ctrlEditSettings ctrlSetPosition [POS_X(9), POS_Y(2.8), POS_W(10.5), POS_H(1.2)];
_ctrlEditSettings ctrlSetBackgroundColor [0, 0, 0, 0.6];
_ctrlEditSettings ctrlCommit 0;

private _ctrlBackgroundSettings = _display ctrlCreate ["RscTextMulti", -1, _ctrlGroup];
_ctrlBackgroundSettings ctrlSetPosition [POS_X(4), POS_Y(2.8), POS_W(4.9), POS_H(1.2)];
_ctrlBackgroundSettings ctrlSetBackgroundColor [0, 0, 0, 0.6];
_ctrlBackgroundSettings ctrlSetText "Preset settings:";
_ctrlBackgroundSettings ctrlSetTooltip "Paste radio preset here, if you are importing. Leave blank if you are creating a new profile.";
_ctrlBackgroundSettings ctrlEnable false;
_ctrlBackgroundSettings ctrlCommit 0;

// Buttons
private _ctrlButtonOk = _display ctrlCreate ["RscButtonMenu", -1, _ctrlGroup];
_ctrlButtonOk ctrlSetPosition [POS_X(15.3), POS_Y(4.6), POS_W(4.8), POS_H(1.2)];
_ctrlButtonOk ctrlSetBackgroundColor [0, 0, 0, 0.7];
_ctrlButtonOk ctrlSetFont "PuristaLight";
_ctrlButtonOk ctrlSetText "OK";
_ctrlButtonOk ctrlCommit 0;
_ctrlButtonOk ctrlAddEventHandler ["ButtonClick", {
    private _display = ctrlParent (_this select 0);

    [ctrlText (_display displayCtrl IDD_EDIT_BOX_NAME), ctrlText (_display displayCtrl IDD_EDIT_BOX_SETTINGS), displayParent _display] call FUNC(createProfile);

    _display closeDisplay IDC_OK;
}];

private _ctrlButtonCancel = _display ctrlCreate ["RscButtonMenu", -1, _ctrlGroup];
_ctrlButtonCancel ctrlSetPosition [POS_X(3.3), POS_Y(4.6), POS_W(5), POS_H(1.2)];
_ctrlButtonCancel ctrlSetBackgroundColor [0, 0, 0, 0.7];
_ctrlButtonCancel ctrlSetFont "PuristaLight";
_ctrlButtonCancel ctrlSetText "CANCEL";
_ctrlButtonCancel ctrlCommit 0;
_ctrlButtonCancel ctrlAddEventHandler ["ButtonClick", {
    (ctrlParent (_this select 0)) closeDisplay IDC_CANCEL;
}];

// Prevent scroll wheel from moving curator camera
if (_displayParent isEqualTo (findDisplay IDD_RSCDISPLAYCURATOR)) then {
    _display setVariable [QGVAR(cameraPos), getPosASL curatorCamera];

    _display displayAddEventHandler ["MouseZChanged", {
        curatorCamera setPosASL ((_this select 0) getVariable QGVAR(cameraPos));
    }];
};

// Add display EH for Enter and Escape buttons
_display displayAddEventHandler ["KeyDown", {
    params ["_display", "_keyCode"];

    // Ok
    if (_keyCode == DIK_RETURN) exitWith {
        [ctrlText (_display displayCtrl IDD_EDIT_BOX_NAME), ctrlText (_display displayCtrl IDD_EDIT_BOX_SETTINGS), displayParent _display] call FUNC(createProfile);

        _display closeDisplay IDC_OK;
    };
}];

ctrlSetFocus _ctrlEditName;
