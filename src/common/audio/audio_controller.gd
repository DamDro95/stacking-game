extends Node2D

@export var mute: bool =  false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !mute:
		play_music()

func play_music() -> void:
	if !mute:
		$Music.play()

func play_stack_success(key, recipe) -> void:
	if !mute:
		$StackSuccess.play()

func play_stack_fail() -> void:
	if !mute:
		$StackFail.play()

func play_button_hover() -> void:
	if !mute:
		$ButtonHover.play()

func play_button_click() -> void:
	if !mute:
		$ButtonClick.play()

func play_ambient_bubbles() -> void:
	if !mute:
		$AmbientBubbles.play()
