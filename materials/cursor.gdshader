shader_type spatial;
render_mode blend_add, world_vertex_coords, cull_disabled, unshaded;
uniform vec3 COLOUR : source_color;

varying vec3 pos;
void vertex() { 
    pos = mat3(MODEL_MATRIX) * -VERTEX;
}

void fragment() {	
	ALPHA = smoothstep(pos.y, -0.8, -0.5);
    if (pos.y <= -0.5) {
        ALPHA = 0.0;
    }
	ALPHA = ALPHA * 0.6;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
