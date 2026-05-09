extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	play_random_animation()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func play_random_animation() -> void:
	var anims = sprite_frames.get_animation_names()
	play(anims[randi() % anims.size()])
