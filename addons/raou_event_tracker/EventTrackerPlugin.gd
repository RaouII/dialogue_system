@tool
extends EditorPlugin
 
var plugin
func _enter_tree():
	plugin = preload("uid://cr1psvy8isxt").new()
	add_inspector_plugin(plugin)
	print("plugin entered tree")
	# Initialization of the plugin goes here.
	pass


func _exit_tree():
	remove_inspector_plugin(plugin)
	# Clean-up of the plugin goes here.
	pass
