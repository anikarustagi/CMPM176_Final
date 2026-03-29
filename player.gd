extends Area2D

var animation_speed = 2
var moving = false
var tile_size = 64
var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

@onready var ray = $RayCast2d

signal frog_zero
signal get_frog

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size / 2
	
func _unhandled_input(event):
	if moving:
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)
			
func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		#position += inputs[dir] * tile_size
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position + inputs[dir] * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		$AnimationPlayer.play(dir)
		await tween.finished
		moving = false
	else:
		if ray.get_collider().is_in_group("enemy"):
			#move on top of croc tile
			var tween = get_tree().create_tween()
			tween.tween_property(self, "position", position + inputs[dir] * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
			moving = true
			$AnimationPlayer.play(dir)
			await tween.finished
			moving = false
			
			#set frogs to 0 and frogs on player's head fall off
			frog_zero.emit()
			
			#put player back on tile they came from
			tween = get_tree().create_tween()
			tween.tween_property(self, "position", position - inputs[dir] * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
			moving = true
			await tween.finished
			moving = false
			
		elif ray.get_collider().is_in_group("frog"):
			var frog = ray.get_collider()
			
			#move on top of frog tile
			var tween = get_tree().create_tween()
			tween.tween_property(self, "position", position + inputs[dir] * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
			moving = true
			$AnimationPlayer.play(dir)
			await tween.finished
			moving = false
			
			#set frog to +1
			get_frog.emit()
			
			#add frog to player's head
			#[ add code here ]
			
			#frog tile goes away and a new one appears somewhere else that isn't a wall, crocodile,
			#and preferably not the tile the player is on
			frog.move_to_random_tile(position)
			
			#check if player has more than 10 frogs, if so, change movement to 2 tiles at a time
			#[ add code here ]
