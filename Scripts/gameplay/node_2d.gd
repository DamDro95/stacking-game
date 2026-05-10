extends Node2D

@export var point_1: Vector2 = Vector2(-90,-400)
@export var point_2: Vector2 = Vector2(90,-400)

@onready var stackable_object: Resource = preload("res://Scenes/gameplay/StackableObject.tscn")
@onready var is_paused: bool = false
@onready var recipe_manager = RecipeManager.new()
@onready var player_manager = PlayerManager.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PauseMenu.hide()
	randomize()
	
	$Player.item_stacked.connect(recipe_manager.stack_calculation)
	recipe_manager.recipe_completed.connect(game_win)
	recipe_manager.invalid_item_stacked.connect(player_manager.apply_damage)
	recipe_manager.valid_item_stacked.connect(valid_item_stacked)
	player_manager.player_died.connect(game_lose)
	
	recipe_manager.new_recipe()
	
	$ScreenOverlay.set_recipe_ui(recipe_manager.recipe)
	
	AudioController.play_ambient_bubbles()
	
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

func valid_item_stacked(Key: String, recipe: Dictionary):
	$ScreenOverlay.update_ui(Key, recipe)

# Spawning Stackables at a specified interval
func _on_spawn_timer_timeout() -> void:
	spawn_stackable()

# Changing the interval time (increasing spawn rate)
func _on_interval_timer_timeout() -> void:
	$SpawnTimer.wait_time *= 0.9
	
func game_win() -> void:
	SceneLoader.load_scene("uid://dyemqgrwngmtn")
	print("winner")

func game_lose() -> void:
	SceneLoader.load_scene("uid://cnaea16dc6f13")
	print('Lose') 
