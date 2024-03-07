extends AnimationPlayer

@export var anim : String

func _ready() -> void:
	play(anim)
