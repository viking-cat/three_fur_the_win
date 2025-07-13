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
var squareMetaData


# _func = built-in functions
func _ready():
	squareMetaData = {}
	var cats = Array([],TYPE_OBJECT,"Scene",null)
	print("TileMap node is: ", tilemap)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# Debug input
		print("square click")
		
		# Get position & cell
		# var world_pos = get_global_mouse_position()
		# var tile_coords = tilemap.local_to_map(world_pos)
		# var tile_data = tilemap.get_cell_tile_data(tile_coords)
		
		# get_viewport().get_mouse_position()
		# var tile_coords := get_viewport().get_mouse_position()
		var tilemapMousePosition = tilemap.get_local_mouse_position()
		var tilemapCoords = tilemap.local_to_map(tilemapMousePosition)
		var tile_data = tilemap.get_cell_tile_data(tilemapCoords)
		# print ("view pos: ", viewMousPosition)
		# print ("global pos: ", world_pos)
		# print ("tilemap pos: ", tilemap.get_local_mouse_position())

		# Check if cell in tilemap contains anything
		if tile_data:
			print("Clicked on SQUARE tile at ", tilemapCoords)
			
			# Instance sprite2D of cat
			if p1Turn:
				cats.append(cat_black.instantiate())
				squareMetaData[ tilemapCoords ] = {"player": 1}
				p1Turn = false
			else:
				cats.append(cat_white.instantiate())
				squareMetaData[ tilemapCoords ] = {"player": 2}
				p1Turn = true
			print("----------------------------------")
			print("cats size ", cats.size())
			print("tile coords ", tilemap.map_to_local(tilemapCoords))
			print("squareMetadata ", squareMetaData )
			cats.get(cats.size() - 1).position = Vector2i(
				tilemap.position.x + tilemap.map_to_local(tilemapCoords).x,
				tilemap.position.y + tilemap.map_to_local(tilemapCoords).y
			)
			#cats.get(cats.size() - 1).position = tilemap.map_to_local(tilemapCoords)
			add_child(cats.get(cats.size() - 1))
			checkWinner()
		else:
			print("Clicked on EMPTY tile at ", tilemapCoords)

func checkWinner() :
	print("Check winner")
