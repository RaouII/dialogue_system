extends Node


signal play_sfx(sound: AudioStream)
signal door_sfx(type: int)
signal add_character_to_level_array(CharacterID)
signal cutscene_started
signal cutscene_ended

var main: Main
var level: Level
var player: CharacterBody2D
var canvas: CanvasLayer
var variable := {}  # For numbers (ints or floats)
var switch := {}   # For booleans


var events: Dictionary


func set_variable(name: String, value: int) -> void:
	variable[name] = value

func get_variable(name: String) -> int:
	if variable.has(name):
		return variable.get(name)
	else:
		return 0

func check_all_conditions(_condition_array: Array[Condition]):
	if _condition_array.is_empty():
		return true
	else:
		var last_entry = _condition_array.size()-1
		for condition in _condition_array:
			if condition.check() != true:
				break
			if condition == _condition_array[last_entry]:
				print("Show Responses")
				return true
		return false

func add_to_variable(name: String, amount: int) -> void:
	variable[name] = get_variable(name) + amount

func set_switch(name: String, value: bool) -> void:
	switch[name] = value

func get_switch(name: String) -> bool:
	return switch.get(name)

func toggle_switch(name: String) -> void:
	switch[name] = !get_switch(name)
