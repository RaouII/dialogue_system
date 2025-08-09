I started working on this for a personal project and ended up really liking how it turned out, so I decided to share it in case someone else finds it useful.

Little demo video:
https://www.youtube.com/watch?v=BQT7F73EWRY&t

DOCUMENTATION:
https://docs.google.com/document/d/1Qnnhuh9sHmmGB_JJ4gAYbsYFSRdI9RakOWvpAa3xm5g/edit?tab=t.0

About the project:

The system is designed for games where NPCs' conversations can change dynamically, reacting to the world or the player through the use of conditions.

Its focus is for dialogues similar to Skyrim: when you talk to an NPC, you'll see a short message or a series of messages as a "Greeting", you'll be then presented with a list of Topics that you can ask about or respond with. Each topic can lead to more options, branching out the conversation. Events of the game can dynamically change what options are available to you.

Dialogues are organized into "Segments", which are groups of related topics that are attached to the NPC's DialogueTree. 

Topics are the options available for the player. They will only be displayed when their conditions are met, and will trigger any attached function when picked. Conditions and Functions are easily created by inheriting the respective resources, allowing for highly customizable dialogue behavior.

The Visual Editor is pretty much done. The only missing feature is the ability to delete individual nodes. However, unconnected nodes will be discarded when saving the branch, so you can just put them aside and it'll be fine.


