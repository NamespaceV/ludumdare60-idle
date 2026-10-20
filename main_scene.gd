extends Node2D

var food = 0
var stones = 0
var huts = 0
var stonehenge = 0

var hut_timer = 1.0

func _ready() -> void:
	$Food.on_interact.connect(addFood)
	$Stones.on_interact.connect(addStones)
	$Huts.on_interact.connect(addHut)
	$Stonehenge.on_interact.connect(addStoneHenge)

func addFood():
	food += 1

func addStones():
	if food >= 1:
		stones += 1
		food -= 1

func addHut():
	if stones >= 5:
		stones -= 5
		huts += 1

func addStoneHenge():
	if stones >= 100:
		stones -= 100
		stonehenge += 1

func _process(delta: float) -> void:
	hut_timer -= delta
	if hut_timer <= 0:
		hut_timer += 1
		food += huts
	refresh_ui()

func refresh_ui():
	$Food/Label.text ="Food %d" % [food]
	$Stones/Label.text ="Stones %d" % [stones]
	$Huts/Label.text ="Huts %d" % [huts]
	$Stonehenge/Label.text ="Stonehenge %d" % [stonehenge]
