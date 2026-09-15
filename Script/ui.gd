extends CanvasLayer

@onready var gold_info         = $TopBar/GoldGroup/GoldInfo
@onready var food_info         = $TopBar/FoodGroup/FoodInfo
@onready var gold_income_label = $TopBar/GoldGroup/GoldIncomePerSec
@onready var food_income_label = $TopBar/FoodGroup/FoodIncomePerSec
@onready var info_label        = $InfoPanel/InfoLabel
@onready var anim_player       = $AnimationPlayer
@onready var timer             = $Timer

func _ready() -> void:
	# Load save first
	SaveManager.load_game()

	# Connect GameManager signals to this UI
	GameManager.data_changed.connect(_update_labels)
	GameManager.show_notification.connect(_show_notification)

	# Connect timer
	timer.timeout.connect(_on_timer_timeout)

	# Hide notification label at start
	info_label.modulate.a = 0.0

	# Update display immediately with loaded data
	_update_labels()

func _update_labels() -> void:
	$TopBar/GoldGroup/GoldInfo.text = "Gold: " + GameManager.format_number(GameManager.gold_count)
	$TopBar/GoldGroup/GoldIncomePerSec.text = "Gold/s: " + GameManager.format_number(GameManager.gold_income) + "/s"
	$TopBar/FoodGroup/FoodInfo.text = "Food: " + GameManager.format_number(GameManager.food_count)
	$TopBar/FoodGroup/FoodIncomePerSec.text = "Food/s: " + GameManager.format_number(GameManager.food_income) + "/s"

func _show_notification(message: String) -> void:
	info_label.text = message
	anim_player.stop()       # restart if already fading
	anim_player.play("fade_notification")

func _on_timer_timeout() -> void:
	GameManager.on_timer_tick()

# Button functions — connect pressed() signals in editor to these
func _on_gold_click_button_pressed() -> void:
	GameManager.click_gold()

func _on_gold_upgrade_button_pressed() -> void:
	GameManager.upgrade_gold()

func _on_food_upgrade_button_pressed() -> void:
	GameManager.upgrade_food()
