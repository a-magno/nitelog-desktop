class_name TransitionButton
extends Button

@export var new_scene: String


func _ready() -> void:
	var on_pressed := func () -> void: get_tree().change_scene_to_file(new_scene)
	self.pressed.connect(on_pressed)
