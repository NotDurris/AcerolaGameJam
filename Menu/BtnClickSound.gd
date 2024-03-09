extends Node

@export var btns : Array[Button]
@onready var click_sound := $BtnClick

func _ready() -> void:
	for button in btns:
		button.connect("pressed", play_click_sound)

func play_click_sound():
	click_sound.play()
