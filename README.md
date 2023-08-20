# overlay_reflect_shader_vgpu

# descripción 
El objetivo principal de este shader es centralizar una de las funciones importantes de uno de optifine 'reflejos' , agregando este elemento sin cambiar el estilo vanilla, compatible con el launcher de dispositivos moviles

# características
screen space reflection(surface water / under water) 

# uso
optifine, 
render vgpu, 
sistema de configuración en: `shaders\cofing.hpp`

```
float tranparency = 0.6;
float reflect_coeff = 0.7;
float reflect_reso = 0.2;
int reflect_distance = 80;
```
