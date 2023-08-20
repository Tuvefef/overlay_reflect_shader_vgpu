#version 120

uniform int worldTime;
uniform float rainStrength;

varying float isNight;
varying vec3 mySkyColor;
varying vec3 mySunColor;
varying vec4 texcoord;

#define time worldTime

vec3 sunColorArr[24] = vec3[24](
  vec3(2, 2, 1), vec3(2, 1.5, 1), vec3(1, 1, 1), vec3(1, 1, 1), vec3(1, 1, 1), vec3(1, 1, 1), vec3(1, 1, 1), vec3(1, 1, 1), vec3(1, 1, 1), vec3(1, 1, 1), vec3(1, 1, 1), vec3(1, 1, 1), vec3(2, 1.5, 0.5), vec3(0.3, 0.5, 0.9), vec3(0.3, 0.5, 0.9), vec3(0.3, 0.5, 0.9), vec3(0.3, 0.5, 0.9), vec3(0.3, 0.5, 0.9), vec3(0.3, 0.5, 0.9), vec3(0.3, 0.5, 0.9), vec3(0.3, 0.5, 0.9), vec3(0.3, 0.5, 0.9), vec3(0.3, 0.5, 0.9), vec3(0.3, 0.5, 0.9)
);

vec3 skyColorArr[24] = vec3[24](
  vec3(0.6, 0.7, 0.87), vec3(0.6, 0.7, 0.87), vec3(0.6, 0.7, 0.87), vec3(0.6, 0.7, 0.87), vec3(0.6, 0.7, 0.87), vec3(0.6, 0.7, 0.87), vec3(0.6, 0.7, 0.87), vec3(0.6, 0.7, 0.87), vec3(0.6, 0.7, 0.87), vec3(0.6, 0.7, 0.87), vec3(0.6, 0.7, 0.87), vec3(0.6, 0.7, 0.87), vec3(0.6, 0.7, 0.87), vec3(0.02, 0.02, 0.027), vec3(0.02, 0.02, 0.027), vec3(0.02, 0.02, 0.027), vec3(0.02, 0.02, 0.027), vec3(0.02, 0.02, 0.027), vec3(0.02, 0.02, 0.027), vec3(0.02, 0.02, 0.027), vec3(0.02, 0.02, 0.027), vec3(0.02, 0.02, 0.027), vec3(0.02, 0.02, 0.027), vec3(0.02, 0.02, 0.027)
);

void main(){
  
  int delt_time = time / 1000;
  int delt_coe = (delt_time +1 < 24) ? (delt_time +1) : (0);
  float delt_cord = float(time - delt_time * 1000) / 1000;
  
  mySkyColor = mix(skyColorArr[delt_time], skyColorArr[delt_coe], delt_cord);
  mySunColor = mix(sunColorArr[delt_time], sunColorArr[delt_coe], delt_cord);
  
  isNight = 0;
  if(12000 < time && time < 13000){
    isNight = 1.0 - (13000 - time) / 1000.0;
  }else if(13000 <= time && time <= 23000){
    isNight = 1.0;
  }else if(23000 < time){
    isNight = (24000 - time) / 1000.0;
  }
  
  gl_Position = ftransform();
  texcoord = gl_TextureMatrix[0] * gl_MultiTexCoord0;
}