extends Control
@onready var resume = %Resume
@onready var main_menu = %"Main Menu"
@onready var restart_level = %"Restart Level"
@onready var margin_container = %MarginContainer

var margin_value = 8
# Called when the node enters the scene tree for the first time.
func _ready():
	margin_container.add_theme_constant_override("margin_top", margin_value)
	margin_container.add_theme_constant_override("margin_left", margin_value)
	margin_container.add_theme_constant_override("margin_bottom", margin_value)
	margin_container.add_theme_constant_override("margin_right", margin_value)
	resume.pressed.connect(resumegame)
	restart_level.pressed.connect(restartlevel)
	main_menu.pressed.connect(gotomain)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func resumegame() -> void:
	pass
	
func restartlevel() -> void:
	pass

func gotomain() -> void:
	pass
