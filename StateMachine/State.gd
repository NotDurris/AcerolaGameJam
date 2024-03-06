extends Node

class_name State

var state_machine = null

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

# Called by state machine when entering this state
func enter() -> void:
	pass

# Called by state machine when eciting the state used for cleanup
func exit() -> void:
	pass
