extends "res://characters/character.gd"

signal moved
signal dead
signal grabbed_key
signal win

func _ready():
	$Sprite2D.scale = Vector2(1, 1)

func _unhandled_input(event):
	if moving:
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)
			if move:
				emit_signal("moved")



func _on_Player_area_entered(area):
	if area.is_in_group('enemies'):
		area.hide()
		set_process(false)
		$CollisionShape2D.call_deferred('set_disabled', true)
		$AnimationPlayer.play('die')
		await $AnimationPlayer.animation_finished
		emit_signal('dead')
	#if area.is_in_group('coins'):
		#print('coin')
		#area.call_deferred("pickup")
	#if area.has_method('pickup'):
		#area.pickup()
		#if area.type == 'key_red':
			#emit_signal('grabbed_key')
		#if area.type == 'star':
			#emit_signal('win')
	
	if area.has_method('pickup'):
		area.call_deferred('pickup')
		if area.is_in_group('coins'):
			print('picked up coin')
		if area.is_in_group('red_keys'):
			emit_signal('grabbed_key')
			print('emitted signal grabbed key')
		if area.is_in_group('star'):
			emit_signal('win')
			print('win')
