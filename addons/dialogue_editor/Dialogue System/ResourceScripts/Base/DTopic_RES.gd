@icon("res://Dialogue System/ICO_DialogueTopic.png")
class_name DialogueTopic extends Resource

@export var _topicText: String
@export var _responses: Array[DialogueResponse]
@export var _nextBranch: DialogueSegment
@export_group("Flags")
@export var _goodbye: bool 
@export var _random: bool 
@export var _exclusive: bool
@export var _priority: int = 10
@export_group("Functions and Conditions")
@export var _functions: Array[Function]
@export var _conditions: Array[Condition]


@export var is_greeting: bool = false
