shader_type canvas_item;

uniform sampler2D dissolve_texture;
uniform float dissolve_value : hint_range(0,1);
uniform float burn_size : hint_range(0.0, 1.0, 0.01);
uniform vec4 burn_color;

void fragment() {
    vec4 main_tex = texture(TEXTURE, UV);
    vec4 noise_tex = texture(dissolve_texture, UV);
    
    // Adjust burn_size to avoid a small burn_color dot at dissolve_value 0 or 1
    float burn_size_step = burn_size * step(0.001, dissolve_value) * step(dissolve_value, 0.999);
    float threshold = smoothstep(noise_tex.r - burn_size_step, noise_tex.r, dissolve_value);
    float border = smoothstep(noise_tex.r, noise_tex.r + burn_size_step, dissolve_value);
    
    COLOR.a *= threshold;
    COLOR.rgb = mix(burn_color.rgb, main_tex.rgb, border);
}