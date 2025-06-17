extends Node




## started dialogue signal: sends a signal saying a dialogue has started
signal started_dialogue()
## close dialogue signal: sends a signal saying a dialogue has ended
signal closed_dialogue()
## set idle animation signal: it sends a signal with a variety of useful information to animate characters during dialogue.
signal set_character_idle_animation(_char: CharacterID,_anim: String,_emotion: String,_emote_intensity: int)
signal add_character_to_level_array(CharacterID)


var canvas: CanvasLayer
var variable := {}  # For numbers (ints or floats)
var switch := {}   # For booleans

func set_variable(name: String, value: int) -> void:
	variable[name] = value

func get_variable(name: String) -> int:
	return variable.get(name)

func add_to_variable(name: String, amount: int) -> void:
	variable[name] = get_variable(name) + amount

func set_switch(name: String, value: bool) -> void:
	switch[name] = value

func get_switch(name: String) -> bool:
	return switch.get(name)

func toggle_switch(name: String) -> void:
	switch[name] = !get_switch(name)
