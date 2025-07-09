extends Node

signal set_new_character_greeting(_id: CharacterID,_greeting: DialogueTopic)
signal play_sfx(sound: AudioStream)
signal door_sfx(type: int)
## started dialogue signal: sends a signal saying a dialogue has started
signal started_dialogue()
## close dialogue signal: sends a signal saying a dialogue has ended
signal closed_dialogue()
## set idle animation signal: it sends a signal with a variety of useful information to animate characters during dialogue.
signal set_character_idle_animation(_char: CharacterID,_anim: String)
signal add_character_to_level_array(CharacterID)

var main: Main
var level: Level
var player: CharacterBody2D
var canvas: CanvasLayer
var DialogueTreeDictionary : Dictionary[String,DialogueTree]
var variable := {}  # For numbers (ints or floats)
var switch := {}   # For booleans


var events: Dictionary

func create_event_info(_event: Event):
	if !events.has(_event):
		events[_event] = Event.new()
		events[_event] = _event.duplicate()
		events[_event].current_stage = EventStageList.new()
		events[_event].current_stage.selected_option = events[_event].stages[0].resource_name
		events[_event].current_index = 0
		events[_event].current_stage.selected_index = 0

func set_variable(name: String, value: int) -> void:
	variable[name] = value

func get_variable(name: String) -> int:
	if variable.has(name):
		return variable.get(name)
	else:
		return -1

func add_to_variable(name: String, amount: int) -> void:
	variable[name] = get_variable(name) + amount

func set_switch(name: String, value: bool) -> void:
	switch[name] = value

func get_switch(name: String) -> bool:
	return switch.get(name)

func toggle_switch(name: String) -> void:
	switch[name] = !get_switch(name)
