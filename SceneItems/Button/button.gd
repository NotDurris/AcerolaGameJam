extends Node3D
class_name btn

signal pressed
signal released

@export var brittle : bool = false
@export var flipper : bool = false
@export var button_sound : AudioStreamPlayer
@export var brittle_sound : AudioStreamPlayer
var progress : float = 1.0

@onready var btn_mesh = $ButtonMesh

var sources : int :
	set(value):
		sources = clamp(value, 0, 1000)
var active : bool:
	set(value):
		active = value
		if active:
			emit_signal("pressed")
		else:
			emit_signal("released")

func _ready() -> void:
	if brittle:
		Signals.connect("reset", reset)

func reset():
	if brittle:
		sources = 0
		if active:
			active = false
		progress = 1
		show()

func _physics_process(delta: float) -> void:
	if active and progress > 0:
		progress -= 5*delta
	elif progress < 1:
		progress += 5*delta
	
	btn_mesh.position.y = lerp(0.0325, 0.125, progress)
	if brittle and progress <= 0:
		hide()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if active and brittle: return
	if body.is_in_group("Player") || body.is_in_group("box"):
		sources += 1
		if flipper:
			body.flip()
		if sources > 0 and not active:
			if brittle:
				brittle_sound.play()
			button_sound.play()
			active = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if brittle: return
	if body.is_in_group("Player") || body.is_in_group("box"):
		sources -= 1
		if sources <= 0 and active:
			button_sound.play()
			active = false
			sources = 0
