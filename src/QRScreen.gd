extends Control

var QRCode := preload("res://addons/qr_code/qr_code.gd")


func _ready() -> void:
	%QRHTTPRequest.request_completed.connect(_on_http_request_request_completed)

	var url: String = CfgFile.settings.get("url-api")
	var error: Error = %QRHTTPRequest.request(url)
	if error != OK:
		print("Erro ao fazer requisição:", error)


# Função para gerar o QR Code com base em uma string de entrada.
func generate_qr_code(data: String) -> void:
	%QRCodeRect.data = CfgFile.settings.get("url-api")


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

		generate_qr_code(link)
		%QRCodeRect.show()  # Gera o QR Code com o link
	else:
		var err: String = "Erro na requisição, código: %s" % response_code
		printerr(err)

		%ErrorLabel.text = err
		%ErrorLabel.show()
