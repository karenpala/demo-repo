--
-- PostgreSQL database dump
--

-- Dumped from database version 13.5
-- Dumped by pg_dump version 13.5

-- Started on 2022-11-17 21:42:39

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 14 (class 2615 OID 70282)
-- Name: system; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA system;


--
-- TOC entry 282 (class 1255 OID 70430)
-- Name: fn_sysassign_adr(); Type: FUNCTION; Schema: system; Owner: -
--

CREATE FUNCTION system.fn_sysassign_adr() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    var_new_state varchar(32);
    var_old_state varchar(32);
    var_error varchar(128);
    var_count integer;
    
BEGIN
--BUSINESS RULES HOME-----------------------------------

--BUSINESS RULES END------------------------------------
    RETURN OLD;
END;
$$;


--
-- TOC entry 287 (class 1255 OID 70431)
-- Name: fn_sysassign_air(); Type: FUNCTION; Schema: system; Owner: -
--

CREATE FUNCTION system.fn_sysassign_air() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    var_new_transac varchar(32);
    var_error varchar(128);
    var_count integer;
    
BEGIN
--BUSINESS RULES HOME-----------------------------------

--BUSINESS RULES END------------------------------------
    return new;
END;
$$;


--
-- TOC entry 288 (class 1255 OID 70432)
-- Name: fn_sysassign_aur(); Type: FUNCTION; Schema: system; Owner: -
--

CREATE FUNCTION system.fn_sysassign_aur() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    var_new_state varchar(32);
    var_old_state varchar(32);
    var_new_transac varchar(32);
    var_error varchar(128);
    var_count integer;
    
BEGIN
--BUSINESS RULES HOME-----------------------------------

--BUSINESS RULES END------------------------------------
    RETURN NEW;
END;
$$;


--
-- TOC entry 440 (class 1255 OID 70433)
-- Name: fn_sysassign_bdr(); Type: FUNCTION; Schema: system; Owner: -
--

CREATE FUNCTION system.fn_sysassign_bdr() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    var_new_state varchar(32);
    var_old_state varchar(32);
    var_error varchar(128);
    var_count integer;
     
BEGIN
    ---------------------------------------------------------------------------------------
    var_old_state := old.br_state;
    SELECT br_stateend INTO var_new_state FROM system.transition 
    WHERE br_table = 'system.sys_assign'
    AND br_statehome = var_old_state AND br_stateend = 'FINAL' AND br_sentence = 'DELETE';
    
    IF (var_new_state is null) THEN
        var_error := '##ERR-BR: Delete is not available in the state: '||var_old_state||' -> sysassign##';
        RAISE EXCEPTION '%',var_error; 
    END IF;
--BUSINESS RULES HOME-----------------------------------

--BUSINESS RULES END------------------------------------
    RETURN OLD;
END;
$$;


--
-- TOC entry 441 (class 1255 OID 70434)
-- Name: fn_sysassign_bir(); Type: FUNCTION; Schema: system; Owner: -
--

CREATE FUNCTION system.fn_sysassign_bir() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    var_new_state varchar(32);
    var_new_transac varchar(32);
    var_error varchar(128);
    var_count integer;
    
BEGIN
    --------------------------------------------------------------------------------------------------
    IF (new.br_transac is null) THEN
         RAISE EXCEPTION '##ERR-BR: The value of the transaction can not be null -> sysassign##';
    ELSE
    	var_new_transac := new.br_transac;
    END IF;
    -------------------------------------------------------
    SELECT br_stateend into var_new_state 
    FROM system.transition WHERE br_table = 'system.sys_assign'
    AND br_statehome = 'INICIAL' AND br_transaction = var_new_transac AND br_sentence = 'INSERT';
    
    IF (var_new_state is null) THEN
    	var_error := '##ERR-BR: Transaction: ' || var_new_transac ||' Not found -> sysassign##';
        RAISE EXCEPTION '%',var_error;   
    END IF;
--BUSINESS RULES HOME-----------------------------------

--BUSINESS RULES END------------------------------------
    new.br_state := var_new_state;
    new.br_createdby := current_user;
    new.br_updatedby := current_user;
    new.br_createdat := current_timestamp;                                                             
    new.br_updatedat := current_timestamp;  
    RETURN NEW;    
END;
$$;


--
-- TOC entry 442 (class 1255 OID 70435)
-- Name: fn_sysassign_bur(); Type: FUNCTION; Schema: system; Owner: -
--

CREATE FUNCTION system.fn_sysassign_bur() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    var_new_state varchar(32);
    var_old_state varchar(32);
    var_new_transac varchar(32);
    var_error varchar(128);
    var_count integer;
    
BEGIN
    ------------------------------------------------------------------------  
    IF (new.br_transac is null) THEN
        var_error := '##ERR-BR: The value of the transaction can not be null -> sysassign##';
        RAISE EXCEPTION '%',var_error; 
    ELSE
    	var_old_state := old.br_state;
    	var_new_transac := new.br_transac;	
    END IF; 
    -----------------------------------------------------------------------
    SELECT br_stateend INTO var_new_state FROM system.transition  
    WHERE br_table = 'system.sys_assign'
    AND br_statehome = var_old_state AND br_transaction = var_new_transac AND br_sentence = 'UPDATE';
    
    IF (var_new_state is null) THEN
        var_error := '##ERR-BR: State end of transaction : '||var_new_transac||' not found -> sysassign##';
        RAISE EXCEPTION '%',var_error;
    END IF;
--BUSINESS RULES HOME-----------------------------------

--BUSINESS RULES END------------------------------------
    new.br_state := var_new_state;
    new.br_updatedby := current_user;
    new.br_updatedat := current_timestamp;
    RETURN NEW;
END
$$;


--
-- TOC entry 443 (class 1255 OID 70436)
-- Name: fn_sysmodule_adr(); Type: FUNCTION; Schema: system; Owner: -
--

CREATE FUNCTION system.fn_sysmodule_adr() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    var_new_state varchar(32);
    var_old_state varchar(32);
    var_error varchar(128);
    var_count integer;
    
BEGIN
--BUSINESS RULES HOME-----------------------------------

--BUSINESS RULES END------------------------------------
    RETURN OLD;
END;
$$;


--
-- TOC entry 444 (class 1255 OID 70437)
-- Name: fn_sysmodule_air(); Type: FUNCTION; Schema: system; Owner: -
--

CREATE FUNCTION system.fn_sysmodule_air() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    var_new_transac varchar(32);
    var_error varchar(128);
    var_count integer;
    
BEGIN
--BUSINESS RULES HOME-----------------------------------

--BUSINESS RULES END------------------------------------
    return new;
END;
$$;


--
-- TOC entry 445 (class 1255 OID 70438)
-- Name: fn_sysmodule_aur(); Type: FUNCTION; Schema: system; Owner: -
--

CREATE FUNCTION system.fn_sysmodule_aur() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    var_new_state varchar(32);
    var_old_state varchar(32);
    var_new_transac varchar(32);
    var_error varchar(128);
    var_count integer;
    
BEGIN
--BUSINESS RULES HOME-----------------------------------

--BUSINESS RULES END------------------------------------
    RETURN NEW;
END;
$$;


--
-- TOC entry 446 (class 1255 OID 70439)
-- Name: fn_sysmodule_bdr(); Type: FUNCTION; Schema: system; Owner: -
--

CREATE FUNCTION system.fn_sysmodule_bdr() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    var_new_state varchar(32);
    var_old_state varchar(32);
    var_error varchar(128);
    var_count integer;
     
BEGIN
    ---------------------------------------------------------------------------------------
    var_old_state := old.br_state;
    SELECT br_stateend INTO var_new_state FROM system.transition 
    WHERE br_table = 'system.sys_module'
    AND br_statehome = var_old_state AND br_stateend = 'FINAL' AND br_sentence = 'DELETE';
    
    IF (var_new_state is null) THEN
        var_error := '##ERR-BR: Delete is not available in the state: '||var_old_state||' -> sysmodule##';
        RAISE EXCEPTION '%',var_error; 
    END IF;
--BUSINESS RULES HOME-----------------------------------

--BUSINESS RULES END------------------------------------
    RETURN OLD;
END;
$$;


--
-- TOC entry 447 (class 1255 OID 70440)
-- Name: fn_sysmodule_bir(); Type: FUNCTION; Schema: system; Owner: -
--

CREATE FUNCTION system.fn_sysmodule_bir() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    var_new_state varchar(32);
    var_new_transac varchar(32);
    var_error varchar(128);
    var_count integer;
    
BEGIN
    --------------------------------------------------------------------------------------------------
    IF (new.br_transac is null) THEN
         RAISE EXCEPTION '##ERR-BR: The value of the transaction can not be null -> sysmodule##';
    ELSE
    	var_new_transac := new.br_transac;
    END IF;
    -------------------------------------------------------
    SELECT br_stateend into var_new_state 
    FROM system.transition WHERE br_table = 'system.sys_module'
    AND br_statehome = 'INICIAL' AND br_transaction = var_new_transac AND br_sentence = 'INSERT';
    
    IF (var_new_state is null) THEN
    	var_error := '##ERR-BR: Transaction: ' || var_new_transac ||' Not found -> sysmodule##';
        RAISE EXCEPTION '%',var_error;   
    END IF;
--BUSINESS RULES HOME-----------------------------------

--BUSINESS RULES END------------------------------------
    new.br_state := var_new_state;
    new.br_createdby := current_user;
    new.br_updatedby := current_user;
    new.br_createdat := current_timestamp;                                                             
    new.br_updatedat := current_timestamp;  
    RETURN NEW;    
END;
$$;


--
-- TOC entry 448 (class 1255 OID 70441)
-- Name: fn_sysmodule_bur(); Type: FUNCTION; Schema: system; Owner: -
--

CREATE FUNCTION system.fn_sysmodule_bur() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    var_new_state varchar(32);
    var_old_state varchar(32);
    var_new_transac varchar(32);
    var_error varchar(128);
    var_count integer;
    
BEGIN
    ------------------------------------------------------------------------  
    IF (new.br_transac is null) THEN
        var_error := '##ERR-BR: The value of the transaction can not be null -> sysmodule##';
        RAISE EXCEPTION '%',var_error; 
    ELSE
    	var_old_state := old.br_state;
    	var_new_transac := new.br_transac;	
    END IF; 
    -----------------------------------------------------------------------
    SELECT br_stateend INTO var_new_state FROM system.transition  
    WHERE br_table = 'system.sys_module'
    AND br_statehome = var_old_state AND br_transaction = var_new_transac AND br_sentence = 'UPDATE';
    
    IF (var_new_state is null) THEN
        var_error := '##ERR-BR: State end of transaction : '||var_new_transac||' not found -> sysmodule##';
        RAISE EXCEPTION '%',var_error;
    END IF;
--BUSINESS RULES HOME-----------------------------------

--BUSINESS RULES END------------------------------------
    new.br_state := var_new_state;
    new.br_updatedby := current_user;
    new.br_updatedat := current_timestamp;
    RETURN NEW;
END
$$;


--
-- TOC entry 449 (class 1255 OID 70442)
-- Name: fn_sysrole_adr(); Type: FUNCTION; Schema: system; Owner: -
--

CREATE FUNCTION system.fn_sysrole_adr() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    var_new_state varchar(32);
    var_old_state varchar(32);
    var_error varchar(128);
    var_count integer;
    
BEGIN
--BUSINESS RULES HOME-----------------------------------

--BUSINESS RULES END------------------------------------
    RETURN OLD;
END;
$$;


--
-- TOC entry 450 (class 1255 OID 70443)
-- Name: fn_sysrole_air(); Type: FUNCTION; Schema: system; Owner: -
--

CREATE FUNCTION system.fn_sysrole_air() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    var_new_transac varchar(32);
    var_error varchar(128);
    var_count integer;
    
BEGIN
--BUSINESS RULES HOME-----------------------------------

--BUSINESS RULES END------------------------------------
    return new;
END;
$$;


--
-- TOC entry 451 (class 1255 OID 70444)
-- Name: fn_sysrole_aur(); Type: FUNCTION; Schema: system; Owner: -
--

CREATE FUNCTION system.fn_sysrole_aur() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    var_new_state varchar(32);
    var_old_state varchar(32);
    var_new_transac varchar(32);
    var_error varchar(128);
    var_count integer;
    
BEGIN
--BUSINESS RULES HOME-----------------------------------

--BUSINESS RULES END------------------------------------
    RETURN NEW;
END;
$$;


--
-- TOC entry 452 (class 1255 OID 70445)
-- Name: fn_sysrole_bdr(); Type: FUNCTION; Schema: system; Owner: -
--

CREATE FUNCTION system.fn_sysrole_bdr() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    var_new_state varchar(32);
    var_old_state varchar(32);
    var_error varchar(128);
    var_count integer;
     
BEGIN
    ---------------------------------------------------------------------------------------
    var_old_state := old.br_state;
    SELECT br_stateend INTO var_new_state FROM system.transition 
    WHERE br_table = 'system.sys_role'
    AND br_statehome = var_old_state AND br_stateend = 'FINAL' AND br_sentence = 'DELETE';
    
    IF (var_new_state is null) THEN
        var_error := '##ERR-BR: Delete is not available in the state: '||var_old_state||' -> sysrole##';
        RAISE EXCEPTION '%',var_error; 
    END IF;
--BUSINESS RULES HOME-----------------------------------

--BUSINESS RULES END------------------------------------
    RETURN OLD;
END;
$$;


--
-- TOC entry 453 (class 1255 OID 70446)
-- Name: fn_sysrole_bir(); Type: FUNCTION; Schema: system; Owner: -
--

CREATE FUNCTION system.fn_sysrole_bir() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    var_new_state varchar(32);
    var_new_transac varchar(32);
    var_error varchar(128);
    var_count integer;
    
BEGIN
    --------------------------------------------------------------------------------------------------
    IF (new.br_transac is null) THEN
         RAISE EXCEPTION '##ERR-BR: The value of the transaction can not be null -> sysrole##';
    ELSE
    	var_new_transac := new.br_transac;
    END IF;
    -------------------------------------------------------
    SELECT br_stateend into var_new_state 
    FROM system.transition WHERE br_table = 'system.sys_role'
    AND br_statehome = 'INICIAL' AND br_transaction = var_new_transac AND br_sentence = 'INSERT';
    
    IF (var_new_state is null) THEN
    	var_error := '##ERR-BR: Transaction: ' || var_new_transac ||' Not found -> sysrole##';
        RAISE EXCEPTION '%',var_error;   
    END IF;
--BUSINESS RULES HOME-----------------------------------

--BUSINESS RULES END------------------------------------
    new.br_state := var_new_state;
    new.br_createdby := current_user;
    new.br_updatedby := current_user;
    new.br_createdat := current_timestamp;                                                             
    new.br_updatedat := current_timestamp;  
    RETURN NEW;    
END;
$$;


--
-- TOC entry 454 (class 1255 OID 70447)
-- Name: fn_sysrole_bur(); Type: FUNCTION; Schema: system; Owner: -
--

CREATE FUNCTION system.fn_sysrole_bur() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    var_new_state varchar(32);
    var_old_state varchar(32);
    var_new_transac varchar(32);
    var_error varchar(128);
    var_count integer;
    
BEGIN
    ------------------------------------------------------------------------  
    IF (new.br_transac is null) THEN
        var_error := '##ERR-BR: The value of the transaction can not be null -> sysrole##';
        RAISE EXCEPTION '%',var_error; 
    ELSE
    	var_old_state := old.br_state;
    	var_new_transac := new.br_transac;	
    END IF; 
    -----------------------------------------------------------------------
    SELECT br_stateend INTO var_new_state FROM system.transition  
    WHERE br_table = 'system.sys_role'
    AND br_statehome = var_old_state AND br_transaction = var_new_transac AND br_sentence = 'UPDATE';
    
    IF (var_new_state is null) THEN
        var_error := '##ERR-BR: State end of transaction : '||var_new_transac||' not found -> sysrole##';
        RAISE EXCEPTION '%',var_error;
    END IF;
--BUSINESS RULES HOME-----------------------------------

--BUSINESS RULES END------------------------------------
    new.br_state := var_new_state;
    new.br_updatedby := current_user;
    new.br_updatedat := current_timestamp;
    RETURN NEW;
END
$$;


--
-- TOC entry 455 (class 1255 OID 70448)
-- Name: fn_sysuser_adr(); Type: FUNCTION; Schema: system; Owner: -
--

CREATE FUNCTION system.fn_sysuser_adr() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    var_new_state varchar(32);
    var_old_state varchar(32);
    var_error varchar(128);
    var_count integer;
    
BEGIN
--BUSINESS RULES HOME-----------------------------------

--BUSINESS RULES END------------------------------------
    RETURN OLD;
END;
$$;


--
-- TOC entry 456 (class 1255 OID 70449)
-- Name: fn_sysuser_air(); Type: FUNCTION; Schema: system; Owner: -
--

CREATE FUNCTION system.fn_sysuser_air() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    var_new_transac varchar(32);
    var_error varchar(128);
    var_count integer;
    
BEGIN
--BUSINESS RULES HOME-----------------------------------

--BUSINESS RULES END------------------------------------
    return new;
END;
$$;


--
-- TOC entry 457 (class 1255 OID 70450)
-- Name: fn_sysuser_aur(); Type: FUNCTION; Schema: system; Owner: -
--

CREATE FUNCTION system.fn_sysuser_aur() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    var_new_state varchar(32);
    var_old_state varchar(32);
    var_new_transac varchar(32);
    var_error varchar(128);
    var_count integer;
    
BEGIN
--BUSINESS RULES HOME-----------------------------------

--BUSINESS RULES END------------------------------------
    RETURN NEW;
END;
$$;


--
-- TOC entry 458 (class 1255 OID 70451)
-- Name: fn_sysuser_bdr(); Type: FUNCTION; Schema: system; Owner: -
--

CREATE FUNCTION system.fn_sysuser_bdr() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    var_new_state varchar(32);
    var_old_state varchar(32);
    var_error varchar(128);
    var_count integer;
     
BEGIN
    ---------------------------------------------------------------------------------------
    var_old_state := old.br_state;
    SELECT br_stateend INTO var_new_state FROM system.transition 
    WHERE br_table = 'system.sys_user'
    AND br_statehome = var_old_state AND br_stateend = 'FINAL' AND br_sentence = 'DELETE';
    
    IF (var_new_state is null) THEN
        var_error := '##ERR-BR: Delete is not available in the state: '||var_old_state||' -> sysuser##';
        RAISE EXCEPTION '%',var_error; 
    END IF;
--BUSINESS RULES HOME-----------------------------------
IF (old.br_state='REGISTRADO') THEN
	-- 1.validar eliminacion -----
	if (old.id = 1 or old.id = 2) then
        RAISE EXCEPTION '##No es posible eliminar al Usuario##';
    end if;
END IF;
--BUSINESS RULES END------------------------------------
    RETURN OLD;
END;
$$;


--
-- TOC entry 459 (class 1255 OID 70452)
-- Name: fn_sysuser_bir(); Type: FUNCTION; Schema: system; Owner: -
--

CREATE FUNCTION system.fn_sysuser_bir() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    var_new_state varchar(32);
    var_new_transac varchar(32);
    var_error varchar(128);
    var_count integer;
    
BEGIN
    --------------------------------------------------------------------------------------------------
    IF (new.br_transac is null) THEN
         RAISE EXCEPTION '##ERR-BR: The value of the transaction can not be null -> sysuser##';
    ELSE
    	var_new_transac := new.br_transac;
    END IF;
    -------------------------------------------------------
    SELECT br_stateend into var_new_state 
    FROM system.transition WHERE br_table = 'system.sys_user'
    AND br_statehome = 'INICIAL' AND br_transaction = var_new_transac AND br_sentence = 'INSERT';
    
    IF (var_new_state is null) THEN
    	var_error := '##ERR-BR: Transaction: ' || var_new_transac ||' Not found -> sysuser##';
        RAISE EXCEPTION '%',var_error;   
    END IF;
--BUSINESS RULES HOME-----------------------------------
IF (new.br_transac='CREAR') THEN
	-- 1.validar datos -----
	select count(*) into var_count from system.sys_user 
    where username = new.username;
    if (var_count <> 0) then                     
        var_error := '##Ya existe el dato username: '||new.username||' registrado en la tabla USUARIO, intente con otro dato##';
        RAISE EXCEPTION 'Mensaje: %', var_error;      
    end if;
    select count(*) into var_count from system.sys_user  
    where email = new.email;
    if (var_count <> 0) then                     
        var_error := '##Ya existe el dato correo: '||new.email||' registrado en la tabla USUARIO, intente con otro dato##';
        RAISE EXCEPTION 'Mensaje: %', var_error;      
    end if;
    --------------------------------------------------------------------------
    new.status := 10;
    if (new.photo is null) then                             
        new.photo := '/uploads/photo/default.jpg';         
    end if;
    NEW."aboutMe" = trim(new."aboutMe");
    if (new."aboutMe" is null OR new."aboutMe" = '') then
        new."aboutMe" := 'Usuario operador del Sistema';         
    end if;
END IF;
--BUSINESS RULES END------------------------------------
    new.br_state := var_new_state;
    new.br_createdby := current_user;
    new.br_updatedby := current_user;
    new.br_createdat := current_timestamp;                                                             
    new.br_updatedat := current_timestamp;  
    RETURN NEW;    
END;
$$;


--
-- TOC entry 460 (class 1255 OID 70453)
-- Name: fn_sysuser_bur(); Type: FUNCTION; Schema: system; Owner: -
--

CREATE FUNCTION system.fn_sysuser_bur() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    var_new_state varchar(32);
    var_old_state varchar(32);
    var_new_transac varchar(32);
    var_error varchar(128);
    var_count integer;
    
BEGIN
    ------------------------------------------------------------------------  
    IF (new.br_transac is null) THEN
        var_error := '##ERR-BR: The value of the transaction can not be null -> uuuuuuusysuser##';
        RAISE EXCEPTION '%',var_error; 
    ELSE
    	var_old_state := old.br_state;
    	var_new_transac := new.br_transac;	
    END IF; 
    -----------------------------------------------------------------------
   SELECT br_stateend INTO var_new_state FROM system.transition  
        WHERE br_table = 'system.sys_user'
             AND br_statehome = var_old_state AND br_transaction = var_new_transac AND br_sentence = 'UPDATE';
    
    --IF (var_new_state is null) THEN
     --   var_error := '##ERR-BR: State end of transaction : '||var_new_transac||' not found -> bbbb sysuser##';
     --   RAISE EXCEPTION '%',var_error;
   -- END IF;
--BUSINESS RULES HOME-----------------------------------
IF ((old.br_state='REGISTRADO') AND (new.br_transac='ACTUALIZAR')) THEN
	-- 1.validar -----
	select count(*) into var_count from system.sys_user 
    where username = new.username and new.username<>old.username;
    if (var_count <> 0) then                     
        var_error := '##Ya existe el dato usuario: '||new.username||' registrado en la tabla Usuarios, intente con otro dato##';
        RAISE EXCEPTION 'Mensaje: %', var_error;      
    end if;
    select count(*) into var_count from system.sys_user  
    where email = new.email and new.email<>old.email;
    if (var_count <> 0) then                     
        var_error := '##Ya existe el dato correo: '||new.email||' registrado en la tabla Usuarios, intente con otro dato##';
        RAISE EXCEPTION 'Mensaje: %', var_error;      
    end if;
END IF;
--BUSINESS RULES END------------------------------------
    new.br_state := var_new_state;
    new.br_updatedby := current_user;
    new.br_updatedat := current_timestamp;
    RETURN NEW;
END
$$;


--
-- TOC entry 275 (class 1259 OID 70824)
-- Name: seq_moduleid; Type: SEQUENCE; Schema: system; Owner: -
--

CREATE SEQUENCE system.seq_moduleid
    START WITH 14
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 276 (class 1259 OID 70826)
-- Name: seq_roleid; Type: SEQUENCE; Schema: system; Owner: -
--

CREATE SEQUENCE system.seq_roleid
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 277 (class 1259 OID 70828)
-- Name: sys_assign; Type: TABLE; Schema: system; Owner: -
--

CREATE TABLE system.sys_assign (
    role_id integer NOT NULL,
    module_id integer NOT NULL,
    br_state character varying(30) NOT NULL,
    br_transac character varying(30) NOT NULL,
    br_createdby character varying(30) NOT NULL,
    br_createdat timestamp(6) without time zone NOT NULL,
    br_updatedby character varying(30) NOT NULL,
    br_updatedat timestamp(6) without time zone NOT NULL
);


--
-- TOC entry 278 (class 1259 OID 70831)
-- Name: sys_module; Type: TABLE; Schema: system; Owner: -
--

CREATE TABLE system.sys_module (
    id integer DEFAULT nextval('system.seq_moduleid'::regclass) NOT NULL,
    name character varying(64) NOT NULL,
    br_state character varying(30) NOT NULL,
    br_transac character varying(30) NOT NULL,
    br_createdby character varying(30) NOT NULL,
    br_createdat timestamp(6) without time zone NOT NULL,
    br_updatedby character varying(30) NOT NULL,
    br_updatedat timestamp(6) without time zone NOT NULL
);


--
-- TOC entry 279 (class 1259 OID 70835)
-- Name: sys_role; Type: TABLE; Schema: system; Owner: -
--

CREATE TABLE system.sys_role (
    id integer DEFAULT nextval('system.seq_roleid'::regclass) NOT NULL,
    name character varying(32) NOT NULL,
    br_state character varying(30) NOT NULL,
    br_transac character varying(30) NOT NULL,
    br_createdby character varying(30) NOT NULL,
    br_createdat timestamp(6) without time zone NOT NULL,
    br_updatedby character varying(30) NOT NULL,
    br_updatedat timestamp(6) without time zone NOT NULL
);


--
-- TOC entry 280 (class 1259 OID 70839)
-- Name: sys_user; Type: TABLE; Schema: system; Owner: -
--

CREATE TABLE system.sys_user (
    id integer DEFAULT public.f_autonum('system.sys_user'::character varying, 'id'::character varying, 1) NOT NULL,
    role_id integer NOT NULL,
    name character varying(64) NOT NULL,
    photo character varying(128) NOT NULL,
    email character varying(64) NOT NULL,
    "aboutMe" character varying(128),
    status smallint NOT NULL,
    username character varying(16) NOT NULL,
    password character varying(256) NOT NULL,
    "authKey" character varying(256) NOT NULL,
    "accessToken" character varying(256) NOT NULL,
    br_state character varying(30) NOT NULL,
    br_transac character varying(30) NOT NULL,
    br_createdby character varying(30) NOT NULL,
    br_createdat timestamp(6) without time zone NOT NULL,
    br_updatedby character varying(30) NOT NULL,
    br_updatedat timestamp(6) without time zone NOT NULL,
    entidad_id integer NOT NULL
);


--
-- TOC entry 281 (class 1259 OID 70846)
-- Name: transition; Type: TABLE; Schema: system; Owner: -
--

CREATE TABLE system.transition (
    br_table character varying(32) NOT NULL,
    br_statehome character varying(32) NOT NULL,
    br_transaction character varying(32) NOT NULL,
    br_stateend character varying(32) NOT NULL,
    br_sentence character varying(32) NOT NULL
);


--
-- TOC entry 3463 (class 0 OID 70828)
-- Dependencies: 277
-- Data for Name: sys_assign; Type: TABLE DATA; Schema: system; Owner: -
--

INSERT INTO system.sys_assign VALUES (1, 13, 'REGISTRADO', 'CREAR', 'postgres', '2016-03-20 17:13:49.104616', 'postgres', '2016-03-20 17:13:49.104616');
INSERT INTO system.sys_assign VALUES (1, 16, 'REGISTRADO', 'CREAR', 'postgres', '2016-03-20 17:13:49.12134', 'postgres', '2016-03-20 17:13:49.12134');
INSERT INTO system.sys_assign VALUES (1, 3, 'REGISTRADO', 'CREAR', 'postgres', '2016-03-20 17:13:49.12288', 'postgres', '2016-03-20 17:13:49.12288');
INSERT INTO system.sys_assign VALUES (1, 1, 'REGISTRADO', 'CREAR', 'postgres', '2016-03-20 17:13:49.124387', 'postgres', '2016-03-20 17:13:49.124387');
INSERT INTO system.sys_assign VALUES (1, 11, 'REGISTRADO', 'CREAR', 'postgres', '2016-03-20 17:13:49.125912', 'postgres', '2016-03-20 17:13:49.125912');
INSERT INTO system.sys_assign VALUES (2, 13, 'REGISTRADO', 'CREAR', 'postgres', '2015-09-26 21:25:50.864984', 'postgres', '2015-09-26 21:25:50.864984');
INSERT INTO system.sys_assign VALUES (2, 9, 'REGISTRADO', 'CREAR', 'postgres', '2015-09-26 21:25:50.86771', 'postgres', '2015-09-26 21:25:50.86771');
INSERT INTO system.sys_assign VALUES (2, 3, 'REGISTRADO', 'CREAR', 'postgres', '2015-09-26 21:25:50.869118', 'postgres', '2015-09-26 21:25:50.869118');
INSERT INTO system.sys_assign VALUES (2, 1, 'REGISTRADO', 'CREAR', 'postgres', '2015-09-26 21:25:50.870512', 'postgres', '2015-09-26 21:25:50.870512');
INSERT INTO system.sys_assign VALUES (2, 11, 'REGISTRADO', 'CREAR', 'postgres', '2015-09-26 21:25:50.871992', 'postgres', '2015-09-26 21:25:50.871992');
INSERT INTO system.sys_assign VALUES (24, 15, 'REGISTRADO', 'CREAR', 'postgres', '2016-07-26 09:22:08.070529', 'postgres', '2016-07-26 09:22:08.070529');
INSERT INTO system.sys_assign VALUES (24, 17, 'REGISTRADO', 'CREAR', 'postgres', '2016-07-26 09:22:08.072567', 'postgres', '2016-07-26 09:22:08.072567');
INSERT INTO system.sys_assign VALUES (24, 19, 'REGISTRADO', 'CREAR', 'postgres', '2016-07-26 09:22:08.073885', 'postgres', '2016-07-26 09:22:08.073885');
INSERT INTO system.sys_assign VALUES (24, 28, 'REGISTRADO', 'CREAR', 'postgres', '2016-07-26 09:22:08.075159', 'postgres', '2016-07-26 09:22:08.075159');
INSERT INTO system.sys_assign VALUES (24, 13, 'REGISTRADO', 'CREAR', 'postgres', '2016-07-26 09:22:08.076413', 'postgres', '2016-07-26 09:22:08.076413');
INSERT INTO system.sys_assign VALUES (24, 21, 'REGISTRADO', 'CREAR', 'postgres', '2016-07-26 09:22:08.077677', 'postgres', '2016-07-26 09:22:08.077677');
INSERT INTO system.sys_assign VALUES (24, 16, 'REGISTRADO', 'CREAR', 'postgres', '2016-07-26 09:22:08.078936', 'postgres', '2016-07-26 09:22:08.078936');
INSERT INTO system.sys_assign VALUES (24, 25, 'REGISTRADO', 'CREAR', 'postgres', '2016-07-26 09:22:08.080023', 'postgres', '2016-07-26 09:22:08.080023');
INSERT INTO system.sys_assign VALUES (24, 20, 'REGISTRADO', 'CREAR', 'postgres', '2016-07-26 09:22:08.08111', 'postgres', '2016-07-26 09:22:08.08111');
INSERT INTO system.sys_assign VALUES (24, 23, 'REGISTRADO', 'CREAR', 'postgres', '2016-07-26 09:22:08.082187', 'postgres', '2016-07-26 09:22:08.082187');
INSERT INTO system.sys_assign VALUES (24, 24, 'REGISTRADO', 'CREAR', 'postgres', '2016-07-26 09:22:08.083341', 'postgres', '2016-07-26 09:22:08.083341');
INSERT INTO system.sys_assign VALUES (24, 26, 'REGISTRADO', 'CREAR', 'postgres', '2016-07-26 09:22:08.08445', 'postgres', '2016-07-26 09:22:08.08445');
INSERT INTO system.sys_assign VALUES (24, 27, 'REGISTRADO', 'CREAR', 'postgres', '2016-07-26 09:22:08.085532', 'postgres', '2016-07-26 09:22:08.085532');
INSERT INTO system.sys_assign VALUES (24, 9, 'REGISTRADO', 'CREAR', 'postgres', '2016-07-26 09:22:08.086645', 'postgres', '2016-07-26 09:22:08.086645');
INSERT INTO system.sys_assign VALUES (24, 3, 'REGISTRADO', 'CREAR', 'postgres', '2016-07-26 09:22:08.087714', 'postgres', '2016-07-26 09:22:08.087714');
INSERT INTO system.sys_assign VALUES (24, 22, 'REGISTRADO', 'CREAR', 'postgres', '2016-07-26 09:22:08.088781', 'postgres', '2016-07-26 09:22:08.088781');
INSERT INTO system.sys_assign VALUES (24, 14, 'REGISTRADO', 'CREAR', 'postgres', '2016-07-26 09:22:08.089927', 'postgres', '2016-07-26 09:22:08.089927');
INSERT INTO system.sys_assign VALUES (24, 18, 'REGISTRADO', 'CREAR', 'postgres', '2016-07-26 09:22:08.091081', 'postgres', '2016-07-26 09:22:08.091081');
INSERT INTO system.sys_assign VALUES (24, 1, 'REGISTRADO', 'CREAR', 'postgres', '2016-07-26 09:22:08.092284', 'postgres', '2016-07-26 09:22:08.092284');
INSERT INTO system.sys_assign VALUES (24, 11, 'REGISTRADO', 'CREAR', 'postgres', '2016-07-26 09:22:08.093415', 'postgres', '2016-07-26 09:22:08.093415');
INSERT INTO system.sys_assign VALUES (24, 10, 'REGISTRADO', 'CREAR', 'postgres', '2016-07-26 09:22:08.094507', 'postgres', '2016-07-26 09:22:08.094507');
INSERT INTO system.sys_assign VALUES (24, 2, 'REGISTRADO', 'CREAR', 'postgres', '2016-07-26 09:22:08.095612', 'postgres', '2016-07-26 09:22:08.095612');
INSERT INTO system.sys_assign VALUES (30, 22, 'REGISTRADO', 'CREAR', 'root', '2019-11-28 22:38:42.065245', 'root', '2019-11-28 22:38:42.065245');
INSERT INTO system.sys_assign VALUES (30, 14, 'REGISTRADO', 'CREAR', 'root', '2019-11-28 22:38:42.07716', 'root', '2019-11-28 22:38:42.07716');
INSERT INTO system.sys_assign VALUES (30, 1, 'REGISTRADO', 'CREAR', 'root', '2019-11-28 22:38:42.086248', 'root', '2019-11-28 22:38:42.086248');
INSERT INTO system.sys_assign VALUES (30, 11, 'REGISTRADO', 'CREAR', 'root', '2019-11-28 22:38:42.095048', 'root', '2019-11-28 22:38:42.095048');
INSERT INTO system.sys_assign VALUES (30, 21, 'REGISTRADO', 'CREAR', 'root', '2020-01-01 23:41:39.944976', 'root', '2020-01-01 23:41:39.944976');


--
-- TOC entry 3464 (class 0 OID 70831)
-- Dependencies: 278
-- Data for Name: sys_module; Type: TABLE DATA; Schema: system; Owner: -
--

INSERT INTO system.sys_module VALUES (1, 'site-about', 'REGISTRADO', 'CREAR', 'postgres', '2015-01-01 00:00:00', 'postgres', '2015-01-01 00:00:00');
INSERT INTO system.sys_module VALUES (10, 'sysrole-adminrole', 'REGISTRADO', 'CREAR', 'postgres', '2015-08-01 22:25:37.798552', 'postgres', '2015-08-01 22:25:37.798552');
INSERT INTO system.sys_module VALUES (11, 'site-index', 'REGISTRADO', 'CREAR', 'postgres', '2015-08-02 10:22:46.682137', 'postgres', '2015-08-02 10:22:46.682137');
INSERT INTO system.sys_module VALUES (2, 'sysuser-adminuser', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2015-01-01 00:00:00', 'postgres', '2015-08-02 11:22:21.502828');
INSERT INTO system.sys_module VALUES (13, 'escenario-adminescenario', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2015-08-02 13:14:23.012499', 'postgres', '2015-08-02 20:27:30.446945');
INSERT INTO system.sys_module VALUES (3, 'plantilla-adminplantilla', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2015-08-01 19:05:25.310793', 'postgres', '2015-09-26 21:25:34.759379');
INSERT INTO system.sys_module VALUES (16, 'fuente-adminfuente', 'REGISTRADO', 'CREAR', 'postgres', '2015-09-27 20:28:52.712246', 'postgres', '2015-09-27 20:28:52.712246');
INSERT INTO system.sys_module VALUES (9, 'params-adminparam', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2015-08-01 22:24:04.4689', 'postgres', '2016-03-07 20:02:06.750301');
INSERT INTO system.sys_module VALUES (14, 'riocp-adminriocp', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2015-09-21 18:56:22.922914', 'postgres', '2016-03-12 18:08:03.273581');
INSERT INTO system.sys_module VALUES (15, 'capacidad-admincapacidad', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2015-09-21 20:54:01.387136', 'postgres', '2016-03-13 11:03:22.898296');
INSERT INTO system.sys_module VALUES (18, 'riocp-estadoriocp', 'REGISTRADO', 'CREAR', 'postgres', '2016-03-16 20:59:01.755659', 'postgres', '2016-03-16 20:59:01.755659');
INSERT INTO system.sys_module VALUES (17, 'capacidad-estadocap', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2016-03-13 13:29:56.186274', 'postgres', '2016-03-16 21:13:42.099084');
INSERT INTO system.sys_module VALUES (19, 'entidad-adminentidad', 'REGISTRADO', 'CREAR', 'postgres', '2016-03-20 07:17:09.554908', 'postgres', '2016-03-20 07:17:09.554908');
INSERT INTO system.sys_module VALUES (20, 'moneda-adminmoneda', 'REGISTRADO', 'CREAR', 'postgres', '2016-03-20 07:59:20.449681', 'postgres', '2016-03-20 07:59:20.449681');
INSERT INTO system.sys_module VALUES (21, 'estadistica-adminseguimiento', 'REGISTRADO', 'CREAR', 'postgres', '2016-03-21 08:03:20.561162', 'postgres', '2016-03-21 08:03:20.561162');
INSERT INTO system.sys_module VALUES (22, 'report-adminreport', 'REGISTRADO', 'CREAR', 'postgres', '2016-03-26 10:49:10.67599', 'postgres', '2016-03-26 10:49:10.67599');
INSERT INTO system.sys_module VALUES (23, 'montomaximo-adminmontomaximo', 'REGISTRADO', 'CREAR', 'postgres', '2016-05-17 07:44:19.649837', 'postgres', '2016-05-17 07:44:19.649837');
INSERT INTO system.sys_module VALUES (24, 'montomaximo-consulta', 'REGISTRADO', 'CREAR', 'postgres', '2016-06-29 15:29:39.248574', 'postgres', '2016-06-29 15:29:39.248574');
INSERT INTO system.sys_module VALUES (25, 'importar-adminimportar', 'REGISTRADO', 'CREAR', 'postgres', '2016-06-29 15:29:53.326452', 'postgres', '2016-06-29 15:29:53.326452');
INSERT INTO system.sys_module VALUES (26, 'origen-adminorigen', 'REGISTRADO', 'CREAR', 'postgres', '2016-06-29 15:30:05.609476', 'postgres', '2016-06-29 15:30:05.609476');
INSERT INTO system.sys_module VALUES (27, 'paramcalc-adminparamcalc', 'REGISTRADO', 'CREAR', 'postgres', '2016-06-29 15:30:15.993499', 'postgres', '2016-06-29 15:30:15.993499');
INSERT INTO system.sys_module VALUES (28, 'entidades-adminfuente', 'REGISTRADO', 'CREAR', 'postgres', '2016-07-26 09:22:03.859453', 'postgres', '2016-07-26 09:22:03.859453');


--
-- TOC entry 3465 (class 0 OID 70835)
-- Dependencies: 279
-- Data for Name: sys_role; Type: TABLE DATA; Schema: system; Owner: -
--

INSERT INTO system.sys_role VALUES (24, 'Superusuario', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2015-08-01 22:46:23.814591', 'postgres', '2015-08-02 08:20:42.806445');
INSERT INTO system.sys_role VALUES (2, 'Operador RIOCP', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2015-01-01 00:00:00', 'postgres', '2015-08-02 11:17:40.347278');
INSERT INTO system.sys_role VALUES (1, 'Analista Financiero', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2015-01-01 00:00:00', 'postgres', '2015-09-28 21:26:06.133712');
INSERT INTO system.sys_role VALUES (30, 'Consultas', 'REGISTRADO', 'ACTUALIZAR', 'root', '2019-11-28 22:33:00.013294', 'root', '2019-11-28 22:33:48.728594');


--
-- TOC entry 3466 (class 0 OID 70839)
-- Dependencies: 280
-- Data for Name: sys_user; Type: TABLE DATA; Schema: system; Owner: -
--

INSERT INTO system.sys_user VALUES (6, 24, 'Shiarella Zelaya', '/uploads/photo/default.jpg', 'shiarella.zelaya@economiayfinanzas.gob.bo', 'Usuario operador del Sistema', 10, 'shiarella', 'ADsHlM.m9dQcc', 'e9c24233047f72319703c43102cabcbfcd87610ccd295b0586ea1728f4917a7ae57bcdde16dd74860c77af6fa578648bf5c28070ca3a516b3493959a168d06e620e16b79c097769109b04b0b8fffc3b490c62954f52d225816fc86e6b3becc8c3a9ba560', '0e386e7dbd09945bd6ff9e22f14fc0534f213f552b425038c8ecc752ef7153a0837183d15790e3f114341ec64aef3f518396dce8aeee745eee963b3dc735cfca8c7cecae0e3d9e2e31ad33150a13043f611a31f969d5d697eaa8324a3b495ee1552fd8f9', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2016-03-22 22:53:00.784397', 'root', '2019-12-30 18:08:59.161356', 4601);
INSERT INTO system.sys_user VALUES (4, 24, 'Vicente Aguirre', '/uploads/photo/default.jpg', 'vicente.aguirre@economiayfinanzas.gob.bo', 'Usuario operador del Sistema', 10, 'vicente', 'ADQSzcr4xnpXs', '9aeedfb30742f849247be880c024e0ad1f1443ea18277d60841c20357bfc20fa575f1af89856c1cac4d4b6f985b1b027edc5d23d0f937c4977494a8259a702456709fad6fdfdf9cd76c16aa1aaf139cf73fc32995fcbfeeca04714f2549e4c31584e03dc', '9fde41158b206781286da045efa58d883bcd33815071e69746a4c501a0d93b7cca063edf5b6a768128c542c58f4212542b0c031c5ec3aab39de461f56add297aadc1743386c97d37071de78b7bf0ad0b133edc8c9ab6d4442b7795967ec72399d2e05c34', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2016-03-22 22:50:59.724976', 'root', '2019-12-24 10:08:45.521423', 4601);
INSERT INTO system.sys_user VALUES (3, 24, 'Nahim Callisaya', '/uploads/photo/default.jpg', 'nahim.callisaya@economiayfinanzas.gob.bo', 'Usuario operador del Sistema', 10, 'nahim', 'AD/oSs6Fsy4Kc', '5a78c791172dc82978a68a31e0737ce2dc0f9061df40edfbc08b112580f523d654b5a8dde742b94e02f79738d836272e14a23d67b0fc091626414df8c9456d9e8a71d3ffa42049dd584fcadea8a7cacaa92e37332badae06cbcecf3de3a03c14ca8572f0', '30444b16c3bf942dd3476b18b0498a020bcbc37ed94c3cf75941bc0d2bd1b4915b2750c9f6b9916511c2436d4a4543d056d1df03c12b8f6f6981254d5e907c639aac00528e4730d00c7971d35ca3f6de7d1d4c63100a730d5dd350d02da7adc713ac665d', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2016-03-22 22:50:07.853734', 'root', '2019-12-30 23:55:19.052643', 1206);
INSERT INTO system.sys_user VALUES (10, 24, 'Virginia Gerónimo', '/uploads/photo/default.jpg', 'virginia.geronimo@economiayfinanzas.gob.bo', 'Usuario operador del Sistema', 10, 'virginia', 'ADEVzhOjCru8s', 'e71c62968d275ab25c87b69f040ee8636d6256f4971583e35c069fb0a25f018d45501aa181c6b1f63533a59ad4f4be7692c13d815bd6233bec5f740bf650a3dac01530df11b9a4be76441a6662d7b08d60906d5e46d41e9eb49245f1d2ff8e3543b16651', '39cbec0f6f80bd8f5d442efd7144e0b7fe940fac5836c1b8562da808fb232418902f62111ad32f1eba1c98aea382ef0d69321ba8cd242a84a069f7ef1c862fafe3864847cd14d0fe7ceca22150ee5e3a726201f247d8e2cb50e596d5d1996394b6c1d2a8', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2016-09-21 16:24:13.825009', 'root', '2019-12-30 23:55:09.267926', 4601);
INSERT INTO system.sys_user VALUES (12, 24, 'Luis Alberto Arce Catacora', '/uploads/photo/default.jpg', 'luis.arce@economiayfinanzas.gob.bo', 'Usuario operador del Sistema', 10, 'Larce', 'ADJ2enIVz5rOE', '7ecb03704743d9869f0d66378326cbeaf1b6b9d668f97e574ca094e8d740990e12b21eedc4d98963b79b1e94c4ab31fb90305837367264b72b99f841252cc8ebf81b6b9f87741829919f0478f0b1ff25ea6ac50a2e5aceac592b4fa96c0b2966927cedd6', '1864c7787fa15a01d6356f268f8c2b99a54d31b07c72cda0a3b6932781a129135b6e2840a19d59453523fb1e215b1c5ce1170bd13c5ecfa6b2f1375cf1e649881f5719fabbfd1fa280a1d542d8e87d7e33cb22b3317a6834e3c1f6925e122e7b7acf2e9b', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2016-11-17 11:20:09.623834', 'root', '2019-12-30 23:55:12.004138', 4601);
INSERT INTO system.sys_user VALUES (7, 24, 'Juan Carlos Villegas', '/uploads/photo/default.jpg', 'juan.villegas@economiayfinanzas.gob.bo', 'Usuario operador del Sistema', 10, 'juancarlos', 'ADObrjbm8wgPM', '077e4adb3cdc40a4083701b8ea5c46da4bffb205548fa99172eeafde080a54bf50579b3462a61adf3233867e4eff815480272b2e33bb3f0c795563a0706581068840ad53665fbb29bd5776e4ca0b2770526552f1ea70cffd3aa06fb9f2a7f8ea0b6b3b38', 'b1ee631f4261781d01b50f66028a42869ca561b1a8886fbc7c8e25b9ea982752a5e7dfededba3dd10c58767c67bf56751b241785aa64d9b3c72930c0dd6893405cbcaa8ba45e4676306d684ab09ba31563863673028bf679c3d92793e85f2cbe69af689d', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2016-03-22 22:54:18.203942', 'root', '2019-12-30 23:55:14.295498', 4601);
INSERT INTO system.sys_user VALUES (14, 24, 'Oscar Alejandro Parrado Ugarte', '/uploads/photo/default.jpg', 'oscar.parrado@economiayfinanzas.gob.bo', 'Usuario operador del Sistema', 10, 'Oscar', 'ADycWTcyzLqZg', '358e293d632a5b24de9589088215b564048942d0b517791be06c0cae42a5e6041f4b772939619e2d5ffb200d909ddf8443520e1ade2d2a0d06f8c5bcca0f0e9b753e9bfdf70787be31c5cd8eee342360ef5e0a26894665afccbf0945de067ccc28098957', '8f34b3ae6b3dae9e2faf1d29b98a8477911bb1f739b3da8508b8c38d37e11ce13624e727641a5f5bd790183a581ca6442ce7a7461c7d12e50eb7c5773fa4b4e473271c49e1c6901052d8eb67062217de15b8867dda9d103c96ad76be336b19084273e461', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2017-05-18 16:52:01.868227', 'root', '2019-12-30 23:55:24.115481', 4601);
INSERT INTO system.sys_user VALUES (9, 24, 'Natalio Condori', '/uploads/photo/default.jpg', 'natalioc2@gmail.com', 'Usuario WEB', 10, 'natalio', 'ADEbBxDYye1bQ', 'f8f2c22ef434d55e7107c904e4ee92fe0473df8291dcd91a07827fcb91f995e00ba318b00f33eb4483d680787d769bdfdd94bbb104b465e4e20d8eb52822a58d8789891f4290eeb26154670e687635a2281189621686b9e81a3d79238001b1a402be1869', '55575a5cbe09e93cf94114b7ccb4b8373e4eff1048f888bd864f16c48deab775c1a272810d0fc23aedf591f854972735e3dccb33fa8221275835094b339b0265ca7eb171169ad28801360d8a77be0892877ae4261274a531dce30d4ea52142a3f7342b19', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2016-07-26 10:01:53.252041', 'root', '2019-12-30 23:55:06.097843', 4601);
INSERT INTO system.sys_user VALUES (5, 24, 'Grisha fushimoto', '/uploads/photo/default.jpg', 'grisha.fushimoto@economiayfinanzas.gob.bo', 'Usuario operador del Sistema', 10, 'grisha', 'ADyZzpP/w7DqQ', '5e66f79bfa70e2172f9d4ad64b13484fd1b3fb44c2a0b2e48d72dbf8c7265dc95d2afd516677fb1dff630b138a04d2496cabf52c209711b677fd87778e2c6cb3fb457d7037ebef8bcefbbd9a11cd4d7af15c532e06f4cd6e2b04ef457692a62fed196aed', '747983e055aaa46816013867ce79fccd6ad441bfcb0d6cbd815202f37d2df50c537fb85eab17e3bdb751faace3f4e679f4f13a54cc2053360ee6ff938fedbbd1628f33a552b1b4e293ee8d872cb3eeaa780020be8d6a8a2746b3aa02c2c16d13c794eb8c', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2016-03-22 22:52:06.459796', 'root', '2019-12-30 23:55:16.562165', 4601);
INSERT INTO system.sys_user VALUES (13, 24, 'Franklin', '/uploads/photo/default.jpg', 'franklin.luna@economiayfinanzas.gob.bo', 'Usuario operador del Sistema', 10, 'fluna', 'ADHKl6iWOI/Gs', '8adb76b8a05c377512ce1d09b664531445611702dc469220b5528b298e348ae26a9e806b2181908ab32a5a93f2de326f3631c03571d78b7a50a019972dbc682f4c77202085e67b62268a687fc8287ae1cbf527c030c0289b57b2698880650ac3c1f4f2a9', '8d01cf28c4083e6143cb4f567a1d22c15288716abc8415bcfeda4961ae4277a2f90d0dd1fcc77e9d2ddcca4cfe5cb5414b4bf724a42781b14e37fea4256411cc36d846340b2f246d90be4b8d648eca0574320cd6d6c6089ffb3ac2e9dcdfd4abe434671a', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2017-02-06 11:11:16.10091', 'root', '2019-12-30 23:55:21.767853', 4601);
INSERT INTO system.sys_user VALUES (2, 24, 'Admin', '/uploads/photo/default.jpg', 'admin@gmail.com', 'Usuario administrador del Sistema', 10, 'admin', 'ADlcMjRZMmeIQ', '3278737086008da9d313c54ca856d706fe4d7236e9ccddc064a9f4b037d6432a7dd5571974ca8e15914ec655391e29e0c2c8f47cfadef49ec32e0e99d1d611d4a02faf20f6440382d1736739e665eafe0740dd7391efbc8f46913218ed43da7382ab5844', 'f9a1b86655ded4d287bb7955166d417a07126df1926cd94b66d369fe6c114f2bc939d91c2df5da796b32b978be053866805cfde7143441412ea4d72eb9a57615cd720cf778210c9919347c99b9486b49f21656425cabf9a694167058007c22b7a3350ddb', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2016-03-07 11:17:03.18151', 'root', '2019-12-31 00:17:06.174016', 903);
INSERT INTO system.sys_user VALUES (20, 24, 'Sdenka Claros', '/uploads/photo/default.jpg', 'sdenka.claros@economiayfinanzas.gob.bo', 'Usuario operador del Sistema', 10, 'sdenka', 'ADY0QXKcJMFjw', '18e1eb701c1ff5333f7489d483067eeec361537c6e2cac5313e021a1a1d852c8c8f72daf23125ccc602e7368a96629547b20e257ccf7f2ab8306dd4ec0a5f6fd774c0f932f0871a5b11e4c27332908de570cd0565c4235e5c6978241cd12b4672c95242e', '6c608bba7b8532d564e7fa47c335eb9be61c73d45b0e44a0fee4f8222bd6dd81af38973489924a99ed43ccb4ef113f9452240bfebe75e753afdc2f774eee4d8f60ac2f133ff8cb1d04099d642b8df72cd3f68602c50e672d28c2c9c5bb80813ca8895e17', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2018-05-11 18:14:10.46831', 'root', '2019-12-30 23:55:31.883284', 4601);
INSERT INTO system.sys_user VALUES (27, 24, 'Wilmer Alavi Argandoña', '/uploads/photo/default.jpg', 'wilmer.alavi@economiayfinanzas.gob.bo', 'Usuario operador del Sistema', 10, 'wilmer', 'ADxXk8ceIUa9k', '27ae6f029a4e4005ca1ea6838545f46726cec27b320d869b70f7de1bac7f73dfff32813199586493af1e39f3bc996dec2840fe8ee3cadc4e1c2bb75da5c68190f374769bfcc2e6769f8ad3eef0bd7a4d3271e72395ce2ab1f9233678d8bb86e2ec9292c9', 'dfd6ffd5f5e82c75a9695b19e12da4dda1af6dab9fa118c17913b93f0c306647d4ca8dc72ce9a10808217b6ed04acf70aa08d2655a451b489c06eda23525b0cc03a3b7e7793fade9046487c125d4bf6287ba407200804c0a7c5597d220c468c45e50538b', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2019-10-08 10:23:16.275325', 'root', '2019-12-30 18:08:48.984009', 4601);
INSERT INTO system.sys_user VALUES (26, 24, 'Jose Callata', '/uploads/photo/default.jpg', 'jose.callata@economiayfinazas.gob.bo', 'Usuario operador del Sistema', 10, 'jcallata', 'ADWXLOJB15COE', '2f92598344bd5f20a4a6094f4f10d6f5bfd7ec1872c28498ea459fb442a7ef3046d98475d9eb4ea8e53ea485d922fb898c97663a67c0ccf0794843382c07de7c069d32ef00622b9fb4d5d736994ce1f5ee877cce287ba60b047411001b352916ef4b260a', '5db6a280d6b5d2c5351c4899d3a6016b488416b52d06521fe919708b987f041a3f5ac755ac254aa89277858846ea15bab6be3794910321219fe8bd669a60581742befb9f3f9b61257739a05a021c089b1b07dfc64b8031c0e60fcb02384974ae60c96e60', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2019-10-08 10:22:11.108965', 'root', '2019-12-30 23:55:34.135632', 4601);
INSERT INTO system.sys_user VALUES (8, 24, 'Sergio Cusicanqui', '/uploads/photo/default.jpg', 'sergio@gmail.com', 'Usuario operador del Sistema', 10, 'vtcp', 'ADEYn65ARbGcA', 'fd6ee5f69769d8cb9cdf8281c84fb4d1795c5b95854c46d38196a7ed582626d06921a1d9d7b74f136007e4aa327bfa2bab3b36a74c4e1c7e3ec78c81553a6cc6d577284daf121f7b3992c7a8249e6bba787072377b0e0dfadf30c3e4ed9aeabc99261b4e', 'ca33e942ed807cbb0ac4be7bdf74129432e81805cfc92db8ee3f20156e0d7f807cefa5bdadc21e152abb027d7d043fb11062b85cb852dce5cf7384668d12229a862a5ec6c8ffa3bd996842436bbf4bf28833c6ff4554f77e74d1d7a99bf3d4cb36462abc', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2016-03-23 12:11:59.878605', 'root', '2019-12-30 23:55:36.431096', 4601);
INSERT INTO system.sys_user VALUES (23, 24, 'Mery Escocia Mendez Cespedes', '/uploads/photo/default.jpg', 'mery.mendez@economiayfinanzas.gob.bo', 'Usuario operador del Sistema', 10, 'mery', 'AD.UMi0wWJS9Y', '874003c4ae5587396c763e173f2c92a804e6e00e4ca39326502f49cdf40ed1d4c100874394c9e55abef5d193cf807ba921f1eaae5dd98999df4163a99906a0527b9cba06d46c45b8b6f8f07ffdbf4782884a9b7c53e0f0e0c3e2ac70f86a65253d52e25a', 'ca010473ebbfd8537143ccf60af43b55bbd26abbcd00bca94437783d9983a3ec52522735aacccdb684453d92d7bd000c8b418ed9e0b13ce178d1cc9f9b302920bd891c852acbc03af61181682febf710a0012fda00c3753c2b302ffb53ca0411b883eb44', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2019-07-11 15:09:52.970635', 'root', '2019-12-30 23:55:43.162406', 4601);
INSERT INTO system.sys_user VALUES (24, 24, 'Carolay Gonzales Medrano', '/uploads/photo/default.jpg', 'carolay.gonzales@economiayfinanzas.gob.bo', 'Usuario operador del Sistema', 10, 'carolay', 'ADFHwTasM2FEY', 'eb70aae10cf439469af946b62c6c8d8df54f697dbc75b11b26ad3c9ce6edad1f8b55b28c4686df76c895a87f5b25f9beb69ce8f94d58334514023e7e00a5fb91794c7ac2d7061b29591edf3353fb4e32dd5ad73159ecb6b663b98434d858ce002b159ac4', 'a16bd889299142b71764bca3e1fd1271943d31dc1c4b559d357487ece306ceec97f3f3565f81b84441f2f353db00042f1787044c924b1f5b7b3c4f681ce766de4bcb56e5f876e37b41df69ddc2a9fddaf0bbc071f4d3da4717ce7019828d5cdb2fc569cb', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2019-07-19 12:13:55.274743', 'root', '2019-12-30 23:55:45.364071', 4601);
INSERT INTO system.sys_user VALUES (25, 24, 'Edwin Silisqui', '/uploads/photo/default.jpg', 'edwin.silisqui@economiayfinanzas.gob.bo', 'Usuario operador del Sistema', 10, 'esilisqui', 'ADcmuzRa6IGik', 'd67dec39f22c5a5fa14d71fae59f75cb2af6c8510e3cff2f6d34494854e3f1471a338faf43298af5d8f88a734cca377a713664c1e40c45884e62e4c96f9fd7fbe97b392748ae48dec9714a100153eb53a2432d1cc116f4b249aea24090ae2572e1c753a7', 'a240c69659b626c1dd5592deafb69c494ef7bf47f53725e59a0834c3aef91a9bef8042d9e6662b11b80423e2742e41096ef072fbec77dfeed596edec7611d709c60ae6b3890bf5020fe533700f84df4fbaf061941f66acf124cbda2301d378898ef46ffe', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2019-10-01 09:43:40.485288', 'root', '2019-12-30 23:55:47.700111', 4601);
INSERT INTO system.sys_user VALUES (28, 30, 'consulta', '/uploads/photo/default.jpg', 'esilisqui@gmail.com', 'Usuario operador del Sistema', 10, 'consulta', 'AD48r8R8hvBf2', '1e979ee40d6f81984e57326ad36fbbe2fefe338a65f5cf363f4d70dbaa1bb640ba544441f9c1f6e8b8b9efaff200eb7fb2a6c4d14f9ace8ecad1fe646dbaf80110d3b0b66b69f5d250ab4760a710577cea6017ce99de406066114d84bfb7d89296814b53', 'a985f4bc133b7268885b754712ec3a5493ffe016ab8744523140ced4617022a1cf716ed60b3a6f2f7d5a194e0248b50dae572939ada723df69fd8a1f2ce3757892522f12220ab40736b2737f5c9377260ee8361be8cf22dcfe4c722342d1f5e5a243fb53', 'REGISTRADO', 'ACTUALIZAR', 'root', '2019-11-28 22:36:51.89984', 'root', '2019-12-30 18:08:31.230199', 1116);
INSERT INTO system.sys_user VALUES (19, 24, 'Yamil Venegas', '/uploads/photo/default.jpg', 'yamil.venegas@economiayfinazas.gob.bo', 'Usuario operador del Sistema', 10, 'benjamin', 'ADVBkrv1pPZ1s', 'd6c6ec5ae6d7944c0bf7f85ed73f095367faabae8dc876ad80adf6134b8ba3561a71c75bb7984ac21d67ad05fe6081df2a758369168b7a4fe0cf42b97706f3b848422119efab0405b2a5bb589b4f46ef587dffc34d5b7c6857469f480febb2071ea73d1e', '0cfeecd99768c0736b483b5bf6899fdf233756744326aff61a4bc0c2ca1b0418eb598332ccfd259954a8ac0dd7f426268e577ffa15d90d8c79a8c0cfe196e23c7e953f5bb9a1c94a859bcb0020d69686b814ed5fc67f52f4de5f0c68395264f72726adcd', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2018-02-21 15:58:54.452146', 'root', '2019-12-30 23:55:29.697087', 4601);
INSERT INTO system.sys_user VALUES (18, 24, 'Alberto Pinto', '/uploads/photo/default.jpg', 'alberto.pinto@economiayfinanzas.gob.bo', 'Usuario operador del Sistema', 10, 'apinto', 'ADeIIvckN4AW2', 'd102656a86f0cd029da103fd7b4e1e455ae26a2568c8b31b612db8189cc107dc71441d0ec3ddc4f9c7cd54b56eddb0f97a4feb404846296578823aeff12078058aacb4352d2bce69d52666bbe42b2870973a2c6b0fd339365b32853dfce7acea98a2b731', 'c6a663325ca4747d7cb8e08ee9606079d85a2e2e038ee51b829c970d7d3341270e7820c9aadf6504e07ded1b1b5b2e99277bdaaeae37aa2e1f25397ab2c47b3f800c01116bf6b7b3c4e63c6459e2b87aeed564d352f70102b5f57b02b5ac38d8d039b726', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2018-02-07 18:03:55.661618', 'root', '2019-12-30 23:55:38.787613', 4601);
INSERT INTO system.sys_user VALUES (22, 24, 'Carmen Fabiola Lopez Flores', '/uploads/photo/default.jpg', 'carmen.lopez@economiayfinanzas.gob.bo', 'Usuario operador del Sistema', 10, 'carmen', 'ADzmQmEHVNg2k', 'ed4d6627c597e8119c74d1a2f12c5abae5da1574171659d5ca0f107680931a35666e2389106df981ae6254f3bed2f6ec3a0c4ecb48ea7d182d1d867aba3077317931e5393791a0f2476333353cc1a58741f9c88667d6e3f90b2a4b5ee76e24cdb2ce1bad', '9ead70ce15ec7a1b7d00834ab7e38f7748b2ed658b86b0793e027a298736c037e4f28ce7dd3f31fd65536d34ac1d3aa75f0415258ca23f50b0a73323696fa7d6c404f9feb06551b77b414da1c76c4a874f29e7efeaaa2c70d17847f75c90c8d6d6624a88', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2019-07-11 15:06:01.215967', 'root', '2019-12-30 23:55:40.947986', 4601);
INSERT INTO system.sys_user VALUES (1, 24, 'Nathan Drake', '/uploads/photo/default.jpg', 'nathan@gmail.com', 'Administrador del Sistema...
', 10, 'nathan', 'ADGWjSHk0qd9U', 'd7be14890edcbcca9f5ff7e77944b10fe146c3537869b8abe51325104cb631c8974c006ee2df0e0597e2358e79a11d01aa40005598bfc1acff58b3c93d0b17327d8e44a32b953a89f381db06e78641e25d7f779098b28a1e3f660c35a11596e59bb79ad8', '9f08f8c8e854be0c68764b14d31d35b3b21003f52bf4f66c448f50a992c3dede645dea87be11ad3582a39a392636a6a615a56828c9fdd98b28529f12baeb7e8ea89762692bc6ba8493c8940a54c29a7a9785f45867487226c55bfcca6e36f07ed5a3051c', 'REGISTRADO', 'ACTUALIZAR', 'postgres', '2015-08-01 13:00:22.226257', 'root', '2019-12-24 10:08:18.806043', 4601);
INSERT INTO system.sys_user VALUES (29, 30, 'pedro', '/uploads/photo/default.jpg', 'pedro@gmail.com', 'Usuario operador del Sistema', 10, 'pedro', 'ADudiPb2k/J26', '8f4c33d8049a05489fe6f769bba69be818aa2e99889e43c391fefbe0cecc01a80b98f87d771114a0bf511a74fa652648736c140f176827f4dbb4b9e09ac176f4fc776ecec9d462e94f45e8ce9f56bb11effb32f5130eb4e6a82f74369f3b1b25086a0c67', '5cc76036ebcc6586b27230e9eba4d6298464a01f231ef0a188a1ee13f1d3e62c0f716e6e8e2e535416b6a3f0b39ff2158ec43982e17aa341f6dff261c561eedc307d0564c34dcf42b881048305a49d73446af252c05f5076e5d50ce67e172e0c8dde5868', 'REGISTRADO', 'ACTUALIZAR', 'root', '2019-12-23 16:54:39.079094', 'root', '2019-12-30 23:55:53.116794', 4601);


--
-- TOC entry 3467 (class 0 OID 70846)
-- Dependencies: 281
-- Data for Name: transition; Type: TABLE DATA; Schema: system; Owner: -
--

INSERT INTO system.transition VALUES ('system.sys_assign', 'INICIAL', 'CREAR', 'REGISTRADO', 'INSERT');
INSERT INTO system.transition VALUES ('system.sys_assign', 'REGISTRADO', 'ACTUALIZAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('system.sys_assign', 'REGISTRADO', 'ELIMINAR', 'FINAL', 'DELETE');
INSERT INTO system.transition VALUES ('system.sys_assign', 'REGISTRADO', 'VERIFICAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('system.sys_assign', 'VERIFICADO', 'DESVERIFICAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('system.sys_assign', 'VERIFICADO', 'APROBAR', 'APROBADO', 'UPDATE');
INSERT INTO system.transition VALUES ('system.sys_assign', 'APROBADO', 'DESAPROBAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('system.sys_role', 'INICIAL', 'CREAR', 'REGISTRADO', 'INSERT');
INSERT INTO system.transition VALUES ('system.sys_role', 'REGISTRADO', 'ACTUALIZAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('system.sys_role', 'REGISTRADO', 'ELIMINAR', 'FINAL', 'DELETE');
INSERT INTO system.transition VALUES ('system.sys_role', 'REGISTRADO', 'VERIFICAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('system.sys_role', 'VERIFICADO', 'DESVERIFICAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('system.sys_role', 'VERIFICADO', 'APROBAR', 'APROBADO', 'UPDATE');
INSERT INTO system.transition VALUES ('system.sys_module', 'INICIAL', 'CREAR', 'REGISTRADO', 'INSERT');
INSERT INTO system.transition VALUES ('system.sys_module', 'REGISTRADO', 'ACTUALIZAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('system.sys_module', 'REGISTRADO', 'ELIMINAR', 'FINAL', 'DELETE');
INSERT INTO system.transition VALUES ('system.sys_module', 'REGISTRADO', 'VERIFICAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('system.sys_module', 'VERIFICADO', 'DESVERIFICAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('system.sys_module', 'VERIFICADO', 'APROBAR', 'APROBADO', 'UPDATE');
INSERT INTO system.transition VALUES ('system.sys_module', 'APROBADO', 'DESAPROBAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('system.sys_role', 'APROBADO', 'DESAPROBAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('system.sys_user', 'INICIAL', 'CREAR', 'REGISTRADO', 'INSERT');
INSERT INTO system.transition VALUES ('system.sys_user', 'REGISTRADO', 'ACTUALIZAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('system.sys_user', 'REGISTRADO', 'ELIMINAR', 'FINAL', 'DELETE');
INSERT INTO system.transition VALUES ('system.sys_user', 'REGISTRADO', 'VERIFICAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('system.sys_user', 'VERIFICADO', 'DESVERIFICAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('system.sys_user', 'VERIFICADO', 'APROBAR', 'APROBADO', 'UPDATE');
INSERT INTO system.transition VALUES ('system.sys_user', 'APROBADO', 'DESAPROBAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('riocp.riocp', 'INICIAL', 'CREAR', 'REGISTRADO', 'INSERT');
INSERT INTO system.transition VALUES ('riocp.riocp', 'REGISTRADO', 'ACTUALIZAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('riocp.riocp', 'REGISTRADO', 'ELIMINAR', 'FINAL', 'DELETE');
INSERT INTO system.transition VALUES ('riocp.riocp', 'REGISTRADO', 'VERIFICAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('riocp.riocp', 'VERIFICADO', 'DESVERIFICAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('riocp.riocp', 'VERIFICADO', 'APROBAR', 'APROBADO', 'UPDATE');
INSERT INTO system.transition VALUES ('riocp.riocp', 'APROBADO', 'DESAPROBAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('riocp.riocp_observa', 'INICIAL', 'CREAR', 'REGISTRADO', 'INSERT');
INSERT INTO system.transition VALUES ('riocp.riocp_observa', 'REGISTRADO', 'ACTUALIZAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('riocp.riocp_observa', 'REGISTRADO', 'ELIMINAR', 'FINAL', 'DELETE');
INSERT INTO system.transition VALUES ('riocp.riocp_observa', 'REGISTRADO', 'VERIFICAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('riocp.riocp_observa', 'VERIFICADO', 'DESVERIFICAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('riocp.riocp_observa', 'VERIFICADO', 'APROBAR', 'APROBADO', 'UPDATE');
INSERT INTO system.transition VALUES ('riocp.riocp_observa', 'APROBADO', 'DESAPROBAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('riocp.riocp_requisito', 'INICIAL', 'CREAR', 'REGISTRADO', 'INSERT');
INSERT INTO system.transition VALUES ('riocp.riocp_requisito', 'REGISTRADO', 'ACTUALIZAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('riocp.riocp_requisito', 'REGISTRADO', 'ELIMINAR', 'FINAL', 'DELETE');
INSERT INTO system.transition VALUES ('riocp.riocp_requisito', 'REGISTRADO', 'VERIFICAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('riocp.riocp_requisito', 'VERIFICADO', 'DESVERIFICAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('riocp.riocp_requisito', 'VERIFICADO', 'APROBAR', 'APROBADO', 'UPDATE');
INSERT INTO system.transition VALUES ('riocp.riocp_requisito', 'APROBADO', 'DESAPROBAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('riocp.riocp_tramite', 'INICIAL', 'CREAR', 'REGISTRADO', 'INSERT');
INSERT INTO system.transition VALUES ('riocp.riocp_tramite', 'REGISTRADO', 'ACTUALIZAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('riocp.riocp_tramite', 'REGISTRADO', 'ELIMINAR', 'FINAL', 'DELETE');
INSERT INTO system.transition VALUES ('riocp.riocp_tramite', 'REGISTRADO', 'VERIFICAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('riocp.riocp_tramite', 'VERIFICADO', 'DESVERIFICAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('riocp.riocp_tramite', 'VERIFICADO', 'APROBAR', 'APROBADO', 'UPDATE');
INSERT INTO system.transition VALUES ('riocp.riocp_tramite', 'APROBADO', 'DESAPROBAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('capend.capacidad', 'INICIAL', 'CREAR', 'REGISTRADO', 'INSERT');
INSERT INTO system.transition VALUES ('capend.capacidad', 'REGISTRADO', 'ACTUALIZAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('capend.capacidad', 'REGISTRADO', 'ELIMINAR', 'FINAL', 'DELETE');
INSERT INTO system.transition VALUES ('capend.capacidad', 'REGISTRADO', 'VERIFICAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('capend.capacidad', 'VERIFICADO', 'DESVERIFICAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('capend.capacidad', 'VERIFICADO', 'APROBAR', 'APROBADO', 'UPDATE');
INSERT INTO system.transition VALUES ('capend.capacidad', 'APROBADO', 'DESAPROBAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('capend.capacidad_observa', 'INICIAL', 'CREAR', 'REGISTRADO', 'INSERT');
INSERT INTO system.transition VALUES ('capend.capacidad_observa', 'REGISTRADO', 'ACTUALIZAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('capend.capacidad_observa', 'REGISTRADO', 'ELIMINAR', 'FINAL', 'DELETE');
INSERT INTO system.transition VALUES ('capend.capacidad_observa', 'REGISTRADO', 'VERIFICAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('capend.capacidad_observa', 'VERIFICADO', 'DESVERIFICAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('capend.capacidad_observa', 'VERIFICADO', 'APROBAR', 'APROBADO', 'UPDATE');
INSERT INTO system.transition VALUES ('capend.capacidad_observa', 'APROBADO', 'DESAPROBAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('capend.capacidad_requisito', 'INICIAL', 'CREAR', 'REGISTRADO', 'INSERT');
INSERT INTO system.transition VALUES ('capend.capacidad_requisito', 'REGISTRADO', 'ACTUALIZAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('capend.capacidad_requisito', 'REGISTRADO', 'ELIMINAR', 'FINAL', 'DELETE');
INSERT INTO system.transition VALUES ('capend.capacidad_requisito', 'REGISTRADO', 'VERIFICAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('capend.capacidad_requisito', 'VERIFICADO', 'DESVERIFICAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('capend.capacidad_requisito', 'VERIFICADO', 'APROBAR', 'APROBADO', 'UPDATE');
INSERT INTO system.transition VALUES ('capend.capacidad_requisito', 'APROBADO', 'DESAPROBAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('capend.capacidad_tramite', 'INICIAL', 'CREAR', 'REGISTRADO', 'INSERT');
INSERT INTO system.transition VALUES ('capend.capacidad_tramite', 'REGISTRADO', 'ACTUALIZAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('capend.capacidad_tramite', 'REGISTRADO', 'ELIMINAR', 'FINAL', 'DELETE');
INSERT INTO system.transition VALUES ('capend.capacidad_tramite', 'REGISTRADO', 'VERIFICAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('capend.capacidad_tramite', 'VERIFICADO', 'DESVERIFICAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('capend.capacidad_tramite', 'VERIFICADO', 'APROBAR', 'APROBADO', 'UPDATE');
INSERT INTO system.transition VALUES ('capend.capacidad_tramite', 'APROBADO', 'DESAPROBAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('capend.capacidad', 'REGISTRADO', 'TRAMITAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('capend.capacidad_tramite', 'REGISTRADO', 'RESPONDER', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('capend.capacidad_tramite', 'REGISTRADO', 'ACTUALIZAR_IND', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('riocp.riocp', 'REGISTRADO', 'TRAMITAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('riocp.riocp_tramite', 'REGISTRADO', 'RESPONDER', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('riocp.riocp_tramite', 'REGISTRADO', 'ACTUALIZAR_CER', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('catalogo.entidades', 'INICIAL', 'CREAR', 'REGISTRADO', 'INSERT');
INSERT INTO system.transition VALUES ('catalogo.entidades', 'REGISTRADO', 'ACTUALIZAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('catalogo.entidades', 'REGISTRADO', 'ELIMINAR', 'FINAL', 'DELETE');
INSERT INTO system.transition VALUES ('catalogo.entidades', 'REGISTRADO', 'VERIFICAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('catalogo.entidades', 'VERIFICADO', 'DESVERIFICAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('catalogo.entidades', 'VERIFICADO', 'APROBAR', 'APROBADO', 'UPDATE');
INSERT INTO system.transition VALUES ('catalogo.entidades', 'APROBADO', 'DESAPROBAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('escenario.escenario', 'INICIAL', 'CREAR', 'REGISTRADO', 'INSERT');
INSERT INTO system.transition VALUES ('escenario.escenario', 'REGISTRADO', 'ACTUALIZAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('escenario.escenario', 'REGISTRADO', 'ELIMINAR', 'FINAL', 'DELETE');
INSERT INTO system.transition VALUES ('escenario.escenario', 'REGISTRADO', 'VERIFICAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('escenario.escenario', 'VERIFICADO', 'DESVERIFICAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('escenario.escenario', 'VERIFICADO', 'APROBAR', 'APROBADO', 'UPDATE');
INSERT INTO system.transition VALUES ('escenario.escenario', 'APROBADO', 'DESAPROBAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('catalogo.financiador', 'INICIAL', 'CREAR', 'REGISTRADO', 'INSERT');
INSERT INTO system.transition VALUES ('catalogo.financiador', 'REGISTRADO', 'ACTUALIZAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('catalogo.financiador', 'REGISTRADO', 'ELIMINAR', 'FINAL', 'DELETE');
INSERT INTO system.transition VALUES ('catalogo.financiador', 'REGISTRADO', 'VERIFICAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('catalogo.financiador', 'VERIFICADO', 'DESVERIFICAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('catalogo.financiador', 'VERIFICADO', 'APROBAR', 'APROBADO', 'UPDATE');
INSERT INTO system.transition VALUES ('catalogo.financiador', 'APROBADO', 'DESAPROBAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('escenario.importar', 'INICIAL', 'CREAR', 'REGISTRADO', 'INSERT');
INSERT INTO system.transition VALUES ('escenario.importar', 'REGISTRADO', 'ACTUALIZAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('escenario.importar', 'REGISTRADO', 'ELIMINAR', 'FINAL', 'DELETE');
INSERT INTO system.transition VALUES ('escenario.importar', 'REGISTRADO', 'VERIFICAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('escenario.importar', 'VERIFICADO', 'DESVERIFICAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('escenario.importar', 'VERIFICADO', 'APROBAR', 'APROBADO', 'UPDATE');
INSERT INTO system.transition VALUES ('escenario.importar', 'APROBADO', 'DESAPROBAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('catalogo.moneda', 'INICIAL', 'CREAR', 'REGISTRADO', 'INSERT');
INSERT INTO system.transition VALUES ('catalogo.moneda', 'REGISTRADO', 'ACTUALIZAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('catalogo.moneda', 'REGISTRADO', 'ELIMINAR', 'FINAL', 'DELETE');
INSERT INTO system.transition VALUES ('catalogo.moneda', 'REGISTRADO', 'VERIFICAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('catalogo.moneda', 'VERIFICADO', 'DESVERIFICAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('catalogo.moneda', 'VERIFICADO', 'APROBAR', 'APROBADO', 'UPDATE');
INSERT INTO system.transition VALUES ('catalogo.moneda', 'APROBADO', 'DESAPROBAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('escenario.origen', 'INICIAL', 'CREAR', 'REGISTRADO', 'INSERT');
INSERT INTO system.transition VALUES ('escenario.origen', 'REGISTRADO', 'ACTUALIZAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('escenario.origen', 'REGISTRADO', 'ELIMINAR', 'FINAL', 'DELETE');
INSERT INTO system.transition VALUES ('escenario.origen', 'REGISTRADO', 'VERIFICAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('escenario.origen', 'VERIFICADO', 'DESVERIFICAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('escenario.origen', 'VERIFICADO', 'APROBAR', 'APROBADO', 'UPDATE');
INSERT INTO system.transition VALUES ('escenario.origen', 'APROBADO', 'DESAPROBAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('catalogo.params', 'INICIAL', 'CREAR', 'REGISTRADO', 'INSERT');
INSERT INTO system.transition VALUES ('catalogo.params', 'REGISTRADO', 'ACTUALIZAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('catalogo.params', 'REGISTRADO', 'ELIMINAR', 'FINAL', 'DELETE');
INSERT INTO system.transition VALUES ('catalogo.params', 'REGISTRADO', 'VERIFICAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('catalogo.params', 'VERIFICADO', 'DESVERIFICAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('catalogo.params', 'VERIFICADO', 'APROBAR', 'APROBADO', 'UPDATE');
INSERT INTO system.transition VALUES ('catalogo.params', 'APROBADO', 'DESAPROBAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('catalogo.plantilla', 'INICIAL', 'CREAR', 'REGISTRADO', 'INSERT');
INSERT INTO system.transition VALUES ('catalogo.plantilla', 'REGISTRADO', 'ACTUALIZAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('catalogo.plantilla', 'REGISTRADO', 'ELIMINAR', 'FINAL', 'DELETE');
INSERT INTO system.transition VALUES ('catalogo.plantilla', 'REGISTRADO', 'VERIFICAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('catalogo.plantilla', 'VERIFICADO', 'DESVERIFICAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('catalogo.plantilla', 'VERIFICADO', 'APROBAR', 'APROBADO', 'UPDATE');
INSERT INTO system.transition VALUES ('catalogo.plantilla', 'APROBADO', 'DESAPROBAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('escenario.escenario', 'REGISTRADO', 'EDITAR_RATIO', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('escenario.escenario', 'REGISTRADO', 'EDITAR_SUPUESTO', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('escenario.montomaximo', 'INICIAL', 'CREAR', 'REGISTRADO', 'INSERT');
INSERT INTO system.transition VALUES ('escenario.montomaximo', 'REGISTRADO', 'ACTUALIZAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('escenario.montomaximo', 'REGISTRADO', 'ELIMINAR', 'FINAL', 'DELETE');
INSERT INTO system.transition VALUES ('escenario.montomaximo', 'REGISTRADO', 'VERIFICAR', 'VERIFICADO', 'UPDATE');
INSERT INTO system.transition VALUES ('escenario.montomaximo', 'VERIFICADO', 'DESVERIFICAR', 'REGISTRADO', 'UPDATE');
INSERT INTO system.transition VALUES ('escenario.montomaximo', 'VERIFICADO', 'APROBAR', 'APROBADO', 'UPDATE');
INSERT INTO system.transition VALUES ('escenario.montomaximo', 'APROBADO', 'DESAPROBAR', 'VERIFICADO', 'UPDATE');


--
-- TOC entry 3473 (class 0 OID 0)
-- Dependencies: 275
-- Name: seq_moduleid; Type: SEQUENCE SET; Schema: system; Owner: -
--

SELECT pg_catalog.setval('system.seq_moduleid', 30, true);


--
-- TOC entry 3474 (class 0 OID 0)
-- Dependencies: 276
-- Name: seq_roleid; Type: SEQUENCE SET; Schema: system; Owner: -
--

SELECT pg_catalog.setval('system.seq_roleid', 30, true);


--
-- TOC entry 3268 (class 2606 OID 70929)
-- Name: sys_module operacion_pkey; Type: CONSTRAINT; Schema: system; Owner: -
--

ALTER TABLE ONLY system.sys_module
    ADD CONSTRAINT operacion_pkey PRIMARY KEY (id);


--
-- TOC entry 3266 (class 2606 OID 70931)
-- Name: sys_assign rol_operacion_idx; Type: CONSTRAINT; Schema: system; Owner: -
--

ALTER TABLE ONLY system.sys_assign
    ADD CONSTRAINT rol_operacion_idx PRIMARY KEY (module_id, role_id);


--
-- TOC entry 3272 (class 2606 OID 70933)
-- Name: sys_role rol_pkey; Type: CONSTRAINT; Schema: system; Owner: -
--

ALTER TABLE ONLY system.sys_role
    ADD CONSTRAINT rol_pkey PRIMARY KEY (id);


--
-- TOC entry 3270 (class 2606 OID 70935)
-- Name: sys_module sys_module_idx; Type: CONSTRAINT; Schema: system; Owner: -
--

ALTER TABLE ONLY system.sys_module
    ADD CONSTRAINT sys_module_idx UNIQUE (name);


--
-- TOC entry 3274 (class 2606 OID 70937)
-- Name: sys_role sys_role_idx; Type: CONSTRAINT; Schema: system; Owner: -
--

ALTER TABLE ONLY system.sys_role
    ADD CONSTRAINT sys_role_idx UNIQUE (name);


--
-- TOC entry 3276 (class 2606 OID 70939)
-- Name: sys_user sys_user_email_key; Type: CONSTRAINT; Schema: system; Owner: -
--

ALTER TABLE ONLY system.sys_user
    ADD CONSTRAINT sys_user_email_key UNIQUE (email);


--
-- TOC entry 3278 (class 2606 OID 70941)
-- Name: sys_user sys_user_username_key; Type: CONSTRAINT; Schema: system; Owner: -
--

ALTER TABLE ONLY system.sys_user
    ADD CONSTRAINT sys_user_username_key UNIQUE (username);


--
-- TOC entry 3280 (class 2606 OID 70943)
-- Name: sys_user users_pkey; Type: CONSTRAINT; Schema: system; Owner: -
--

ALTER TABLE ONLY system.sys_user
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3284 (class 2620 OID 71070)
-- Name: sys_assign br_sysassign_adr; Type: TRIGGER; Schema: system; Owner: -
--

CREATE TRIGGER br_sysassign_adr AFTER DELETE ON system.sys_assign FOR EACH ROW EXECUTE FUNCTION system.fn_sysassign_adr();


--
-- TOC entry 3285 (class 2620 OID 71071)
-- Name: sys_assign br_sysassign_air; Type: TRIGGER; Schema: system; Owner: -
--

CREATE TRIGGER br_sysassign_air AFTER INSERT ON system.sys_assign FOR EACH ROW EXECUTE FUNCTION system.fn_sysassign_air();


--
-- TOC entry 3286 (class 2620 OID 71072)
-- Name: sys_assign br_sysassign_aur; Type: TRIGGER; Schema: system; Owner: -
--

CREATE TRIGGER br_sysassign_aur AFTER UPDATE ON system.sys_assign FOR EACH ROW EXECUTE FUNCTION system.fn_sysassign_aur();


--
-- TOC entry 3287 (class 2620 OID 71073)
-- Name: sys_assign br_sysassign_bdr; Type: TRIGGER; Schema: system; Owner: -
--

CREATE TRIGGER br_sysassign_bdr BEFORE DELETE ON system.sys_assign FOR EACH ROW EXECUTE FUNCTION system.fn_sysassign_bdr();


--
-- TOC entry 3288 (class 2620 OID 71074)
-- Name: sys_assign br_sysassign_bir; Type: TRIGGER; Schema: system; Owner: -
--

CREATE TRIGGER br_sysassign_bir BEFORE INSERT ON system.sys_assign FOR EACH ROW EXECUTE FUNCTION system.fn_sysassign_bir();


--
-- TOC entry 3289 (class 2620 OID 71075)
-- Name: sys_assign br_sysassign_bur; Type: TRIGGER; Schema: system; Owner: -
--

CREATE TRIGGER br_sysassign_bur BEFORE UPDATE ON system.sys_assign FOR EACH ROW EXECUTE FUNCTION system.fn_sysassign_bur();


--
-- TOC entry 3295 (class 2620 OID 71076)
-- Name: sys_module br_sysmodule_adr; Type: TRIGGER; Schema: system; Owner: -
--

CREATE TRIGGER br_sysmodule_adr AFTER DELETE ON system.sys_module FOR EACH ROW EXECUTE FUNCTION system.fn_sysmodule_adr();


--
-- TOC entry 3294 (class 2620 OID 71077)
-- Name: sys_module br_sysmodule_air; Type: TRIGGER; Schema: system; Owner: -
--

CREATE TRIGGER br_sysmodule_air AFTER INSERT ON system.sys_module FOR EACH ROW EXECUTE FUNCTION system.fn_sysmodule_air();


--
-- TOC entry 3293 (class 2620 OID 71078)
-- Name: sys_module br_sysmodule_aur; Type: TRIGGER; Schema: system; Owner: -
--

CREATE TRIGGER br_sysmodule_aur AFTER UPDATE ON system.sys_module FOR EACH ROW EXECUTE FUNCTION system.fn_sysmodule_aur();


--
-- TOC entry 3292 (class 2620 OID 71079)
-- Name: sys_module br_sysmodule_bdr; Type: TRIGGER; Schema: system; Owner: -
--

CREATE TRIGGER br_sysmodule_bdr BEFORE DELETE ON system.sys_module FOR EACH ROW EXECUTE FUNCTION system.fn_sysmodule_bdr();


--
-- TOC entry 3291 (class 2620 OID 71080)
-- Name: sys_module br_sysmodule_bir; Type: TRIGGER; Schema: system; Owner: -
--

CREATE TRIGGER br_sysmodule_bir BEFORE INSERT ON system.sys_module FOR EACH ROW EXECUTE FUNCTION system.fn_sysmodule_bir();


--
-- TOC entry 3290 (class 2620 OID 71081)
-- Name: sys_module br_sysmodule_bur; Type: TRIGGER; Schema: system; Owner: -
--

CREATE TRIGGER br_sysmodule_bur BEFORE UPDATE ON system.sys_module FOR EACH ROW EXECUTE FUNCTION system.fn_sysmodule_bur();


--
-- TOC entry 3296 (class 2620 OID 71082)
-- Name: sys_role br_sysrole_adr; Type: TRIGGER; Schema: system; Owner: -
--

CREATE TRIGGER br_sysrole_adr AFTER DELETE ON system.sys_role FOR EACH ROW EXECUTE FUNCTION system.fn_sysrole_adr();


--
-- TOC entry 3297 (class 2620 OID 71083)
-- Name: sys_role br_sysrole_air; Type: TRIGGER; Schema: system; Owner: -
--

CREATE TRIGGER br_sysrole_air AFTER INSERT ON system.sys_role FOR EACH ROW EXECUTE FUNCTION system.fn_sysrole_air();


--
-- TOC entry 3298 (class 2620 OID 71084)
-- Name: sys_role br_sysrole_aur; Type: TRIGGER; Schema: system; Owner: -
--

CREATE TRIGGER br_sysrole_aur AFTER UPDATE ON system.sys_role FOR EACH ROW EXECUTE FUNCTION system.fn_sysrole_aur();


--
-- TOC entry 3299 (class 2620 OID 71085)
-- Name: sys_role br_sysrole_bdr; Type: TRIGGER; Schema: system; Owner: -
--

CREATE TRIGGER br_sysrole_bdr BEFORE DELETE ON system.sys_role FOR EACH ROW EXECUTE FUNCTION system.fn_sysrole_bdr();


--
-- TOC entry 3300 (class 2620 OID 71086)
-- Name: sys_role br_sysrole_bir; Type: TRIGGER; Schema: system; Owner: -
--

CREATE TRIGGER br_sysrole_bir BEFORE INSERT ON system.sys_role FOR EACH ROW EXECUTE FUNCTION system.fn_sysrole_bir();


--
-- TOC entry 3301 (class 2620 OID 71087)
-- Name: sys_role br_sysrole_bur; Type: TRIGGER; Schema: system; Owner: -
--

CREATE TRIGGER br_sysrole_bur BEFORE UPDATE ON system.sys_role FOR EACH ROW EXECUTE FUNCTION system.fn_sysrole_bur();


--
-- TOC entry 3307 (class 2620 OID 71088)
-- Name: sys_user br_sysuser_adr; Type: TRIGGER; Schema: system; Owner: -
--

CREATE TRIGGER br_sysuser_adr AFTER DELETE ON system.sys_user FOR EACH ROW EXECUTE FUNCTION system.fn_sysuser_adr();


--
-- TOC entry 3306 (class 2620 OID 71089)
-- Name: sys_user br_sysuser_air; Type: TRIGGER; Schema: system; Owner: -
--

CREATE TRIGGER br_sysuser_air AFTER INSERT ON system.sys_user FOR EACH ROW EXECUTE FUNCTION system.fn_sysuser_air();


--
-- TOC entry 3305 (class 2620 OID 71090)
-- Name: sys_user br_sysuser_aur; Type: TRIGGER; Schema: system; Owner: -
--

CREATE TRIGGER br_sysuser_aur AFTER UPDATE ON system.sys_user FOR EACH ROW EXECUTE FUNCTION system.fn_sysuser_aur();


--
-- TOC entry 3304 (class 2620 OID 71091)
-- Name: sys_user br_sysuser_bdr; Type: TRIGGER; Schema: system; Owner: -
--

CREATE TRIGGER br_sysuser_bdr BEFORE DELETE ON system.sys_user FOR EACH ROW EXECUTE FUNCTION system.fn_sysuser_bdr();


--
-- TOC entry 3303 (class 2620 OID 71092)
-- Name: sys_user br_sysuser_bir; Type: TRIGGER; Schema: system; Owner: -
--

CREATE TRIGGER br_sysuser_bir BEFORE INSERT ON system.sys_user FOR EACH ROW EXECUTE FUNCTION system.fn_sysuser_bir();


--
-- TOC entry 3302 (class 2620 OID 71093)
-- Name: sys_user br_sysuser_bur; Type: TRIGGER; Schema: system; Owner: -
--

CREATE TRIGGER br_sysuser_bur BEFORE UPDATE ON system.sys_user FOR EACH ROW EXECUTE FUNCTION system.fn_sysuser_bur();

ALTER TABLE system.sys_user DISABLE TRIGGER br_sysuser_bur;


--
-- TOC entry 3281 (class 2606 OID 71254)
-- Name: sys_assign sys_assign_fk; Type: FK CONSTRAINT; Schema: system; Owner: -
--

ALTER TABLE ONLY system.sys_assign
    ADD CONSTRAINT sys_assign_fk FOREIGN KEY (role_id) REFERENCES system.sys_role(id) ON DELETE CASCADE;


--
-- TOC entry 3282 (class 2606 OID 71259)
-- Name: sys_assign sys_assign_fk1; Type: FK CONSTRAINT; Schema: system; Owner: -
--

ALTER TABLE ONLY system.sys_assign
    ADD CONSTRAINT sys_assign_fk1 FOREIGN KEY (module_id) REFERENCES system.sys_module(id);


--
-- TOC entry 3283 (class 2606 OID 71264)
-- Name: sys_user sys_user_fk; Type: FK CONSTRAINT; Schema: system; Owner: -
--

ALTER TABLE ONLY system.sys_user
    ADD CONSTRAINT sys_user_fk FOREIGN KEY (role_id) REFERENCES system.sys_role(id);


-- Completed on 2022-11-17 21:42:41

--
-- PostgreSQL database dump complete
--

