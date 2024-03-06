extends Node

var start_flip : bool

func _ready():
	Signals.connect("reset", reset)
	start_flip = get_parent().flipped
	
func reset():
	get_parent().flipped = start_flip
	get_parent().determine_flip()
