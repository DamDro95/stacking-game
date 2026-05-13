extends Control


func _on_start_pressed() -> void:
	AudioController.play_button_click()
	SceneLoader.load_scene("uid://dpufkg3k3u3ar")

func _on_start_mouse_entered() -> void:
	AudioController.play_button_hover()

func _on_credits_pressed() -> void:
	AudioController.play_button_click()
	SceneLoader.load_scene("uid://cunnoexbwjvs3")

func _on_credits_mouse_entered() -> void:
	AudioController.play_button_hover()

func _on_options_pressed() -> void:
	AudioController.play_button_click()
	SceneLoader.load_scene("uid://c0f5hw3n43ka5")

func _on_options_mouse_entered() -> void:
	AudioController.play_button_hover()

func _on_exit_pressed() -> void:
	AudioController.play_button_click()
	get_tree().quit()

func _on_exit_mouse_entered() -> void:
	AudioController.play_button_hover()
