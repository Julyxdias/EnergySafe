--
-- PostgreSQL database dump
--

\restrict Yqs468aR1Ai0Zqp0esEEK8IXu21ahY6shTzUElB1oriRWKniFqvh5MBE9pefM00

-- Dumped from database version 18.3 (Debian 18.3-1.pgdg12+1)
-- Dumped by pg_dump version 18.3

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

ALTER TABLE IF EXISTS ONLY public.tarifas DROP CONSTRAINT IF EXISTS tarifas_local_id_fkey;
ALTER TABLE IF EXISTS ONLY public.rateio DROP CONSTRAINT IF EXISTS rateio_fatura_id_fkey;
ALTER TABLE IF EXISTS ONLY public.rateio DROP CONSTRAINT IF EXISTS rateio_area_id_fkey;
ALTER TABLE IF EXISTS ONLY public.quadros DROP CONSTRAINT IF EXISTS quadros_quadro_pai_id_fkey;
ALTER TABLE IF EXISTS ONLY public.quadros DROP CONSTRAINT IF EXISTS quadros_local_id_fkey;
ALTER TABLE IF EXISTS ONLY public.quadros DROP CONSTRAINT IF EXISTS quadros_area_id_fkey;
ALTER TABLE IF EXISTS ONLY public.metas DROP CONSTRAINT IF EXISTS metas_quadro_id_fkey;
ALTER TABLE IF EXISTS ONLY public.metas DROP CONSTRAINT IF EXISTS metas_local_id_fkey;
ALTER TABLE IF EXISTS ONLY public.medicoes DROP CONSTRAINT IF EXISTS medicoes_canal_id_fkey;
ALTER TABLE IF EXISTS ONLY public.faturas_ocr DROP CONSTRAINT IF EXISTS faturas_ocr_fatura_id_fkey;
ALTER TABLE IF EXISTS ONLY public.faturas DROP CONSTRAINT IF EXISTS faturas_local_id_fkey;
ALTER TABLE IF EXISTS ONLY public.faturas DROP CONSTRAINT IF EXISTS faturas_instalacao_id_fkey;
ALTER TABLE IF EXISTS ONLY public.fatura_itens DROP CONSTRAINT IF EXISTS fatura_itens_fatura_id_fkey;
ALTER TABLE IF EXISTS ONLY public.enel_instalacoes DROP CONSTRAINT IF EXISTS enel_instalacoes_local_id_fkey;
ALTER TABLE IF EXISTS ONLY public.dispositivos_status DROP CONSTRAINT IF EXISTS dispositivos_status_dispositivo_id_fkey;
ALTER TABLE IF EXISTS ONLY public.dispositivos DROP CONSTRAINT IF EXISTS dispositivos_quadro_id_fkey;
ALTER TABLE IF EXISTS ONLY public.consumo_diario DROP CONSTRAINT IF EXISTS consumo_diario_canal_id_fkey;
ALTER TABLE IF EXISTS ONLY public.canais_medicao DROP CONSTRAINT IF EXISTS canais_medicao_dispositivo_id_fkey;
ALTER TABLE IF EXISTS ONLY public.areas DROP CONSTRAINT IF EXISTS areas_local_id_fkey;
ALTER TABLE IF EXISTS ONLY public.alertas DROP CONSTRAINT IF EXISTS alertas_canal_id_fkey;
DROP TRIGGER IF EXISTS trg_faturas_ocr_atualizado_em ON public.faturas_ocr;
DROP TRIGGER IF EXISTS trg_faturas_atualizado_em ON public.faturas;
DROP TRIGGER IF EXISTS trg_enel_inst_atualizado_em ON public.enel_instalacoes;
DROP INDEX IF EXISTS public.idx_tarifas_local;
DROP INDEX IF EXISTS public.idx_medicoes_timestamp;
DROP INDEX IF EXISTS public.idx_medicoes_canal;
DROP INDEX IF EXISTS public.idx_faturas_vencimento;
DROP INDEX IF EXISTS public.idx_faturas_status;
DROP INDEX IF EXISTS public.idx_faturas_ocr_fatura;
DROP INDEX IF EXISTS public.idx_fatura_itens_fatura;
DROP INDEX IF EXISTS public.idx_enel_inst_local;
DROP INDEX IF EXISTS public.idx_consumo_diario_data;
DROP INDEX IF EXISTS public.idx_alertas_timestamp;
ALTER TABLE IF EXISTS ONLY public.tarifas DROP CONSTRAINT IF EXISTS tarifas_pkey;
ALTER TABLE IF EXISTS ONLY public.tarifas DROP CONSTRAINT IF EXISTS tarifas_local_id_vigencia_key;
ALTER TABLE IF EXISTS ONLY public.rateio DROP CONSTRAINT IF EXISTS rateio_pkey;
ALTER TABLE IF EXISTS ONLY public.rateio DROP CONSTRAINT IF EXISTS rateio_fatura_id_area_id_key;
ALTER TABLE IF EXISTS ONLY public.quadros DROP CONSTRAINT IF EXISTS quadros_pkey;
ALTER TABLE IF EXISTS ONLY public.metas DROP CONSTRAINT IF EXISTS metas_pkey;
ALTER TABLE IF EXISTS ONLY public.medicoes DROP CONSTRAINT IF EXISTS medicoes_pkey;
ALTER TABLE IF EXISTS ONLY public.locais DROP CONSTRAINT IF EXISTS locais_pkey;
ALTER TABLE IF EXISTS ONLY public.faturas DROP CONSTRAINT IF EXISTS faturas_pkey;
ALTER TABLE IF EXISTS ONLY public.faturas_ocr DROP CONSTRAINT IF EXISTS faturas_ocr_pkey;
ALTER TABLE IF EXISTS ONLY public.faturas_ocr DROP CONSTRAINT IF EXISTS faturas_ocr_fatura_id_key;
ALTER TABLE IF EXISTS ONLY public.faturas DROP CONSTRAINT IF EXISTS faturas_local_id_mes_key;
ALTER TABLE IF EXISTS ONLY public.fatura_itens DROP CONSTRAINT IF EXISTS fatura_itens_pkey;
ALTER TABLE IF EXISTS ONLY public.enel_instalacoes DROP CONSTRAINT IF EXISTS enel_instalacoes_pkey;
ALTER TABLE IF EXISTS ONLY public.enel_instalacoes DROP CONSTRAINT IF EXISTS enel_instalacoes_local_id_numero_key;
ALTER TABLE IF EXISTS ONLY public.dispositivos_status DROP CONSTRAINT IF EXISTS dispositivos_status_pkey;
ALTER TABLE IF EXISTS ONLY public.dispositivos_status DROP CONSTRAINT IF EXISTS dispositivos_status_dispositivo_id_key;
ALTER TABLE IF EXISTS ONLY public.dispositivos DROP CONSTRAINT IF EXISTS dispositivos_pkey;
ALTER TABLE IF EXISTS ONLY public.consumo_diario DROP CONSTRAINT IF EXISTS consumo_diario_pkey;
ALTER TABLE IF EXISTS ONLY public.consumo_diario DROP CONSTRAINT IF EXISTS consumo_diario_canal_id_data_key;
ALTER TABLE IF EXISTS ONLY public.canais_medicao DROP CONSTRAINT IF EXISTS canais_medicao_pkey;
ALTER TABLE IF EXISTS ONLY public.areas DROP CONSTRAINT IF EXISTS areas_pkey;
ALTER TABLE IF EXISTS ONLY public.alertas DROP CONSTRAINT IF EXISTS alertas_pkey;
ALTER TABLE IF EXISTS public.tarifas ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.rateio ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.quadros ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.metas ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.medicoes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.locais ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.faturas_ocr ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.faturas ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.fatura_itens ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.enel_instalacoes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.dispositivos_status ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.dispositivos ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.consumo_diario ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.canais_medicao ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.areas ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.alertas ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.tarifas_id_seq;
DROP TABLE IF EXISTS public.tarifas;
DROP SEQUENCE IF EXISTS public.rateio_id_seq;
DROP TABLE IF EXISTS public.rateio;
DROP SEQUENCE IF EXISTS public.quadros_id_seq;
DROP TABLE IF EXISTS public.quadros;
DROP SEQUENCE IF EXISTS public.metas_id_seq;
DROP TABLE IF EXISTS public.metas;
DROP SEQUENCE IF EXISTS public.medicoes_id_seq;
DROP TABLE IF EXISTS public.medicoes;
DROP SEQUENCE IF EXISTS public.locais_id_seq;
DROP TABLE IF EXISTS public.locais;
DROP SEQUENCE IF EXISTS public.faturas_ocr_id_seq;
DROP TABLE IF EXISTS public.faturas_ocr;
DROP SEQUENCE IF EXISTS public.faturas_id_seq;
DROP TABLE IF EXISTS public.faturas;
DROP SEQUENCE IF EXISTS public.fatura_itens_id_seq;
DROP TABLE IF EXISTS public.fatura_itens;
DROP SEQUENCE IF EXISTS public.enel_instalacoes_id_seq;
DROP TABLE IF EXISTS public.enel_instalacoes;
DROP SEQUENCE IF EXISTS public.dispositivos_status_id_seq;
DROP TABLE IF EXISTS public.dispositivos_status;
DROP SEQUENCE IF EXISTS public.dispositivos_id_seq;
DROP TABLE IF EXISTS public.dispositivos;
DROP SEQUENCE IF EXISTS public.consumo_diario_id_seq;
DROP TABLE IF EXISTS public.consumo_diario;
DROP SEQUENCE IF EXISTS public.canais_medicao_id_seq;
DROP TABLE IF EXISTS public.canais_medicao;
DROP SEQUENCE IF EXISTS public.areas_id_seq;
DROP TABLE IF EXISTS public.areas;
DROP SEQUENCE IF EXISTS public.alertas_id_seq;
DROP TABLE IF EXISTS public.alertas;
DROP FUNCTION IF EXISTS public.set_atualizado_em();
-- *not* dropping schema, since initdb creates it
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


--
-- Name: set_atualizado_em(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.set_atualizado_em() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.atualizado_em = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alertas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alertas (
    id integer NOT NULL,
    canal_id integer,
    tipo text,
    nivel text,
    mensagem text,
    valor real,
    limite real,
    "timestamp" timestamp without time zone NOT NULL,
    resolvido boolean DEFAULT false,
    criado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: alertas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.alertas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: alertas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.alertas_id_seq OWNED BY public.alertas.id;


--
-- Name: areas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.areas (
    id integer NOT NULL,
    nome text NOT NULL,
    local_id integer,
    descricao text
);


--
-- Name: areas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.areas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: areas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.areas_id_seq OWNED BY public.areas.id;


--
-- Name: canais_medicao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.canais_medicao (
    id integer NOT NULL,
    dispositivo_id integer,
    fase text,
    tipo text,
    descricao text,
    CONSTRAINT canais_medicao_fase_check CHECK ((fase = ANY (ARRAY['A'::text, 'B'::text, 'C'::text])))
);


--
-- Name: canais_medicao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.canais_medicao_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: canais_medicao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.canais_medicao_id_seq OWNED BY public.canais_medicao.id;


--
-- Name: consumo_diario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.consumo_diario (
    id bigint NOT NULL,
    canal_id integer,
    data date NOT NULL,
    kwh real NOT NULL,
    criado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: consumo_diario_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.consumo_diario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: consumo_diario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.consumo_diario_id_seq OWNED BY public.consumo_diario.id;


--
-- Name: dispositivos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dispositivos (
    id integer NOT NULL,
    nome text NOT NULL,
    quadro_id integer,
    ativo boolean DEFAULT true,
    data_instalacao timestamp without time zone,
    observacoes text
);


--
-- Name: dispositivos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.dispositivos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dispositivos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.dispositivos_id_seq OWNED BY public.dispositivos.id;


--
-- Name: dispositivos_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dispositivos_status (
    id integer NOT NULL,
    dispositivo_id integer,
    status text,
    ultima_leitura timestamp without time zone,
    potencia_atual real,
    atualizado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT dispositivos_status_status_check CHECK ((status = ANY (ARRAY['ONLINE'::text, 'ATRASO'::text, 'OFFLINE'::text])))
);


--
-- Name: dispositivos_status_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.dispositivos_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dispositivos_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.dispositivos_status_id_seq OWNED BY public.dispositivos_status.id;


--
-- Name: enel_instalacoes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enel_instalacoes (
    id integer NOT NULL,
    local_id integer NOT NULL,
    numero text NOT NULL,
    titular text,
    endereco text,
    lista_raw jsonb,
    criado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    atualizado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: TABLE enel_instalacoes; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.enel_instalacoes IS 'Instalações Enel vinculadas a cada local';


--
-- Name: COLUMN enel_instalacoes.numero; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.enel_instalacoes.numero IS 'Número da instalação Enel (ex: 7006123456)';


--
-- Name: COLUMN enel_instalacoes.lista_raw; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.enel_instalacoes.lista_raw IS 'Array completo de instalações do login — para referência';


--
-- Name: enel_instalacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.enel_instalacoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enel_instalacoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.enel_instalacoes_id_seq OWNED BY public.enel_instalacoes.id;


--
-- Name: fatura_itens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fatura_itens (
    id integer NOT NULL,
    fatura_id integer NOT NULL,
    descricao text NOT NULL,
    valor numeric(10,2) NOT NULL
);


--
-- Name: TABLE fatura_itens; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.fatura_itens IS 'Itens de composição da fatura (ocr.itens_fatura)';


--
-- Name: fatura_itens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.fatura_itens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fatura_itens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.fatura_itens_id_seq OWNED BY public.fatura_itens.id;


--
-- Name: faturas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.faturas (
    id integer NOT NULL,
    local_id integer,
    mes date NOT NULL,
    valor_total numeric(10,2) NOT NULL,
    kwh_total numeric(10,3),
    descricao text,
    criado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    instalacao_id integer,
    vencimento date,
    status text,
    codigo_barras text,
    conta_pdf_url text,
    atualizado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: COLUMN faturas.valor_total; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.faturas.valor_total IS 'R$ total da fatura — NUMERIC para evitar erro de ponto flutuante';


--
-- Name: COLUMN faturas.kwh_total; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.faturas.kwh_total IS 'kWh da fatura (para conferência com o medido)';


--
-- Name: COLUMN faturas.instalacao_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.faturas.instalacao_id IS 'FK para enel_instalacoes — nullable, faturas manuais não precisam preencher';


--
-- Name: COLUMN faturas.vencimento; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.faturas.vencimento IS 'Data de vencimento da fatura Enel';


--
-- Name: COLUMN faturas.status; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.faturas.status IS 'Status retornado pelo serviço: em aberto | pago | vencido';


--
-- Name: faturas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.faturas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: faturas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.faturas_id_seq OWNED BY public.faturas.id;


--
-- Name: faturas_ocr; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.faturas_ocr (
    id integer NOT NULL,
    fatura_id integer NOT NULL,
    cliente text,
    distribuidora text,
    nota_fiscal text,
    aviso text,
    endereco text,
    codigo_barras text,
    classe text,
    subclasse text,
    grupo text,
    subgrupo text,
    ref_mes smallint,
    ref_ano smallint,
    emissao_data date,
    data_apresentacao date,
    leitura_anterior_data date,
    leitura_data date,
    leitura_proxima_data date,
    energia_kwh numeric(10,3),
    valor numeric(10,2),
    vencimento date,
    preco_te numeric(10,6),
    preco_tusd numeric(10,6),
    normalizado_preco_te numeric(10,6),
    normalizado_preco_tusd numeric(10,6),
    normalizado_valor numeric(10,2),
    criado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    atualizado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: TABLE faturas_ocr; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.faturas_ocr IS 'Dados extraídos por OCR do PDF da fatura Enel — 1-para-1 com faturas';


--
-- Name: COLUMN faturas_ocr.energia_kwh; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.faturas_ocr.energia_kwh IS 'Consumo total em kWh extraído do PDF';


--
-- Name: COLUMN faturas_ocr.preco_te; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.faturas_ocr.preco_te IS 'Tarifa de Energia (TE) em R$/kWh';


--
-- Name: COLUMN faturas_ocr.preco_tusd; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.faturas_ocr.preco_tusd IS 'Tarifa de Uso do Sistema de Distribuição em R$/kWh';


--
-- Name: faturas_ocr_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.faturas_ocr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: faturas_ocr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.faturas_ocr_id_seq OWNED BY public.faturas_ocr.id;


--
-- Name: locais; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.locais (
    id integer NOT NULL,
    nome text NOT NULL,
    andar integer,
    descricao text
);


--
-- Name: locais_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.locais_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: locais_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.locais_id_seq OWNED BY public.locais.id;


--
-- Name: medicoes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.medicoes (
    id bigint NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    canal_id integer,
    corrente real,
    tensao real,
    potencia real,
    valido boolean DEFAULT true,
    criado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    potencia_ativa double precision,
    potencia_aparente double precision,
    potencia_reativa double precision,
    fator_potencia double precision
);


--
-- Name: medicoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.medicoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medicoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.medicoes_id_seq OWNED BY public.medicoes.id;


--
-- Name: metas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metas (
    id integer NOT NULL,
    local_id integer,
    quadro_id integer,
    descricao text,
    kwh_baseline real NOT NULL,
    kwh_meta real NOT NULL,
    data_inicio date NOT NULL,
    data_fim date,
    criado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: metas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.metas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: metas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.metas_id_seq OWNED BY public.metas.id;


--
-- Name: quadros; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quadros (
    id integer NOT NULL,
    nome text NOT NULL,
    local_id integer,
    area_id integer,
    quadro_pai_id integer,
    descricao text
);


--
-- Name: quadros_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quadros_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quadros_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quadros_id_seq OWNED BY public.quadros.id;


--
-- Name: rateio; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rateio (
    id bigint NOT NULL,
    fatura_id integer,
    area_id integer,
    kwh real NOT NULL,
    percentual real NOT NULL,
    valor_rs real NOT NULL,
    gerado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: rateio_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rateio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rateio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rateio_id_seq OWNED BY public.rateio.id;


--
-- Name: tarifas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tarifas (
    id integer NOT NULL,
    local_id integer,
    valor_kwh real NOT NULL,
    vigencia date NOT NULL,
    descricao text,
    criado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: tarifas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tarifas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tarifas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tarifas_id_seq OWNED BY public.tarifas.id;


--
-- Name: alertas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alertas ALTER COLUMN id SET DEFAULT nextval('public.alertas_id_seq'::regclass);


--
-- Name: areas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.areas ALTER COLUMN id SET DEFAULT nextval('public.areas_id_seq'::regclass);


--
-- Name: canais_medicao id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.canais_medicao ALTER COLUMN id SET DEFAULT nextval('public.canais_medicao_id_seq'::regclass);


--
-- Name: consumo_diario id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.consumo_diario ALTER COLUMN id SET DEFAULT nextval('public.consumo_diario_id_seq'::regclass);


--
-- Name: dispositivos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dispositivos ALTER COLUMN id SET DEFAULT nextval('public.dispositivos_id_seq'::regclass);


--
-- Name: dispositivos_status id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dispositivos_status ALTER COLUMN id SET DEFAULT nextval('public.dispositivos_status_id_seq'::regclass);


--
-- Name: enel_instalacoes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enel_instalacoes ALTER COLUMN id SET DEFAULT nextval('public.enel_instalacoes_id_seq'::regclass);


--
-- Name: fatura_itens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fatura_itens ALTER COLUMN id SET DEFAULT nextval('public.fatura_itens_id_seq'::regclass);


--
-- Name: faturas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faturas ALTER COLUMN id SET DEFAULT nextval('public.faturas_id_seq'::regclass);


--
-- Name: faturas_ocr id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faturas_ocr ALTER COLUMN id SET DEFAULT nextval('public.faturas_ocr_id_seq'::regclass);


--
-- Name: locais id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locais ALTER COLUMN id SET DEFAULT nextval('public.locais_id_seq'::regclass);


--
-- Name: medicoes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medicoes ALTER COLUMN id SET DEFAULT nextval('public.medicoes_id_seq'::regclass);


--
-- Name: metas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metas ALTER COLUMN id SET DEFAULT nextval('public.metas_id_seq'::regclass);


--
-- Name: quadros id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quadros ALTER COLUMN id SET DEFAULT nextval('public.quadros_id_seq'::regclass);


--
-- Name: rateio id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rateio ALTER COLUMN id SET DEFAULT nextval('public.rateio_id_seq'::regclass);


--
-- Name: tarifas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tarifas ALTER COLUMN id SET DEFAULT nextval('public.tarifas_id_seq'::regclass);


--
-- Data for Name: alertas; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.alertas (id, canal_id, tipo, nivel, mensagem, valor, limite, "timestamp", resolvido, criado_em) FROM stdin;
4	3	consumo_fora_horario	aviso	Consumo fora do hor rio permitido. Corrente: 38.7A.	38.7	0	2026-05-22 22:30:00	t	2026-05-26 00:25:20.936498
1	1	sobrecorrente	critico	Sobrecorrente detectada. Corrente: 52.4A, limite: 40A.	52.4	40	2026-05-22 09:15:00	t	2026-05-26 00:25:20.936498
5	3	sobrecorrente	critico	Sobrecorrente detectada. Corrente: 55.2A, limite: 40A.	55.2	40	2026-05-22 10:00:00	t	2026-05-26 00:25:20.936498
2	2	sobrecorrente	critico	Sobrecorrente detectada. Corrente: 68.1A, limite: 40A.	68.1	40	2026-05-22 09:20:00	t	2026-05-26 00:25:20.936498
3	1	queda_brusca	aviso	Queda brusca de corrente: de 52.4A para 1.2A.	1.2	52.4	2026-05-22 09:16:00	t	2026-05-26 00:25:20.936498
\.


--
-- Data for Name: areas; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.areas (id, nome, local_id, descricao) FROM stdin;
1	Terreo ADM	2	Salas de Aula - Andar 0
2	1 Andar ADM	3	Financeiro, Reuniao, Professores
3	2 Andar ADM	4	Coordenacao, Reitoria
\.


--
-- Data for Name: canais_medicao; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.canais_medicao (id, dispositivo_id, fase, tipo, descricao) FROM stdin;
1	1	A	corrente	ADM0_A307 Fase A
2	2	A	corrente	ADM1_A301 Fase A
3	3	A	corrente	ADM2_A302 Fase A
4	1	B	corrente	ADM0_A307 Fase B
5	1	C	corrente	ADM0_A307 Fase C
6	2	B	corrente	ADM1_A301 Fase B
7	2	C	corrente	ADM1_A301 Fase C
8	3	B	corrente	ADM2_A302 Fase B
9	3	C	corrente	ADM2_A302 Fase C
\.


--
-- Data for Name: consumo_diario; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.consumo_diario (id, canal_id, data, kwh, criado_em) FROM stdin;
1	5	2026-05-21	5.505	2026-05-26 00:25:31.291803
2	3	2026-05-20	5.911	2026-05-26 00:25:31.291803
3	6	2026-05-20	11.502	2026-05-26 00:25:31.291803
4	5	2026-05-20	5.428	2026-05-26 00:25:31.291803
5	7	2026-05-20	5.032	2026-05-26 00:25:31.291803
6	2	2026-05-22	7.487	2026-05-26 00:25:31.291803
7	4	2026-05-20	9.3405	2026-05-26 00:25:31.291803
8	1	2026-05-21	11.384	2026-05-26 00:25:31.291803
9	7	2026-05-21	5.021	2026-05-26 00:25:31.291803
10	6	2026-05-21	9.7075	2026-05-26 00:25:31.291803
11	3	2026-05-21	5.9235	2026-05-26 00:25:31.291803
12	8	2026-05-20	5.9675	2026-05-26 00:25:31.291803
13	2	2026-05-21	16.617	2026-05-26 00:25:31.291803
14	2	2026-05-20	18.8015	2026-05-26 00:25:31.291803
15	9	2026-05-20	4.129	2026-05-26 00:25:31.291803
16	1	2026-05-22	5.897	2026-05-26 00:25:31.291803
17	9	2026-05-21	4.261	2026-05-26 00:25:31.291803
18	1	2026-05-20	14.0925	2026-05-26 00:25:31.291803
19	3	2026-05-22	10.348	2026-05-26 00:25:31.291803
20	8	2026-05-21	5.9565	2026-05-26 00:25:31.291803
21	4	2026-05-21	6.749	2026-05-26 00:25:31.291803
\.


--
-- Data for Name: dispositivos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.dispositivos (id, nome, quadro_id, ativo, data_instalacao, observacoes) FROM stdin;
1	ESP32_ADM0_A307	1	t	2025-01-10 08:00:00	\N
2	ESP32_ADM1_A301	2	t	2025-01-10 08:00:00	\N
3	ESP32_ADM2_A302	3	t	2025-01-11 08:00:00	\N
\.


--
-- Data for Name: dispositivos_status; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.dispositivos_status (id, dispositivo_id, status, ultima_leitura, potencia_atual, atualizado_em) FROM stdin;
1	1	ONLINE	2026-05-22 19:52:00	2744.12	2026-05-24 01:10:00.521659
2	2	ONLINE	2026-05-22 19:52:00	2220	2026-05-22 19:53:15.739088
3	3	ONLINE	2026-05-22 19:52:00	2579	2026-05-22 19:50:38.083412
\.


--
-- Data for Name: enel_instalacoes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.enel_instalacoes (id, local_id, numero, titular, endereco, lista_raw, criado_em, atualizado_em) FROM stdin;
\.


--
-- Data for Name: fatura_itens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fatura_itens (id, fatura_id, descricao, valor) FROM stdin;
\.


--
-- Data for Name: faturas; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.faturas (id, local_id, mes, valor_total, kwh_total, descricao, criado_em, instalacao_id, vencimento, status, codigo_barras, conta_pdf_url, atualizado_em) FROM stdin;
1	1	2026-01-01	133984.00	190661.000	Fatura Enel 01/2026 - Bandeira Amarela - NF 000029364	2026-05-08 00:01:25.658288	\N	\N	\N	\N	\N	2026-05-16 13:59:15.568543
2	1	2026-02-01	111794.00	161697.000	Fatura Enel 02/2026 - Bandeira Verde - NF 000034022	2026-05-08 00:01:25.658288	\N	\N	\N	\N	\N	2026-05-16 13:59:15.568543
3	1	2026-03-01	124125.00	174857.000	Fatura Enel 03/2026 - Bandeira Verde - NF 000041044	2026-05-08 00:01:25.658288	\N	\N	\N	\N	\N	2026-05-16 13:59:15.568543
\.


--
-- Data for Name: faturas_ocr; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.faturas_ocr (id, fatura_id, cliente, distribuidora, nota_fiscal, aviso, endereco, codigo_barras, classe, subclasse, grupo, subgrupo, ref_mes, ref_ano, emissao_data, data_apresentacao, leitura_anterior_data, leitura_data, leitura_proxima_data, energia_kwh, valor, vencimento, preco_te, preco_tusd, normalizado_preco_te, normalizado_preco_tusd, normalizado_valor, criado_em, atualizado_em) FROM stdin;
\.


--
-- Data for Name: locais; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.locais (id, nome, andar, descricao) FROM stdin;
1	Geral	0	P/ Faturas
2	Predio ADM - Terreo	0	Salas de Aula
3	Predio ADM - 1 Andar	1	Sala de Reuniao, Financeiro, Sala dos Professores
4	Predio ADM - 2 Andar	2	Coordenacao, Reitoria, Salas de Reuniao
\.


--
-- Data for Name: medicoes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.medicoes (id, "timestamp", canal_id, corrente, tensao, potencia, valido, criado_em, potencia_ativa, potencia_aparente, potencia_reativa, fator_potencia) FROM stdin;
51	2026-05-20 08:00:00	4	11.8	220.2	2598	t	2026-05-25 23:02:52.42556	2490	2598	726	0.96
52	2026-05-20 08:30:00	4	12.5	219.9	2749	t	2026-05-25 23:02:52.42556	2640	2749	769	0.96
53	2026-05-20 09:00:00	4	11.2	220.5	2470	t	2026-05-25 23:02:52.42556	2370	2470	691	0.96
54	2026-05-20 09:30:00	4	13	221	2873	t	2026-05-25 23:02:52.42556	2760	2873	804	0.96
55	2026-05-20 10:00:00	4	12.7	220.3	2798	t	2026-05-25 23:02:52.42556	2690	2798	783	0.96
56	2026-05-20 14:00:00	4	11.5	220.1	2531	t	2026-05-25 23:02:52.42556	2430	2531	708	0.96
57	2026-05-20 15:00:00	4	12.1	220	2662	t	2026-05-25 23:02:52.42556	2560	2662	745	0.96
58	2026-05-21 08:00:00	4	12.3	220.4	2711	t	2026-05-25 23:02:52.42556	2600	2711	758	0.96
59	2026-05-21 09:00:00	4	11.6	220.1	2553	t	2026-05-25 23:02:52.42556	2450	2553	714	0.96
60	2026-05-21 10:00:00	4	13.1	219.8	2879	t	2026-05-25 23:02:52.42556	2760	2879	806	0.96
61	2026-05-21 14:00:00	4	11.9	220.6	2625	t	2026-05-25 23:02:52.42556	2520	2625	734	0.96
62	2026-05-21 15:00:00	4	12.4	220.2	2730	t	2026-05-25 23:02:52.42556	2620	2730	764	0.96
63	2026-05-20 08:00:00	5	9.5	220.1	2091	t	2026-05-25 23:02:52.42556	2010	2091	585	0.96
64	2026-05-20 09:00:00	5	10.2	220.5	2249	t	2026-05-25 23:02:52.42556	2160	2249	629	0.96
65	2026-05-20 10:00:00	5	9.8	220.3	2159	t	2026-05-25 23:02:52.42556	2080	2159	604	0.96
66	2026-05-20 14:00:00	5	10.5	220.2	2312	t	2026-05-25 23:02:52.42556	2220	2312	647	0.96
67	2026-05-20 15:00:00	5	9.3	219.9	2045	t	2026-05-25 23:02:52.42556	1970	2045	572	0.96
68	2026-05-21 08:00:00	5	10	220.4	2204	t	2026-05-25 23:02:52.42556	2120	2204	616	0.96
69	2026-05-21 09:00:00	5	9.6	220	2112	t	2026-05-25 23:02:52.42556	2030	2112	591	0.96
70	2026-05-21 10:00:00	5	10.7	219.8	2352	t	2026-05-25 23:02:52.42556	2260	2352	658	0.96
71	2026-05-21 14:00:00	5	9.4	220.6	2074	t	2026-05-25 23:02:52.42556	1990	2074	580	0.96
72	2026-05-21 15:00:00	5	10.3	220.2	2268	t	2026-05-25 23:02:52.42556	2180	2268	635	0.96
73	2026-05-20 08:00:00	6	17.2	220.2	3787	t	2026-05-25 23:02:52.42556	3640	3787	1060	0.96
74	2026-05-20 08:30:00	6	18	219.9	3958	t	2026-05-25 23:02:52.42556	3800	3958	1108	0.96
75	2026-05-20 09:00:00	6	16.8	220.5	3704	t	2026-05-25 23:02:52.42556	3560	3704	1036	0.96
76	2026-05-20 10:00:00	6	18.5	220.3	4076	t	2026-05-25 23:02:52.42556	3910	4076	1141	0.96
77	2026-05-20 14:00:00	6	17.5	220.1	3852	t	2026-05-25 23:02:52.42556	3700	3852	1078	0.96
78	2026-05-20 15:00:00	6	16.5	219.8	3627	t	2026-05-25 23:02:52.42556	3480	3627	1015	0.96
79	2026-05-21 08:00:00	6	17.8	220.4	3923	t	2026-05-25 23:02:52.42556	3770	3923	1098	0.96
80	2026-05-21 09:00:00	6	18.2	220	4004	t	2026-05-25 23:02:52.42556	3840	4004	1121	0.96
81	2026-05-21 10:00:00	6	17	219.7	3735	t	2026-05-25 23:02:52.42556	3590	3735	1046	0.96
82	2026-05-21 14:00:00	6	18.3	220.5	4032	t	2026-05-25 23:02:52.42556	3870	4032	1129	0.96
83	2026-05-21 15:00:00	6	16.9	220.2	3721	t	2026-05-25 23:02:52.42556	3570	3721	1041	0.96
84	2026-05-20 08:00:00	7	8.8	220.1	1937	t	2026-05-25 23:02:52.42556	1860	1937	542	0.96
85	2026-05-20 09:00:00	7	9.5	220.5	2095	t	2026-05-25 23:02:52.42556	2010	2095	586	0.96
86	2026-05-20 10:00:00	7	9.1	220.3	2005	t	2026-05-25 23:02:52.42556	1930	2005	561	0.96
87	2026-05-20 14:00:00	7	9.8	220.2	2158	t	2026-05-25 23:02:52.42556	2070	2158	604	0.96
88	2026-05-20 15:00:00	7	8.5	219.9	1869	t	2026-05-25 23:02:52.42556	1800	1869	523	0.96
89	2026-05-21 08:00:00	7	9.3	220.4	2050	t	2026-05-25 23:02:52.42556	1970	2050	574	0.96
90	2026-05-21 09:00:00	7	8.9	220	1958	t	2026-05-25 23:02:52.42556	1880	1958	548	0.96
91	2026-05-21 10:00:00	7	9.6	219.8	2110	t	2026-05-25 23:02:52.42556	2030	2110	591	0.96
92	2026-05-21 14:00:00	7	8.6	220.6	1898	t	2026-05-25 23:02:52.42556	1820	1898	531	0.96
93	2026-05-21 15:00:00	7	9.2	220.2	2026	t	2026-05-25 23:02:52.42556	1950	2026	567	0.96
94	2026-05-20 08:00:00	8	10.5	220.1	2311	t	2026-05-25 23:02:52.42556	2220	2311	647	0.96
95	2026-05-20 09:00:00	8	11.2	220.5	2470	t	2026-05-25 23:02:52.42556	2370	2470	691	0.96
96	2026-05-20 10:00:00	8	10.8	220.3	2379	t	2026-05-25 23:02:52.42556	2290	2379	666	0.96
97	2026-05-20 14:00:00	8	11.5	220.2	2532	t	2026-05-25 23:02:52.42556	2430	2532	709	0.96
98	2026-05-20 15:00:00	8	10.2	219.9	2243	t	2026-05-25 23:02:52.42556	2160	2243	628	0.96
99	2026-05-21 08:00:00	8	11	220.4	2424	t	2026-05-25 23:02:52.42556	2330	2424	679	0.96
100	2026-05-21 09:00:00	8	10.6	220.1	2333	t	2026-05-25 23:02:52.42556	2240	2333	653	0.96
1	2026-05-20 08:00:00	1	12.3	220.1	2706	t	2026-05-24 01:27:37.504601	2600	2706	754	0.96
2	2026-05-20 08:30:00	1	13.1	219.8	2879	t	2026-05-24 01:27:37.504601	2750	2879	820	0.95
3	2026-05-20 09:00:00	1	11.8	220.5	2601	t	2026-05-24 01:27:37.504601	2500	2601	720	0.96
4	2026-05-20 09:30:00	1	14.2	221	3138	t	2026-05-24 01:27:37.504601	3000	3138	890	0.96
5	2026-05-20 10:00:00	1	13.7	220.3	3018	t	2026-05-24 01:27:37.504601	2900	3018	855	0.96
6	2026-05-20 10:30:00	1	12.9	219.9	2837	t	2026-05-24 01:27:37.504601	2720	2837	800	0.96
7	2026-05-20 11:00:00	1	13.4	220.7	2957	t	2026-05-24 01:27:37.504601	2840	2957	835	0.96
8	2026-05-20 14:00:00	1	12.1	220.2	2664	t	2026-05-24 01:27:37.504601	2560	2664	740	0.96
9	2026-05-20 14:30:00	1	13	220	2860	t	2026-05-24 01:27:37.504601	2750	2860	810	0.96
10	2026-05-20 15:00:00	1	11.5	219.6	2525	t	2026-05-24 01:27:37.504601	2430	2525	705	0.96
11	2026-05-21 08:00:00	1	12.8	220.4	2821	t	2026-05-24 01:27:37.504601	2710	2821	795	0.96
12	2026-05-21 08:30:00	1	13.3	220.1	2929	t	2026-05-24 01:27:37.504601	2810	2929	828	0.96
13	2026-05-21 09:00:00	1	11.9	220.8	2628	t	2026-05-24 01:27:37.504601	2520	2628	728	0.96
14	2026-05-21 09:30:00	1	14	221.2	3097	t	2026-05-24 01:27:37.504601	2970	3097	878	0.96
15	2026-05-21 10:00:00	1	13.6	220	2992	t	2026-05-24 01:27:37.504601	2880	2992	848	0.96
16	2026-05-21 10:30:00	1	12.5	219.7	2746	t	2026-05-24 01:27:37.504601	2640	2746	775	0.96
17	2026-05-21 11:00:00	1	13.2	220.6	2911	t	2026-05-24 01:27:37.504601	2800	2911	822	0.96
18	2026-05-21 14:00:00	1	12	220.3	2644	t	2026-05-24 01:27:37.504601	2540	2644	736	0.96
19	2026-05-20 08:00:00	2	18.5	220.1	4072	t	2026-05-24 01:27:37.504601	3900	4072	1140	0.96
20	2026-05-20 08:30:00	2	19.2	219.8	4220	t	2026-05-24 01:27:37.504601	4050	4220	1180	0.96
21	2026-05-20 09:00:00	2	17.8	220.5	3925	t	2026-05-24 01:27:37.504601	3770	3925	1095	0.96
22	2026-05-20 09:30:00	2	20.1	221	4442	t	2026-05-24 01:27:37.504601	4260	4442	1240	0.96
23	2026-05-20 10:00:00	2	19.7	220.3	4340	t	2026-05-24 01:27:37.504601	4160	4340	1215	0.96
24	2026-05-20 10:30:00	2	18.9	219.9	4156	t	2026-05-24 01:27:37.504601	3990	4156	1160	0.96
25	2026-05-20 11:00:00	2	19.4	220.7	4282	t	2026-05-24 01:27:37.504601	4110	4282	1196	0.96
26	2026-05-20 14:00:00	2	18.1	220.2	3986	t	2026-05-24 01:27:37.504601	3830	3986	1113	0.96
27	2026-05-20 14:30:00	2	19	220	4180	t	2026-05-24 01:27:37.504601	4010	4180	1168	0.96
28	2026-05-21 08:00:00	2	18.7	220.4	4121	t	2026-05-24 01:27:37.504601	3950	4121	1151	0.96
29	2026-05-21 08:30:00	2	19.3	220.1	4248	t	2026-05-24 01:27:37.504601	4080	4248	1188	0.96
30	2026-05-21 09:00:00	2	17.9	220.8	3952	t	2026-05-24 01:27:37.504601	3790	3952	1102	0.96
31	2026-05-21 09:30:00	2	20	221.2	4424	t	2026-05-24 01:27:37.504601	4240	4424	1236	0.96
32	2026-05-21 10:00:00	2	19.5	220	4290	t	2026-05-24 01:27:37.504601	4120	4290	1198	0.96
33	2026-05-21 10:30:00	2	18.3	219.7	4021	t	2026-05-24 01:27:37.504601	3860	4021	1122	0.96
34	2026-05-21 11:00:00	2	19.1	220.6	4213	t	2026-05-24 01:27:37.504601	4040	4213	1177	0.96
35	2026-05-21 14:00:00	2	18	220.3	3965	t	2026-05-24 01:27:37.504601	3810	3965	1108	0.96
36	2026-05-20 08:00:00	3	10.2	220.1	2245	t	2026-05-24 01:27:37.504601	2160	2245	626	0.96
37	2026-05-20 09:00:00	3	11	220.5	2426	t	2026-05-24 01:27:37.504601	2330	2426	676	0.96
38	2026-05-20 10:00:00	3	10.7	220.3	2357	t	2026-05-24 01:27:37.504601	2260	2357	657	0.96
39	2026-05-20 14:00:00	3	10.5	220.2	2311	t	2026-05-24 01:27:37.504601	2220	2311	645	0.96
40	2026-05-20 15:00:00	3	11.3	219.8	2483	t	2026-05-24 01:27:37.504601	2390	2483	693	0.96
41	2026-05-21 08:00:00	3	10.3	220.4	2268	t	2026-05-24 01:27:37.504601	2180	2268	633	0.96
42	2026-05-21 09:00:00	3	11.1	220.8	2449	t	2026-05-24 01:27:37.504601	2350	2449	683	0.96
43	2026-05-21 10:00:00	3	10.8	220	2376	t	2026-05-24 01:27:37.504601	2280	2376	663	0.96
44	2026-05-21 14:00:00	3	10.4	220.3	2291	t	2026-05-24 01:27:37.504601	2200	2291	639	0.96
45	2026-05-21 15:00:00	3	11.2	219.9	2463	t	2026-05-24 01:27:37.504601	2370	2463	688	0.96
46	2026-05-22 09:15:00	1	52.4	220.1	11530	t	2026-05-24 01:27:37.504601	11060	11530	3220	0.96
47	2026-05-22 09:20:00	2	68.1	219.8	14974	t	2026-05-24 01:27:37.504601	14370	14974	4185	0.96
48	2026-05-22 09:16:00	1	1.2	220	264	t	2026-05-24 01:27:37.504601	254	264	73.7	0.96
49	2026-05-22 22:30:00	3	38.7	220.2	8522	t	2026-05-24 01:27:37.504601	8180	8522	2381	0.96
50	2026-05-22 10:00:00	3	55.2	220.5	12174	t	2026-05-24 01:27:37.504601	11690	12174	3403	0.96
101	2026-05-21 10:00:00	8	11.3	219.8	2484	t	2026-05-25 23:02:52.42556	2390	2484	695	0.96
102	2026-05-21 14:00:00	8	10.1	220.6	2228	t	2026-05-25 23:02:52.42556	2140	2228	624	0.96
103	2026-05-21 15:00:00	8	11.1	220.2	2444	t	2026-05-25 23:02:52.42556	2350	2444	684	0.96
104	2026-05-20 08:00:00	9	7.1	220.1	1563	t	2026-05-25 23:02:52.42556	1500	1563	437	0.96
105	2026-05-20 09:00:00	9	7.8	220.5	1720	t	2026-05-25 23:02:52.42556	1650	1720	481	0.96
106	2026-05-20 10:00:00	9	7.4	220.3	1630	t	2026-05-25 23:02:52.42556	1570	1630	456	0.96
107	2026-05-20 14:00:00	9	8	220.2	1762	t	2026-05-25 23:02:52.42556	1690	1762	493	0.96
108	2026-05-20 15:00:00	9	7.2	219.9	1583	t	2026-05-25 23:02:52.42556	1530	1583	443	0.96
109	2026-05-21 08:00:00	9	7.6	220.4	1675	t	2026-05-25 23:02:52.42556	1610	1675	469	0.96
110	2026-05-21 09:00:00	9	7.3	220	1606	t	2026-05-25 23:02:52.42556	1550	1606	449	0.96
111	2026-05-21 10:00:00	9	8.1	219.8	1780	t	2026-05-25 23:02:52.42556	1710	1780	498	0.96
112	2026-05-21 14:00:00	9	7.5	220.6	1655	t	2026-05-25 23:02:52.42556	1590	1655	463	0.96
113	2026-05-21 15:00:00	9	8.2	220.2	1806	t	2026-05-25 23:02:52.42556	1740	1806	505	0.96
\.


--
-- Data for Name: metas; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.metas (id, local_id, quadro_id, descricao, kwh_baseline, kwh_meta, data_inicio, data_fim, criado_em) FROM stdin;
1	2	1	Reducao 10% Terreo ADM Q1/26	1200	1080	2026-01-01	2026-03-31	2026-05-08 00:01:31.351496
2	3	2	Reducao 15% 1 Andar ADM Q1/26	980	833	2026-01-01	2026-03-31	2026-05-08 00:01:31.351496
3	4	3	Reducao 20% 2 Andar TI Q1/26	1100	880	2026-01-01	2026-03-31	2026-05-08 00:01:31.351496
\.


--
-- Data for Name: quadros; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.quadros (id, nome, local_id, area_id, quadro_pai_id, descricao) FROM stdin;
1	QLT-307	2	1	\N	Quadro principal - Terreo ADM
2	QLT-301	3	2	1	Quadro - 1 Andar ADM
3	QLT-302	4	3	1	Quadro - 2 Andar / Reitoria
\.


--
-- Data for Name: rateio; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.rateio (id, fatura_id, area_id, kwh, percentual, valor_rs, gerado_em) FROM stdin;
1	3	1	1258.7	0.72	893.51	2026-05-08 00:01:30.908358
2	3	2	1548.89	0.89	1099.5	2026-05-08 00:01:30.908358
3	3	3	1821.55	1.04	1293.05	2026-05-08 00:01:30.908358
\.


--
-- Data for Name: tarifas; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tarifas (id, local_id, valor_kwh, vigencia, descricao, criado_em) FROM stdin;
\.


--
-- Name: alertas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.alertas_id_seq', 5, true);


--
-- Name: areas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.areas_id_seq', 3, true);


--
-- Name: canais_medicao_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.canais_medicao_id_seq', 9, true);


--
-- Name: consumo_diario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.consumo_diario_id_seq', 21, true);


--
-- Name: dispositivos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.dispositivos_id_seq', 4, false);


--
-- Name: dispositivos_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.dispositivos_status_id_seq', 4, false);


--
-- Name: enel_instalacoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.enel_instalacoes_id_seq', 1, false);


--
-- Name: fatura_itens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.fatura_itens_id_seq', 1, false);


--
-- Name: faturas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.faturas_id_seq', 3, true);


--
-- Name: faturas_ocr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.faturas_ocr_id_seq', 1, false);


--
-- Name: locais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.locais_id_seq', 4, true);


--
-- Name: medicoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.medicoes_id_seq', 113, true);


--
-- Name: metas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.metas_id_seq', 3, true);


--
-- Name: quadros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.quadros_id_seq', 3, true);


--
-- Name: rateio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rateio_id_seq', 3, true);


--
-- Name: tarifas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tarifas_id_seq', 4, true);


--
-- Name: alertas alertas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alertas
    ADD CONSTRAINT alertas_pkey PRIMARY KEY (id);


--
-- Name: areas areas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_pkey PRIMARY KEY (id);


--
-- Name: canais_medicao canais_medicao_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.canais_medicao
    ADD CONSTRAINT canais_medicao_pkey PRIMARY KEY (id);


--
-- Name: consumo_diario consumo_diario_canal_id_data_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.consumo_diario
    ADD CONSTRAINT consumo_diario_canal_id_data_key UNIQUE (canal_id, data);


--
-- Name: consumo_diario consumo_diario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.consumo_diario
    ADD CONSTRAINT consumo_diario_pkey PRIMARY KEY (id);


--
-- Name: dispositivos dispositivos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dispositivos
    ADD CONSTRAINT dispositivos_pkey PRIMARY KEY (id);


--
-- Name: dispositivos_status dispositivos_status_dispositivo_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dispositivos_status
    ADD CONSTRAINT dispositivos_status_dispositivo_id_key UNIQUE (dispositivo_id);


--
-- Name: dispositivos_status dispositivos_status_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dispositivos_status
    ADD CONSTRAINT dispositivos_status_pkey PRIMARY KEY (id);


--
-- Name: enel_instalacoes enel_instalacoes_local_id_numero_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enel_instalacoes
    ADD CONSTRAINT enel_instalacoes_local_id_numero_key UNIQUE (local_id, numero);


--
-- Name: enel_instalacoes enel_instalacoes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enel_instalacoes
    ADD CONSTRAINT enel_instalacoes_pkey PRIMARY KEY (id);


--
-- Name: fatura_itens fatura_itens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fatura_itens
    ADD CONSTRAINT fatura_itens_pkey PRIMARY KEY (id);


--
-- Name: faturas faturas_local_id_mes_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faturas
    ADD CONSTRAINT faturas_local_id_mes_key UNIQUE (local_id, mes);


--
-- Name: faturas_ocr faturas_ocr_fatura_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faturas_ocr
    ADD CONSTRAINT faturas_ocr_fatura_id_key UNIQUE (fatura_id);


--
-- Name: faturas_ocr faturas_ocr_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faturas_ocr
    ADD CONSTRAINT faturas_ocr_pkey PRIMARY KEY (id);


--
-- Name: faturas faturas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faturas
    ADD CONSTRAINT faturas_pkey PRIMARY KEY (id);


--
-- Name: locais locais_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locais
    ADD CONSTRAINT locais_pkey PRIMARY KEY (id);


--
-- Name: medicoes medicoes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medicoes
    ADD CONSTRAINT medicoes_pkey PRIMARY KEY (id);


--
-- Name: metas metas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metas
    ADD CONSTRAINT metas_pkey PRIMARY KEY (id);


--
-- Name: quadros quadros_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quadros
    ADD CONSTRAINT quadros_pkey PRIMARY KEY (id);


--
-- Name: rateio rateio_fatura_id_area_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rateio
    ADD CONSTRAINT rateio_fatura_id_area_id_key UNIQUE (fatura_id, area_id);


--
-- Name: rateio rateio_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rateio
    ADD CONSTRAINT rateio_pkey PRIMARY KEY (id);


--
-- Name: tarifas tarifas_local_id_vigencia_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tarifas
    ADD CONSTRAINT tarifas_local_id_vigencia_key UNIQUE (local_id, vigencia);


--
-- Name: tarifas tarifas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tarifas
    ADD CONSTRAINT tarifas_pkey PRIMARY KEY (id);


--
-- Name: idx_alertas_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_alertas_timestamp ON public.alertas USING btree ("timestamp");


--
-- Name: idx_consumo_diario_data; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_consumo_diario_data ON public.consumo_diario USING btree (canal_id, data);


--
-- Name: idx_enel_inst_local; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_enel_inst_local ON public.enel_instalacoes USING btree (local_id);


--
-- Name: idx_fatura_itens_fatura; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fatura_itens_fatura ON public.fatura_itens USING btree (fatura_id);


--
-- Name: idx_faturas_ocr_fatura; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_faturas_ocr_fatura ON public.faturas_ocr USING btree (fatura_id);


--
-- Name: idx_faturas_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_faturas_status ON public.faturas USING btree (status);


--
-- Name: idx_faturas_vencimento; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_faturas_vencimento ON public.faturas USING btree (vencimento);


--
-- Name: idx_medicoes_canal; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_medicoes_canal ON public.medicoes USING btree (canal_id);


--
-- Name: idx_medicoes_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_medicoes_timestamp ON public.medicoes USING btree ("timestamp");


--
-- Name: idx_tarifas_local; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tarifas_local ON public.tarifas USING btree (local_id, vigencia);


--
-- Name: enel_instalacoes trg_enel_inst_atualizado_em; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_enel_inst_atualizado_em BEFORE UPDATE ON public.enel_instalacoes FOR EACH ROW EXECUTE FUNCTION public.set_atualizado_em();


--
-- Name: faturas trg_faturas_atualizado_em; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_faturas_atualizado_em BEFORE UPDATE ON public.faturas FOR EACH ROW EXECUTE FUNCTION public.set_atualizado_em();


--
-- Name: faturas_ocr trg_faturas_ocr_atualizado_em; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_faturas_ocr_atualizado_em BEFORE UPDATE ON public.faturas_ocr FOR EACH ROW EXECUTE FUNCTION public.set_atualizado_em();


--
-- Name: alertas alertas_canal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alertas
    ADD CONSTRAINT alertas_canal_id_fkey FOREIGN KEY (canal_id) REFERENCES public.canais_medicao(id);


--
-- Name: areas areas_local_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_local_id_fkey FOREIGN KEY (local_id) REFERENCES public.locais(id);


--
-- Name: canais_medicao canais_medicao_dispositivo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.canais_medicao
    ADD CONSTRAINT canais_medicao_dispositivo_id_fkey FOREIGN KEY (dispositivo_id) REFERENCES public.dispositivos(id);


--
-- Name: consumo_diario consumo_diario_canal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.consumo_diario
    ADD CONSTRAINT consumo_diario_canal_id_fkey FOREIGN KEY (canal_id) REFERENCES public.canais_medicao(id);


--
-- Name: dispositivos dispositivos_quadro_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dispositivos
    ADD CONSTRAINT dispositivos_quadro_id_fkey FOREIGN KEY (quadro_id) REFERENCES public.quadros(id);


--
-- Name: dispositivos_status dispositivos_status_dispositivo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dispositivos_status
    ADD CONSTRAINT dispositivos_status_dispositivo_id_fkey FOREIGN KEY (dispositivo_id) REFERENCES public.dispositivos(id);


--
-- Name: enel_instalacoes enel_instalacoes_local_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enel_instalacoes
    ADD CONSTRAINT enel_instalacoes_local_id_fkey FOREIGN KEY (local_id) REFERENCES public.locais(id) ON DELETE CASCADE;


--
-- Name: fatura_itens fatura_itens_fatura_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fatura_itens
    ADD CONSTRAINT fatura_itens_fatura_id_fkey FOREIGN KEY (fatura_id) REFERENCES public.faturas(id) ON DELETE CASCADE;


--
-- Name: faturas faturas_instalacao_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faturas
    ADD CONSTRAINT faturas_instalacao_id_fkey FOREIGN KEY (instalacao_id) REFERENCES public.enel_instalacoes(id) ON DELETE SET NULL;


--
-- Name: faturas faturas_local_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faturas
    ADD CONSTRAINT faturas_local_id_fkey FOREIGN KEY (local_id) REFERENCES public.locais(id);


--
-- Name: faturas_ocr faturas_ocr_fatura_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faturas_ocr
    ADD CONSTRAINT faturas_ocr_fatura_id_fkey FOREIGN KEY (fatura_id) REFERENCES public.faturas(id) ON DELETE CASCADE;


--
-- Name: medicoes medicoes_canal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medicoes
    ADD CONSTRAINT medicoes_canal_id_fkey FOREIGN KEY (canal_id) REFERENCES public.canais_medicao(id);


--
-- Name: metas metas_local_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metas
    ADD CONSTRAINT metas_local_id_fkey FOREIGN KEY (local_id) REFERENCES public.locais(id);


--
-- Name: metas metas_quadro_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metas
    ADD CONSTRAINT metas_quadro_id_fkey FOREIGN KEY (quadro_id) REFERENCES public.quadros(id);


--
-- Name: quadros quadros_area_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quadros
    ADD CONSTRAINT quadros_area_id_fkey FOREIGN KEY (area_id) REFERENCES public.areas(id);


--
-- Name: quadros quadros_local_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quadros
    ADD CONSTRAINT quadros_local_id_fkey FOREIGN KEY (local_id) REFERENCES public.locais(id);


--
-- Name: quadros quadros_quadro_pai_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quadros
    ADD CONSTRAINT quadros_quadro_pai_id_fkey FOREIGN KEY (quadro_pai_id) REFERENCES public.quadros(id) ON DELETE SET NULL;


--
-- Name: rateio rateio_area_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rateio
    ADD CONSTRAINT rateio_area_id_fkey FOREIGN KEY (area_id) REFERENCES public.areas(id);


--
-- Name: rateio rateio_fatura_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rateio
    ADD CONSTRAINT rateio_fatura_id_fkey FOREIGN KEY (fatura_id) REFERENCES public.faturas(id);


--
-- Name: tarifas tarifas_local_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tarifas
    ADD CONSTRAINT tarifas_local_id_fkey FOREIGN KEY (local_id) REFERENCES public.locais(id);


--
-- PostgreSQL database dump complete
--

\unrestrict Yqs468aR1Ai0Zqp0esEEK8IXu21ahY6shTzUElB1oriRWKniFqvh5MBE9pefM00

