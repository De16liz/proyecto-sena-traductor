-- creacion de base de datos-.

DROP TABLE IF EXISTS tb_palabras;
CREATE TABLE tb_palabras
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    palabra NVARCHAR(50) NOT NULL,
    idioma TINYINT NOT NULL -- llave foranea.
);

DROP TABLE IF EXISTS tb_idiomas;
CREATE TABLE tb_idiomas
(
    id TINYINT PRIMARY KEY AUTO_INCREMENT,
    idioma NVARCHAR(15) NOT NULL 
);

DROP TABLE IF EXISTS tb_traducciones;
CREATE TABLE tb_traduccion
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_palabra INT NOT NULL,  -- llave foranea.
    id_palabra_traduccion INT NOT NULL -- llave foranea.
);

DROP TABLE IF EXISTS tb_vocabularios;
CREATE TABLE tb_vocabularios
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    frase NVARCHAR(200) NOT NULL,  
    frase_idioma TINYINT NOT NULL, -- llave foranea.
    traduccion  NVARCHAR(200) NOT NULL,
    traduccion_idioma TINYINT NOT NULL -- llave foranea.
);

-- FUNCIONES

DROP FUNCTION IF EXISTS fun_agregar_palabra;
delimiter //
CREATE FUNCTION fun_agregar_palabra( v_palabra NVARCHAR(50), v_idioma TINYINT)
RETURNS bit
BEGIN
	DECLARE validacion_existencia INT;
	SET validacion_existencia = (SELECT  COUNT(*) FROM tb_palabras WHERE palabra = v_palabra AND idioma = v_idioma);
	if (validacion_existencia = 0) then 
		INSERT INTO tb_palabras (palabra, idioma) VALUES (v_palabra, v_idioma);  
		RETURN 1;
		
	ELSE 
		RETURN 0;
	END if ; 
	 
END //
delimiter ;

-- Función de insertar traducciones.

DROP FUNCTION IF EXISTS fun_agregar_traduccion;
delimiter //
CREATE FUNCTION fun_agregar_traduccion( v_id_palabra INT, v_id_palabra_traduccion INT)
RETURNS bit
BEGIN
	
	DECLARE validacion_1 INT;
	DECLARE validacion_2 INT;
	DECLARE validacion_3 INT;
	
	SET validacion_1 = (SELECT COUNT(*) FROM tb_palabras WHERE id = v_id_palabra);
	SET validacion_2 = (SELECT COUNT(*) FROM tb_palabras WHERE id = v_id_palabra_traduccion);
	SET validacion_3 = (SELECT COUNT(*) FROM tb_traducciones WHERE id_palabra = v_id_palabra AND id_palabra_traduccion = v_id_palabra_traduccion );
	
	
	if (validacion_1 = 1 AND validacion_2 = 1 AND validacion_3 = 0) then
		INSERT INTO tb_traducciones(id_palabra, id_palabra_traduccion) VALUES(v_id_palabra, v_id_palabra_traduccion); 
		RETURN 1;
	else
		RETURN 0;
	END if;
END //
delimiter ;




