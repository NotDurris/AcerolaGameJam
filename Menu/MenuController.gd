extends Control
class_name MenuController

signal ScreenChange(id)

@export var screens : Array[Control]

func _ready() -> void:
	change_screen(0)
	connect("ScreenChange", change_screen)

func change_screen(id : int):
	process_mode = Node.PROCESS_MODE_ALWAYS
	for screen in screens:
		if screens.find(screen) != id:
			screen.hide()
		else:
			screen.show()
