extends RefCounted

class_name RecipeManager

var recipe: Dictionary;
var stackable_object: Resource = preload("res://Scenes/gameplay/StackableObject.tscn")
var head_items:Array = []
var body_items:Array = []

signal recipe_completed(recipe: Dictionary)
signal valid_item_stacked(Key: String, recipe: Dictionary)
signal invalid_item_stacked()

func _init():
	var temp_instance = stackable_object.instantiate()
	var anim_sprite = temp_instance.get_node_or_null("AnimatedSprite2D")
	var items = Array(anim_sprite.sprite_frames.get_animation_names())
	
	head_items = items.filter(func(item): return "head" in item)
	body_items = items.filter(func(item): return "head" not in item)
	
func new_recipe() -> void:
	# Randomize the seed (crucial so you don't get the same "random" results every time)
	randomize() 
	body_items.shuffle()
	head_items.shuffle()
	
	var number_of_body_parts = randi_range(1, 3)
	
	var new_items = body_items.slice(0, number_of_body_parts)
	recipe = {}
	for item in new_items:
		recipe[item] = randi_range(1, 6)
	
	var head_item = head_items[0]
	recipe[head_item] = 1

func stack_calculation(area:Area2D) -> void:
	var anim_sprit = area.get_node('AnimatedSprite2D')
	var anim_name = anim_sprit.animation
	
	var is_body_recipe_complete = recipe.keys().all(func(key):
		if "head" in key:
			return true
		return recipe[key] == 0
	)
	
	if (anim_name not in recipe
	or (anim_name in recipe and recipe[anim_name] < 1)
	or ("head" in anim_name and not is_body_recipe_complete)):
		invalid_item_stacked.emit()
		AudioController.play_stack_fail()
		return
	
	recipe[anim_name] -= 1;
	valid_item_stacked.emit(anim_name, recipe)
	AudioController.play_stack_success()
		
	var is_recipe_complete = recipe.values().all(func(v): return v == 0)
	if is_recipe_complete and "head" in anim_name:
		recipe_completed.emit()
