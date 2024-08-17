shader_type spatial;
render_mode blend_mix;
uniform vec3 COLOUR : source_color;
uniform sampler2D BEHIND_TEXTURE : hint_screen_texture;
uniform sampler2D DEPTH_TEXTURE : hint_depth_texture, repeat_disable, filter_nearest;
global uniform float time_elapsed;

void vertex() {
	// Called for every vertex the material is visible on.
	VERTEX = VERTEX + vec3(
		0.0, 
		sin(time_elapsed*1.0 - (MODELVIEW_MATRIX * vec4(VERTEX, 1)).x * 5.0) * 0.02 + sin(time_elapsed*2.5 - (MODELVIEW_MATRIX * vec4(VERTEX, 1)).z * 5.0) * 0.02, 
		0.0
	);
}

vec3 AdjustContrastCurve(vec3 color, float contrast) {
    return pow(abs(color * vec3(2.0 - 1.0)), vec3(1.0 / max(contrast, 0.0001))) * sign(color - vec3(0.5)) + vec3(0.5);
}

void fragment() {
	vec3 newColour = textureLod(BEHIND_TEXTURE, SCREEN_UV, 1.0).rgb;
	newColour = vec3((newColour.r + newColour.g + newColour.b) / 3.5);
	ALBEDO = newColour * COLOUR;
	SPECULAR = 0.3;
	ROUGHNESS = 0.0;
	//ALPHA = (VIEW_MATRIX * vec4(VERTEX, 1.0)).x * 10.0;
	//ALPHA = 1.0 - ((sin(TIME*0.5 - vec4(VERTEX, 1.0)).z * 0.4 + sin(TIME*1.5 - vec4(VERTEX, 1.0)).z * 0.15)) ;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
