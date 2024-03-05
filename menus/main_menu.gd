extends Control

func _ready():
	if Data.music:
		$AudioStreamPlayer.volume_db = 0
		$Frame/HBoxContainer4/ButtonMusic.show()
		$Frame/HBoxContainer4/ButtonMusicDisable.hide()
	else:
		$AudioStreamPlayer.volume_db = -80
		$Frame/HBoxContainer4/ButtonMusic.hide()
		$Frame/HBoxContainer4/ButtonMusicDisable.show()
	if Data.sound:
		$Click.volume_db = 0
		$Frame/HBoxContainer4/ButtonSound.show()
		$Frame/HBoxContainer4/ButtonSoundDisable.hide()
	else:
		$Click.volume_db = -80
		$Frame/HBoxContainer4/ButtonSound.hide()
		$Frame/HBoxContainer4/ButtonSoundDisable.show()

	if Data.justFinishLv6:
		$Frame.hide()
		$EndGame.show()
		Data.justFinishLv6 = false

func _on_button_play_pressed():
	$Click.play()
	var level = str(PlayerData.level + 1)
	if level == "7":
		$Frame.hide()
		$EndGame.show()
	else:
		await $Click.finished
		get_tree().change_scene_to_file("res://level_" + level + "/level_" + level + ".tscn")

func _on_button_quit_pressed():
	$Click.play()
	await $Click.finished
	get_tree().quit()

func _on_button_level_pressed():
	$Click.play()
	await $Click.finished
	$LevelMenu.show()
	$Frame.hide()

func _on_button_load_pressed():
	$Click.play()
	Data.load_data()
	get_tree().reload_current_scene()

func _on_button_sound_pressed():
	$Click.play()
	Data.sound = false
	$Click.volume_db = -80
	$Frame/HBoxContainer4/ButtonSound.hide()
	$Frame/HBoxContainer4/ButtonSoundDisable.show()

func _on_button_sound_disable_pressed():
	$Click.play()
	Data.sound = true
	$Click.volume_db = 0
	$Frame/HBoxContainer4/ButtonSound.show()
	$Frame/HBoxContainer4/ButtonSoundDisable.hide()

func _on_button_music_pressed():
	$Click.play()
	Data.music = false
	$AudioStreamPlayer.volume_db = -80
	$Frame/HBoxContainer4/ButtonMusic.hide()
	$Frame/HBoxContainer4/ButtonMusicDisable.show()

func _on_button_music_disable_pressed():
	$Click.play()
	Data.music = true
	$AudioStreamPlayer.volume_db = 0
	$Frame/HBoxContainer4/ButtonMusic.show()
	$Frame/HBoxContainer4/ButtonMusicDisable.hide()

func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()
