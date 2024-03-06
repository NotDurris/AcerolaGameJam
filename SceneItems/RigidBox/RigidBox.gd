extends CharacterBody3D

class_name RigidBox

@export var gravity : bool = true
@export var conserve_velocity : bool = false

const MAX_SPEED = 20

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		if gravity:
			velocity.y -= 64 * delta
	move_and_slide()
	var ground_velocity = Vector2(velocity.x, velocity.z)
	if ground_velocity != Vector2.ZERO:
		if !conserve_velocity:
			ground_velocity = lerp(ground_velocity, Vector2.ZERO, 0.5)
		velocity.x = ground_velocity.x
		velocity.z = ground_velocity.y

func push_box(direction : Vector3):
	velocity.x = clamp(direction.x, -MAX_SPEED, MAX_SPEED)
	velocity.z = clamp(direction.z, -MAX_SPEED, MAX_SPEED)
