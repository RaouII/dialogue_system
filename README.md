I started working on this for a personal project and ended up really liking how it turned out, so I decided to share it in case someone else finds it useful.

Little demo video:
https://www.youtube.com/watch?v=BQT7F73EWRY&t

DOCUMENTATION:
https://docs.google.com/document/d/1Qnnhuh9sHmmGB_JJ4gAYbsYFSRdI9RakOWvpAa3xm5g/edit?tab=t.0

About the project:

The system is designed for games where NPCs' conversations can change dynamically, reacting to the world or the player through the use of conditions(an approach similar to Storylets). It uses custom Godot's resources as building blocks to create the dialogue trees, and it dynamically chooses what dialogue is displayed through the use of conditions.

Although the project features a simple CutscenePlayer node, which is an extension of the default AnimationPlayer with extra functions to allow the use of Responses to display dialogue during cutscenes, the focus isn't on cinematics. It works well enough if you're doing a simple game, with basic sprite or 3D animations during cutscenes, but anything fancier than that is not in my current plans(but then again, Godot's default AnimationPlayer is already pretty powerful so its probably possible to do some cool stuff).

The Visual Editor is pretty much done. The only missing feature is the ability to delete individual nodes. However, unconnected nodes will be discarded when saving the branch, so you can just put them aside and it'll be fine.


