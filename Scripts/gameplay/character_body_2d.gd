extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var stack: Array[Area2D] = []

@onready var stack_marker = $Marker2D

signal item_stacked

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_meta("is_stacked", false):
		return

	area.set_meta("is_stacked", true)
	area.get_node("CollisionShape2D").set_deferred("moitorable", false)
	area.get_node("CollisionShape2D").set_deferred("monitorable", false)
	call_deferred("_stack", area)

func _stack(area: Area2D) -> void:
	# Double check it hasn't been deleted or freed
	if not is_instance_valid(area):
		return
		
	# Disable collisions now that we are outside the "flushing" lock
	area.monitoring = false
	area.monitorable = false
	
	# Reparent
	area.reparent(self, false)
	
	#stop physics processing
	area.set_process(false)
	
	# Put the object on top
	area.position = stack_marker.position
	
	#position the marker to the top of the stack
	var sprite = area.get_node("AnimatedSprite2D")
	var frames = sprite.get_sprite_frames()
	var item_height = frames.get_frame_texture(sprite.animation, sprite.frame).get_size().y
	stack_marker.position.y -= (item_height *  sprite.scale.y) - 15
	
	#Move the collision shape to the top
	$Area2D.position = stack_marker.position

	stack.append(area)
	item_stacked.emit(area)
