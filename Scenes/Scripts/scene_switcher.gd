extends Node

signal level_changed(new_level)

var next_level = Level

@onready var current_level : Level = $MainMenu
@onready var death_fade_manager = $FadeManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	death_fade_manager.connect("animation_end", _on_animation_player_animation_finished)
	current_level.connect("level_changed", handle_level_changed)
	death_fade_manager.fade_in()

func handle_level_changed(target_next_level_name : String):
	get_tree().paused = true
	death_fade_manager.fade_out()
	next_level = load("res://Scenes/Levels/"+ target_next_level_name +".tscn").instantiate()
	next_level.hide()
	next_level.connect("level_changed", handle_level_changed)
	emit_signal("level_changed", target_next_level_name)
	transfer_data_between_scenes(current_level, next_level)

func transfer_data_between_scenes(old_scene : Level, new_scene : Level):
	new_scene.load_level_parameters(old_scene.level_parameters)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"fade_out":
			await current_level.cleanup()
			add_child(next_level)
			current_level = next_level
			current_level.show()
			next_level = null
			get_tree().paused = false
			death_fade_manager.fade_in()
