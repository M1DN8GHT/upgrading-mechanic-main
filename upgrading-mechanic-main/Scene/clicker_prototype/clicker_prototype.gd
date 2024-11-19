class_name ClickerPrototype
extends Control

@export var label : Label  # Label to display clicks
@export var upgrade_button : Button  # The upgrade button

var clicks : int = 0
var clicks_per_click : int = 1  # Start with 1 click per press
var upgrade_cost : int = 50  # Cost to upgrade (50 clicks)

func _ready() -> void:
	if upgrade_button == null:
		print("Error: Upgrade button is not assigned!")
		return  # Exit if upgrade_button is not assigned
	update_label()
	upgrade_button.disabled = true  # Disable the upgrade button initially
	upgrade_button.pressed.connect(_on_upgrade_button_pressed)  # Connect upgrade button signal

func update_label() -> void:
	# Update the label to show the current click count and if the upgrade is available
	var upgrade_message = ""
	if clicks >= upgrade_cost and clicks_per_click == 1:
		upgrade_message = "\nUpgrade available! (50 clicks)"
		upgrade_button.disabled = false  # Enable upgrade button when upgrade is available
	else:
		upgrade_button.disabled = true  # Disable upgrade button if upgrade is not available
	
	label.text = "Clicks: %d%s" % [clicks, upgrade_message]

func increase_clicks() -> void:
	clicks += clicks_per_click  # Add clicks based on clicks_per_click
	update_label()

func _on_button_pressed() -> void:
	increase_clicks()
	check_for_upgrade()

func check_for_upgrade() -> void:
	# Check if upgrade is available and apply it
	if clicks >= upgrade_cost and clicks_per_click == 1:
		upgrade_button.disabled = false  # Ensure the upgrade button is enabled when the upgrade is available

func _on_upgrade_button_pressed() -> void:
	if clicks >= upgrade_cost and clicks_per_click == 1:
		clicks_per_click = 2  # Upgrade to 2 clicks per press
		clicks -= upgrade_cost  # Subtract 50 clicks as the cost of the upgrade
		upgrade_button.disabled = true  # Disable the upgrade button after the upgrade
		update_label()  # Update the label after upgrade
		print("Upgrade successful! Each click is now worth 2. 50 clicks have been spent.")
