extends Control
@onready var up_lvl_select = %UpLvlSelect
@onready var label_no = %"Label No"
@onready var dwn_lvl_select = %DwnLvlSelect
var lvlno := 1
# Called when the node enters the scene tree for the first time.
func _ready():
	lvlupanddown()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func lvlupanddown() -> void:
	#up_lvl_select.pressed.connect(func() -> void: print(lvlno))
	up_lvl_select.pressed.connect(upbutton)
	dwn_lvl_select.pressed.connect(downbutton)
	
func upbutton() -> void:
	if lvlno < MaxLvlNo.MaxLvlNo:
		lvlno += 1
		label_no.text = str(lvlno)
	
func downbutton() -> void:
	if lvlno > 1:
		lvlno -= 1
		label_no.text = str(lvlno)
