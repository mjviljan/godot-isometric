// this is from the Godot forums post https://godotforums.org/d/36452-simple-way-for-sprite-masks-in-godot-4 with slight changes

shader_type canvas_item;

uniform vec2 holeCenter;
uniform float holeRadius;
uniform float penumbra = 20.0;

varying vec2 p;

void vertex(){
	p = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0) ).xy;
}

void fragment(){
	vec4 original = texture(TEXTURE, UV);
	COLOR.a = min(smoothstep(holeRadius - penumbra/2.0, holeRadius + penumbra/2.0, length(p - holeCenter)), original.a);
}