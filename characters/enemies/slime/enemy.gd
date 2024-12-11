extends "res://characters/character.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	moving = false
	facing = inputs.keys()[randi() % 4]
	await get_tree().create_timer(0.5).timeout


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if moving:
		return
	if !move or randi() % 10 > 5:
		facing = inputs.keys()[randi() % 4]
		move(facing)
