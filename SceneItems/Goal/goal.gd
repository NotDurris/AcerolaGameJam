extends Node3D

@export var level : Level
@export var target_level : String
@export var level_completed : int

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		if level.level_parameters["LevelsCompleted"] < level_completed:
			level.level_parameters["LevelsCompleted"] = level_completed
		level.change_scene(target_level)
