extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$StackableObject.stack.connect(_stack)
	$StackableObject2.stack.connect(_stack)
	$StackableObject3.stack.connect(_stack)

	pass # Replace with function body.
func _stack() -> void:
	print('stack')
