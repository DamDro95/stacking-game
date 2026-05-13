extends Control


func _on_back_pressed() -> void:
	AudioController.play_button_click()
	SceneLoader.load_scene("uid://caoeee7s4m5ti")

func _on_back_mouse_entered() -> void:
	AudioController.play_button_hover()

func _on_exit_pressed() -> void:
	AudioController.play_button_click()
	get_tree().quit()

func _on_exit_mouse_entered() -> void:
	AudioController.play_button_hover()
