extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	print("Start game button pressed!")
	Maestro.emit_game_started()


func _on_quit_pressed() -> void:
	print("Quit game button pressed. Shutting game down.")
	Maestro.emit_quit_game()
