class_name EventObjective extends Resource

@export var objective_text: String
var completed: bool = false
#var required_item: Item

func _set_objective_active():
	pass
	#Global.grabbed_item.connect(on_item_collected)
	
#func on_item_collected(_item: Item):
	#if _item == required_item:
		#completed = true
