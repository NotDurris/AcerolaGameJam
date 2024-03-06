extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().connect("visibility_changed", grab_some_foci)
	grab_some_foci()

func grab_some_foci():
	if get_parent().is_visible_in_tree():
		get_parent().grab_focus()
