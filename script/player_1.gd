extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
# You might want to adjust this value based on your game's layout
const FALL_THRESHOLD = 1000.0  # Y-position where game restarts if exceeded

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	# Check if character has fallen out of the scene
	if position.y > FALL_THRESHOLD or position.x > FALL_THRESHOLD:
		restart_game()

func restart_game() -> void:
	# This reloads the current scene
	get_tree().reload_current_scene()
