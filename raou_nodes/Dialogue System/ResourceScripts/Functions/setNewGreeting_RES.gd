class_name SetNewGreeting extends Function

@export var new_greeting: DialogueTopic
@export var character_id: CharacterID
func run():
	Global.DialogueTreeDictionary[character_id.name]._greeting = new_greeting
	#Global.set_new_character_greeting.emit(character_id,new_greeting)
