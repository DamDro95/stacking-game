extends RefCounted

class_name RecipeManager

var stackable_object: Resource = preload("res://Scenes/gameplay/StackableObject.tscn")

func new_recipe() -> Dictionary:
	var temp_instance = stackable_object.instantiate()
	var anim_sprite = temp_instance.get_node_or_null("AnimatedSprite2D")
	var items = Array(anim_sprite.sprite_frames.get_animation_names())
	
	# Randomize the seed (crucial so you don't get the same "random" results every time)
	randomize() 
	items.shuffle()
	
	var new_items = items.slice(0, 4)
	var recipe = {}
	for item in new_items:
		recipe[item] = randi_range(1, 5)
	
	return recipe
