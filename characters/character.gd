extends Area2D

var animation_speed = 3
@onready var tween

var tile_size = 64
var moving = false
var facing = 'right'
@onready var ray = $RayCast2D

var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

func _ready():
	# snapped() allows round the position to the nearest tile
	position = position.snapped(Vector2.ONE * tile_size)
	# adding a half-tile amount to make sure the player is centered on the tile.
	position += Vector2.ONE * tile_size/2
	
func move(dir):
	$AnimationPlayer.speed_scale = animation_speed
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		#position += inputs[dir] * tile_size
		$AnimationPlayer.play(dir)
		tween = create_tween()
		tween.tween_property(self, "position",
		position+inputs[dir]*tile_size,
		1.0/animation_speed
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		moving = true
		await tween.finished
		moving = false
	return true
