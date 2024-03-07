extends Control

@export var level : Level
@export var level_buttons : Array[Button]

func _ready() -> void:
	var levels_completed = level.level_parameters["LevelsCompleted"]
	for button in level_buttons:
		if level_buttons.find(button,0) <= levels_completed:
			button.disabled = false
			button.show()
		else:
			button.disabled = true
			button.hide()
