@tool
extends GraphNode

func _on_add_condition_pressed() -> void:
	if not Engine.is_editor_hint():
		return
	var entry := _create_resource_entry("Condition")
	$"Conditions Container/VBoxContainer".add_child(entry)

func _on_add_function_pressed() -> void:
	if not Engine.is_editor_hint():
		return
	var entry := _create_resource_entry("Function")
	$"Functions Container/VBoxContainer".add_child(entry)

func _create_resource_entry(resource_type: String) -> VBoxContainer:
	var vbox := VBoxContainer.new()

	# HBox holds arrow toggle and resource picker
	var hbox := HBoxContainer.new()
	var toggle := Button.new()
	toggle.text = "▶"
	toggle.toggle_mode = true
	toggle.focus_mode = Control.FOCUS_NONE
	toggle.size_flags_horizontal = Control.SIZE_SHRINK_CENTER

	var picker := EditorResourcePicker.new()
	picker.base_type = resource_type
	picker.editable = true
	picker.set_custom_minimum_size(Vector2(200, 24))

	hbox.add_child(toggle)
	hbox.add_child(picker)
	vbox.add_child(hbox)

	var inspector_container := VBoxContainer.new()
	inspector_container.size_flags_vertical = Control.SIZE_EXPAND_FILL
	vbox.add_child(inspector_container)

	# Shared state holder with inspector instance saved
	var entry_data := {
		"resource": null,
		"inspector_container": inspector_container,
		"toggle": toggle,
		"inspector": null
	}

	# When a resource is selected
	picker.resource_changed.connect(func(resource: Resource) -> void:
		entry_data.resource = resource
		if entry_data.inspector:
			entry_data.inspector.edit(entry_data.resource)
		elif toggle.button_pressed and entry_data.resource:
			entry_data.inspector = EditorInspector.new()
			entry_data.inspector.edit(entry_data.resource)
			entry_data.inspector.size_flags_vertical = Control.SIZE_EXPAND_FILL
			entry_data.inspector.custom_minimum_size = Vector2(200, 150)
			entry_data.inspector_container.add_child(entry_data.inspector)
		
		if toggle.button_pressed and entry_data.inspector:
			entry_data.inspector.show()
		elif entry_data.inspector:
			entry_data.inspector.hide()

	)

	# When toggle is clicked
	toggle.toggled.connect(func(pressed: bool) -> void:
		if pressed and entry_data.resource:
			if not entry_data.inspector:
				entry_data.inspector = EditorInspector.new()
				entry_data.inspector.edit(entry_data.resource)
				entry_data.inspector.size_flags_vertical = Control.SIZE_EXPAND_FILL
				entry_data.inspector.custom_minimum_size = Vector2(200, 150)
				entry_data.inspector_container.add_child(entry_data.inspector)
			else:
				entry_data.inspector.show()
			toggle.text = "▼"
		else:
			if entry_data.inspector:
				entry_data.inspector.hide()
			toggle.text = "▶"
	)

	return vbox

func _clear_container(container: VBoxContainer) -> void:
	for child in container.get_children():
		child.queue_free()
#@tool
#extends GraphNode
#
#const QUESTCONDITION_GRAPH_NODE = preload("uid://dt72t8ps3u0pn")
#
#var _function_inspector: EditorInspector = null
#var _condition_inspector: EditorInspector = null
#
#
#func _on_add_condition_pressed() -> void:
	#if not Engine.is_editor_hint():
		#return  # Only do this in the editor
	#var resource_picker = EditorResourcePicker.new()
	#resource_picker.base_type = "Condition"  # restrict to your Function resource
	##resource_picker.allow_empty = false
	#resource_picker.editable = true  # allows creating new resources on the fly
	#resource_picker.set_custom_minimum_size(Vector2(200, 24))
	## Optional: connect signal if you want to react to changes
	#resource_picker.resource_changed.connect(_on_condition_resource_changed)
	#$"Conditions Container/VBoxContainer".add_child(resource_picker)
#
#
#
#func _on_add_function_pressed() -> void:
	#if not Engine.is_editor_hint():
		#return  # Only do this in the editor
	#var resource_picker = EditorResourcePicker.new()
	#resource_picker.base_type = "Function"  # restrict to your Function resource
	##resource_picker.allow_empty = false
	#resource_picker.editable = true  # allows creating new resources on the fly
	#resource_picker.set_custom_minimum_size(Vector2(200, 24))
	## Optional: connect signal if you want to react to changes
	#resource_picker.resource_changed.connect(_on_function_resource_changed)
	#$"Functions Container/VBoxContainer".add_child(resource_picker)
#
#func _on_function_resource_changed(resource: Resource) -> void:
	#print("Function selected: ", resource)
#
	## Remove old inspector if any
	#if _function_inspector:
		#_function_inspector.queue_free()
		#_function_inspector = null
#
	## Create and show new inspector
	#_function_inspector = EditorInspector.new()
	#_function_inspector.edit(resource)
	#_function_inspector.show_top_editor = false  # optional: hides the class dropdown
	#$"Functions Container/VBoxContainer".add_child(_function_inspector)
	#_function_inspector.update()
	#_function_inspector.refresh()
#
#func _on_condition_resource_changed(resource: Resource) -> void:
	#print("Condition selected: ", resource)
#
	#if _condition_inspector:
		#_condition_inspector.queue_free()
		#_condition_inspector = null
#
	#_condition_inspector = EditorInspector.new()
	#_condition_inspector.edit(resource)
	#_condition_inspector.set_anchors_preset(Control.PRESET_TOP_WIDE)
	#_condition_inspector.custom_minimum_size = Vector2(200, 200)
	#_condition_inspector.name = "ConditionInspector"
	#$"Conditions Container/VBoxContainer".add_child(_condition_inspector)
	##_condition_inspector.update()
	##_condition_inspector.refresh()
