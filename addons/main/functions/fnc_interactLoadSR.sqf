#include "script_component.hpp"

/*
 * Author: johnb43
 * Adds all SR to the menu for loading self-interactions.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * All interaction submenus of SR <ARRAY>
 *
 * Example:
 * player call tfar_ace_extended_main_fnc_interactLoadSR;
 *
 * Public: No
 */

// Make menus for each SR
(_this call TFAR_fnc_radiosList) apply {[
    [
        format [QGVAR(interactLoadSR_%1), _x], // Action name
        [_x, "displayName"] call TFAR_fnc_getWeaponConfigProperty, // Display name
        [_x, "picture"] call TFAR_fnc_getWeaponConfigProperty, // Icon
        {}, // Statement
        {GVAR(enableSRInteractions)}, // Condition
        { // Children actions
            // Send player and radio information
            private _args = _this select 2;

            [_args select 0, [true, false, false], true, _args select 1] call FUNC(profileMenusLoad);
        },
        [_this, _x] // Action parameters
    ] call ace_interact_menu_fnc_createAction, [], _this];
}
