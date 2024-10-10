extends LineEdit


func _ready() -> void:
	self.text = Config.get_url(self.name)

	var on_submit := func(new_text: String) -> void: Config.set_url(self.name, new_text)
	self.text_submitted.connect(on_submit)

	self.focus_exited.connect(func() -> void: self.text_submitted.emit(text))
