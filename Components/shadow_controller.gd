extends RayCast3D

@export var shadow : MeshInstance3D
@export var dist : float

var default_scale : Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	default_scale = shadow.scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_colliding():
		var progress = clamp((get_collision_point() - global_position).length() / dist,0.0,1.0)
		shadow.scale = Vector3(default_scale.x * (1-progress), default_scale.y, default_scale.z * (1-progress))
		if progress < 1:
			shadow.global_position = get_collision_point()
			shadow.global_transform.basis = align_up(shadow.global_transform.basis, get_collision_normal())

func align_up(node_basis, normal):
	var result = Basis()
	var rscale = node_basis.get_scale() # Only if your node might have a scale other than (1,1,1)

	result.x = normal.cross(node_basis.z)
	result.y = normal
	result.z = node_basis.x.cross(normal)

	result = result.orthonormalized()
	result.x *= rscale.x 
	result.y *= rscale.y 
	result.z *= rscale.z 

	return result
