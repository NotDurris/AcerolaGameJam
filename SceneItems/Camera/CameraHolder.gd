extends RemoteTransform3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	remote_path = get_viewport().get_camera_3d().get_path()
