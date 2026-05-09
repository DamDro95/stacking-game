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
	resume()

func _on_exit_pressed() -> void:
	get_tree().quit()

func _process(_float) -> void:
	_pausing()
