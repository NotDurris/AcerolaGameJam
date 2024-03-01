extends State

class_name PlayerState

var player: PlayerController

func _ready() -> void:
	await owner.ready
	
	player = owner as PlayerController
	
	assert(player!=null)
