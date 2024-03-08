extends Node

class_name pam

@export var audio_array : Array[AudioStreamPlayer]

func play_audio(id : int, pitch : float):
	var asp : AudioStreamPlayer = audio_array[id]
	asp.pitch_scale = pitch
	asp.play()
