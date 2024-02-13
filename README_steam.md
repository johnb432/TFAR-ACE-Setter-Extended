[b]TFAR - ACE Radio Setter - Extended[/b] is a client side. It's a simple Quality of Life mod which allows you to save/load your TFAR radios configuration via ACE Self-Interactions. This is not an official ACE or TFAR mod.

The mod stores data locally in `profileNamespace` which means it stores configurations on a per profile basis. This has the added side effect of requiring you to save a new configuration for each profile you make use of, but also ensures you can have different radio configurations for different units etc.

This mod also adds the ability to sort radios by their ranges in the ACE arsenal.

[h2]CBA Settings[/h2]
[list]
[*] [b]Enable Arsenal Radio settings Saving:[/b] This setting will make the player save his current radio profile before accessing an arsenal (Vanilla or ACE). When exiting the arsenal or after respawning, the saved settings will be applied again.
[*] [b]Enable FK Server Detection:[/b] This setting will change your SR channel to your squad's channel automatically after loading a setting and can only be used on an FK server.
[*] [b]Enable 'SR' Interactions:[/b] If enabled, you will see the load and save options for SRs.
[*] [b]Enable 'LR' Interactions:[/b] If enabled, you will see the load and save options for LRs.
[*] [b]Enable 'VLR' Interactions:[/b] If enabled, you will see the load and save options for VLRs.
[*] [b]Enable 'SR & LR' Interactions:[/b] If enabled, you will see the load and save options if you have access to an SR and LR at the same time.
[*] [b]Enable 'All' Interactions:[/b] If enabled, you will see the load and save options if you have access to an SR, LR and VLR at the same time.
[*] [b]Ask Load Confirmation:[/b] This setting will open a confirmation box when you try to load a profile. Handy for avoiding mistakes.
[*] [b]Ask Save Confirmation:[/b] This setting will open a confirmation box when you try to save a profile. Handy for avoiding mistakes.
[*] [b]Ask Delete Confirmation:[/b] This setting will open a confirmation box when you try to delete a profile. Handy for avoiding mistakes.
[*] [b]Ask Overwrite Confirmation:[/b] This setting will open a confirmation box when you try to overwrite a profile when importing/creating profiles. Handy for avoiding mistakes.
[*] [b]Icon Color in Messages:[/b] This setting changes the color of the icon that is shown when you load/save/export a profile.
[*] [b]Air Profile:[/b] Allows the player to have a profile applied automatically when getting in an aircraft.
[*] [b]Land Profile:[/b] Allows the player to have a profile applied automatically when getting in a ground vehicle.
[*] [b]Enable Mounting Radio settings Saving:[/b] If the player has crew status, this setting will make the player save his current radio profile before mounting into a vehicle. When exiting the vehicle, the saved settings will be applied again.
[*] [b]Default Crew Status:[/b] Allows the player to set the default crew status when joining a mission.
[/list]

[h2]CBA Keybinds[/h2]
[list]
[*] Press [b]NUMPAD-9[/b] to set your radio to the 9th SR channel.
[/list]

[h2]How to[/h2]
[list]
[*] Use the "Create/Import Profile" interaction, which will open a dialog (window). In the top line you must give your profile a name and in the lower line you can give settings to a profile, but it's optional. This array is proprietary (see config.cpp in comment).
[*] Now you can save your current radio settings using the "Save" interaction. SR radios will be individually listed, if there are multiple whereas for LR there will always be 1 interaction. You can select which profile you want to save the settings to.
[*] You can now load the saved settings using the "Load" interaction.
[*] Use the "Set Status" interaction to change your status as a crew member:
    If you are crew, it will apply radio loadouts in vehicles if they are defined.
    If you aren't crew, it will do nothing.
[/list]

[h2]Notes[/h2]

TFAR Beta is required, but it is version independent as far as I'm aware. If you use a version other than the one listed, or if you use a local version, this should still work. Currently written and tested under 1.0.328 (Beta).

[h2]Links[/h2]
[list]
[*] [url=https://steamcommunity.com/sharedfiles/filedetails/?id=2526965189]Steam Workshop[/url]
[*] [url=https://github.com/johnb432/TFAR-ACE-Setter-Extended]GitHub[/url]
[/list]

[h2]Credit[/h2]
[list]
[*] [url=https://github.com/RTO-Chatter]Chatter[/url] & [url=https://github.com/M3ales]M3ales[/url], with edits from [url=https://github.com/Tirpitz93]Tirpitz93[/url] for TFAR Beta compatibility, for making the [url=https://steamcommunity.com/sharedfiles/filedetails/?id=1909836103]original mod[/url]
[*] Mod by johnb43
[/list]

[h2]License[/h2]
See LICENSE.
