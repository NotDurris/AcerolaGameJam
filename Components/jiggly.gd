extends RichTextLabel

@export var level : Level
@export var actual_text : String

func _ready():
	var levels_completed = level.level_parameters["LevelsCompleted"]
	text = "[center][shake rate="+ str(10+(levels_completed * 0.1)) +" level="+ str(10+(levels_completed * 2)) +"]" + actual_text

