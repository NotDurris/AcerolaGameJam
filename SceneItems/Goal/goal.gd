extends Node3D

@export var level : Level
@export var target_level : String

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		level.change_scene(target_level)
