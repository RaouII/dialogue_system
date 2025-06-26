@tool
class_name ResponseGraphNode extends GraphNode

@onready var topic_prompt : TextEdit = $"Topic Container/HFlowContainer/TextEdit"
@onready var character_id_label = $CharacterID/CharacterIDLabel
@onready var characterIDFilePicker = $CharacterID/characterIDFilePicker
var characterID: CharacterID
var animation: String


func _on_text_edit_text_changed():
	title = topic_prompt.text
	pass # Replace with function body.


func _on_file_dialog_file_selected(path):
	var id: CharacterID = load(path)
	character_id_label.text = id.name
	characterID = id
	characterIDFilePicker.visible = false
	pass # Replace with function body.


func _on_animation_label_text_changed():
	animation = $HBoxContainer/AnimationLabel.text
	pass # Replace with function body.


func _on_select_id_button_up():
	characterIDFilePicker.visible = true
	pass # Replace with function body.


func _on_button_button_up():
	queue_free()
	pass # Replace with function body.
