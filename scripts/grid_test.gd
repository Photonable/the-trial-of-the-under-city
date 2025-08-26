extends Node3D

# Using UP/DOWN in a Vector2 is for 2D, which is Y-axis.
# For a 3D grid on the XZ plane, it's more intuitive to think of
# them as forward/backward.
const dir = [
	Vector3(1, 0, 0),   # Right
	Vector3(-1, 0, 0),  # Left
	Vector3(0, 0, -1),  # Forward
	Vector3(0, 0, 1)    # Backward
]

var grid_size = 50
var grid_steps = 50

func _ready() -> void:
	randomize()

	var current_pos = Vector3i(0, 0, 0)
	var last_dir = Vector3(0, 0, 0) # Use a Vector3 for last_dir

	$GridMap.set_cell_item(current_pos, 0, 0) # Place the first block

	for i in range(0, grid_steps):
		var valid_dirs = dir.duplicate()
		valid_dirs.shuffle()

		var next_dir = Vector3.ZERO
		
		# Find a valid direction
		for d in valid_dirs:
			var next_pos = current_pos + Vector3i(d)
			# Check if the move is within bounds and not a reversal of the last move
			if (abs(next_pos.x) <= grid_size and 
				abs(next_pos.z) <= grid_size and 
				d != -last_dir):
				
				next_dir = d
				break
		
		# If a valid direction was found, move and place a block
		if next_dir != Vector3.ZERO:
			current_pos += Vector3i(next_dir)
			last_dir = next_dir
			$GridMap.set_cell_item(current_pos, 0, 0)
		else:
			# Handle the case where no valid move can be made
			# For example, by breaking the loop or logging a message
			print("No valid move found, ending path generation.")
			break
