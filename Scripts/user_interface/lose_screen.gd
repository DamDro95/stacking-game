extends Control

# Next
func _on_next_pressed() -> void:
	AudioController.play_button_click()
	SceneLoader.load_scene("uid://dpufkg3k3u3ar")

func _on_next_mouse_entered() -> void:
	AudioController.play_button_hover()

# Exit
func _on_exit_pressed() -> void:
	AudioController.play_button_click()
	get_tree().quit()

func _on_exit_mouse_entered() -> void:
	AudioController.play_button_hover()
