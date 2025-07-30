class_name GameController extends Node

@export var world_3d : Node3D
@export var world_2d : Node2D
@export var gui : Control

@onready var current_3d_scene
@onready var current_2d_scene
@onready var current_gui_scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Maestro.game_controller = self
	Maestro.game_started.connect(_on_start_game)
	Maestro.quit_game.connect(_on_quit_game)
	Maestro.splash_finished.connect(_on_splash_finish)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#func _unhandled_key_input(event: InputEvent) -> void:
	#if Input.is_action_pressed("Pause"):
		#get_tree().quit()

# Change the gui scene.
func change_gui_scene(new_scene: String, delete: bool = true, keep_running: bool = false) -> void:
	if current_gui_scene != null:
		if delete:
			print("Destroying " + str(current_gui_scene) + " .")
			current_gui_scene.queue_free() # Removes node entirely
		if keep_running:
			print("Keeping " + str(current_gui_scene) + " running in background.")
			current_gui_scene.visible = false # Keeps in memory and running
		else:
			print("Removing " + str(current_gui_scene) +  " from the parent node. Keeping in memory.")
			gui.remove_child(current_gui_scene) # Keeps in memory, does not run
	var new = load(new_scene).instantiate()
	gui.add_child(new)
	current_gui_scene = new
	print("Current GUI scene is " + str(current_gui_scene) + " .")
	
# Change the 3d scene.
func change_3d_scene(new_scene: String, delete: bool = true, keep_running: bool = false) -> void:
	if current_3d_scene != null:
		if delete:
			print("Destroying " + str(current_3d_scene) + " .")
			current_3d_scene.queue_free() # Removes node entirely
		if keep_running:
			print("Keeping " + str(current_3d_scene) + " running in background.")
			current_3d_scene.visible = false # Keeps in memory and running
		else:
			print("Removing " + str(current_3d_scene) + " from the parent node. Keeping in memory.")
			world_3d.remove_child(current_3d_scene) # Keeps in memory, does not run
	var new = load(new_scene).instantiate()
	world_3d.add_child(new)
	current_3d_scene = new
	print("Current World 3D scene is " + str(current_3d_scene) + " .")

# Change the 2d scene
func change_2d_scene(new_scene: String, delete: bool = true, keep_running: bool = false) -> void:
	pass

func _on_splash_finish():
	print("Splash screen \"finished\" signal.")
	change_gui_scene("res://Scenes/GUIScenes/main_menu.tscn", true, false)
	
	
func _on_start_game():
	change_gui_scene("res://Scenes/GUIScenes/blank.tscn", true, false)
	change_3d_scene("res://Scenes/3DScenes/Test.tscn", false, false)
	
func _on_quit_game():
	get_tree().quit()
