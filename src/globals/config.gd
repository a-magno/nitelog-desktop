class_name Configuration
extends Node

var url_web: String
var url_api: String
var url_websocket_qr: String

var qr_timeout: float


func get_url(type: String) -> String:
	if type.to_lower().begins_with("websocket"):
		return url_websocket_qr
	elif type.to_lower().begins_with("api"):
		return url_api
	elif type.to_lower().begins_with("web"):
		return url_web
	else:
		return ""


func set_url(type: String, value: String) -> void:
	if type.to_lower().begins_with("websocket"):
		url_websocket_qr = value
	elif type.to_lower().begins_with("api"):
		url_api = value
	elif type.to_lower().begins_with("web"):
		url_web = value
