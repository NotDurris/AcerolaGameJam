extends PlayerState

func enter() -> void:
	player.player_animation.set("parameters/Blend/blend_amount", 0)
	player.player_animation.set("parameters/Movement/blend_position", 0)

func exit() -> void:
	pass

func physics_update(delta : float) -> void:
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
	
	# Apply gravity
	player.apply_gravity(delta)
	player.set_move_direction(player.get_move_direction() * player.SPEED)
	# Apply movement
	player.move_and_slide()
	
		# Handle collisions
	var pushed = false
	if player.get_slide_collision_count() > 0:
		for i in player.get_slide_collision_count():
			var collision = player.get_slide_collision(i)
			var collider = collision.get_collider()
			
			if collider is RigidBox:
				pushed = true
				collider.push_box(-collision.get_normal(0) * player.PUSH_FORCE, player)
	
	# Handle other transitions
	if Input.is_action_just_pressed("primary_action") or not player.jump_buffer.is_stopped():
		state_machine.transition_to("Jump")
	if player.get_move_direction() == Vector3.ZERO:
		state_machine.transition_to("Idle")
	if not pushed and Input.is_action_pressed("secondary_action"):
		state_machine.transition_to("Run")

