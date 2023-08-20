# overlay_reflect_shader_vgpu

### descripción 
El objetivo principal de este shader es centralizar una de las funciones importantes de uno de optifine 'reflejos' , agregando este elemento sin cambiar el estilo vanilla, compatible con el launcher de dispositivos moviles

### características
screen space reflection(surface water / under water) 

### capturas de pantalla
![](https://github.com/Tuvefef/overlay_reflect_shader_vgpu/blob/main/img1.png)
![](https://github.com/Tuvefef/overlay_reflect_shader_vgpu/blob/main/img2.png)
![](https://github.com/Tuvefef/overlay_reflect_shader_vgpu/blob/main/img3.png)
![](https://github.com/Tuvefef/overlay_reflect_shader_vgpu/blob/main/img8.png)

### uso
Optifine, 

Render vgpu, 

Sistema de configuración en: `shaders\cofing.hpp`


```
float tranparency = 0.6;
float reflect_coeff = 0.7; \\1.0 maximum
float reflect_reso = 0.2;
int reflect_distance = 80;
```
### avisisos(!)
Puede que el shader este mal optimizado y se presenten bajas de fps pero sigue siendo jugable, 

Aun esta en fase de desarrollo, cualquier reporte de bugs o sugerencias contácteme a discord "gab08549" 
