extends Control

# Slider Signals
# Master
func _on_volume_slider_drag_ended(_value_changed: bool) -> void:
	AudioController.play_button_click()

func _on_master_slider_mouse_entered() -> void:
	AudioController.play_button_hover()

# Music
func _on_music_slider_drag_ended(_value_changed: bool) -> void:
	AudioController.play_button_click()

func _on_music_slider_mouse_entered() -> void:
	AudioController.play_button_hover()

# SFX
func _on_sfx_slider_drag_ended(_value_changed: bool) -> void:
	AudioController.play_button_click()

func _on_sfx_slider_mouse_entered() -> void:
	AudioController.play_button_hover()

# Button Signals
# Back
func _on_back_pressed() -> void:
	AudioController.play_button_click()
	SceneLoader.load_scene("uid://caoeee7s4m5ti")

func _on_back_mouse_entered() -> void:
	AudioController.play_button_hover()

# Exit
func _on_exit_pressed() -> void:
	AudioController.play_button_click()
	get_tree().quit()

func _on_exit_mouse_entered() -> void:
	AudioController.play_button_hover()
