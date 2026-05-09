extends CanvasLayer

signal loading_screen_ready

@export var animation_player: AnimationPlayer

func _ready() -> void:
	await animation_player.animation_finished
	loading_screen_ready.emit()

# Function to utilize the Progress float
func _on_progress_changed(_new_value: float) -> void:
	pass

# Replay transition in reverse to fade out from black in new scene
func _on_load_finished() -> void:
	animation_player.play_backwards("transition")
	await animation_player.animation_finished
	queue_free()
