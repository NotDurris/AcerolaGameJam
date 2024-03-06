extends Node

@export var controller_body : PlayerController
@export var remoted_bodies : Array[CharacterBody3D]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var move_vector = controller_body.get_move_direction()
	for body in remoted_bodies:
		if body == null: continue
		if move_vector.x != 0:
			body.velocity.x = move_vector.x
		if controller_body.velocity.y > 0:
			body.velocity.y = controller_body.velocity.y
		if move_vector.z != 0:
			body.velocity.z = move_vector.z
