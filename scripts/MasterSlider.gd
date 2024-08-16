extends HSlider
@onready var master_music_button = %MasterMusicButton

var bus := AudioServer.get_bus_index("Master")

func _ready() -> void:
	value = db_to_linear(AudioServer.get_bus_volume_db(bus))

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus, linear_to_db(value))
	if AudioServer.get_bus_volume_db(bus) == 0:
		master_music_button.
