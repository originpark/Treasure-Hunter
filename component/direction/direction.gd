class_name Direction
extends Node
## 角色的面朝方向组件

## value值的枚举
enum {LEFT = -1, RIGHT = 1}

## 与方向绑定的sprite
@export var Graphics: Node2D

## 方向值, 初始默认面朝右
var value: int = RIGHT:
	set(v):
		if v == LEFT:
			value = LEFT
			Graphics.scale.x = -1
		elif v == RIGHT:
			value = RIGHT
			Graphics.scale.x = 1
		else:
			print("error: 方向设置未生效, 错误值: ", v)
