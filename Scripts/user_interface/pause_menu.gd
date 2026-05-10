extends CanvasLayer



func resume() -> void:
	get_tree().paused = false
	hide()

func pause() -> void:
	get_tree().paused = true
	show()

func _pausing() -> void:
	if Input.is_action_just_pressed("Pause") and !get_tree().paused:
		pause()

func _on_resume_pressed() -> void:
	AudioController.play_button_click()
	resume()

func _on_resume_mouse_entered() -> void:
	AudioController.play_button_hover()

func _on_exit_pressed() -> void:
	AudioController.play_button_click()
	get_tree().quit()

func _on_exit_mouse_entered() -> void:
	AudioController.play_button_hover()

func _process(_float) -> void:
	_pausing()
