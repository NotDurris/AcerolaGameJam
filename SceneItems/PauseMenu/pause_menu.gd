extends Control

@onready var menu : TextureRect = $MenuBackground
@onready var anim : AnimationPlayer = $AnimationPlayer
@export var bus_name : String

var bus_index: int

var default_vol

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	default_vol = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	unpause()

func pause():
	get_tree().paused = true
	AudioServer.set_bus_effect_enabled(bus_index,1, true)
	await set_background()
	anim.play("pause")

func unpause():
	AudioServer.set_bus_effect_enabled(bus_index,1, false)
	anim.play("unpause")

func set_time_paused_state(value : bool):
	get_tree().paused = value

func quit() -> void:
	get_tree().quit()

func set_background():
	await RenderingServer.frame_post_draw
	var viewport_image = get_viewport().get_texture().get_image()
	
	var texture : ImageTexture = ImageTexture.create_from_image(viewport_image)
	
	var texture2d : Texture2D = texture

	menu.texture = texture2d
