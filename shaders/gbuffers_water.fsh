#version 120

uniform sampler2D texture;
uniform sampler2D lightmap;

uniform int worldTime;
varying float id;
varying vec3 normal;
varying vec4 texcoord;
varying vec4 color;
varying vec4 lightMapCoord;

#include "cofing.hpp"
#define time worldTime

void main(){
  
  vec4 elem_light = texture2D(lightmap, lightMapCoord.st);
  vec3 marmlf1 = normalize(normal);
  marmlf1 = marmlf1 * 0.5 + 0.5;
  
  if(id != 10091){
    gl_FragData[0] = color * texture2D(texture, texcoord.st) * elem_light;
    gl_FragData[3] = vec4(marmlf1, 1.0);
  }else{
    gl_FragData[0] = vec4(vec3(1), tranparency) * (color * texture2D(texture, texcoord.st)) * elem_light;
    gl_FragData[3] = vec4(marmlf1, 1.0);
  }
}