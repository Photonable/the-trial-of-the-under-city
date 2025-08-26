extends Node3D

enum ColType {START, SECTION_01, SECTION_02, SECTION_03, END}

@export var ColliderType: ColType

@onready var editorMesh = $Area3D/MeshInstance3D
@onready var areaCollider = $Area3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	editorMesh.visible = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Signals		
func _on_area_3d_body_exited(body: Node3D) -> void:
	match ColliderType:
		ColType.START:
			# TODO: Start the gauntlet run game loop.
			_start_gauntlet()
		ColType.SECTION_01:
			# TODO: Start section one of the gauntlet run.
			pass
		ColType.SECTION_02:
			# TODO: Start section two of the gauntlet run.
			pass
		ColType.SECTION_03:
			# TODO: Start section three of the gauntlet run.
			pass
		ColType.END:
			# TODO: End gauntlet run.
			pass

func _start_gauntlet():
	print("Start!!!")
