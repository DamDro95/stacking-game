extends AnimatedSprite2D


func _ready() -> void:
	randomize()
	play_random_animation()


func play_random_animation() -> void:
	var anims = sprite_frames.get_animation_names()
	play(anims[randi() % anims.size()])
