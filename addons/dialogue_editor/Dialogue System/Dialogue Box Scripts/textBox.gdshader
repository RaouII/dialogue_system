shader_type canvas_item;

uniform vec4 target_color : source_color;
uniform vec4 replace_color : source_color;

uniform float tolerance : hint_range(0,1);

void fragment(){
	vec4 tex_color = texture(TEXTURE,UV);

	float dist = distance(tex_color.rgba, target_color.rgba);

	if (dist < tolerance){
		tex_color.rgba = replace_color.rgba;
	}

	COLOR = tex_color;
}