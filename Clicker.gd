extends Node2D

func _process(delta):
	$canvas/cashAmount.text = 'Cash: ' + str(global.gcash)
	$canvas/cashPerSec.text = 'Cash/s: ' + str(global.cashPerSec)
	$canvas/coalPerSec.text = 'Coal/s: ' + str(global.coalPerSec)
	$canvas/pollution.text = 'Costs: ' + str(global.pollution + global.transportCost)

func _ready():
	$canvas/cashAmount.text = 'Cash:' + '$' + str(global.gcash)
	$canvas/upgradeCost.text = 'Cost:' + '$' + str(global.gupgradeCost)

func _on_button_pressed():
	global.gcash = global.gcash + global.gcashPerClick
	$canvas/cashAmount.text = 'Cash:' + '$' + str(global.gcash)
	$click.play()

func _on_upgrade_pressed():
	if global.gcash >= global.gupgradeCost:
		global.gcashPerClick = global.gcashPerClick + 0.1
		global.gcash = global.gcash - global.gupgradeCost
		global.gupgradeCost = global.gupgradeCost + 1
		$canvas/upgradeCost.text = 'Cost:' + '$' + str(global.gupgradeCost)
		$canvas/cashAmount.text = 'Cash:' + '$' + str(global.gcash)
		$upgrade.play()

func _on_menu_pressed():
	get_tree().change_scene("res://Menu.tscn")
