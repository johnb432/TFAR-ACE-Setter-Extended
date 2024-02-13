#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

// Set array, so it can be modified by reference later
if (isNil {GETPRVAR(QGVAR(profileNames),nil)}) then {
    SETPRVAR(QGVAR(profileNames),[]);
};

// CBA Settings
#include "initSettings.inc.sqf"

ADDON = true;
