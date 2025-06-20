<p align="center">
    <img width="460" height="300" src="image_src/logo_large_grey_alpha.png?raw=true">
</p>

***

**TFAR - ACE Radio Setter - Extended** is a client side mod which allows you to save/load your TFAR radios configuration via ACE Self-Interactions. This is not an official ACE or TFAR mod.

The mod stores data locally in `profileNamespace` which means it stores configurations on a per player profile basis. This has the added side effect of requiring you to save a new configuration for each profile you make use of, but also ensures you can have different radio configurations for different units etc.

This mod also adds the ability to sort radios by their ranges in the ACE arsenal.

<h2>CBA Settings</h2>

* **Enable Arsenal Radio settings Saving:** This setting will make the player save his current radio profile before accessing an arsenal (Vanilla or ACE). When exiting the arsenal or after respawning, the saved settings will be applied again.
* **Enable FK Server Detection:** This setting will change your SR channel to your squad's channel automatically after loading a setting and can only be used on an FK server.
* **Enable 'SR' Interactions:** If enabled, you will see the load and save options for SRs.
* **Enable 'LR' Interactions:** If enabled, you will see the load and save options for LRs.
* **Enable 'VLR' Interactions:** If enabled, you will see the load and save options for VLRs.
* **Enable 'SR & LR' Interactions:** If enabled, you will see the load and save options if you have access to an SR and LR at the same time.
* **Enable 'All' Interactions:** If enabled, you will see the load and save options if you have access to an SR, LR and VLR at the same time.
* **Ask Load Confirmation:** This setting will open a confirmation box when you try to load a profile. Handy for avoiding mistakes.
* **Ask Save Confirmation:** This setting will open a confirmation box when you try to save a profile. Handy for avoiding mistakes.
* **Ask Delete Confirmation:** This setting will open a confirmation box when you try to delete a profile. Handy for avoiding mistakes.
* **Ask Overwrite Confirmation:** This setting will open a confirmation box when you try to overwrite a profile when importing/creating profiles. Handy for avoiding mistakes.
* **Icon Color in Messages:** This setting changes the color of the icon that is shown when you load/save/export a profile.
* **Air Profile:** Allows the player to have a profile applied automatically when getting in an aircraft.
* **Land Profile:** Allows the player to have a profile applied automatically when getting in a ground vehicle.
* **Enable Mounting Radio settings Saving:** If the player has crew status, this setting will make the player save his current radio profile before mounting into a vehicle. When exiting the vehicle, the saved settings will be applied again.
* **Default Crew Status:** Allows the player to set the default crew status when joining a mission.

<h2>CBA Keybinds</h2>

* Press **NUMPAD-9** to set your radio to the 9th SR channel.

<h2>How to</h2>

* Use the "Create/Import Profile" interaction, which will open a dialog (window). In the top line you must give your profile a name and in the lower line you can give settings to a profile, but it's optional. This array is proprietary (see config.cpp in comment).
* Now you can save your current radio settings using the "Save" interaction. SR radios will be individually listed, if there are multiple whereas for LR there will always be 1 interaction. You can select which profile you want to save the settings to.
* You can now load the saved profile using the "Load" interaction.
* Use the "Set Status" interaction to change your status as a crew member:
    If you are crew, it will apply radio loadouts in vehicles if they are defined.
    If you aren't crew, it will do nothing.
    
<h2>Notes</h2>

TFAR Beta is required, but it is version independent as far as I'm aware. If you use a version other than the one listed, or if you use a local version, this should still work. Currently written and tested under 1.0.328 (Beta).

<h2>Links</h2>

* [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2526965189)
* [GitHub](https://github.com/johnb432/TFAR-ACE-Setter-Extended)

<h2>Credit</h2>

* [Chatter](https://github.com/RTO-Chatter) & [M3ales](https://github.com/M3ales), with edits from [Tirpitz93](https://github.com/Tirpitz93) for TFAR Beta compatibility, for making the [original mod](https://steamcommunity.com/sharedfiles/filedetails/?id=1909836103)
* Mod by johnb43
* See AUTHORS.txt

<h2>License</h2>

See LICENSE.
