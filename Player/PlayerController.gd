extends CharacterBody3D
class_name PlayerController

@export var gravity : bool = true
var landed : bool = true

@onready var player_animation : AnimationTree = $AnimationTree
@onready var player_mesh : Node3D = $Armature
@onready var jump_buffer : Timer = $JumpBuffer
@onready var coyotee_time : Timer = $CoyoteeTime

const SPEED = 2.5
const RUNSPEED = 5
const JUMP_FORCE = 15
const GRAVITY = 64
const PUSH_FORCE = Vector3(1.5,0, 1.5)

var facing : bool = true
var facing_scale : float = 0.0

func apply_gravity(delta : float):
	if gravity:
		velocity.y -= GRAVITY * delta
	else:
		if velocity.y > 0:
			velocity.y = clamp(velocity.y - GRAVITY * delta,0,1000)
		else:
			velocity.y = 0

func set_move_direction(direction : Vector3):
	if direction.x < 0:
		facing = false
	elif direction.x > 0:
		facing = true
	velocity.x = direction.x
	velocity.z = direction.z

func get_move_direction() -> Vector3:
	var horizontal_move_direction = Input.get_axis("left", "right")
	var vertical_move_direction = Input.get_axis("up", "down")
	var move_vector = Vector2(horizontal_move_direction, vertical_move_direction).normalized()
	return Vector3(move_vector.x, 0, move_vector.y)

func _ready() -> void:
	facing_scale = player_mesh.scale.y

func _physics_process(delta: float) -> void:
	if facing:
		player_mesh.scale.y = lerp(player_mesh.scale.y, facing_scale, 5*delta)
	else:
		player_mesh.scale.y = lerp(player_mesh.scale.y, -facing_scale, 5*delta)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		$PauseMenu.pause()
