extends Node2D

var mineCost = 10
var rikszaCost = 7.5
var drillCost = 20
var lidlCost = 40

func _process(delta):
	$canvas/cashAmount.text = 'Cash: ' + str(global.gcash)
	$canvas/coalAmount.text = 'Coal: ' + str(global.gcoal)

func _ready():
	$canvas/cashAmount.text = 'Cash:' + '$' + str(global.gcash)
	$canvas/coalAmount.text = 'Coal:' + '$' + str(global.gcoal)
	
	$canvas/mineCost.text = 'Cost:' + '$' + str(mineCost)
	$canvas/rikszaCost.text = 'Cost:' + '$' + str(rikszaCost)
	$canvas/drillCost.text = 'Cost:' + '$' + str(drillCost)
	$canvas/lidlCost.text = 'Cost:' + '$' + str(lidlCost)
	
	if global.isMine1Purchased == true:
		$canvas/mine1.disabled = true
	else:
		$canvas/obamiumdrills.disabled = true
	
	if global.isTransport1Purchased == true:
		$canvas/transport1.disabled = true
	else:
		$canvas/lidlracing.disabled = true
	
	if global.isDrill1Purchased == true:
		$canvas/obamiumdrills.disabled = true
	if global.isLidl1Purchased == true:
		$canvas/lidlracing.disabled = true
	
func _on_menu_pressed():
	get_tree().change_scene("res://Main.tscn")

func _on_mine1_pressed():
	if global.gcash >= mineCost:
		global.gcash = global.gcash - mineCost
		$canvas/cashAmount.text = 'Cash:' + '$' + str(global.gcash)
		$purchase.play()
		global.isMine1Purchased = true
		$canvas/obamiumdrills.disabled = false
		$canvas/mine1.disabled = true
		
		global.coalYield += 1
		global.pollution += 5
		#call the mine1 only in the level 1 mine, later mines don't need that
		global.Mine1.start()
		global.coalPerSec += 1
		_ready()

func _on_transport1_pressed():
	if global.gcash >= rikszaCost:
		global.gcash = global.gcash - rikszaCost
		$canvas/cashAmount.text = 'Cash:' + '$' + str(global.gcash)
		$purchase.play()
		global.isTransport1Purchased = true
		$canvas/lidlracing.disabled = false
		$canvas/transport1.disabled = true
		
		global.pollution += 3
		global.transportCapacity += 2
		global.transportLoss += 0.5
		global.transportCost += 3
		
		global.Transport1.start()
		global.cashPerSec += global.coalValue * (global.transportCapacity - global.transportLoss)
		_ready()

func _on_obamiumdrills_pressed():
	if global.gcash >= drillCost:
		global.gcash = global.gcash - drillCost
		$canvas/cashAmount.text = 'Cash:' + '$' + str(global.gcash)
		$purchase.play()
		global.isDrill1Purchased = true
		$canvas/obamiumdrills.disabled = true
		
		global.coalYield += 2
		global.pollution += 1
		global.coalPerSec += 2
		_ready()

func _on_lidlracing_pressed():
	if global.gcash >= lidlCost:
		global.gcash = global.gcash - lidlCost
		$canvas/cashAmount.text = 'Cash:' + '$' + str(global.gcash)
		$purchase.play()
		global.isLidl1Purchased = true
		$canvas/lidlracing.disabled = true
		
		global.transportSpeed -= 0.5
		global.Transport1.set_wait_time(global.transportSpeed)
		global.transportCost += 1
		global.transportLoss += 0.2
		_ready()

