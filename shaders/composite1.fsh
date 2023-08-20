#version 120

#define reflect_sky_coeff
#include "cofing.hpp"

uniform float near;
uniform float far;
uniform sampler2D colortex3;
uniform sampler2D depthtex0;
uniform sampler2D colortex0;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferProjection;
uniform mat4 gbufferProjectionInverse;
uniform vec3 cameraPosition;
uniform vec3 sunPosition;
uniform vec3 moonPosition;
uniform int worldTime;

#define time worldTime

varying float isNight;
varying vec3 mySkyColor;
varying vec3 mySunColor;
varying vec4 texcoord;

vec2 space_reflect_coord(vec3 coord){
  vec4 mesh = vec4(coord, 1.0);
  mesh = gbufferProjection * mesh;
  mesh /= mesh.w;
  mesh = mesh * 0.5f + 0.5f;
  return mesh.st;
}

float line_depht(float coeff) {
  return (2.0 * near) / (far + near - coeff * (far - near));
}

float line_depht_coord(vec3 viewCoord) {
  vec4 p = vec4(viewCoord, 1.0);
  p = gbufferProjection * p;
  p /= p.w;
  return line_depht(p.z * 0.5 + 0.5);
}

vec3 sky_reflect(vec3 coord) {
  float sun_mat = clamp(1.0 - 1.0, 0, 1) * (1.0-isNight);
  vec3 final = mix(mySkyColor, mySunColor, pow(sun_mat, 10));

  float moon_mat = clamp(1.0 - 1.0, 0, 1) * isNight;
  final = mix(final, mySunColor, pow(moon_mat, 10));

  return final;
}

vec3 waterRayTarcing(vec3 startPoint, vec3 coords, vec3 color) {
  vec3 direcRegul = coords;
  const float base_ = reflect_reso;
  vec3 testPoint = startPoint;
  coords *= base_ * 0.8;
  vec3 intersect = vec3(0.0);
  int step = reflect_distance;
  for(int i = 0; i < step; i++){
    testPoint += coords * (1 + float(i) * 0.08);
    vec2 uv = space_reflect_coord(testPoint);
    
    if(uv.x<0 || uv.x>1 || uv.y<0 || uv.y>1){
      #ifdef reflect_sky_coeff
        break;
      #else
        return vec3(0);
      #endif
        }
    float sampleDepth = texture2DLod(depthtex0, uv, 0.0).x;
    sampleDepth = line_depht(sampleDepth);
    float testDepth = line_depht_coord(testPoint);
    
    if((sampleDepth < testDepth && testDepth - sampleDepth < (1.0 + testDepth * 200.0 + float(i))/2048.0 ) || i == step-1 ){
      intersect = texture2DLod(colortex0, uv, 0.0).rgb;
      return intersect.rgb;
    }
  }
  
  intersect = sky_reflect(direcRegul);
  return intersect.rgb;
}

vec3 env(vec3 color, vec2 uv, vec3 viewPos, vec4 positionInWorldCoord, vec4 water) {
  float intersect_ = water.w;
  if(intersect_ >= 0.5){
    vec3 normal = water.xyz * 2 - 1;
    positionInWorldCoord.xyz += cameraPosition;
    vec3 viewPos_ = normalize(viewPos.xyz);
    float angle = abs(dot(viewPos_, normal));
    vec3 viewRefRay = reflect(viewPos_, normal);
    vec3 reflectColor = waterRayTarcing(viewPos, viewRefRay, color);
    reflectColor = mix(reflectColor, color, angle);
    color = mix(color, reflectColor, reflect_coeff);
    
  }
  return color;
}

void main(){
  
  vec3 final = texture2D(colortex0, texcoord.st).rgb;
  vec4 intersect = texture2D(colortex3, texcoord.st);
  
  float eval = texture2D(depthtex0, texcoord.st).x;
  vec4 mtn = vec4(texcoord.st*2-1, eval*2-1, 1);
  vec4 positionInClipCoord0 = gbufferProjectionInverse * mtn;
  vec4 coord0 = vec4(positionInClipCoord0.xyz/positionInClipCoord0.w, 1.0);
  vec4 coord_mat = gbufferModelViewInverse * coord0;

  final = env(final, texcoord.st, coord0.xyz, coord_mat, intersect);
	
    gl_FragData[0] = vec4(final, 1.0);
}