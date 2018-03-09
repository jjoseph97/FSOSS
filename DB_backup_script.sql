--
-- PostgreSQL database dump
--

-- Dumped from database version 10.2
-- Dumped by pg_dump version 10.2

-- Started on 2018-03-09 08:41:13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12924)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 3025 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 2 (class 3079 OID 18597)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 3026 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 200 (class 1259 OID 18644)
-- Name: administrator_account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE administrator_account (
    administrator_account_id integer NOT NULL,
    username character varying(50) NOT NULL,
    admin_password character varying(60) NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    active_yn boolean DEFAULT true NOT NULL,
    date_created timestamp without time zone DEFAULT now() NOT NULL,
    date_modified timestamp without time zone
);


ALTER TABLE administrator_account OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 18642)
-- Name: administrator_account_administrator_account_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE administrator_account_administrator_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE administrator_account_administrator_account_id_seq OWNER TO postgres;

--
-- TOC entry 3027 (class 0 OID 0)
-- Dependencies: 199
-- Name: administrator_account_administrator_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE administrator_account_administrator_account_id_seq OWNED BY administrator_account.administrator_account_id;


--
-- TOC entry 219 (class 1259 OID 18750)
-- Name: administrator_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE administrator_role (
    administrator_account_id integer NOT NULL,
    security_role_id integer NOT NULL,
    date_modified timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE administrator_role OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 18686)
-- Name: age_range; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE age_range (
    age_range_id integer NOT NULL,
    age_range_description character varying(100) NOT NULL
);


ALTER TABLE age_range OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 18684)
-- Name: age_range_age_range_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE age_range_age_range_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE age_range_age_range_id_seq OWNER TO postgres;

--
-- TOC entry 3028 (class 0 OID 0)
-- Dependencies: 207
-- Name: age_range_age_range_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE age_range_age_range_id_seq OWNED BY age_range.age_range_id;


--
-- TOC entry 210 (class 1259 OID 18694)
-- Name: gender; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE gender (
    gender_id integer NOT NULL,
    gender_description character varying(100) NOT NULL
);


ALTER TABLE gender OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 18692)
-- Name: gender_gender_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE gender_gender_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE gender_gender_id_seq OWNER TO postgres;

--
-- TOC entry 3029 (class 0 OID 0)
-- Dependencies: 209
-- Name: gender_gender_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE gender_gender_id_seq OWNED BY gender.gender_id;


--
-- TOC entry 206 (class 1259 OID 18678)
-- Name: meal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE meal (
    meal_id integer NOT NULL,
    meal_name character varying(100) NOT NULL
);


ALTER TABLE meal OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 18676)
-- Name: meal_meal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE meal_meal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE meal_meal_id_seq OWNER TO postgres;

--
-- TOC entry 3030 (class 0 OID 0)
-- Dependencies: 205
-- Name: meal_meal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE meal_meal_id_seq OWNED BY meal.meal_id;


--
-- TOC entry 229 (class 1259 OID 18873)
-- Name: participant_response; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE participant_response (
    submitted_survey_id integer NOT NULL,
    question_id integer NOT NULL,
    participant_answer text
);


ALTER TABLE participant_response OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 18710)
-- Name: participant_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE participant_type (
    participant_type_id integer NOT NULL,
    participant_description character varying(100) NOT NULL
);


ALTER TABLE participant_type OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 18708)
-- Name: participant_type_participant_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE participant_type_participant_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE participant_type_participant_type_id_seq OWNER TO postgres;

--
-- TOC entry 3031 (class 0 OID 0)
-- Dependencies: 213
-- Name: participant_type_participant_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE participant_type_participant_type_id_seq OWNED BY participant_type.participant_type_id;


--
-- TOC entry 216 (class 1259 OID 18718)
-- Name: potential_survey_word; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE potential_survey_word (
    survey_word_id integer NOT NULL,
    administrator_account_id integer NOT NULL,
    survey_access_word character varying(8) NOT NULL,
    date_modified timestamp without time zone DEFAULT now() NOT NULL,
    archive_yn boolean DEFAULT false NOT NULL
);


ALTER TABLE potential_survey_word OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 18716)
-- Name: potential_survey_word_survey_word_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE potential_survey_word_survey_word_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE potential_survey_word_survey_word_id_seq OWNER TO postgres;

--
-- TOC entry 3032 (class 0 OID 0)
-- Dependencies: 215
-- Name: potential_survey_word_survey_word_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE potential_survey_word_survey_word_id_seq OWNED BY potential_survey_word.survey_word_id;


--
-- TOC entry 223 (class 1259 OID 18782)
-- Name: question; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE question (
    question_id integer NOT NULL,
    administrator_account_id integer NOT NULL,
    question_format_id integer NOT NULL,
    question_topic_id integer NOT NULL,
    question_text character varying(250) NOT NULL,
    date_created timestamp without time zone DEFAULT now() NOT NULL,
    is_extra boolean DEFAULT false NOT NULL
);


ALTER TABLE question OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 18670)
-- Name: question_format; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE question_format (
    question_format_id integer NOT NULL,
    question_format_name character varying(100) NOT NULL
);


ALTER TABLE question_format OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 18668)
-- Name: question_format_question_format_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE question_format_question_format_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE question_format_question_format_id_seq OWNER TO postgres;

--
-- TOC entry 3033 (class 0 OID 0)
-- Dependencies: 203
-- Name: question_format_question_format_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE question_format_question_format_id_seq OWNED BY question_format.question_format_id;


--
-- TOC entry 222 (class 1259 OID 18780)
-- Name: question_question_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE question_question_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE question_question_id_seq OWNER TO postgres;

--
-- TOC entry 3034 (class 0 OID 0)
-- Dependencies: 222
-- Name: question_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE question_question_id_seq OWNED BY question.question_id;


--
-- TOC entry 228 (class 1259 OID 18862)
-- Name: question_selection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE question_selection (
    question_selection_id integer NOT NULL,
    question_id integer NOT NULL,
    question_selection_text character varying(100) NOT NULL,
    question_selection_value character varying(100) NOT NULL
);


ALTER TABLE question_selection OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 18860)
-- Name: question_selection_question_selection_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE question_selection_question_selection_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE question_selection_question_selection_id_seq OWNER TO postgres;

--
-- TOC entry 3035 (class 0 OID 0)
-- Dependencies: 227
-- Name: question_selection_question_selection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE question_selection_question_selection_id_seq OWNED BY question_selection.question_selection_id;


--
-- TOC entry 212 (class 1259 OID 18702)
-- Name: question_topic; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE question_topic (
    question_topic_id integer NOT NULL,
    question_topic_description character varying(100) NOT NULL
);


ALTER TABLE question_topic OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 18700)
-- Name: question_topic_question_topic_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE question_topic_question_topic_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE question_topic_question_topic_id_seq OWNER TO postgres;

--
-- TOC entry 3036 (class 0 OID 0)
-- Dependencies: 211
-- Name: question_topic_question_topic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE question_topic_question_topic_id_seq OWNED BY question_topic.question_topic_id;


--
-- TOC entry 198 (class 1259 OID 18636)
-- Name: security_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE security_role (
    security_role_id integer NOT NULL,
    security_description character varying(100) NOT NULL
);


ALTER TABLE security_role OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 18634)
-- Name: security_role_security_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE security_role_security_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE security_role_security_role_id_seq OWNER TO postgres;

--
-- TOC entry 3037 (class 0 OID 0)
-- Dependencies: 197
-- Name: security_role_security_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE security_role_security_role_id_seq OWNED BY security_role.security_role_id;


--
-- TOC entry 202 (class 1259 OID 18656)
-- Name: site; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE site (
    site_id integer NOT NULL,
    site_name character varying(100) NOT NULL,
    date_modified timestamp without time zone NOT NULL,
    administrator_account_id integer NOT NULL,
    is_closed_yn boolean DEFAULT false NOT NULL
);


ALTER TABLE site OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 18654)
-- Name: site_site_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE site_site_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE site_site_id_seq OWNER TO postgres;

--
-- TOC entry 3038 (class 0 OID 0)
-- Dependencies: 201
-- Name: site_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE site_site_id_seq OWNED BY site.site_id;


--
-- TOC entry 226 (class 1259 OID 18823)
-- Name: submitted_survey; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE submitted_survey (
    submitted_survey_id integer NOT NULL,
    survey_version_id integer NOT NULL,
    unit_id integer NOT NULL,
    meal_id integer NOT NULL,
    participant_type_id integer NOT NULL,
    age_range_id integer NOT NULL,
    gender_id integer NOT NULL,
    date_entered timestamp without time zone DEFAULT now() NOT NULL,
    contact_status character varying(100) NOT NULL,
    contact_room_number character varying(50),
    contact_phone_number character varying(20)
);


ALTER TABLE submitted_survey OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 18821)
-- Name: submitted_survey_submitted_survey_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE submitted_survey_submitted_survey_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE submitted_survey_submitted_survey_id_seq OWNER TO postgres;

--
-- TOC entry 3039 (class 0 OID 0)
-- Dependencies: 225
-- Name: submitted_survey_submitted_survey_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE submitted_survey_submitted_survey_id_seq OWNED BY submitted_survey.submitted_survey_id;


--
-- TOC entry 230 (class 1259 OID 18891)
-- Name: survey_question; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE survey_question (
    survey_version_id integer NOT NULL,
    question_id integer NOT NULL
);


ALTER TABLE survey_question OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 18768)
-- Name: survey_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE survey_version (
    survey_version_id integer NOT NULL,
    administrator_account_id integer NOT NULL,
    start_date timestamp without time zone DEFAULT now() NOT NULL,
    end_date timestamp without time zone
);


ALTER TABLE survey_version OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 18766)
-- Name: survey_version_survey_version_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE survey_version_survey_version_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE survey_version_survey_version_id_seq OWNER TO postgres;

--
-- TOC entry 3040 (class 0 OID 0)
-- Dependencies: 220
-- Name: survey_version_survey_version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE survey_version_survey_version_id_seq OWNED BY survey_version.survey_version_id;


--
-- TOC entry 224 (class 1259 OID 18805)
-- Name: survey_word; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE survey_word (
    survey_word_id integer NOT NULL,
    site_id integer NOT NULL,
    date_used timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE survey_word OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 18733)
-- Name: unit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE unit (
    unit_id integer NOT NULL,
    unit_number character varying(100) NOT NULL,
    site_id integer NOT NULL,
    date_modified timestamp without time zone NOT NULL,
    administrator_account_id integer NOT NULL,
    is_closed_yn boolean DEFAULT false NOT NULL
);


ALTER TABLE unit OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 18731)
-- Name: unit_unit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE unit_unit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE unit_unit_id_seq OWNER TO postgres;

--
-- TOC entry 3041 (class 0 OID 0)
-- Dependencies: 217
-- Name: unit_unit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE unit_unit_id_seq OWNED BY unit.unit_id;


--
-- TOC entry 2809 (class 2604 OID 18647)
-- Name: administrator_account administrator_account_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administrator_account ALTER COLUMN administrator_account_id SET DEFAULT nextval('administrator_account_administrator_account_id_seq'::regclass);


--
-- TOC entry 2816 (class 2604 OID 18689)
-- Name: age_range age_range_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY age_range ALTER COLUMN age_range_id SET DEFAULT nextval('age_range_age_range_id_seq'::regclass);


--
-- TOC entry 2817 (class 2604 OID 18697)
-- Name: gender gender_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gender ALTER COLUMN gender_id SET DEFAULT nextval('gender_gender_id_seq'::regclass);


--
-- TOC entry 2815 (class 2604 OID 18681)
-- Name: meal meal_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY meal ALTER COLUMN meal_id SET DEFAULT nextval('meal_meal_id_seq'::regclass);


--
-- TOC entry 2819 (class 2604 OID 18713)
-- Name: participant_type participant_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY participant_type ALTER COLUMN participant_type_id SET DEFAULT nextval('participant_type_participant_type_id_seq'::regclass);


--
-- TOC entry 2820 (class 2604 OID 18721)
-- Name: potential_survey_word survey_word_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY potential_survey_word ALTER COLUMN survey_word_id SET DEFAULT nextval('potential_survey_word_survey_word_id_seq'::regclass);


--
-- TOC entry 2828 (class 2604 OID 18785)
-- Name: question question_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY question ALTER COLUMN question_id SET DEFAULT nextval('question_question_id_seq'::regclass);


--
-- TOC entry 2814 (class 2604 OID 18673)
-- Name: question_format question_format_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY question_format ALTER COLUMN question_format_id SET DEFAULT nextval('question_format_question_format_id_seq'::regclass);


--
-- TOC entry 2834 (class 2604 OID 18865)
-- Name: question_selection question_selection_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY question_selection ALTER COLUMN question_selection_id SET DEFAULT nextval('question_selection_question_selection_id_seq'::regclass);


--
-- TOC entry 2818 (class 2604 OID 18705)
-- Name: question_topic question_topic_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY question_topic ALTER COLUMN question_topic_id SET DEFAULT nextval('question_topic_question_topic_id_seq'::regclass);


--
-- TOC entry 2808 (class 2604 OID 18639)
-- Name: security_role security_role_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY security_role ALTER COLUMN security_role_id SET DEFAULT nextval('security_role_security_role_id_seq'::regclass);


--
-- TOC entry 2812 (class 2604 OID 18659)
-- Name: site site_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY site ALTER COLUMN site_id SET DEFAULT nextval('site_site_id_seq'::regclass);


--
-- TOC entry 2832 (class 2604 OID 18826)
-- Name: submitted_survey submitted_survey_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY submitted_survey ALTER COLUMN submitted_survey_id SET DEFAULT nextval('submitted_survey_submitted_survey_id_seq'::regclass);


--
-- TOC entry 2827 (class 2604 OID 18771)
-- Name: survey_version survey_version_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY survey_version ALTER COLUMN survey_version_id SET DEFAULT nextval('survey_version_survey_version_id_seq'::regclass);


--
-- TOC entry 2823 (class 2604 OID 18736)
-- Name: unit unit_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY unit ALTER COLUMN unit_id SET DEFAULT nextval('unit_unit_id_seq'::regclass);


--
-- TOC entry 2838 (class 2606 OID 18651)
-- Name: administrator_account administrator_account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administrator_account
    ADD CONSTRAINT administrator_account_pkey PRIMARY KEY (administrator_account_id);


--
-- TOC entry 2840 (class 2606 OID 18653)
-- Name: administrator_account administrator_account_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administrator_account
    ADD CONSTRAINT administrator_account_username_key UNIQUE (username);


--
-- TOC entry 2860 (class 2606 OID 18755)
-- Name: administrator_role administrator_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administrator_role
    ADD CONSTRAINT administrator_role_pkey PRIMARY KEY (administrator_account_id, security_role_id);


--
-- TOC entry 2848 (class 2606 OID 18691)
-- Name: age_range age_range_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY age_range
    ADD CONSTRAINT age_range_pkey PRIMARY KEY (age_range_id);


--
-- TOC entry 2850 (class 2606 OID 18699)
-- Name: gender gender_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gender
    ADD CONSTRAINT gender_pkey PRIMARY KEY (gender_id);


--
-- TOC entry 2846 (class 2606 OID 18683)
-- Name: meal meal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY meal
    ADD CONSTRAINT meal_pkey PRIMARY KEY (meal_id);


--
-- TOC entry 2872 (class 2606 OID 18880)
-- Name: participant_response participant_response_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY participant_response
    ADD CONSTRAINT participant_response_pkey PRIMARY KEY (submitted_survey_id, question_id);


--
-- TOC entry 2854 (class 2606 OID 18715)
-- Name: participant_type participant_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY participant_type
    ADD CONSTRAINT participant_type_pkey PRIMARY KEY (participant_type_id);


--
-- TOC entry 2856 (class 2606 OID 18725)
-- Name: potential_survey_word potential_survey_word_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY potential_survey_word
    ADD CONSTRAINT potential_survey_word_pkey PRIMARY KEY (survey_word_id);


--
-- TOC entry 2844 (class 2606 OID 18675)
-- Name: question_format question_format_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY question_format
    ADD CONSTRAINT question_format_pkey PRIMARY KEY (question_format_id);


--
-- TOC entry 2864 (class 2606 OID 18789)
-- Name: question question_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY question
    ADD CONSTRAINT question_pkey PRIMARY KEY (question_id);


--
-- TOC entry 2870 (class 2606 OID 18867)
-- Name: question_selection question_selection_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY question_selection
    ADD CONSTRAINT question_selection_pkey PRIMARY KEY (question_selection_id);


--
-- TOC entry 2852 (class 2606 OID 18707)
-- Name: question_topic question_topic_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY question_topic
    ADD CONSTRAINT question_topic_pkey PRIMARY KEY (question_topic_id);


--
-- TOC entry 2836 (class 2606 OID 18641)
-- Name: security_role security_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY security_role
    ADD CONSTRAINT security_role_pkey PRIMARY KEY (security_role_id);


--
-- TOC entry 2842 (class 2606 OID 18662)
-- Name: site site_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY site
    ADD CONSTRAINT site_pkey PRIMARY KEY (site_id);


--
-- TOC entry 2868 (class 2606 OID 18829)
-- Name: submitted_survey submitted_survey_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY submitted_survey
    ADD CONSTRAINT submitted_survey_pkey PRIMARY KEY (submitted_survey_id);


--
-- TOC entry 2874 (class 2606 OID 18895)
-- Name: survey_question survey_question_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY survey_question
    ADD CONSTRAINT survey_question_pkey PRIMARY KEY (survey_version_id, question_id);


--
-- TOC entry 2862 (class 2606 OID 18774)
-- Name: survey_version survey_version_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY survey_version
    ADD CONSTRAINT survey_version_pkey PRIMARY KEY (survey_version_id);


--
-- TOC entry 2866 (class 2606 OID 18810)
-- Name: survey_word survey_word_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY survey_word
    ADD CONSTRAINT survey_word_pkey PRIMARY KEY (survey_word_id, site_id);


--
-- TOC entry 2858 (class 2606 OID 18739)
-- Name: unit unit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY unit
    ADD CONSTRAINT unit_pkey PRIMARY KEY (unit_id);


--
-- TOC entry 2879 (class 2606 OID 18756)
-- Name: administrator_role administrator_role_administrator_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administrator_role
    ADD CONSTRAINT administrator_role_administrator_account_id_fkey FOREIGN KEY (administrator_account_id) REFERENCES administrator_account(administrator_account_id);


--
-- TOC entry 2880 (class 2606 OID 18761)
-- Name: administrator_role administrator_role_security_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administrator_role
    ADD CONSTRAINT administrator_role_security_role_id_fkey FOREIGN KEY (security_role_id) REFERENCES security_role(security_role_id);


--
-- TOC entry 2895 (class 2606 OID 18886)
-- Name: participant_response participant_response_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY participant_response
    ADD CONSTRAINT participant_response_question_id_fkey FOREIGN KEY (question_id) REFERENCES question(question_id);


--
-- TOC entry 2894 (class 2606 OID 18881)
-- Name: participant_response participant_response_submitted_survey_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY participant_response
    ADD CONSTRAINT participant_response_submitted_survey_id_fkey FOREIGN KEY (submitted_survey_id) REFERENCES submitted_survey(submitted_survey_id);


--
-- TOC entry 2876 (class 2606 OID 18726)
-- Name: potential_survey_word potential_survey_word_administrator_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY potential_survey_word
    ADD CONSTRAINT potential_survey_word_administrator_account_id_fkey FOREIGN KEY (administrator_account_id) REFERENCES administrator_account(administrator_account_id);


--
-- TOC entry 2882 (class 2606 OID 18790)
-- Name: question question_administrator_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY question
    ADD CONSTRAINT question_administrator_account_id_fkey FOREIGN KEY (administrator_account_id) REFERENCES administrator_account(administrator_account_id);


--
-- TOC entry 2883 (class 2606 OID 18795)
-- Name: question question_question_format_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY question
    ADD CONSTRAINT question_question_format_id_fkey FOREIGN KEY (question_format_id) REFERENCES question_format(question_format_id);


--
-- TOC entry 2884 (class 2606 OID 18800)
-- Name: question question_question_topic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY question
    ADD CONSTRAINT question_question_topic_id_fkey FOREIGN KEY (question_topic_id) REFERENCES question_topic(question_topic_id);


--
-- TOC entry 2893 (class 2606 OID 18868)
-- Name: question_selection question_selection_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY question_selection
    ADD CONSTRAINT question_selection_question_id_fkey FOREIGN KEY (question_id) REFERENCES question(question_id);


--
-- TOC entry 2875 (class 2606 OID 18663)
-- Name: site site_administrator_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY site
    ADD CONSTRAINT site_administrator_account_id_fkey FOREIGN KEY (administrator_account_id) REFERENCES administrator_account(administrator_account_id);


--
-- TOC entry 2888 (class 2606 OID 18835)
-- Name: submitted_survey submitted_survey_age_range_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY submitted_survey
    ADD CONSTRAINT submitted_survey_age_range_id_fkey FOREIGN KEY (age_range_id) REFERENCES age_range(age_range_id);


--
-- TOC entry 2892 (class 2606 OID 18855)
-- Name: submitted_survey submitted_survey_gender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY submitted_survey
    ADD CONSTRAINT submitted_survey_gender_id_fkey FOREIGN KEY (gender_id) REFERENCES gender(gender_id);


--
-- TOC entry 2890 (class 2606 OID 18845)
-- Name: submitted_survey submitted_survey_meal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY submitted_survey
    ADD CONSTRAINT submitted_survey_meal_id_fkey FOREIGN KEY (meal_id) REFERENCES meal(meal_id);


--
-- TOC entry 2891 (class 2606 OID 18850)
-- Name: submitted_survey submitted_survey_participant_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY submitted_survey
    ADD CONSTRAINT submitted_survey_participant_type_id_fkey FOREIGN KEY (participant_type_id) REFERENCES participant_type(participant_type_id);


--
-- TOC entry 2887 (class 2606 OID 18830)
-- Name: submitted_survey submitted_survey_survey_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY submitted_survey
    ADD CONSTRAINT submitted_survey_survey_version_id_fkey FOREIGN KEY (survey_version_id) REFERENCES survey_version(survey_version_id);


--
-- TOC entry 2889 (class 2606 OID 18840)
-- Name: submitted_survey submitted_survey_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY submitted_survey
    ADD CONSTRAINT submitted_survey_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES unit(unit_id);


--
-- TOC entry 2897 (class 2606 OID 18901)
-- Name: survey_question survey_question_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY survey_question
    ADD CONSTRAINT survey_question_question_id_fkey FOREIGN KEY (question_id) REFERENCES question(question_id);


--
-- TOC entry 2896 (class 2606 OID 18896)
-- Name: survey_question survey_question_survey_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY survey_question
    ADD CONSTRAINT survey_question_survey_version_id_fkey FOREIGN KEY (survey_version_id) REFERENCES survey_version(survey_version_id);


--
-- TOC entry 2881 (class 2606 OID 18775)
-- Name: survey_version survey_version_administrator_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY survey_version
    ADD CONSTRAINT survey_version_administrator_account_id_fkey FOREIGN KEY (administrator_account_id) REFERENCES administrator_account(administrator_account_id);


--
-- TOC entry 2886 (class 2606 OID 18816)
-- Name: survey_word survey_word_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY survey_word
    ADD CONSTRAINT survey_word_site_id_fkey FOREIGN KEY (site_id) REFERENCES site(site_id);


--
-- TOC entry 2885 (class 2606 OID 18811)
-- Name: survey_word survey_word_survey_word_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY survey_word
    ADD CONSTRAINT survey_word_survey_word_id_fkey FOREIGN KEY (survey_word_id) REFERENCES potential_survey_word(survey_word_id);


--
-- TOC entry 2877 (class 2606 OID 18740)
-- Name: unit unit_administrator_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY unit
    ADD CONSTRAINT unit_administrator_account_id_fkey FOREIGN KEY (administrator_account_id) REFERENCES administrator_account(administrator_account_id);


--
-- TOC entry 2878 (class 2606 OID 18745)
-- Name: unit unit_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY unit
    ADD CONSTRAINT unit_site_id_fkey FOREIGN KEY (site_id) REFERENCES site(site_id);


-- Completed on 2018-03-09 08:41:14

--
-- PostgreSQL database dump complete
--

