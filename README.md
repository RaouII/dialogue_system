I started working on this for a personal project and ended up really liking how it turned out, so I decided to share it in case someone else finds it useful.

Little demo video:
https://www.youtube.com/watch?v=BQT7F73EWRY&t

About the project:

The system uses custom Godot's resources as building blocks to create dialogue trees, and it dynamically chooses what dialogue is displayed through the use of conditions. It is designed for games where NPCs' conversations can change dynamically, reacting to the world or the player through the use of conditions(an approach similar to Storylets).

To be a bit more specific: Imagine you have a character that stays in the same place everyday, maybe a shopkeeper or something. The first time you meet them, they might say a "Nice to meet you!", next time you meet them, they might just say "Hello!" instead, since you've already met them. Maybe you're doing a quest where you learned this shopkeeper used to be a burglar, and now you can ask them something like "I heard you were a burglar before settling down". Maybe the player just finished another quest for a rival shopkeeper and this one got mad at them, so now he says "What do you want, traitor?" instead of the happy greeting from before. 
Another example: You can have a companion character that the player can talk to throughout their journey, this companion might have different things to say based on where you are or what quests are active.

The practical implementation of this is this: instead of you somehow "hardcoding" the changes(by coding changes of states in the shopkeeper or companion, or manually writing "ifs" when calling the dialogue), you just build the branches with the conditions applied directly to the dialogue, and the system takes care of choosing whats the correct/relevant message to display.

Although the project features a simple CutscenePlayer node, which is an extension of the default AnimationPlayer with extra functions to allow the use of Responses to display dialogue during cutscenes, the focus isn't on cinematics. It works well enough if you're doing a simple game, with basic sprite or 3D animations during cutscenes, but anything fancier than that is not in my current plans(but then again, Godot's default AnimationPlayer is already pretty powerful so its probably possible to do some cool stuff).

The Visual Editor is pretty much done. The only missing feature is the ability to delete individual nodes. However, unconnected nodes will be discarded when saving the branch, so you can just put them aside and it'll be fine.


============================================================
The main dialogue system files are inside the "raou_nodes" folder and the visual plugin is inside the "addons" folder. You do not need the visual editor plugin in order to use the dialogue system itself, its completely *possible* to make your trees just using godots default inspector, but any tree of moderate size can get overwhelming *(so its not recommended approach)*. The rest is just a sample project I'm working on to demonstrate some of its functionalities, its also currently a work in progress but you can play it and check out *some* of it.
*(there is also some Event Tracker stuff I'm trying out and using this same project as test-grounds for it, but feel free to ignore it)*

I've never writen documentation for anything before so its probably shit but heres a link to it:
https://docs.google.com/document/d/1Qnnhuh9sHmmGB_JJ4gAYbsYFSRdI9RakOWvpAa3xm5g/edit?tab=t.0
(documentation was made before I started the Visual Editor, I'll update it once I actually finish it)
