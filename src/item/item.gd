extends Area2D

func _ready() -> void:
	randomize()
	play_random_animation()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += 200 * delta
	
func play_random_animation() -> void:
	var anims = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(anims[randi() % anims.size()])
