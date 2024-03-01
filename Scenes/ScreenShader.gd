@tool
extends MeshInstance3D

@export var material : Material
@export var target : Node3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	(material as ShaderMaterial).set_shader_parameter("focal_point", target.global_position)
