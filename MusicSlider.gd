extends HSlider
var bus := AudioServer.get_bus_index("Music")
@onready var music_music_button = %MusicMusicButton
var soundicon = preload("res://Assets/soundicon.svg")
var soundiconmuted = preload("res://Assets/soundiconmuted.svg")

func _ready() -> void:
	value = db_to_linear(AudioServer.get_bus_volume_db(bus))
	music_music_button.pressed.connect(musicds)

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus, linear_to_db(value))

func musicds() -> void:
	if 	AudioServer.is_bus_mute(bus) == true:
		music_music_button.texture_normal = soundicon
		AudioServer.set_bus_mute(bus, 0)
		print("unmute")
	elif  	AudioServer.is_bus_mute(bus) == false:
		music_music_button.texture_normal = soundiconmuted
		AudioServer.set_bus_mute(bus, 1)
		print("mute")
