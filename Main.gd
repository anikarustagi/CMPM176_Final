extends Node2D

@export var tile_size = 64
@export var width = 896
@export var height = 640

func _draw():
	for x in range(0, 896, 64):
		draw_line(Vector2(x, 0), Vector2(x, 640), Color8(0, 0, 0), 1.5)
	for y in range(0, 640, 64):
		draw_line(Vector2(0, y), Vector2(896, y), Color8(0, 0, 0), 2)
