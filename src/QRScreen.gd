extends Control


func _ready() -> void:
	%QRHTTPRequest.request_completed.connect(_on_http_request_request_completed)
	%OpenLoginButton.toggled.connect(_on_open_login_toggled)

	var url: String = CfgFile.settings.get("url-api")
	%QRCodeRect.data = url

	var error: Error = %QRHTTPRequest.request(url)
	if error != OK:
		print("Erro ao fazer requisição:", error)


func _on_open_login_toggled(value: bool) -> void:
	if value == true:
		%LoginAnimPlayer.play("transition_in")
		%OpenLoginButton.text = " < "
		return

	%LoginAnimPlayer.play("transition_out")
	%OpenLoginButton.text = " > "


func _on_http_request_request_completed(
	result: int,
	response_code: int,
	headers: PackedStringArray,
	body: PackedByteArray
) -> void:
	if response_code == 200:
		var response_data := body.get_string_from_utf8()
		print("Resposta recebida:", response_data)

		var domain := "0.0.0.0:3000"
		var route := "users"
		var params := "id=555"

		var link := "http://%s/%s?%s" % [domain, route, params]
		print("Link gerado:", link)

		# %QRCodeRect.data = link
		%QRCodeRect.show()  # Gera o QR Code com o link
	else:
		var err: String = "Erro na requisição, código: %s" % response_code
		printerr(err)

		%ErrorLabel.text = err
		%ErrorLabel.show()
