extends Node2D

enum CellType { PLAYER,OBSTACLE, OBJECT_SOLID, OBJECT_PERMEABLE }

export(CellType) var type = CellType.OBJECT_SOLID setget set_type, getType

var active = true setget set_active

func set_active(value):
	active = value
	set_process(value)
	set_process_input(value)
	return

func set_type(newType = CellType.OBJECT_SOLID):
	match newType:
		CellType.OBJECT_SOLID:
			type = newType
			return
		CellType.OBJECT_PERMEABLE:
			type = newType
			return
		CellType.PLAYER:
			type = newType
			return
		CellType.OBSTACLE:
			type = newType
			return
		_:
			push_error("Type %s is not a valid type!" % [newType])

func getType():
	return type
