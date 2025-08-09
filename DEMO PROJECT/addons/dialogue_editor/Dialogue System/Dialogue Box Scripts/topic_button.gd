extends Button


@export var _dialogueTopic: DialogueTopic
var _topicIndex: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_up() -> void:
	DialogueController.select_topic.emit(_dialogueTopic)
	pass # Replace with function body.s
