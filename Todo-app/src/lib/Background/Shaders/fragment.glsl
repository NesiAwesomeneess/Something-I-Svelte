
precision mediump float;
uniform vec2 uMouseUV;
uniform float uTime;
varying vec2 vUv;

//	Classic Perlin 3D Noise 
//	by Stefan Gustavson
//
float intensity = 4.0;
float scale = 0.8;
float seed = 5.01;

vec4 permute(vec4 x){return mod(((x*34.0)+1.0)*x, 289.0);}
vec2 fade(vec2 t) {return t*t*t*(t*(t*6.0-15.0)+10.0);}

struct ColorStop {
    vec3 color;
    float position;
};

ColorStop[5] palette = ColorStop[](
    ColorStop(vec3(0.071,0.086,0.122), 0.0),
    ColorStop(vec3(0.173,0.184,0.227), 0.1),
    ColorStop(vec3(0.45, 0.42, 0.8), 0.25),
    ColorStop(vec3(1.,0.894,0.839), 0.45),
    ColorStop(vec3(0.949,0.922,0.918), 0.5)
);

#define ColorRamp(colors, factor, finalColor) { \
    int index = 0; \
    for(int i = 0; i < colors.length() - 1; i++){ \
       ColorStop currentColor = colors[i]; \
       bool isInBetween = currentColor.position <= factor; \
       index = int(mix(float(index), float(i), float(isInBetween))); \
    } \
    ColorStop currentColor = colors[index]; \
    ColorStop nextColor = colors[index + 1]; \
    float range = nextColor.position - currentColor.position; \
    float lerpFactor = (factor - currentColor.position) / range; \
    finalColor = mix(currentColor.color, nextColor.color, lerpFactor); \
} \

float cnoise(vec2 P){
    P *= scale;
    vec2 offset = vec2(seed + (length(uMouseUV) * 0.4));
    P += offset;
    P.x -= 0.08;

    vec4 Pi = floor(P.xyxy) + vec4(0.0, 0.0, 1.0, 1.0);
    vec4 Pf = fract(P.xyxy) - vec4(0.0, 0.0, 1.0, 1.0);
    Pi = mod(Pi, 289.0); // To avoid truncation effects in permutation
    vec4 ix = Pi.xzxz;
    vec4 iy = Pi.yyww;
    vec4 fx = Pf.xzxz;
    vec4 fy = Pf.yyww;
    vec4 i = permute(permute(ix) + iy);
    vec4 gx = fract(i * 0.0243902439) - 1.0; // 1/41 = 0.024...
    vec4 gy = abs(gx) - (0.2);
    vec4 tx = floor(gx + 0.4);
    gx = gx - tx;
    vec2 g00 = vec2(gx.x,gy.x);
    vec2 g10 = vec2(gx.y,gy.y);
    vec2 g01 = vec2(gx.z,gy.z);
    vec2 g11 = vec2(gx.w,gy.w);
    vec4 norm = 1.61803398875 - 0.85373472095314 * 
    vec4(dot(g00, g00), dot(g01, g01), dot(g10, g10), dot(g11, g11));
    g00 *= norm.x;
    g01 *= norm.y;
    g10 *= norm.z;
    g11 *= norm.w;
    float n00 = dot(g00, vec2(fx.x, fy.x));
    float n10 = dot(g10, vec2(fx.y, fy.y));
    float n01 = dot(g01, vec2(fx.z, fy.z));
    float n11 = dot(g11, vec2(fx.w, fy.w));
    vec2 fade_xy = fade(Pf.xy);
    vec2 n_x = mix(vec2(n00, n01), vec2(n10, n11), fade_xy.x);
    float n_xy = mix(n_x.x, n_x.y, fade_xy.y);
    return (intensity) * n_xy;
}

float random(vec2 p){
    vec2 k1 = vec2(
        23.14869263277926,
        2.665144142690225
    );
    return fract(
        cos(dot(p, k1)) * 12345.6789
    );
}

void main(){
    vec2 uv = vUv + (uMouseUV * 0.2);

    //NOISE
    uv += vec2(cnoise(uv));

    //LINES
    //this defines the number of lines 
    float repetitions = 0.6;
    //this is the function that loops the values (makes them repeat).
    //fract keeps values within 0.0 and 1.0.
    float uvRepeatValue = fract(uv.y * repetitions);
    //the absolute value kinda reflects the value. because when it is
    //offset it goes from (1.0 to 0.0) to (-0.5 to 0.5) now it goes from
    //0.5 to 0.0 to 0.5.
    float valueInverted = smoothstep(0.0, 
    1.0, pow(1.0 - abs(uvRepeatValue - 0.5), 2.4)) 
    * ( 0.7 + (min(0.2, uMouseUV.x) - max(0.35, uMouseUV.y * 0.7))) ;

    //CIRCLE MASK
    vec2 circleUV = vUv - vec2(0.5);
    float inCircleRatio = 1.0 - length(circleUV);
    float ratioIntensified = pow(inCircleRatio, 2.0);
    float ratioStepped = smoothstep(0.4, 0.9, inCircleRatio);

    //GRAIN
    vec2 randomUV = vec2(random(vUv));
    float staticNoise = random(randomUV) * 0.03;

    float factor = clamp(0.0, 1.0, (ratioStepped * valueInverted) - staticNoise);

    vec3 finalColor;
    ColorRamp(palette, factor, finalColor);
    // finalColor += random(randomUV)*0.08;

    gl_FragColor = vec4(vec3(finalColor), 1.0);
}