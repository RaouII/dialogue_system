# random_int_editor.gd
extends EditorProperty

#const ENUM_DROP_DOWN = preload("uid://dtd5qiksiw8ia")
# The main control for editing the property.
var property_control = preload("uid://dtd5qiksiw8ia").instantiate() as OptionButton
# An internal value of the property.
var current_value = preload("uid://beuxf1qqtjhqn").new() as EventStageList
# A guard against internal changes when the property is updated.
var updating = false

func _create_array(_array: Array[EventStage]) -> Array:
	var array: Array
	for i in _array:
		array.append(i._name)
	return array


func _init(obj):
	var array: Array
	if obj is Event:
		array = _create_array(obj.stages)	
	if obj is SetEventStage:
		if obj._event != null:
			array = _create_array(obj._event.stages)
	if obj is EventStageCondition:
		if obj.event != null:
			array = _create_array(obj.event.stages)
	if obj is StageBetweenCondition:
		if obj.eventStage1 == null:
			if obj.event1 != null:
				array = _create_array(obj.event1.stages)
		else:
			if obj.event2 != null:
				array = _create_array(obj.event2.stages)
				

	property_control.feed_items(array)
	# Add the control as a direct child of EditorProperty node.
	add_child(property_control)
	# Make sure the control is able to retain the focus.
	add_focusable(property_control)
	property_control.item_selected.connect(_on_item_selected)


func _on_item_selected(index):
	print(index)
	# Ignore the signal if the property is currently being updated.
	if (updating):
		return
	#current_value.selected_option = property_control.get_item_text(index) 
	current_value.selected_index = property_control.get_item_index(index) 
	emit_changed(get_edited_property(), current_value)


func _update_property():
	print(get_edited_object())
	# Read the current value from the property.
	var new_value = get_edited_object()[get_edited_property()]
	
	if new_value:
		new_value = new_value as EventStageList
		for i in property_control.item_count:
			#if new_value.selected_option == property_control.get_item_text(i):
				#property_control.select(i)
			if new_value.selected_index == property_control.get_item_index(i):
				property_control.select(i)
		return
		updating = true
		current_value = new_value
		updating = false
