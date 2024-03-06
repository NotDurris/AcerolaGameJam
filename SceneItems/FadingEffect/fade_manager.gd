extends Node
class_name fade_manager

signal animation_end(animation)

@onready var animator : AnimationPlayer = $AnimationPlayer
@onready var screen_transition : ShaderMaterial = preload("res://Shaders/ScreenShader/scene_transition.tres")

func fade_in():
	animator.play("fade_in")

func fade_out():
	animator.play("fade_out")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	emit_signal("animation_end", anim_name)
	match anim_name:
		"fade_in":
			screen_transition.set_shader_parameter("colour", Colour.line_colour)
