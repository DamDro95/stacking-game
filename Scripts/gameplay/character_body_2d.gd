extends CharacterBody2D

@onready var stack_marker = $Marker2D
@export var follow_speed: float = 15.0 # How fast items catch up
@export var lag_strength: float = 0.2  # Higher = more lag/floppiness
const SPEED = 200.0
var stack: Array[Area2D] = []

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
	apply_stack_sway(delta)
	
func apply_stack_sway(delta: float) -> void:
	# The first 'target' is the player's center (0,0 in local space)
	var target_x = 0.0
	
	for i in range(stack.size()):
		var item = stack[i]
		
		# We target the position of the item below it
		# But we add a bit of the player's velocity to exaggerate the lag
		var move_lag = (velocity.x * delta * lag_strength) * (i + 1)
		
		# Smoothly move the item's X toward the target
		# We subtract move_lag to make it "stay behind" the player's direction
		var target_with_lag = target_x - move_lag
		
		item.position.x = lerp(item.position.x, target_with_lag, follow_speed * delta)
		
		# Optional: Add a slight tilt based on the X offset to sell the effect
		item.rotation = lerp_angle(item.rotation, (item.position.x * 0.01), 10.0 * delta)
		
		# The next item in the stack will now try to follow THIS item's X position
		target_x = item.position.x
		
		# Make sure the collision box follow the top of the stack
		if i == (stack.size() - 1):
			$Area2D.position = item.position

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
