class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class TFAR_Radio {
                class ADDON {
                    condition = QUOTE(true);
                    displayName = "TFAR Setter";
                    EXCEPTIONS;
                    icon = ICON_ROOT;

                    class GVAR(saveBase) {
                        condition = QUOTE(call TFAR_fnc_haveSWRadio || call TFAR_fnc_haveLRRadio);
                        displayName = "Save";
                        EXCEPTIONS;
                        icon = ICON_SAVE;

                        class GVAR(saveSR) {
                            condition = QUOTE(call TFAR_fnc_haveSWRadio);
                            displayName = "SR";
                            EXCEPTIONS;
                            icon = ICON_SR;
                            insertChildren = QUOTE([ARR_3(_this,[ARR_3(true,false,false)],true)] call FUNC(profileMenusSave));
                        };

                        class GVAR(saveFromLRtoLR) {
                            condition = QUOTE(!isNil {player call TFAR_fnc_backpackLR});
                            displayName = "from LR to LR";
                            EXCEPTIONS;
                            icon = ICON_LR;
                            insertChildren = QUOTE([ARR_3(_this,[ARR_3(false,true,false)],true)] call FUNC(profileMenusSave));
                        };

                        class GVAR(saveFromVLRtoLR) {
                            condition = QUOTE((objectParent _player) call TFAR_fnc_hasVehicleRadio);
                            displayName = "from VLR to LR";
                            EXCEPTIONS;
                            icon = ICON_LR;
                            insertChildren = QUOTE([ARR_3(_this,[ARR_3(false,true,false)],false)] call FUNC(profileMenusSave));
                        };

                        class GVAR(saveFromLRtoVLR) {
                            condition = QUOTE(!isNil {player call TFAR_fnc_backpackLR});
                            displayName = "from LR to VLR";
                            EXCEPTIONS;
                            icon = ICON_VLR;
                            insertChildren = QUOTE([ARR_3(_this,[ARR_3(false,false,true)],false)] call FUNC(profileMenusSave));
                        };

                        class GVAR(saveFromVLRtoVLR) {
                            condition = QUOTE((objectParent _player) call TFAR_fnc_hasVehicleRadio);
                            displayName = "from VLR to VLR";
                            EXCEPTIONS;
                            icon = ICON_VLR;
                            insertChildren = QUOTE([ARR_3(_this,[ARR_3(false,false,true)],true)] call FUNC(profileMenusSave));
                        };

                        class GVAR(saveSRAndFromLRtoLR) {
                            condition =  QUOTE(call TFAR_fnc_haveSWRadio && !isNil {player call TFAR_fnc_backpackLR});
                            displayName = "SR and from LR to LR";
                            EXCEPTIONS;
                            icon = ICON_ROOT;
                            insertChildren = QUOTE([ARR_3(_this,[ARR_3(true,true,false)],true)] call FUNC(profileMenusSave));
                        };

                        class GVAR(saveAll) {
                            condition =  QUOTE(call TFAR_fnc_haveSWRadio && call TFAR_fnc_haveLRRadio);
                            displayName = "All";
                            EXCEPTIONS;
                            icon = ICON_ROOT;
                            insertChildren = QUOTE([ARR_3(_this,[ARR_3(true,true,true)],true)] call FUNC(profileMenusSave));
                        };
                    };

                    class GVAR(loadBase) {
                        condition = QUOTE(call TFAR_fnc_haveSWRadio || call TFAR_fnc_haveLRRadio);
                        displayName = "Load";
                        EXCEPTIONS;
                        icon = ICON_LOAD;

                        class GVAR(loadSR) {
                            condition = QUOTE(call TFAR_fnc_haveSWRadio);
                            displayName = "SR";
                            EXCEPTIONS;
                            icon = ICON_SR;
                            insertChildren = QUOTE([ARR_3(_this,[ARR_3(true,false,false)],true)] call FUNC(profileMenusLoad));
                        };

                        class GVAR(loadFromLRToLR) {
                            condition = QUOTE(!isNil {player call TFAR_fnc_backpackLR});
                            displayName = "from LR to LR";
                            EXCEPTIONS;
                            icon = ICON_LR;
                            insertChildren = QUOTE([ARR_3(_this,[ARR_3(false,true,false)],true)] call FUNC(profileMenusLoad));
                        };

                        class GVAR(loadFromVLRToLR) {
                            condition = QUOTE(!isNil {player call TFAR_fnc_backpackLR});
                            displayName = "from VLR to LR";
                            EXCEPTIONS;
                            icon = ICON_LR;
                            insertChildren = QUOTE([ARR_3(_this,[ARR_3(false,false,true)],false)] call FUNC(profileMenusLoad));
                        };

                        class GVAR(loadFromLRToVLR) {
                            condition = QUOTE((objectParent _player) call TFAR_fnc_hasVehicleRadio);
                            displayName = "from LR to VLR";
                            EXCEPTIONS;
                            icon = ICON_VLR;
                            insertChildren = QUOTE([ARR_3(_this,[ARR_3(false,true,false)],false)] call FUNC(profileMenusLoad));
                        };

                        class GVAR(loadFromVLRToVLR) {
                            condition = QUOTE((objectParent _player) call TFAR_fnc_hasVehicleRadio);
                            displayName = "from VLR to VLR";
                            EXCEPTIONS;
                            icon = ICON_VLR;
                            insertChildren = QUOTE([ARR_3(_this,[ARR_3(false,false,true)],true)] call FUNC(profileMenusLoad));
                        };

                        class GVAR(loadFromSRAndFromLRToLR) {
                            condition = QUOTE(call TFAR_fnc_haveSWRadio && !isNil {player call TFAR_fnc_backpackLR});
                            displayName = "SR and from LR to LR";
                            EXCEPTIONS;
                            icon = ICON_ROOT;
                            insertChildren = QUOTE([ARR_3(_this,[ARR_3(true,true,false)],true)] call FUNC(profileMenusLoad));
                        };

                        class GVAR(loadAll) {
                            condition =  QUOTE(call TFAR_fnc_haveSWRadio && call TFAR_fnc_haveLRRadio);
                            displayName = "All";
                            EXCEPTIONS;
                            icon = ICON_ROOT;
                            insertChildren = QUOTE([ARR_3(_this,[ARR_3(true,true,true)],true)] call FUNC(profileMenusLoad));
                        };
                    };

                    class GVAR(deleteProfile) {
                         condition = QUOTE(GETPRVAR(QUOTE(QGVAR(profileNames)),[]) isNotEqualTo []);
                         displayName = "Delete Profile";
                         EXCEPTIONS;
                         icon = ICON_DELETE;
                         statement = QUOTE(call FUNC(deleteProfile));
                    };

                    class GVAR(newProfile) {
                         condition = QUOTE(true);
                         displayName = "Create New Profile";
                         EXCEPTIONS;
                         icon = ICON_ADD;
                         statement = QUOTE(call FUNC(createNewProfile));
                    };
                };
            };
        };
    };
};