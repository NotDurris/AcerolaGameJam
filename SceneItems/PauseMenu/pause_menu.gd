extends Control

@onready var menu : TextureRect = $MenuBackground
@onready var anim : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	unpause()

func pause():
	get_tree().paused = true
	await set_background()
	anim.play("pause")

func unpause():
	get_tree().paused = false
	anim.play("unpause")

func quit() -> void:
	get_tree().quit()

func set_background():
	await RenderingServer.frame_post_draw
	var viewport_image = get_viewport().get_texture().get_image()
	
	var texture : ImageTexture = ImageTexture.create_from_image(viewport_image)
	
	var texture2d : Texture2D = texture

	menu.texture = texture2d
