extends Label

var cooldown : float = 0.7
var subtraction : float = 0.02

func spiral():
	text += "no "
	add_no()

func add_no():
	await get_tree().create_timer(cooldown).timeout
	cooldown = clamp(cooldown - subtraction,0.01,100)
	subtraction = clamp(cooldown * 0.1,0,cooldown*0.5)
	text += "no "
	add_no()
