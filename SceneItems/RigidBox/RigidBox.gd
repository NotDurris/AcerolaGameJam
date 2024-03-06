extends CharacterBody3D

class_name RigidBox

@export var gravity : bool = true
@export var conserve_velocity : bool = false
@export var flipped : bool = false
@export var sticky : bool = false

var stuck_body : CharacterBody3D

const MAX_SPEED = 20

func _ready() -> void:
	determine_flip()

func determine_flip():
	if flipped:
		up_direction = Vector3.DOWN
	else:
		up_direction = Vector3.UP

func flip():
	flipped = not flipped
	determine_flip()

func _physics_process(delta: float) -> void:
	if sticky and stuck_body != null:
		var dir = (stuck_body.global_position - global_position).length()
		if dir > 1.2:
			stuck_body = null
		else:
			velocity.x = stuck_body.velocity.x
			velocity.z = stuck_body.velocity.z
	
	if not is_on_floor() and gravity:
		if flipped:
			velocity.y += 64 * delta
		else:
			velocity.y -= 64 * delta
	if not gravity:
		velocity.y = 0
	move_and_slide()
	var ground_velocity = Vector2(velocity.x, velocity.z)
	if ground_velocity != Vector2.ZERO:
		if !conserve_velocity:
			ground_velocity = lerp(ground_velocity, Vector2.ZERO, 0.5)
		velocity.x = ground_velocity.x
		velocity.z = ground_velocity.y

func push_box(direction : Vector3, body : CharacterBody3D):
	velocity.x = clamp(direction.x, -MAX_SPEED, MAX_SPEED)
	velocity.z = clamp(direction.z, -MAX_SPEED, MAX_SPEED)
	if sticky:
		stuck_body = body
