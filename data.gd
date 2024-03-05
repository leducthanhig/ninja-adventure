extends Node

const SAVE_PATH = "user://user_data.data"

var sound = true
var music = true
var justFinishLv6 = false

func load_data():
	var config = ConfigFile.new()
	var checkFile = config.load(SAVE_PATH)
	if checkFile == OK:
		PlayerData.scores = config.get_value("player", "scores")
		PlayerData.level = config.get_value("player", "level")
		Data.sound = config.get_value("setting", "sound")
		Data.music = config.get_value("setting", "music")

func save_data():
	var config = ConfigFile.new()
	config.set_value("player", "scores", PlayerData.scores)
	config.set_value("player", "level", PlayerData.level)
	config.set_value("setting", "sound", Data.sound)
	config.set_value("setting", "music", Data.music)
	config.save(SAVE_PATH)
