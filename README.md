<p align="center">
	<img width="460" height="300" src="https://github.com/RTO-Chatter/ACE-TFAR-Long-Range-Setter/blob/master/image_src/logo_large_grey_alpha.png?raw=true">
</p>

***

**TFAR - ACE Radio Setter - Extended** is a simple Quality of Life mod for the ARMA 3 written by johnb43, based off of [this mod](https://github.com/Tirpitz93/ACE-TFAR-Setter) which allows you to save/load your TFAR Long Range Radio configuration via an ACE Self Interaction.

The mod stores data locally in `profileNamespace` which means it stores configurations on a per profile basis. This has the added side effect of requiring you to save a new configuration for each profile you make use of, but also ensures you can have different LR configurations for different units etc.

## Links

- [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=1909836103)

## Requirements

- [ACE 3](https://steamcommunity.com/sharedfiles/filedetails/?id=463939057)
- [Task Force Arrowhead Radio (BETA)](https://steamcommunity.com/sharedfiles/filedetails/?id=894678801)
- [Zeus Enhanced](https://steamcommunity.com/sharedfiles/filedetails/?id=1779063631) (For profile creation and deletion; hopefully in future I will remove that dependency)

## Notes

- TFAR is required, but it is version independent as far as I'm aware. If you use a version other than the one listed, or if you use a local version, this should still work. Currently written and tested under 1.0.328 (Beta).
- Do not use with side encryption enabled servers. This mod does not care for encryption: It can load BLUFOR encrypted radio settings on REDFOR radios e.g.

## Credit

Credit to the original authors [Chatter](https://github.com/RTO-Chatter) & [M3ales](https://github.com/M3ales), with edits from [Tirpitz93](https://github.com/Tirpitz93) for TFAR Beta compatibility. Very little of their code is left, but it served as a basis and inspiration nonetheless, not to mention their pictures and icons are used in this version. So, thank you guys for making the original [mod](https://github.com/Tirpitz93/ACE-TFAR-Setter)!

## How to create PBOs

* Download hemtt from [here](https://brettmayson.github.io/HEMTT/#/)
* Place hemtt.exe inside the project folder (same level as addons)
* Open commmand terminal, navigate to said folder (Windows: cd <insert path>)
* Type "hemtt build --release"
