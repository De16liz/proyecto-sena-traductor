-- creacion de base de datos-.
DROP TABLE IF EXISTS tb_idiomas;
CREATE TABLE tb_idiomas
(
    id TINYINT PRIMARY KEY,
    idioma NVARCHAR(15) NOT NULL 
);
INSERT tb_idiomas VALUES('1', 'ESPAÑOL'),('2','TUCANO'); -- Insertar datos por defecto

DROP TABLE IF EXISTS tb_diccionario;
CREATE TABLE tb_diccionario
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	palabra VARCHAR(60) NOT NULL,
	palabra_idioma TINYINT NOT NULL, -- Llave foranea
	traduccion VARCHAR(60) NOT NULL, 
	traduccion_idioma TINYINT NOT NULL, -- lLave foranra
	significado VARCHAR(300) NOT NULL
);

DROP TABLE IF EXISTS tb_vocabularios;
CREATE TABLE tb_vocabularios
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    frase NVARCHAR(200) NOT NULL,  
    frase_idioma TINYINT NOT NULL, -- llave foranea.
    traduccion  NVARCHAR(200) NOT NULL,
    traduccion_idioma TINYINT NOT NULL, -- llave foranea.
	significado VARCHAR(300) NOT NULL
);

-- FUNCIONES

-- Funcion de insertar palabras.
DROP FUNCTION IF EXISTS fun_agregar_palabra;
DELIMITER //
CREATE FUNCTION fun_agregar_palabra(p_palabra VARCHAR(60), p_palabra_idioma TINYINT, p_traduccion VARCHAR(60), p_traduccion_idioma TINYINT, p_significado VARCHAR(300))
RETURNS BIT
BEGIN 
	DECLARE v BIT;
	SET v = IF((SELECT COUNT(*) FROM tb_diccionario t1 WHERE t1.palabra = p_palabra AND t1.palabra_idioma = p_palabra_idioma) = 0, 1, 0);
	IF (v = 1) then
		INSERT INTO tb_diccionario(palabra, palabra_idioma, traduccion, traduccion_idioma, significado)
		VALUES(UPPER(p_palabra), p_palabra_idioma, UPPER(p_traduccion), p_traduccion_idioma, p_significado); 
		RETURN 1;
	ELSE
		RETURN 0;
	END IF;
END //
DELIMITER ;

-- Agregar vocabulario.
DROP FUNCTION IF EXISTS fun_agregar_vocabulario;
DELIMITER //
CREATE FUNCTION fun_agregar_vocabulario(p_frase VARCHAR(200), p_frase_idioma TINYINT, p_traduccion VARCHAR(200), p_traduccion_idioma TINYINT, p_significado VARCHAR(300))
RETURNS BIT
BEGIN
	DECLARE v1 BIT;
	
	SET v1 = IF ((SELECT COUNT(*) FROM tb_vocabularios t1  WHERE t1.frase = p_frase AND t1.frase_idioma = p_frase_idioma) = 0,1,0);
	
	IF (v1 = 1) THEN
		INSERT INTO tb_vocabularios(frase, frase_idioma, traduccion, traduccion_idioma, significado)
		VALUES(UPPER(p_frase), p_frase_idioma, UPPER(p_traduccion), p_traduccion_idioma, p_significado);
		RETURN 1;
	ELSE 
		RETURN 0;
	END IF;
END //
DELIMITER ;

-- VISTAS

-- vista diccionario
CREATE VIEW vista_diccionario    
AS 
SELECT COUNT( * ) AS conteo, t1.palabra, t1.traduccion
from tb_diccionario t1
WHERE t1.id 

GROUP BY t1.palabra, t1.traduccion ;

-- vista vocabulario
CREATE VIEW vista_vocabulario    
AS 
SELECT COUNT( * ) AS conteo, t1.frase, t1.traduccion, t1.significado
from tb_vocabularios t1
WHERE t1.id 
GROUP BY t1.frase, t1.traduccion,t1.significado ;





