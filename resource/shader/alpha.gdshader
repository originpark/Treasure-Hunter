shader_type canvas_item;
uniform float alpha : hint_range(0.0, 1.0) = 0.5;

void fragment() {
    COLOR.a *= alpha;  // 将透明度应用到最终颜色上
}
