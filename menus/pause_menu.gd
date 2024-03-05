extends Control

@onready var musicStream = get_parent().get_node("AudioStreamPlayer")

func _ready():
	if Data.music:
		musicStream.volume_db = 0
		$PauseMenu/HBoxContainer/Music.show()
		$PauseMenu/HBoxContainer/Music_disable.hide()
	else:
		musicStream.volume_db = -80
		$PauseMenu/HBoxContainer/Music.hide()
		$PauseMenu/HBoxContainer/Music_disable.show()
	if Data.sound:
		$Click.volume_db = 0
		$PauseMenu/HBoxContainer/Sound.show()
		$PauseMenu/HBoxContainer/Sound_disable.hide()
	else:
		$Click.volume_db = -80
		$PauseMenu/HBoxContainer/Sound.hide()
		$PauseMenu/HBoxContainer/Sound_disable.show()
	
	var level = str(get_tree().get_current_scene().get_path())[-1]
	$PauseMenu/Title.text = "Level " + level

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and visible:
		if get_tree().paused:
			get_tree().paused = false
			$PauseMenu.hide()
		else:
			get_tree().paused = true
			$PauseMenu.show()

func _on_show_pause_menu_pressed():
	$Click.play()
	get_tree().paused = true
	$PauseMenu.show()

func _on_continue_pressed():
	$Click.play()
	get_tree().paused = false
	$PauseMenu.hide()

func _on_replay_pressed():
	$Click.play()
	await $Click.finished
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_main_menu_pressed():
	$Click.play()
	await $Click.finished
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")

func _on_sound_pressed():
	$Click.play()
	Data.sound = false
	$Click.volume_db = -80
	$PauseMenu/HBoxContainer/Sound.hide()
	$PauseMenu/HBoxContainer/Sound_disable.show()

func _on_sound_disable_pressed():
	$Click.play()
	Data.sound = true
	$Click.volume_db = 0
	$PauseMenu/HBoxContainer/Sound.show()
	$PauseMenu/HBoxContainer/Sound_disable.hide()

func _on_music_pressed():
	$Click.play()
	Data.music = false
	musicStream.volume_db = -80
	$PauseMenu/HBoxContainer/Music.hide()
	$PauseMenu/HBoxContainer/Music_disable.show()

func _on_music_disable_pressed():
	$Click.play()
	Data.music = true
	musicStream.volume_db = 0
	$PauseMenu/HBoxContainer/Music.show()
	$PauseMenu/HBoxContainer/Music_disable.hide()
