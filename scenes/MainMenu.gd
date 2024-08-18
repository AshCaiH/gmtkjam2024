extends Node2D
# @onready var mm_background_music = $MMBackgroundMusic
@onready var start_button = %"Start Button"
@onready var hard_button = %"Hard Button"
@onready var credits = %Credits
@onready var credits_window = %CreditsWindow
@onready var level_select = %"Level Select"

# Called when the node enters the scene tree for the first time.
func _ready():
	# mm_background_music.play()
	start_button.pressed.connect(startgame)
	hard_button.pressed.connect(hardMode)
	credits.pressed.connect(creditswindow)
	startvisibility()

func hardMode():
	Globals.hardMode = true;
	startgame()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func startgame() -> void:
	get_tree().change_scene_to_file("scenes/Main.tscn")
	pass
	
func creditswindow() -> void:
	credits_window.visible = true
	
func startvisibility() -> void:
	if MaxLvlNo.MaxLvlNo > 1:
		start_button.visible = false
		level_select.visible = true
	else:
		start_button.visible = true
		level_select.visible = false
		
