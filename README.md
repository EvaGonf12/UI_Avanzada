# Concurrencia-Red

- Añadido diseño de las 2 pantallas de temas y usuarios. 
- Creado un bg específico para el menú donde se añaden las notificaciones. Con 2 tamaños establecidos pequeño y grande. Quedaría por hacer que el bg no sea una imagen sino una custom UIView que modifique su altura en función del contenido. 
- Creada UIView custom vía código donde se crea la notificación con la acción del botón decidida por la pantalla que la implementa. 
- El botón dentro de la notificación "simula" de algún modo la desaparición de la misma. Aquí habría que modificar la lógica, tanto por la acción a realizar al pulsar el botón como para que la desaparición de la notificación se aplique a todas las pantallas de la app (así como su aparición). La tabla se desliza hacia arriba para reubicarse al pulsar el botón.
- Añadido el diseño del searchbar pero sin funcionalidad.
- Creado un bg para el tabbar con CALayer para poner insertar el botón de añadir topic en el medio. Habría de modificarse el tabbar para usuarios, puesto que este botón en usuarios carece de funcionalidad.
- Modificadas las vistas de detalle del topic y añadir topic para que concordasen con el resto del diseño. 
- Añadidas sombras a las imágenes (en ambos listados), y al bg del tabbar para no añadirle un borde y que se diferencie del resto del contenido. 
- Aparición mediante animación de las imágenes en ambas tablas.
- Añadido el refreshController en ambas pantallas.
