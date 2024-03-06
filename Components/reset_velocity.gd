extends Node

func _ready():
	Signals.connect("reset", reset)
	
func reset():
	get_parent().velocity = Vector3.ZERO
