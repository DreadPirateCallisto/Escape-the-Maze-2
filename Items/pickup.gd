extends Area2D

signal coin_pickup

var type
var textures = {
	'coin': 'res://assets/coin.png',
	'key_red': 'res://assets/keyRed.png',
	'star': 'res://assets/star.png'
}
#@onready var tween
#func _ready():
	#tween = get_tree().create_tween()
	
#func _init(_type, pos):
		#$Sprite2D.texture = load(textures[_type])
		#type = _type
		#position = pos
		
func instance(_type, pos):
	$Sprite2D.texture = load(textures[_type])
	type = _type
	position = pos
		
func pickup():
	match type:
		'coin':
			emit_signal('coin_pickup', 1)
	$CollisionShape2D.call_deferred("set_disabled", true)
	var tween = get_tree().create_tween()
	tween.tween_property(
		self,
		'scale',
		Vector2(3, 3),
		0.5
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	queue_free()
	
