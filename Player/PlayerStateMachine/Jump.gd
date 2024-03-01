extends PlayerState

var blendAmount : float = -1.0

func enter() -> void:
	player.velocity.y = player.JUMP_FORCE
	
	player.player_animation.set("parameters/Blend/blend_amount", 1)
	player.player_animation.set("parameters/Jump/blend_position", -1)
	blendAmount = -1.0

func exit() -> void:
	pass

func physics_update(delta : float) -> void:
	blendAmount = lerp(blendAmount, 0.0, 5*delta)
	player.player_animation.set("parameters/Jump/blend_position", blendAmount)
	# Check if player is falling
	if not player.is_on_floor():
		if player.velocity.y <= 0:
			state_machine.transition_to("Fall")
	
	player.apply_gravity(delta)
	if Input.is_action_pressed("run"):
		player.set_move_direction(player.get_move_direction() * player.RUNSPEED)
	else:
		player.set_move_direction(player.get_move_direction() * player.SPEED)
	player.move_and_slide()
	
	# Handle collisions
