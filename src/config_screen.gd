extends Control


func _ready() -> void:
	var on_web := func (new_s: String = %WebInput.text) -> void:
		CfgFile.settings["url-web"] = new_s

	%WebInput.text_changed.connect(on_web)
	%WebInput.focus_exited.connect(on_web)

	var on_api := func (new_s: String = %APIInput.text) -> void:
		CfgFile.settings["url-api"] = new_s

	%APIInput.text_changed.connect(on_api)
	%APIInput.focus_exited.connect(on_api)

	var on_websocket := func (new_s: String = %WebsocketInput.text) -> void:
		CfgFile.settings["url-websocket"] = new_s

	%WebsocketInput.text_changed.connect(on_websocket)
	%WebsocketInput.focus_exited.connect(on_websocket)


	var on_time_slider := func (new_v: float) -> void:
		CfgFile.settings["qr-timeout"] = new_v
		%TimeoutLabel.text = "%s Segundos" % new_v

	%TimeoutSlider.value_changed.connect(on_time_slider)


	# Update UI
	%WebInput.text = CfgFile.settings.get("url-web", "")
	%APIInput.text = CfgFile.settings.get("url-api", "")
	%WebsocketInput.text = CfgFile.settings.get("url-websocket", "")
	%TimeoutSlider.value = CfgFile.settings.get("qr-timeout", 90)

	self.tree_exiting.connect(func () -> void: CfgFile.update_cfg_file())
