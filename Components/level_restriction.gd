extends Node

@export var level : Level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if level.level_parameters["LevelsCompleted"] == 0:
		get_parent().hide()
