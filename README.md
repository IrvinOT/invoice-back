# README

# Invoice Back - Prueba Técnica

Este proyecto es el backend para una prueba técnica. Consiste en una API desarrollada en Ruby on Rails para la gestión y consulta de facturas (invoices). Forma parte de un sistema dividido en dos repositorios:

- **Backend (este repositorio):** Ruby on Rails
- **Frontend:** Angular (repositorio separado)

## Requisitos
- Ruby 3.1.0
- PostgreSQL
- Bundler

## Configuración y ejecución


1. **Instala las dependencias:**
   ```sh
   bundle install
   ```

2. **Configura las variables de entorno:**
   - Copia el archivo `.env.example` a `.env` y edítalo con tus credenciales de base de datos.


3. **Ejecuta el servidor:**
   ```sh
   rails server
   ```
   El backend estará disponible en `http://localhost:3000`.

## Notas
- El frontend en Angular debe consumir los endpoints de este backend.
---
