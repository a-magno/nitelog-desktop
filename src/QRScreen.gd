extends Control


func _ready() -> void:
	%QRHTTPRequest.request_completed.connect(_on_http_request_request_completed)
	%OpenLoginButton.toggled.connect(_on_open_login_toggled)

	var url: String = CfgFile.settings["url-api"] + "/meetings"

	var json := JSON.new()
	var body: String = json.stringify(
		{"date": Time.get_datetime_string_from_system()}
	)

	var error: Error = %QRHTTPRequest.request(
		url, [], HTTPClient.METHOD_POST, body
	)
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
	var json := JSON.new()
	var error: Error = json.parse(body.get_string_from_utf8())
	var response_data: Variant = json.get_data()

	var meeting_id: int
	if response_code == HTTPClient.RESPONSE_CREATED:
		meeting_id = response_data.get("id")
	elif response_code == HTTPClient.RESPONSE_CONFLICT:
		meeting_id = response_data.get("meeting").get("id")
	else:
		var err: String = "Erro na requisição, código: %s" % response_code
		printerr(err)

		%ErrorLabel.text = err
		%ErrorLabel.show()
		return

	var domain: String = CfgFile.settings["url-api"]
	var route: String = "/meetings"
	var params: String = "/%d" % meeting_id

	var link: String = domain + route + params
	%QRCodeRect.data = link
	%QRCodeRect.show()


func _on_open_login_toggled(value: bool) -> void:
	if value == true:
		%LoginAnimPlayer.play("transition_in")
		%OpenLoginButton.text = " < "
		return

	%LoginAnimPlayer.play("transition_out")
	%OpenLoginButton.text = " > "
