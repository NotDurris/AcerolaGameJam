extends Button

@onready var fading_manager : fade_manager = $FadeManager

func _ready() -> void:
	connect("pressed", _on_pressed)
	fading_manager.connect("animation_end", _on_animation_player_animation_finished)

func _on_pressed() -> void:
	fading_manager.fade_out()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"fade_out":
			Signals.emit_signal("reset")
			fading_manager.fade_in()
