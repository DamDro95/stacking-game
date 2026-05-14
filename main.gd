extends Node2D

@onready var is_paused: bool = false
@onready var recipe_manager = RecipeManager.new()
@onready var player_manager = PlayerManager.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Gameplay hooks
	$Player.item_stacked.connect(recipe_manager.stack_calculation)
	recipe_manager.invalid_item_stacked.connect(player_manager.apply_damage)
	recipe_manager.valid_item_stacked.connect($UI.update_ui)
	recipe_manager.recipe_completed.connect(game_win)
	player_manager.player_died.connect(game_lose)
	
	# Setup UI
	recipe_manager.new_recipe()
	$UI.set_recipe_ui(recipe_manager.recipe)
	player_manager.took_damage.connect($UI.update_hearts)
	
	# Audio setup
	recipe_manager.invalid_item_stacked.connect(AudioController.play_stack_fail)
	recipe_manager.valid_item_stacked.connect(AudioController.play_stack_success)	
	AudioController.play_ambient_bubbles()

func game_win() -> void:
	SceneLoader.load_scene("uid://dyemqgrwngmtn")

func game_lose() -> void:
	SceneLoader.load_scene("uid://cnaea16dc6f13")
