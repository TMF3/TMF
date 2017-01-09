# Teamwork Mission Framework (TMF)

<img src="http://teamonetactical.com/logo_tmf_ca.png">

TMF is an open source, flexible and modular mission framework designed from the ground up for Arma 3's 3DEN editor.
We created TMF intending it to be easy to pick up, but rich with features. A mission maker enabler, allowing them to focus on mission design instead of peripherals.
The framework is addon based, keeping filesize down and ensuring that even old missions are up-to-date.

## Core Features:
- Extensive 3DEN integration
- Automatic ACRE2 radio allocation and powerful channel creator, with randomized frequencies
- Our own Spectator system, with support for highlighting positions of e.g. objectives
- Assign Gear with config-based loadouts - loadouts can exist in the mission and/or an addon for retroactive updates
- Hierarchal ORBAT integration with ingame map tracker
- Easy Briefing system with automatically generated pages for player loadout, ORBAT and radios
- Safe Start module
- Wave Spawner module that preserves waypoints, supports trigger activation and headless client
- Map Click Teleport module for group leaders

## Common Issues
- On dedicated servers the briefing files may not load - To fix the issue in server.cfg to add the `sqf` extension to the `allowedHTMLLoadExtensions` whitelist. For example `allowedHTMLLoadExtensions[] = {"htm","html","xml","txt","sqf"};`


## Credits
The TMF Team:
Head, Nick and Snippers

Special Thanks:
- Team One Tactical (1Tac) - http://www.teamonetactical.com
- CBA Team - http://www.github.com/CBATeam/CBA_A3/
- F3 Framework - http://ferstaberinde.com/f3/en/
- ACE Team - https://github.com/acemod/ACE3
- Bear
- Feanix
- Morbo

We would also like to thank all developers who have publically released any content for Arma. Without you all the Arma community wouldn't be what it is!

## License
The Arma community has long been thriving on communities and developers coming together and sharing.
This is why we are committed to providing TMF as an open source, free to modify addon.
We do ask that anyone who modifies TMF or creates addons from it publishes their changes and additions on a public github repository, so that others can benefit from their modifications.
We ask that they retain credits to TMF and a link to this github page.
If anyone wishes to create a fork or derivative using this framework, ideally use the following naming scheme:
DERIVATIVE_TAG-TMF, where DERIVATIVE_TAG is the tag or name of the derivative or fork, and -TMF our postfix.

We reserve the right to integrate any changes or additions into TMF itself, and will provide proper credit when doing so.

Offical license: Arma Public License Share-Alike (APL-SA)

Full License: https://www.bistudio.com/community/licenses/arma-public-license-share-alike

We are always keen and interested to hear how various communities use and alter the framework so that we can improve it. Feel free to get in touch!
