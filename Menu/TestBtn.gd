extends Button

@export var sound : AudioStreamPlayer


func _on_pressed() -> void:
	sound.play()
