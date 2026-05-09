extends Control


func _on_start_pressed() -> void:
	SceneLoader.load_scene("uid://dpufkg3k3u3ar")


func _on_credits_pressed() -> void:
	SceneLoader.load_scene("uid://cunnoexbwjvs3")


func _on_options_pressed() -> void:
	SceneLoader.load_scene("uid://c0f5hw3n43ka5")


func _on_exit_pressed() -> void:
	get_tree().quit()
