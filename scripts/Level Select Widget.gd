extends Control
@onready var up_lvl_select = %UpLvlSelect
@onready var label_no = %"Label No"
@onready var dwn_lvl_select = %DwnLvlSelect
var lvlno := 1
# Called when the node enters the scene tree for the first time.
func _ready():
	lvlupanddown()
	buttonlogic()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func lvlupanddown() -> void:
	if lvlno < MaxLvlNo.MaxLvlNo:
		up_lvl_select.pressed.connect(func() -> void: lvlno += 1)
	if lvlno > MaxLvlNo.MaxLvlNo:
		dwn_lvl_select.pressed.connect(func() -> void: lvlno -= 1)	

func buttonlogic() -> void:
	up_lvl_select.focus_exited.connect(func() -> void: up_lvl_select.texture_normal)
	up_lvl_select.focus_entered.connect(func() -> void: up_lvl_select.texture_hover)
	pass
