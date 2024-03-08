extends Node
class_name Level

signal level_changed(scene_name)

#@export var scene_name : String = "scene"

var parameters_loaded := false

var level_parameters  := {
	"LevelsCompleted" : -1
}

func load_level_parameters(new_level_parameters : Dictionary):
	level_parameters = new_level_parameters
	parameters_loaded = true

func change_scene(target_scene : String) -> void:
	emit_signal("level_changed", target_scene)

func cleanup():
	queue_free()
