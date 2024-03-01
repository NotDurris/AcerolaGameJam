extends Node

signal level_changed(new_level)

var next_level = Level

@onready var current_level : Level = $MainMenu
@onready var anim = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_level.connect("level_changed", handle_level_changed)
	anim.play("fade_in")

func handle_level_changed(target_next_level_name : String):
	next_level = load("res://Scenes/"+ target_next_level_name +".tscn").instantiate()
	next_level.hide()
	anim.play("fade_out")
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
			anim.play("fade_in")
