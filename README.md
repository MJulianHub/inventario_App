# Sistema de Inventario

## Descripción

Aplicación web para gestionar un inventario de productos. Permite crear y organizar productos por categorías, controlar el stock con movimientos de entrada y salida, y mantener un registro de los cambios en tiempo real.

## Funcionalidades

- **Categorías**: Crear, editar y eliminar categorías para organizar los productos. No se puede eliminar una categoría si tiene productos asociados.
- **Productos**: Registro completo con nombre, código único, descripción, precio, stock inicial y categoría. Cada producto puede activarse o desactivarse.
- **Movimientos de Stock**: Registrar entradas (agregar stock), salidas (remover stock) y devoluciones. El sistema valida que no se pueda remover más stock del disponible.
- **Notificaciones**: Mensajes visuales que confirman las acciones realizadas.
- **Validaciones**: Los datos se validan automáticamente para evitar errores como códigos duplicados, precios negativos o stock insuficiente.

## Tecnologías Utilizadas

| Tecnología                 | Uso                                         |
| -------------------------- | ------------------------------------------- |
| Ruby 3.4                   | Lenguaje principal                          |
| Ruby on Rails 8.1          | Framework web                               |
| PostgreSQL                 | Base de datos                               |
| DBeaver                    | Visualización y gestión de la base de datos |
| Hotwire (Turbo + Stimulus) | Navegación sin recargar la página           |
| Importmap                  | Gestión de JavaScript                       |
| RSpec                      | Tests de modelo                             |
| Kamal + Docker             | Despliegue                                  |

## Instalación

1. **Clonar el repositorio**:

```bash
git clone <url-del-repositorio>
cd inventario_app
```

2. **Instalar dependencias**:

```bash
bundle install
```

3. **Configurar la base de datos** (requiere PostgreSQL instalado):

```bash
bin/rails db:create
bin/rails db:migrate
```

4. **Cargar datos iniciales** (opcional):

```bash
bin/rails db:seed
```

## Ejecución del Proyecto

```bash
bin/rails server
```

Abrir el navegador en: `http://localhost:3000`

## Estructura del Sistema

```
app/
├── controllers/    # Lógica de las páginas (CRUD de categorías, productos, stocks)
├── models/         # Reglas de negocio y validaciones
│   ├── category.rb
│   ├── product.rb
│   └── stock.rb
├── views/          # Plantillas HTML de cada página
│   ├── categories/
│   ├── products/
│   └── stocks/
├── javascript/     # JavaScript con Stimulus
└── assets/         # Hojas de estilos CSS

config/
├── locales/        # Traducciones al español
├── routes.rb       # Rutas de la aplicación
└── database.yml    # Configuración de la base de datos

spec/
└── models/         # Tests de los modelos con RSpec
```

## Capturas del Sistema

\*\*

## Tests

El proyecto usa **RSpec** para validar las reglas de negocio de los modelos:

```bash
# Ejecutar todos los tests
bundle exec rspec

# Ejecutar con salida detallada
bundle exec rspec --format documentation
```

**Qué se prueba:**

- **Categorías**: Nombre obligatorio, nombres únicos, no eliminar con productos asociados
- **Productos**: Campos obligatorios, código único, precio no negativo, estado activo por defecto
- **Stock**: Movimientos de entrada/salida/devolución, no remover más del disponible, actualización automática del stock

## Mejoras Implementadas

- Interfaz traducida completamente al español
- Barra de navegación visible en todas las páginas
- Estilos CSS consistentes para botones, tablas y formularios
- Mensajes de error de formulario con lista detallada de problemas
- Validaciones en español (ej: "Nombre ya está en uso" en vez de "Name ya está en uso")
- Corrección de campos duplicados en formularios
- Tests de modelo con RSpec para cubrir las reglas de negocio

## Autor

Proyecto desarrollado por Jose Julian Merlo Perez como parte de una pasantía
