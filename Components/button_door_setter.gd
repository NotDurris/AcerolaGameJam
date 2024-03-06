extends Node3D

@onready var button : btn = $Button
@onready var door = $Door

func _ready() -> void:
	door.speed = 5
	door.buttons.append(button)
	door.setup_buttons()
