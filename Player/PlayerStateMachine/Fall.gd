extends PlayerState

var blendAmount : float = -1.0

func enter() -> void:
	player.landed = false
	player.player_animation.set("parameters/Blend/blend_amount", 1)
	blendAmount = player.player_animation.get("parameters/Jump/blend_position")

func exit() -> void:
	pass

func physics_update(delta : float) -> void:
	
	blendAmount = lerp(blendAmount, 0.0, 3*delta)
	player.player_animation.set("parameters/Jump/blend_position", blendAmount)
	
	if player.is_on_floor():
		state_machine.transition_to("Land")
	else:
		if not player.gravity and player.velocity.y == 0:
			state_machine.transition_to("Land")
	
	player.apply_gravity(delta)
	if Input.is_action_pressed("secondary_action"):
		if player.velocity.length() <= player.RUNSPEED:
			player.set_move_direction(player.get_move_direction() * player.RUNSPEED)
	else:
		if player.velocity.length() <= player.SPEED:
			player.set_move_direction(player.get_move_direction() * player.SPEED)
	player.move_and_slide()
	
	# Handle collisions
	
	# Handle other transitions
	if Input.is_action_just_pressed("primary_action"):
		if not player.coyotee_time.is_stopped():
			state_machine.transition_to("Jump")
		else:
			player.jump_buffer.start()
