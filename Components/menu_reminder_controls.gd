extends Label

@export var keyboard_text : String
@export var controller_text : String

func _ready() -> void:
	if Variables.using_controller:
		text = controller_text
	else:
		text = keyboard_text

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey or event is InputEventMouseMotion:
		text = keyboard_text
		Variables.using_controller = false
	elif event is InputEventJoypadButton or event is InputEventJoypadMotion:
		text = controller_text
		Variables.using_controller = true
	
