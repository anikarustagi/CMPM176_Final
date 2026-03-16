extends Camera2D

@onready var player = get_node("../Player") # change "Player" to whatever your player node is named

func _process(delta):
	global_position = lerp(global_position, player.global_position, 0.1)
