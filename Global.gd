extends Node


var score:int
var levels = [
	'res://maps/level_1/level_1.tscn',
	'res://maps/level_2/level_2.tscn'
]
var current_level

var start_screen = 'res://UI/start_screen.tscn'
var end_screen = 'res://UI/end_screen.tscn'

func game_over():
	call_deferred("change_scene")
	
func change_scene():
	get_tree().change_scene_to_file(end_screen)
	
func next_level():
	current_level += 1
	if current_level >= levels.size():
		#no more levels to load
		game_over()
	else:
		get_tree().change_scene_to_packed(levels[current_level])


func new_game():
	score = 0
	get_tree().change_scene_to_file(levels[0])
