extends Camera3D

@export var look_target : CharacterBody3D
@export var position_target : Node3D
@export var move_speed : float

func _ready() -> void:
	global_position = position_target.global_position
	look_at(look_target.global_position)

func _physics_process(delta: float) -> void:
	look_at(look_target.global_position)
	
	var target_position = Vector3(position_target.global_position.x, global_position.y, position_target.global_position.z)
	global_position = lerp(global_position, target_position, delta * move_speed)
	
	if look_target.is_on_floor():
		global_position.y = lerp(global_position.y, position_target.global_position.y, delta)
