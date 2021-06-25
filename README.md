<p align="center">
	<img width="460" height="300" src="https://github.com/johnb432/ACE-TFAR-Setter-Extended/blob/main/image_src/logo_large_grey_alpha.png?raw=true">
</p>

***

**TFAR - ACE Radio Setter - Extended** is a simple Quality of Life mod for the ARMA 3 written by johnb43, based off of [this mod](https://github.com/Tirpitz93/ACE-TFAR-Setter) which allows you to save/load your TFAR Long Range Radio configuration via an ACE Self Interaction.

The mod stores data locally in `profileNamespace` which means it stores configurations on a per profile basis. This has the added side effect of requiring you to save a new configuration for each profile you make use of, but also ensures you can have different LR configurations for different units etc.

## CBA Settings
- **Air profile:** Allows the player to have a profile applied automatically when getting in an aircraft.
- **Land profile:** Allows the player to have a profile applied automatically when getting in a ground vehicle.
- **Ask load confirmation:** This setting will open a confirmation box when you try to load a profile. Handy for avoiding mistakes.
- **Ask save confirmation:** This setting will open a confirmation box when you try to save a profile. Handy for avoiding mistakes.
- **Enable automatic arsenal saving of radio settings:** This setting will make the player save his current radio preset before mounting into a vehicle. When exiting the vehicle, the saved settings will be applied again.
- **Enable automatic mounting saving of radio settings:** This setting will make the player save his current radio preset before accessing an arsenal (Vanilla or ACE). When exiting the vehicle, the saved settings will be applied again.
- **Enable 'SR' interactions:** If enabled, you will see the load and save options for SRs.
- **Enable 'LR' interactions:** If enabled, you will see the load and save options for LRs.
- **Enable 'VLR' interactions:** If enabled, you will see the load and save options for VLRs.
- **Enable 'SR & LR' interactions:** If enabled, you will see the load and save options if you have access to an SR and LR at the same time.
- **Enable 'All' interactions:** If enabled, you will see the load and save options if you have access to an SR, LR and VLR at the same time.

## Links

- [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=1909836103)
- [GitHub](https://github.com/johnb432/ACE-TFAR-Setter-Extended)

## Notes

- TFAR is required, but it is version independent as far as I'm aware. If you use a version other than the one listed, or if you use a local version, this should still work. Currently written and tested under 1.0.328 (Beta).

## Credit

Credit to the original authors [Chatter](https://github.com/RTO-Chatter) & [M3ales](https://github.com/M3ales), with edits from [Tirpitz93](https://github.com/Tirpitz93) for TFAR Beta compatibility. Very little of their code is left, but it served as a basis and inspiration nonetheless, not to mention their pictures and icons are used in this version. So, thank you guys for making the original [mod](https://github.com/Tirpitz93/ACE-TFAR-Setter)!

## How to create PBOs

* Download hemtt from [here](https://brettmayson.github.io/HEMTT/#/)
* Place hemtt.exe inside the project folder (same level as addons)
* Open commmand terminal, navigate to said folder (Windows: cd <insert path>)
* Type "hemtt build --release"
