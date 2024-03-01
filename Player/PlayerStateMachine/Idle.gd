extends PlayerState

var blendAmount : float

func enter() -> void:
	player.velocity = Vector3.ZERO
	
	player.player_animation.set("parameters/Blend/blend_amount", 0)
	blendAmount = player.player_animation.get("parameters/Movement/blend_position")

func exit() -> void:
	pass

func physics_update(delta : float) -> void:
	# Animation control
	blendAmount = lerp(blendAmount, -1.0, 5*delta)
	player.player_animation.set("parameters/Movement/blend_position", blendAmount)
	
	# Check if player is falling
	if not player.is_on_floor():
		if player.velocity.y < 0:
			player.coyotee_time.start()
			state_machine.transition_to("Fall")
	
	# Apply gravity
	player.apply_gravity(delta)
	
	# Apply movement
	player.move_and_slide()
	
	# Handle Collisions
	
	# Handle other transitions
	if Input.is_action_just_pressed("jump") or not player.jump_buffer.is_stopped():
		state_machine.transition_to("Jump")
	if player.get_move_direction() != Vector3.ZERO:
		state_machine.transition_to("Walk")
