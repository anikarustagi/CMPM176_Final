extends CanvasLayer

@onready var frog_label = $FrogCounterLabel
@onready var timer_label = $TimerLabel
@onready var end_screen = $EndScreen
@onready var final_score_label = $EndScreen/Label
@onready var restart_button = $EndScreen/Button

@export var total_time = 60  # seconds
var time_left = total_time
var timer_running = true

# Frog counter
var frog_count = 0

func _ready():
	# Hide end screen at start
	end_screen.visible = false
	# Connect button
	restart_button.pressed.connect(restart_game)
	# Initialize labels
	update_frog_count(0)
	update_timer_label()

func _process(delta):
	if timer_running:
		time_left -= delta
		if time_left <= 0:
			time_left = 0
			timer_running = false
			print("Timer done!")
			show_end_screen()
		update_timer_label()

# Frog counter functions
func update_frog_count(new_count): #need to call this in frog function like this: canvas_layer.update_frog_count(new_count)
	frog_count = new_count
	frog_label.text = "Frogs: %d" % frog_count

# Timer functions
func update_timer_label():
	timer_label.text = "Time: %d" % int(time_left)

# End screen functions
func show_end_screen():
	end_screen.visible = true
	final_score_label.text = "Final Frogs: %d" % frog_count
	print("show_end_screen called")         
	print("end_screen node: ", end_screen) 
	print("visible is now: ", end_screen.visible)


func restart_game():
	get_tree().reload_current_scene()
