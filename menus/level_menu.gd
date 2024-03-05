extends Control

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		hide()
		get_parent().get_node("Frame").show()

func _ready():
	if Data.sound:
		$Click.volume_db = 0
	else:
		$Click.volume_db = -80

	var score = [-1]
	for i in range(1, 7):
		score += [PlayerData.scores["Level" + str(i)]]
	
	for i in range(1, 7):
		var firstPara = str((i + 1) / 2)
		var secondPara = str(1 if i % 2 else 2)
		if score[i] == 0:
			if score[i - 1] != 0:
				get_node("Levels/Map" + firstPara + "/Level" + str(i)).disabled = false
			else:
				get_node("Levels/Star" + firstPara + "/Level" + secondPara + "_0").hide()
				get_node("Levels/Star" + firstPara + "/Level" + secondPara + "_disable").show()
				get_node("Levels/Map" + firstPara + "/Level" + str(i)).disabled = true
		else:
			get_node("Levels/Star" + firstPara + "/Level" + secondPara + "_0").hide()
			if score[i] == 100:
				get_node("Levels/Star" + firstPara + "/Level" + secondPara + "_3").show()
			elif score[i] >= 67:
				get_node("Levels/Star" + firstPara + "/Level" + secondPara + "_2").show()
			else:
				get_node("Levels/Star" + firstPara + "/Level" + secondPara + "_1").show()
			get_node("Levels/Map" + firstPara + "/Level" + str(i)).disabled = false

func _on_level_1_pressed():
	$Click.play()
	await $Click.finished
	get_tree().change_scene_to_file("res://level_1/level_1.tscn")

func _on_level_2_pressed():
	$Click.play()
	await $Click.finished
	get_tree().change_scene_to_file("res://level_2/level_2.tscn")

func _on_level_3_pressed():
	$Click.play()
	await $Click.finished
	get_tree().change_scene_to_file("res://level_3/level_3.tscn")

func _on_level_4_pressed():
	$Click.play()
	await $Click.finished
	get_tree().change_scene_to_file("res://level_4/level_4.tscn")

func _on_level_5_pressed():
	$Click.play()
	await $Click.finished
	get_tree().change_scene_to_file("res://level_5/level_5.tscn")

func _on_level_6_pressed():
	$Click.play()
	await $Click.finished
	get_tree().change_scene_to_file("res://level_6/level_6.tscn")

func _on_exit_pressed():
	$Click.play()
	hide()
	get_parent().get_node("Frame").show()
