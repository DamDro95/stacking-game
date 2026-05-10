extends CanvasLayer


# Pause Logic
func resume() -> void:
	get_tree().paused = false
	hide()

func pause() -> void:
	get_tree().paused = true
	show()

func _pausing() -> void:
	if Input.is_action_just_pressed("Pause") and !get_tree().paused:
		pause()

func _process(_float) -> void:
	_pausing()

# Slider Signals
# Master
func _on_master_slider_drag_ended(_value_changed: bool) -> void:
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
# Resume
func _on_resume_pressed() -> void:
	AudioController.play_button_click()
	resume()

func _on_resume_mouse_entered() -> void:
	AudioController.play_button_hover()

# Exit
func _on_exit_pressed() -> void:
	AudioController.play_button_click()
	get_tree().quit()

func _on_exit_mouse_entered() -> void:
	AudioController.play_button_hover()
