extends Node

@export var level : Level
@export var target_level : String
@export var time : float
@export var level_completed : int

@onready var timer : Timer = $Timer

func _ready():
	timer.wait_time = time
	timer.start()

func _on_timer_timeout() -> void:
	if level.level_parameters["LevelsCompleted"] < level_completed:
		level.level_parameters["LevelsCompleted"] = level_completed
	level.change_scene(target_level)
