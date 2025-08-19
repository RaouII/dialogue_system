@icon("res://Dialogue System/ICO_DialogueResponse.png")
class_name DialogueResponse extends DialogueResource


@export var _responseText: String
@export var _conditions: Array[Condition]
@export var _functions: Array[Function]
@export var character_id: CharacterID
@export var _idleAnimation: String
#@export_enum("Neutral","Anger","Disgust","Fear","Sad","Happy","Surprise","Puzzled") var _emotionType: String = "Neutral"
#@export var _audioTrack: AudioStream
