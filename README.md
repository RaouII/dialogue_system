I started working on this for a personal project and liked how easy it was to actually use it, so I figure I'd put it out there in case its useful to someone else as well

Little demo video:
<iframe width="560" height="315" src="https://www.youtube.com/embed/z_re1ueZL2s?si=_U-GMmbBHeXTfHTM" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

About:

This is a framework designed for games where NPCs' conversations can change dynamically, reacting to the world or the player, without requiring a custom cutscene or tightly choreographed moment. Dialogue is structured around reusable branches that become available when specific conditions are met.
The system uses Godot Resources to represent dialogue components. These resources can be saved as individual files, making it easy to reuse them elsewhere. 

The system is not designed for presentation-heavy or cinematic dialogue. You won’t find complex tools for syncing camera cuts, animations, or voice acting, just functional conversations that can slot into gameplay with minimal setup.

Currently, there is no custom visual editor, but you can use Godot’s default inspector to edit dialogue. Editing large trees can be overwhelming, but you can work on branches individually and then drag and drop them into your tree.


The files are inside the "raou_nodes" folder, the rest is just a sample project demonstrating it a bit.

I've never writen documentation for anything before so its probably shit but heres a link to it:
https://docs.google.com/document/d/1Qnnhuh9sHmmGB_JJ4gAYbsYFSRdI9RakOWvpAa3xm5g/edit?tab=t.0
