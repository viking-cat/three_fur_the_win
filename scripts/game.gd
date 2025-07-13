extends Node2D

# @onready = built in
# $ = getnode from scene
@onready var tilemap := $NewSquareOnTheBlock # adjust path if needed
@onready var cat_black := preload("res://assets/cat_black.tscn")
@onready var cat_white := preload("res://assets/cat_white.tscn")
@onready var cats: Array[Node2D] = []
@onready var p1Label := $"Camera2D/P1 Tittle"
@onready var p2Label := $"Camera2D/P2 Tittle"
@onready var p1Turn := true
@onready var cellDataWrappers


# _func = built-in functions
func _ready():
	cellDataWrappers = {}
	var cats = Array([],TYPE_OBJECT,"Scene",null)
	print("TileMap node is: ", tilemap)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# Debug input
		# print("square click")
		
		# Get position & cell
		var tilemapMousePosition = tilemap.get_local_mouse_position()
		var tilemapCoords = tilemap.local_to_map(tilemapMousePosition)
		
		# Get cell data (no graphics = no data)
		var realCellData = tilemap.get_cell_tile_data(tilemapCoords)

		# Check if cell contained data
		if realCellData:
			
			# No data in dictionary at these cell coordinates means it is free
			if tilemapCoords not in cellDataWrappers:

				# Instance sprite2D of cat
				if p1Turn:
					# cats.append(cat_black.instantiate())
					cellDataWrappers[ tilemapCoords ] = {
						"player": 1,
						"artInstance" : cat_black.instantiate()
					}
					p1Turn = false
				else:
					#cats.append(cat_white.instantiate())
					#cellDataWrappers[ tilemapCoords ] = {"player": 2}
					cellDataWrappers[ tilemapCoords ] = {
						"player": 2,
						"artInstance" : cat_white.instantiate()
					}
					p1Turn = true
				# print("----------------------------------")
				# print("cats size ", cats.size())
				# print("tile coords ", tilemap.map_to_local(tilemapCoords))
				# print("cellDataWrappers ", cellDataWrappers )
				# cats.get(cats.size() - 1).position = Vector2i(
				cellDataWrappers[tilemapCoords]["artInstance"].position = Vector2i(
					tilemap.position.x + tilemap.map_to_local(tilemapCoords).x,
					tilemap.position.y + tilemap.map_to_local(tilemapCoords).y
				)
				# add_child(cats.get(cats.size() - 1))
				add_child(cellDataWrappers[tilemapCoords]["artInstance"])
				checkWinner()
		else:
			print("Clicked on EMPTY tile at ", tilemapCoords)

func checkWinner() :
	print("Check winner")
