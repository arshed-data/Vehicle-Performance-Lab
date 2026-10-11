extends CanvasLayer

@onready var car = $"../Car"
@onready var speed_label = $SpeedLabel
@onready var throttle_label = $ThrottleLabel
@onready var brake_label = $BrakeLabel
@onready var acceleration_label = $AccelerationLabel
@onready var zero_to_thirty_label = $ZeroToThirtyLabel
@onready var brake_distance_label = $BrakeDistanceLabel
@onready var brake_time_label = $BrakeTimeLabel

var braking_test_running = false
var brake_start_position = Vector3.ZERO
var brake_start_speed = 0.0
var braking_time = 0.0
var previous_speed = 0.0
var test_running = false
var test_time = 0.0
var test_finished = false

func _process(delta):

	# SPEED
	var speed_kmh = abs(car.speed) * 3.6
	speed_label.text = str(round(speed_kmh)) + " km/h"

	# THROTTLE
	if Input.is_key_pressed(KEY_UP):
		throttle_label.text = "THROTTLE: 100%"
	else:
		throttle_label.text = "THROTTLE: 0%"

	# BRAKE
	if Input.is_key_pressed(KEY_DOWN):
		brake_label.text = "BRAKE: 100%"
	else:
		brake_label.text = "BRAKE: 0%"

	# ACCELERATION
	var acceleration = (car.speed - previous_speed) / delta
	acceleration_label.text = "ACCELERATION: %.1f m/s²" % acceleration

	previous_speed = car.speed
		# 0-30 KM/H TEST
	if speed_kmh < 1.0 and not test_running:
		test_time = 0.0
		test_finished = false
		zero_to_thirty_label.text = "0-30 km/h: READY"

	if Input.is_key_pressed(KEY_UP) and speed_kmh < 1.0 and not test_running:
		test_running = true
		test_time = 0.0

	if test_running:
		test_time += delta
		zero_to_thirty_label.text = "0-30 km/h: %.2f s" % test_time

	if test_running and speed_kmh >= 30.0:
		test_running = false
		test_finished = true
		zero_to_thirty_label.text = "0-30 km/h: %.2f s" % test_time
		
		# BRAKING PERFORMANCE TEST

	var brake_pressed = Input.is_key_pressed(KEY_DOWN)

	# Start measuring when braking begins
	if brake_pressed and car.speed > 1.0 and not braking_test_running:

		braking_test_running = true
		brake_start_position = car.global_position
		brake_start_speed = car.speed * 3.6
		braking_time = 0.0

	# Measure only while brake is held
	if braking_test_running:

		if brake_pressed and car.speed > 0.1:

			braking_time += delta

			var current_distance = brake_start_position.distance_to(car.global_position)

			brake_distance_label.text = "BRAKING DISTANCE: %.2f m" % current_distance
			brake_time_label.text = "BRAKING TIME: %.2f s" % braking_time

		else:

			# Brake released OR car stopped
			braking_test_running = false

			var final_distance = brake_start_position.distance_to(car.global_position)

			brake_distance_label.text = "BRAKING DISTANCE: %.2f m" % final_distance
			brake_time_label.text = "BRAKING TIME: %.2f s" % braking_time
