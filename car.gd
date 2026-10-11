extends CharacterBody3D

var speed = 0.0

var acceleration = 1.0
var max_speed = 8.0
var brake_strength = 6.0
var coast_deceleration = 0.5
var steering_speed = 0.8


func _physics_process(delta):

	# ACCELERATION
	if Input.is_key_pressed(KEY_UP):
		speed += acceleration * delta

	# BRAKING
	elif Input.is_key_pressed(KEY_DOWN):
		speed = move_toward(speed, 0.0, brake_strength * delta)

	# COASTING
	else:
		speed = move_toward(speed, 0.0, coast_deceleration * delta)

	# SPEED LIMIT
	speed = clamp(speed, 0.0, max_speed)

	# STEERING
	if Input.is_key_pressed(KEY_LEFT):
		rotate_y(steering_speed * delta)

	if Input.is_key_pressed(KEY_RIGHT):
		rotate_y(-steering_speed * delta)

	# MOVEMENT
	velocity = -transform.basis.z * speed

	move_and_slide()
