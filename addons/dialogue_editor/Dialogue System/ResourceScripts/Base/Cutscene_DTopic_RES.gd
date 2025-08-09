class_name CutsceneDialogueTopic extends DialogueResource

@export var _topicText: String
@export var _responseAnimation: Array[Animation]

@export var _sayOnce: bool 
var already_said: bool = false
@export var _goodbye: bool 
@export var _random: bool 
@export var _exclusive: bool

@export var _setVar: Array[VariableSetter]

@export var _conditions: Array[String]
