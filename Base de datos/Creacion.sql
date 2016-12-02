--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: auto_incremento_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auto_incremento_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auto_incremento_id OWNER TO postgres;

--
-- Name: SEQUENCE auto_incremento_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON SEQUENCE auto_incremento_id IS 'Secuencia que auto incrementa la variable id';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

-- ********************************************** CREACIÓN DE TABLAS ***************************************

--Creación tabla usuarios

CREATE TABLE usuarios (
    id_usuario integer DEFAULT nextval('auto_incremento_id'::regclass) NOT NULL,
    nombre_usuario text NOT NULL,
    apellido_usuario text,
    nombre_acceso text NOT NULL,
    contrasenia text NOT NULL,
    email text NOT NULL,
    estado text NOT NULL,
    telefono integer NOT NULL,
    tipo_usuario text NOT NULL,
    
    CONSTRAINT email_correcto CHECK (((email)::text ~ '^[\w!#$%&''*+/=?`{|}~^-]+(\.[\w!#$%&''*+/=?`{|}~^-]+)*@[\w-]+(\.[\w-]+)*$'::text)),
    CONSTRAINT estado_correcto CHECK (((estado)::bpchar = ANY (ARRAY['a'::character(1), 'e'::character(1),'i'::character(1)]))),    
    --estados posibles a = aceptado , e = espera , i = inhabilitado
    CONSTRAINT tipo_correcto CHECK (((tipo_usuario)::bpchar = ANY (ARRAY['c'::character(1), 'p'::character(1),'a'::character(1)])))
    -- tipos de usuarios c = cliente , p = proveedor, a = administrador    
);

ALTER TABLE usuarios OWNER TO postgres;


--Creación tabla categorias

CREATE TABLE categorias (
    id_categoria integer DEFAULT nextval('auto_incremento_id'::regclass) NOT NULL,
    nombre_categoria text NOT NULL,
    CONSTRAINT categoria_correcta CHECK (((nombre_categoria)::bpchar = ANY (ARRAY['c'::character(1), 'p'::character(1),'a'::character(1)])))   
    -- categorias c = comida , p = paseos ecológicos, a = alojamiento 
);

ALTER TABLE categorias OWNER TO postgres;


--Creación tabla catalogos

CREATE TABLE catalogos (
    id_catalogo integer DEFAULT nextval('auto_incremento_id'::regclass) NOT NULL,
    nombre_catalogo text NOT NULL,
    imagen text NOT NULL,
    descripcion text NOT NULL,
    fk_id_usuario integer NOT NULL,
    fk_id_categoria integer NOT NULL
);


ALTER TABLE catalogos OWNER TO postgres;


--Creación tabla calificaciones

CREATE TABLE calificaciones (
    id_calificacion integer DEFAULT nextval('auto_incremento_id'::regclass) NOT NULL,
    valor integer NOT NULL,
    --fk_id_usuario integer REFERENCES usuarios ON DELETE CASCADE,
    fk_id_usuario integer NOT NULL,
    --fk_id_oferta integer REFERENCES ofertas ON DELETE CASCADE
    fk_id_oferta integer NOT NULL
);
ALTER TABLE calificaciones OWNER TO postgres;

--id_usuario_calificado integer REFERENCES usuario ON DELETE CASCADE,

--Creación tabla ofertas
CREATE TABLE ofertas (
    id_oferta integer DEFAULT nextval('auto_incremento_id'::regclass) NOT NULL,
    costo integer NOT NULL,
    fecha_ini DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    descripcion text NOT NULL,
    fk_id_catalogo integer NOT NULL
);
ALTER TABLE ofertas OWNER TO postgres;

--Creación tabla compras
CREATE TABLE compras (
    id_compra integer DEFAULT nextval('auto_incremento_id'::regclass) NOT NULL,
    fk_id_usuario integer NOT NULL,
    fk_id_oferta integer NOT NULL
);
ALTER TABLE compras OWNER TO postgres;


-- ************************************ LLAVES PRIMARIAS*******************************************************++

--Llave primaria de la tabla usuarios
ALTER TABLE ONLY usuarios
    ADD CONSTRAINT pk_id_usuario PRIMARY KEY (id_usuario);

--Llave primaria de la tabla categorias
ALTER TABLE ONLY categorias
    ADD CONSTRAINT pk_id_categoria PRIMARY KEY (id_categoria);

--Llave primaria de la tabla catalogos
ALTER TABLE ONLY catalogos
    ADD CONSTRAINT pk_id_catalogo PRIMARY KEY (id_catalogo);

--Llave primaria de la tabla calificaciones
ALTER TABLE ONLY calificaciones
    ADD CONSTRAINT pk_id_calificacion PRIMARY KEY (id_calificacion);

--Llave primaria de la tabla ofertas
ALTER TABLE ONLY ofertas
    ADD CONSTRAINT pk_id_oferta PRIMARY KEY (id_oferta);

--Llave primaria de la tabla compras
ALTER TABLE ONLY compras
    ADD CONSTRAINT pk_id_compra PRIMARY KEY (id_compra);

-- *****************************************LLAVES FORÁNEAS ********************************************************

--Llave foránea que irá en calificaciones referente a la tabla ofertas
ALTER TABLE ONLY calificaciones
    ADD CONSTRAINT fk_id_oferta_calificaciones FOREIGN KEY (fk_id_oferta) REFERENCES ofertas(id_oferta);

--Llave foránea que irá en calificaciones referente a la tabla usuarios
ALTER TABLE ONLY calificaciones
    ADD CONSTRAINT fk_id_usuario_calificaciones FOREIGN KEY (fk_id_usuario) REFERENCES usuarios(id_usuario);

--Llave foránea que irá en catálogos referente a la tabla usuarios
ALTER TABLE ONLY catalogos
    ADD CONSTRAINT fk_id_usuario_catalogos FOREIGN KEY (fk_id_usuario) REFERENCES usuarios(id_usuario);

--Llave foránea que irá en catálogos referente a la tabla categoria
ALTER TABLE ONLY catalogos
    ADD CONSTRAINT fk_id_categoria_catalogos FOREIGN KEY (fk_id_categoria) REFERENCES categorias(id_categoria);

--Llave foránea que irá en ofertas referente a la tabla catalogos
ALTER TABLE ONLY ofertas
    ADD CONSTRAINT fk_id_catalogo_ofertas FOREIGN KEY (fk_id_catalogo) REFERENCES catalogos(id_catalogo);

--Llave foránea que irá en compras referente a la tabla usuarios
ALTER TABLE ONLY compras
    ADD CONSTRAINT fk_id_usuarios_compras FOREIGN KEY (fk_id_usuario) REFERENCES usuarios(id_usuario);

--Llave foránea que irá en compras referente a la tabla ofertas
ALTER TABLE ONLY compras
    ADD CONSTRAINT fk_id_ofertas_compras FOREIGN KEY (fk_id_oferta) REFERENCES ofertas(id_oferta);


-- ****************************************CHECKS ******************************************************************

--Check de unique para el email
ALTER TABLE ONLY usuarios
    ADD CONSTRAINT unique_email UNIQUE (email);

--Check de rango para el id_usuario
ALTER TABLE ONLY usuarios
    ADD CONSTRAINT ck_id_usuario CHECK(id_usuario >= 0);

--Check de unique para el nombre de acceso
ALTER TABLE ONLY usuarios
    ADD CONSTRAINT unique_nombre_acceso UNIQUE (nombre_acceso);

--Check de rango para el id_categorias
ALTER TABLE ONLY categorias
    ADD CONSTRAINT ck_id_categoria CHECK(id_categoria >= 0);

--Check de unique para el nombre de acceso
ALTER TABLE ONLY catalogos
    ADD CONSTRAINT unique_nombre_catalogo UNIQUE (nombre_catalogo);

--Check de rango para el id_catalogo
ALTER TABLE ONLY catalogos
    ADD CONSTRAINT ck_id_catalogo CHECK(id_catalogo >= 0);

--Check de rango para el valor
ALTER TABLE ONLY calificaciones
    ADD CONSTRAINT ck_valor CHECK(valor >= 0 AND valor <=5);

--Check de rango para el id_calificacion
ALTER TABLE ONLY calificaciones
    ADD CONSTRAINT ck_id_calificacion CHECK(id_calificacion >= 0);

--Check de rango para el valor
ALTER TABLE ONLY ofertas
    ADD CONSTRAINT ck_costo CHECK(costo >= 0);

--Check de rango para el id_calificacion
ALTER TABLE ONLY ofertas
    ADD CONSTRAINT ck_id_oferta CHECK(id_oferta >= 0);

--Check de rango para el id_compra
ALTER TABLE ONLY compras
    ADD CONSTRAINT ck_id_compra CHECK(id_compra >= 0);

--Check de ofertas para que la fecha inicial sea menor a la fecha final
ALTER TABLE ONLY ofertas
    ADD CONSTRAINT ck_fechas CHECK(fecha_ini <= fecha_fin);


-- Autoincremento
SELECT pg_catalog.setval('auto_incremento_id', 7, true);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--