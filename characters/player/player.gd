extends "res://characters/character.gd"

signal moved
signal dead
signal grabbed_key
signal win

func _unhandled_input(event):
	if moving:
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)
			if move:
				emit_signal("moved")



func _on_Player_area_entered(area):
	if area.is_in_group(area):
		emit_signal('dead')
	if area.has_method('pickup'):
		area.pickup()
		if area.type == 'key_red':
			emit_signal('grabbed_key')
		if area.type == 'star':
			emit_signal('win')
