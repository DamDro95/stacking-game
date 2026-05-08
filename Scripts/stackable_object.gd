extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.gravity_scale = 0
	self.inear_velocity = Vector2(0, 300) # Falls down at 300 pixels per second
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
