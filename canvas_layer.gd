extends CanvasLayer

@onready var frog_label = $FrogCounterLabel
@onready var timer_label = $TimerLabel

@onready var start_screen = $StartScreen
@onready var start_button = $StartScreen/StartButton
@onready var instructions_button = $StartScreen/InstructionButton

@onready var instruction_screen = $InstructionScreen
@onready var back_button = $InstructionScreen/BackButton

@onready var end_screen = $EndScreen
@onready var final_score_label = $EndScreen/"Frog Count"

@onready var restart_button = $EndScreen/PlayButton


@export var total_time = 60
var time_left = total_time
var timer_running = false
var frog_count = 0


func _ready():

	print("Instruction screen:", instruction_screen)

	# Show start screen first
	start_screen.visible = true
	instruction_screen.visible = false
	end_screen.visible = false

	# Hide game UI until game starts
	frog_label.visible = false
	timer_label.visible = false

	# Connect buttons
	start_button.pressed.connect(start_game)
	instructions_button.pressed.connect(show_instructions)
	back_button.pressed.connect(back_to_menu)
	restart_button.pressed.connect(restart_game)

	update_frog_count(0)
	update_timer_label()


func _process(delta):

	if timer_running:
		time_left -= delta

		if time_left <= 0:
			time_left = 0
			timer_running = false
			show_end_screen()

		update_timer_label()


# Start game
func start_game():

	start_screen.visible = false
	instruction_screen.visible = false

	frog_label.visible = true
	timer_label.visible = true

	time_left = total_time
	timer_running = true


# Show instructions
func show_instructions():

	start_screen.visible = false
	instruction_screen.visible = true


# Back to menu
func back_to_menu():

	instruction_screen.visible = false
	start_screen.visible = true


# Frog counter
func update_frog_count(new_count):

	frog_count = new_count
	frog_label.text = "Frogs: %d" % frog_count


# Timer UI
func update_timer_label():

	timer_label.text = "Time: %d" % int(time_left)


# End screen
func show_end_screen():

	end_screen.visible = true
	final_score_label.text = "Final Frogs: %d" % frog_count


# Restart
func restart_game():

	get_tree().reload_current_scene()
