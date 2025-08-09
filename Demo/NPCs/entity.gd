class_name Entity extends Node

### I created this Entity component just to handle functions related to the CharacterID
### You can replace this with whatever other component makes more sense for your project
### Maybe you leave all your character data inside a CharacterBody script, in that case
### just connect the signal correctly and place the correct functions and references inside your script


@export var characterID: CharacterID
@export var animationPlayer: AnimationPlayer
@export var dialogueComponent: DialogueComponent
func _ready():
	DialogueController.set_character_idle_animation.connect(_on_idle_animation)

	
func _on_set_new_greeting(_char: CharacterID,_greeting: DialogueTopic):
	if _char == characterID:
		print("FOUND CHARACTER")
		#Global.DialogueTreeDictionary[characterID.name]._greeting = _greeting
		#dialogueComponent._dialogueTree._greeting = _greeting
	
func _on_idle_animation(_char: CharacterID,_anim: String):
	### This funcion checks if the characterID assigned to the Dialogue Response is the same as this one.
	### If it is, and you assigned an animation player to this node, and you also passed an animation name in the Response resource
	### it'll play it.
	if _char == characterID and animationPlayer != null:
		if _anim:
			animationPlayer.play(_anim)
			
	### You can expand this to do other things, maybe its a 3D project and you have a facial animation system?
	### You could pass this information through the DialogueResponse resource and pass it through the signal
	### and then use that information in your facial animation system.
