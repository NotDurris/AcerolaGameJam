extends Node3D

@export var buttons : Array[btn]
@export var reverse : bool
@export var preset : bool = true
@export var speed : float = 1.0

@export var pushable : bool = false
var body : CharacterBody3D

var progress : float = 0.0

@onready var door_body = $StaticBody3D

var opened : bool = false
var sources : int:
	set(value):
		sources = value
		if sources > 0:
			opened = true
		else:
			opened = false

func _ready():
	if pushable:
		add_to_group("box")
		if $StaticBody3D is CharacterBody3D:
			body = $StaticBody3D
		else:
			print("WARNING: door not characterbody3D")
	move_to_start_pos()
	Signals.connect("reset", move_to_start_pos)
	setup_buttons()

func setup_buttons():
	for button in buttons:
		if button == null:
			print("WARNING door button set to null " + get_node(".").name)
			continue
		button.connect("pressed", add_state)
		button.connect("released", remove_state)

func move_to_start_pos():
	# Get Current State
	var state = opened
	# If reverse and preset
	if reverse:
		state = !state
	if preset:
		state = !reverse
	if state:
		progress = 1.0
	else:
		progress = 0.0
	door_body.scale.y = lerp(0.001, 1.0, progress)
	door_body.position.y = lerp(-0.5, 0.0, progress)

func _physics_process(delta: float) -> void:
	var state = opened
	if reverse:
		state = !state
	if state:
		if progress > 0:
			progress -= delta * speed / scale.y
		else:
			progress = 0
	else:
		if progress < 1:
			progress += delta * speed / scale.y
		else:
			progress = 1
	
	door_body.scale.y = lerp(0.001, 1.0, progress)
	door_body.position.y = lerp(-0.5, 0.0, progress)

func add_state():
	sources += 1

func remove_state():
	sources -= 1

func push_box(direction : Vector3, _body : CharacterBody3D):
	var MAX_SPEED = 20.0
	body.velocity.x = clamp(direction.x, -MAX_SPEED, MAX_SPEED)
	body.velocity.z = clamp(direction.z, -MAX_SPEED, MAX_SPEED)
