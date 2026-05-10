extends RefCounted

class_name PlayerManager

var health = 3

signal player_died

func apply_damage() -> void:
	health -= 1
	
	if health < 1:
		player_died.emit()
