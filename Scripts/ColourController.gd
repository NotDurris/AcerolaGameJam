@tool
extends Node

@export var light_mat : ShaderMaterial
@export var mid_mat : ShaderMaterial
@export var dark_mat : ShaderMaterial
@export var screen_mat : ShaderMaterial

@export var colour : Color :
	set(value):
		colour = value
		light_mat.set_shader_parameter("colour", colour*1.5)
		mid_mat.set_shader_parameter("colour", colour)
		dark_mat.set_shader_parameter("colour", colour*0.5)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
