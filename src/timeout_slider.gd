extends HSlider


func _ready() -> void:
	self.value = Config.qr_timeout

	self.value_changed.connect(
		func(new_value: float) -> void: Config.qr_timeout = new_value
	)
