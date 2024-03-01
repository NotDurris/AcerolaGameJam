extends Node

class_name State

var state_machine = null

func handle_input(event: InputEvent) -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass

# Called by state machine when entering this state
func enter() -> void:
	pass

# Called by state machine when eciting the state used for cleanup
func exit() -> void:
	pass
