extends Button

var full : bool = false

func _ready() -> void:
	connect("pressed", _on_pressed)

func _on_pressed() -> void:
	if full:
		windowed()
	else:
		fullscreen()
	full = !full

func windowed():
	text = "fullscreen"
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func fullscreen():
	text = "window"
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
