extends Node
class_name SoundManager
@export var sounds : Array[AudioStreamPlayer]

var default_pitches : Array[float]

func _ready() -> void:
	for sound in sounds:
		default_pitches.append(sound.pitch_scale)

func play_sound(id : int):
	var targetSound = sounds[id]
	var targetPitch = default_pitches[id]
	if !targetSound.playing:
		targetSound.pitch_scale = targetPitch + randf_range(-0.2,0.5)
		targetSound.play()
