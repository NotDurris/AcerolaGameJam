extends PlayerState

var blendAmount : float = 0.0

func enter() -> void:
	player.player_animation.set("parameters/Blend/blend_amount", 1)
	blendAmount = player.player_animation.get("parameters/Jump/blend_position")

func exit() -> void:
	pass

func physics_update(delta : float) -> void:
	# Animation control
	blendAmount = lerp(blendAmount, 1.0, 5*delta)
	player.player_animation.set("parameters/Jump/blend_position", blendAmount)
	
	if blendAmount >= 0.65:
		state_machine.transition_to("Idle")
	
	player.apply_gravity(delta)
	if Input.is_action_pressed("run"):
		player.set_move_direction(player.get_move_direction() * player.RUNSPEED)
	else:
		player.set_move_direction(player.get_move_direction() * player.SPEED)
	player.move_and_slide()

