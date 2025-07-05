extends Node2D

# @onready = built in
# $ = getnode from scene
@onready var tilemap := $Squares # adjust path if needed

# _func = built-in functions
func _ready():
	print("TileMap node is: ", tilemap)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("hello")
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
