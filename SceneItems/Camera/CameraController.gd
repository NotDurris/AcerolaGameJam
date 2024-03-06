extends Camera3D

@export var look_target : Node3D
@export var position_target : Node3D
@export var move_speed : float
@export_flags_3d_physics var wall_collision_layers : int

@onready var ray_cast = $RayCast3D

var previous_mat

func _ready() -> void:
	global_position = position_target.global_position
	look_at(look_target.global_position)

func _physics_process(delta: float) -> void:
	detect_wall_collision()
	
	look_at(look_target.global_position)
	
	var target_position = Vector3(position_target.global_position.x, global_position.y, position_target.global_position.z)
	global_position = lerp(global_position, target_position, delta * move_speed)
	
	if look_target.landed:
		global_position.y = lerp(global_position.y, position_target.global_position.y, delta)

func detect_wall_collision():
	var query = PhysicsRayQueryParameters3D.new()
	
	query.from = global_position
	query.to = look_target.global_position
	query.collide_with_areas = false
	query.collide_with_bodies = true
	query.collision_mask = wall_collision_layers
	
	var hit_dictionary = get_world_3d().direct_space_state.intersect_ray(query);
	
	if(hit_dictionary):
		var cutout_pos = unproject_position(look_target.global_position + Vector3(0,1,0))
		cutout_pos.y /= get_viewport().size.y
		cutout_pos.x /= get_viewport().size.x
		var collided : StaticBody3D = hit_dictionary.collider
		var mesh : MeshInstance3D = collided.get_child(0)
		previous_mat = mesh.get_active_material(0)
		previous_mat.set_shader_parameter("cutout_size", 0.15)
		previous_mat.set_shader_parameter("cutout_position", cutout_pos)
	else:
		if previous_mat != null:
			previous_mat.set_shader_parameter("cutout_size", 0.0)
			previous_mat = null

