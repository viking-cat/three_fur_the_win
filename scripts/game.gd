extends Node2D

# @onready = built in
# $ = getnode from scene
@onready var tilemap := $Squares # adjust path if needed
@onready var cat_black := preload("res://assets/cat_black.tscn")
@onready var cat_white := preload("res://assets/cat_white.tscn")
@onready var cats: Array[Node2D] = []

# _func = built-in functions
func _ready():
	var cats = Array([],TYPE_OBJECT,"Scene",null)
	print("TileMap node is: ", tilemap)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# Debug input
		print("click")
		
		# Get position & cell
		var world_pos = get_global_mouse_position()
		var tile_coords = tilemap.local_to_map(world_pos)
		var tile_data = tilemap.get_cell_tile_data(tile_coords)

		# Instance sprite2D of cat
		#var myTest = cat_white.instantiate()
		#add_child(myTest)
		cats.append(cat_black.instantiate())
		print("cats size ", cats.size())
		print("tile coords ", tilemap.map_to_local(tile_coords))
		
		cats.get(cats.size() - 1).position = tilemap.map_to_local(tile_coords)
		add_child(cats.get(cats.size() - 1))
		#cats.get(cats.size()-1)

		if tile_data:
			print("Clicked on tile at ", tile_coords)
		else:
			print("No tile at clicked position")
#    if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
#        var click_pos = event.position
#        var world_pos = get_viewport().get_camera_2d().screen_to_world(click_pos)
#        var tile_coords = tilemap.local_to_map(world_pos)
#
#        var tile_data = tilemap.get_cell_tile_data(0, tile_coords)  # layer 0
##        if tile_data:
#            print("Clicked on tile at ", tile_coords)
#        else:
#            print("No tile at clicked position")
