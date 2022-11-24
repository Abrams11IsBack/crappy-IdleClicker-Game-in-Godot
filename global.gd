extends Node

var gcash = 0
var gcashPerClick = 0.1
var gupgradeCost = 0.5

var isMine1Purchased = false
var isTransport1Purchased = false
var isDrill1Purchased = false
var isLidl1Purchased = false

var gcoal = 0

var coalYield = 0
var pollution = 0
var transportCapacity = 0
var transportLoss = 0
var transportCost = 0
var transportSpeed = 1 #the lower the faster

#later add less polluting mines/transport to buy, mine selling and a big menu for all of that
#also add less costly transport and ones that have less coal loss per shipment
#upload this project to github later

#timer variables here
var Mine1:Timer
var Transport1:Timer
var Costs:Timer

var coalPerSec = 0
var cashPerSec = 0

var coalValue = 3

func _ready():
	#create new timer for Mine1
	Mine1 = Timer.new()
	Mine1.set_wait_time(1)
	Mine1.connect("timeout", self, "_on_Mine1_timeout")
	add_child(Mine1)
	
	#create new timer for Transport1
	Transport1 = Timer.new()
	Transport1.set_wait_time(transportSpeed)
	Transport1.connect("timeout", self, "_on_Transport1_timeout")
	add_child(Transport1)
	
	#create new timer for Costs (every 30 seconds there is tax)
	Costs = Timer.new()
	Costs.set_wait_time(30)
	Costs.connect("timeout", self, "_on_Costs_timeout")
	add_child(Costs)
	
	Costs.start()


#timer functions
func _on_Mine1_timeout():
	gcoal += coalYield
	
func _on_Transport1_timeout():
	if gcoal >= transportCapacity:
		gcoal -= transportCapacity
		var transportOutput = transportCapacity - transportLoss
		gcash += transportOutput
		
func _on_Costs_timeout():
	gcash -= pollution + transportCost
