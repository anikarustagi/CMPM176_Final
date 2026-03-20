extends Area2D

@export var tile_size = 64
@export var grid_width = 14
@export var grid_height = 10

func _ready():
	randomize()
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size / 2

func move_to_random_tile(player_pos: Vector2) -> void:
	var valid_spot = false
	
	while !valid_spot:
		var random_x = randi_range(0, grid_width - 1)
		var random_y = randi_range(0, grid_height - 1)
		
		var new_position = Vector2(random_x * tile_size, random_y * tile_size)
		new_position += Vector2.ONE * tile_size / 2
		
		if new_position != player_pos:
			position = new_position
			valid_spot = true
