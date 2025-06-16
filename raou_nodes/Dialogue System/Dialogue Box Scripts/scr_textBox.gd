extends MarginContainer


@onready var timer: Timer = $LetterDisplayTimer
@onready var container: VBoxContainer = $VBoxContainer
var default_portrait: Texture2D = preload("uid://c8qvcguwevbq6")
@onready var window_skin: NinePatchRect = $NinePatchRect

#const TOPIC_TEST = preload("res://Dialogue System/Graph Editor Test/topic_test.tres")

const MAX_WIDTH = 256

var text: String
var letter_index = 0

var letter_time = 0.03
var space_time = 0.05
var punctuation_time = 0.02

var choices
var choice_container
var response_container

signal finished_displaying()

func display_text(text_to_display: String, _charInfo: CharacterID = null):
	text = text_to_display
	response_container.label.text = text_to_display
	if _charInfo != null:
		pass
		#response_container.portrait_texture.texture = _charInfo.portrait
		
	else:
		pass
		#response_container.portrait_texture.texture = default_portrait
	#window_skin.set_instance_shader_parameter("shader_parameter/replace_color",Color(1.0,0.0,0.0,1.0))
	await resized
	custom_minimum_size.x = min(size.x,MAX_WIDTH)
	if size.x > MAX_WIDTH:
		response_container.label.autowrap_mode = TextServer.AUTOWRAP_WORD
		#await resized # await for x resize
		#await resized # await for y resize
	#	print("break point")
		custom_minimum_size.y = size.y
	print(size)
	global_position.x -= size.x/2
	global_position.y -= size.y + 96
	response_container.label.text = ""
	#var txt: RichTextLabel
	#response_container.label.text.size = size
	display_letter()
	
func display_letter():
	#global_position.y += size.y + 48
	response_container.label.text += text[letter_index]
#	print("display_letter")
	letter_index +=1
	if letter_index >= text.length():
		finished_displaying.emit()
#		print("finished_displaying")
		return
#	print("display_letter")
	match text[letter_index]:
		"!",".",",","?":
#			print("punctuation_time")
			timer.start(punctuation_time)
		" ":
#			print("space_time")
			timer.start(space_time)
		_:
#			print("letter_time")
			timer.start(letter_time)

func _ready() -> void:
	#Dialogue.text_box = self ### ONLY FOR TESTING, DELETE LATER
	#Dialogue.display_topic(TOPIC_TEST)
	pass



func _on_letter_display_timer_timeout() -> void:
	display_letter()
	pass # Replace with function body.
