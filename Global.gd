extends Node


var score:int
var highscore:int = 0
var levels = [
	'res://maps/level_1/level_1.tscn',
	'res://maps/level_2/level_2.tscn'
]
var current_level: int = 0

var start_screen = 'res://UI/start_screen.tscn'
var end_screen = 'res://UI/end_screen.tscn'

var score_file = 'user://highscore.txt'

func _ready():
	setup()

func setup():
	var f
	if FileAccess.file_exists(score_file):
		f = FileAccess.open(score_file, FileAccess.READ)
		if f:
			var content = f.get_as_text()
			highscore = int(content)
			f.close()
	else:
		f = FileAccess.open(score_file, FileAccess.WRITE)
		if f:
			f.store_string("0")
			f.close()

func game_over():
	if score > highscore:
		highscore = score
		save_score()
	call_deferred("change_scene_to_end_screen")
	
func save_score():
	var f = FileAccess.open(score_file, FileAccess.WRITE)
	if f:
		f.store_string(str(highscore))
		f.close()
	else:
		print("Failed to open file for writing")
	
func change_scene_to_end_screen():
	get_tree().change_scene_to_file(end_screen)
	
func change_scene_to_next_level():
	get_tree().change_scene_to_file(levels[current_level])
	
func next_level():
	current_level += 1
	if current_level >= levels.size():
		#no more levels to load
		game_over()
	else:
		call_deferred("change_scene_to_next_level")


func new_game():
	score = 0
	current_level = 0
	get_tree().change_scene_to_file(levels[0])
