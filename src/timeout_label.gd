extends Label

@export var slider: HSlider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var on_change := func (value: float): text = "%s Segundos" % value
	slider.value_changed.connect(on_change)
