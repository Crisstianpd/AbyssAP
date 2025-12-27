# AbyssAP | Rogue Access Point
![Demo de AbyssAP](assets/preview.gif)
Herramienta para el despliegue automatizado de un *rogue access point*, integrada con un portal cautivo para la recopilación de información con fines educativos o demostrativos en entornos de pruebas de seguridad.


## ⚠️ Descargo de responsabilidad
Este proyecto ha sido desarrollado exclusivamente con fines educativos y demostrativos, orientado a la concienciación en seguridad inalámbrica y pruebas controladas.

No me hago responsable del uso indebido de esta herramienta ni de cualquier daño o impacto causado por su ejecución fuera de entornos autorizados.
El uso de AbyssAP debe limitarse estrictamente a laboratorios, redes propias o entornos donde se cuente con autorización explícita.

El usuario es el único responsable de cumplir con la legislación y normativas vigentes en su país.

## Características del proyecto
- Despliegue automatizado de un Rogue Access Point
- Configuración dinámica de SSID, interfaz y canal
- Integración de portal cautivo con capacidad de selección de plantilla
- Registro de dispositivos conectados
- Recolección de información del usuario y del dispositivo conectado
- Almacenamiento de información de forma local
- Interfaz en consola clara e interactiva

## Funcionamiento
AbyssAP sigue un flujo de ejecución estructurado en etapas:
1. Verificación de dependencias y entorno
2. Selección de la interfaz inalámbrica
3. Configuración del punto de acceso falso (nombre y canal del punto de acceso)
4. Selección de plantilla para el portal cautivo
5. Inicialización de servicios de red
6. Despliegue del portal cautivo
7. Monitoreo de dispositivos conectados y recopilación de información
8. Almacenamiento de la información recopilada
9. Restauración del sistema al finalizar la ejecución

El proceso está diseñado para ser transparente, controlado y reversible, minimizando impactos persistentes en el sistema anfitrión.

## Tecnologías y requisitos
AbyssAP está desarrollado principalmente en `bash`, utilizando herramientas nativas de red en entornos Linux para la gestión del acceso inalámbrico.

Los portales cautivos se encuentran implementados en `PHP`, encargándose de la interacción con el usuario y del manejo de los datos generados durante la conexión.


### Requisitos
- OS: Linux
- Acceso root
- Adaptador inalámbrico compatible con modo AP / monitor
- NetworkManager instalado

### Dependencias:
- `hostapd`
- `dnsmasq`
- `php`
- `iw`
- `jq`

## Instalación y uso
Clona el repositorio y accede al directorio del proyecto:
```bash 
git clone https://github.com/crisstianpd/abyssap.git
cd AbyssAP
```
Ejecuta la herramienta con privilegios de superusuario:
```bash
sudo bash abyssap.sh
```

Después de ejecutar, el script guiará al usuario mediante una interfaz interactiva para completar la configuración del RogueAP a desplegar.

## Estructura del proyecto
```bash
AbyssAP/
├── abyssap.sh
├── templates/
│   ├── test/
│   └── ...
│   ├── free-ap/
│   └── ...
├── data/
│   └── ...
├── assets/
│   └── preview.gif
├── LICENSE
└── README.md
```

## Contribuciones
Las contribuciones son bienvenidas.

Si deseas mejorar el proyecto, reportar errores o proponer nuevas funcionalidades, puedes hacerlo mediante issues o pull requests.

## Licencia
Este proyecto se distribuye bajo la licencia GNU General Public License v3.0.

Consulta el archivo [LICENSE](LICENSE) para más información sobre los términos de uso, modificación y distribución.

## Autor y contacto
Cristian Alexander *(Crisstianpd)*

Autor y desarrollador de *AbyssAP*

Web: https://crisstianpd.vercel.app/

