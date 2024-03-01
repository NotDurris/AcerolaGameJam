extends Node

@export var btns : Array[Button]
@onready var click_sound := $BtnClick
@onready var hover_sound := $BtnHover

func _ready() -> void:
	for btn in btns:
		btn.connect("pressed", play_click_sound)
		btn.connect("mouse_entered", play_hover_sound)

func play_click_sound():
	click_sound.play()

func play_hover_sound():
	hover_sound.play()
