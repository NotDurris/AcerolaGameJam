extends Node

@onready var fading_manager : fade_manager = $FadeManager

var player

func _ready() -> void:
	fading_manager.connect("animation_end", _on_animation_player_animation_finished)

func _on_death_box_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player = body
		fading_manager.fade_out()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"fade_out":
			Signals.emit_signal("reset")
			fading_manager.fade_in()
