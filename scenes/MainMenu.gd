extends Node2D
@onready var mm_background_music = $MMBackgroundMusic
@onready var start_button = %"Start Button"
@onready var credits = %Credits

# Called when the node enters the scene tree for the first time.
func _ready():
	mm_background_music.play()
	start_button.button_pressed.connect(startgame)
	credits.button_pressed.connect(creditswindow)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func startgame() -> void:
	#get_tree().change_scene_to_file()
	pass
	
func creditswindow() -> void:
	pass
