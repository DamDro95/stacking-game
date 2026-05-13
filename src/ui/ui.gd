extends CanvasLayer

var stackable_object: Resource = preload("res://src/item/item.tscn")
var custom_font = load("res://assets/Martius-LV9L4.ttf")

var label_collection: Dictionary = {}
var hearts_list: Array[TextureRect]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func update_ui(Key: String, recipe: Dictionary):
	label_collection[Key].text = str(recipe[Key])

func set_recipe_ui(recipe: Dictionary):
	var temp_instance = stackable_object.instantiate()
	var anim_sprite = temp_instance.get_node_or_null("AnimatedSprite2D")
	
	var texture_container = []
	var texture_position = 5
	
	var label_container = []
	var label_position = 45
	
	for Key in recipe:
		# Displaying which Parts with TextureRects
		var texture_rects = TextureRect.new()
		texture_rects.scale = Vector2(0.2, 0.2)
		
		texture_container.append(texture_rects)
		add_child(texture_rects)
		texture_rects.position = Vector2(texture_position, 50)
		texture_position += 80
		
		var texture = anim_sprite.sprite_frames.get_frame_texture(Key, 0)
		texture_rects.texture = texture
		
		# Displaying # of Parts with Labels
		var labels = Label.new()
		labels.add_theme_font_override("font", custom_font)
		labels.add_theme_font_size_override("font_size", 24)
		
		label_container.append(labels)
		add_child(labels)
		labels.position = Vector2(label_position, 120)
		label_position += 80
		
		var amount = str(recipe[Key])
		labels.text = amount
		label_collection[Key] = labels

func update_hearts(health: int):
	if health == 2:
		$VBoxContainer/heart/AnimatedSprite2D.play("empty")
	elif health == 1:
		$VBoxContainer/heart2/AnimatedSprite2D.play("empty")
	elif health == 0:
		$VBoxContainer/heart3/AnimatedSprite2D.play("empty")
