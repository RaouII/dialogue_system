I started working on this for a personal project and liked how easy it was to actually use it, so I figure I'd put it out there in case its useful to someone else as well

Little demo video:
https://www.youtube.com/watch?v=BQT7F73EWRY&t

About:

This is a framework designed for games where NPCs' conversations can change dynamically, reacting to the world or the player through the use of conditions, an approach similar to a Storylets approach.

The system is not designed for presentation-heavy or cinematic dialogue, just functional conversations that can slot into gameplay with minimal setup. (A custom AnimationPlayer node is planned, but it'll hardly feature much more than the ability to call Dialogue Responses through the animation player and wait for player input before continuing the animation)

I'm currently working on finishing the Visual Editor. The loaded branches currently lack any connections between its nodes, but other than that, its pretty much completed.

The main dialogue system files are inside the "raou_nodes" folder and the visual plugin is inside the "addons" folder. You do not need the visual editor plugin in order to use the dialogue system itself, its completely possible to make your trees just using godots default inspector, but any tree of moderate size can get overwhelming. The rest is just a sample project I'm working on to demonstrate some of its functionalities, its also currently a work in progress but you can play it and check out *some* of it.

I've never writen documentation for anything before so its probably shit but heres a link to it:
https://docs.google.com/document/d/1Qnnhuh9sHmmGB_JJ4gAYbsYFSRdI9RakOWvpAa3xm5g/edit?tab=t.0
(documentation was made before I started the Visual Editor, I'll update it once I actually finish it)
