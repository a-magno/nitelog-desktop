extends Node

const CFG_FILE: String = "user://nitelog.cfg"

var config: ConfigFile
var settings: Dictionary

func _ready() -> void:
	config = ConfigFile.new()

	if not FileAccess.file_exists(CFG_FILE):
		return

	var err := config.load(CFG_FILE)
	if err != OK:
		return

	var keys: PackedStringArray = config.get_section_keys("config")
	if keys.is_empty(): 
		# Rename broken config
		var broken_name: String = "user://nitelog.%s.cfg.broken" % Time.get_datetime_string_from_system()
		DirAccess.rename_absolute(CFG_FILE, broken_name)

		return

	for key: String in keys:
		var value: Variant = config.get_value("config", key)
		settings.get_or_add(key, value)


func update_cfg_file() -> void:
	var keys: Array = settings.keys()

	for key: String in keys:
		config.set_value("config", key, settings.get(key, null))

	config.save(CFG_FILE)
