extends Node

@export var level : Level
@export var target_level : String
@export var time : float

@onready var timer : Timer = $Timer

func _ready():
	timer.wait_time = time
	timer.start()

func _on_timer_timeout() -> void:
	level.change_scene(target_level)
