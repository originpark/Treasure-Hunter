extends ParallaxBackground

@onready var big_cloud_parallax_layer: ParallaxLayer = $BigCloudParallaxLayer
@onready var small_cloud_parallax_layer: ParallaxLayer = $SmallCloudParallaxLayer


func _physics_process(delta: float) -> void:
	small_cloud_parallax_layer.motion_offset.x -= 0.1
	if small_cloud_parallax_layer.motion_offset.x <= -384:
		small_cloud_parallax_layer.motion_offset.x = 0
		
	big_cloud_parallax_layer.motion_offset.x -= 0.3
	if big_cloud_parallax_layer.motion_offset.x <= -448:
		big_cloud_parallax_layer.motion_offset.x = 0
