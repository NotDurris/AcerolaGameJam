extends Button

@export var target_screenID : int
@export var menu_controller : MenuController

func _ready() -> void:
	connect("pressed", on_click)

func on_click():
	menu_controller.emit_signal("ScreenChange", target_screenID)
