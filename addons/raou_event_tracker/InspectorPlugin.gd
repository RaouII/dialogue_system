# my_inspector_plugin.gd
extends EditorInspectorPlugin

var EnumEditorProperty = preload("uid://cm8lf6hfxvbda")


func _can_handle(object):
	if object is SetEventStage:
		return true
	if object is EventStageCondition:
		return true
	elif object is Event:
		return true 



func _parse_property(object, type, name, hint_type, hint_string, usage_flags, wide):
	print(object)
	if hint_string == "EventStageList":
		add_property_editor(name, EnumEditorProperty.new(object))
		return true
		print("yey")
	pass
