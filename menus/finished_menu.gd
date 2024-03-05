extends Control

func _ready():
	if Data.sound:
		$Click.volume_db = 0
	else:
		$Click.volume_db = -80

func _process(delta):
	if get_parent().finished and get_parent().get_parent().get_node("Player").animation.animation == "idle":
		show()
		get_tree().paused = true

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

func _on_next_level_pressed():
	$Click.play()
	await $Click.finished
	get_tree().paused = false
	var nextLv = str(int(str(get_parent().get_parent().name)[-1]) + 1)
	if nextLv == "7":
		Data.justFinishLv6 = true
		get_tree().change_scene_to_file("res://menus/main_menu.tscn")
	else:
		get_tree().change_scene_to_file("res://level_" + nextLv +"/level_" + nextLv + ".tscn")
