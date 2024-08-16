extends HSlider
@onready var master_music_button = %MasterMusicButton

var soundicon = preload("res://Assets/soundicon.svg")
var soundiconmuted = preload("res://Assets/soundiconmuted.svg")

var bus := AudioServer.get_bus_index("Master")

func _ready() -> void:
	value = db_to_linear(AudioServer.get_bus_volume_db(bus))
	master_music_button.pressed.connect(mmds)

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus, linear_to_db(value))

func mmds() -> void:
	if 	AudioServer.is_bus_mute(bus) == true:
		master_music_button.texture_normal = soundicon
		AudioServer.set_bus_mute(bus, 0)
		print("unmute")
	elif  	AudioServer.is_bus_mute(bus) == false:
		master_music_button.texture_normal = soundiconmuted
		AudioServer.set_bus_mute(bus, 1)
		print("mute")
