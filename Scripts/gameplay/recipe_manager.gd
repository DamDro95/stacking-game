extends RefCounted

class_name RecipeManager

var recipe: Dictionary;
var stackable_object: Resource = preload("res://Scenes/gameplay/StackableObject.tscn")
var head_items:Array = []
var body_items:Array = []

signal recipe_completed()
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
	else:
		invalid_item_stacked.emit()
		return
		
	# Check if recipe is complete
	var is_complete = recipe.values().all(func(v): return v == 0)
	if is_complete and "head" in anim_name:
		recipe_completed.emit()
	elif not is_complete and "head" in anim_name:
		invalid_item_stacked.emit()
