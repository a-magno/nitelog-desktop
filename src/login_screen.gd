extends Control


func _ready() -> void:
	%LoginButton.pressed.connect(submit)

	%ShowPassButton.pressed.connect(
		func() -> void: %PasswdInput.secret = !%ShowPassButton.button_pressed
	)


func submit() -> void:
	if not is_valid_email(%EmailInput.text):
		print("not valid")
	else:
		print("VALID")


func is_valid_email(email: String) -> bool:
	var regex := RegEx.new()
	regex.compile("[\\w.]+@[\\w.]+\\.\\w+")

	var result: RegExMatch = regex.search(email)
	if not result:
		return false

	return true
