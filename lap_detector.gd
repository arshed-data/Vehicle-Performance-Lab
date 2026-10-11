extends Area3D

var lap_count = 0
var can_count_lap = true

var timer_running = false
var current_lap_time = 0.0
var best_lap_time = 0.0

@onready var lap_label = $"../HUD/LapLabel"
@onready var current_lap_label = $"../HUD/CurrentLapLabel"
@onready var last_lap_label = $"../HUD/LastLapLabel"
@onready var best_lap_label = $"../HUD/BestLapLabel"


func _ready():
	lap_label.text = "LAP: 0"
	current_lap_label.text = "CURRENT: 0.00 s"
	last_lap_label.text = "LAST: -- s"
	best_lap_label.text = "BEST: -- s"

	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _process(delta):

	if timer_running:
		current_lap_time += delta
		current_lap_label.text = "CURRENT: %.2f s" % current_lap_time


func _on_body_entered(body):

	if body.name == "Car" and can_count_lap:

		can_count_lap = false

		# FIRST CROSSING = START LAP 1
		if lap_count == 0:

			lap_count = 1
			current_lap_time = 0.0
			timer_running = true

			lap_label.text = "LAP: 1"

		# NEXT CROSSINGS = FINISH OLD LAP + START NEW LAP
		else:

			var finished_lap_time = current_lap_time

			last_lap_label.text = "LAST: %.2f s" % finished_lap_time

			# Update best lap
			if best_lap_time == 0.0 or finished_lap_time < best_lap_time:
				best_lap_time = finished_lap_time
				best_lap_label.text = "BEST: %.2f s" % best_lap_time

			lap_count += 1
			lap_label.text = "LAP: " + str(lap_count)

			current_lap_time = 0.0


func _on_body_exited(body):

	if body.name == "Car":
		can_count_lap = true
		
