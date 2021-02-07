extends TileMap

enum CellType { PLAYER, OBSTACLE, OBJECT_SOLID, OBJECT_PERMEABLE }
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		set_cellv(world_to_map(child.position), child.type)


func get_cell_pawn(cell, type = CellType.OBJECT_SOLID):
	for node in get_children():
		if node.type != type:
			continue
		if world_to_map(node.position) == cell:
			return(node)

## Attempt to trigger an objects onTrigger function. If it doesn't exist, don't do anything
func attempt_trigger(pawn, direction):
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction
	
	var cell_tile_id = get_cellv(cell_target)
	match cell_tile_id:
		-1:
			return
		_:
			var target_pawn = get_cell_pawn(cell_target, cell_tile_id)
			if (not target_pawn.has_node("EventHandler")):
				return
			
			if (target_pawn.get_node("EventHandler").onTrigger):
				target_pawn.get_node("EventHandler").onTrigger()
				return

##Request to move. Move requests will be made inside of the player script.
func request_move(pawn, direction):
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction

	var cell_tile_id = get_cellv(cell_target)
	match cell_tile_id:
		-1:
			set_cellv(cell_target, CellType.ACTOR)
			set_cellv(cell_start, -1)
			return map_to_world(cell_target) + cell_size / 2
		##SOLID OBJECT COLLISION
		CellType.OBJECT_SOLID:
			var target_pawn = get_cell_pawn(cell_target, cell_tile_id)
			print("Cell %s contains %s" % [cell_target, target_pawn.name])

			if (not target_pawn.has_node("EventHandler")):
				return 
			## If there is a node named eventhandler inside of whatever it has collided with, trigger the function
			## named "onCollide()" inside that event handler
			if target_pawn.has_node("EventHandler"):
				target_pawn.get_node("EventHandler").onCollide();
		##PERMEABLE OBJECT COLLISION
		CellType.OBJECT_PERMEABLE:
			var target_pawn = get_cell_pawn(cell_target, cell_tile_id)
			print("Cell %s contains %s, passing through" % [cell_target, target_pawn.name])

			if (not target_pawn.has_node("EventHandler")):
				return 
			## If there is a node named eventhandler inside of whatever it has collided with, trigger the function
			## named "onCollide()" inside that event handler
			if target_pawn.get_node("EventHandler").onCollide:
				target_pawn.get_node("EventHandler").onCollide();
			## Overwrite the cell and move over it
			set_cellv(cell_target, CellType.ACTOR)
			set_cellv(cell_start, -1)
			return map_to_world(cell_target) + cell_size / 2
				
