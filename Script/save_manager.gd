extends Node

const SAVE_PATH = "user://savegame.save"

func save_game() -> void:
	var data = {
		"gold_count":   GameManager.gold_count,
		"food_count":   GameManager.food_count,
		"gold_per_tab": GameManager.gold_per_tab,
		"gold_income":  GameManager.gold_income,
		"food_income":  GameManager.food_income
	}
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		print("Save error: ", FileAccess.get_open_error())
		return
	file.store_string(JSON.stringify(data))
	file.close()

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		print("No save file, starting fresh")
		return
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		print("Load error: ", FileAccess.get_open_error())
		return
	var content = file.get_as_text()
	file.close()
	var parsed = JSON.parse_string(content)
	if parsed == null:
		print("Corrupted save file")
		return
	GameManager.apply_save(parsed)
