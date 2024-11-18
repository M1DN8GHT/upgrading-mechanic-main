class_name ClickerPrototype
extends Control

@export var label: Label

var clicks: int = 0
var clicks_per_click: int = 1  # Start with 1 click per press
var upgrade_cost: int = 50  # Cost to upgrade (50 clicks)

func _ready() -> void:
	update_label()

func update_label() -> void:
	# Update the label to show the current click count and if the upgrade is available
	var upgrade_message = ""
	if clicks >= upgrade_cost:
		upgrade_message = "\nUpgrade available! (50 clicks)"
	label.text = "Clicks: %d%s" % [clicks, upgrade_message]

func increase_clicks() -> void:
	clicks += clicks_per_click  # Add clicks based on clicks_per_click
	update_label()

func _on_button_pressed() -> void:
	increase_clicks()
	check_for_upgrade()

func check_for_upgrade() -> void:
	if clicks >= upgrade_cost and clicks_per_click == 1:
		clicks_per_click = 2  # Upgrade to 2 clicks per press
		update_label()
