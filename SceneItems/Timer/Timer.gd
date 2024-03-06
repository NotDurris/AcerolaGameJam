extends Control

@export var start_time : float = 10
var time : float
@export var death_manager : DeathManager

@onready var label : Label = $Label

var stop_processing : bool = false

func _ready() -> void:
	time = start_time
	Signals.connect("reset", reset)

func reset():
	time = start_time
	stop_processing = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if stop_processing: return
	time -= delta
	label.text = str(time).pad_decimals(2)
	if time <= 0:
		stop_processing = true
		label.text = "0.00"
		death_manager.fading_manager.fade_out()
