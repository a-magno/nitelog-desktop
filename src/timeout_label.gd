extends Label

@export var slider: HSlider


func _ready() -> void:
	text = "%s Segundos" % Config.qr_timeout

	var on_change := func(value: float) -> void: text = "%s Segundos" % value
	slider.value_changed.connect(on_change)
