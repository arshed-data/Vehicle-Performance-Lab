extends Node

@onready var car = $"../Car"

var recording_time = 0.0
var sample_timer = 0.0
var previous_speed = 0.0

var file

func _ready():
	file = FileAccess.open("user://telemetry.csv", FileAccess.WRITE)

	if file == null:
		push_error("Could not create telemetry file")
		set_process(false)
		return

	file.store_line("time,speed_kmh,acceleration,throttle,brake")


func _process(delta):
	recording_time += delta
	sample_timer += delta

	if sample_timer < 0.1:
		return

	var interval = sample_timer
	sample_timer = 0.0

	var speed = car.speed
	var speed_kmh = abs(speed) * 3.6
	var acceleration = (speed - previous_speed) / interval

	var throttle = int(Input.is_key_pressed(KEY_UP))
	var brake = int(Input.is_key_pressed(KEY_DOWN))

	file.store_csv_line([
		str(recording_time),
		str(speed_kmh),
		str(acceleration),
		str(throttle),
		str(brake)
	])

	previous_speed = speed


func _exit_tree():
	if file != null:
		file.close()
