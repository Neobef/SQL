CREATE DATABASE Posts;

CREATE TABLE post(
id VARCHAR(25) NOT NULL,
nombre_de_usuario VARCHAR(25) NOT NULL,
fecha_de_creacion DATE NOT NULL,
contenido VARCHAR(25),
descripcion VARCHAR(50),
PRIMARY KEY (id)
);

CREATE USER pamela WITH PASSWORD 'pamela'
CREATE USER carlos WITH PASSWORD 'carlos'

INSERT INTO post (id, nombre_de_usuario, fecha_de_creacion, contenido, descripcion) 
VALUES ('001','pamela','2021/03/28','contenido 1', 'descripcion de contenido 1');
INSERT INTO post (id, nombre_de_usuario, fecha_de_creacion, contenido, descripcion) 
VALUES ('002','pamela','2021/03/28','contenido 2', 'descripcion de contenido 2');
INSERT INTO post (id, nombre_de_usuario, fecha_de_creacion, contenido, descripcion) 
VALUES ('003','carlos','2021/03/28','contenido 3', 'descripcion de contenido 3');

ALTER TABLE post 
ADD titulo VARCHAR(25);

UPDATE post 
SET titulo = 'titulo1' 
WHERE id = '001';
UPDATE post 
SET titulo = 'titulo2' 
WHERE id = '002';
UPDATE post 
SET titulo = 'titulo3' 
WHERE id = '003';


INSERT INTO post (id, nombre_de_usuario, fecha_de_creacion, contenido, descripcion, titulo) 
VALUES ('004','pedro','2021/03/28','contenido 4', 'descripcion de contenido 4', 'titulo4');
INSERT INTO post (id, nombre_de_usuario, fecha_de_creacion, contenido, descripcion, titulo) 
VALUES ('005','pedro','2021/03/28','contenido 5', 'descripcion de contenido 5', 'titulo5');

DELETE FROM post 
WHERE nombre_de_usuario = 'carlos';

INSERT INTO post (id, nombre_de_usuario, fecha_de_creacion, contenido, descripcion, titulo) 
VALUES ('006','carlos','2021/03/28','contenido 6', 'descripcion de contenido 6', 'titulo6');

CREATE TABLE comentarios(
id VARCHAR(25) NOT NULL,
post_id VARCHAR(25) NOT NULL,
fecha DATE NOT NULL,
hora_de_creacion VARCHAR(25),
contenido VARCHAR(50),
PRIMARY KEY (id),
FOREIGN KEY (post_id) REFERENCES
post(id)
);

INSERT INTO comentarios (id, post_id, fecha, hora_de_creacion, contenido)
VALUES ('0001', '001', '2021/03/28', '15:00');
INSERT INTO comentarios (id, post_id, fecha, hora_de_creacion, contenido)
VALUES ('0002', '001', '2021/03/28', '15:10');
INSERT INTO comentarios (id, post_id, fecha, hora_de_creacion, contenido)
VALUES ('0003', '006', '2021/03/28', '15:12');
INSERT INTO comentarios (id, post_id, fecha, hora_de_creacion, contenido)
VALUES ('0004', '006', '2021/03/28', '15:15');
INSERT INTO comentarios (id, post_id, fecha, hora_de_creacion, contenido)
VALUES ('0005', '006', '2021/03/28', '15:18');
INSERT INTO comentarios (id, post_id, fecha, hora_de_creacion, contenido)
VALUES ('0006', '006', '2021/03/28', '15:24');

INSERT INTO post (id, nombre_de_usuario, fecha_de_creacion, contenido, descripcion, titulo) 
VALUES ('007','margarita','2021/03/28','contenido 7', 'descripcion de contenido 7', 'titulo7');

INSERT INTO comentarios (id, post_id, fecha, hora_de_creacion, contenido)
VALUES ('0007', '007', '2021/03/28', '15:54');
INSERT INTO comentarios (id, post_id, fecha, hora_de_creacion, contenido)
VALUES ('0008', '007', '2021/03/28', '15:54');
INSERT INTO comentarios (id, post_id, fecha, hora_de_creacion, contenido)
VALUES ('0009', '007', '2021/03/28', '15:55');
INSERT INTO comentarios (id, post_id, fecha, hora_de_creacion, contenido)
VALUES ('0010', '007', '2021/03/28', '15:56');
INSERT INTO comentarios (id, post_id, fecha, hora_de_creacion, contenido)
VALUES ('0011', '007', '2021/03/28', '15:58');

