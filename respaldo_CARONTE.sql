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
-- Name: sujetosobligados; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA sujetosobligados;


ALTER SCHEMA sujetosobligados OWNER TO postgres;

--
-- Name: transacciones; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA transacciones;


ALTER SCHEMA transacciones OWNER TO postgres;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = sujetosobligados, pg_catalog;

--
-- Name: seq_tx_documento; Type: SEQUENCE; Schema: sujetosobligados; Owner: postgres
--

CREATE SEQUENCE seq_tx_documento
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_tx_documento OWNER TO postgres;

--
-- Name: seq_tx_documento_adjunto; Type: SEQUENCE; Schema: sujetosobligados; Owner: postgres
--

CREATE SEQUENCE seq_tx_documento_adjunto
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_tx_documento_adjunto OWNER TO postgres;

--
-- Name: seq_tx_entidad; Type: SEQUENCE; Schema: sujetosobligados; Owner: postgres
--

CREATE SEQUENCE seq_tx_entidad
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_tx_entidad OWNER TO postgres;

--
-- Name: seq_tx_entidad_actividad; Type: SEQUENCE; Schema: sujetosobligados; Owner: postgres
--

CREATE SEQUENCE seq_tx_entidad_actividad
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_tx_entidad_actividad OWNER TO postgres;

--
-- Name: seq_tx_func_usu_entidad; Type: SEQUENCE; Schema: sujetosobligados; Owner: postgres
--

CREATE SEQUENCE seq_tx_func_usu_entidad
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_tx_func_usu_entidad OWNER TO postgres;

--
-- Name: seq_tx_funcionaro_caronte; Type: SEQUENCE; Schema: sujetosobligados; Owner: postgres
--

CREATE SEQUENCE seq_tx_funcionaro_caronte
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_tx_funcionaro_caronte OWNER TO postgres;

--
-- Name: seq_tx_persona_general; Type: SEQUENCE; Schema: sujetosobligados; Owner: postgres
--

CREATE SEQUENCE seq_tx_persona_general
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_tx_persona_general OWNER TO postgres;

--
-- Name: seq_tx_remplazo_temp_fr; Type: SEQUENCE; Schema: sujetosobligados; Owner: postgres
--

CREATE SEQUENCE seq_tx_remplazo_temp_fr
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_tx_remplazo_temp_fr OWNER TO postgres;

--
-- Name: seq_tx_seguimiento_etapa; Type: SEQUENCE; Schema: sujetosobligados; Owner: postgres
--

CREATE SEQUENCE seq_tx_seguimiento_etapa
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_tx_seguimiento_etapa OWNER TO postgres;

--
-- Name: seq_tx_tramite; Type: SEQUENCE; Schema: sujetosobligados; Owner: postgres
--

CREATE SEQUENCE seq_tx_tramite
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_tx_tramite OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: tx_documento; Type: TABLE; Schema: sujetosobligados; Owner: postgres; Tablespace: 
--

CREATE TABLE tx_documento (
    id_documento numeric(15,0) NOT NULL,
    id_funcionario_caronte numeric(15,0),
    id_entidad numeric(15,0) NOT NULL,
    id_tramite numeric(15,0) NOT NULL,
    numero_documento character varying(50),
    fecha_documento timestamp without time zone,
    cod_tipo_documento character varying(50),
    cod_etapa_tramite character varying(15),
    cod_estado_renovacion character varying(15),
    observaciones character varying(500),
    tx_id numeric(15,0) NOT NULL,
    tx_usuario character varying(50),
    tx_fecha timestamp without time zone,
    tx_estado character varying(15)
);


ALTER TABLE tx_documento OWNER TO postgres;

--
-- Name: COLUMN tx_documento.id_documento; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_documento.id_documento IS 'Identificador Ãºnico de la tabla';


--
-- Name: COLUMN tx_documento.id_funcionario_caronte; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_documento.id_funcionario_caronte IS 'Id del funcionario responsable o analista de cumplimiento del que es el documento';


--
-- Name: COLUMN tx_documento.id_entidad; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_documento.id_entidad IS 'Entidad a la que pertenece el documento';


--
-- Name: COLUMN tx_documento.numero_documento; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_documento.numero_documento IS 'NÃºmero identificador del documento presentado. No todos tienen un nÃºmero Ej Curriculum Vitae';


--
-- Name: COLUMN tx_documento.fecha_documento; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_documento.fecha_documento IS 'Fecha en la que se imprimiÃ³ el document';


--
-- Name: COLUMN tx_documento.cod_tipo_documento; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_documento.cod_tipo_documento IS 'Tipo del document presentado. Ej TÃ­tulo en provisi{on Nacional';


--
-- Name: COLUMN tx_documento.cod_etapa_tramite; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_documento.cod_etapa_tramite IS 'Es la etapa en la que se encuentra el trÃ¡mite. Ej.  AP Aprobado Legal, AJ: Area Juridica, AR: Aprobado Sistemas, TE: Archiado';


--
-- Name: COLUMN tx_documento.cod_estado_renovacion; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_documento.cod_estado_renovacion IS 'Ej. True, False';


--
-- Name: tx_documento_adjunto; Type: TABLE; Schema: sujetosobligados; Owner: postgres; Tablespace: 
--

CREATE TABLE tx_documento_adjunto (
    id_documento_adjunto numeric(15,0) NOT NULL,
    id_documento numeric(15,0) NOT NULL,
    nombre_archivo character varying(50),
    tipo_archivo character varying(50),
    ruta_archivo character varying(500),
    descripcion character varying(500),
    tx_id numeric(15,0) NOT NULL,
    tx_usuario character(50),
    tx_fecha timestamp without time zone,
    tx_estado character varying(15)
);


ALTER TABLE tx_documento_adjunto OWNER TO postgres;

--
-- Name: COLUMN tx_documento_adjunto.nombre_archivo; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_documento_adjunto.nombre_archivo IS 'Nombre del archivo adjuntado';


--
-- Name: COLUMN tx_documento_adjunto.tipo_archivo; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_documento_adjunto.tipo_archivo IS 'Tipo del archivo adjuntado. Ej pdf, doc.';


--
-- Name: COLUMN tx_documento_adjunto.ruta_archivo; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_documento_adjunto.ruta_archivo IS 'Ruta en la que se encuentra el archivo.';


--
-- Name: COLUMN tx_documento_adjunto.descripcion; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_documento_adjunto.descripcion IS 'descripciÃ³n de archivo adjuntado';


--
-- Name: tx_entidad; Type: TABLE; Schema: sujetosobligados; Owner: postgres; Tablespace: 
--

CREATE TABLE tx_entidad (
    id_entidad numeric(15,0) NOT NULL,
    id_persona_general numeric(15,0) NOT NULL,
    nombre character varying(50),
    nit character varying(15),
    sigla character varying(50),
    direccion character varying(100),
    telefono character varying(15),
    correo character varying(50),
    zona character varying(50),
    cod_tipo_entidad character varying(15),
    cod_tipo_empresa character varying(15),
    cod_estado_entidad character varying(15),
    cod_pais character varying(15),
    cod_departamento character varying(15),
    cod_provincia character varying(15),
    cod_municipio character varying(15),
    cod_localidad character varying(15),
    observaciones character varying(500),
    tx_id numeric(15,0) NOT NULL,
    tx_usuario character varying(50),
    tx_fecha timestamp without time zone,
    tx_estado character varying(15)
);


ALTER TABLE tx_entidad OWNER TO postgres;

--
-- Name: COLUMN tx_entidad.nombre; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_entidad.nombre IS 'Nombre del sujeto obligado.';


--
-- Name: COLUMN tx_entidad.nit; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_entidad.nit IS 'Nit del sujeto obligado.';


--
-- Name: COLUMN tx_entidad.sigla; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_entidad.sigla IS 'Sigla del sujeto obligado. Ej UIF';


--
-- Name: COLUMN tx_entidad.direccion; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_entidad.direccion IS 'DirecciÃ³n del sujeto obligado.';


--
-- Name: COLUMN tx_entidad.telefono; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_entidad.telefono IS 'TelÃ©fono del sujeto obligado.';


--
-- Name: COLUMN tx_entidad.correo; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_entidad.correo IS 'Correo del sujeto obligado.';


--
-- Name: COLUMN tx_entidad.zona; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_entidad.zona IS 'Zona del sujeto obligado.';


--
-- Name: COLUMN tx_entidad.cod_tipo_entidad; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_entidad.cod_tipo_entidad IS 'Tipo del sujeto obligado. Ejm BANCOS, MUTUALES';


--
-- Name: COLUMN tx_entidad.cod_tipo_empresa; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_entidad.cod_tipo_empresa IS 'Tipo de estado de la entidad puede ser preregistro';


--
-- Name: COLUMN tx_entidad.cod_estado_entidad; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_entidad.cod_estado_entidad IS 'Tipo de empresa del sujeto obligado. Ej. UNIPERSONAL';


--
-- Name: COLUMN tx_entidad.cod_pais; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_entidad.cod_pais IS 'Pais del sujeto obligado.';


--
-- Name: COLUMN tx_entidad.cod_departamento; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_entidad.cod_departamento IS 'Departamento del sujeto obligado.';


--
-- Name: COLUMN tx_entidad.cod_provincia; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_entidad.cod_provincia IS 'Provincia del sujeto obligado.';


--
-- Name: COLUMN tx_entidad.cod_municipio; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_entidad.cod_municipio IS 'Municipio del sujeto obligado.';


--
-- Name: COLUMN tx_entidad.cod_localidad; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_entidad.cod_localidad IS 'Ciudad del sujeto obligado.';


--
-- Name: tx_entidad_actividad; Type: TABLE; Schema: sujetosobligados; Owner: postgres; Tablespace: 
--

CREATE TABLE tx_entidad_actividad (
    id_entidad_actividad numeric(15,0) NOT NULL,
    id_entidad numeric(15,0) NOT NULL,
    cod_actividad character varying(50),
    tx_id numeric(15,0) NOT NULL,
    tx_usuario character varying(50),
    tx_fecha timestamp without time zone,
    tx_estado character varying(15)
);


ALTER TABLE tx_entidad_actividad OWNER TO postgres;

--
-- Name: COLUMN tx_entidad_actividad.id_entidad_actividad; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_entidad_actividad.id_entidad_actividad IS 'Identificador Ãºnico de la tabla';


--
-- Name: COLUMN tx_entidad_actividad.id_entidad; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_entidad_actividad.id_entidad IS 'Entidad a la que pertenece el documento';


--
-- Name: COLUMN tx_entidad_actividad.cod_actividad; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_entidad_actividad.cod_actividad IS 'Tipo del document presentado. Ej TÃ­tulo en provisi{on Nacional';


--
-- Name: tx_func_usu_entidad; Type: TABLE; Schema: sujetosobligados; Owner: postgres; Tablespace: 
--

CREATE TABLE tx_func_usu_entidad (
    id_func_usu_entidad numeric(15,0) NOT NULL,
    id_funcionario_caronte numeric(15,0) NOT NULL,
    id_entidad numeric(15,0),
    id_usuario numeric(15,0),
    nombre_usuario character(40),
    sistema_usuario character varying(15),
    tx_id numeric(15,0) NOT NULL,
    tx_usuario character varying(50),
    tx_fecha timestamp without time zone,
    tx_estado character varying(15)
);


ALTER TABLE tx_func_usu_entidad OWNER TO postgres;

--
-- Name: COLUMN tx_func_usu_entidad.id_funcionario_caronte; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_func_usu_entidad.id_funcionario_caronte IS 'funcionario caronte que tendrá usario';


--
-- Name: COLUMN tx_func_usu_entidad.id_usuario; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_func_usu_entidad.id_usuario IS 'id usuario se obtiene de la tabla usuarios, dependiend el sistema';


--
-- Name: COLUMN tx_func_usu_entidad.nombre_usuario; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_func_usu_entidad.nombre_usuario IS 'Es el nombre del usuaro, revisar si se quedará.';


--
-- Name: COLUMN tx_func_usu_entidad.sistema_usuario; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_func_usu_entidad.sistema_usuario IS 'Con este campo podemos saber que usuarios tiene en determinad sistema el funcionario(cuando se integren las bd debería ser solo uno) sistema siso, sadi, etc.';


--
-- Name: tx_funcionario_caronte; Type: TABLE; Schema: sujetosobligados; Owner: postgres; Tablespace: 
--

CREATE TABLE tx_funcionario_caronte (
    id_funcionario_caronte numeric(15,0) NOT NULL,
    id_entidad numeric(15,0) NOT NULL,
    id_persona_general numeric(15,0) NOT NULL,
    cod_tipo_funcionario character varying(15),
    cargo character varying(250),
    observaciones character varying(500),
    motivo_estado character varying(250),
    tx_id numeric(15,0) NOT NULL,
    tx_usuario character varying(50),
    tx_fecha timestamp without time zone,
    tx_estado character varying(15)
);


ALTER TABLE tx_funcionario_caronte OWNER TO postgres;

--
-- Name: COLUMN tx_funcionario_caronte.cod_tipo_funcionario; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_funcionario_caronte.cod_tipo_funcionario IS 'FR-AC';


--
-- Name: tx_persona_general; Type: TABLE; Schema: sujetosobligados; Owner: postgres; Tablespace: 
--

CREATE TABLE tx_persona_general (
    id_persona_general numeric(15,0) NOT NULL,
    primer_nombre character varying(200),
    segundo_nombre character varying(200),
    primer_apellido character varying(200),
    segundo_apellido character varying(200),
    apellido_casada character varying(200),
    cod_genero character varying(15),
    fecha_nacimiento timestamp without time zone,
    numero_documento character varying(15),
    complemento numeric(15,0),
    cod_tipo_documento character varying(15),
    cod_expedido character varying(15),
    cod_tipo_persona character varying(40),
    direccion character varying(250),
    tx_id numeric(15,0) NOT NULL,
    tx_usuario character varying(50),
    tx_fecha timestamp without time zone,
    tx_estado character varying(15)
);


ALTER TABLE tx_persona_general OWNER TO postgres;

--
-- Name: tx_remplazo_temp_fr; Type: TABLE; Schema: sujetosobligados; Owner: postgres; Tablespace: 
--

CREATE TABLE tx_remplazo_temp_fr (
    id_remplazo_temporal_fr numeric(15,0) NOT NULL,
    id_funcionario_caronte numeric(15,0) NOT NULL,
    id_funcionario_remplazo numeric(15,0),
    fecha_inicio_remplazo timestamp without time zone,
    fecha_fin_remplazo timestamp without time zone,
    tx_id numeric(15,0) NOT NULL,
    tx_usuario character varying(50),
    tx_fecha timestamp without time zone,
    tx_estado character varying(15)
);


ALTER TABLE tx_remplazo_temp_fr OWNER TO postgres;

--
-- Name: tx_seguimiento_etapa; Type: TABLE; Schema: sujetosobligados; Owner: postgres; Tablespace: 
--

CREATE TABLE tx_seguimiento_etapa (
    id_seguimiento_etapa numeric(15,0) NOT NULL,
    id_tramite numeric(15,0) NOT NULL,
    cod_etapa_tramite character varying(15),
    cod_ubicacion_tramite character varying(15),
    descripcion character varying(500),
    fecha timestamp without time zone,
    nombre_usuario character varying(50),
    observaciones character varying(500),
    tx_id numeric(15,0) NOT NULL,
    tx_usuario character varying(50),
    tx_fecha timestamp without time zone,
    tx_estado character varying(15)
);


ALTER TABLE tx_seguimiento_etapa OWNER TO postgres;

--
-- Name: COLUMN tx_seguimiento_etapa.nombre_usuario; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_seguimiento_etapa.nombre_usuario IS 'Nombre del usuaro responsable de la etapa';


--
-- Name: tx_tramite; Type: TABLE; Schema: sujetosobligados; Owner: postgres; Tablespace: 
--

CREATE TABLE tx_tramite (
    id_tramite numeric(15,0) NOT NULL,
    id_entidad numeric(15,0),
    id_funcionario_caronte numeric(15,0),
    id_tramite_anterior numeric(15,0),
    id_analista_legal numeric(15,0),
    id_jefe_area_legal numeric(15,0),
    numero_tramite character varying(50) NOT NULL,
    cod_tipo_funcionario character varying(40),
    cod_etapa_tramite character varying(15),
    cod_origen_tramite character varying(15),
    cod_tipo_tramite character varying(15),
    nro_informe_irc character varying(25),
    nro_tramite_sicod character varying(25),
    gestion character varying(15),
    motivo_baja character varying(250),
    codigo_validacion character varying(50),
    codigo character varying(15),
    fecha_creacion timestamp without time zone,
    fecha_ini_cert timestamp without time zone,
    fecha_fin_cert timestamp without time zone,
    id_usuario_creacion numeric(15,0),
    observaciones character varying(500),
    tx_id numeric(15,0) NOT NULL,
    tx_usuario character varying(50),
    tx_fecha timestamp without time zone,
    tx_estado character varying(15)
);


ALTER TABLE tx_tramite OWNER TO postgres;

--
-- Name: COLUMN tx_tramite.id_tramite; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_tramite.id_tramite IS 'Identificador Ãºnico de la tabla';


--
-- Name: COLUMN tx_tramite.id_entidad; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_tramite.id_entidad IS 'Entidad a la que pertenence el trÃ¡mite.';


--
-- Name: COLUMN tx_tramite.id_funcionario_caronte; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_tramite.id_funcionario_caronte IS 'Funcionario al que estÃ¡ asociado el trÃ¡mite, puede ser : FR o AC';


--
-- Name: COLUMN tx_tramite.cod_tipo_funcionario; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_tramite.cod_tipo_funcionario IS 'Puede ser FR o AC.';


--
-- Name: COLUMN tx_tramite.cod_etapa_tramite; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_tramite.cod_etapa_tramite IS 'Es la etapa en la que se encuentra el trÃ¡mite. Ej  AJ	TRAMITE PENDIENTE AP	TRAMITE APROBADO AR	TRAMITE APROBADO PARA ARCHIVAR OB	TRAMITE OBSERVADO TE	TRAMITE TERMINADO';


--
-- Name: COLUMN tx_tramite.cod_origen_tramite; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_tramite.cod_origen_tramite IS 'Es de donde llega el trÃ¡mite. Ej Mesa de entrada.';


--
-- Name: COLUMN tx_tramite.cod_tipo_tramite; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_tramite.cod_tipo_tramite IS 'Campo utilizado para conocer si el trÃ¡mite es de SO, FR, AC, SO-FR-AC, SO-FR';


--
-- Name: COLUMN tx_tramite.nro_informe_irc; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_tramite.nro_informe_irc IS 'Es el nÃºmero de informe que se genera para Caronte desde el Ã¡rea legal';


--
-- Name: COLUMN tx_tramite.nro_tramite_sicod; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_tramite.nro_tramite_sicod IS 'TrÃ¡mite Sicod del flujo';


--
-- Name: COLUMN tx_tramite.motivo_baja; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_tramite.motivo_baja IS 'Es el motivo por el que se da de baja un trÃ¡mite.';


--
-- Name: COLUMN tx_tramite.codigo_validacion; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_tramite.codigo_validacion IS 'CÃ³digo para ARCHIVO para generar reporte,';


--
-- Name: COLUMN tx_tramite.codigo; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_tramite.codigo IS 'CÃ³digo para generar las certificaciones, VER ARCHIVO';


--
-- Name: COLUMN tx_tramite.fecha_creacion; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_tramite.fecha_creacion IS 'Fecha de creaciÃ³n del trÃ¡mite.';


--
-- Name: COLUMN tx_tramite.id_usuario_creacion; Type: COMMENT; Schema: sujetosobligados; Owner: postgres
--

COMMENT ON COLUMN tx_tramite.id_usuario_creacion IS 'Usuario que creo el trÃ¡mite.';


SET search_path = transacciones, pg_catalog;

--
-- Name: seq_tx_access_log; Type: SEQUENCE; Schema: transacciones; Owner: postgres
--

CREATE SEQUENCE seq_tx_access_log
    START WITH 114181
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_tx_access_log OWNER TO postgres;

--
-- Name: seq_tx_error_log; Type: SEQUENCE; Schema: transacciones; Owner: postgres
--

CREATE SEQUENCE seq_tx_error_log
    START WITH 2454
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_tx_error_log OWNER TO postgres;

--
-- Name: seq_tx_log_tramite_reporte; Type: SEQUENCE; Schema: transacciones; Owner: postgres
--

CREATE SEQUENCE seq_tx_log_tramite_reporte
    START WITH 111
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_tx_log_tramite_reporte OWNER TO postgres;

--
-- Name: seq_tx_operacion; Type: SEQUENCE; Schema: transacciones; Owner: postgres
--

CREATE SEQUENCE seq_tx_operacion
    START WITH 219643
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_tx_operacion OWNER TO postgres;

--
-- Name: seq_tx_reporte_log; Type: SEQUENCE; Schema: transacciones; Owner: postgres
--

CREATE SEQUENCE seq_tx_reporte_log
    START WITH 164
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999999
    CACHE 1;


ALTER TABLE seq_tx_reporte_log OWNER TO postgres;

--
-- Name: seq_tx_tramite_log; Type: SEQUENCE; Schema: transacciones; Owner: postgres
--

CREATE SEQUENCE seq_tx_tramite_log
    START WITH 55
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_tx_tramite_log OWNER TO postgres;

--
-- Name: seq_tx_transaccion; Type: SEQUENCE; Schema: transacciones; Owner: postgres
--

CREATE SEQUENCE seq_tx_transaccion
    START WITH 859132
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_tx_transaccion OWNER TO postgres;

--
-- Name: tx_access_log; Type: TABLE; Schema: transacciones; Owner: postgres; Tablespace: 
--

CREATE TABLE tx_access_log (
    id_access_log numeric(15,0) NOT NULL,
    parametros character varying(4000),
    pagina character varying(100),
    tx_usuario character varying(50),
    tx_fecha timestamp without time zone,
    tx_estacion character varying(50)
);


ALTER TABLE tx_access_log OWNER TO postgres;

--
-- Name: tx_error_log; Type: TABLE; Schema: transacciones; Owner: postgres; Tablespace: 
--

CREATE TABLE tx_error_log (
    id_error_log numeric(15,0) NOT NULL,
    tipo_error character varying(150),
    mensaje character varying(500),
    clase character varying(500),
    metodo character varying(500),
    linea character varying(500),
    observaciones character varying(500),
    tx_usuario character varying(50),
    tx_fecha timestamp without time zone,
    tx_estacion character varying(50)
);


ALTER TABLE tx_error_log OWNER TO postgres;

--
-- Name: tx_log_tramite_reporte; Type: TABLE; Schema: transacciones; Owner: postgres; Tablespace: 
--

CREATE TABLE tx_log_tramite_reporte (
    id_log_tramite_reporte numeric(15,0) NOT NULL,
    id_tramite numeric(15,0),
    impresion character varying(40),
    tx_id numeric(15,0),
    tx_usuario character varying(50),
    tx_fecha timestamp without time zone,
    tx_estado character varying(10),
    tx_estacion character varying(15)
);


ALTER TABLE tx_log_tramite_reporte OWNER TO postgres;

--
-- Name: tx_operacion; Type: TABLE; Schema: transacciones; Owner: postgres; Tablespace: 
--

CREATE TABLE tx_operacion (
    id_operacion numeric(15,0) NOT NULL,
    tx_id numeric(15,0) NOT NULL,
    cod_operacion character varying(40) NOT NULL,
    fecha timestamp without time zone NOT NULL,
    tx_estado character varying(40) NOT NULL,
    usuario character varying(40) NOT NULL,
    estacion character varying(40) NOT NULL
);


ALTER TABLE tx_operacion OWNER TO postgres;

--
-- Name: COLUMN tx_operacion.cod_operacion; Type: COMMENT; Schema: transacciones; Owner: postgres
--

COMMENT ON COLUMN tx_operacion.cod_operacion IS 'Codigo de la operacion que se realizó:  "REG" = REGISTRADO "MOD" = MODIFICADO "ELI" = ELIMINADO';


--
-- Name: COLUMN tx_operacion.tx_estado; Type: COMMENT; Schema: transacciones; Owner: postgres
--

COMMENT ON COLUMN tx_operacion.tx_estado IS 'Es el estado del registro puede ser: "ELI" "PA" "H" "R1" "REG" "CRE" "CRGDO" "PER" "MOD" "RESP" "ACT" "A" "E" "R"';


--
-- Name: COLUMN tx_operacion.usuario; Type: COMMENT; Schema: transacciones; Owner: postgres
--

COMMENT ON COLUMN tx_operacion.usuario IS 'Usuario que realizo el cambio.';


--
-- Name: COLUMN tx_operacion.estacion; Type: COMMENT; Schema: transacciones; Owner: postgres
--

COMMENT ON COLUMN tx_operacion.estacion IS 'Estacion donde se realizo el cambio.';


--
-- Name: tx_reporte_log; Type: TABLE; Schema: transacciones; Owner: postgres; Tablespace: 
--

CREATE TABLE tx_reporte_log (
    id_reporte_log numeric(15,0) NOT NULL,
    id_usuario numeric(15,0),
    nombre_reporte character varying(100),
    id_caso numeric(15,0),
    fecha timestamp without time zone,
    estacion character varying(15)
);


ALTER TABLE tx_reporte_log OWNER TO postgres;

--
-- Name: tx_tramite_log; Type: TABLE; Schema: transacciones; Owner: postgres; Tablespace: 
--

CREATE TABLE tx_tramite_log (
    id_tramite_log numeric(15,0) NOT NULL,
    id_tramite numeric(15,0),
    id_tramite_anterior numeric,
    tipo_operacion character varying(40),
    tx_usuario character varying(15),
    tx_fecha timestamp without time zone NOT NULL,
    tx_estado numeric(10,0),
    tx_estacion character varying(40)
);


ALTER TABLE tx_tramite_log OWNER TO postgres;

--
-- Name: tx_transaccion; Type: TABLE; Schema: transacciones; Owner: postgres; Tablespace: 
--

CREATE TABLE tx_transaccion (
    tx_id numeric(15,0) NOT NULL,
    tx_fecha timestamp without time zone,
    usuario character varying(15),
    estacion character varying(15)
);


ALTER TABLE tx_transaccion OWNER TO postgres;

--
-- Name: COLUMN tx_transaccion.tx_id; Type: COMMENT; Schema: transacciones; Owner: postgres
--

COMMENT ON COLUMN tx_transaccion.tx_id IS 'Identificador de la tabla.';


--
-- Name: COLUMN tx_transaccion.tx_fecha; Type: COMMENT; Schema: transacciones; Owner: postgres
--

COMMENT ON COLUMN tx_transaccion.tx_fecha IS 'Fecha en la que se genero el registro.';


--
-- Name: COLUMN tx_transaccion.usuario; Type: COMMENT; Schema: transacciones; Owner: postgres
--

COMMENT ON COLUMN tx_transaccion.usuario IS 'Usuario que genero el registro.';


--
-- Name: COLUMN tx_transaccion.estacion; Type: COMMENT; Schema: transacciones; Owner: postgres
--

COMMENT ON COLUMN tx_transaccion.estacion IS 'Estacion desde donde se genero el registro.';


SET search_path = sujetosobligados, pg_catalog;

--
-- Name: seq_tx_documento; Type: SEQUENCE SET; Schema: sujetosobligados; Owner: postgres
--

SELECT pg_catalog.setval('seq_tx_documento', 0, false);


--
-- Name: seq_tx_documento_adjunto; Type: SEQUENCE SET; Schema: sujetosobligados; Owner: postgres
--

SELECT pg_catalog.setval('seq_tx_documento_adjunto', 0, false);


--
-- Name: seq_tx_entidad; Type: SEQUENCE SET; Schema: sujetosobligados; Owner: postgres
--

SELECT pg_catalog.setval('seq_tx_entidad', 9, true);


--
-- Name: seq_tx_entidad_actividad; Type: SEQUENCE SET; Schema: sujetosobligados; Owner: postgres
--

SELECT pg_catalog.setval('seq_tx_entidad_actividad', 0, false);


--
-- Name: seq_tx_func_usu_entidad; Type: SEQUENCE SET; Schema: sujetosobligados; Owner: postgres
--

SELECT pg_catalog.setval('seq_tx_func_usu_entidad', 0, false);


--
-- Name: seq_tx_funcionaro_caronte; Type: SEQUENCE SET; Schema: sujetosobligados; Owner: postgres
--

SELECT pg_catalog.setval('seq_tx_funcionaro_caronte', 0, false);


--
-- Name: seq_tx_persona_general; Type: SEQUENCE SET; Schema: sujetosobligados; Owner: postgres
--

SELECT pg_catalog.setval('seq_tx_persona_general', 0, false);


--
-- Name: seq_tx_remplazo_temp_fr; Type: SEQUENCE SET; Schema: sujetosobligados; Owner: postgres
--

SELECT pg_catalog.setval('seq_tx_remplazo_temp_fr', 0, false);


--
-- Name: seq_tx_seguimiento_etapa; Type: SEQUENCE SET; Schema: sujetosobligados; Owner: postgres
--

SELECT pg_catalog.setval('seq_tx_seguimiento_etapa', 0, false);


--
-- Name: seq_tx_tramite; Type: SEQUENCE SET; Schema: sujetosobligados; Owner: postgres
--

SELECT pg_catalog.setval('seq_tx_tramite', 0, false);


--
-- Data for Name: tx_documento; Type: TABLE DATA; Schema: sujetosobligados; Owner: postgres
--

COPY tx_documento (id_documento, id_funcionario_caronte, id_entidad, id_tramite, numero_documento, fecha_documento, cod_tipo_documento, cod_etapa_tramite, cod_estado_renovacion, observaciones, tx_id, tx_usuario, tx_fecha, tx_estado) FROM stdin;
\.


--
-- Data for Name: tx_documento_adjunto; Type: TABLE DATA; Schema: sujetosobligados; Owner: postgres
--

COPY tx_documento_adjunto (id_documento_adjunto, id_documento, nombre_archivo, tipo_archivo, ruta_archivo, descripcion, tx_id, tx_usuario, tx_fecha, tx_estado) FROM stdin;
\.


--
-- Data for Name: tx_entidad; Type: TABLE DATA; Schema: sujetosobligados; Owner: postgres
--

COPY tx_entidad (id_entidad, id_persona_general, nombre, nit, sigla, direccion, telefono, correo, zona, cod_tipo_entidad, cod_tipo_empresa, cod_estado_entidad, cod_pais, cod_departamento, cod_provincia, cod_municipio, cod_localidad, observaciones, tx_id, tx_usuario, tx_fecha, tx_estado) FROM stdin;
5	1	DSEYY	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	859143	1	2018-04-04 18:52:13.161	REG
9	1	LIZ	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	859134	1	2018-04-05 15:46:48.078	REG
\.


--
-- Data for Name: tx_entidad_actividad; Type: TABLE DATA; Schema: sujetosobligados; Owner: postgres
--

COPY tx_entidad_actividad (id_entidad_actividad, id_entidad, cod_actividad, tx_id, tx_usuario, tx_fecha, tx_estado) FROM stdin;
\.


--
-- Data for Name: tx_func_usu_entidad; Type: TABLE DATA; Schema: sujetosobligados; Owner: postgres
--

COPY tx_func_usu_entidad (id_func_usu_entidad, id_funcionario_caronte, id_entidad, id_usuario, nombre_usuario, sistema_usuario, tx_id, tx_usuario, tx_fecha, tx_estado) FROM stdin;
\.


--
-- Data for Name: tx_funcionario_caronte; Type: TABLE DATA; Schema: sujetosobligados; Owner: postgres
--

COPY tx_funcionario_caronte (id_funcionario_caronte, id_entidad, id_persona_general, cod_tipo_funcionario, cargo, observaciones, motivo_estado, tx_id, tx_usuario, tx_fecha, tx_estado) FROM stdin;
\.


--
-- Data for Name: tx_persona_general; Type: TABLE DATA; Schema: sujetosobligados; Owner: postgres
--

COPY tx_persona_general (id_persona_general, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, apellido_casada, cod_genero, fecha_nacimiento, numero_documento, complemento, cod_tipo_documento, cod_expedido, cod_tipo_persona, direccion, tx_id, tx_usuario, tx_fecha, tx_estado) FROM stdin;
\.


--
-- Data for Name: tx_remplazo_temp_fr; Type: TABLE DATA; Schema: sujetosobligados; Owner: postgres
--

COPY tx_remplazo_temp_fr (id_remplazo_temporal_fr, id_funcionario_caronte, id_funcionario_remplazo, fecha_inicio_remplazo, fecha_fin_remplazo, tx_id, tx_usuario, tx_fecha, tx_estado) FROM stdin;
\.


--
-- Data for Name: tx_seguimiento_etapa; Type: TABLE DATA; Schema: sujetosobligados; Owner: postgres
--

COPY tx_seguimiento_etapa (id_seguimiento_etapa, id_tramite, cod_etapa_tramite, cod_ubicacion_tramite, descripcion, fecha, nombre_usuario, observaciones, tx_id, tx_usuario, tx_fecha, tx_estado) FROM stdin;
\.


--
-- Data for Name: tx_tramite; Type: TABLE DATA; Schema: sujetosobligados; Owner: postgres
--

COPY tx_tramite (id_tramite, id_entidad, id_funcionario_caronte, id_tramite_anterior, id_analista_legal, id_jefe_area_legal, numero_tramite, cod_tipo_funcionario, cod_etapa_tramite, cod_origen_tramite, cod_tipo_tramite, nro_informe_irc, nro_tramite_sicod, gestion, motivo_baja, codigo_validacion, codigo, fecha_creacion, fecha_ini_cert, fecha_fin_cert, id_usuario_creacion, observaciones, tx_id, tx_usuario, tx_fecha, tx_estado) FROM stdin;
\.


SET search_path = transacciones, pg_catalog;

--
-- Name: seq_tx_access_log; Type: SEQUENCE SET; Schema: transacciones; Owner: postgres
--

SELECT pg_catalog.setval('seq_tx_access_log', 114181, false);


--
-- Name: seq_tx_error_log; Type: SEQUENCE SET; Schema: transacciones; Owner: postgres
--

SELECT pg_catalog.setval('seq_tx_error_log', 2454, false);


--
-- Name: seq_tx_log_tramite_reporte; Type: SEQUENCE SET; Schema: transacciones; Owner: postgres
--

SELECT pg_catalog.setval('seq_tx_log_tramite_reporte', 111, false);


--
-- Name: seq_tx_operacion; Type: SEQUENCE SET; Schema: transacciones; Owner: postgres
--

SELECT pg_catalog.setval('seq_tx_operacion', 219643, false);


--
-- Name: seq_tx_reporte_log; Type: SEQUENCE SET; Schema: transacciones; Owner: postgres
--

SELECT pg_catalog.setval('seq_tx_reporte_log', 164, false);


--
-- Name: seq_tx_tramite_log; Type: SEQUENCE SET; Schema: transacciones; Owner: postgres
--

SELECT pg_catalog.setval('seq_tx_tramite_log', 55, false);


--
-- Name: seq_tx_transaccion; Type: SEQUENCE SET; Schema: transacciones; Owner: postgres
--

SELECT pg_catalog.setval('seq_tx_transaccion', 859134, true);


--
-- Data for Name: tx_access_log; Type: TABLE DATA; Schema: transacciones; Owner: postgres
--

COPY tx_access_log (id_access_log, parametros, pagina, tx_usuario, tx_fecha, tx_estacion) FROM stdin;
\.


--
-- Data for Name: tx_error_log; Type: TABLE DATA; Schema: transacciones; Owner: postgres
--

COPY tx_error_log (id_error_log, tipo_error, mensaje, clase, metodo, linea, observaciones, tx_usuario, tx_fecha, tx_estacion) FROM stdin;
\.


--
-- Data for Name: tx_log_tramite_reporte; Type: TABLE DATA; Schema: transacciones; Owner: postgres
--

COPY tx_log_tramite_reporte (id_log_tramite_reporte, id_tramite, impresion, tx_id, tx_usuario, tx_fecha, tx_estado, tx_estacion) FROM stdin;
\.


--
-- Data for Name: tx_operacion; Type: TABLE DATA; Schema: transacciones; Owner: postgres
--

COPY tx_operacion (id_operacion, tx_id, cod_operacion, fecha, tx_estado, usuario, estacion) FROM stdin;
219682	859134	CRE	2018-04-05 15:46:48.078	REG	1	SDS
\.


--
-- Data for Name: tx_reporte_log; Type: TABLE DATA; Schema: transacciones; Owner: postgres
--

COPY tx_reporte_log (id_reporte_log, id_usuario, nombre_reporte, id_caso, fecha, estacion) FROM stdin;
\.


--
-- Data for Name: tx_tramite_log; Type: TABLE DATA; Schema: transacciones; Owner: postgres
--

COPY tx_tramite_log (id_tramite_log, id_tramite, id_tramite_anterior, tipo_operacion, tx_usuario, tx_fecha, tx_estado, tx_estacion) FROM stdin;
\.


--
-- Data for Name: tx_transaccion; Type: TABLE DATA; Schema: transacciones; Owner: postgres
--

COPY tx_transaccion (tx_id, tx_fecha, usuario, estacion) FROM stdin;
859134	2018-04-05 15:46:47.917	1	SDS
\.


SET search_path = sujetosobligados, pg_catalog;

--
-- Name: pk_tx_documento; Type: CONSTRAINT; Schema: sujetosobligados; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tx_documento
    ADD CONSTRAINT pk_tx_documento PRIMARY KEY (id_documento);


--
-- Name: pk_tx_documento_adjunto; Type: CONSTRAINT; Schema: sujetosobligados; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tx_documento_adjunto
    ADD CONSTRAINT pk_tx_documento_adjunto PRIMARY KEY (id_documento_adjunto);


--
-- Name: pk_tx_entidad; Type: CONSTRAINT; Schema: sujetosobligados; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tx_entidad
    ADD CONSTRAINT pk_tx_entidad PRIMARY KEY (id_entidad);


--
-- Name: pk_tx_entidad_actividad; Type: CONSTRAINT; Schema: sujetosobligados; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tx_entidad_actividad
    ADD CONSTRAINT pk_tx_entidad_actividad PRIMARY KEY (id_entidad_actividad);


--
-- Name: pk_tx_func_usu_entidad; Type: CONSTRAINT; Schema: sujetosobligados; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tx_func_usu_entidad
    ADD CONSTRAINT pk_tx_func_usu_entidad PRIMARY KEY (id_func_usu_entidad);


--
-- Name: pk_tx_funcionario_caronte; Type: CONSTRAINT; Schema: sujetosobligados; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tx_funcionario_caronte
    ADD CONSTRAINT pk_tx_funcionario_caronte PRIMARY KEY (id_funcionario_caronte);


--
-- Name: pk_tx_persona_general; Type: CONSTRAINT; Schema: sujetosobligados; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tx_persona_general
    ADD CONSTRAINT pk_tx_persona_general PRIMARY KEY (id_persona_general);


--
-- Name: pk_tx_remplazo_temp_fr; Type: CONSTRAINT; Schema: sujetosobligados; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tx_remplazo_temp_fr
    ADD CONSTRAINT pk_tx_remplazo_temp_fr PRIMARY KEY (id_remplazo_temporal_fr);


--
-- Name: pk_tx_seguimiento_etapa; Type: CONSTRAINT; Schema: sujetosobligados; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tx_seguimiento_etapa
    ADD CONSTRAINT pk_tx_seguimiento_etapa PRIMARY KEY (id_seguimiento_etapa);


--
-- Name: pk_tx_tramite; Type: CONSTRAINT; Schema: sujetosobligados; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tx_tramite
    ADD CONSTRAINT pk_tx_tramite PRIMARY KEY (id_tramite);


SET search_path = transacciones, pg_catalog;

--
-- Name: pk_id_access_log; Type: CONSTRAINT; Schema: transacciones; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tx_access_log
    ADD CONSTRAINT pk_id_access_log PRIMARY KEY (id_access_log);


--
-- Name: pk_id_error_log; Type: CONSTRAINT; Schema: transacciones; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tx_error_log
    ADD CONSTRAINT pk_id_error_log PRIMARY KEY (id_error_log);


--
-- Name: pk_id_log_tramite_reporte; Type: CONSTRAINT; Schema: transacciones; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tx_log_tramite_reporte
    ADD CONSTRAINT pk_id_log_tramite_reporte PRIMARY KEY (id_log_tramite_reporte);


--
-- Name: pk_id_operacion; Type: CONSTRAINT; Schema: transacciones; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tx_operacion
    ADD CONSTRAINT pk_id_operacion PRIMARY KEY (id_operacion);


--
-- Name: pk_id_reporte_log; Type: CONSTRAINT; Schema: transacciones; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tx_reporte_log
    ADD CONSTRAINT pk_id_reporte_log PRIMARY KEY (id_reporte_log);


--
-- Name: pk_id_tramite_log; Type: CONSTRAINT; Schema: transacciones; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tx_tramite_log
    ADD CONSTRAINT pk_id_tramite_log PRIMARY KEY (id_tramite_log);


--
-- Name: tx_transaccion_pkey; Type: CONSTRAINT; Schema: transacciones; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tx_transaccion
    ADD CONSTRAINT tx_transaccion_pkey PRIMARY KEY (tx_id);


SET search_path = sujetosobligados, pg_catalog;

--
-- Name: idx_tx_entidad_cod_tipo_entidad; Type: INDEX; Schema: sujetosobligados; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX idx_tx_entidad_cod_tipo_entidad ON tx_entidad USING btree (cod_tipo_entidad);


--
-- Name: tx_documento_tx_documento_adjunto; Type: FK CONSTRAINT; Schema: sujetosobligados; Owner: postgres
--

ALTER TABLE ONLY tx_documento_adjunto
    ADD CONSTRAINT tx_documento_tx_documento_adjunto FOREIGN KEY (id_documento) REFERENCES tx_documento(id_documento);


--
-- Name: tx_entidad_tx_documento; Type: FK CONSTRAINT; Schema: sujetosobligados; Owner: postgres
--

ALTER TABLE ONLY tx_documento
    ADD CONSTRAINT tx_entidad_tx_documento FOREIGN KEY (id_entidad) REFERENCES tx_entidad(id_entidad);


--
-- Name: tx_entidad_tx_entidad_actividad; Type: FK CONSTRAINT; Schema: sujetosobligados; Owner: postgres
--

ALTER TABLE ONLY tx_entidad_actividad
    ADD CONSTRAINT tx_entidad_tx_entidad_actividad FOREIGN KEY (id_entidad) REFERENCES tx_entidad(id_entidad);


--
-- Name: tx_entidad_tx_funcionario_caronte; Type: FK CONSTRAINT; Schema: sujetosobligados; Owner: postgres
--

ALTER TABLE ONLY tx_funcionario_caronte
    ADD CONSTRAINT tx_entidad_tx_funcionario_caronte FOREIGN KEY (id_entidad) REFERENCES tx_entidad(id_entidad);


--
-- Name: tx_entidad_tx_tramite; Type: FK CONSTRAINT; Schema: sujetosobligados; Owner: postgres
--

ALTER TABLE ONLY tx_tramite
    ADD CONSTRAINT tx_entidad_tx_tramite FOREIGN KEY (id_entidad) REFERENCES tx_entidad(id_entidad);


--
-- Name: tx_funcionario_caronte_tx_documento; Type: FK CONSTRAINT; Schema: sujetosobligados; Owner: postgres
--

ALTER TABLE ONLY tx_documento
    ADD CONSTRAINT tx_funcionario_caronte_tx_documento FOREIGN KEY (id_funcionario_caronte) REFERENCES tx_funcionario_caronte(id_funcionario_caronte);


--
-- Name: tx_funcionario_caronte_tx_func_usu_entidad; Type: FK CONSTRAINT; Schema: sujetosobligados; Owner: postgres
--

ALTER TABLE ONLY tx_func_usu_entidad
    ADD CONSTRAINT tx_funcionario_caronte_tx_func_usu_entidad FOREIGN KEY (id_funcionario_caronte) REFERENCES tx_funcionario_caronte(id_funcionario_caronte);


--
-- Name: tx_funcionario_caronte_tx_remplazo_temp_fr; Type: FK CONSTRAINT; Schema: sujetosobligados; Owner: postgres
--

ALTER TABLE ONLY tx_remplazo_temp_fr
    ADD CONSTRAINT tx_funcionario_caronte_tx_remplazo_temp_fr FOREIGN KEY (id_funcionario_caronte) REFERENCES tx_funcionario_caronte(id_funcionario_caronte);


--
-- Name: tx_funcionario_caronte_tx_tramite; Type: FK CONSTRAINT; Schema: sujetosobligados; Owner: postgres
--

ALTER TABLE ONLY tx_tramite
    ADD CONSTRAINT tx_funcionario_caronte_tx_tramite FOREIGN KEY (id_funcionario_caronte) REFERENCES tx_funcionario_caronte(id_funcionario_caronte);


--
-- Name: tx_tramite_tx_seguimiento_etapas; Type: FK CONSTRAINT; Schema: sujetosobligados; Owner: postgres
--

ALTER TABLE ONLY tx_seguimiento_etapa
    ADD CONSTRAINT tx_tramite_tx_seguimiento_etapas FOREIGN KEY (id_tramite) REFERENCES tx_tramite(id_tramite);


SET search_path = transacciones, pg_catalog;

--
-- Name: tx_transaccion_tx_operacion; Type: FK CONSTRAINT; Schema: transacciones; Owner: postgres
--

ALTER TABLE ONLY tx_operacion
    ADD CONSTRAINT tx_transaccion_tx_operacion FOREIGN KEY (tx_id) REFERENCES tx_transaccion(tx_id);


--
-- PostgreSQL database dump complete
--

