extends TileMap

enum CellType { PLAYER, OBSTACLE, OBJECT_SOLID, OBJECT_PERMEABLE }
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var width = 29
var height = 13
var animals = 0
var strawberry = preload("res://Classes/Strawberry.tscn")
var animal = preload("res://Classes/Animal.tscn")

func removeAnimal():
	print ("Removing 1 of ", animals)
	animals -= 1
	print("There are ", animals, " left")
	if animals == 0:
		print("Yeet")
		self.get_parent().get_parent().changeGameState("StartScreen")
	return

# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	for child in get_children():
		set_cellv(world_to_map(child.position), child.type)
	for i in range(rng.randi_range(1,1)):
		var randx = rng.randi_range(0,width)
		var randy = rng.randi_range(0,height)
		#berry
		while get_cellv(Vector2(randx,randy)) != -1:
			randx = rng.randi_range(0,width)
			randy = rng.randi_range(0,height)
		var newBerry = strawberry.instance(2)
		self.add_child(newBerry)
		newBerry.position = map_to_world(Vector2(randx,randy)) + cell_size / 2
		randx = rng.randi_range(0,width)
		randy = rng.randi_range(0,height)
		while get_cellv(Vector2(randx,randy)) != -1:
			randx = rng.randi_range(0,width)
			randy = rng.randi_range(0,height)
		var newAnimal = animal.instance(2)
		self.add_child(newAnimal)
		newAnimal.position = map_to_world(Vector2(randx,randy)) + cell_size / 2
		animals += 1
		print("Animal at position ",randx, ":", randy)
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
		CellType.OBSTACLE:
			return
		_:
			var target_pawn = get_cell_pawn(cell_target, cell_tile_id)
			if target_pawn == null:
				return
			if (not target_pawn.has_node("EventHandler")):
				return
			target_pawn.get_node("EventHandler").onTrigger(pawn)
			if target_pawn.get_node("EventHandler").consume() == true:
				self.remove_child(target_pawn)
				set_cellv(cell_target, -1)
			return

##Request to move. Move requests will be made inside of the player script.
func request_move(pawn, direction):
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction

	var cell_tile_id = get_cellv(cell_target)
	match cell_tile_id:
		-1:
			set_cellv(cell_target, pawn.getType())
			set_cellv(cell_start, -1)
			return map_to_world(cell_target) + cell_size / 2
		##SOLID OBJECT COLLISION
		CellType.OBSTACLE:
			return
		CellType.PLAYER:
			return
		CellType.OBJECT_SOLID:
			var target_pawn = get_cell_pawn(cell_target, cell_tile_id)
			if target_pawn == null:
				return

			if (not target_pawn.has_node("EventHandler")):
				return 
			## If there is a node named eventhandler inside of whatever it has collided with, trigger the function
			## named "onCollide()" inside that event handler
			if target_pawn.has_node("EventHandler"):
				target_pawn.get_node("EventHandler").onCollide();
		##PERMEABLE OBJECT COLLISION
		CellType.OBJECT_PERMEABLE:
			var target_pawn = get_cell_pawn(cell_target, cell_tile_id)

			if (not target_pawn.has_node("EventHandler")):
				return 
			## If there is a node named eventhandler inside of whatever it has collided with, trigger the function
			## named "onCollide()" inside that event handler
			target_pawn.get_node("EventHandler").onCollide();
			## Overwrite the cell and move over it
			self.remove_child(target_pawn)
			set_cellv(cell_target, CellType.PLAYER)
			set_cellv(cell_start, -1)
			return map_to_world(cell_target) + cell_size / 2
				
