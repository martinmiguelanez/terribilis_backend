--
-- PostgreSQL database dump
--

\restrict laZ5rUzNLsbAf6aaENCRkRn6yfDS0PTGGdCkvKaYsxdKAUJuyze0pg8xBssZF21

-- Dumped from database version 17.9
-- Dumped by pg_dump version 17.9

-- Started on 2026-04-17 10:10:57

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE postgres;
--
-- TOC entry 5082 (class 1262 OID 5)
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Spain.1252';


ALTER DATABASE postgres OWNER TO postgres;

\unrestrict laZ5rUzNLsbAf6aaENCRkRn6yfDS0PTGGdCkvKaYsxdKAUJuyze0pg8xBssZF21
\connect postgres
\restrict laZ5rUzNLsbAf6aaENCRkRn6yfDS0PTGGdCkvKaYsxdKAUJuyze0pg8xBssZF21

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5083 (class 0 OID 0)
-- Dependencies: 5082
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 240 (class 1259 OID 16540)
-- Name: brumation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.brumation (
    id integer NOT NULL,
    species_id integer,
    requiere boolean,
    meses character varying(255),
    temperatura_min double precision,
    temperatura_max double precision,
    descripcion character varying(255)
);


ALTER TABLE public.brumation OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16539)
-- Name: brumation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.brumation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.brumation_id_seq OWNER TO postgres;

--
-- TOC entry 5084 (class 0 OID 0)
-- Dependencies: 239
-- Name: brumation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.brumation_id_seq OWNED BY public.brumation.id;


--
-- TOC entry 238 (class 1259 OID 16521)
-- Name: diet_food; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.diet_food (
    id integer NOT NULL,
    species_diet_id integer,
    food_id integer,
    porcentaje double precision
);


ALTER TABLE public.diet_food OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16520)
-- Name: diet_food_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.diet_food_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.diet_food_id_seq OWNER TO postgres;

--
-- TOC entry 5085 (class 0 OID 0)
-- Dependencies: 237
-- Name: diet_food_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.diet_food_id_seq OWNED BY public.diet_food.id;


--
-- TOC entry 232 (class 1259 OID 16488)
-- Name: diet_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.diet_type (
    id integer NOT NULL,
    nombre character varying(255)
);


ALTER TABLE public.diet_type OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16487)
-- Name: diet_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.diet_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.diet_type_id_seq OWNER TO postgres;

--
-- TOC entry 5086 (class 0 OID 0)
-- Dependencies: 231
-- Name: diet_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.diet_type_id_seq OWNED BY public.diet_type.id;


--
-- TOC entry 226 (class 1259 OID 16446)
-- Name: environment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.environment (
    id integer NOT NULL,
    species_id integer,
    temperatura_dia_min integer,
    temperatura_dia_max integer,
    temperatura_noche_min integer,
    temperatura_noche_max integer,
    humedad_min integer,
    humedad_max integer,
    uvb_requerido boolean,
    horas_luz integer
);


ALTER TABLE public.environment OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16445)
-- Name: environment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.environment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.environment_id_seq OWNER TO postgres;

--
-- TOC entry 5087 (class 0 OID 0)
-- Dependencies: 225
-- Name: environment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.environment_id_seq OWNED BY public.environment.id;


--
-- TOC entry 234 (class 1259 OID 16495)
-- Name: food; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.food (
    id integer NOT NULL,
    nombre character varying(255),
    tipo character varying(255)
);


ALTER TABLE public.food OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16494)
-- Name: food_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.food_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.food_id_seq OWNER TO postgres;

--
-- TOC entry 5088 (class 0 OID 0)
-- Dependencies: 233
-- Name: food_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.food_id_seq OWNED BY public.food.id;


--
-- TOC entry 228 (class 1259 OID 16460)
-- Name: habitat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.habitat (
    id integer NOT NULL,
    species_id integer,
    tipo character varying(255),
    tamano_minimo_cm character varying(255),
    volumen_litros integer,
    sustrato character varying(255),
    decoracion text,
    enriquecimiento text
);


ALTER TABLE public.habitat OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16459)
-- Name: habitat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.habitat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.habitat_id_seq OWNER TO postgres;

--
-- TOC entry 5089 (class 0 OID 0)
-- Dependencies: 227
-- Name: habitat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.habitat_id_seq OWNED BY public.habitat.id;


--
-- TOC entry 242 (class 1259 OID 16554)
-- Name: health_issue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.health_issue (
    id integer NOT NULL,
    nombre character varying(255),
    descripcion character varying(255)
);


ALTER TABLE public.health_issue OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16553)
-- Name: health_issue_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.health_issue_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.health_issue_id_seq OWNER TO postgres;

--
-- TOC entry 5090 (class 0 OID 0)
-- Dependencies: 241
-- Name: health_issue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.health_issue_id_seq OWNED BY public.health_issue.id;


--
-- TOC entry 230 (class 1259 OID 16474)
-- Name: natural_habitat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.natural_habitat (
    id integer NOT NULL,
    species_id integer,
    region character varying(255),
    clima character varying(255),
    bioma character varying(255),
    altitud character varying(255)
);


ALTER TABLE public.natural_habitat OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16473)
-- Name: natural_habitat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.natural_habitat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.natural_habitat_id_seq OWNER TO postgres;

--
-- TOC entry 5091 (class 0 OID 0)
-- Dependencies: 229
-- Name: natural_habitat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.natural_habitat_id_seq OWNED BY public.natural_habitat.id;


--
-- TOC entry 224 (class 1259 OID 16429)
-- Name: species; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.species (
    id integer NOT NULL,
    nombre_comun character varying(255) NOT NULL,
    nombre_cientifico character varying(255),
    descripcion character varying(255),
    origen character varying(255),
    esperanza_vida integer,
    tamano_promedio_cm integer,
    peso_promedio_gramos integer,
    actividad character varying(255),
    peligrosidad character varying(255),
    dificultad character varying(255),
    family_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.species OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16502)
-- Name: species_diet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.species_diet (
    id integer NOT NULL,
    species_id integer,
    diet_type_id integer,
    frecuencia character varying(255),
    observaciones character varying(255)
);


ALTER TABLE public.species_diet OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16501)
-- Name: species_diet_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.species_diet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.species_diet_id_seq OWNER TO postgres;

--
-- TOC entry 5092 (class 0 OID 0)
-- Dependencies: 235
-- Name: species_diet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.species_diet_id_seq OWNED BY public.species_diet.id;


--
-- TOC entry 244 (class 1259 OID 16563)
-- Name: species_health; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.species_health (
    id integer NOT NULL,
    species_id integer,
    health_issue_id integer,
    prevencion character varying(255)
);


ALTER TABLE public.species_health OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16562)
-- Name: species_health_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.species_health_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.species_health_id_seq OWNER TO postgres;

--
-- TOC entry 5093 (class 0 OID 0)
-- Dependencies: 243
-- Name: species_health_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.species_health_id_seq OWNED BY public.species_health.id;


--
-- TOC entry 223 (class 1259 OID 16428)
-- Name: species_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.species_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.species_id_seq OWNER TO postgres;

--
-- TOC entry 5094 (class 0 OID 0)
-- Dependencies: 223
-- Name: species_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.species_id_seq OWNED BY public.species.id;


--
-- TOC entry 246 (class 1259 OID 16582)
-- Name: species_image; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.species_image (
    id integer NOT NULL,
    species_id integer,
    url character varying(255),
    descripcion character varying(255)
);


ALTER TABLE public.species_image OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 16581)
-- Name: species_image_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.species_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.species_image_id_seq OWNER TO postgres;

--
-- TOC entry 5095 (class 0 OID 0)
-- Dependencies: 245
-- Name: species_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.species_image_id_seq OWNED BY public.species_image.id;


--
-- TOC entry 250 (class 1259 OID 17141)
-- Name: species_supplement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.species_supplement (
    id integer NOT NULL,
    species_id integer,
    supplement_id integer,
    observaciones character varying(255)
);


ALTER TABLE public.species_supplement OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 17140)
-- Name: species_supplement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.species_supplement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.species_supplement_id_seq OWNER TO postgres;

--
-- TOC entry 5096 (class 0 OID 0)
-- Dependencies: 249
-- Name: species_supplement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.species_supplement_id_seq OWNED BY public.species_supplement.id;


--
-- TOC entry 248 (class 1259 OID 17127)
-- Name: supplement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.supplement (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion character varying(255),
    marca character varying(100)
);


ALTER TABLE public.supplement OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 17126)
-- Name: supplement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.supplement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.supplement_id_seq OWNER TO postgres;

--
-- TOC entry 5097 (class 0 OID 0)
-- Dependencies: 247
-- Name: supplement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.supplement_id_seq OWNED BY public.supplement.id;


--
-- TOC entry 218 (class 1259 OID 16390)
-- Name: taxonomic_class; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.taxonomic_class (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.taxonomic_class OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16389)
-- Name: taxonomic_class_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.taxonomic_class_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.taxonomic_class_id_seq OWNER TO postgres;

--
-- TOC entry 5098 (class 0 OID 0)
-- Dependencies: 217
-- Name: taxonomic_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.taxonomic_class_id_seq OWNED BY public.taxonomic_class.id;


--
-- TOC entry 222 (class 1259 OID 16417)
-- Name: taxonomic_family; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.taxonomic_family (
    id integer NOT NULL,
    nombre character varying(255),
    order_id integer
);


ALTER TABLE public.taxonomic_family OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16416)
-- Name: taxonomic_family_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.taxonomic_family_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.taxonomic_family_id_seq OWNER TO postgres;

--
-- TOC entry 5099 (class 0 OID 0)
-- Dependencies: 221
-- Name: taxonomic_family_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.taxonomic_family_id_seq OWNED BY public.taxonomic_family.id;


--
-- TOC entry 220 (class 1259 OID 16405)
-- Name: taxonomic_order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.taxonomic_order (
    id integer NOT NULL,
    nombre character varying(255),
    class_id integer
);


ALTER TABLE public.taxonomic_order OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16404)
-- Name: taxonomic_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.taxonomic_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.taxonomic_order_id_seq OWNER TO postgres;

--
-- TOC entry 5100 (class 0 OID 0)
-- Dependencies: 219
-- Name: taxonomic_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.taxonomic_order_id_seq OWNED BY public.taxonomic_order.id;


--
-- TOC entry 4834 (class 2604 OID 16543)
-- Name: brumation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brumation ALTER COLUMN id SET DEFAULT nextval('public.brumation_id_seq'::regclass);


--
-- TOC entry 4833 (class 2604 OID 16524)
-- Name: diet_food id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diet_food ALTER COLUMN id SET DEFAULT nextval('public.diet_food_id_seq'::regclass);


--
-- TOC entry 4830 (class 2604 OID 16491)
-- Name: diet_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diet_type ALTER COLUMN id SET DEFAULT nextval('public.diet_type_id_seq'::regclass);


--
-- TOC entry 4827 (class 2604 OID 16449)
-- Name: environment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.environment ALTER COLUMN id SET DEFAULT nextval('public.environment_id_seq'::regclass);


--
-- TOC entry 4831 (class 2604 OID 16498)
-- Name: food id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.food ALTER COLUMN id SET DEFAULT nextval('public.food_id_seq'::regclass);


--
-- TOC entry 4828 (class 2604 OID 16463)
-- Name: habitat id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.habitat ALTER COLUMN id SET DEFAULT nextval('public.habitat_id_seq'::regclass);


--
-- TOC entry 4835 (class 2604 OID 16557)
-- Name: health_issue id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_issue ALTER COLUMN id SET DEFAULT nextval('public.health_issue_id_seq'::regclass);


--
-- TOC entry 4829 (class 2604 OID 16477)
-- Name: natural_habitat id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.natural_habitat ALTER COLUMN id SET DEFAULT nextval('public.natural_habitat_id_seq'::regclass);


--
-- TOC entry 4825 (class 2604 OID 16432)
-- Name: species id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.species ALTER COLUMN id SET DEFAULT nextval('public.species_id_seq'::regclass);


--
-- TOC entry 4832 (class 2604 OID 16505)
-- Name: species_diet id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.species_diet ALTER COLUMN id SET DEFAULT nextval('public.species_diet_id_seq'::regclass);


--
-- TOC entry 4836 (class 2604 OID 16566)
-- Name: species_health id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.species_health ALTER COLUMN id SET DEFAULT nextval('public.species_health_id_seq'::regclass);


--
-- TOC entry 4837 (class 2604 OID 16585)
-- Name: species_image id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.species_image ALTER COLUMN id SET DEFAULT nextval('public.species_image_id_seq'::regclass);


--
-- TOC entry 4839 (class 2604 OID 17144)
-- Name: species_supplement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.species_supplement ALTER COLUMN id SET DEFAULT nextval('public.species_supplement_id_seq'::regclass);


--
-- TOC entry 4838 (class 2604 OID 17130)
-- Name: supplement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplement ALTER COLUMN id SET DEFAULT nextval('public.supplement_id_seq'::regclass);


--
-- TOC entry 4822 (class 2604 OID 16393)
-- Name: taxonomic_class id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxonomic_class ALTER COLUMN id SET DEFAULT nextval('public.taxonomic_class_id_seq'::regclass);


--
-- TOC entry 4824 (class 2604 OID 16420)
-- Name: taxonomic_family id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxonomic_family ALTER COLUMN id SET DEFAULT nextval('public.taxonomic_family_id_seq'::regclass);


--
-- TOC entry 4823 (class 2604 OID 16408)
-- Name: taxonomic_order id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxonomic_order ALTER COLUMN id SET DEFAULT nextval('public.taxonomic_order_id_seq'::regclass);


--
-- TOC entry 5066 (class 0 OID 16540)
-- Dependencies: 240
-- Data for Name: brumation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.brumation VALUES (1, 1, false, '', 0, 0, '');
INSERT INTO public.brumation VALUES (2, 2, true, 'Juni-Agosto', 18, 0, 'Realiza un periodo de estivación durante la estación seca. Se reduce drásticamente la humedad y se cesa la alimentación. La rana se cubrirá completamente de su cera protectora y permanecerá inmóvil en las ramas más altas para conservar energía.');
INSERT INTO public.brumation VALUES (3, 3, false, '', 0, 0, '');
INSERT INTO public.brumation VALUES (4, 4, true, 'Diciembre-Febrero', 18, 0, 'Opcional pero recomendada para adultos sanos');
INSERT INTO public.brumation VALUES (5, 5, true, 'Diciembre-Febrero', 18, 0, 'Opcional pero recomendada para adultos sanos');
INSERT INTO public.brumation VALUES (6, 6, false, '', 0, 0, '');
INSERT INTO public.brumation VALUES (8, 8, false, '3 meses', 12, 0, 'equieren un periodo de diapausa (enfriamiento) en invierno para estimular su salud y ciclo reproductivo');
INSERT INTO public.brumation VALUES (9, 9, true, '3 meses', 12, 0, 'Si es solo mascota, no es necesario');
INSERT INTO public.brumation VALUES (10, 10, false, '', 0, 0, 'No requiere, pero pasan por una "estación seca" menos húmeda en libertad.');
INSERT INTO public.brumation VALUES (11, 11, false, '', 0, 0, 'Realizan un proceso llamado Estivación si el ambiente se seca: crean una capa de piel seca protectora y se entierran meses.');


--
-- TOC entry 5064 (class 0 OID 16521)
-- Dependencies: 238
-- Data for Name: diet_food; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.diet_food VALUES (1, 1, 10, NULL);
INSERT INTO public.diet_food VALUES (2, 1, 11, NULL);
INSERT INTO public.diet_food VALUES (3, 1, 12, NULL);
INSERT INTO public.diet_food VALUES (4, 2, 1, NULL);
INSERT INTO public.diet_food VALUES (5, 2, 2, NULL);
INSERT INTO public.diet_food VALUES (6, 2, 3, NULL);
INSERT INTO public.diet_food VALUES (7, 2, 4, NULL);
INSERT INTO public.diet_food VALUES (8, 2, 8, NULL);
INSERT INTO public.diet_food VALUES (9, 3, 1, NULL);
INSERT INTO public.diet_food VALUES (10, 3, 3, NULL);
INSERT INTO public.diet_food VALUES (11, 3, 4, NULL);
INSERT INTO public.diet_food VALUES (12, 3, 8, NULL);
INSERT INTO public.diet_food VALUES (13, 4, 1, NULL);
INSERT INTO public.diet_food VALUES (14, 4, 3, NULL);
INSERT INTO public.diet_food VALUES (15, 4, 4, NULL);
INSERT INTO public.diet_food VALUES (16, 4, 6, NULL);
INSERT INTO public.diet_food VALUES (17, 5, 1, NULL);
INSERT INTO public.diet_food VALUES (18, 5, 3, NULL);
INSERT INTO public.diet_food VALUES (19, 5, 4, NULL);
INSERT INTO public.diet_food VALUES (20, 6, 4, NULL);
INSERT INTO public.diet_food VALUES (21, 6, 26, NULL);
INSERT INTO public.diet_food VALUES (22, 6, 27, NULL);
INSERT INTO public.diet_food VALUES (23, 6, 30, NULL);
INSERT INTO public.diet_food VALUES (26, 8, 1, NULL);
INSERT INTO public.diet_food VALUES (27, 8, 3, NULL);
INSERT INTO public.diet_food VALUES (28, 9, 13, NULL);
INSERT INTO public.diet_food VALUES (29, 9, 14, NULL);
INSERT INTO public.diet_food VALUES (30, 9, 15, NULL);
INSERT INTO public.diet_food VALUES (31, 10, 1, NULL);
INSERT INTO public.diet_food VALUES (32, 11, 1, NULL);
INSERT INTO public.diet_food VALUES (33, 11, 4, NULL);
INSERT INTO public.diet_food VALUES (34, 11, 15, NULL);


--
-- TOC entry 5058 (class 0 OID 16488)
-- Dependencies: 232
-- Data for Name: diet_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.diet_type VALUES (1, 'Insectívoro');
INSERT INTO public.diet_type VALUES (2, 'Carnívoro');
INSERT INTO public.diet_type VALUES (3, 'Herbívoro');
INSERT INTO public.diet_type VALUES (4, 'Omnívoro');
INSERT INTO public.diet_type VALUES (5, 'Frugívoro');
INSERT INTO public.diet_type VALUES (6, 'Piscívoro');
INSERT INTO public.diet_type VALUES (7, 'Molusquívoro');


--
-- TOC entry 5052 (class 0 OID 16446)
-- Dependencies: 226
-- Data for Name: environment; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.environment VALUES (1, 1, 24, 27, 20, 22, 70, 90, false, 12);
INSERT INTO public.environment VALUES (2, 2, 26, 32, 20, 28, 50, 60, true, 12);
INSERT INTO public.environment VALUES (3, 3, 24, 35, 18, 26, 50, 60, true, 12);
INSERT INTO public.environment VALUES (4, 4, 24, 32, 20, 28, 30, 40, false, 12);
INSERT INTO public.environment VALUES (5, 5, 24, 28, 20, 25, 50, 70, false, 12);
INSERT INTO public.environment VALUES (6, 6, 22, 26, 18, 24, 50, 70, false, 12);
INSERT INTO public.environment VALUES (8, 8, 20, 25, 16, 22, 60, 90, true, 12);
INSERT INTO public.environment VALUES (9, 9, 22, 30, 20, 28, 40, 50, false, 12);
INSERT INTO public.environment VALUES (10, 10, 22, 27, 20, 25, 60, 70, false, 12);
INSERT INTO public.environment VALUES (11, 11, 24, 30, 20, 26, 70, 80, false, 12);


--
-- TOC entry 5060 (class 0 OID 16495)
-- Dependencies: 234
-- Data for Name: food; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.food VALUES (1, 'Grillo Acheta', NULL);
INSERT INTO public.food VALUES (2, 'Grillo Bimaculatus', NULL);
INSERT INTO public.food VALUES (3, 'Langosta migratoria', NULL);
INSERT INTO public.food VALUES (4, 'Cucaracha Dubia', NULL);
INSERT INTO public.food VALUES (5, 'Cucaracha Runner', NULL);
INSERT INTO public.food VALUES (6, 'Tenebrio molitor', NULL);
INSERT INTO public.food VALUES (7, 'Zophobas morio', NULL);
INSERT INTO public.food VALUES (8, 'Gusano de seda', NULL);
INSERT INTO public.food VALUES (9, 'Drosophila melanogaster', NULL);
INSERT INTO public.food VALUES (10, 'Drosophila hydei', NULL);
INSERT INTO public.food VALUES (11, 'Colémbolos', NULL);
INSERT INTO public.food VALUES (12, 'Cochinilla de la jungla', NULL);
INSERT INTO public.food VALUES (13, 'Ratón Pinky', NULL);
INSERT INTO public.food VALUES (14, 'Ratón Primer pelo', NULL);
INSERT INTO public.food VALUES (15, 'Ratón Adulto', NULL);
INSERT INTO public.food VALUES (16, 'Rata Puppy', NULL);
INSERT INTO public.food VALUES (17, 'Rata Adulta', NULL);
INSERT INTO public.food VALUES (18, 'Pollito de un día', NULL);
INSERT INTO public.food VALUES (19, 'Codorniz', NULL);
INSERT INTO public.food VALUES (20, 'Escarola', NULL);
INSERT INTO public.food VALUES (21, 'Canónigos', NULL);
INSERT INTO public.food VALUES (22, 'Rúcula', NULL);
INSERT INTO public.food VALUES (23, 'Diente de león', NULL);
INSERT INTO public.food VALUES (24, 'Calabacín', NULL);
INSERT INTO public.food VALUES (25, 'Zanahoria', NULL);
INSERT INTO public.food VALUES (26, 'Papaya', NULL);
INSERT INTO public.food VALUES (27, 'Higo', NULL);
INSERT INTO public.food VALUES (28, 'Manzana (sin semillas)', NULL);
INSERT INTO public.food VALUES (29, 'Pienso extrusionado', NULL);
INSERT INTO public.food VALUES (30, 'Gelatina de frutas', NULL);
INSERT INTO public.food VALUES (31, 'Pescado de río', NULL);
INSERT INTO public.food VALUES (32, 'Caracoles/Babosas', NULL);


--
-- TOC entry 5054 (class 0 OID 16460)
-- Dependencies: 228
-- Data for Name: habitat; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.habitat VALUES (1, 1, 'Terrario Selva / Tropical Húmedo', '45x45x45', 45, 'Fibra de Coco, Musgo Sphagnum, Hojarasca Roble/Encina', 'Ramas/Troncos, Plantas Naturales/Bioactivo, Cueva/Refugio Seco, Piscina', 'Presa viva (Caza)');
INSERT INTO public.habitat VALUES (2, 2, 'Terrario Bosque Templado', '45x45x60', 60, 'Fibra de Coco, Hojarasca Roble/Encina, Papel de Cocina', 'Zona Caliente (Basking), Ramas/Troncos, Plantas Naturales/Bioactivo, Bebedero/Piscina, Piscina', 'Presa viva (Caza), Fondos 3D Escalables');
INSERT INTO public.habitat VALUES (3, 3, 'Flexarium', '60x45x90', 100, 'Fibra de Coco, Papel de Cocina', 'Zona Caliente (Basking), Ramas/Troncos, Plantas Naturales/Bioactivo, Lianas/Cuerdas', 'Presa viva (Caza), Sistema de Lluvia');
INSERT INTO public.habitat VALUES (4, 4, 'Terrario Desértico / Árido', '60x45x30', 50, 'Fibra de Coco, Arena de Desierto, Arcilla/Excavator, Papel de Cocina', 'Zona Caliente (Basking), Refugio Húmedo, Zona Fría, Ramas/Troncos, Rocas/Piedras Pizarra, Cueva/Refugio Seco, Bebedero/Piscina', 'Zonas de excavación, Presa viva (Caza), Fondos 3D Escalables');
INSERT INTO public.habitat VALUES (5, 5, 'Terrario Selva / Tropical Húmedo', '45x45x60', NULL, 'Fibra de Coco, Musgo Sphagnum, Papel de Cocina', 'Ramas/Troncos, Plantas Naturales/Bioactivo, Lianas/Cuerdas, Piscina', 'Presa viva (Caza), Fondos 3D Escalables');
INSERT INTO public.habitat VALUES (6, 6, 'Terrario Selva / Tropical Húmedo', '45x45x60', NULL, 'Fibra de Coco', 'Ramas/Troncos, Plantas Naturales/Bioactivo, Cueva/Refugio Seco, Lianas/Cuerdas, Bebedero/Piscina', 'Presa viva (Caza), Fondos 3D Escalables');
INSERT INTO public.habitat VALUES (8, 8, 'Flexarium', '120x100x200', NULL, 'Fibra de Coco, Turba Rubia', 'Zona Caliente (Basking), Ramas/Troncos, Plantas Naturales/Bioactivo, Lianas/Cuerdas', 'Presa viva (Caza), Sistema de Lluvia, Fondos 3D Escalables');
INSERT INTO public.habitat VALUES (9, 9, 'Terrario Bosque Templado', '100x50x50', NULL, 'Fibra de Coco, Arena de Desierto, Turba Rubia, Papel de Cocina', 'Zona Caliente (Basking), Refugio Húmedo, Ramas/Troncos, Rocas/Piedras Pizarra, Cueva/Refugio Seco, Bebedero/Piscina', 'Fondos 3D Escalables');
INSERT INTO public.habitat VALUES (10, 10, 'Terrario Selva / Tropical Húmedo', '45x45x60', NULL, 'Fibra de Coco, Musgo Sphagnum', 'Plantas Naturales/Bioactivo, Piscina', 'Presa viva (Caza)');
INSERT INTO public.habitat VALUES (11, 11, 'Terrario Semitropical / Sabana', '30x30x30', NULL, 'Fibra de Coco, Musgo Sphagnum', 'Plantas Naturales/Bioactivo, Bebedero/Piscina', 'Zonas de excavación');


--
-- TOC entry 5068 (class 0 OID 16554)
-- Dependencies: 242
-- Data for Name: health_issue; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.health_issue VALUES (1, 'Disecdisis', 'Retención de muda por falta de humedad o hidratación.');
INSERT INTO public.health_issue VALUES (2, 'Ácaros (Ophionyssus)', 'Parásitos externos hematófagos, requieren tratamiento químico.');
INSERT INTO public.health_issue VALUES (3, 'Estomatitis Infecciosa', 'Necrosis en tejidos bucales, común por estrés o mala higiene.');
INSERT INTO public.health_issue VALUES (4, 'Neumonía / I.R.', 'Dificultad respiratoria, mucosidad o sibilancias al respirar.');
INSERT INTO public.health_issue VALUES (5, 'EOM (MBD)', 'Descalcificación ósea grave por ratio Ca:P incorrecto o falta de UVB.');
INSERT INTO public.health_issue VALUES (6, 'Impactación', 'Obstrucción del tracto digestivo por sustrato o presas demasiado grandes.');
INSERT INTO public.health_issue VALUES (7, 'Distocia', 'Retención de huevos (unión de huevos) en hembras, urgencia veterinaria.');
INSERT INTO public.health_issue VALUES (8, 'Septicemia', 'Infección sistémica bacteriana (síndrome de pata roja en anfibios).');
INSERT INTO public.health_issue VALUES (9, 'Quitridiomicosis', 'Hongo letal en anfibios que afecta la queratina de la piel.');
INSERT INTO public.health_issue VALUES (10, 'Criptosporidiosis', 'Parásito protozoo muy contagioso y grave en serpientes y gecos.');


--
-- TOC entry 5056 (class 0 OID 16474)
-- Dependencies: 230
-- Data for Name: natural_habitat; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.natural_habitat VALUES (1, 1, 'América del Sur (Amazonía/Chaco)', 'Tropical Húmedo', 'Selva Perennifolia', '');
INSERT INTO public.natural_habitat VALUES (2, 2, 'América del Sur (Amazonía/Chaco)', 'Ecuatorial', 'Bosque Seco Tropical', '0-1000');
INSERT INTO public.natural_habitat VALUES (3, 3, 'Asia (Oriente Medio)', 'Subtropical', 'Bosque Seco Tropical', '');
INSERT INTO public.natural_habitat VALUES (4, 4, '', '', '', '');
INSERT INTO public.natural_habitat VALUES (5, 5, 'Oceanía (Australia/N. Zelanda)', 'Tropical Húmedo', 'Selva Perennifolia', '');
INSERT INTO public.natural_habitat VALUES (6, 6, 'Oceanía (Australia/N. Zelanda)', 'Subtropical', 'Selva Perennifolia', '0-1000');
INSERT INTO public.natural_habitat VALUES (7, 8, 'Madagascar e Islas', 'Tropical Húmedo', 'Selva Perennifolia', '0-1000');
INSERT INTO public.natural_habitat VALUES (8, 9, 'América del Norte', 'Subtropical', 'Pradera / Pastizal', '0-1000');
INSERT INTO public.natural_habitat VALUES (9, 10, 'América Central y Caribe', 'Tropical Húmedo', 'Selva Perennifolia', '0-1000');
INSERT INTO public.natural_habitat VALUES (10, 11, 'América del Sur (Amazonía/Chaco)', 'Tropical Monzónico', 'Sabana Arbolada', '0-1000');


--
-- TOC entry 5050 (class 0 OID 16429)
-- Dependencies: 224
-- Data for Name: species; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.species VALUES (4, 'Gecko Leopardo', 'Eublepharis macularius', 'Lagarto terrestre originario de zonas semidesérticas. Es conocido por su cola gruesa (donde almacena grasa) y su dócil temperamento. Existe una enorme variedad de "fases" o colores creados en cautividad.', NULL, 20, 25, 80, 'Nocturno', 'Nula (Inofensivo)', 'Principiante', 7, '2026-04-16 13:43:24.556016');
INSERT INTO public.species VALUES (1, 'Rana Dardo Dorada (Yellow)', 'Phyllobates Terribilis Yellow', 'Es el vertebrado más tóxico del mundo en estado salvaje. La variedad "Yellow" es de un amarillo intenso y uniforme. Es una especie muy descarada y activa, nada asustadiza comparada con otras Dendrobates.', NULL, 15, 5, 15, 'Diurno', 'Media (Manejo experto / Veneno no letal)', 'Media', 27, '2026-04-16 13:13:08.696473');
INSERT INTO public.species VALUES (2, 'Rana Mono de Cera', 'Phyllomedusa sauvagii', 'Originaria del Chaco (Sudamérica). Se mueve de forma lenta y prensil, como un primate. Secreta lípidos cutáneos que extiende por su cuerpo con las patas para sellar la humedad.', NULL, 15, 8, 60, 'Nocturno', 'Nula (Inofensivo)', 'Media', 30, '2026-04-16 13:20:57.557907');
INSERT INTO public.species VALUES (3, 'Camaleón del Yemen / Camaleón Velado', 'Chamaeleo calyptratus', 'Posee una cresta craneal alta llamada casco. Son arborícolas estrictos y muy territoriales. Cambian de color no para camuflarse con el entorno, sino para regular su temperatura y comunicar su estado de ánimo.', NULL, 8, 60, 200, 'Diurno', 'Baja (Posible mordisco/picadura leve)', 'Media', 11, '2026-04-16 13:30:44.793874');
INSERT INTO public.species VALUES (5, 'Rana Arborícola de White', 'Litoria caerulea', 'Rana arborícola de color verde brillante, famosa por su carácter dócil y su aspecto "sonriente".', NULL, 15, 10, 90, 'Nocturno', 'Nula (Inofensivo)', 'Principiante', 29, '2026-04-16 14:07:05.337323');
INSERT INTO public.species VALUES (6, 'Geco Crestado', 'Correlophus Ciliatus', 'Geco arborícola originario de Nueva Caledonia, famoso por sus proyecciones sobre los ojos que parecen pestañas.', NULL, 20, 20, 55, 'Nocturno', 'Nula (Inofensivo)', 'Principiante', 9, '2026-04-16 14:52:19.066244');
INSERT INTO public.species VALUES (8, 'Camaleón de Parson', 'Calumma parsonii', 'Un titán entre los camaleones. De color verde turquesa o amarillento, con una estructura ósea masiva y un temperamento muy calmado.', NULL, 20, 70, 800, 'Diurno', 'Nula (Inofensivo)', 'Avanzada', 11, '2026-04-16 15:25:34.166185');
INSERT INTO public.species VALUES (9, 'Serpiente del Maíz', 'Pantherophis guttatus', 'Serpiente dócil y de colores vibrantes (originalmente naranja y roja). Excelente para quienes se inician en el mundo de los ofidios.', NULL, 18, 150, 900, 'Crepuscular', 'Nula (Inofensivo)', 'Principiante', 3, '2026-04-16 15:33:31.434398');
INSERT INTO public.species VALUES (10, 'Rana de Ojos Rojos', 'Agalychnis callidryas', 'Famosa por sus costados azules y amarillos y sus enormes ojos rojos. Son expertas en el camuflaje disruptivo.', NULL, 10, 7, 17, 'Nocturno', 'Nula (Inofensivo)', 'Media', 30, '2026-04-16 15:41:57.308736');
INSERT INTO public.species VALUES (11, 'Rana Pacman / Escuerzo de Cranwell', 'Ceratophrys cranwelli', 'Cuerpo redondeado y boca inmensa. Existen en colores verde, albino (amarillo), "strawberry" y marrón.', NULL, 10, 15, 500, 'Nocturno', 'Baja (Posible mordisco/picadura leve)', 'Principiante', 31, '2026-04-16 15:52:54.865173');


--
-- TOC entry 5062 (class 0 OID 16502)
-- Dependencies: 236
-- Data for Name: species_diet; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.species_diet VALUES (1, 1, 1, 'Diaria', '');
INSERT INTO public.species_diet VALUES (2, 2, 1, '2-3 veces por semana', '');
INSERT INTO public.species_diet VALUES (3, 3, 1, 'Días alternos', '');
INSERT INTO public.species_diet VALUES (4, 4, 1, '2-3 veces por semana', '');
INSERT INTO public.species_diet VALUES (5, 5, 1, '2-3 veces por semana', 'Tienden a la obesidad. Controlar la cantidad de comida.');
INSERT INTO public.species_diet VALUES (6, 6, 5, 'Días alternos', 'La base suele ser papilla comercial (Pangea/Repashy). Ofrecer insectos ocasionalmente para fomentar la caza.');
INSERT INTO public.species_diet VALUES (8, 8, 1, '2-3 veces por semana', 'Beben únicamente de gotas en las hojas o sistemas de goteo constantes. No toleran bien el exceso de suplementos vitamínicos.');
INSERT INTO public.species_diet VALUES (9, 9, 2, 'Semanal', 'Se recomienda alimentar fuera del terrario en un recipiente aparte para evitar la ingesta de sustrato y la asociación de "mano = comida".');
INSERT INTO public.species_diet VALUES (10, 10, 1, '2-3 veces por semana', 'Son cazadoras visuales; solo comen insectos que se muevan mucho. No aceptan comida muerta.');
INSERT INTO public.species_diet VALUES (11, 11, 4, 'Semanal', 'Son propensas a la obesidad. Se les puede acostumbrar a comer de pinzas. Cuidado con los dedos, confunden cualquier movimiento con comida.');


--
-- TOC entry 5070 (class 0 OID 16563)
-- Dependencies: 244
-- Data for Name: species_health; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.species_health VALUES (14, 1, 8, 'Controlar calidad de agua y sustrato para evitar parásitos internos');
INSERT INTO public.species_health VALUES (15, 1, 9, 'Mantener higiene estricta para evitar infecciones fúngicas cutáneas');
INSERT INTO public.species_health VALUES (16, 2, 4, 'Asegurar niveles de calcio; son propensas a debilidad ósea por falta de UVB');
INSERT INTO public.species_health VALUES (17, 2, 5, 'Vigilar la correcta hidratación y niveles de Vitamina D3');
INSERT INTO public.species_health VALUES (18, 2, 6, 'Asegurar que la humedad no baje del 40% durante el día para facilitar la muda');
INSERT INTO public.species_health VALUES (19, 3, 4, 'Uso obligatorio de UVB 5.0/6.0 para prevenir EMO (Enfermedad Metabólica Ósea)');
INSERT INTO public.species_health VALUES (20, 3, 5, 'Suplementar con calcio sin D3 en cada toma para evitar deformidades óseas');
INSERT INTO public.species_health VALUES (21, 4, 1, 'Proveer refugio húmedo con musgo para evitar retención de muda en los dedos');
INSERT INTO public.species_health VALUES (22, 4, 6, 'Vigilar que el sustrato no sea arena para evitar impactaciones intestinales');
INSERT INTO public.species_health VALUES (23, 4, 5, 'Suplementar con calcio y D3 para evitar el síndrome de Enigma o MBD');
INSERT INTO public.species_health VALUES (24, 5, 5, 'Evitar el exceso de alimentación para prevenir la obesidad y letargia');
INSERT INTO public.species_health VALUES (25, 5, 9, 'Mantener buena ventilación para evitar infecciones bacterianas por estancamiento de aire');
INSERT INTO public.species_health VALUES (26, 6, 5, 'Asegurar aporte de calcio y vitaminas; vigilar que la mandíbula no se ablande');
INSERT INTO public.species_health VALUES (27, 6, 6, 'Pulverizar por la noche para ayudar a desprender la piel de la cabeza y crestas');
INSERT INTO public.species_health VALUES (29, 8, 4, 'Jamás usar terrarios cerrados de cristal. La ventilación cruzada es innegociable');
INSERT INTO public.species_health VALUES (30, 9, 1, 'Ofrecer un refugio húmedo con musgo cuando los ojos se vuelvan azulados (fase opaca)');
INSERT INTO public.species_health VALUES (31, 9, 2, 'Revisar la piel y el bebedero periódicamente en busca de pequeños puntos negros');
INSERT INTO public.species_health VALUES (32, 10, 4, 'Asegurar ventilación parcial para que el aire no se estanque');
INSERT INTO public.species_health VALUES (33, 10, 9, 'Extrema higiene: el agua del bebedero o piscina debe ser declorada y cambiada a diario');
INSERT INTO public.species_health VALUES (34, 11, 5, 'Debido a su rápido crecimiento, el calcio con D3 es crítico para evitar deformaciones en la mandíbula');
INSERT INTO public.species_health VALUES (35, 11, 6, 'Alimentar con pinzas o en una zona limpia para evitar que traguen fibra de coco al cazar');


--
-- TOC entry 5072 (class 0 OID 16582)
-- Dependencies: 246
-- Data for Name: species_image; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.species_image VALUES (1, 1, '/img/species/phyllobatesTerribilisYellow.jpg', 'Imagen Principal');
INSERT INTO public.species_image VALUES (2, 2, '/img/species/phyllomedusaSauvagii.jpg', 'Imagen Principal');
INSERT INTO public.species_image VALUES (3, 2, '/img/species/phyllomedusaSauvagii2.jpg', 'Imagen Principal');
INSERT INTO public.species_image VALUES (4, 3, '/img/species/chamaeleoCalyptratus.jpg', 'Imagen Principal');
INSERT INTO public.species_image VALUES (5, 4, '/img/species/eublepharisMacularius.jpg', 'Imagen Principal');
INSERT INTO public.species_image VALUES (6, 5, '/img/species/litoriaCaerulea.jpg', 'Imagen Principal');
INSERT INTO public.species_image VALUES (7, 6, '/img/species/correlophusCiliatus.jpg', 'Imagen Principal');
INSERT INTO public.species_image VALUES (9, 8, 'https://upload.wikimedia.org/wikipedia/commons/5/5d/Parson%27s_Chameleon_%28Calumma_parsonii%29_%2810313932313%29.jpg', 'Imagen Principal');
INSERT INTO public.species_image VALUES (10, 6, '/img/species/correlophusCiliatus2.jpg', 'Imagen Principal');
INSERT INTO public.species_image VALUES (11, 9, '/img/species/pantherophisGuttatus.jpg', 'Imagen Principal');
INSERT INTO public.species_image VALUES (12, 10, '/img/species/agalychnisCallidryas.jpg', 'Imagen Principal');
INSERT INTO public.species_image VALUES (13, 9, 'https://www.mascotasalgama.com/image/cache/catalog/nominal%20(1)-600x600.jpg', 'Imagen Principal');
INSERT INTO public.species_image VALUES (15, 11, 'https://imagenes.20minutos.es/files/image_1280_auto/uploads/imagenes/2023/06/16/rana-pacman-1.jpeg', 'Imagen Principal');
INSERT INTO public.species_image VALUES (14, 11, 'https://imagenes.20minutos.es/files/image_990_auto/uploads/imagenes/2023/06/16/ejemplar-de-rana-pacman.jpeg', 'Imagen Principal');
INSERT INTO public.species_image VALUES (16, 11, 'https://preview.redd.it/my-samurai-blue-pac-man-frog-v0-h9s0x8hgbly91.jpg?width=1080&crop=smart&auto=webp&s=5f50e429cfee4a9ab6810729299197dbf7da1d7b', 'Imagen Principal');


--
-- TOC entry 5076 (class 0 OID 17141)
-- Dependencies: 250
-- Data for Name: species_supplement; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.species_supplement VALUES (1, 1, 10, 'Vital 1 vez por semana para prevenir el síndrome de pata pegajosa');
INSERT INTO public.species_supplement VALUES (2, 1, 13, 'En cada toma de insectos');
INSERT INTO public.species_supplement VALUES (3, 1, 16, 'Para mantener el amarillo brillante e intenso');
INSERT INTO public.species_supplement VALUES (4, 2, 2, 'Uso regular en cada comida debido a sus necesidades de asoleamiento');
INSERT INTO public.species_supplement VALUES (5, 2, 11, '1 vez cada 15 días');
INSERT INTO public.species_supplement VALUES (6, 3, 6, 'En casi todas las tomas de insectos');
INSERT INTO public.species_supplement VALUES (7, 3, 7, '2 veces al mes si el UVB es correcto');
INSERT INTO public.species_supplement VALUES (8, 3, 11, '1 vez al mes');
INSERT INTO public.species_supplement VALUES (9, 3, 17, 'Mezclado con los insectos para extra de energía');
INSERT INTO public.species_supplement VALUES (10, 4, 2, 'Una vez a la semana con el alimento');
INSERT INTO public.species_supplement VALUES (11, 4, 3, '1 vez cada dos semana');
INSERT INTO public.species_supplement VALUES (12, 4, 6, 'Se puede dejar un taponcito con este polvo dentro del terrario para que el geco lo lama cuando necesite');
INSERT INTO public.species_supplement VALUES (13, 5, 2, '2 veces por semana');
INSERT INTO public.species_supplement VALUES (14, 5, 3, 'Una vez por semana');
INSERT INTO public.species_supplement VALUES (15, 6, 2, '');
INSERT INTO public.species_supplement VALUES (16, 8, 1, 'Cada dos tomas');
INSERT INTO public.species_supplement VALUES (17, 8, 3, '1 vez al mes');
INSERT INTO public.species_supplement VALUES (18, 9, 1, 'muy ocasional, ya que lo obtienen de los huesos del ratón');
INSERT INTO public.species_supplement VALUES (19, 10, 2, 'Siempre');
INSERT INTO public.species_supplement VALUES (20, 10, 3, 'Una vez por semana');
INSERT INTO public.species_supplement VALUES (21, 11, 2, 'Con los insectos');
INSERT INTO public.species_supplement VALUES (22, 11, 3, 'Dos veces al mes');


--
-- TOC entry 5074 (class 0 OID 17127)
-- Dependencies: 248
-- Data for Name: supplement; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.supplement VALUES (1, 'Calcio', 'Calcio puro sin fósforo ni vitamina D3. Uso diario.', '');
INSERT INTO public.supplement VALUES (2, 'Calcio con D3', 'Calcio con aporte de vitamina D3 para asimilación de UV.', '');
INSERT INTO public.supplement VALUES (3, 'Multivitamínico', 'Complejo de vitaminas y minerales esenciales.', '');
INSERT INTO public.supplement VALUES (4, 'Vitamina A', 'Suplemento específico de Vitamina A (importante para anfibios).', '');
INSERT INTO public.supplement VALUES (5, 'Calcio + Magnesio', 'Refuerzo óseo avanzado.', '');
INSERT INTO public.supplement VALUES (6, 'Calcio Sin D3 (Fino)', 'Calcio en polvo ultra fino, sin fósforo. Para animales con mucha radiación UVB.', 'Exo Terra');
INSERT INTO public.supplement VALUES (7, 'Calcio + D3 (Low)', 'Calcio con niveles bajos de D3 para animales de bosque o sombra.', 'Zoo Med');
INSERT INTO public.supplement VALUES (8, 'Calcio + D3 (High)', 'Calcio con altos niveles de D3 para especies desérticas o sin UVB.', 'Repashy');
INSERT INTO public.supplement VALUES (9, 'Calcio Líquido', 'Suplemento de absorción rápida para hembras en puesta o casos leves de EOM.', 'Exo Terra');
INSERT INTO public.supplement VALUES (10, 'Vitamina A Plus', 'Vitamina A preformada. Esencial para anfibios y gecos para evitar problemas de muda y ojos.', 'Repashy');
INSERT INTO public.supplement VALUES (11, 'Multivitamínico con Probióticos', 'Mezcla completa con bacterias beneficiosas para la digestión.', 'Arcadia');
INSERT INTO public.supplement VALUES (12, 'B-Complex', 'Vitaminas del grupo B para apoyo al sistema nervioso y apetito.', 'Zoo Med');
INSERT INTO public.supplement VALUES (13, 'Calcium Plus (All-in-One)', 'El suplemento diario estándar: mezcla de calcio, vitaminas y minerales.', 'Repashy');
INSERT INTO public.supplement VALUES (14, 'EarthPro-A', 'Polvo mineral diario rico en arcillas naturales y vitaminas.', 'Arcadia');
INSERT INTO public.supplement VALUES (15, 'Grub Pie', 'Suplemento nutricional completo en gel para insectívoros.', 'Repashy');
INSERT INTO public.supplement VALUES (16, 'SuperPigment / Carotenoides', 'Potenciador de colores rojos, naranjas y amarillos (perfecto para Terribilis).', 'Repashy');
INSERT INTO public.supplement VALUES (17, 'Polen de Abeja Puro', 'Suplemento natural muy apreciado por camaleones y herbívoros.', 'Zoo Med');
INSERT INTO public.supplement VALUES (18, 'Electrolitos & B12', 'Solución de baño o rociado para animales estresados o deshidratados.', 'Exo Terra');
INSERT INTO public.supplement VALUES (19, 'Magnesium + Calcio', 'Fórmula específica para la contracción muscular y salud ósea.', 'Arcadia');
INSERT INTO public.supplement VALUES (20, 'Shed-Ease', 'Suplemento para facilitar la muda de piel mediante aceites y vitaminas.', 'Zilla');


--
-- TOC entry 5044 (class 0 OID 16390)
-- Dependencies: 218
-- Data for Name: taxonomic_class; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.taxonomic_class VALUES (1, 'Reptilia');
INSERT INTO public.taxonomic_class VALUES (2, 'Amphibia');


--
-- TOC entry 5048 (class 0 OID 16417)
-- Dependencies: 222
-- Data for Name: taxonomic_family; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.taxonomic_family VALUES (1, 'Boidae', 1);
INSERT INTO public.taxonomic_family VALUES (2, 'Pythonidae', 1);
INSERT INTO public.taxonomic_family VALUES (3, 'Colubridae', 1);
INSERT INTO public.taxonomic_family VALUES (4, 'Viperidae', 1);
INSERT INTO public.taxonomic_family VALUES (5, 'Elapidae', 1);
INSERT INTO public.taxonomic_family VALUES (6, 'Gekkonidae', 1);
INSERT INTO public.taxonomic_family VALUES (7, 'Eublepharidae', 1);
INSERT INTO public.taxonomic_family VALUES (8, 'Phyllodactylidae', 1);
INSERT INTO public.taxonomic_family VALUES (9, 'Diplodactylidae', 1);
INSERT INTO public.taxonomic_family VALUES (10, 'Agamidae', 1);
INSERT INTO public.taxonomic_family VALUES (11, 'Chamaeleonidae', 1);
INSERT INTO public.taxonomic_family VALUES (12, 'Iguanidae', 1);
INSERT INTO public.taxonomic_family VALUES (13, 'Varanidae', 1);
INSERT INTO public.taxonomic_family VALUES (14, 'Teiidae', 1);
INSERT INTO public.taxonomic_family VALUES (15, 'Scincidae', 1);
INSERT INTO public.taxonomic_family VALUES (16, 'Lacertidae', 1);
INSERT INTO public.taxonomic_family VALUES (17, 'Helodermatidae', 1);
INSERT INTO public.taxonomic_family VALUES (18, 'Dactyloidae', 1);
INSERT INTO public.taxonomic_family VALUES (19, 'Testudinidae', 2);
INSERT INTO public.taxonomic_family VALUES (20, 'Emydidae', 2);
INSERT INTO public.taxonomic_family VALUES (21, 'Geoemydidae', 2);
INSERT INTO public.taxonomic_family VALUES (22, 'Cheloniidae', 2);
INSERT INTO public.taxonomic_family VALUES (23, 'Chelydridae', 2);
INSERT INTO public.taxonomic_family VALUES (24, 'Kinosternidae', 2);
INSERT INTO public.taxonomic_family VALUES (25, 'Trionychidae', 2);
INSERT INTO public.taxonomic_family VALUES (26, 'Chelidae', 2);
INSERT INTO public.taxonomic_family VALUES (27, 'Dendrobatidae', 3);
INSERT INTO public.taxonomic_family VALUES (28, 'Hylidae', 3);
INSERT INTO public.taxonomic_family VALUES (29, 'Pelodryadidae', 3);
INSERT INTO public.taxonomic_family VALUES (30, 'Phyllomedusidae', 3);
INSERT INTO public.taxonomic_family VALUES (31, 'Ceratophryidae', 3);
INSERT INTO public.taxonomic_family VALUES (32, 'Pyxicephalidae', 3);
INSERT INTO public.taxonomic_family VALUES (33, 'Ranidae', 3);
INSERT INTO public.taxonomic_family VALUES (34, 'Bufonidae', 3);
INSERT INTO public.taxonomic_family VALUES (35, 'Microhylidae', 3);
INSERT INTO public.taxonomic_family VALUES (36, 'Pipidae', 3);
INSERT INTO public.taxonomic_family VALUES (37, 'Rhacophoridae', 3);
INSERT INTO public.taxonomic_family VALUES (38, 'Mantellidae', 3);
INSERT INTO public.taxonomic_family VALUES (39, 'Ambystomatidae', 4);
INSERT INTO public.taxonomic_family VALUES (40, 'Salamandridae', 4);
INSERT INTO public.taxonomic_family VALUES (41, 'Plethodontidae', 4);
INSERT INTO public.taxonomic_family VALUES (42, 'Hynobiidae', 4);


--
-- TOC entry 5046 (class 0 OID 16405)
-- Dependencies: 220
-- Data for Name: taxonomic_order; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.taxonomic_order VALUES (1, 'Squamata', 1);
INSERT INTO public.taxonomic_order VALUES (2, 'Testudines', 1);
INSERT INTO public.taxonomic_order VALUES (3, 'Anura', 2);
INSERT INTO public.taxonomic_order VALUES (4, 'Caudata', 2);
INSERT INTO public.taxonomic_order VALUES (5, 'Crocodylia', 1);


--
-- TOC entry 5101 (class 0 OID 0)
-- Dependencies: 239
-- Name: brumation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.brumation_id_seq', 11, true);


--
-- TOC entry 5102 (class 0 OID 0)
-- Dependencies: 237
-- Name: diet_food_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.diet_food_id_seq', 34, true);


--
-- TOC entry 5103 (class 0 OID 0)
-- Dependencies: 231
-- Name: diet_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.diet_type_id_seq', 7, true);


--
-- TOC entry 5104 (class 0 OID 0)
-- Dependencies: 225
-- Name: environment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.environment_id_seq', 11, true);


--
-- TOC entry 5105 (class 0 OID 0)
-- Dependencies: 233
-- Name: food_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.food_id_seq', 32, true);


--
-- TOC entry 5106 (class 0 OID 0)
-- Dependencies: 227
-- Name: habitat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.habitat_id_seq', 11, true);


--
-- TOC entry 5107 (class 0 OID 0)
-- Dependencies: 241
-- Name: health_issue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.health_issue_id_seq', 10, true);


--
-- TOC entry 5108 (class 0 OID 0)
-- Dependencies: 229
-- Name: natural_habitat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.natural_habitat_id_seq', 10, true);


--
-- TOC entry 5109 (class 0 OID 0)
-- Dependencies: 235
-- Name: species_diet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.species_diet_id_seq', 11, true);


--
-- TOC entry 5110 (class 0 OID 0)
-- Dependencies: 243
-- Name: species_health_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.species_health_id_seq', 35, true);


--
-- TOC entry 5111 (class 0 OID 0)
-- Dependencies: 223
-- Name: species_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.species_id_seq', 11, true);


--
-- TOC entry 5112 (class 0 OID 0)
-- Dependencies: 245
-- Name: species_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.species_image_id_seq', 16, true);


--
-- TOC entry 5113 (class 0 OID 0)
-- Dependencies: 249
-- Name: species_supplement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.species_supplement_id_seq', 22, true);


--
-- TOC entry 5114 (class 0 OID 0)
-- Dependencies: 247
-- Name: supplement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.supplement_id_seq', 20, true);


--
-- TOC entry 5115 (class 0 OID 0)
-- Dependencies: 217
-- Name: taxonomic_class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.taxonomic_class_id_seq', 2, true);


--
-- TOC entry 5116 (class 0 OID 0)
-- Dependencies: 221
-- Name: taxonomic_family_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.taxonomic_family_id_seq', 42, true);


--
-- TOC entry 5117 (class 0 OID 0)
-- Dependencies: 219
-- Name: taxonomic_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.taxonomic_order_id_seq', 5, true);


--
-- TOC entry 4869 (class 2606 OID 16547)
-- Name: brumation brumation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brumation
    ADD CONSTRAINT brumation_pkey PRIMARY KEY (id);


--
-- TOC entry 4867 (class 2606 OID 16528)
-- Name: diet_food diet_food_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diet_food
    ADD CONSTRAINT diet_food_pkey PRIMARY KEY (id);


--
-- TOC entry 4861 (class 2606 OID 16493)
-- Name: diet_type diet_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diet_type
    ADD CONSTRAINT diet_type_pkey PRIMARY KEY (id);


--
-- TOC entry 4855 (class 2606 OID 16453)
-- Name: environment environment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.environment
    ADD CONSTRAINT environment_pkey PRIMARY KEY (id);


--
-- TOC entry 4863 (class 2606 OID 16500)
-- Name: food food_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.food
    ADD CONSTRAINT food_pkey PRIMARY KEY (id);


--
-- TOC entry 4857 (class 2606 OID 16467)
-- Name: habitat habitat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.habitat
    ADD CONSTRAINT habitat_pkey PRIMARY KEY (id);


--
-- TOC entry 4871 (class 2606 OID 16561)
-- Name: health_issue health_issue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_issue
    ADD CONSTRAINT health_issue_pkey PRIMARY KEY (id);


--
-- TOC entry 4859 (class 2606 OID 16481)
-- Name: natural_habitat natural_habitat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.natural_habitat
    ADD CONSTRAINT natural_habitat_pkey PRIMARY KEY (id);


--
-- TOC entry 4865 (class 2606 OID 16509)
-- Name: species_diet species_diet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.species_diet
    ADD CONSTRAINT species_diet_pkey PRIMARY KEY (id);


--
-- TOC entry 4875 (class 2606 OID 16570)
-- Name: species_health species_health_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.species_health
    ADD CONSTRAINT species_health_pkey PRIMARY KEY (id);


--
-- TOC entry 4877 (class 2606 OID 16589)
-- Name: species_image species_image_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.species_image
    ADD CONSTRAINT species_image_pkey PRIMARY KEY (id);


--
-- TOC entry 4851 (class 2606 OID 16604)
-- Name: species species_nombre_cientifico_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.species
    ADD CONSTRAINT species_nombre_cientifico_key UNIQUE (nombre_cientifico);


--
-- TOC entry 4853 (class 2606 OID 16437)
-- Name: species species_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.species
    ADD CONSTRAINT species_pkey PRIMARY KEY (id);


--
-- TOC entry 4881 (class 2606 OID 17146)
-- Name: species_supplement species_supplement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.species_supplement
    ADD CONSTRAINT species_supplement_pkey PRIMARY KEY (id);


--
-- TOC entry 4879 (class 2606 OID 17132)
-- Name: supplement supplement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplement
    ADD CONSTRAINT supplement_pkey PRIMARY KEY (id);


--
-- TOC entry 4841 (class 2606 OID 16395)
-- Name: taxonomic_class taxonomic_class_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxonomic_class
    ADD CONSTRAINT taxonomic_class_pkey PRIMARY KEY (id);


--
-- TOC entry 4847 (class 2606 OID 16422)
-- Name: taxonomic_family taxonomic_family_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxonomic_family
    ADD CONSTRAINT taxonomic_family_pkey PRIMARY KEY (id);


--
-- TOC entry 4843 (class 2606 OID 16410)
-- Name: taxonomic_order taxonomic_order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxonomic_order
    ADD CONSTRAINT taxonomic_order_pkey PRIMARY KEY (id);


--
-- TOC entry 4849 (class 2606 OID 16697)
-- Name: taxonomic_family unique_family_nombre; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxonomic_family
    ADD CONSTRAINT unique_family_nombre UNIQUE (nombre);


--
-- TOC entry 4873 (class 2606 OID 16699)
-- Name: health_issue unique_health_issue_nombre; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_issue
    ADD CONSTRAINT unique_health_issue_nombre UNIQUE (nombre);


--
-- TOC entry 4845 (class 2606 OID 16695)
-- Name: taxonomic_order unique_order_nombre; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxonomic_order
    ADD CONSTRAINT unique_order_nombre UNIQUE (nombre);


--
-- TOC entry 4892 (class 2606 OID 16548)
-- Name: brumation brumation_species_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brumation
    ADD CONSTRAINT brumation_species_id_fkey FOREIGN KEY (species_id) REFERENCES public.species(id) ON DELETE CASCADE;


--
-- TOC entry 4890 (class 2606 OID 16534)
-- Name: diet_food diet_food_food_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diet_food
    ADD CONSTRAINT diet_food_food_id_fkey FOREIGN KEY (food_id) REFERENCES public.food(id);


--
-- TOC entry 4891 (class 2606 OID 16529)
-- Name: diet_food diet_food_species_diet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diet_food
    ADD CONSTRAINT diet_food_species_diet_id_fkey FOREIGN KEY (species_diet_id) REFERENCES public.species_diet(id) ON DELETE CASCADE;


--
-- TOC entry 4885 (class 2606 OID 16454)
-- Name: environment environment_species_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.environment
    ADD CONSTRAINT environment_species_id_fkey FOREIGN KEY (species_id) REFERENCES public.species(id) ON DELETE CASCADE;


--
-- TOC entry 4886 (class 2606 OID 16468)
-- Name: habitat habitat_species_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.habitat
    ADD CONSTRAINT habitat_species_id_fkey FOREIGN KEY (species_id) REFERENCES public.species(id) ON DELETE CASCADE;


--
-- TOC entry 4887 (class 2606 OID 16482)
-- Name: natural_habitat natural_habitat_species_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.natural_habitat
    ADD CONSTRAINT natural_habitat_species_id_fkey FOREIGN KEY (species_id) REFERENCES public.species(id) ON DELETE CASCADE;


--
-- TOC entry 4888 (class 2606 OID 16515)
-- Name: species_diet species_diet_diet_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.species_diet
    ADD CONSTRAINT species_diet_diet_type_id_fkey FOREIGN KEY (diet_type_id) REFERENCES public.diet_type(id);


--
-- TOC entry 4889 (class 2606 OID 16510)
-- Name: species_diet species_diet_species_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.species_diet
    ADD CONSTRAINT species_diet_species_id_fkey FOREIGN KEY (species_id) REFERENCES public.species(id) ON DELETE CASCADE;


--
-- TOC entry 4884 (class 2606 OID 16440)
-- Name: species species_family_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.species
    ADD CONSTRAINT species_family_id_fkey FOREIGN KEY (family_id) REFERENCES public.taxonomic_family(id);


--
-- TOC entry 4893 (class 2606 OID 16576)
-- Name: species_health species_health_health_issue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.species_health
    ADD CONSTRAINT species_health_health_issue_id_fkey FOREIGN KEY (health_issue_id) REFERENCES public.health_issue(id);


--
-- TOC entry 4894 (class 2606 OID 16571)
-- Name: species_health species_health_species_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.species_health
    ADD CONSTRAINT species_health_species_id_fkey FOREIGN KEY (species_id) REFERENCES public.species(id) ON DELETE CASCADE;


--
-- TOC entry 4895 (class 2606 OID 16590)
-- Name: species_image species_image_species_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.species_image
    ADD CONSTRAINT species_image_species_id_fkey FOREIGN KEY (species_id) REFERENCES public.species(id) ON DELETE CASCADE;


--
-- TOC entry 4896 (class 2606 OID 17147)
-- Name: species_supplement species_supplement_species_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.species_supplement
    ADD CONSTRAINT species_supplement_species_id_fkey FOREIGN KEY (species_id) REFERENCES public.species(id) ON DELETE CASCADE;


--
-- TOC entry 4897 (class 2606 OID 17152)
-- Name: species_supplement species_supplement_supplement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.species_supplement
    ADD CONSTRAINT species_supplement_supplement_id_fkey FOREIGN KEY (supplement_id) REFERENCES public.supplement(id) ON DELETE CASCADE;


--
-- TOC entry 4883 (class 2606 OID 16423)
-- Name: taxonomic_family taxonomic_family_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxonomic_family
    ADD CONSTRAINT taxonomic_family_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.taxonomic_order(id);


--
-- TOC entry 4882 (class 2606 OID 16411)
-- Name: taxonomic_order taxonomic_order_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxonomic_order
    ADD CONSTRAINT taxonomic_order_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.taxonomic_class(id);


-- Completed on 2026-04-17 10:10:58

--
-- PostgreSQL database dump complete
--

\unrestrict laZ5rUzNLsbAf6aaENCRkRn6yfDS0PTGGdCkvKaYsxdKAUJuyze0pg8xBssZF21

