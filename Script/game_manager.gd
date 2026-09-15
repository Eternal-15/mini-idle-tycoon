extends Node

# All game data lives here
var gold_count: int = 0
var food_count: float = 0.0
var gold_per_tab: int = 1
var gold_income: int = 1
var food_income: float = 1.0

# Signals
signal data_changed
signal show_notification(message: String)

func click_gold() -> void:
	gold_count += gold_per_tab
	data_changed.emit()
	SaveManager.save_game()

func upgrade_gold() -> void:
	gold_per_tab += 2
	gold_income += 5
	show_notification.emit("Gold Income +5/sec")
	data_changed.emit()
	SaveManager.save_game()

func upgrade_food() -> void:
	food_income += 5
	show_notification.emit("Food Income +5/sec")
	data_changed.emit()
	SaveManager.save_game()

func on_timer_tick() -> void:
	gold_count += gold_income
	food_count += food_income
	data_changed.emit()
	SaveManager.save_game()

func apply_save(data: Dictionary) -> void:
	gold_count   = data.get("gold_count", 0)
	food_count   = data.get("food_count", 0.0)
	gold_per_tab = data.get("gold_per_tab", 1)
	gold_income  = data.get("gold_income", 1)
	food_income  = data.get("food_income", 1.0)
	data_changed.emit()
	
func format_number(value: float) -> String:
	if value >= 1_000_000_000:
		return "%.1f" % (value / 1_000_000_000.0) + "B"
	elif value >= 1_000_000:
		return "%.1f" % (value / 1_000_000.0) + "M"
	elif value >= 1_000:
		return "%.1f" % (value / 1_000.0) + "K"
	else:
		return str(int(value))
