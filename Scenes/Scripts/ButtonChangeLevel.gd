extends Button

@export var level : Level
@export var target_level : String

func _ready() -> void:
	connect("pressed", _on_pressed)

func _on_pressed() -> void:
	if target_level != "MainMenu":
		Colour.delay_randomise_colour()
	if level == null:
		get_node("/root/SceneSwitcher").current_level.change_scene(target_level)
	else:
		level.change_scene(target_level)
