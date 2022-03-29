--1 Crear una base de datos llamada películas. 
CREATE DATABASE peliculas;

CREATE TABLE peliculas(
    id INT NOT NULL,
    pelicula VARCHAR (80),
    año_estreno SMALLINT,
    director VARCHAR (25),
    PRIMARY KEY (id)
);

CREATE TABLE reparto(
    pelicula_id INT NOT NULL,
    nombre_actores VARCHAR(25),
    FOREIGN KEY (pelicula_id) REFERENCES peliculas(id),
);

--2 Cargar ambos archivos a su tabla correspondiente.
\ copy peliculas
FROM
    'peliculas.csv' csv header;

\ copy reparto
FROM
    'reparto.csv' csv;

--3 Obtener el ID de la película “Titanic”. 
SELECT
    id
FROM
    peliculas
WHERE
    pelicula = 'Titanic';

--4 Listar a todos los actores que aparecen en la película "Titanic". 
SELECT
    p.pelicula,
    r.nombre_actores
FROM
    reparto AS r
    LEFT JOIN peliculas AS p ON p.id = r.id_pelicula
WHERE
    pelicula = 'Titanic';

--5 Consultar en cuántas películas del top 100 participa Harrison Ford. 
SELECT
    COUNT (id_pelicula)
FROM
    reparto
WHERE
    nombre_actores = 'Harrison Ford';

--6 Indicar las películas estrenadas entre los años 1990 y 1999 ordenadas por título de manera ascendente. 
SELECT
    *
FROM
    peliculas
WHERE
    año_estreno BETWEEN '1990'
    AND '1999'
ORDER BY
    pelicula ASC;

--7 Hacer una consulta SQL que muestre los títulos con su longitud, la longitud debe ser nombrado para la consulta como “longitud_titulo”.
SELECT
    pelicula,
    LENGHT(pelicula) AS longitud_titulo
FROM
    peliculas;

--8 Consultar cual es la longitud más grande entre todos los títulos de las películas
SELECT
    pelicula,
    LENGHT(pelicula) AS longitud_mas_grande
FROM
    peliculas
ORDER BY
    2 DESC
LIMIT
    1;