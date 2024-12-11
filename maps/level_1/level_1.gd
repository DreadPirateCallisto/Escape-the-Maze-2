extends Node2D

@export var Enemy: PackedScene
@export var Pickup: PackedScene

@onready var items = $Items
var doors = []

func _ready():
	randomize()
	$Player.tile_size = 64
	$Items.hide()
	set_camera_limits()
	find_doors()
	#for cell in $Walls.get_used_cells_by_id(door_id):
		#doors.append(cell)
	#print(len(doors))
	spawn_items()
	#$Player.connect('dead', self, 'game_over')
	$Player.dead.connect(game_over)
	#$Player.connect('grabbed_key', self, '_on_Player_grabbed_key')
	$Player.grabbed_key.connect(_on_Player_grabbed_key)
	#$Player.connect('win', self, '_on_Player_win')
	$Player.win.connect(_on_Player_win)
	
func find_doors():
	var cells = $Walls.get_used_cells(0)
	for cell in cells:
		var tile_data = $Walls.get_cell_tile_data(0, cell)
		var door_property = tile_data.get_custom_data('Doors')
		if door_property == 'red_door':
			doors.append(cell)
	print(doors)
	
func set_camera_limits():
	var map_size = $Ground.get_used_rect()
	var cell_size = $Ground.tile_set.tile_size
	$Player/Camera2D.limit_left = map_size.position.x * cell_size.x
	$Player/Camera2D.limit_top = map_size.position.y * cell_size.y
	$Player/Camera2D.limit_right = map_size.end.x * cell_size.x
	$Player/Camera2D.limit_bottom = map_size.end.x * cell_size.y
	
func spawn_items():
	#var enemy = Enemy.instantiate()
	#add_child(enemy)
	#enemy.position = $EnemySpawn.position
	
	for cell in items.get_used_cells(0):
		var tile_data = items.get_cell_tile_data(0, cell)
		var type = tile_data.get_custom_data('Spawns')
		#if type == 'enemy_spawn':
			#var enemy = Enemy.instantiate()
			#add_child(enemy)
			#enemy.position = items.map_to_local(cell)
		#if type == 'player_spawn':
			#$Player.position = items.map_to_local(cell)
		match type:
			'enemy_spawn':
				var enemy = Enemy.instantiate()
				$EnemyNode.add_child(enemy)
				enemy.position = items.map_to_local(cell)
			'player_spawn':
				$Player.position = items.map_to_local(cell)
			'coin_spawn':
				var coin = Pickup.instantiate()
				coin.instance('coin', items.map_to_local(cell))
				$CoinNode.add_child(coin)
			'star_spawn':
				var star = Pickup.instantiate()
				star.instance('star', items.map_to_local(cell))
				$StarNode.add_child(star)
		#print(type)
		#var pos = items.map_to_local(cell) + items.map_to_local(items.tile_set.tile_size/2)
	
	
func game_over():
	print('game over')
	
func _on_Player_grabbed_key():
	print('clearing the door')
	$Walls.set_cell(0, doors[0], -1)
	
func _on_Player_win():
	print('yay! you won')
