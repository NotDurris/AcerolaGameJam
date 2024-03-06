extends PlayerState

var blendAmount : float = -1.0

func enter() -> void:
	var jump_forward_vel
	if Input.is_action_pressed("secondary_action"):
		jump_forward_vel = player.get_move_direction() * player.RUNSPEED * 2
	else:
		jump_forward_vel = player.get_move_direction() * player.SPEED * 2
	var jump_vert = player.JUMP_FORCE
	if player.flipped:
		jump_vert *= -1
	player.velocity = Vector3(jump_forward_vel.x, jump_vert, jump_forward_vel.z)
	
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
	if not player.is_on_floor() and player.gravity:
		var falling = false
		if player.flipped:
			falling = 0 < player.velocity.y 
		else:
			falling = player.velocity.y < 0
		if falling:
			player.coyotee_time.start()
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
