extends Node

@onready var SceneManager := $".."

@export var music_components : Array[AudioStreamPlayer]

#var active_list : Array[bool]
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#process_mode = Node.PROCESS_MODE_ALWAYS
	#for audio in music_components:
		#active_list.append(true)
	#active_list[1] = false
	#change_volume()
	#$"..".connect("level_changed", update_components)
#
#func update_components(current_level_name : String):
	#match current_level_name:
		#"MainMenu":
			#active_list[0] = true
			#active_list[1] = false
		#"Game":
			#active_list[0] = true
			#active_list[1] = true
		#"EndScreen":
			#active_list[0] = true
			#active_list[1] = false
		#_:
			#print("Level: ", current_level_name, " not found")
			#return
	#change_volume()
#
#func change_volume():
	#for i in range(music_components.size()):
		#var audio = music_components[i]
		#var active = active_list[i]
		#if !active:
			#if audio.volume_db != -80:
				#var tween = create_tween()
				#tween.tween_property(audio, "volume_db", -80, 1)
		#else:
			#var tween = create_tween()
			#tween.tween_property(audio, "volume_db", -15, 1)
