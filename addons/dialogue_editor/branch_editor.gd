@tool
extends Control

@onready var graph_edit = $GraphEdit
const TOPIC_GRAPH_NODE = preload("uid://jsd763hsqsc6")
var init_pos = Vector2(100,100)
var node_index = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _add_topic_node() -> void:
	print_debug("adding new node")
	var node = TOPIC_GRAPH_NODE.instantiate()
	node.position_offset = init_pos + (node_index * Vector2(40, 40))
	graph_edit.add_child(node)
	node_index += 1
	
func _on_button_pressed() -> void:
	print_debug("pressing button new node")
	call_deferred("_add_topic_node")
