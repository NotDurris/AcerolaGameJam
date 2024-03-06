extends PlayerState

var blendAmount : float = -1.0

func enter() -> void:
	var jump_forward_vel = player.velocity * 2
	player.velocity = Vector3(jump_forward_vel.x, player.JUMP_FORCE, jump_forward_vel.z)
	
	player.landed = false
	
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
	else:
		if player.velocity.y == 0:
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
