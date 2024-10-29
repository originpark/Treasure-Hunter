extends CanvasLayer

signal health_changed(value: float)
@onready var texture_progress_bar: TextureProgressBar = $MarginContainer/TextureProgressBar

func _ready() -> void:
	health_changed.connect(update_health_bar)
	


func update_health_bar(value: float) -> void:
	#print("正在更新health_bar")
	await  create_tween().tween_property(texture_progress_bar, "value", value, 0.3).finished
	#print("health_bar更新完成: ", texture_progress_bar.value)
