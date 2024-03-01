extends Button

@export var level : Level
@export var target_level : String

func _ready() -> void:
	connect("pressed", _on_pressed)

func _on_pressed() -> void:
	level.change_scene(target_level)
