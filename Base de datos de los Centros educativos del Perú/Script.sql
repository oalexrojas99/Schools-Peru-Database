USE G3_rojas_oscaralexander;

/*Ubigeo: Departamento, provincia y distrito*/
DROP TABLE IF EXISTS MINEDU_Departamento;
CREATE TABLE MINEDU_Departamento(
	id_departamento INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(64)
);

DROP TABLE IF EXISTS MINEDU_Provincia;
CREATE TABLE MINEDU_Provincia(
	id_provincia INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(64),
    id_departamento INT
);

ALTER TABLE MINEDU_Provincia
	ADD CONSTRAINT fk_MINEDU_Provincia_MINEDU_Departamento FOREIGN KEY (id_departamento) REFERENCES MINEDU_Departamento(id_departamento) ON DELETE CASCADE;

DROP TABLE IF EXISTS MINEDU_Distrito;
CREATE TABLE MINEDU_Distrito(
	id_distrito INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(64),
    id_provincia INT
);

ALTER TABLE MINEDU_Distrito
	ADD CONSTRAINT fk_MINEDU_Distrito_MINEDU_Provincia FOREIGN KEY (id_provincia) REFERENCES MINEDU_Provincia (id_provincia) ON DELETE CASCADE;

DROP TABLE IF EXISTS MINEDU_Ubigeo;
CREATE TABLE MINEDU_Ubigeo(
	id_ubigeo VARCHAR(8) PRIMARY KEY,
    id_distrito INT
);

ALTER TABLE MINEDU_Ubigeo
	ADD CONSTRAINT fk_MINEDU_Ubigeo_MINEDU_Distrito FOREIGN KEY (id_distrito) REFERENCES MINEDU_Distrito (id_distrito) ON DELETE CASCADE;

/*Turno, Característica de modalidad y Modularidad, Modalidad*/
DROP TABLE IF EXISTS MINEDU_Modularidad;
CREATE TABLE MINEDU_Modularidad(
	id_modularidad VARCHAR(16) PRIMARY KEY,
    anexo VARCHAR(32)
);

DROP TABLE IF EXISTS MINEDU_Turno;
CREATE TABLE MINEDU_Turno(
	id_turno VARCHAR(16) PRIMARY KEY,
    descripcion VARCHAR(32)
);

DROP TABLE IF EXISTS MINEDU_Caracteristica_Modalidad;
CREATE TABLE MINEDU_Caracteristica_Modalidad(
	id_caracteristica VARCHAR(16) PRIMARY KEY,
    descripcion VARCHAR(32)
);

DROP TABLE IF EXISTS MINEDU_Modalidad;
CREATE TABLE MINEDU_Modalidad(
	id_modalidad VARCHAR(16) PRIMARY KEY,
    descripcion VARCHAR(64)
);

/*Tipo de declaración, Estado del CE, tipo colegio según admisión de sexo, tipo escolarización*/
DROP TABLE IF EXISTS MINEDU_Tipo_Fuente_Datos;
CREATE TABLE MINEDU_Tipo_Fuente_Datos(
	id_tipo INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(64)
);
    
DROP TABLE IF EXISTS MINEDU_Tipo_CE_Segun_Admision_Sexo;
CREATE TABLE MINEDU_Tipo_CE_Segun_Admision_Sexo(
	id_tipo VARCHAR(16) PRIMARY KEY,
    descripcion VARCHAR(32)
);

DROP TABLE IF EXISTS MINEDU_Estado_CE;
CREATE TABLE MINEDU_Estado_CE(
	id_estado VARCHAR(16) PRIMARY KEY,
    descripcion VARCHAR(32)
);

DROP TABLE IF EXISTS MINEDU_Tipo_Escolarizacion;
CREATE TABLE MINEDU_Tipo_Escolarizacion(
	id_tipo INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(32)
);

/*Director, Centro poblado*/
DROP TABLE IF EXISTS MINEDU_Director;
CREATE TABLE MINEDU_Director(
	id_director INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(256)
);

DROP TABLE IF EXISTS MINEDU_Centro_Poblado;
CREATE TABLE MINEDU_Centro_Poblado(
	id_centro_poblado INT AUTO_INCREMENT PRIMARY KEY,
	id_minedu VARCHAR(16),
	id_inei VARCHAR(16),
    descripcion VARCHAR(256)
);

/*Gestión y detalle gestion*/
DROP TABLE IF EXISTS MINEDU_Gestion;
CREATE TABLE MINEDU_Gestion(
	id_gestion VARCHAR(16) PRIMARY KEY,
    descripcion VARCHAR(32)
);

DROP TABLE IF EXISTS MINEDU_Dep_Gestion;
CREATE TABLE MINEDU_Dep_Gestion(
	id_dep_gestion VARCHAR(16) PRIMARY KEY,
    descripcion VARCHAR(32)
);

/*Ugel y Direccion adm de ugel*/
DROP TABLE IF EXISTS MINEDU_Direccion_Adm_UGEL;
CREATE TABLE MINEDU_Direccion_Adm_UGEL(
	id_direccion_adm INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(32)
);

DROP TABLE IF EXISTS MINEDU_UGEL;
CREATE TABLE MINEDU_UGEL(
	id_ugel VARCHAR(16) PRIMARY KEY,
    nombre VARCHAR(256),
    id_direccion_adm INT
);
ALTER TABLE MINEDU_UGEL
	ADD CONSTRAINT fk_MINEDU_UGEL_MINEDU_Direccion_Adm_UGEL FOREIGN KEY (id_direccion_adm) REFERENCES MINEDU_Direccion_Adm_UGEL (id_direccion_adm) ON DELETE CASCADE;

/*Centro educativo (colegio)*/
DROP TABLE IF EXISTS MINEDU_Centro_Educativo;
CREATE TABLE MINEDU_Centro_Educativo(
	id_centro_educativo VARCHAR(16) PRIMARY KEY,
	nombre_colegio VARCHAR(64),
	telefono VARCHAR(16),
    email VARCHAR(32),
    pagina_web VARCHAR(32),
    direccion VARCHAR(128),
    referencia VARCHAR(128),
    localidad VARCHAR(64),
    latitud DOUBLE,
    longitud DOUBLE,
    total_alumnos_hombres INT,
	total_alumnos_mujeres INT,
	total_alumnos INT,
    total_secciones INT,
    total_docentes INT,
    fecha_registro VARCHAR(32),
    fecha_actuacilizacion VARCHAR(32),
    id_estado VARCHAR(16),
    id_tipo_fuente INT,
    id_director INT, 
    id_ugel VARCHAR(16),
    id_escolarizacion INT,
    id_tipo_sexo VARCHAR(16),
    id_centro_poblado INT,
    id_ubigeo VARCHAR(16)
);

ALTER TABLE MINEDU_Centro_Educativo
	ADD CONSTRAINT fk_MINEDU_Centro_Educativo_MINEDU_Ubigeo FOREIGN KEY (id_ubigeo) REFERENCES MINEDU_Ubigeo (id_ubigeo) ON DELETE CASCADE,
	ADD	CONSTRAINT fk_MINEDU_Centro_Educativo_MINEDU_Estado_CE FOREIGN KEY (id_estado) REFERENCES MINEDU_Estado_CE (id_estado) ON DELETE CASCADE,
    ADD	CONSTRAINT fk_MINEDU_Centro_Educativo_MINEDU_Tipo_Fuente_Datos FOREIGN KEY (id_tipo_fuente) REFERENCES MINEDU_Tipo_Fuente_Datos (id_tipo) ON DELETE CASCADE,
    ADD	CONSTRAINT fk_MINEDU_Centro_Educativo_MINEDU_Director FOREIGN KEY (id_director) REFERENCES MINEDU_Director (id_director) ON DELETE CASCADE,
    ADD	CONSTRAINT fk_MINEDU_Centro_Educativo_MINEDU_UGEL FOREIGN KEY (id_ugel) REFERENCES MINEDU_UGEL (id_ugel) ON DELETE CASCADE,
    ADD	CONSTRAINT fk_MINEDU_Centro_Educativo_MINEDU_Tipo_CE_Segun_Admision_Sexo FOREIGN KEY (id_tipo_sexo) REFERENCES MINEDU_Tipo_CE_Segun_Admision_Sexo (id_tipo) ON DELETE CASCADE,
    ADD	CONSTRAINT fk_MINEDU_Centro_Educativo_MINEDU_Tipo_Escolarizacion FOREIGN KEY (id_escolarizacion) REFERENCES MINEDU_Tipo_Escolarizacion (id_tipo) ON DELETE CASCADE,
    ADD	CONSTRAINT fk_MINEDU_Centro_Educativo_MINEDU_Centro_Poblado FOREIGN KEY (id_centro_poblado) REFERENCES MINEDU_Centro_Poblado (id_centro_poblado) ON DELETE CASCADE;

DROP TABLE IF EXISTS MINEDU_Detalle_Centro_Educativo_Gestion;
CREATE TABLE MINEDU_Detalle_Centro_Educativo_Gestion(
	id_detalle_ce_gestion INT AUTO_INCREMENT PRIMARY KEY,
    id_centro_educativo VARCHAR(16) NOT NULL REFERENCES  MINEDU_Centro_Educativo (id_centro_educativo) ON DELETE CASCADE,
    id_gestion VARCHAR(16) NOT NULL REFERENCES MINEDU_Gestion (id_gestion) ON DELETE CASCADE,
    id_dep_gestion VARCHAR(16) NOT NULL REFERENCES MINEDU_Dep_Gestion (id_dep_gestion) ON DELETE CASCADE
);

DROP TABLE IF EXISTS MINEDU_Detalle_Centro_Educativo_Modalidad;
CREATE TABLE MINEDU_Detalle_Centro_Educativo_Modalidad(
	id_detalle_ce_modalidad INT AUTO_INCREMENT PRIMARY KEY,
    id_centro_educativo VARCHAR(16) NOT NULL REFERENCES  MINEDU_Centro_Educativo (id_centro_educativo) ON DELETE CASCADE,
    id_modalidad VARCHAR(16) NOT NULL REFERENCES MINEDU_Modalidad (id_modalidad) ON DELETE CASCADE,
    id_modularidad VARCHAR(16) NOT NULL REFERENCES MINEDU_Modularidad (id_modularidad) ON DELETE CASCADE,
    id_turno VARCHAR(16) NOT NULL REFERENCES MINEDU_Turno (id_turno) ON DELETE CASCADE,
    id_caracteristica VARCHAR(16) NOT NULL REFERENCES MINEDU_Caracteristica_Modalidad (id_caracteristica) ON DELETE CASCADE
);

/**/
INSERT INTO MINEDU_Departamento (nombre)
	SELECT D_DPTO
	FROM G2_campos_jzavaleta._padron_web
    GROUP BY D_DPTO
    ORDER BY D_DPTO ASC;
    
INSERT INTO MINEDU_Provincia (nombre, id_departamento)
	SELECT pw.D_PROV, d.id_departamento
	FROM G2_campos_jzavaleta._padron_web pw
    INNER JOIN MINEDU_Departamento d ON pw.D_DPTO = d.nombre
    GROUP BY pw.D_PROV, d.id_departamento
    ORDER BY D_PROV ASC;
    
INSERT INTO MINEDU_Distrito (nombre, id_provincia)
	SELECT pw.D_DIST, p.id_provincia
	FROM MINEDU_Departamento d
    INNER JOIN MINEDU_Provincia p ON d.id_departamento = p.id_departamento
	INNER JOIN G2_campos_jzavaleta._padron_web pw ON pw.D_DPTO = d.nombre
		AND pw.D_PROV = p.nombre
    GROUP BY pw.CODGEO, p.id_provincia
    ORDER BY pw.D_DIST ASC;

    
INSERT INTO MINEDU_Ubigeo (id_ubigeo, id_distrito)
	SELECT pw.CODGEO, d.id_distrito
	FROM MINEDU_Provincia p
    INNER JOIN MINEDU_Distrito d ON p.id_provincia = d.id_provincia
	INNER JOIN G2_campos_jzavaleta._padron_web pw ON pw.D_PROV = p.nombre
		AND pw.D_DIST = d.nombre
    GROUP BY pw.CODGEO, d.id_distrito
    ORDER BY pw.CODGEO ASC;

-- II. MINEDU_Modularidad, MINEDU_Turno,  MINEDU_Caracteristica_Modalidad
INSERT INTO MINEDU_Modularidad (id_modularidad, anexo)
	SELECT COD_MOD, ANEXO
	FROM G2_campos_jzavaleta._padron_web
    GROUP BY COD_MOD
    ORDER BY COD_MOD ASC;

INSERT INTO MINEDU_Turno (id_turno, descripcion)
	SELECT COD_TUR, D_COD_TUR
	FROM G2_campos_jzavaleta._padron_web
    GROUP BY COD_TUR, D_COD_TUR
    ORDER BY COD_TUR ASC;
    
INSERT INTO MINEDU_Caracteristica_Modalidad (id_caracteristica, descripcion)
	SELECT COD_CAR, D_COD_CAR
	FROM G2_campos_jzavaleta._padron_web
    GROUP BY COD_CAR, D_COD_CAR
    ORDER BY COD_CAR ASC;
    
INSERT INTO MINEDU_Modalidad (id_modalidad, descripcion)
	SELECT NIV_MOD, D_NIV_MOD
	FROM G2_campos_jzavaleta._padron_web
    GROUP BY NIV_MOD, D_NIV_MOD
    ORDER BY NIV_MOD ASC;
    
/*III.*/
INSERT INTO MINEDU_Tipo_Fuente_Datos (descripcion)
	SELECT D_FTE_DATO
    FROM G2_campos_jzavaleta._padron_web
    GROUP BY D_FTE_DATO
    ORDER BY D_FTE_DATO ASC;
    
INSERT INTO MINEDU_Tipo_CE_Segun_Admision_Sexo (id_tipo, descripcion)
	SELECT TIPSSEXO, D_TIPSSEXO
    FROM G2_campos_jzavaleta._padron_web
    GROUP BY TIPSSEXO, D_TIPSSEXO
    ORDER BY TIPSSEXO ASC;
    
INSERT INTO MINEDU_Estado_CE (id_estado, descripcion)
	SELECT ESTADO, D_ESTADO
    FROM G2_campos_jzavaleta._padron_web
    GROUP BY ESTADO, D_ESTADO
    ORDER BY ESTADO ASC;
    
INSERT INTO MINEDU_Tipo_Escolarizacion (descripcion)
	SELECT D_FORMA
    FROM G2_campos_jzavaleta._padron_web
    GROUP BY D_FORMA
    ORDER BY D_FORMA ASC;
    
INSERT INTO MINEDU_Director (nombre_completo)
	SELECT DIRECTOR
    FROM G2_campos_jzavaleta._padron_web
    GROUP BY DIRECTOR
    ORDER BY DIRECTOR ASC;
    
INSERT INTO MINEDU_Centro_Poblado (id_minedu, id_inei, descripcion)
	SELECT CODCCPP, CODCP_INEI, CEN_POB
    FROM G2_campos_jzavaleta._padron_web
    GROUP BY CODCCPP, CODCP_INEI, CEN_POB
    ORDER BY CODCCPP ASC;

INSERT INTO MINEDU_Gestion (id_gestion, descripcion)
	SELECT GESTION, D_GESTION
	FROM G2_campos_jzavaleta._padron_web
    GROUP BY GESTION, D_GESTION
    ORDER BY GESTION ASC;
    
INSERT INTO MINEDU_Dep_Gestion (id_dep_gestion, descripcion)
	SELECT GES_DEP, D_GES_DEP
	FROM G2_campos_jzavaleta._padron_web
    GROUP BY GES_DEP, D_GES_DEP
    ORDER BY GES_DEP ASC;

INSERT INTO MINEDU_Direccion_Adm_UGEL (descripcion)
	SELECT D_REGION
	FROM G2_campos_jzavaleta._padron_web
    GROUP BY D_REGION
    ORDER BY D_REGION ASC;
    
INSERT INTO MINEDU_UGEL (id_ugel, nombre, id_direccion_adm)
	SELECT pw.CODOOII, pw.D_DREUGEL, adm_ugel.id_direccion_adm
	FROM G2_campos_jzavaleta._padron_web pw
    INNER JOIN MINEDU_Direccion_Adm_UGEL adm_ugel ON adm_ugel.descripcion = pw.D_REGION
    GROUP BY pw.CODOOII, pw.D_DREUGEL, adm_ugel.id_direccion_adm
    ORDER BY CODOOII ASC;

/*Inserción de datos de CE*/
INSERT INTO MINEDU_Centro_Educativo 
	(id_centro_educativo, nombre_colegio, telefono, email, pagina_web, referencia, localidad,
	latitud, longitud, total_alumnos_hombres, total_alumnos_mujeres, total_alumnos,
    total_secciones, total_docentes, fecha_registro, fecha_actuacilizacion,
    -- Referencias
    id_estado, id_tipo_fuente, id_director, id_ugel, id_escolarizacion, id_tipo_sexo,
    id_centro_poblado, id_ubigeo)
    
	SELECT pw.CODLOCAL, pw.CEN_EDU, pw.TELEFONO, pw.EMAIL, pw.PAGWEB, pw.REFERENCIA, pw.LOCALIDAD,
		pw.NLAT_IE, pw.NLONG_IE, pw.TALUM_HOM, pw.TALUM_MUJ, pw.TALUMNO, pw.TSECCION, pw.TDOCENTE,
        pw.FECHAREG, pw.FECHA_ACT,
        
        pw.ESTADO, tfd.id_tipo, dir.id_director,
        pw.CODOOII, te.id_tipo, pw.TIPSSEXO, ce.id_centro_poblado,
        pw.CODGEO
	FROM G2_campos_jzavaleta._padron_web pw
    INNER JOIN MINEDU_Tipo_Fuente_Datos tfd ON pw.D_FTE_DATO = tfd.descripcion
    INNER JOIN MINEDU_Director dir ON pw.DIRECTOR = dir.nombre_completo
    INNER JOIN MINEDU_Tipo_Escolarizacion te ON pw.D_FORMA = te.descripcion
    INNER JOIN MINEDU_Centro_Poblado ce ON pw.CODCP_INEI = ce.id_inei
		AND pw.CODCCPP = ce.id_minedu
    GROUP BY pw.CODLOCAL, pw.CEN_EDU, pw.TELEFONO, pw.EMAIL, pw.PAGWEB, pw.REFERENCIA, pw.LOCALIDAD,
		pw.NLAT_IE, pw.NLONG_IE, pw.TALUM_HOM, pw.TALUM_MUJ, pw.TALUMNO, pw.TSECCION, pw.TDOCENTE,
        pw.FECHAREG, pw.FECHA_ACT,
        
        pw.ESTADO, tfd.id_tipo, dir.id_director,
        pw.CODOOII, te.id_tipo, pw.TIPSSEXO, ce.id_centro_poblado,
        pw.CODGEO
    ORDER BY CODOOII ASC;