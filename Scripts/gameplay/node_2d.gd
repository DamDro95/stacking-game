extends Node2D

@export var point_1: Vector2 = Vector2(-90,-400)
@export var point_2: Vector2 = Vector2(90,-400)

@onready var stackable_object: Resource = preload("res://Scenes/gameplay/StackableObject.tscn")

var is_paused: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PauseMenu.hide()
	randomize()

#func _process(_delta: float) -> void:
	#if Input.is_action_just_pressed("Pause") and is_paused == false:
		#is_paused = true
		#get_tree().paused = true
		#$PauseMenu.show()
	#elif Input.is_action_just_pressed("Pause") and is_paused == true:
		#get_tree().paused = false
		#$PauseMenu.hide()
		#
		#is_paused = false

func get_a_random_position(p1: Vector2, p2: Vector2) -> Vector2:
	# Get random x and y values
	var x_value: float = randf_range(p1.x, p2.x)
	var y_value: float = randf_range(p1.y, p2.y)
	# Set the random values into a Vector2
	var random_position: Vector2 = Vector2(x_value, y_value)
	
	return(random_position)

func spawn_stackable():
	# Creates an instance of the Stackable Object
	var stackable_instance: Node = stackable_object.instantiate()
	# Places the instanced Stackable into the Scene Tree
	add_child(stackable_instance)
	# Generate a spawn location
	var spawn_location: Vector2 = get_a_random_position(point_1, point_2)
	# Sets the position of the spawn location when instantiating
	stackable_instance.set_position(spawn_location)

# Spawning Stackables at a specified interval
func _on_spawn_timer_timeout() -> void:
	spawn_stackable()

# Changing the interval time (increasing spawn rate)
func _on_interval_timer_timeout() -> void:
	$SpawnTimer.wait_time *= 0.9
