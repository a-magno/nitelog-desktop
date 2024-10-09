class_name TransitionButton
extends Button

@export var new_scene: PackedScene


func _ready() -> void:
	var on_pressed := func (): get_tree().change_scene_to_packed(new_scene)
	self.pressed.connect(on_pressed)
