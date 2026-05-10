extends RefCounted

class_name PlayerManager

var health = 3

signal player_died
signal took_damage(health: int)

func apply_damage() -> void:
	health -= 1
	took_damage.emit(health)
	if health < 1:
		player_died.emit()
