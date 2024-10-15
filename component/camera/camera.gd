class_name Camera
extends Camera2D

@export var tilemap_layer: TileMapLayer

func _ready() -> void:
	var used_rect := tilemap_layer.get_used_rect()
	var tile_size := tilemap_layer.tile_set.tile_size
	limit_top = used_rect.position.y * tile_size.y
	limit_bottom = used_rect.end.y * tile_size.y
	limit_left = used_rect.position.x * tile_size.x
	limit_right = used_rect.end.x * tile_size.x
	reset_smoothing()
