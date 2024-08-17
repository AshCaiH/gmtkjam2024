extends Control
@onready var up_lvl_select = %UpLvlSelect
@onready var label_no = %"Label No"
@onready var dwn_lvl_select = %DwnLvlSelect
@onready var playgamebutton = %Playgamebutton

var lvlno := 1
# Called when the node enters the scene tree for the first time.
func _ready():
	dwn_lvl_select.disabled = true
	lvlupanddown()
	playgamebutton.pressed.connect(startgame)
	self.position = get_viewport_rect().size/2
	self.position.y = 530

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func lvlupanddown() -> void:
	#up_lvl_select.pressed.connect(func() -> void: print(lvlno))
	up_lvl_select.pressed.connect(upbutton)
	dwn_lvl_select.pressed.connect(downbutton)
	
func upbutton() -> void:
	if lvlno < MaxLvlNo.MaxLvlNo:
		lvlno += 1
		label_no.text = str(lvlno)
		buttoncheck()
	
func downbutton() -> void:
	if lvlno > 1:
		lvlno -= 1
		label_no.text = str(lvlno)
		buttoncheck()
		
func buttoncheck() -> void:
	if lvlno == 1:
		dwn_lvl_select.disabled = true
	else:
		dwn_lvl_select.disabled = false

	if lvlno == MaxLvlNo.MaxLvlNo:
		up_lvl_select.disabled = true
	else:
		up_lvl_select.disabled = false
		
func startgame() -> void:
	#get_tree().change_scene_to_file()
	pass
