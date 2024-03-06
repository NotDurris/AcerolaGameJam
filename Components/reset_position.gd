extends Node

var start_position

func _ready():
	start_position = get_parent().global_position
	Signals.connect("reset", reset)
	
func reset():
	get_parent().global_position = start_position
