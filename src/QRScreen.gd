extends Control


func _ready() -> void:
	%QRHTTPRequest.request_completed.connect(_on_http_request_request_completed)
	%OpenLoginButton.toggled.connect(_on_open_login_toggled)

	var domain: String = CfgFile.settings.get("url-api")
	var route: String = "/meetings/by-date"
	var params: String = "/%s" % Time.get_date_string_from_system()

	var url: String = domain + route + params

	var error: Error = %QRHTTPRequest.request(url)
	if error != OK:
		var msg: String = (
			"Erro ao fazer requisição para %s (%s)" % [url, error_string(error)]
		)

		%QRSpinner.status = %QRSpinner.Status.ERROR
		%ErrorLabel.show()
		%ErrorLabel.text = msg
		printerr(msg)


func _on_http_request_request_completed(
	result: int,
	response_code: int,
	headers: PackedStringArray,
	body: PackedByteArray
) -> void:
	if response_code == 200:
		var json := JSON.new()
		json.parse(body.get_string_from_utf8())

		var response_data: Variant = json.get_data()

		var meeting_id: int = response_data.get("id")

		var domain: String = CfgFile.settings["url-api"]
		var route: String = "/meetings"
		var params: String = "/%d" % meeting_id

		var link: String = domain + route + params
		print("Link gerado:", link)

		%QRCodeRect.data = link
		%QRCodeRect.show()
	else:
		var err: String = "Erro na requisição, código: %s" % response_code
		printerr(err)

		%ErrorLabel.text = err
		%ErrorLabel.show()


func _on_open_login_toggled(value: bool) -> void:
	if value == true:
		%LoginAnimPlayer.play("transition_in")
		%OpenLoginButton.text = " < "
		return

	%LoginAnimPlayer.play("transition_out")
	%OpenLoginButton.text = " > "
