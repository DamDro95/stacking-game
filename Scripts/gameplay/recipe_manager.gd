extends RefCounted

class_name RecipeManager

var recipe: Dictionary;
var stackable_object: Resource = preload("res://Scenes/gameplay/StackableObject.tscn")

signal recipe_completed()

func new_recipe() -> void:
	var temp_instance = stackable_object.instantiate()
	var anim_sprite = temp_instance.get_node_or_null("AnimatedSprite2D")
	var items = Array(anim_sprite.sprite_frames.get_animation_names())
	
	# Randomize the seed (crucial so you don't get the same "random" results every time)
	randomize() 
	items.shuffle()
	
	var new_items = items.slice(0, 4)
	recipe = {}
	for item in new_items:
		recipe[item] = randi_range(1, 2)

func stack_calculation(area:Area2D) -> void:
	var anim_sprit = area.get_node('AnimatedSprite2D')
	var anim_name = anim_sprit.animation

	if anim_name in recipe and recipe[anim_name] > 0:
		recipe[anim_name] -= 1;
		
	# Check if recipe is complete
	var is_complete = recipe.values().all(func(v): return v == 0)
	if is_complete:
		recipe_completed.emit()
