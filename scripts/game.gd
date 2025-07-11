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

# _func = built-in functions
func _ready():
	var cats = Array([],TYPE_OBJECT,"Scene",null)
	print("TileMap node is: ", tilemap)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# Debug input
		print("square click")
		
		# Get position & cell
		var world_pos = get_global_mouse_position()
		var tile_coords = tilemap.local_to_map(world_pos)
		var tile_data = tilemap.get_cell_tile_data(tile_coords)

		# Check if cell in tilemap contains anything
		if tile_data:
			print("Clicked on SQUARE tile at ", tile_coords)
			# Instance sprite2D of cat
			if p1Turn:
				cats.append(cat_black.instantiate())
				p1Turn = false
			else:
				cats.append(cat_white.instantiate())
				p1Turn = true
			print("cats size ", cats.size())
			print("tile coords ", tilemap.map_to_local(tile_coords))
			
			cats.get(cats.size() - 1).position = tilemap.map_to_local(tile_coords)
			add_child(cats.get(cats.size() - 1))
		else:
			print("Clicked on EMPTY tile at ", tile_coords)
