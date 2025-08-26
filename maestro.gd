extends Node

var debugEna : bool = false
var game_controller : GameController
var showrunner_ai : ShowRunner

signal game_started
signal quit_game
signal splash_finished

func emit_game_started():
	game_started.emit()
	
func emit_quit_game():
	quit_game.emit()
	
func emit_splash_finished():
	splash_finished.emit()
