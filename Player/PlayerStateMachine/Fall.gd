extends PlayerState

var blendAmount : float = -1.0

func enter() -> void:
	pass
	player.player_animation.set("parameters/Blend/blend_amount", 1)
	blendAmount = player.player_animation.get("parameters/Jump/blend_position")

func exit() -> void:
	pass

func physics_update(delta : float) -> void:
	
	blendAmount = lerp(blendAmount, 0.0, 3*delta)
	player.player_animation.set("parameters/Jump/blend_position", blendAmount)
	# Determine walk direction
	var horizontal_move_direction = Input.get_axis("left", "right")
	var vertical_move_direction = Input.get_axis("up", "down")
	
	if player.is_on_floor():
		state_machine.transition_to("Land")
	
	player.apply_gravity(delta)
	if Input.is_action_pressed("run"):
		player.set_move_direction(player.get_move_direction() * player.RUNSPEED)
	else:
		player.set_move_direction(player.get_move_direction() * player.SPEED)
	player.move_and_slide()
	
	# Handle collisions
	
	# Handle other transitions
	if Input.is_action_just_pressed("jump"):
		if not player.coyotee_time.is_stopped():
			state_machine.transition_to("Jump")
		else:
			player.jump_buffer.start()
