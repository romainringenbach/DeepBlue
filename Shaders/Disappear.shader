shader_type spatial;
render_mode blend_mix,depth_draw_alpha_prepass,cull_back,diffuse_burley,specular_schlick_ggx;

uniform float specular;
uniform float metallic;
uniform float roughness : hint_range(0,1);

uniform vec4 emission_color : hint_color;
uniform float emission_strength : hint_range(0,10);

uniform sampler2D albedo_map : hint_albedo;

uniform sampler2D metallic_map : hint_white;
uniform vec4 metallic_texture_channel;

uniform sampler2D roughness_map : hint_white;
uniform vec4 roughness_texture_channel;

uniform sampler2D normal_map : hint_normal;

uniform sampler2D noise_map : hint_albedo;
uniform float noise_threshold : hint_range(0,1);

void fragment()
{
	vec4 albedo_tex = texture(albedo_map,UV);
	vec3 noise_tex = texture(noise_map, UV).rgb;
	
	ALPHA *= floor(noise_threshold + min(0.99, noise_tex.r));
	
	ALBEDO = albedo_tex.rgb;
	
	EMISSION = emission_color.rgb * emission_strength;
	NORMALMAP = texture(normal_map,UV).rgb;
	float metallic_tex = dot(texture(metallic_map,UV),metallic_texture_channel);
	METALLIC = metallic_tex * metallic;
	float roughness_tex = dot(texture(roughness_map,UV),roughness_texture_channel);
	ROUGHNESS = roughness_tex * roughness;
	SPECULAR = specular;
	
}