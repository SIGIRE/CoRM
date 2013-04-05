--
-- PostgreSQL database cluster dump
--

\connect postgres

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET escape_string_warning = off;

--
-- Roles
--

CREATE ROLE crm;
ALTER ROLE crm WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN;
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN PASSWORD 'md501240c83534256dbcc5bb928331807e9';






--
-- Database creation
--

CREATE DATABASE crm_development WITH TEMPLATE = template0 OWNER = postgres;
CREATE DATABASE crm_production WITH TEMPLATE = template0 OWNER = postgres;
REVOKE ALL ON DATABASE template1 FROM PUBLIC;
REVOKE ALL ON DATABASE template1 FROM postgres;
GRANT ALL ON DATABASE template1 TO postgres;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


\connect crm_development

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: active_admin_comments; Type: TABLE; Schema: public; Owner: crm; Tablespace: 
--

CREATE TABLE active_admin_comments (
    id integer NOT NULL,
    resource_id integer NOT NULL,
    resource_type character varying(255) NOT NULL,
    author_id integer,
    author_type character varying(255),
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    namespace character varying(255)
);


ALTER TABLE public.active_admin_comments OWNER TO crm;

--
-- Name: admin_notes_id_seq; Type: SEQUENCE; Schema: public; Owner: crm
--

CREATE SEQUENCE admin_notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.admin_notes_id_seq OWNER TO crm;

--
-- Name: admin_notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: crm
--

ALTER SEQUENCE admin_notes_id_seq OWNED BY active_admin_comments.id;


--
-- Name: admin_notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: crm
--

SELECT pg_catalog.setval('admin_notes_id_seq', 1, false);


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: crm; Tablespace: 
--

CREATE TABLE admin_users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.admin_users OWNER TO crm;

--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: crm
--

CREATE SEQUENCE admin_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.admin_users_id_seq OWNER TO crm;

--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: crm
--

ALTER SEQUENCE admin_users_id_seq OWNED BY admin_users.id;


--
-- Name: admin_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: crm
--

SELECT pg_catalog.setval('admin_users_id_seq', 1, true);


--
-- Name: comptes; Type: TABLE; Schema: public; Owner: crm; Tablespace: 
--

CREATE TABLE comptes (
    id integer NOT NULL,
    societe character varying(255),
    adresse1 character varying(255),
    adresse2 character varying(255),
    cp character varying(255),
    ville character varying(255),
    pays character varying(255),
    origine character varying(255),
    code_compta character varying(255),
    notes text,
    created_by character varying(255),
    modified_by character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer,
    genre character varying(255),
    tel character varying(255),
    fax character varying(255),
    email character varying(255),
    web character varying(255)
);


ALTER TABLE public.comptes OWNER TO crm;

--
-- Name: comptes_id_seq; Type: SEQUENCE; Schema: public; Owner: crm
--

CREATE SEQUENCE comptes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.comptes_id_seq OWNER TO crm;

--
-- Name: comptes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: crm
--

ALTER SEQUENCE comptes_id_seq OWNED BY comptes.id;


--
-- Name: comptes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: crm
--

SELECT pg_catalog.setval('comptes_id_seq', 1, false);


--
-- Name: comptes_produits; Type: TABLE; Schema: public; Owner: crm; Tablespace: 
--

CREATE TABLE comptes_produits (
    compte_id integer,
    produit_id integer
);


ALTER TABLE public.comptes_produits OWNER TO crm;

--
-- Name: contacts; Type: TABLE; Schema: public; Owner: crm; Tablespace: 
--

CREATE TABLE contacts (
    id integer NOT NULL,
    nom character varying(255),
    prenom character varying(255),
    civilite character varying(255),
    tel character varying(255),
    fax character varying(255),
    mobile character varying(255),
    email character varying(255),
    fonction character varying(255),
    notes text,
    created_by character varying(255),
    modified_by character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    compte_id integer
);


ALTER TABLE public.contacts OWNER TO crm;

--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: crm
--

CREATE SEQUENCE contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.contacts_id_seq OWNER TO crm;

--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: crm
--

ALTER SEQUENCE contacts_id_seq OWNED BY contacts.id;


--
-- Name: contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: crm
--

SELECT pg_catalog.setval('contacts_id_seq', 1, false);


--
-- Name: contacts_produits; Type: TABLE; Schema: public; Owner: crm; Tablespace: 
--

CREATE TABLE contacts_produits (
    contact_id integer,
    produit_id integer
);


ALTER TABLE public.contacts_produits OWNER TO crm;

--
-- Name: evenements; Type: TABLE; Schema: public; Owner: crm; Tablespace: 
--

CREATE TABLE evenements (
    id integer NOT NULL,
    debut timestamp without time zone,
    fin timestamp without time zone,
    notes text,
    created_by character varying(255),
    modified_by character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    contact_id integer,
    compte_id integer,
    type_id integer,
    user_id integer,
    fichier_joint_file_name character varying(255),
    fichier_joint_content_type character varying(255),
    fichier_joint_file_size integer,
    fichier_joint_updated_at timestamp without time zone,
    tache_id integer
);


ALTER TABLE public.evenements OWNER TO crm;

--
-- Name: evenements_id_seq; Type: SEQUENCE; Schema: public; Owner: crm
--

CREATE SEQUENCE evenements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.evenements_id_seq OWNER TO crm;

--
-- Name: evenements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: crm
--

ALTER SEQUENCE evenements_id_seq OWNED BY evenements.id;


--
-- Name: evenements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: crm
--

SELECT pg_catalog.setval('evenements_id_seq', 1, false);


--
-- Name: ma_table; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ma_table (
    col1 integer,
    coln integer
);


ALTER TABLE public.ma_table OWNER TO postgres;

--
-- Name: opportunites; Type: TABLE; Schema: public; Owner: crm; Tablespace: 
--

CREATE TABLE opportunites (
    id integer NOT NULL,
    nom character varying(255),
    description text,
    statut character varying(255),
    remarque character varying(255),
    montant double precision,
    echeance timestamp without time zone,
    fichier_joint_file_name character varying(255),
    fichier_joint_content_type character varying(255),
    fichier_joint_file_size integer,
    fichier_joint_updated_at timestamp without time zone,
    created_by character varying(255),
    updated_by character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    compte_id integer,
    contact_id integer,
    user_id integer,
    marge double precision
);


ALTER TABLE public.opportunites OWNER TO crm;

--
-- Name: opportunitees_id_seq; Type: SEQUENCE; Schema: public; Owner: crm
--

CREATE SEQUENCE opportunitees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.opportunitees_id_seq OWNER TO crm;

--
-- Name: opportunitees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: crm
--

ALTER SEQUENCE opportunitees_id_seq OWNED BY opportunites.id;


--
-- Name: opportunitees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: crm
--

SELECT pg_catalog.setval('opportunitees_id_seq', 1, false);


--
-- Name: origines; Type: TABLE; Schema: public; Owner: crm; Tablespace: 
--

CREATE TABLE origines (
    id integer NOT NULL,
    nom character varying(255),
    description text,
    created_by character varying(255),
    updated_by character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.origines OWNER TO crm;

--
-- Name: origines_id_seq; Type: SEQUENCE; Schema: public; Owner: crm
--

CREATE SEQUENCE origines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.origines_id_seq OWNER TO crm;

--
-- Name: origines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: crm
--

ALTER SEQUENCE origines_id_seq OWNED BY origines.id;


--
-- Name: origines_id_seq; Type: SEQUENCE SET; Schema: public; Owner: crm
--

SELECT pg_catalog.setval('origines_id_seq', 1, false);


--
-- Name: produits; Type: TABLE; Schema: public; Owner: crm; Tablespace: 
--

CREATE TABLE produits (
    id integer NOT NULL,
    nom character varying(255),
    description text,
    created_by character varying(255),
    updated_by character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.produits OWNER TO crm;

--
-- Name: produits_id_seq; Type: SEQUENCE; Schema: public; Owner: crm
--

CREATE SEQUENCE produits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.produits_id_seq OWNER TO crm;

--
-- Name: produits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: crm
--

ALTER SEQUENCE produits_id_seq OWNED BY produits.id;


--
-- Name: produits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: crm
--

SELECT pg_catalog.setval('produits_id_seq', 1, false);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: crm; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO crm;

--
-- Name: taches; Type: TABLE; Schema: public; Owner: crm; Tablespace: 
--

CREATE TABLE taches (
    id integer NOT NULL,
    notes text,
    statut character varying(255),
    created_at timestamp without time zone NOT NULL,
    created_by character varying(255),
    modified_at timestamp without time zone,
    modified_by character varying(255),
    updated_at timestamp without time zone NOT NULL,
    contact_id integer,
    compte_id integer,
    user_id integer,
    echeance character varying(255),
    fichier_joint_file_name character varying(255),
    fichier_joint_content_type character varying(255),
    fichier_joint_file_size integer,
    fichier_joint_updated_at timestamp without time zone
);


ALTER TABLE public.taches OWNER TO crm;

--
-- Name: taches_id_seq; Type: SEQUENCE; Schema: public; Owner: crm
--

CREATE SEQUENCE taches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.taches_id_seq OWNER TO crm;

--
-- Name: taches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: crm
--

ALTER SEQUENCE taches_id_seq OWNED BY taches.id;


--
-- Name: taches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: crm
--

SELECT pg_catalog.setval('taches_id_seq', 1, false);


--
-- Name: types; Type: TABLE; Schema: public; Owner: crm; Tablespace: 
--

CREATE TABLE types (
    id integer NOT NULL,
    libelle character varying(255),
    direction character varying(255),
    created_by character varying(255),
    modified_by character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.types OWNER TO crm;

--
-- Name: types_id_seq; Type: SEQUENCE; Schema: public; Owner: crm
--

CREATE SEQUENCE types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.types_id_seq OWNER TO crm;

--
-- Name: types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: crm
--

ALTER SEQUENCE types_id_seq OWNED BY types.id;


--
-- Name: types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: crm
--

SELECT pg_catalog.setval('types_id_seq', 1, false);


--
-- Name: users; Type: TABLE; Schema: public; Owner: crm; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    prenom character varying(255),
    nom character varying(255),
    tel character varying(255),
    mobile character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO crm;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: crm
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO crm;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: crm
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: crm
--

SELECT pg_catalog.setval('users_id_seq', 1, false);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: crm
--

ALTER TABLE ONLY active_admin_comments ALTER COLUMN id SET DEFAULT nextval('admin_notes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: crm
--

ALTER TABLE ONLY admin_users ALTER COLUMN id SET DEFAULT nextval('admin_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: crm
--

ALTER TABLE ONLY comptes ALTER COLUMN id SET DEFAULT nextval('comptes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: crm
--

ALTER TABLE ONLY contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: crm
--

ALTER TABLE ONLY evenements ALTER COLUMN id SET DEFAULT nextval('evenements_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: crm
--

ALTER TABLE ONLY opportunites ALTER COLUMN id SET DEFAULT nextval('opportunitees_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: crm
--

ALTER TABLE ONLY origines ALTER COLUMN id SET DEFAULT nextval('origines_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: crm
--

ALTER TABLE ONLY produits ALTER COLUMN id SET DEFAULT nextval('produits_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: crm
--

ALTER TABLE ONLY taches ALTER COLUMN id SET DEFAULT nextval('taches_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: crm
--

ALTER TABLE ONLY types ALTER COLUMN id SET DEFAULT nextval('types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: crm
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: active_admin_comments; Type: TABLE DATA; Schema: public; Owner: crm
--

COPY active_admin_comments (id, resource_id, resource_type, author_id, author_type, body, created_at, updated_at, namespace) FROM stdin;
\.


--
-- Data for Name: admin_users; Type: TABLE DATA; Schema: public; Owner: crm
--

COPY admin_users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at) FROM stdin;
1	admin@example.com	$2a$10$ovzTkWtfpFW4.AF92tsuXOyEzg5lKo8.5YE4aG3kDwGSe/NzUnczC	\N	\N	\N	0	\N	\N	\N	\N	2012-07-17 08:37:13.995234	2012-07-17 08:37:13.995234
\.


--
-- Data for Name: comptes; Type: TABLE DATA; Schema: public; Owner: crm
--

COPY comptes (id, societe, adresse1, adresse2, cp, ville, pays, origine, code_compta, notes, created_by, modified_by, created_at, updated_at, user_id, genre, tel, fax, email, web) FROM stdin;
\.


--
-- Data for Name: comptes_produits; Type: TABLE DATA; Schema: public; Owner: crm
--

COPY comptes_produits (compte_id, produit_id) FROM stdin;
\.


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: crm
--

COPY contacts (id, nom, prenom, civilite, tel, fax, mobile, email, fonction, notes, created_by, modified_by, created_at, updated_at, compte_id) FROM stdin;
\.


--
-- Data for Name: contacts_produits; Type: TABLE DATA; Schema: public; Owner: crm
--

COPY contacts_produits (contact_id, produit_id) FROM stdin;
\.


--
-- Data for Name: evenements; Type: TABLE DATA; Schema: public; Owner: crm
--

COPY evenements (id, debut, fin, notes, created_by, modified_by, created_at, updated_at, contact_id, compte_id, type_id, user_id, fichier_joint_file_name, fichier_joint_content_type, fichier_joint_file_size, fichier_joint_updated_at, tache_id) FROM stdin;
\.


--
-- Data for Name: ma_table; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ma_table (col1, coln) FROM stdin;
\.


--
-- Data for Name: opportunites; Type: TABLE DATA; Schema: public; Owner: crm
--

COPY opportunites (id, nom, description, statut, remarque, montant, echeance, fichier_joint_file_name, fichier_joint_content_type, fichier_joint_file_size, fichier_joint_updated_at, created_by, updated_by, created_at, updated_at, compte_id, contact_id, user_id, marge) FROM stdin;
\.


--
-- Data for Name: origines; Type: TABLE DATA; Schema: public; Owner: crm
--

COPY origines (id, nom, description, created_by, updated_by, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: produits; Type: TABLE DATA; Schema: public; Owner: crm
--

COPY produits (id, nom, description, created_by, updated_by, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: crm
--

COPY schema_migrations (version) FROM stdin;
20120218071616
20120218071940
20120218072017
20120218072036
20120218072103
20120218075659
20120227190442
20120227200451
20120227200452
20120322213445
20120428160402
20120513053831
20120621143121
20120627122129
20120627151302
20120628092714
20120702153424
20120705093257
20120717084452
20120720134635
20120723124706
20120723151416
\.


--
-- Data for Name: taches; Type: TABLE DATA; Schema: public; Owner: crm
--

COPY taches (id, notes, statut, created_at, created_by, modified_at, modified_by, updated_at, contact_id, compte_id, user_id, echeance, fichier_joint_file_name, fichier_joint_content_type, fichier_joint_file_size, fichier_joint_updated_at) FROM stdin;
\.


--
-- Data for Name: types; Type: TABLE DATA; Schema: public; Owner: crm
--

COPY types (id, libelle, direction, created_by, modified_by, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: crm
--

COPY users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, prenom, nom, tel, mobile, created_at, updated_at) FROM stdin;
\.


--
-- Name: admin_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: crm; Tablespace: 
--

ALTER TABLE ONLY active_admin_comments
    ADD CONSTRAINT admin_notes_pkey PRIMARY KEY (id);


--
-- Name: admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: crm; Tablespace: 
--

ALTER TABLE ONLY admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: comptes_pkey; Type: CONSTRAINT; Schema: public; Owner: crm; Tablespace: 
--

ALTER TABLE ONLY comptes
    ADD CONSTRAINT comptes_pkey PRIMARY KEY (id);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: crm; Tablespace: 
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: evenements_pkey; Type: CONSTRAINT; Schema: public; Owner: crm; Tablespace: 
--

ALTER TABLE ONLY evenements
    ADD CONSTRAINT evenements_pkey PRIMARY KEY (id);


--
-- Name: opportunitees_pkey; Type: CONSTRAINT; Schema: public; Owner: crm; Tablespace: 
--

ALTER TABLE ONLY opportunites
    ADD CONSTRAINT opportunitees_pkey PRIMARY KEY (id);


--
-- Name: origines_pkey; Type: CONSTRAINT; Schema: public; Owner: crm; Tablespace: 
--

ALTER TABLE ONLY origines
    ADD CONSTRAINT origines_pkey PRIMARY KEY (id);


--
-- Name: produits_pkey; Type: CONSTRAINT; Schema: public; Owner: crm; Tablespace: 
--

ALTER TABLE ONLY produits
    ADD CONSTRAINT produits_pkey PRIMARY KEY (id);


--
-- Name: taches_pkey; Type: CONSTRAINT; Schema: public; Owner: crm; Tablespace: 
--

ALTER TABLE ONLY taches
    ADD CONSTRAINT taches_pkey PRIMARY KEY (id);


--
-- Name: types_pkey; Type: CONSTRAINT; Schema: public; Owner: crm; Tablespace: 
--

ALTER TABLE ONLY types
    ADD CONSTRAINT types_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: crm; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_active_admin_comments_on_author_type_and_author_id; Type: INDEX; Schema: public; Owner: crm; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_author_type_and_author_id ON active_admin_comments USING btree (author_type, author_id);


--
-- Name: index_active_admin_comments_on_namespace; Type: INDEX; Schema: public; Owner: crm; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_namespace ON active_admin_comments USING btree (namespace);


--
-- Name: index_admin_notes_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: crm; Tablespace: 
--

CREATE INDEX index_admin_notes_on_resource_type_and_resource_id ON active_admin_comments USING btree (resource_type, resource_id);


--
-- Name: index_admin_users_on_email; Type: INDEX; Schema: public; Owner: crm; Tablespace: 
--

CREATE UNIQUE INDEX index_admin_users_on_email ON admin_users USING btree (email);


--
-- Name: index_admin_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: crm; Tablespace: 
--

CREATE UNIQUE INDEX index_admin_users_on_reset_password_token ON admin_users USING btree (reset_password_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: crm; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: crm; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: crm; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


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

\connect crm_production

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: active_admin_comments; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE active_admin_comments (
    id integer NOT NULL,
    resource_id integer NOT NULL,
    resource_type character varying(255) NOT NULL,
    author_id integer,
    author_type character varying(255),
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    namespace character varying(255)
);


ALTER TABLE public.active_admin_comments OWNER TO postgres;

--
-- Name: admin_notes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE admin_notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.admin_notes_id_seq OWNER TO postgres;

--
-- Name: admin_notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE admin_notes_id_seq OWNED BY active_admin_comments.id;


--
-- Name: admin_notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('admin_notes_id_seq', 1, false);


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE admin_users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.admin_users OWNER TO postgres;

--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE admin_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.admin_users_id_seq OWNER TO postgres;

--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE admin_users_id_seq OWNED BY admin_users.id;


--
-- Name: admin_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('admin_users_id_seq', 1, true);


--
-- Name: comptes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE comptes (
    id integer NOT NULL,
    societe character varying(255),
    adresse1 character varying(255),
    adresse2 character varying(255),
    cp character varying(255),
    ville character varying(255),
    pays character varying(255),
    code_compta character varying(255),
    notes text,
    created_by character varying(255),
    modified_by character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer,
    genre character varying(255),
    tel character varying(255),
    fax character varying(255),
    email character varying(255),
    web character varying(255),
    origine_id integer
);


ALTER TABLE public.comptes OWNER TO postgres;

--
-- Name: comptes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE comptes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.comptes_id_seq OWNER TO postgres;

--
-- Name: comptes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE comptes_id_seq OWNED BY comptes.id;


--
-- Name: comptes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('comptes_id_seq', 367, true);


--
-- Name: comptes_produits; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE comptes_produits (
    compte_id integer,
    produit_id integer
);


ALTER TABLE public.comptes_produits OWNER TO postgres;

--
-- Name: contacts; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE contacts (
    id integer NOT NULL,
    nom character varying(255),
    prenom character varying(255),
    civilite character varying(255),
    tel character varying(255),
    fax character varying(255),
    mobile character varying(255),
    email character varying(255),
    fonction character varying(255),
    notes text,
    created_by character varying(255),
    modified_by character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    compte_id integer
);


ALTER TABLE public.contacts OWNER TO postgres;

--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.contacts_id_seq OWNER TO postgres;

--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE contacts_id_seq OWNED BY contacts.id;


--
-- Name: contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('contacts_id_seq', 431, true);


--
-- Name: contacts_produits; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE contacts_produits (
    contact_id integer,
    produit_id integer
);


ALTER TABLE public.contacts_produits OWNER TO postgres;

--
-- Name: evenements; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE evenements (
    id integer NOT NULL,
    debut timestamp without time zone,
    fin timestamp without time zone,
    notes text,
    created_by character varying(255),
    modified_by character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    contact_id integer,
    compte_id integer,
    type_id integer,
    user_id integer,
    fichier_joint_file_name character varying(255),
    fichier_joint_content_type character varying(255),
    fichier_joint_file_size integer,
    fichier_joint_updated_at timestamp without time zone,
    tache_id integer
);


ALTER TABLE public.evenements OWNER TO postgres;

--
-- Name: evenements_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE evenements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.evenements_id_seq OWNER TO postgres;

--
-- Name: evenements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE evenements_id_seq OWNED BY evenements.id;


--
-- Name: evenements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('evenements_id_seq', 654, true);


--
-- Name: opportunites; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE opportunites (
    id integer NOT NULL,
    nom character varying(255),
    description text,
    statut character varying(255),
    remarque character varying(255),
    montant double precision,
    echeance timestamp without time zone,
    fichier_joint_file_name character varying(255),
    fichier_joint_content_type character varying(255),
    fichier_joint_file_size integer,
    fichier_joint_updated_at timestamp without time zone,
    created_by character varying(255),
    updated_by character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    compte_id integer,
    contact_id integer,
    user_id integer,
    marge double precision
);


ALTER TABLE public.opportunites OWNER TO postgres;

--
-- Name: opportunitees_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE opportunitees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.opportunitees_id_seq OWNER TO postgres;

--
-- Name: opportunitees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE opportunitees_id_seq OWNED BY opportunites.id;


--
-- Name: opportunitees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('opportunitees_id_seq', 5, true);


--
-- Name: origines; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE origines (
    id integer NOT NULL,
    nom character varying(255),
    description text,
    created_by character varying(255),
    updated_by character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.origines OWNER TO postgres;

--
-- Name: origines_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE origines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.origines_id_seq OWNER TO postgres;

--
-- Name: origines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE origines_id_seq OWNED BY origines.id;


--
-- Name: origines_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('origines_id_seq', 2, true);


--
-- Name: produits; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE produits (
    id integer NOT NULL,
    nom character varying(255),
    description text,
    created_by character varying(255),
    updated_by character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.produits OWNER TO postgres;

--
-- Name: produits_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE produits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.produits_id_seq OWNER TO postgres;

--
-- Name: produits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE produits_id_seq OWNED BY produits.id;


--
-- Name: produits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('produits_id_seq', 8, true);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: taches; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE taches (
    id integer NOT NULL,
    notes text,
    statut character varying(255),
    created_at timestamp without time zone NOT NULL,
    created_by character varying(255),
    modified_at timestamp without time zone,
    modified_by character varying(255),
    updated_at timestamp without time zone NOT NULL,
    contact_id integer,
    compte_id integer,
    user_id integer,
    echeance character varying(255),
    fichier_joint_file_name character varying(255),
    fichier_joint_content_type character varying(255),
    fichier_joint_file_size integer,
    fichier_joint_updated_at timestamp without time zone
);


ALTER TABLE public.taches OWNER TO postgres;

--
-- Name: taches_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE taches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.taches_id_seq OWNER TO postgres;

--
-- Name: taches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE taches_id_seq OWNED BY taches.id;


--
-- Name: taches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('taches_id_seq', 19, true);


--
-- Name: types; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE types (
    id integer NOT NULL,
    libelle character varying(255),
    direction character varying(255),
    created_by character varying(255),
    modified_by character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.types OWNER TO postgres;

--
-- Name: types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.types_id_seq OWNER TO postgres;

--
-- Name: types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE types_id_seq OWNED BY types.id;


--
-- Name: types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('types_id_seq', 16, true);


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    prenom character varying(255),
    nom character varying(255),
    tel character varying(255),
    mobile character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 7, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY active_admin_comments ALTER COLUMN id SET DEFAULT nextval('admin_notes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY admin_users ALTER COLUMN id SET DEFAULT nextval('admin_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comptes ALTER COLUMN id SET DEFAULT nextval('comptes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY evenements ALTER COLUMN id SET DEFAULT nextval('evenements_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY opportunites ALTER COLUMN id SET DEFAULT nextval('opportunitees_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY origines ALTER COLUMN id SET DEFAULT nextval('origines_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY produits ALTER COLUMN id SET DEFAULT nextval('produits_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY taches ALTER COLUMN id SET DEFAULT nextval('taches_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY types ALTER COLUMN id SET DEFAULT nextval('types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: active_admin_comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY active_admin_comments (id, resource_id, resource_type, author_id, author_type, body, created_at, updated_at, namespace) FROM stdin;
\.


--
-- Data for Name: admin_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY admin_users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at) FROM stdin;
1	admin@example.com	$2a$10$VmbCjuQCOgNf3mtfdASl1.YJE5KcoMmzkyccMaVlfQvB3MVmeua26	\N	\N	\N	6	2012-07-24 15:11:45.627967	2012-07-24 12:52:09.996977	46.226.131.55	46.226.131.55	2012-04-15 09:46:06.307606	2012-07-24 15:11:45.62939
\.


--
-- Data for Name: comptes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY comptes (id, societe, adresse1, adresse2, cp, ville, pays, code_compta, notes, created_by, modified_by, created_at, updated_at, user_id, genre, tel, fax, email, web, origine_id) FROM stdin;
3	LABOSPORT	Technoparc du Circuit des 24 Heures	Chemin aux boeufs	72100	LE MANS	FRANCE			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-15 19:03:44.645302	2012-04-15 19:03:44.645302	1	Client	02 43 47 08 40	02 43 47 08 28	contact@labosport.com	http://www.labosport.com	\N
4	MAIRIE D'YVRE LE POLIN	Place de l'Eglise		72330	YVRE LE POLIN	FRANCE			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-15 19:09:23.913036	2012-04-15 19:09:23.913036	1	Client	02 43 87 42 48		communeyvrelepolin@wanadoo.fr		\N
6	COMMUNAUTE DE COMMUNES DU VAL DE SARTHE	27, rue du 11 Novembre	BP 26	72210	LA SUZE SUR SARTHE	FRANCE			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-15 19:31:15.43041	2012-04-15 19:31:15.43041	2	Client	02 43 83 51 12	02 43 83 51 13	communaute@cc-valdesarthe.fr		\N
21	ALBEA	Route de Sillé le Guillaume		72350	BRULON	FRANCE			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-17 13:01:52.291439	2012-04-17 13:01:52.291439	1	Client	02 43 95 21 33	02 43 95 29 36			\N
30	ALPA MANUTENTION	55, avenue Pierre Piffault 	ZI Sud	72100	LE MANS	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 08:57:03.449752	2012-04-18 08:57:03.449752	2	Prospect	02 43 75 67 00	02 43 75 78 75	alpa.manutention@alpamanutention.fr	http://www.alpa-manutention.fr/	\N
7	IMPRIMERIE KAYSER	Rue Frères Lemée	BP 6	53150	MONTSURS	FRANCE	41031102		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-16 08:06:56.4971	2012-04-16 08:06:56.4971	1	Client	02 43 01 01 26	02 43 01 04 20			\N
8	ZOO DE LA FLECHE	Le Tertre Rouge		72200	LA FLECHE	FRANCE			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-16 08:38:45.939705	2012-04-16 08:38:45.939705	1	Client	02 43 48 19 19				\N
10	LE MANS ENDURANCE MANAGEMENT	Circuit des 24 Heures		72019	LE MANS CEDEX 2	FRANCE			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-16 13:10:18.281602	2012-04-16 13:10:18.281602	1	Client					\N
11	AGRIMARQUES	1494, route de Croix de May		38160	SAINT SAUVEUR	FRANCE		Client lié à COSNET INDUSTRIES.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-16 13:14:41.855309	2012-04-16 13:16:26.952712	1	Client			admin@agrimarques.com		\N
12	APPLE STORE	Hollyhill Industrial Estate	Hollyhill		CORK	IRELAND			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-16 13:28:02.166696	2012-04-16 13:33:25.222048	1	Fournisseur				http://www.apple.fr	\N
13	SABLESIENNE	1 avenue Jean Monnet		72300	SABLE-SUR-SARTHE	FRANCE			m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-16 14:15:31.10323	2012-04-16 14:15:31.10323	1	Client	02 43 95 04 53	02 43 92 27 55 	contact@sablesienne.com	http://www.sablesienne.com/	\N
1	GESLIN SAS	Rue Edmé Bouchardon		72100	LE MANS	FRANCE			g.forestier@sigire.fr	Manuel OZAN	2012-04-15 14:04:04.258369	2012-07-20 14:50:34.379921	1	Client	02 43 75 02 61				\N
22	SERAC	12, route de Mamers		72400	LA FERTE BERNARD	FRANCE		Prospect SARTEL	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-17 14:12:35.404609	2012-04-17 14:12:35.404609	1	Prospect					\N
23	SESAM VITALE	5, boulevard Marie et Alexandre Oyon		72019	LE MANS CEDEX 2	FRANCE			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-17 15:24:51.686443	2012-04-17 15:24:51.686443	2	Client					\N
31	ALPHI	ZI de L'industrie		72320	VIBRAYE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 09:02:06.060793	2012-04-18 09:02:06.060793	2	Prospect	02 43 60 77 58				\N
14	INSTITUT ANDRE BEULE	1 bis, rue Mauté-Lelasseux		28400	NOGENT LE ROTROU	FRANCE	41030245		n.retout@sigire.fr	n.retout@sigire.fr	2012-04-16 15:16:59.091615	2012-04-16 16:25:26.48918	2	Client	02 37 53 52 76			http://www.andrebeule.com	\N
16	LACIE	17, rue Ampère		91349	MASSY CEDEX	FRANCE		Paiement à 30 jours - Encours : 2.000 EUR	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-17 07:57:13.757137	2012-04-17 07:57:13.757137	1	Fournisseur	01 69 32 83 90	01 69 32 07 60	sales.fr@lacie.com	http://www.lacie.fr	\N
18	FUTUR TELECOM	10, place de la Joliette - Les Docks	BP 35214	13567	MARSEILLE CEDEX 2	FRANCE		Les commandes passent par IPOP TELECOM.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-17 08:40:43.654514	2012-04-17 08:40:43.654514	1	Fournisseur	08 05 80 18 11	04 96 17 10 11		http://www.futurtelecom.com	\N
19	NICOLAY LANOUVELLE HANNOTIN	11, rue de Phalsbourg		75017	PARIS	FRANCE		A souscrit un contrat de maintenance	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-17 08:48:35.096779	2012-04-17 08:48:35.096779	1	Client	01 46 22 28 20		courrier@scpnlh.com		\N
20	FUNKWERK ENTERPRISE COMMUNICATIONS	6, allée de la Grande Lande	CS 20102	33173	GRADIGNAN CEDEX	FRANCE		Produits BINTEC et ELMEG. Grossiste : CRIS RESEAUX	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-17 12:11:22.144645	2012-04-17 12:11:22.144645	1	Fournisseur	05 57 35 63 00	05 56 89 14 05		http://www.funkwerk-ec.com	\N
28	I-CONE	25, rue des Marais		72000	LE MANS	FRANCE			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 08:41:12.910515	2012-04-18 08:41:12.910515	2	Client	02 43 84 50 00	02 43 61 55 05		http://www.i-cone.fr	\N
5	MOULINS REUNIS DE LA SARTHE	La Lande	Route de Paris	72470	CHAMPAGNE	FRANCE		Magasin : 02 43 89 51 68	g.forestier@sigire.fr	m.ozan@sigire.fr	2012-04-15 19:15:05.863015	2012-04-30 13:07:29.272049	1	Client	02 43 54 00 50	02 43 54 00 59			\N
29	ABREVIATIONS	Rue Edgar Brandt	ZA Monthéard	72000	LE MANS	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 08:49:15.289254	2012-04-18 08:49:15.289254	2	Prospect	08 99 96 58 09	32 43 86 21 47			\N
2	ADEKMA LEVAGE	68, Avenue Pierre Piffault	Zone industrielle Sud	72100	LE MANS	FRANCE			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-15 17:52:09.917417	2012-04-18 08:52:18.407669	1	Client	02 43 75 94 58	02 43 75 97 43	adekmalevage@wanadoo.fr	http://levage-transport-speciaux.adekma.fr/	\N
33	ALTA BATIMENT	67 rue Albert Einstein		7200	LE MANS	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 09:09:59.617629	2012-04-18 09:09:59.617629	2	Prospect	02 43 87 60 87	02 43 87 08 93			\N
34	BOULOIRE AMBULANCE	45,rue du Jeu de Paume		72440	BOULOIRE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 09:14:29.508569	2012-04-18 09:14:29.508569	2	Prospect	02 43 35 48 82				\N
32	CBL	79 route du Chêne		72230	ARNAGE	FRANCE		Certificat/Licence SYMANTEC : 10606645 / 38198712\r\n	s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 09:06:31.77859	2012-04-19 08:41:08.0787	2	Client	02 43 84 77 88	02 43 84 79 61			\N
27	ABC VENDOME PARE BRISE	192, Faubourg Chartrain		41100	VENDOME	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 08:39:20.658236	2012-04-26 08:38:16.023105	1	Prospect	09 64 11 38 14	02 54 73 28 54			\N
26	IMS BACKUP	70, boulevard Alexandre Oyon		72100	LE MANS	FRANCE		Solutions de sauvegarde en ligne et d'externalisation\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 08:37:14.197692	2012-04-24 18:33:39.1199	1	Fournisseur	08 25 82 80 80	02 43 85 55 97	support@imsbackup.com	http://www.imsbackup.com	\N
17	HABRIAL MANUTENTION	Boulevard Ravalières		72560	CHANGE				n.retout@sigire.fr	Manuel OZAN	2012-04-17 08:08:36.183475	2012-07-19 13:58:37.823758	1	Client	02 43 40 19 00	02 43 40 19 50		http://www.habrial.fr	\N
24	2IE			72190	SARGE LES LE MANS	FRANCE			s.martin@sigire.fr	Guillaume BONVOUST	2012-04-18 08:25:19.99398	2012-07-24 09:34:45.80776	1	Prospect	02 43 76 50 50	02 43 76 50 60	info@2ie.com	http://www.2ie.com	2
35	ESNAULT FROGER	69 rue Michel Beaufils		72160	CONNERRE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 09:18:43.997138	2012-04-18 09:18:43.997138	2	Prospect	02 43 89 01 07			http://www.taxis-esnault-froger-ambulances.fr	\N
36	LE MANS HOTEL RESERVATION	70, boulevard Alexandre Oyon		72100	LE MANS	FRANCE		Serveur externalisé chez IMS BACKUP. Connaît personnellement le gérant d'IMS BACKUP.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 09:19:35.910923	2012-04-18 09:19:35.910923	1	Client	02 43 20 07 00	02 43 20 07 70		http://www.lemansreservation.com	\N
37	AMCI	53,rue Saint André de Gelly		72110	BONNETABLE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 09:23:02.480951	2012-04-18 09:23:02.480951	2	Prospect	02 43 29 03 51	02 43 29 03 52			\N
40	MAIRIE DE VIBRAYE	Place de l'Hôtele de Ville		72320	VIBRAYE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 09:35:05.526533	2012-04-18 09:35:05.526533	2	Prospect	02 43 93 60 27	02 43 71 89 68 			\N
41	AUTO CASSE	8, allée de la Coudre	ZA Les Ravalières	72560	CHANGE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 09:40:37.365219	2012-04-18 09:40:37.365219	2	Prospect		 02 43 40 19 13			\N
42	AUTO ECOLE ALLAIRE	23, rue Michel Beaufils		72160	CONNERRE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 09:43:47.819727	2012-04-18 09:43:47.819727	2	Prospect	02 43 89 40 93 				\N
43	AUTO ECOLE BESOMBES	15 bis, rue de la Jatterie		72160	CONNERRE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 09:46:54.376334	2012-04-18 09:46:54.376334	2	Prospect	02 43 89 01 68				\N
44	AXICLIM	ZAC du Cormier		72230	MULSANNE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 09:52:06.859699	2012-04-18 09:52:06.859699	2	Prospect	02 43 21 33 63	02 43 21 33 36	contact@axiclim.fr	http://www.axiclim.fr/	\N
48	CARRIER KHEOPS BAC	ZAC Le Monné	Rue du Champ du Verger - CS 30009	72705	ALLONNES CEDEX	FRANCE			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 10:04:48.722205	2012-04-18 10:04:48.722205	2	Client	02 43 61 45 45	02 43 61 45 00	ckb@deutsch.net	http://www.deutsch.net	\N
47	BETAIL GORRONNAIS SAS	Les Pilletieres 	route des Mollans	72200	LA FLECHE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 10:04:21.270128	2012-04-18 10:06:22.357793	2	Prospect	08 99 23 64 00				\N
50	SARTEL	2, allée des Gémeaux		72000	LE MANS	FRANCE			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 10:08:39.549248	2012-04-18 10:12:23.880793	1	Fournisseur	08 10 72 00 72				\N
46	BELLESORT ETS	Rabours		72610	CHERISAY	FRANCE			s.martin@sigire.fr	g.forestier@sigire.fr	2012-04-18 09:59:06.901302	2012-04-29 16:44:38.332579	2	Prospect					\N
53	OPCOM	15, rue Danielle Casanova		75011	PARIS	FRANCE			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 10:19:21.420814	2012-04-18 10:19:21.420814	1	Fournisseur	01 70 61 90 50	01 55 04 93 95	voip@opcom.fr	http://www.opcom.fr	\N
54	CANIROUTE	BEAUREPAIRE		72650	SAINT SATURNIN 	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 12:08:12.219242	2012-04-18 12:08:12.219242	2	Prospect	02 43 25 92 53				\N
55	CC SPORT	188 rue Nationale		72000	LE MANS	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 12:18:20.05029	2012-04-18 12:18:20.05029	2	Prospect	02 43 72 74 28 	02 43 75 65 81			\N
56	CABINET OLIVIER CELLE	2, rue Gladiateurs		72000	LE MANS	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 12:22:53.456528	2012-04-18 12:22:53.456528	2	Prospect	02 43 39 96 66	02 43 39 96 69	cabinet.celle@orange.fr		\N
59	CHAPLAIN PHLIPPE	Le Puits aux Passés		72190	Neuville sur Sarthe	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 12:31:12.318492	2012-04-18 12:31:57.526668	2	Prospect	02 43 25 55 97	02 43 25 55 97		http://www.chaplainterrassement.fr	\N
58	CHAPLAIN	4, rue de Bretagne		72190	SAINT PAVACE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 12:28:17.628499	2012-04-18 12:40:17.528873	2	Prospect	02 43 76 05 57				\N
61	DAM	Impasse André Fertre		72100	LE MANS	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 12:48:02.434581	2012-04-18 12:48:02.434581	2	Prospect	02 43 85 66 99	02 43 86 84 41	dam72@wanadoo.fr	http://www.dam72.fr	\N
62	DEPANNE ELEC	15, rue de la Forge		72340	TASSE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 12:51:48.466269	2012-04-18 12:52:08.174862	2	Prospect	02 43 55 17 80				\N
63	DISTRI PAREBRISE	275, avenue Félix Geneslay		72100	LE MANS	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 12:55:57.346365	2012-04-18 12:55:57.346365	2	Prospect	02 43 85 60 00	02 43 85 88 11 			\N
64	ETS DULUARD	14 rue des Vertolines		72500	CHTEAU DU LOIR	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 12:57:02.683546	2012-04-18 13:02:45.250091	2	Prospect	02 43 44 01 60				\N
49	BEUCHER SA	2, avenue Olivier Heuzé		72000	LE MANS				s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 10:05:51.070997	2012-04-18 13:03:15.476315	2	Prospect	02 43 87 01 58	02 43 87 01 11			\N
65	DUPONT THIERRY	Centre Commerciale des Rochères		72230	MULSANNE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 13:08:19.182359	2012-04-18 13:08:58.777416	2	Prospect	02 43 42 84 99				\N
68	EURO PAREBRISE	121, rue André Dessaux		45400	FLEURY LES AUBRAIS	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 13:19:55.7273	2012-04-18 13:19:55.7273	2	Prospect	02 38 56 11 63 	02 38 56 61 72	europarebrise45@wanadoo.fr	http://www.europarebrise45.com	\N
69	EUROVIA BASSE NORMANDIE	Route Nationale 12		61250	HAUTERIVE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 13:25:34.783173	2012-04-18 13:25:34.783173	2	Prospect	02 33 27 10 67			www.eurovia.com	\N
70	FAURE HERMAN	Route de Bonnetable		72400	LA FERTE BERNARD	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 13:30:33.769089	2012-04-18 13:30:33.769089	2	Prospect	02 43 60 28 60	02 43 60 28 70			\N
67	TONY ESNAULT SARL	39 rue Bara		72230	LE MANS	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 13:15:13.604975	2012-04-18 14:31:51.828797	2	Prospect					\N
51	BLANCHARD SA	ZA du Perquoi		72560	CHANGE				s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 10:13:29.758724	2012-04-18 16:54:20.543077	1	Prospect	04 75 30 55 55	04 75 30 50 00	contact@blanchard.fr 	http://www.blanchard.fr/	\N
45	BEAUPOUX CHARPENTE	ZAC Cormier		72230	MULSANNE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 09:56:00.949457	2012-04-23 08:30:02.573458	1	Client	02 43 85 67 37				\N
38	ARTISANS REUNIS	2, Avenue HAOUZA		72100	LE MANS	FRANCE			s.martin@sigire.fr	m.ozan@sigire.fr	2012-04-18 09:27:03.760841	2012-04-30 15:32:50.463895	2	Client	02 43 28 20 03	02 43 24 31 71	artisansreunis@oceanet.pro	http://www.artisans-reunis-mo.fr	\N
60	HBR CONCEPT	110 avenue Olivier Heuzé		72000	LE MANS	FRANCE			s.martin@sigire.fr	m.ozan@sigire.fr	2012-04-18 12:43:25.181963	2012-05-11 08:15:35.384884	2	Client	02 43 23 96 09	02 43 24 68 36		http://www.creacuisinesetbains.fr	\N
39	ASSOCIATION L'HORIZON	143, route de Coulaines		72190	SARGE LES LE MANS	FRANCE			s.martin@sigire.fr	i.moison@sigire.fr	2012-04-18 09:30:01.221426	2012-05-16 15:23:41.964333	2	Prospect	02 43 76 93 80				\N
72	FJ CONCORDE	43, avenue du Général de Gaulle		72000	LE MANS	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 13:36:59.654467	2012-04-18 13:36:59.654467	2	Prospect	02 43 23 69 00	02 43 23 69 33			\N
73	FLEURY DANIEL	7, rue du Lac		72100	LE MANS	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 13:41:54.336385	2012-04-18 13:41:54.336385	2	Prospect					\N
74	FOUQUET SARL	35 rue des Bleuets		72160	LA CHAPELLE SAINT REMY	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 13:46:11.36276	2012-04-18 13:46:11.36276	2	Prospect	02 43 93 46 17	02 43 71 36 22	sarlfouquet@wanadoo.fr	www.fouquetsarl.com	\N
75	GENERALE SARTHOISE DE PEINTURE	21 ROUTE  LE MANS		72530	YVRE L'EVEQUE				s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 14:03:37.840755	2012-04-18 14:03:37.840755	2	Prospect	02 43 84 00 43				\N
76	CABINET LAURENT GODRET	4 cour Etienne Jules Marey		72000	LE MANS	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 14:17:33.643608	2012-04-18 14:17:33.643608	2	Prospect	08 99 02 96 31	02 99 02 18 58			\N
77	GRIGNON SARL	48 rue de la Mission 		72000	LE MANS	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 14:22:40.53266	2012-04-18 14:22:40.53266	2	Prospect					\N
78	GROUAS SARL	le lézard		72170	BEAUMONT SUR SARTHE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 14:25:02.718575	2012-04-18 14:25:02.718575	2	Prospect		02 43 97 06 94			\N
79	GSMS	17, impasse Saint Jean		72650	AIGNE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 14:31:00.071704	2012-04-18 14:31:00.071704	2	Prospect	06 16 35 33 58	02 43 27 48 16			\N
71	FJ CONCORDE	43, avenue du Général de Gaulle		72000	LE MANS				s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 13:33:25.11901	2012-04-18 14:31:27.579496	2	Prospect					\N
80	GUZMAN	76, boulevard Jean Yves Chapalain		72100	LE MANS	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 14:38:42.612098	2012-04-18 14:38:42.612098	2	Prospect	02 43 85 10 61	02 43 85 36 60			\N
81	HPV	La Menardiere		37360	SONZAY	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 14:44:13.248198	2012-04-18 14:44:13.248198	2	Prospect					\N
82	HUREL AUTOMOBILES	avenue Falkenstein	ZA La Crouillère	61170	SAINT JULIEN SUR SARTHE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 14:51:37.108704	2012-04-18 14:51:37.108704	2	Prospect	02 33 31 92 00 				\N
84	INSTINCTIF	Gallerie comerciale	6 ZAC de la Moissonière	72230 	MONCE EN BELIN	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 15:06:58.971267	2012-04-18 15:14:08.719355	2	Prospect	02 43 39 30 79				\N
85	LTP SAS	Za rue de la Maison Neuve			SUZE SUR SATHE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 15:22:13.206009	2012-04-18 15:22:13.206009	2	Prospect	02 43 77 44 20	 02 43 77 49 22			\N
86	LECOMTE ALIAN	22, rue Fresnet		72160	TUFFE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 15:25:02.929459	2012-04-18 15:26:21.928881	2	Prospect	02 43 71 59 01 				\N
87	FEMME REVEE	207, rue des Maillets		72000	LE MANS	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 15:31:46.570457	2012-04-18 15:31:46.570457	2	Prospect	02 43 81 24 98				\N
88	MAISONS LELIEVRE	21, rue Mardelles		72390	LE LUART	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 15:36:19.238535	2012-04-18 15:36:19.238535	2	Prospect	02 43 93 45 19			http://www.maisons-lelievre.fr	\N
89	MARIS PAYSAE	Les Chatons		72550	PARIGNEL'EVEQUE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-18 15:42:06.312962	2012-04-18 15:42:06.312962	2	Prospect					\N
90	MATTALIA SARL	26, rue Voltaire		72000 	LE MANS	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 07:08:47.027781	2012-04-19 07:08:47.027781	2	Prospect	02 43 24 13 13	02 43 23 66 10		http://www.mattalia.fr	\N
91	MG ENTREPRISES	42, rue Wagram		72000	LE MANS	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 07:15:52.225726	2012-04-19 07:15:52.225726	2	Prospect	02 43 23 09 10	02 43 23 14 97 			\N
92	MGR LOISIRS	19 rue d' Antin		75002	PARIS	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 07:19:44.308098	2012-04-19 07:19:44.308098	2	Prospect	01 40 06 04 54				\N
93	NUANCE APRS	4, rue de Corse		72100 	LE MANS	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 07:26:14.330048	2012-04-19 07:26:14.330048	2	Prospect	02 43 84 72 57	02 43 75 07 93 			\N
94	O BON SOIR	12 place du Hallai 		72000 	LE MANS	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 07:36:05.399877	2012-04-19 07:36:05.399877	2	Prospect	02 43 77 13 95 				\N
95	OPTIQUE CASTIONI	Passage du Commerce		72000	LE MANS	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 07:39:52.278268	2012-04-19 07:39:52.278268	2	Prospect	02 43 24 59 38		contact@optiquerondeau.fr		\N
96	POID LOURD SERVICE	129, boulevard Pierre Lefaucheux							s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 07:46:39.933607	2012-04-19 07:46:39.933607	2	Prospect	02 43 21 11 29 	02 43 21 64 47		http://www.poidslourdsservice.fr	\N
97	PRUNIER SAS	25, rue de la Jatterie		72160	CONNERRE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 07:51:05.592953	2012-04-26 13:41:55.860185	1	Prospect	02 43 76 30 00 	02 43 76 30 29 		http://www.prunier.fr	\N
98	PAPIN ROGER	Le Perquoi		72560	CHANGE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 08:01:50.639749	2012-04-19 08:01:50.639749	2	Prospect	02 43 40 04 59 	02 43 40 15 54 			\N
99	ROISNE SAS	Les Landes 	Route Ruaudin	72100	LE MANS	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 08:07:29.50358	2012-04-19 08:07:29.50358	2	Prospect	02 43 84 21 50 				\N
100	CABINET ROUILLARD	41 bis, rue de Vienne		72190	COULAINES	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 08:15:45.247062	2012-04-19 08:15:45.247062	2	Prospect					\N
101	SAM	ZA le Perquoi		72560	CHAGE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 08:17:15.977855	2012-04-19 08:23:01.646759	2	Prospect	02 43 40 00 90	02 43 40 00 66 	sam-goupil@wanadoo.fr	http://www.sam-assainissement-sarthe.fr	\N
103	SACOFEL	Route Nationale 148	Les Hogues	72650 	LA BAZOGE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 08:33:51.026244	2012-04-19 08:39:31.427665	2	Prospect	02 43 51 26 26 	02 43 51 26 29 			\N
104	COSNET SAS	ZA La Cour du Bois		72550	COULANS SUR GEE	FRANCE			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-19 08:47:34.19107	2012-04-19 08:47:34.19107	1	Client	02 43 88 85 90	02 43 88 76 58		http://www.cosnet.fr	\N
105	SALGADO MANUEL SARL	Le Champ des Landes		72530	YVRE L'EVEQUE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 08:50:23.940508	2012-04-19 08:50:23.940508	2	Prospect					\N
106	SCEA DU DOMAINE	Domaine du Chesnay 		72110 	COURCEMONT				s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 08:58:53.085501	2012-04-19 08:58:53.085501	2	Prospect	02 43 20 37 98 				\N
107	SCETEC	15 rue Louis Breguet		72100	LE MANS	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 09:05:58.413281	2012-04-19 09:06:28.509138	2	Prospect	02 43 86 23 00	02 43 84 77 25 	scetec@scetec.fr  	htp://www.scetec.fr	\N
83	AHSS D'HYGIENE SOCIALE (IME)	92 rue Molière		72000 	LE MANS	FRANCE			s.martin@sigire.fr	g.forestier@sigire.fr	2012-04-18 15:06:21.517989	2012-04-29 16:47:51.997075	1	Prospect	02 43 50 32 40	02 43 50 32 40			\N
109	SIITEL OUEST	10 bis, allée de la Coudre		72560	CHANGE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 09:12:38.833298	2012-04-19 09:20:23.51847	2	Prospect	02 43 82 32 32 	02 43 82 98 23 		http://www.siitel-ouest.fr	\N
110	SOPAME SAS	Le bois de Milesse		72650	MILESSE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 09:30:31.612065	2012-04-19 09:30:31.612065	2	Prospect					\N
111	SOVEMI	route des Bois	Les Bois	72230\t  	MONCE EN BELIN				s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 09:38:31.859668	2012-04-19 09:38:46.279849	2	Prospect					\N
112	SOVOPA	Le pré du doué		72650	AIGNE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 09:41:20.319802	2012-04-19 09:41:20.319802	2	Prospect					\N
113	SPI SAS								s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 09:42:15.340011	2012-04-19 09:42:15.340011	2	Suspect					\N
114	STPL	ZA de la Forêt		72470	CHAMPAGNE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 09:50:52.306998	2012-04-19 09:51:38.847632	2	Prospect	02 43 89 56 49 	02 43 89 60 74			\N
115	TJM SARL	route des Aulnays		72700	SPAY	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 09:58:08.747477	2012-04-19 09:58:08.747477	2	Prospect	02 43 21 69 00 	02 43 21 36 83			\N
117	TRANSPORTS BRULON 	ZA Le Petit Raidit		72220 	TELOCHE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 12:21:47.641434	2012-04-19 12:27:44.698531	2	Prospect	02 43 42 06 50  	02 43 42 24 51	transports.brulon@nerim.net  		\N
118	TRANSPORTS COMBES	Le Liard		72250	PARIGNE L'EVEQUE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 12:27:04.450545	2012-04-19 12:29:42.629296	2	Prospect	02 43 75 28 91				\N
119	TRANSPORTS FRONTEAU	Beauchêne	72190	SARGE LES LE MANS	SARGE LES LE MANS	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 12:35:01.739713	2012-04-19 12:35:01.739713	2	Prospect	02 43 76 55 49	02 43 76 54 99			\N
120	TRANSPORTS HEITZ	L'Orchidée		72470	SAINT MARS LA BIERE	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 12:51:14.182446	2012-04-19 12:51:14.182446	2	Prospect	02 43 89 03 86	02 43 89 14 66			\N
121	TRANSPORT MOMMESSIN	Les Teillais		72700	ALLONNES				s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 12:54:31.590928	2012-04-19 12:54:31.590928	2	Prospect	02 43 80 41 02				\N
122	VITRAIL FRANCE	17, rue de Tascher		72000	LE MANS	FRANCE			s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 13:06:19.412322	2012-04-19 13:06:19.412322	2	Prospect	02 43 81 18 60	02 43 82 15 58	vitrailfrance@vitrailfrance.com	http://http://www.vitrailfrance.com/	\N
123	DATAGREX	Espace Villeneuve B11	28, rue de Villeneuve	72650	SAINT SATURNIN	FRANCE			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-23 09:34:44.240314	2012-04-23 09:34:44.240314	1	Fournisseur				http://www.datagrex.com	\N
124	DRI	Le Grand Courgoult		72140	ROUEZ EN CHAMPAGNE	FRANCE		support@dri.fr	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-23 14:09:22.585515	2012-04-23 15:01:57.016474	6	Fournisseur	02 90 92 05 50	02 43 29 61 68	contact@dri.fr	http://www.dri.fr	\N
15	CIS SIPOD	ZA Le Sablon		72230	MULSANNE	FRANCE		Entreprise liée à ITF\r\nN° Client chez Alitude Télécom : B5015	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-16 15:51:58.809193	2012-04-24 08:00:52.632394	1	Client	02 43 28 64 55	02 43 28 67 97	cis-sipod@cis-sipod.fr		\N
128	ANTI-GERM	ZI Le Roineau		72500	VAAS	FRANCE		Client FUTUR TELECOM. Parc >100 lignes à migrer.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-25 08:31:39.632818	2012-04-25 08:31:39.632818	1	Client	02 43 46 71 22	02 43 46 70 05		http://www.penngar.fr	\N
129	MEDISPORT			72230	RUAUDIN	FRANCE			m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-25 08:53:54.786288	2012-04-25 08:58:39.5318	4	Client	02 43 84 77 17	02 43 72 39 15		http://www.medisport.fr/	\N
130	JURI OUEST	39, boulevard Demorieux		72000	LE MANS	FRANCE			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 06:48:47.439362	2012-04-26 06:48:47.439362	1	Client	02 44 02 90 00	02 44 02 90 19			\N
131	LA GIRARDERIE EARL	La Girarderie		72110	SAINT AIGNAN	FRANCE		Client FUTUR TELECOM	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 07:52:40.439327	2012-04-26 07:52:40.439327	1	Client	02 43 97 46 94		earl-girarderie@orange.fr		\N
132	CRIS-RESEAUX	3, Rue Jules Verne		44405	REZE 	FRANCE			m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-26 08:31:45.180501	2012-04-26 08:31:45.180501	4	Fournisseur	02 40 32 16 90	02 40 32 16 91	ouest@cris-reseaux.com	http://www.cris-reseaux.com/	\N
133	SFR BUSINESS TEAM							Autre numéro : 907	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 13:34:52.406766	2012-04-26 13:34:52.406766	1	Fournisseur	08 11 90 79 07				\N
134	SETIPP	176, avenue MAginot		37100	TOURS	FRANCE		Partenaire SFR Business Team	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 13:47:25.689412	2012-04-26 13:47:25.689412	1	Fournisseur	02 47 41 40 39	02 47 42 56 87			\N
135	TARMAC	143, route de Coulaines		72190	SARGE LES LE MANS	FRANCE			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 14:44:16.501414	2012-04-26 14:44:16.501414	1	Prospect	02 43 76 93 81				\N
136	AUTOMOBILE CLUB DE L'OUEST	Circuit des 24 Heures		72019	LE MANS CEDEX 2	FRANCE	41030141		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-27 07:33:25.307181	2012-04-27 07:33:25.307181	1	Client	02 43 40 24 24	02 43 40 86 99 67		http://www.lemans.org	\N
138	EKLO-DESIGN								m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-27 09:42:06.438482	2012-04-27 09:44:32.284701	4	Client	02 48 24 08 46				\N
139	ARIANE	82-86, rue de la Pelouse		72000	LE MANS	FRANCE			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-27 09:46:47.395478	2012-04-27 09:49:05.879981	1	Client	02 43 23 78 28	02 43 43 81 95			\N
140	ALTITUDE-TELECOM								m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-27 15:21:19.737135	2012-04-27 15:21:36.185698	4	Autre	08 05 76 07 60				\N
141	PREFEO								m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-30 08:11:03.236108	2012-04-30 08:11:03.236108	4	Client					\N
142	SUPPLEX								m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-30 08:31:26.028189	2012-04-30 08:34:06.043362	4	Client	02 43 92 80 00				\N
144	COSNET TERRASSEMENT								m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-30 09:27:58.925008	2012-04-30 09:27:58.925008	4	Suspect	02 43 27 73 66				\N
145	COJEF								m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-30 12:03:56.026794	2012-04-30 12:04:45.170516	4	Client	02 47 61 06 60				\N
146	MOULIN DE LIGNE	400 impasse du moulin		60230	CHAMBLY				m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-30 12:50:05.646735	2012-04-30 12:50:05.646735	4	Client	01 30 28 91 91				\N
147	GALVA 72	ZA la Paty 		72550	COULANS SUR GEE	FRANCE			n.retout@sigire.fr	n.retout@sigire.fr	2012-05-02 08:40:43.473872	2012-05-02 08:40:43.473872	3	Client	0243391111				\N
125	AVNET	1 place Victor HUGO		92400	COURBEVOIE	FRANCE		Revendeur exclusif VEEAM. adv@avnet.com.	m.ozan@sigire.fr	g.forestier@sigire.fr	2012-04-24 14:34:06.491366	2012-06-21 16:17:38.842941	4	Fournisseur	01 41 91 55 55			http://www.ts.avnet.com/fr/	\N
143	SEGECA	5 Rue de Belle Ile 		72190	COULAINES	FRANCE			m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-30 09:15:45.149078	2012-06-11 12:21:01.157036	4	Client	02 43 39 12 39			http://www.segeca.com/	\N
148	PONTHOU POIDS LOURDS	6, rue Antoine Becquerel	ZIS B.11	72026	LE MANS CEDEX	FRANCE	41031646	Routeur Alençon : CISCO RVS4000 / 85.14.139.17	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-02 09:09:04.402869	2012-05-02 09:09:04.402869	1	Client	02 43 50 20 60				\N
149	ACTN	ZAC de Pahin	BP 10016	31170	TOURNEFEUILLE	FRANCE	40030104		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-02 09:16:47.408465	2012-05-02 09:21:10.036222	1	Fournisseur	05 62 48 84 88	05 62 48 84 89		http://www.actn.fr	\N
150	PROFIBOIS	ZA du Bois des Cours		72140	SILLE LE GUILLAUME	FRANCE	41031636		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-02 13:18:10.441364	2012-05-02 13:18:10.441364	1	Client	02 43 52 11 97	02 43 52 11 98	contact@peintures-profibois.fr		\N
152	MOSAINE CONCEPT	19, boulevard Monge		69330	MEYZIEU	FRANCE			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-04 08:49:50.450469	2012-05-04 08:49:50.450469	1	Client	04 78 21 51 03	04 78 21 59 65			\N
155	DMS DISTRIBUTION MULTIMEDIA SERVICE (DMS) 	9, rue des frères Lumière		72650	LA CHAPELLE SAINT AUBIN 	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-04 09:45:46.329953	2012-05-04 09:45:46.329953	2	Suspect	02 43 85 02 70				\N
151	FABRE SAS	30, rue des frères Lumière			LA CHAPELLE SAINT AUBIN 	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-04 08:39:13.420149	2012-05-04 09:48:27.433005	2	Suspect	02 43 24 86 30 				\N
154	LACOTE SAS	11, rue des frères Lumière		72650	LA CHAPELLE SAINT AUBIN 	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-04 09:00:28.742788	2012-05-04 09:48:41.39723	2	Suspect	02 43 81 89 80				\N
153	PRECIA MOLEN SERVICE	24 rue des frères Lumière		72650	LA CHAPELLE SAINT AUBIN 	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-04 08:51:37.169578	2012-05-04 09:48:57.842712	2	Suspect	02 43 24 87 18				\N
156	NORMACTION	8, rue des frères Lumière		72650	LA CHAPELLE SAINT AUBIN 	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-04 09:55:20.652937	2012-05-04 09:55:20.652937	2	Autre	02 43 39 13 13				\N
157	TRANSPORT FOURNIER THIERRY	55, rue Albert Einstein		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-04 09:59:14.569497	2012-05-04 09:59:14.569497	2	Suspect	02 43 88 55 29				\N
158	FORCE-OUVRIERE								m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-04 11:48:20.158949	2012-05-04 11:48:20.158949	4	Client					\N
159	TFN PROPRETE APPROS ET TECHNIQUES	rue des frères Voisin		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-07 07:47:53.904287	2012-05-07 07:47:53.904287	2	Suspect	02 43 43 37 00				\N
160	TECHNIMAINE	55, rue Albert Einstein		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-07 07:48:49.793086	2012-05-07 07:48:49.793086	2	Suspect	02 43 28 98 34				\N
161	SOFEMA IDF	8, rue René Panhard		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 13:22:46.832834	2012-05-09 13:22:46.832834	2	Suspect	02 43 57 05 91				\N
162	MCB	1, rue des frères Voisin		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 13:25:46.952098	2012-05-09 13:26:14.841051	2	Suspect	02 43 39 06 06				\N
163	ATELIER CHIRON 	14, rue des frères Voisin		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 13:32:07.738687	2012-05-09 13:32:07.738687	2	Suspect	02 43 28 64 36				\N
164	PLEINS PHARES	39, rue de l'Europe		72650	LA CHAPELLE SAINT AUBIN 	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 13:36:33.669444	2012-05-09 13:36:33.669444	2	Suspect	02 43 27 29 50				\N
165	METAMORPHOSE	5, rue de Villeneuve		72650	SAINT SATURNIN	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 13:48:36.98601	2012-05-09 13:48:36.98601	2	Suspect	02 43 52 81 16				\N
166	MAINE CARRELAGE	8, rue Albert de Dion		72650	LA CHAPELLE SAINT AUBIN 				g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 13:56:33.428365	2012-05-09 13:56:33.428365	2	Suspect	02 43 51 20 80				\N
167	MAGE / Sport & Communication Attitude	65, rue Albert Einstein		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 14:14:04.764631	2012-05-09 14:14:04.764631	2	Suspect	02 43 76 79 45				\N
168	LUCAS	13, rue Ernest Chenard		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 14:20:47.390162	2012-05-09 14:20:47.390162	2	Suspect	02 43 39 97 40				\N
169	LE ROUX DIFFUSION	24, rue Villeneuve		72650	SAINT SATURNIN	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 14:59:23.294296	2012-05-09 14:59:23.294296	2	Suspect	09 63 66 33 39				\N
170	LE MANS FD / SPEED PARK	1, rue de Villeneuve		72650	SAINT SATURNIN	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 15:02:41.795247	2012-05-09 15:03:28.34212	2	Suspect	02 43 29 56 56				\N
171	HOME TOUT BOIS	28, rue de Villeneuve		72650	SAINT SATURNIN	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 15:19:40.168086	2012-05-09 15:19:40.168086	2	Suspect	02 43 244 515				\N
172	GRAVOSIGN	67, rue Albert Einstein		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-10 08:13:51.172524	2012-05-10 08:13:51.172524	2	Suspect	02 43 14 52 52				\N
173	FONDERIE MACHERET	ZA LA PECARDIERE		72450	MONTFORT LE GESNOIS				n.retout@sigire.fr	n.retout@sigire.fr	2012-05-10 13:35:19.826239	2012-05-10 13:35:19.826239	3	Client			contact@fonderie-macheret.fr		\N
175	ECOFFI SOFTWARE					FRANCE		Prérequis MASTERPRINT :\r\nServeur : Dual-Core / Windows Server 2003 32/64bits / 4Go\r\nStation : Dual-Core / XP/Vista/7 32/64bits / 2Go\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-10 14:01:04.36573	2012-05-10 14:01:04.36573	1	Fournisseur					\N
176	LACME	Les Pelouses	Route du Lude	72200	LA FLECHE	FRANCE			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-10 14:32:03.892986	2012-05-10 14:32:03.892986	2	Prospect	02 43 94 13 45	02 43 45 24 25			\N
177	SOFAC	ZI du Guittion		72360	MAYET	FRANCE	41031906		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-10 17:02:26.667353	2012-05-10 17:02:26.667353	1	Client	02 43 46 53 54	02 43 46 58 58			\N
178	DESHAYES ET COMPAGNIE / TELEX HELIO	rue des frères Voisin		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-11 07:50:47.927104	2012-05-11 07:50:47.927104	2	Suspect	02 43 24 87 44				\N
179	ATEMA	10, rue Ernest Chenard		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-11 08:20:06.399228	2012-05-11 08:20:06.399228	2	Suspect	02 43 24 29 29				\N
180	TROUILLARD SA	56, avenue Pierre Piffault		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-11 08:39:29.272412	2012-05-11 08:39:29.272412	2	Suspect	02 43 50 15 50 				\N
181	THYSSENKRUPP MATERIALS FRANCE	72, rue Pierre Martin		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-11 08:48:10.192905	2012-05-11 08:48:10.192905	2	Suspect	02 43 40 56 56 				\N
182	MYOKEN	39, rue Gambetta		72000	LE MANS	FRANCE		Agence Web\r\nDev Web pour : www.geslin-sas.fr	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-11 10:14:54.77865	2012-05-11 10:14:54.77865	4	Autre	02 43 21 22 08			https://www.myoken.fr	\N
183	THYSSENKRUPP ASCENSEURS	11, rue André Blondel		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 13:01:35.986937	2012-05-14 13:01:35.986937	2	Suspect	02 43 50 03 20 				\N
184	TAMPLEU SPRIET	5, rue Antoine Becquerel		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 13:09:33.193601	2012-05-14 13:09:33.193601	2	Suspect	02 43 16 17 60 				\N
185	SUD MOTO	40, boulevard Pierre Lefaucheux		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 13:32:50.089342	2012-05-14 13:32:50.089342	2	Suspect	02 43 72 14 14 				\N
186	SUD CARROSSERIE	rue Pierre Martin		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 13:37:55.321931	2012-05-14 13:37:55.321931	2	Suspect	02 43 84 98 95 				\N
187	SOPRAGGLO PRODUITS BETON	6, rue Antoine Becquerel		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 13:41:39.085625	2012-05-14 13:43:07.222471	2	Suspect					\N
189	SOFRAP (Point S)	37, boulevard Pierre Lefaucheux		72000	LE MANS				g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 13:45:54.279839	2012-05-14 13:47:34.74684	2	Suspect	02 43 75 67 59 				\N
190	SOCOTEC INDUSTRIES	32, boulevard Pierre Lefaucheux		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 13:49:41.733063	2012-05-14 13:49:41.733063	2	Suspect	02 43 39 90 11 				\N
191	ARROW ECS	38-40 rue Victor Hugo 		92400 	COURBEVOIE	FRANCE			m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-14 14:44:11.206232	2012-05-14 14:47:04.676689	4	Fournisseur	01 49 97 50 00	01 49 97 50 01	contact@arrowecs.fr	http://www.arrowecs.fr	\N
192	SOCIETE MANCELLE D'EMBALLAGE INDUSTRIEL	13, boulevard Pierre Lefaucheux		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 15:01:52.015208	2012-05-14 15:01:52.015208	2	Suspect	02 43 50 28 28 				\N
193	LE HELLO	38, boulevard Pierre Lefaucheux		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 15:06:38.491721	2012-05-14 15:06:38.491721	2	Suspect	02 43 78 37 83 				\N
194	SOCIETE ELECTRO-BOBINAGE ANGEARD	50, avenue Pierre Piffault		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 09:26:42.753369	2012-05-15 09:26:42.753369	2	Suspect	02 43 84 38 10 				\N
195	SOCIETE DANIEL THIBAULT IMMOBILIER	2, boulevard Pierre Lefaucheux		72000	LE MANS				g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 09:44:03.077	2012-05-15 09:44:03.077	2	Suspect	02 43 85 23 23 				\N
196	SOCIETE CIVILE IMAGE ET MARQUE	2, avenue Pierre Piffault		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 09:50:44.423374	2012-05-15 09:50:44.423374	2	Suspect	02 43 28 17 89 				\N
102	SMV	Epinettes du Loir		72500 	DISSAY SOUS COURCILLON	FRANCE		- 1 time Capsule (sauvegarde)\r\n- 5 postes (2 MacOS) avec accès INTERNET\r\n- ADSL ORANGE - Ping 81ms - BP Down : 0,9Mbit/s DP Up : 0,13 Mbits/s	s.martin@sigire.fr	m.ozan@sigire.fr	2012-04-19 08:27:41.782529	2012-05-15 09:56:13.468406	2	Prospect	02 43 44 09 13	02 43 44 56 76			\N
197	SOCIETE NOUVELLE DES ETS ROUSSEAU	60, rue Pierre Martin		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 09:57:30.675789	2012-05-15 09:57:30.675789	2	Suspect	02 43 41 38 19 				\N
198	CHEVALLIER DUFEIL	Zi Les Epinettes Du Loir	14, avenue du Mans	72500	DISSAY SOUS COURCILLON				g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 13:31:34.679533	2012-05-15 13:31:34.679533	2	Suspect	02 43 44 08 44				\N
199	CLOAREC SARL	Za des Epinettes du Loir		72500	DISSAY SOUS COURCILLON	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 13:37:49.807143	2012-05-15 13:37:49.807143	2	Suspect	02 43 44 61 44				\N
200	SOCIETE NANTAISE FOURNITURES INDUSTRIELLES	18, boulevard Pierre Lefaucheux		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 14:44:30.256152	2012-05-15 14:44:30.256152	2	Suspect	02 43 84 18 98 				\N
201	SOCIETE D'EXPLOITATION DES ETS DE SABLE 	56, boulevard Pierre Lefaucheux		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 14:59:37.683647	2012-05-15 15:00:12.429771	2	Suspect	02 43 50 36 10 				\N
202	AQUILOC	60, rue Pierre Martin		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 15:05:21.855238	2012-05-15 15:06:22.890273	2	Suspect	02 43 84 16 16 				\N
203	SNC ARPAL 72	22, rue Pierre Martin		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 15:19:13.647588	2012-05-15 15:19:13.647588	2	Suspect	02 43 85 53 00 				\N
204	SMAC	51, avenue Pierre Piffault		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 15:21:41.065752	2012-05-15 15:21:41.065752	2	Suspect	02 43 84 60 03 				\N
205	QUERU DISTRIBUTION	78, rue Pierre Martin		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 15:42:25.096155	2012-05-15 15:42:25.096155	2	Suspect	02 43 72 15 51 				\N
206	OCEANET	7 rue des Frênes	ZAC de la Pointe	72190	SARGE-LES-LE MANS				m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-16 07:56:56.97953	2012-05-16 07:59:53.159652	4	Fournisseur	02 43 50 26 45	02 43 72 21 14		http://www.oceanet.com/	\N
207	LIGEPACK	27-29, Rue Jean Grémillon		72000	LE MANS		41031243		i.moison@sigire.fr	i.moison@sigire.fr	2012-05-16 13:03:52.8267	2012-05-16 13:03:52.8267	5	Client	02 43 28 97 97	02 43 28 14 20	contact@ligepack.com	www.ligepack.com	\N
208	LENOVO FRANCE					FRANCE			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-18 07:24:03.471942	2012-05-18 07:24:03.471942	1	Fournisseur					\N
209	VMWARE	100-101, Quartier Boieldieu		92042	PARIS LA DEFENSE	FRANCE			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-18 15:17:40.83986	2012-05-18 15:17:40.83986	1	Fournisseur				http://www.vmware.fr	\N
211	CLINIQUE VETERINAIRE BOUSSER CARON	26, rue Henri Barbusse		72100	LE MANS	FRANCE	41030244		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-21 13:01:09.462089	2012-05-21 13:13:42.996693	1	Client	02 43 72 45 85				\N
212	S2E	36, rue Edgar Brandt		72000	LE MANS	FRANCE	41031912		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-21 15:33:13.049684	2012-05-21 15:33:13.049684	1	Client	02 43 76 15 50	02 43 81 24 19			\N
213	BOUET SERVICE ELEVAGE	Zone industrielle	Rue de la Scierie	61170	COULONGES SUR SARTHE	FRANCE			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-22 08:18:05.757123	2012-05-22 08:18:05.757123	1	Client	02 33 31 28 28	02 33 31 28 29			\N
214	CREATION CUISINES ET BAINS	83 chemin de CESAR		72230	RUAUDIN	FRANCE		9h00 - 19H00 du lundi au samedi	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-22 08:43:22.641112	2012-06-22 07:48:05.166493	4	Client	02 43 72 01 42	02 43 78 00 94			\N
215	DIAGONORM	9, rue de la Butte		72650	SAINT SATURNIN	FRANCE	41031831		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-22 09:08:14.709329	2012-05-22 09:09:20.60955	1	Client	02 43 72 06 56	02 43 72 08 87	diagonorm@yahoo.fr	http://www.diagnostics-immobiliers-diagonorm.fr	\N
216	KILOUTOU 	34, boulevard Pierre Lefaucheux		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-23 09:25:31.847589	2012-05-23 09:25:31.847589	2	Suspect	02 43 16 18 18 				\N
217	R-HYDRAU	21, boulevard Pierre Lefaucheux		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-23 09:32:00.977428	2012-05-23 09:40:24.364567	2	Suspect	02 43 86 68 60 				\N
218	REXEL FRANCE	14, boulevard Pierre Lefaucheux		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-23 09:40:08.300781	2012-05-23 09:40:53.266095	2	Suspect	02 43 50 23 23 				\N
219	RENOV'HABITAT	28, rue des grandes courbes		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-23 09:46:41.036761	2012-05-23 09:46:41.036761	2	Suspect	02 43 24 24 10 				\N
220	PROXISERVE	94, rue Pierre Martin		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-23 09:54:24.844835	2012-05-23 09:54:24.844835	2	Suspect	02 43 85 49 72 				\N
221	RT2P	16, rue du Champ Fleuri		72190	COULAINES	FRANCE			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-23 15:43:50.705733	2012-05-23 15:43:50.705733	1	Prospect					\N
222	PREFA BETON 72	30, boulevard Pierre Lefaucheux		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-24 08:35:02.270882	2012-05-24 08:35:02.270882	2	Suspect	02 43 80 61 55				\N
225	OUVRIERS DES TRANSPORTEURS DU MAINE	6, rue Antoine Becquerel		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-24 14:20:27.248453	2012-05-24 14:20:27.248453	2	Suspect	02 43 84 15 88 				\N
226	OTIS 	117, rue de l'Angevinière		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-24 14:23:49.998013	2012-05-24 14:23:49.998013	2	Suspect	02 43 41 42 14 				\N
227	NET PLUS	18, boulevard Pierre Lefaucheux		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-24 15:49:42.635258	2012-05-24 15:49:42.635258	2	Suspect	02 43 72 40 43 				\N
116	TPM BATIMENT	ZA La Borde		72310	BESSE SUR BRAYE				s.martin@sigire.fr	g.forestier@sigire.fr	2012-04-19 12:07:18.385392	2012-05-25 08:17:00.130364	2	Prospect	02 43 35 13 91	02 43 35 14 38	tpmbatiment@orange.fr		\N
228	IMPRI-OUEST							Site de SALBRIS : 02 54 97 07 19	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-29 09:42:00.1947	2012-05-29 09:46:50.25166	4	Client	02 43 86 21 74				\N
210	ECOLE SUPERIEURE DES BEAUX-ARTS D'ANGERS	Hôtel d'Ollone	72, rue Bressigny	49100	ANGERS	FRANCE		Est envoyé par Henri-Michel Jean (ESBAM).\r\nRéf KASPERSKY : KL4851XAPFE	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-21 09:16:40.163172	2012-05-30 09:34:15.902421	1	Prospect	02 41 24 13 50	02 41 87 26 49	contact@esba-angers.eu	http://www.esba-angers.eu	\N
229	ETC	Bâtiment Les Corvettes	142, avenue de Stalingrad	92714	COLOMBES CEDEX	FRANCE			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-04 06:36:12.810214	2012-06-04 06:36:12.810214	1	Fournisseur				http://www.etc-dist.fr	\N
230	7BULLES	ZONE INDUSTRIELLE NORD		72650	LA CHAPELLE SAINT-AUBIN	FRANCE			n.retout@sigire.fr	n.retout@sigire.fr	2012-06-04 08:28:21.742199	2012-06-04 08:28:21.742199	3	Client					\N
231	MAINE SOUDAGE	79, avenue Pierre Piffault		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-04 12:36:44.582289	2012-06-04 12:36:44.582289	2	Suspect	02 43 75 55 88 				\N
232	MABEL	Boulevard d'Estienne d'Orves		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-04 12:38:53.990902	2012-06-04 12:38:53.990902	2	Suspect	02 43 86 70 10				\N
233	LOISIRS CONSTRUCTIONS PISCINES	1, rue Pierre Martin		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-04 13:33:07.029217	2012-06-04 13:33:07.029217	2	Suspect	02 43 50 06 50				\N
234	LOCA POIDS LOURDS	2, rue Antoine Becquerel		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-04 13:36:34.453357	2012-06-04 13:36:34.453357	2	Suspect	02 43 50 26 80 				\N
235	BOUTAUX	ZA de Mâle	RD 923	61260	LE THEIL SUR HUISNE	FRANCE		N° Fournisseur : 002160	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-04 13:47:11.274418	2012-06-04 13:48:19.387179	1	Client	02 37 49 15 00	02 37 49 64 07		http://www.boutaux.com	\N
236	LINCONYL	5, avenue Pierre Piffault		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-04 13:48:43.667591	2012-06-04 13:48:43.667591	2	Suspect	02 43 23 24 10 				\N
237	LES VIANDES DU MANS	39, boulevard Pierre Lefaucheux		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-04 15:18:30.521759	2012-06-04 15:18:30.521759	2	Suspect	02 43 50 31 50 				\N
238	LE MANS QUAD	28, boulevard Pierre Lefaucheux		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-04 15:20:12.95917	2012-06-04 15:20:12.95917	2	Suspect	02 43 86 60 48 				\N
239	ATELIER STYL'COUTURE	80, boulevard de l'industrie		53940	SAINT BERTHEVIN	FRANCE			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-05 07:13:59.67266	2012-06-05 07:13:59.67266	1	Client	02 43 64 16 66				\N
240	LE MANS PRIMEURS	12, rue Antoine Becquerel		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:25:29.259772	2012-06-05 13:25:29.259772	2	Suspect	02 43 72 89 55 				\N
242	EUREKA INGENIERIE	19, rue Louis Breguet		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:30:20.260343	2012-06-05 13:30:20.260343	2	Suspect	02 43 72 89 02 				\N
241	SOUPLET 	17, rue Michael Farraday		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:28:57.748263	2012-06-05 13:30:36.704347	2	Suspect	02 43 84 70 88 				\N
243	EUROPE REGIES OUEST	38, boulevard d'Estienne d'Orves		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:32:44.533348	2012-06-05 13:32:44.533348	2	Suspect	02 99 26 45 61 				\N
244	FRAIKIN FRANCE	50, boulevard Pierre Lefaucheux		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:38:52.363551	2012-06-05 13:38:52.363551	2	Suspect	02 43 78 04 54 				\N
245	FRANCE ALLIANCE 72	18, boulevard Pierre Lefaucheux		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:40:19.692957	2012-06-05 13:40:19.692957	2	Suspect	02 43 75 71 18 				\N
246	FRANCE SECURITE	rue Pierre Martin		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:41:28.711377	2012-06-05 13:41:28.711377	2	Suspect	02 43 84 84 23				\N
247	FRANS BONHOMME	rue Pierre Martin		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:42:53.594289	2012-06-05 13:42:53.594289	2	Suspect	02 43 85 11 18				\N
248	GARAGE CRETOT	2, rue Antoine Becquerel		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:44:01.909159	2012-06-05 13:44:01.909159	2	Suspect	02 43 84 88 88 				\N
249	GEFI	Boulevard Pierre Lefaucheux		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:45:30.014017	2012-06-05 13:45:30.014017	2	Suspect	02 43 78 50 00				\N
250	GMT	11, rue Pierre Martin		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:46:58.795856	2012-06-05 13:46:58.795856	2	Suspect	02 43 50 23 00 				\N
251	GPDIS GRAND OUEST	3, rue Antoine Becquerel		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:50:05.826781	2012-06-05 13:50:05.826781	2	Suspect	02 43 50 17 50				\N
252	GROUPE TC	16bis, rue Pierre Martin		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:51:27.405015	2012-06-05 13:51:27.405015	2	Suspect	02 43 86 04 04				\N
253	GUY DAUPHIN ENVIRONNEMENT	49, avenue Pierre Piffault		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:52:49.706034	2012-06-05 13:52:49.706034	2	Suspect	02 43 84 65 80				\N
254	HILTI-FRANCE	2, boulevard Pierre Lefaucheux		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:54:22.20802	2012-06-05 13:54:22.20802	2	Suspect	02 43 75 16 16				\N
255	HINAUT ELEC	20, boulevard Pierre Lefaucheux		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:55:28.598294	2012-06-05 13:55:28.598294	2	Suspect	02 43 78 02 00				\N
223	PARTENIA	4, rue Joseph Marie Jacquard		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-24 08:45:31.594943	2012-06-12 08:32:43.024146	2	Suspect	02 43 41 33 33		contact@partenia-plast.com		\N
257	IFTIM ENTREPRISES	56, rue François Monier		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:56:44.27687	2012-06-05 13:56:44.27687	2	Suspect	02 43 75 02 85				\N
258	JALPA	21, boulevard Pierre Lefaucheux		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:57:39.074386	2012-06-05 13:57:39.074386	2	Suspect	02 43 84 66 60				\N
259	KDI	15, boulevard Pierre Lefaucheux		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:58:22.927848	2012-06-05 13:58:22.927848	2	Suspect	02 43 50 14 50				\N
256	COUELLIER VIVIER	1 IMP RENE LEBRUN		72000	LE MANS	FRANCE		Cabinet d'architectes	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-05 13:55:41.894548	2012-06-05 13:59:12.144675	4	Client	02 43 78 11 78	02 43 41 31 48			\N
260	LAFARGE BETONS DE L'OUEST	1, rue Antoine Becquerel		72000	LE MANS	FRANCE			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:59:28.447849	2012-06-05 13:59:28.447849	2	Suspect	02 43 50 11 80				\N
261	GAUTIER								m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-06 10:03:10.17775	2012-06-06 10:03:10.17775	4	Client					\N
262	MARCADE								n.retout@sigire.fr	n.retout@sigire.fr	2012-06-07 14:30:43.394789	2012-06-07 14:30:43.394789	3	Client	02 43 85 66 75				\N
263	FIA WEC	Circuit des 24H		72000	LE MANS		41032601		i.moison@sigire.fr	i.moison@sigire.fr	2012-06-08 09:31:14.175019	2012-06-08 09:31:14.175019	5	Client	02 43 40 21 87	02 43 40 21 84	a.rosay@fiawec.com      		\N
264	ON CHANNEL	69-71, avenue Pierre Grenier		92100	BOULOGNE BILLANCOURT	FRANCE		Agence de communication d'IBM	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-08 09:31:46.112991	2012-06-08 09:31:46.112991	1	Fournisseur					\N
265	COMPTE BIDON	frd	fgdfg		dfgfd				m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-11 10:19:04.965519	2012-06-11 10:19:57.174716	4	Suspect	gfd	gfdg	fdg	fdgdg	\N
267	ABATTOIR DE CHERANCE	33, rue de la 2 DB		72170	CHERANCE	FRANCE		Appeler au 02 37 29 18 03\r\n\r\n \r\n \t\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 41483410100019\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 2\r\nEffectif sur site \t: 60\t \tNombre de PC \t: 29\r\nEffectif société \t: 120\t \tActivité \t: Production de viandes de boucherie (151A)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 1\r\nEffectif Production \t: 48\t \tNb téléphones fixes \t: 10\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 2\r\n \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tIBM\tSERVEUR\tWINDOWS 2003\t2\t10\t07\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDIVERS\tPC\tWINDOWS XP\t28\t\t\r\nPortable\tDIVERS\tPORTABLE\tWINDOWS XP\t1\t\t\r\nEcrans plats\tHP/COMPAQ\t\t\t10\t\t\r\nMobilité\tAPPLE\tIPHONE\tIPHONE OS\t1\t\t11\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tAASTRA/MATRA TELECOM\tERICSSON\t\t\t\t02\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tHP/COMPAQ\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nGpao\tSPECIFIQUE\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tMCAFEE\t\t\t\t\t\r\nAntivirus\tKASPERSKY\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tXEROX/TEKTRONIX\t\t\t\t\t\r\nImprimantes\tKONICA/MINOLTA\t\t\t\t\t\r\nImprimantes\tRICOH\t\t\t\t\t\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tBROTHER\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t4\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\nStockage Software\tSTOCKAGE SOFTWARE\t\t\t\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t1\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 09:04:03.008868	2012-06-12 09:05:55.002157	2	Prospect	02 43 33 13 33	02 43 97 11 78		http://www.vallegrain.com	\N
338	ENTREPRISE DUCRE	26, rue André Ampère		61000	ALENCON	FRANCE		ne répond pas\r\n\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 09632011400018\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 59\t \tNombre de PC \t: 15\r\nEffectif société \t: 59\t \tActivité \t: Installation d'équipements thermiques et de climatisation (453F)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 1\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 0\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 0\r\n \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tDIVERS\tSERVEUR\tWINDOWS 2003\t1\t\t08\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDIVERS\tPC\tLINUX\t15\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:23:55.695918	2012-06-16 23:24:35.193235	2	Suspect	02 33 29 17 83	02 33 31 03 64			\N
339	EPI NT	ZA des Maletières		53600	EVRON	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 42863407500041\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 13\t \tNombre de PC \t: 15\r\nEffectif société \t: 13\t \tActivité \t: Traitement et revêtement des métaux (285A)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 11\t \tNb téléphones fixes \t: 6\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 6\r\n \r\n \r\n Les serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t1\t12\t05\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS XP\t12\t\t\r\nPortable\tHP/COMPAQ\tPORTABLE\tWINDOWS XP\t3\t\t\r\nEcrans plats\tHP/COMPAQ\t\t\t12\t\t\r\nMobilité\tBLACKBERRY\tPDA\tRIM\t1\t\t09\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tSFR\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tSFR\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t4\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\nStockage Software\tSTOCKAGE SOFTWARE\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t72\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\tTIBCO\t\t1\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:26:04.839157	2012-06-16 23:26:04.839157	2	Suspect	02 43 01 39 01	02 43 01 32 05		http://www.sdi.fr	\N
340	ETOILE ROUTIERE	ZI nord ouest rue des Frères Chappe		72200	LA FLECHE	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 57715011300030\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 300\t \tNombre de PC \t: 36\r\nEffectif société \t: 300\t \tActivité \t: Transports routiers de marchandises interurbains (602M)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 30\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 84\r\n \r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs mini\tIBM\tISERIES\tOS 400\t1\t30\t04\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDIVERS\tPC\tWINDOWS XP\t30\t\t\r\nPortable\tDIVERS\tPORTABLE\tWINDOWS XP\t6\t\t\r\nEcrans plats\tDIVERS\t\t\t30\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tDIVERS\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tDIVERS\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tDIVERS\t\t\t\t\t\r\nSwitch\tDIVERS\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tDB2/BAS400\t\t\t\t\t\r\nCompta/Finance\tSPECIFIQUE\t\t\t\t\t\r\nGED\tDIVERS\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tDIVERS\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tBITDEFENDER\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tLEXMARK\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tIBM\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t10\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t1\t\t\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:32:35.906439	2012-06-16 23:32:35.906439	2	Suspect	02 43 48 26 26	02 43 48 26 25		http://www.etoileroutiere.fr	\N
268	ACTIBAT PARIS IDF	11, rue Emile Brault	ZA des Alignes 	53000	LAVAL	FRANCE		 \t\r\nAppartient à un groupe \t: Oui\t \tSIRET \t: 44015610700029\r\nGroupe \t: GTA FINANCE\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 4\r\nEffectif sur site \t: 30\t \tNombre de PC \t: 35\r\nEffectif société \t: 200\t \tActivité \t: Administration d'entreprises (741J)\r\nEffectif informatique \t: 3\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 30\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 5\r\n \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tDIVERS\tSERVEUR\tWINDOWS 2000\t1\t\t06\r\nServeurs micro\tDIVERS\tSERVEUR\tWINDOWS 2003\t2\t\t06\r\nServeurs micro\tIBM\tSERVEUR\tLINUX\t1\t\t06\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDIVERS\tPC\tWINDOWS XP\t30\t\t\r\nPortable\tACER\tPORTABLE\tWINDOWS XP\t5\t\t\r\nEcrans plats\tDIVERS\t\t\t15\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2000\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nOpérateur Fixe\tSFR\t\t\t\t\t\r\nPABX/IPBX\tDIVERS\t\t\t\t\t01\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tFUNKWERK\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tMOZILLA\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nAntivirus\tTREND MICRO\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 09:15:00.640751	2012-06-12 09:15:46.430961	2	Suspect	02 43 01 20 34	02 43 26 03 50		http://www.actual-interim.com	\N
269	ADINE	7, allée du Pré Vert 		72360	MAYET	FRANCE		tout externalise. Ne veut  pas me parler\r\n\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 31179524900011\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 5\r\nEffectif sur site \t: 90\t \tNombre de PC \t: 60\r\nEffectif société \t: 90\t \tActivité \t: Fabrication de papier et de carton (211C)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 53\t \tNb téléphones fixes \t: 40\r\nEffectif BE \t: 5\t \tNb téléphones mobiles \t: 10\r\n \r\n\r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t2\t41\t08\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2003\t3\t41\t05\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tAPPLE\tMAC\tMAC/OS\t1\t\t\r\nMicro\tDELL\tPC\tWINDOWS XP\t20\t\t\r\nMicro\tASSEMBLE\tPC\tWINDOWS XP\t32\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t7\t\t\r\nEcrans plats\tDELL\t\t\t30\t\t\r\nMobilité\tBLACKBERRY\tPDA\tRIM\t6\t\t07\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t10\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nWAN\tVOIP\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tD-LINK\t\t\t\t\t\r\nSwitch\tSMC/NETWORKS\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tACCESS\t\t\t\t\t\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nCfao\tAUTODESK\t\t\t\t\t\r\nGpao\tDIVERS\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCompta/Finance\tCEGID\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tZYXEL\t\t\t\t\t\r\nAntivirus\tF SECURE\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tEPSON\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tTOSHIBA\t\t\t\t\t\r\nImprimantes\tSAMSUNG\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t30\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDELL\tLTO\t\t\t\t\r\nStockage Software\tSTOCKAGE SOFTWARE\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t300\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFacility management\t\t\t1\t\t\r\nInfos Diverses\tFait appel a une ssii\t\t\t\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 09:20:38.064815	2012-06-12 09:20:38.064815	2	Suspect	02 43 38 52 52	02 43 38 52 72		http://www.adine.fr	\N
270	AGEM	10, rue de la Tuilerie		72400	CHERRE 			Ne prend pas au téléphone. Uniquement mail\r\n\r\nAppartient à un groupe \t: Oui\t \tSIRET \t: 34857200900028\r\nGroupe \t: FINANCIERE VALMER\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 2\r\nEffectif sur site \t: 250\t \tNombre de PC \t: 95\r\nEffectif société \t: 250\t \tActivité \t: Fabrication de charpentes et de menuiseries (203Z)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 1\r\nEffectif Production \t: 75\t \tNb téléphones fixes \t: 30\r\nEffectif BE \t: 2\t \tNb téléphones mobiles \t: 15\r\n \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tASSEMBLE\tSERVEUR\tWINDOWS 2003\t2\t90\t08\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tASSEMBLE\tPC\tWINDOWS XP\t80\t\t\r\nPortable\tTOSHIBA\tPORTABLE\tWINDOWS XP\t15\t\t\r\nEcrans plats\tLG/GOLDSTAR\t\t\t80\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tSFR\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t01\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tSFR\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tFUNKWERK\t\t\t\t\t\r\nSwitch\tD-LINK\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tFOX PRO\t\t\t\t\t\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nCfao\tAUTODESK\tAUTOCAD\t\t\t\t\r\nCompta/Finance\tCEGID\tCCMX\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tDIVERS\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tSYMANTEC\t\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tTREND MICRO\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tRICOH\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t5\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\tLTO\t\t\t\t\r\nStockage Software\tCOMPUTER ASSOCIATES\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t150\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFacility management\t\t\t1\t\t\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 09:25:06.444704	2012-06-12 09:25:06.444704	2	Prospect	02 43 71 28 78	02 43 71 28 72		http://www.agem.fr	\N
271	AGRO EVOLUTION	Sourche Centre de Recherche		72240	SAINT SYMPHORIEN	FRANCE		Hors cible\r\n\r\n\r\n \t\r\nAppartient à un groupe \t: Oui\t \tSIRET \t: 43382579100018\r\nGroupe \t: GLON\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 2\r\nEffectif sur site \t: 50\t \tNombre de PC \t: 35\r\nEffectif société \t: 50\t \tActivité \t: Recherche-développement en sciences physiques et naturelles (731Z)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 1\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 40\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 10\r\n \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t2\t34\t07\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tASSEMBLE\tPC\tWINDOWS XP\t25\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t10\t\t\r\nEcrans plats\tLG/GOLDSTAR\t\t\t2\t\t\r\nEcrans plats\tDELL\t\t\t2\t\t\r\nMobilité\tAPPLE\tIPHONE\tIPHONE OS\t1\t\t11\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nTechnologie d accès\tFIBRE OPTIQUE\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nWAN\tGLOBAL INTRANET\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tORACLE\t\t\t\t\t\r\nSgbd\tACCESS\t\t\t\t\t\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nGpao\tSPECIFIQUE\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCompta/Finance\tARCOLE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nExtranet\tEXTRANET\t\t\t\t\t\r\nMessagerie\tLOTUSNOTES\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tLEXMARK\t\t\t\t\t\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t10\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tHP/COMPAQ\tLTO\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t80\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 13:19:43.824018	2012-06-12 13:19:43.824018	2	Suspect	02 43 52 10 52	02 43 20 77 69		http://www.groupe-glon.com/	\N
272	AIMM	ZI les Morandieres rue Jean Baptiste Lamarcq	rue Jean Baptiste Lamarcq BP 90607 Changé	53006	LAVAL CEDEX	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 39449954500025\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 120\t \tNombre de PC \t: 38\r\nEffectif société \t: 120\t \tActivité \t: Découpage, emboutissage (284B)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 80\t \tNb téléphones fixes \t: 30\r\nEffectif BE \t: 3\t \tNb téléphones mobiles \t: 5\r\n \r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tDELL\tSERVEUR\tUNIX\t1\t20\t04\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t30\t\t\r\nPortable\tNEC\tPORTABLE\tWINDOWS XP\t5\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS 2000\t3\t\t\r\nEcrans plats\tDELL\t\t\t10\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t04\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tFUNKWERK\t\t\t\t\t\r\nSwitch\t3COM\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tINFORMIX/IBM\t\t\t\t\t\r\nCfao\tMISSLER\tTOPCAD\t\t\t\t\r\nErp\tDIVERS\tSYLOB\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tBROTHER\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 13:27:19.378289	2012-06-12 13:27:19.378289	2	Suspect	02 43 59 21 59	02 43 49 10 70		http://www.aim-grp.fr	\N
273	HARAS DE LA VALLEE DES HALFINGER	GOURDAINE		72550	DEGRE	FRANCE			n.retout@sigire.fr	n.retout@sigire.fr	2012-06-12 13:57:04.178836	2012-06-12 13:57:04.178836	3	Client	02 43 27 27 12				\N
275	ALSETEX	Usine de malpaire		72300	PRECIGNE	FRANCE		M. Chague est a Muret en Haute Garonne\r\nHORS CIBLE\r\n\r\nAppartient à un groupe \t: Oui\t \tSIRET \t: 77733552200036\r\nGroupe \t: LACROIX\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 2\r\nEffectif sur site \t: 150\t \tNombre de PC \t: 56\r\nEffectif société \t: 150\t \tActivité \t: Fabrication d'armement (296A)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 1\r\nEffectif Production \t: 80\t \tNb téléphones fixes \t: 40\r\nEffectif BE \t: 3\t \tNb téléphones mobiles \t: 12\r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tIBM\tSERVEUR\tUNIX\t1\t11\t06\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2003\t1\t\t08\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDIVERS\tPC\tWINDOWS XP\t48\t\t\r\nPortable\tHP/COMPAQ\tPORTABLE\tWINDOWS XP\t8\t\t\r\nEcrans plats\tDIVERS\t\t\t45\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nTechnologie d accès\tSDSL\t\t\t\t\t\r\nOpérateur Fixe\tDIVERS\t\t\t\t\t\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tOPERATEUR MOBILE\t\t\t\t\t\r\nFourniss. Accès Internet\tDIVERS\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tDIVERS\t\t\t\t\t\r\nSwitch\tDIVERS\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nCfao\tSOLIDWORKS\t\t\t\t\t\r\nErp\tPMICS\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tDIVERS\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tTREND MICRO\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tBROTHER\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t15\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\n  	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 15:37:20.810606	2012-06-12 15:37:20.810606	2	Suspect	02 43 92 81 00	02 45 92 81 36		http://www.alsetex.fr	\N
276	SIPPAC	10, rue Gambetta		72300	SABLE SUR SARTHE	FRANCE		Concurrent. Contacté par SUPPLEX pour fournir du matériel. Fait surtout du EBP et intervient jusque Angers et Laval. 	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 15:42:35.498936	2012-06-12 15:42:35.498936	1	Autre	02 43 62 00 77			http://www.sippac.fr	\N
278	APPLI PLASTE	18, rue Eiffel		61000	ALENCON	FRANCE		Contact : M. Grenier 02 33 31 28 11\r\nVient de s'équiper avec une société voisine\r\n\r\n \t\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 39912399100032\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 45\t \tNombre de PC \t: 18\r\nEffectif société \t: 45\t \tActivité \t: Fabrication d'articles divers en matières plastiques (252G)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 1\r\nEffectif Production \t: 35\t \tNb téléphones fixes \t: 10\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 1\r\n \r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t1\t16\t06\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tIBM/LENOVO\tPC\tWINDOWS XP\t16\t\t\r\nPortable\tIBM/LENOVO\tPORTABLE\tWINDOWS XP\t2\t\t\r\nEcrans plats\tIBM\t\t\t16\t\t\r\nMobilité\tBLACKBERRY\tPDA\tRIM\t2\t\t10\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t95\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\t3COM\t\t\t\t\t\r\nSwitch\t3COM\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tDIVERS\t\t\t\t\t\r\nErp\tSAGE\tXR3\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tNOD 32\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t7\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tHP/COMPAQ\t\t\t\t\t\r\nStockage Software\tSTOCKAGE SOFTWARE\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t200\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 15:54:15.792857	2012-06-12 15:54:15.792857	2	Suspect	02 33 31 08 93	02 33 31 08 94		http://www.appliplast.fr	\N
274	ALCCAD	ZI sud	rue Pierre Lemonnier\t	53960	BONCHAMP LES LAVAL	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 38767757800016\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 12\r\nEffectif sur site \t: 40\t \tNombre de PC \t: 23\r\nEffectif société \t: 40\t \tActivité \t: Fabrication de fils et câbles isolés (313Z)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 30\t \tNb téléphones fixes \t: 20\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 2\r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t12\t\t07\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t18\t\t\r\nMicro\tDELL\tPC\tWINDOWS 7\t2\t\t\r\nPortable\tACER\tPORTABLE\tWINDOWS XP\t3\t\t\r\nEcrans plats\tDIVERS\t\t\t5\t\t\r\nEcrans plats\tDELL\t\t\t1\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tDIVERS\t\t\t\t\t\r\nSwitch\tDIVERS\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tINTERBASE\t\t\t\t\t\r\nGpao\tSPECIFIQUE\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nMessagerie\tMOZILLA\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tKASPERSKY\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t3\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t480\t\t\r\n\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 15:33:12.430565	2012-06-14 23:21:56.107714	2	Suspect	02 43 59 76 00	02 43 53 36 21		http://www.alcad.com	\N
279	APROCHIM	ZI la Promenade		53290	GREZ EN BOUERE	FRANCE		Appartient à un groupe \t: Oui\t \tSIRET \t: 34498486900026\r\nGroupe \t: CHIMIREC\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 3\r\nEffectif sur site \t: 90\t \tNombre de PC \t: 37\r\nEffectif société \t: 90\t \tActivité \t: Traitement des autres déchets solides (900E)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 1\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 25\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 20\r\n \r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t3\t40\t09\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS XP\t25\t\t\r\nPortable\tHP/COMPAQ\tPORTABLE\tWINDOWS XP\t12\t\t\r\nEcrans plats\tHP/COMPAQ\t\t\t25\t\t\r\nMobilité\tBLACKBERRY\tPDA\tRIM\t12\t\t10\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tSDSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t08\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tHP/COMPAQ\t\t\t\t\t\r\nSwitch\tHP/COMPAQ\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t15\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tHP/COMPAQ\t\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t200\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\tTIBCO\t\t1\t\t\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:00:09.207987	2012-06-12 16:00:09.207987	2	Suspect	02 43 09 14 50	02 43 70 68 26		http://www.aprochim.fr	\N
280	AREA SNA	Parc d'activité de Sainte Anne		61190	TOUROUVRE	FRANCE		Envoyer mail a laurent.legoupil@sna.coop\r\n\r\n \t\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 32001798100046\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 2\r\nEffectif sur site \t: 220\t \tNombre de PC \t: 48\r\nEffectif société \t: 220\t \tActivité \t: Reproduction d'enregistrements sonores (223A)\r\nEffectif informatique \t: 3\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 130\t \tNb téléphones fixes \t: 0\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 0\r\n\r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs mini\tIBM\tISERIES\tOS 400\t1\t7\t01\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2000\t1\t\t01\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDIVERS\tPC\tWINDOWS 2000\t45\t\t\r\nPortable\tHP/COMPAQ\tPORTABLE\tWINDOWS 2000\t3\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2000\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tHP/COMPAQ\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tDB2/BAS400\t\t\t\t\t\r\nSgbd\tACCESS\t\t\t\t\t\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nGpao\tSPECIFIQUE\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:05:37.404522	2012-06-12 16:05:37.404522	2	Suspect	02 33 85 15 15	02 33 25 76 06		http://www.snacompactdisc.com	\N
281	ARIEL BN	9, rue Auguste Mauttin		61500	SEES	FRANCE		Hors Cible. Groupe Vinci Pour tout y compris Télécom\r\n\r\nAppartient à un groupe \t: Oui\t \tSIRET \t: 31820108400064\r\nGroupe \t: VINCI\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 2\r\nEffectif sur site \t: 44\t \tNombre de PC \t: 24\r\nEffectif société \t: 72\t \tActivité \t: Fabrication de materiel de distribution et de commande (312A)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 20\r\nEffectif BE \t: 8\t \tNb téléphones mobiles \t: 10\r\n \r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tDELL\tSERVEUR\tLINUX\t1\t13\t06\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2008\t1\t20\t10\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t13\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t8\t\t\r\nStation de travail\tDELL\tWORKSTATION\tWINDOWS XP\t3\t\t05\r\nEcrans plats\tDELL\t\t\t13\t\t\r\nMobilité\tBLACKBERRY\tPDA\tRIM\t3\t\t10\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2008\t\t\t\t\r\nTechnologie d accès\tSDSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nOpérateur Fixe\tSFR\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t08\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tNETGEAR\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tORACLE\t\t\t\t\t\r\nCfao\tDIVERS\tIGE\t\t\t\t\r\nErp\tORACLE APL\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nExtranet\tEXTRANET\t\t\t\t\t\r\nMessagerie\tEXCHANGE\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t4\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\tDAT\t\t\t\t\r\nStockage Software\tSTOCKAGE SOFTWARE\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t150\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:10:15.617224	2012-06-12 16:10:15.617224	1	Suspect	02 33 28 70 60	02 33 27 79 65		http://www.ariel.fr	\N
282	ARJOWIGGINS	Lieu dit Le Bourray		72470	SAINT MARS LA BRIERE	FRANCE		HORS CIBLE\r\n\r\nAppartient à un groupe \t: Oui\t \tSIRET \t: 57715015400018\r\nGroupe \t: SEQUANA\t \tType Ets \t: Siege\r\nSite informatique distant \t: Oui\t \tNombre de Serveurs \t: 12\r\nEffectif sur site \t: 260\t \tNombre de PC \t: 80\r\nEffectif société \t: 260\t \tActivité \t: Fabrication de papier et de carton (211C)\r\nEffectif informatique \t: 2\t \tNb sites interconnectés \t: 1\r\nEffectif Production \t: 190\t \tNb téléphones fixes \t: 60\r\nEffectif BE \t: 2\t \tNb téléphones mobiles \t: 5\r\n \r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2003\t10\t78\t09\r\nServeurs risc\tHP/COMPAQ\t9000\tUNIX\t2\t78\t09\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tIBM/LENOVO\tPC\tWINDOWS XP\t70\t\t\r\nPortable\tIBM/LENOVO\tPORTABLE\tWINDOWS XP\t10\t\t\r\nEcrans plats\tIBM\t\t\t70\t\t\r\nMobilité\tBLACKBERRY\tPDA\tRIM\t10\t\t10\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tSDSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t05\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nWAN\tMPLS\t\t\t\t\t\r\nWAN\tVOIP\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tHP/COMPAQ\t\t\t\t\t\r\nSwitch\tHP/COMPAQ\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tORACLE\t\t\t\t\t\r\nSgbd\tACCESS\t\t\t\t\t\r\nCfao\tAUTODESK\tAUTOCAD\t\t\t\t\r\nGpao\tSPECIFIQUE\t\t\t\t\t\r\nErp\tSPECIFIQUE\t\t\t\t\t\r\nCompta/Finance\tDIVERS\t\t\t\t\t\r\nCRM\tKDP INFORMATIQUE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tLOTUSNOTES\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tKASPERSKY\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tRICOH\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t30\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\tROBOT\t\t\t\t\r\nStockage Hardware\tDIVERS\tDLT\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t160\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\tTIBCO\t\t1\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:14:03.739828	2012-06-12 16:14:03.739828	2	Suspect	02 43 82 91 00	02 43 82 91 01		http://www.arjowiggins.com	\N
283	ARO	1, avenue de Tours		72500	CHATEAU DU LOIR	FRANCE		HORS CIBLE\r\nChangement actionnaire\r\nMatos : Angleterre\r\nFAI : Adista sur plaque Sartel\r\nMobile : Bouygues Telecom\r\n\r\n\r\n \t\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 54210295900047\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 20\r\nEffectif sur site \t: 280\t \tNombre de PC \t: 230\r\nEffectif société \t: 280\t \tActivité \t: Fabrication de matériel de soudage (294D)\r\nEffectif informatique \t: 4\t \tNb sites interconnectés \t: 4\r\nEffectif Production \t: 120\t \tNb téléphones fixes \t: 400\r\nEffectif BE \t: 50\t \tNb téléphones mobiles \t: 50\r\n \r\n\r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t4\t400\t05\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tLINUX\t4\t\t05\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2008\t1\t\t10\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2000\t4\t400\t10\r\nServeurs risc\tHP/COMPAQ\t9000\tUNIX\t7\t400\t06\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS XP\t120\t\t\r\nPortable\tHP/COMPAQ\tPORTABLE\tWINDOWS XP\t80\t\t\r\nStation de travail\tHP/COMPAQ\tWORKSTATION\tWINDOWS 2000\t30\t\t06\r\nEcrans plats\tHP/COMPAQ\t\t\t120\t\t\r\nMobilité\tAPPLE\tIPHONE\tIPHONE OS\t4\t\t10\r\nMobilité\tAPPLE\tIPHONE\tIPHONE OS\t10\t\t10\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2000\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2008\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nTechnologie d accès\tFIBRE OPTIQUE\t\t\t\t\t\r\nTechnologie d accès\tTDSL\t\t\t\t\t\r\nOpérateur Fixe\tSFR\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tHP/COMPAQ\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tORACLE\t\t\t\t\t\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nCfao\tCATIA\t\t\t\t\t\r\nCfao\tMICROCADDS\t\t\t\t\t\r\nErp\tSAP\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nExtranet\tEXTRANET\t\t\t\t\t\r\nMessagerie\tEXCHANGE\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tSONICWALL\t\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tDIVERS\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tXEROX/TEKTRONIX\t\t\t\t\t\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t100\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tHP/COMPAQ\tSAN\t\t\t\t\r\nStockage Software\tATEMPO\tTIME NAVIGATOR\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t4000\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t1\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:17:53.973576	2012-06-12 16:17:53.973576	2	Suspect	02 43 44 74 00	02 43 44 74 01		http://www.aronet.com	\N
284	ARTS GRAPHIQUES ROTO	ZA Berd Huis		61340	BERD HUIS	FRANCE		Envoyer courrier a M. ou Mme Chedhomme\r\n\r\n \t\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 34414463900012\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 2\r\nEffectif sur site \t: 80\t \tNombre de PC \t: 15\r\nEffectif société \t: 83\t \tActivité \t: Autre imprimerie (labeur) (222C)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 67\t \tNb téléphones fixes \t: 30\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 7\r\n \r\n\r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tAPPLE\tSERVEUR\tMAC/OS\t1\t5\t06\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2000\t1\t8\t06\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDIVERS\tPC\tWINDOWS 2000\t8\t\t\r\nMicro\tAPPLE\tMAC\tMAC/OS\t5\t\t\r\nPortable\tDIVERS\tPORTABLE\tWINDOWS XP\t2\t\t\r\nEcrans plats\tDIVERS\t\t\t5\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tAPPLESHARE\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2000\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tAVAYA/TENOVIS\t\t\t\t\t\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tFUNKWERK\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nGpao\tSPECIFIQUE\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tTREND MICRO\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t2\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFacility management\t\t\t1\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:25:57.411052	2012-06-12 16:25:57.411052	2	Suspect	02 33 85 10 10	02 33 85 10 19		http://www.agroto.fr	\N
285	ASAHI DIAMOND INDUSTRIAL	47, avenue d'Orléans 	BP 841	28011	CHARTRES CEDEX	FRANCE		Appartient à un groupe \t: Oui\t \tSIRET \t: 62200758100029\r\nGroupe \t: ASAHI DIAMOND INDUSTRIAL\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 3\r\nEffectif sur site \t: 160\t \tNombre de PC \t: 70\r\nEffectif société \t: 160\t \tActivité \t: Fabrication d'outillage mécanique (286D)\r\nEffectif informatique \t: 2\t \tNb sites interconnectés \t: 7\r\nEffectif Production \t: 100\t \tNb téléphones fixes \t: 0\r\nEffectif BE \t: 1\t \tNb téléphones mobiles \t: 0\r\n \r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs mini\tIBM\tISERIES\tOS 400\t1\t70\t02\r\nServeurs micro\tIBM\tSERVEUR\tWINDOWS 2000\t2\t\t02\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t50\t\t\r\nPortable\tIBM/LENOVO\tPORTABLE\tWINDOWS XP\t20\t\t\r\nEcrans plats\tDELL\t\t\t50\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2000\t\t\t\t\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nTechnologie d accès\tSDSL\t\t\t\t\t\r\nOpérateur Fixe\tDIVERS\t\t\t\t\t\r\nPABX/IPBX\tDIVERS\t\t\t\t\t\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nWAN\tVOIP\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tDIVERS\t\t\t\t\t\r\nSwitch\tD-LINK\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tDB2/BAS400\t\t\t\t\t\r\nSgbd\tACCESS\t\t\t\t\t\r\nCfao\tSOLIDWORKS\t\t\t\t\t\r\nGpao\tINFOR/MAPICS\t\t\t\t\t\r\nCompta/Finance\tDIVERS\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tDIVERS\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tKYOCERA/MITA\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t15\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\tDLT\t\t\t\t\r\nStockage Software\tSTOCKAGE SOFTWARE\t\t\t\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t1\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:28:29.10295	2012-06-12 16:28:29.10295	2	Suspect	02 37 24 40 40	02 37 24 40 99			\N
286	ASSOC DIOCESAINE DE LAVAL	27, rue du cardinal Suhard 	BP 1225\t	53012	LAVAL CEDEX	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 78625768300015\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 25\t \tNombre de PC \t: 20\r\nEffectif société \t: 50\t \tActivité \t: Organisations religieuses (913A)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 26\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 0\r\n \r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tACER\tSERVEUR\tWINDOWS XP\t1\t\t07\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tASSEMBLE\tPC\tWINDOWS XP\t19\t\t\r\nPortable\tHP/COMPAQ\tPORTABLE\tWINDOWS XP\t1\t\t\r\nEcrans plats\tVIEWSONIC/NOKIA\t\t\t19\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS XP\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tAASTRA/MATRA TELECOM\tERICSSON\t\t\t\t\r\nOpérateur Mobile\tOPERATEUR MOBILE\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tIBM\t\t\t\t\t\r\nSwitch\tIBM\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tACCESS\t\t\t\t\t\r\nCompta/Finance\tSPECIFIQUE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nAntivirus\tTREND MICRO\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tTOSHIBA\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t2\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\nStockage Software\tSTOCKAGE SOFTWARE\t\t\t\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:32:24.95205	2012-06-12 16:32:24.95205	2	Suspect	02 43 69 24 21	02 43 66 87 46		http://www.diocese-laval.cef.fr	\N
287	ASSOC PROMOTION EMPLOI SPORTIF	32, rue paul courboulay		72000	LE MANS	FRANCE		 \t\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 39206314500016\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 30\t \tNombre de PC \t: 4\r\nEffectif société \t: 120\t \tActivité \t: Gestion d'installations sportives (926A)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 3\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 0\r\n \r\n\r\n  \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tASSEMBLE\tSERVEUR\tWINDOWS NT\t1\t4\t02\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tASSEMBLE\tPC\tWINDOWS XP\t4\t\t\r\nEcrans plats\tDIVERS\t\t\t2\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tETHERNET\tWINDOWS NT\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t93\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\t3COM\t\t\t\t\t\r\nSwitch\t3COM\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nCompta/Finance\tCIEL\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tMCAFEE\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tDIVERS\t\t\t\t\t\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t3\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t1\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:35:50.647866	2012-06-12 16:35:50.647866	2	Suspect	02 43 43 57 77	02 43 43 57 76		http://www.asso.proxylond.fr/apes72	\N
288	ATLAN	Route Louplande		72210	LA SUZE SUR SARTHE	FRANCE		Pas de besoins. Barrage secretaire\r\n\r\n \t\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 57595008400039\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 2\r\nEffectif sur site \t: 47\t \tNombre de PC \t: 9\r\nEffectif société \t: 47\t \tActivité \t: Fabrication de matières plastiques de base (241L)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 43\t \tNb téléphones fixes \t: 15\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 10\r\n \r\n \r\n \r\n\r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2000\t1\t10\t03\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS NT\t1\t10\t99\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS XP\t7\t\t\r\nPortable\tHP/COMPAQ\tPORTABLE\tWINDOWS XP\t2\t\t\r\nEcrans plats\tHP/COMPAQ\t\t\t5\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2000\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS NT\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tSFR\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t07\r\nWAN\tTRANSPAC\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tEPSON\t\t\t\t\t\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t3\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tHP/COMPAQ\tRAID\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t100\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:43:14.661282	2012-06-12 16:43:14.661282	2	Prospect	02 43 39 19 90	02 43 77 39 30		http://www.atlan.fr	\N
341	ETS DENIS	Avenue Louis Denis		28160	BROU	FRANCE		\r\n \t\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 32123678800014\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 2\r\nEffectif sur site \t: 200\t \tNombre de PC \t: 90\r\nEffectif société \t: 200\t \tActivité \t: Fabrication d'équipements de levage et de manutention (292D)\r\nEffectif informatique \t: 2\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 100\t \tNb téléphones fixes \t: 90\r\nEffectif BE \t: 25\t \tNb téléphones mobiles \t: 0\r\n \r\n\r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tDIVERS\tSERVEUR\tWINDOWS NT\t2\t80\t02\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tASSEMBLE\tPC\tWINDOWS NT\t40\t\t\r\nMicro\tASSEMBLE\tPC\tWINDOWS XP\t40\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS NT\t5\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS 2000\t5\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tETHERNET\tWINDOWS NT\t\t\t\t\r\nRéseaux locaux\tETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tAASTRA/MATRA TELECOM\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tDIVERS\tSHIVA\t\t\t\t\r\nSwitch\tHP/COMPAQ\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tORACLE\t\t\t\t\t\r\nSgbd\tACCESS\t\t\t\t\t\r\nSgbd\tPROGRESS\t\t\t\t\t\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nCfao\tPROENGINER\t\t\t\t\t\r\nErp\tINFOR/MAPICS\t\t\t\t\t\r\nCompta/Finance\tDIVERS\t\t\t\t\t\r\nOutils décisionnel\tDIVERS\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tEXCHANGE\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:53:04.610443	2012-06-16 23:53:04.610443	2	Suspect	 02 37 97 66 11	 02 37 97 66 40		http://www.denis.fr	\N
266	3 MO	rue de Bruxelles		53000	LAVAL	FRANCE		 \t\r\nAppartient à un groupe \t: Oui\t \tSIRET \t: 41414623300013\r\nGroupe \t: ERMO\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 2\r\nEffectif sur site \t: 46\t \tNombre de PC \t: 33\r\nEffectif société \t: 46\t \tActivité \t: Fabrication de moules et modèles (295N)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 1\r\nEffectif Production \t: 32\t \tNb téléphones fixes \t: 20\r\nEffectif BE \t: 10\t \tNb téléphones mobiles \t: 10\r\n \r\n \r\n Les serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t1\t24\t06\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2008\t1\t30\t11\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS XP\t25\t\t\r\nPortable\tHP/COMPAQ\tPORTABLE\tWINDOWS XP\t3\t\t\r\nPortable\tHP/COMPAQ\tPORTABLE\tWINDOWS 7\t5\t\t\r\nEcrans plats\tHP/COMPAQ\t\t\t25\t\t\r\nMobilité\tAPPLE\tIPHONE\tIPHONE OS\t1\t\t11\r\nMobilité\tTOSHIBA\tPOCKET PC\tWINDOWS CE\t1\t\t06\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tWINDOWS 2008\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nOpérateur Fixe\tSFR\t\t\t\t\t\r\nPABX/IPBX\tDIVERS\tCENTREX\t\t\t\t10\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nWAN\tVOIP\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tSFR\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tHP/COMPAQ\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tACCESS\t\t\t\t\t\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nCfao\tCATIA\t\t\t\t\t\r\nGpao\tDIVERS\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tTREND MICRO\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t2\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\tNAS\t\t\t\t\r\nStockage Hardware\tHP/COMPAQ\t\t\t\t\t\r\nStockage Software\tSTOCKAGE SOFTWARE\tBACKUP EXPRESS\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t2000\t\t\r\n	g.forestier@sigire.fr	g.guivarch@sigire.fr	2012-06-11 19:17:48.856549	2012-06-13 08:49:12.710987	2	Suspect	02 43 53 29 39	02 43 56 60 20		http://www.3mo.com	\N
277	ANFRAY GIORIA ELECTRICITE	157, route de Beaugé 		72021	LE MANS CEDEX 2	FRANCE		M. Vade est la plupart du temps sur Paris. La secretaire souhaite que nous envoyions une documentation\r\n\r\n \t\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 32474600700032\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 12\t \tNombre de PC \t: 17\r\nEffectif société \t: 43\t \tActivité \t: Travaux d'installation électrique (453A)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 15\r\nEffectif BE \t: 6\t \tNb téléphones mobiles \t: 30\r\n \r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t1\t17\t08\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t12\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t5\t\t\r\nEcrans plats\tDELL\t\t\t12\t\t\r\nMobilité\tBLACKBERRY\tPDA\tRIM\t4\t\t11\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tSFR\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t03\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tSFR\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tORACLE\t\t\t\t\t\r\nCfao\tAUTODESK\tAUTOCAD\t\t\t\t\r\nCompta/Finance\tDIVERS\tPROGIB\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tKONICA/MINOLTA\t\t\t\t\t\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t2\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tHP/COMPAQ\t\t\t\t\t\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 15:50:32.891772	2012-06-13 08:52:57.837884	1	Client	02 43 52 05 90	02 43 52 00 05		http://www.anfray-gioria.fr	\N
289	BASE DE MAGNY LE DESERT	La Brindossiere		61600	MAGNY LE DESERT	FRANCE		RDV le 20/06/2012 a 15H00 \r\n\r\nAppartient à un groupe \t: Oui\t \tSIRET \t: 34523405800013\r\nGroupe \t: ITM ENTREPRISE\t \tType Ets \t: Siege\r\nSite informatique distant \t: Oui\t \tNombre de Serveurs \t: 5\r\nEffectif sur site \t: 150\t \tNombre de PC \t: 53\r\nEffectif société \t: 200\t \tActivité \t: Entreposage frigorifique (631D)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 2\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 85\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 4\r\n \r\n\r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tIBM\tSERVEUR\tWINDOWS 2003\t4\t50\t09\r\nServeurs micro\tIBM\tSERVEUR\tWINDOWS 2000\t1\t50\t02\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS XP\t30\t\t\r\nMicro\tDELL\tPC\tWINDOWS XP\t20\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t2\t\t\r\nStation de travail\tDELL\tWORKSTATION\tWINDOWS XP\t1\t\t06\r\nEcrans plats\tDELL\t\t\t40\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2000\t\t\t\t\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nTechnologie d accès\tLL 512K\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t\r\nWAN\tTRANSPAC\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tDIVERS\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tALCATEL\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tORACLE\t\t\t\t\t\r\nSgbd\tACCESS\t\t\t\t\t\r\nCompta/Finance\tDIVERS\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tLOTUSNOTES\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tDIVERS\t\t\t\t\t\r\nImprimantes\tLEXMARK\t\t\t\t\t\r\nImprimantes\tRICOH\t\t\t\t\t\r\nImprimantes\tIBM\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t22\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\nStockage Hardware\tIBM\t\t\t\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 10:10:44.485798	2012-06-13 10:12:44.472138	2	Suspect	02 33 30 28 00	02 33 38 03 28		http://www.mousquetaires.com	\N
290	BELIPA	101, route de Tours		72220	ECOMMOY	FRANCE		Plan de continuation. Periode d'observation\r\n\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 33500332300029\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 4\r\nEffectif sur site \t: 120\t \tNombre de PC \t: 52\r\nEffectif société \t: 120\t \tActivité \t: Fabrication de panneaux de bois (202Z)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 90\t \tNb téléphones fixes \t: 60\r\nEffectif BE \t: 2\t \tNb téléphones mobiles \t: 14\r\n \r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t4\t30\t09\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDIVERS\tPC\tWINDOWS XP\t45\t\t\r\nPortable\tHP/COMPAQ\tPORTABLE\tWINDOWS XP\t7\t\t\r\nEcrans plats\tDIVERS\t\t\t30\t\t\r\nMobilité\tAPPLE\tIPHONE\tIPHONE OS\t6\t\t11\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tD-LINK\t\t\t\t\t\r\nSwitch\tHP/COMPAQ\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tACCESS\t\t\t\t\t\r\nSgbd\tFOX PRO\t\t\t\t\t\r\nCfao\tDESIGNCAD\t\t\t\t\t\r\nGpao\tCEGID/PRODUFLEX\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tLOTUSNOTES\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tRICOH\t\t\t\t\t\r\nImprimantes\tEPSON\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t25\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tHP/COMPAQ\t\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 10:14:41.953461	2012-06-13 10:14:41.953461	2	Prospect	02 43 47 02 80	02 43 42 38 52		http://www.belipa.com	\N
292	BERU MURSORB	Route d'Argentan		61600	LA FERTE MACE	FRANCE		HORS CIBLE - GROUPE BERU\r\n\r\nAppartient à un groupe \t: Oui\t \tSIRET \t: 33918633000017\r\nGroupe \t: BERU\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 80\t \tNombre de PC \t: 32\r\nEffectif société \t: 80\t \tActivité \t: Fabrication de materiels electriques pour moteurs et véhicu (316A)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 60\t \tNb téléphones fixes \t: 20\r\nEffectif BE \t: 1\t \tNb téléphones mobiles \t: 2\r\n \r\n\r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tNETWARE\t1\t32\t\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tASSEMBLE\tPC\tWINDOWS XP\t30\t\t\r\nPortable\tNEC\tPORTABLE\tWINDOWS XP\t2\t\t\r\nEcrans plats\tHP/COMPAQ\t\t\t30\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tNETWARE\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tAASTRA/MATRA TELECOM\t\t\t\t\t\r\nWAN\tTRANSPAC\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\t3COM\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tACCESS\t\t\t\t\t\r\nCfao\tAUTODESK\tAUTOCAD\t\t\t\t\r\nErp\tSAP\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nExtranet\tEXTRANET\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tBROTHER\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t5\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 10:30:29.872008	2012-06-13 10:30:29.872008	2	Suspect	02 33 30 24 24	02 33 30 12 96		http://www.beru.de	\N
293	BORREL BOUVARD ARTHAUD	Lieu dit la Maladerie		72340	LA CHARTRE SUR LE LOIR	FRANCE		HORS CIBLE - Argenteuil M. Gerard 01 34 26 52 52\r\n\r\nAppartient à un groupe \t: Oui\t \tSIRET \t: 38113665400013\r\nGroupe \t: MARCK\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 35\t \tNombre de PC \t: 16\r\nEffectif société \t: 50\t \tActivité \t: Industries textiles n.c.a. (175G)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 20\t \tNb téléphones fixes \t: 15\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 1\r\n \r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2008\t1\t\t11\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t15\t\t\r\nPortable\tHP/COMPAQ\tPORTABLE\tWINDOWS XP\t1\t\t\r\nEcrans plats\tDELL\t\t\t15\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2008\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t03\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tORACLE\t\t\t\t\t\r\nErp\tSAGE\tXR3\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tNOD 32\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tXEROX/TEKTRONIX\t\t\t\t\t\r\nImprimantes\tEPSON\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t7\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 10:33:56.125058	2012-06-13 10:33:56.125058	2	Suspect	02 43 44 41 75	02 43 79 07 27		http://www/b-d-a.fr	\N
294	BOULFRAY	ZI ouest 8, rue Gilbert Romme		72200	LA FLECHE	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 32900161400034\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 120\t \tNombre de PC \t: 12\r\nEffectif société \t: 120\t \tActivité \t: Peinture (454J)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 7\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 12\r\n \r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tDIVERS\tSERVEUR\tWINDOWS 2003\t1\t\t05\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDIVERS\tPC\tWINDOWS XP\t7\t\t\r\nPortable\tDIVERS\tPORTABLE\tWINDOWS XP\t5\t\t\r\nEcrans plats\tDIVERS\t\t\t5\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tDIVERS\t\t\t\t\t03\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tDIVERS\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nCompta/Finance\tCEGID\tCCMX\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nAntivirus\tKASPERSKY\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tBROTHER\t\t\t\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\nStockage Software\tSTOCKAGE SOFTWARE\t\t\t\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 10:37:23.531955	2012-06-13 10:37:23.531955	2	Suspect	02 43 94 04 77	02 43 94 20 73		http://www.boulfray.fr	\N
295	BOULONNERIE ET VISSERIE DE SABLE	ZI route du Mans BP 6		72301	SABLE SUR SARTHE CEDEX	FRANCE		RDV tres fructueux\r\nPlusieurs projets : Fibre, téléphonie fixe, téléphonie mobile, Wifi, changement de serveur, firewall, virtualisation ?\r\nRDV Technique le 12 juin à 14 h 00 avec ingénieur Sigiré\r\n\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 57625065800027\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 5\r\nEffectif sur site \t: 46\t \tNombre de PC \t: 33\r\nEffectif société \t: 46\t \tActivité \t: Visserie et boulonnerie (287G)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 30\t \tNb téléphones fixes \t: 17\r\nEffectif BE \t: 2\t \tNb téléphones mobiles \t: 3\r\n \r\n \r\n Les serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t1\t28\t08\r\nServeurs micro\tIBM\tSERVEUR\tUNIX\t1\t28\t03\r\nServeurs micro\tIBM\tSERVEUR\tLINUX\t1\t28\t03\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2003\t1\t28\t05\r\nServeurs micro\tASSEMBLE\tSERVEUR\tWINDOWS 2003\t1\t\t11\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tASSEMBLE\tPC\tWINDOWS XP\t30\t\t\r\nPortable\tDIVERS\tPORTABLE\tWINDOWS 7\t1\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t2\t\t\r\nEcrans plats\tLG/GOLDSTAR\t\t\t10\t\t\r\nEcrans plats\tHYUNDAI\t\t\t5\t\t\r\nEcrans plats\tDELL\t\t\t3\t\t\r\nMobilité\tBLACKBERRY\tPDA\tRIM\t1\t\t06\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tFIBRE OPTIQUE\t\t\t\t\t\r\nTechnologie d accès\tSDSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t08\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nWAN\tVOIP\t\t\t\t\t\r\nOpérateur Mobile\tBOUYGUES\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tD-LINK\t\t\t\t\t\r\nSwitch\t3COM\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tORACLE\t\t\t\t\t\r\nCfao\tVISIONAEL\t\t\t\t\t\r\nCfao\tSOLIDWORKS\t\t\t\t\t\r\nErp\tASAP\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nOutils décisionnel\tIBM/COGNOS\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\tLINUX\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tKASPERSKY\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tBROTHER\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t10\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\tDAT\t\t\t\t\r\nStockage Software\tCOMPUTER ASSOCIATES\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t200\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 10:41:45.221875	2012-06-13 10:41:45.221875	2	Suspect	02 43 95 00 74	02 43 92 27 60		http://www.bvs-fixations.com	\N
296	BOURDON HAENNI BAUMER	125, rue de la Marre BP 70214		41103	VENDOME CEDEX	FRANCE		Appartient à un groupe \t: Oui\t \tSIRET \t: 77568049900149\r\nGroupe \t: BOURDON HAENNI\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 4\r\nEffectif sur site \t: 200\t \tNombre de PC \t: 140\r\nEffectif société \t: 200\t \tActivité \t: Fabrication d'instrumentation scientifique et technique (332B)\r\nEffectif informatique \t: 2\t \tNb sites interconnectés \t: 1\r\nEffectif Production \t: 110\t \tNb téléphones fixes \t: 150\r\nEffectif BE \t: 20\t \tNb téléphones mobiles \t: 20\r\n \r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs mini\tIBM\tISERIES\tOS 400\t1\t100\t07\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2003\t3\t100\t09\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t120\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t20\t\t\r\nEcrans plats\tDELL\t\t\t120\t\t\r\nMobilité\tHTC\tPDA\tWINDOWS MOBILE\t2\t\t09\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tAASTRA/MATRA TELECOM\t\t\t\t\t02\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tDB2/BAS400\t\t\t\t\t\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nCfao\tAUTODESK\tAUTOCAD\t\t\t\t\r\nErp\tSAP\t\t\t\t\t\r\nOutils décisionnel\tIBM/COGNOS\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tLOTUSNOTES\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tNETASQ\t\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nAntivirus\tCOMPUTER ASSOCIATES\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tKYOCERA/MITA\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t15\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\tDAT\t\t\t\t\r\nStockage Hardware\tDIVERS\tLTO\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t1000\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 18:44:30.790566	2012-06-13 18:44:30.790566	2	Suspect	02 54 73 74 75	02 54 73 74 74		http://www.baumer.com	\N
297	BRIO	Boulevard Galilee		53810	CHANGE	FRANCE		Appartient à un groupe \t: Oui\t \tSIRET \t: 33275811900033\r\nGroupe \t: AGIR GRAPHIC\t \tType Ets \t: Siege\r\nSite informatique distant \t: Oui\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 150\t \tNombre de PC \t: 27\r\nEffectif société \t: 163\t \tActivité \t: Reliure et finition (222E)\r\nEffectif informatique \t: 2\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 0\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 0\r\n \r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tDIVERS\tSERVEUR\tWINDOWS 95\t1\t\t97\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS 95\t22\t\t\r\nMicro\tDELL\tPC\tWINDOWS 95\t3\t\t\r\nPortable\tDIVERS\tPORTABLE\tWINDOWS 95\t2\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tDIVERS\t\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tDIVERS\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nGpao\tCEGID/PRODUFLEX\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tLOTUSNOTES\t\t\t\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 18:47:13.197752	2012-06-13 18:47:13.197752	2	Suspect	02 43 49 59 00	02 43 49 59 02		http://www.brio-graphic.fr	\N
298	BRISARD NOGUES VAL DE LOIRE	Lieu dit Vaumigny		28200	SAINT DENIS LES PONTS	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 40076194600013\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 55\t \tNombre de PC \t: 20\r\nEffectif société \t: 55\t \tActivité \t: Fabrication de constructions métalliques (281A)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 18\t \tNb téléphones fixes \t: 20\r\nEffectif BE \t: 2\t \tNb téléphones mobiles \t: 5\r\n Les serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tDIVERS\tSERVEUR\tWINDOWS 2003\t1\t\t06\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tFUJITSU/SIEMENS\tPC\tWINDOWS XP\t20\t\t\r\nEcrans plats\tDIVERS\t\t\t20\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tDIVERS\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tDIVERS\t\t\t\t\t\r\nSwitch\tDIVERS\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nCfao\tDIVERS\t\t\t\t\t\r\nGpao\tSPECIFIQUE\t\t\t\t\t\r\nCompta/Finance\tSPECIFIQUE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nAntivirus\tMCAFEE\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tDIVERS\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 18:51:20.93771	2012-06-13 18:51:20.93771	2	Suspect	02 37 45 09 90	02 37 45 65 75			\N
299	BROCHAGE 3000	ZA BP 252 Fromentieres		53202	CHATEAU GONTIER CEDEX	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 31579772000010\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 60\t \tNombre de PC \t: 10\r\nEffectif société \t: 60\t \tActivité \t: Reliure et finition (222E)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 6\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 2\r\n \r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tAPPLE\tSERVEUR\tMAC/OS\t1\t6\t01\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tAPPLE\tMAC\tMAC/OS\t8\t\t\r\nPortable\tAPPLE\tPORTABLE\tMAC/OS\t2\t\t\r\nEcrans plats\tAPPLE\t\t\t8\t\t\r\nMobilité\tPALM\tPDA\tPALM/OS\t1\t\t07\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tAPPLESHARE\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tDIVERS\tCOFRATEL\t\t\t\t07\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tDIVERS\t\t\t\t\t\r\nSwitch\tDIVERS\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nAntivirus\tKASPERSKY\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tOKI\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t2\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\nStockage Software\tSTOCKAGE SOFTWARE\t\t\t\t\t\r\nStockage Software\tSTOCKAGE SOFTWARE\tRETROSPEC\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t250\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 18:54:37.670696	2012-06-13 18:54:37.670696	2	Suspect	02 43 09 62 62	02 43 70 48 26			\N
300	BRODARD ET TAUPIN	ZI de la Lande avenue Rhin et Danube BP 19		72200	LA FLECHE	FRANCE		Appartient à un groupe \t: Oui\t \tSIRET \t: 55209583800074\r\nGroupe \t: CHEVRILLON PHILIPPE INDUSTRIE\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 2\r\nEffectif sur site \t: 200\t \tNombre de PC \t: 81\r\nEffectif société \t: 200\t \tActivité \t: Autre imprimerie (labeur) (222C)\r\nEffectif informatique \t: 3\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 170\t \tNb téléphones fixes \t: 0\r\nEffectif BE \t: 10\t \tNb téléphones mobiles \t: 0\r\n \r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2003\t1\t100\t09\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2008\t1\t100\t09\r\nVirtualisation\tDELL\tVMWARE\t\t1\t\t09\r\nOs virtualisation\tWINDOWS 2008\t\t\t1\t\t\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t75\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t6\t\t\r\nEcrans plats\tDELL\t\t\t75\t\t\r\nMobilité\tAPPLE\tIPHONE\tIPHONE OS\t1\t\t09\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tWINDOWS 2008\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tSDSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tBOUYGUES\t\t\t\t\t\r\nFourniss. Accès Internet\tDIVERS\tEASYNET\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tDELL\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tORACLE\t\t\t\t\t\r\nSgbd\tACCESS\t\t\t\t\t\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nSgbd\tHYPERFILE\t\t\t\t\t\r\nCfao\tAUTODESK\tAUTOCAD\t\t\t\t\r\nGpao\tSPECIFIQUE\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nOutils décisionnel\tDIVERS\t\t\t\t\t\r\nCRM\tSPECIFIQUE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tLOCAL\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tEXCHANGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tTREND MICRO\t\t\t\t\t\r\nAntivirus\tNOD 32\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tDELL\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t20\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\tLTO\t\t\t\t\r\nStockage Hardware\tDIVERS\tNAS\t\t\t\t\r\nStockage Software\tCOMPUTER ASSOCIATES\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t1000\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 18:57:15.350182	2012-06-13 18:57:15.350182	2	Suspect	02 43 48 22 22	02 43 48 22 23		http://www.cpibooks.fr	\N
137	WATT COMMUNICATION	9, rue Docteur Schweitzer		85100 	LES SABLE D'OLONNE	FRANCE		A réalisé le site www.dupontavice.com	m.ozan@sigire.fr	g.forestier@sigire.fr	2012-04-27 08:17:22.27388	2012-06-14 09:39:33.106496	4	Prospect			http://www.watt-communication.fr/		\N
301	CALBERSON EURE ET LOIR	ZI BP 256 Le Coudray		28005	CHARTRES CEDEX	FRANCE		Appartient à un groupe \t: Oui\t \tSIRET \t: 80572097600044\r\nGroupe \t: GEODIS\t \tType Ets \t: Siege\r\nSite informatique distant \t: Oui\t \tNombre de Serveurs \t: 3\r\nEffectif sur site \t: 108\t \tNombre de PC \t: 60\r\nEffectif société \t: 108\t \tActivité \t: Messagerie, fret express (634A)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 2\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 40\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 57\r\n \r\n \r\n Les serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs mini\tIBM\tISERIES\tOS 400\t1\t\t11\r\nServeurs micro\tIBM\tSERVEUR\tWINDOWS 2003\t1\t60\t06\r\nServeurs micro\tIBM\tTSE\tWINDOWS 2003\t1\t60\t08\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tNEC\tPC\tWINDOWS XP\t20\t\t\r\nMicro\tHP/NEOWARE\tTW\tWINDOWS CE\t30\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t10\t\t\r\nEcrans plats\tHP/COMPAQ\t\t\t20\t\t\r\nEcrans plats\tNEC/MITSUBISHI\t\t\t20\t\t\r\nMobilité\tHTC\tPDA\tWINDOWS CE\t50\t\t10\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nTechnologie d accès\tTRANSFIX\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nTechnologie d accès\tFIBRE OPTIQUE\t\t\t\t\t\r\nOpérateur Fixe\tSFR\t\t\t\t\t\r\nPABX/IPBX\tSAGEM\t\t\t\t\t\r\nWAN\tFRAME RELAY\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tDB2/BAS400\t\t\t\t\t\r\nSgbd\tACCESS\t\t\t\t\t\r\nCompta/Finance\tANAEL MS\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tLOTUSNOTES\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tMCAFEE\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tLEXMARK\t\t\t\t\t\r\nImprimantes\tKYOCERA/MITA\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tSHARP\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t12\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tIBM\tDAT\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t360\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 22:40:38.97655	2012-06-14 22:40:38.97655	2	Suspect	02 37 28 28 28	02 37 28 18 10		http://www.calberson.com	\N
302	CAREA SANITAIRE	Route d'Evron		72140	SILLE LE GUILLAUME	FRANCE		Ne veut pas me prendre. Pas de besoins\r\n\r\nAppartient à un groupe \t: Oui\t \tSIRET \t: 42870356500013\r\nGroupe \t: CAREA\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 2\r\nEffectif sur site \t: 80\t \tNombre de PC \t: 24\r\nEffectif société \t: 80\t \tActivité \t: Fabrication d'éléments en matières plastiques pour la (252E)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 2\r\nEffectif Production \t: 30\t \tNb téléphones fixes \t: 20\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 15\r\n \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t2\t15\t07\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tACER\tPC\tWINDOWS XP\t15\t\t\r\nMicro\tDELL\tPC\tWINDOWS VISTA\t2\t\t\r\nMicro\tDELL\tPC\tWINDOWS XP\t2\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t5\t\t\r\nEcrans plats\tDELL\t\t\t15\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nOpérateur Fixe\tSFR\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t02\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tBOUYGUES\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tNETOPIA\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nGpao\tCEGID/PRODUFLEX\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCRM\tKDP INFORMATIQUE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tCOMPUTER ASSOCIATES\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tBROTHER\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tTOSHIBA\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t6\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tHP/COMPAQ\t\t\t\t\t\r\nStockage Hardware\tHP/COMPAQ\tDAT\t\t\t\t\r\nStockage Software\tCOMPUTER ASSOCIATES\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t140\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 22:45:31.743961	2012-06-14 22:45:31.743961	2	Suspect	02 43 20 00 01	02 43 20 88 15		http://www.carea.fr	\N
303	CARRIERES DE VOUTRE	Route de Sillé		53600	VOUTRE	FRANCE		Appartient à un groupe \t: Oui\t \tSIRET \t: 33119225200012\r\nGroupe \t: PIERRE CHARRON\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 60\t \tNombre de PC \t: 25\r\nEffectif société \t: 60\t \tActivité \t: Production de sables et de granulats (142A)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 1\r\nEffectif Production \t: 30\t \tNb téléphones fixes \t: 30\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 8\r\n Les serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t1\t\t05\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS XP\t15\t\t\r\nMicro\tDELL\tPC\tWINDOWS XP\t5\t\t\r\nPortable\tACER\tPORTABLE\tWINDOWS XP\t5\t\t\r\nEcrans plats\tLG/GOLDSTAR\t\t\t5\t\t\r\nEcrans plats\tHP/COMPAQ\t\t\t10\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tDIVERS\t\t\t\t\t10\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tFUNKWERK\t\t\t\t\t\r\nSwitch\tDIVERS\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tACCESS\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tBROTHER\t\t\t\t\t\r\nImprimantes\tTOSHIBA\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t6\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nStockage Software\tHP\tDATA PROTECTOR\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t72\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 22:48:06.833902	2012-06-14 22:48:06.833902	2	Suspect	02 43 01 53 00	02 43 01 53 10			\N
304	CARROSSERIE INDUSTRIELLE TOUTAIN	Avenue de Verdun		72200	LA FLECHE	FRANCE		Barrage secretaire\r\n\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 32444493400016\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 50\t \tNombre de PC \t: 10\r\nEffectif société \t: 50\t \tActivité \t: Fabrication de carrosseries automobiles (342A)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 34\t \tNb téléphones fixes \t: 10\r\nEffectif BE \t: 3\t \tNb téléphones mobiles \t: 3\r\n \r\n\r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tASSEMBLE\tSERVEUR\tWINDOWS 2000\t1\t10\t02\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tASSEMBLE\tPC\tWINDOWS 2000\t10\t\t\r\nEcrans plats\tDIVERS\t\t\t3\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2000\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\t3COM\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nCfao\tAUTODESK\tAUTOCAD\t\t\t\t\r\nGpao\tSPECIFIQUE\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tTOSHIBA\t\t\t\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 22:50:12.004024	2012-06-14 22:51:32.390024	2	Suspect	02 43 94 09 97	02 43 45 29 50			\N
305	CARTONEX	ZI les Cophas		28120	ILLIERS COMBRAY	FRANCE		Appartient à un groupe \t: Oui\t \tSIRET \t: 58214340000023\r\nGroupe \t: LGR EMBALLAGES\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 2\r\nEffectif sur site \t: 72\t \tNombre de PC \t: 38\r\nEffectif société \t: 72\t \tActivité \t: Fabrication de cartonnages (212B)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 1\r\nEffectif Production \t: 53\t \tNb téléphones fixes \t: 30\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 5\r\n \r\n \r\n Les serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tAPPLE\tSERVEUR\tMAC/OS\t1\t4\t05\r\nServeurs risc\tIBM\tRISC 6000\tUNIX\t1\t20\t05\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tAPPLE\tMAC\tMAC/OS\t4\t\t\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS XP\t15\t\t\r\nMicro\tDELL\tPC\tWINDOWS XP\t15\t\t\r\nPortable\tHP/COMPAQ\tPORTABLE\tWINDOWS XP\t3\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t1\t\t\r\nEcrans plats\tHP/COMPAQ\t\t\t10\t\t\r\nEcrans plats\tDELL\t\t\t7\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tAPPLESHARE\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tAPPLESHARE\t\t\t\t\r\nTechnologie d accès\tSDSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t04\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tHP/COMPAQ\t\t\t\t\t\r\nSwitch\tHP/COMPAQ\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tORACLE\t\t\t\t\t\r\nGpao\tSPECIFIQUE\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tTREND MICRO\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tTOSHIBA\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t12\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\tDAT\t\t\t\t\r\nStockage Software\tCOMPUTER ASSOCIATES\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t76\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 22:53:25.199292	2012-06-14 22:53:25.199292	2	Suspect	02 37 91 36 80	02 37 24 23 04		http://www.lgr-emballages.com	\N
360	FRETIGNE	Zone de Montron		53000	LAVAL	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 43945537900024\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 51\t \tNombre de PC \t: 7\r\nEffectif société \t: 51\t \tActivité \t: Peinture (454J)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 10\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 4\r\n \r\n \r\n \r\n \t\r\n\tContacts\t\r\n \r\n \t\r\nCivilité\tNom\tPrénom\tFonction\tEmail\r\n \r\n  M  \t  FRETIGNE  \t  AUGUSTE  \t  GERANT  \t   \r\nCommentaire:  \r\n  MME  \t  KERVRAN  \t  LUCETTE  \t  DIRECTEUR COMPTABLE  \t   \r\nCommentaire:  \r\n \r\n \r\n   \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tDIVERS\tSERVEUR\tWINDOWS XP\t1\t7\t06\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS XP\t7\t\t\r\nEcrans plats\tHP/COMPAQ\t\t\t3\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tETHERNET\tWINDOWS XP\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t06\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tDIVERS\t\t\t\t\t\r\nSwitch\tDIVERS\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nCompta/Finance\tDIVERS\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tBROTHER\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t3\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 19:03:09.065822	2012-06-17 19:03:09.065822	2	Suspect	02 43 69 60 36	02 43 68 77 35			\N
361	FROMAGERIE VAUBERGNIER	Domaine du Bois Belleray		53470	MARTIGNE SUR MAYENNE	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 73575009300016\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 6\r\nEffectif sur site \t: 100\t \tNombre de PC \t: 40\r\nEffectif société \t: 100\t \tActivité \t: Fabrication de fromages (155C)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 60\t \tNb téléphones fixes \t: 30\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 18\r\n \r\n \r\n \r\n \t\r\n\tContacts\t\r\n \r\n \t\r\nCivilité\tNom\tPrénom\tFonction\tEmail\r\n \r\n  M  \t  DREZEN  \t  JEAN  \t  PRESIDENT DIRECTEUR GENERAL  \t   \r\nCommentaire:  \r\n  M  \t  BOUILLE  \t  FREDERIC  \t  RESPONSABLE INFORMATIQUE  \t   \r\nCommentaire:  \r\n  M  \t  LAIR  \t  JEAN CLAUDE  \t  TECHNICIEN DE MAINTENANCE INFO  \t   \r\nCommentaire:  \r\n  MME  \t  GEESLER  \t  SOPHIE  \t  DIRECTEUR RESSOURCES HUMAINES  \t   \r\nCommentaire:  \r\n  M  \t  FAVRIE  \t  PASCAL  \t  DIRECTEUR PRODUCTION  \t   \r\nCommentaire:  \r\n  M  \t  BRINDEJONC  \t  YANNIK  \t  DIRECTEUR COMPTABLE  \t   \r\nCommentaire:  \r\n  M  \t  GRALL  \t  XAVIER  \t  DIRECTEUR COMMERCIAL  \t   \r\nCommentaire:  \r\n \r\n \r\n   \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t1\t40\t08\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2008\t5\t40\t09\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS XP\t31\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t9\t\t\r\nEcrans plats\tBELINEA/MAXDATA\t\t\t10\t\t\r\nEcrans plats\tDELL\t\t\t6\t\t\r\nEcrans plats\tPHILIPS\t\t\t10\t\t\r\nMobilité\tDIVERS\tPOCKET PC\tSYMBIAN OS\t3\t\t09\r\nMobilité\tNOKIA\tPOCKET PC\tWINDOWS MOBILE\t6\t\t10\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2008\t\t\t\t\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tWINDOWS 2008\t\t\t\t\r\nTechnologie d accès\tFIBRE OPTIQUE\t\t\t\t\t\r\nTechnologie d accès\tSDSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t04\r\nWAN\tVOIP\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tD-LINK\t\t\t\t\t\r\nSwitch\tD-LINK\t\t\t\t\t\r\nSwitch\tHP/COMPAQ\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nGpao\tSPECIFIQUE\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nOutils décisionnel\tSAP/BO\t\t\t\t\t\r\nGED\tDIVERS\tCANON\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nMessagerie\tMDAEMON\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\tDLINK\t\t\t\t\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tXEROX/TEKTRONIX\t\t\t\t\t\r\nImprimantes\tLEXMARK\t\t\t\t\t\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t10\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tHP/COMPAQ\tLTO\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t1000\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t1\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 19:04:28.849099	2012-06-17 19:04:28.849099	2	Suspect	02 43 02 50 01	02 43 02 53 14			\N
306	CATHILD INDUSTRIE	ZI 2, boulevard Fromenteau		72510	MANSIGNE	FRANCE		Barrage secretaire\r\n\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 38343311700017\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 29\t \tNombre de PC \t: 15\r\nEffectif société \t: 29\t \tActivité \t: Fabrication de machines spécialisées diverses (295R)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 14\t \tNb téléphones fixes \t: 12\r\nEffectif BE \t: 3\t \tNb téléphones mobiles \t: 10\r\n \r\n\r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t1\t12\t98\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tFUJITSU/SIEMENS\tPC\tWINDOWS XP\t10\t\t\r\nMicro\tASSEMBLE\tPC\tWINDOWS XP\t2\t\t\r\nPortable\tHP/COMPAQ\tPORTABLE\tWINDOWS XP\t3\t\t\r\nEcrans plats\tDELL\t\t\t12\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nTechnologie d accès\tSDSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t99\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tSFR\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tD-LINK\t\t\t\t\t\r\nSwitch\tD-LINK\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tACCESS\t\t\t\t\t\r\nCfao\tAUTODESK\tAUTOCAD\t\t\t\t\r\nGpao\tSPECIFIQUE\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tDIVERS\t\t\t\t\t\r\nImprimantes\tBROTHER\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t10\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\tTIBCO\t\t1\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 22:56:33.972678	2012-06-14 22:57:47.046351	2	Suspect	02 43 46 15 96	02 43 46 21 81		http://www.cathild.com	\N
307	CAVOL	Les Epinettes		72540	LOUE	FRANCE		Barrage secretaire\r\nHORS CIBLE - GROUPE LDC\r\n \t\r\nAppartient à un groupe \t: Oui\t \tSIRET \t: 44450202500042\r\nGroupe \t: LDC\t \tType Ets \t: Etablissement\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 300\t \tNombre de PC \t: 24\r\nEffectif société \t: 9000\t \tActivité \t: Production de viandes de volaille (151C)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 270\t \tNb téléphones fixes \t: 30\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 10\r\n \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tASSEMBLE\tSERVEUR\tWINDOWS NT\t1\t\t01\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tNEC\tPC\tWINDOWS XP\t21\t\t\r\nMicro\tNEC\tPC\tWINDOWS NT\t1\t\t\r\nPortable\tDIVERS\tPORTABLE\tWINDOWS XP\t2\t\t\r\nEcrans plats\tNEC/MITSUBISHI\t\t\t11\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS NT\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tSDSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nOpérateur Fixe\tSFR\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t03\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tDIVERS\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tDIVERS\t\t\t\t\t\r\nSwitch\tDIVERS\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nCompta/Finance\tDIVERS\tINFOLOGIC\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tLOTUSNOTES\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tDIVERS\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tRICOH\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 23:00:21.395935	2012-06-14 23:00:21.395935	1	Suspect	02 43 88 26 88	02 43 88 45 06		http://www.loue.fr	\N
308	CESSOT DECORATION	14, rue Croix la Comtesse		28400	NOGENT LE ROTROU	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 38089296800013\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 2\r\nEffectif sur site \t: 105\t \tNombre de PC \t: 43\r\nEffectif société \t: 115\t \tActivité \t: Fabrication de serrures et ferrures (286F)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 16\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 12\r\n \r\n\r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2000\t2\t35\t05\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDIVERS\tPC\tWINDOWS 98\t3\t\t\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS XP\t33\t\t\r\nPortable\tHP/COMPAQ\tPORTABLE\tWINDOWS XP\t4\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t3\t\t\r\nEcrans plats\tHP/COMPAQ\t\t\t20\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2000\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t\r\nWAN\tTRANSPAC\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tZYXEL\t\t\t\t\t\r\nSwitch\t3COM\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nCfao\tAUTODESK\tAUTOCAD\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tWEB\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nAntivirus\tAVG\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 23:14:27.362881	2012-06-14 23:16:04.050047	2	Suspect	02 37 53 42 00	02 37 52 24 23		http://www.cessot.decoration.fr	\N
309	CGMP	24, rue de la Mairie		72160	TUFFE	FRANCE		M. Bignon ne souhaite pas me parler. Sa secrétaire me dit qu'il a ce qu'il faut côté fournisseurs\r\n\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 38403095300028\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 8\r\nEffectif sur site \t: 150\t \tNombre de PC \t: 60\r\nEffectif société \t: 150\t \tActivité \t: Fabrication d'articles en papier à usage sanitaire ou (212E)\r\nEffectif informatique \t: 3\t \tNb sites interconnectés \t: 2\r\nEffectif Production \t: 80\t \tNb téléphones fixes \t: 50\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 15\r\n \r\n \r\n \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t8\t50\t09\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tACER\tPC\tWINDOWS XP\t50\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t10\t\t\r\nEcrans plats\tACER\t\t\t50\t\t\r\nMobilité\tBLACKBERRY\tPDA\tRIM\t8\t\t08\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t\r\nWAN\tFRAME RELAY\t\t\t\t\t\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tINFORMIX/IBM\t\t\t\t\t\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nErp\tSAP\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tEXCHANGE\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tMCAFEE\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tEPSON\t\t\t\t\t\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tBROTHER\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t20\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\tDLT\t\t\t\t\r\nStockage Hardware\tDIVERS\tLTO\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t800\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t1\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 23:20:10.472494	2012-06-14 23:20:10.472494	2	Suspect	02 43 60 11 10	02 43 60 13 96		http://www.cgmp.fr	\N
310	AMEN								m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-15 12:14:04.60828	2012-06-15 12:14:04.60828	4	Fournisseur	08 11 88 77 66				\N
311	CHAMBRE D AGRICULTURE	10, rue Dieudonné Costes		28024	CHARTRES CEDEX	FRANCE		Appartient à un groupe \t: Oui\t \tSIRET \t: 18280003700018\r\nGroupe \t: MINISTERE DE L AGRICULTURE\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 8\r\nEffectif sur site \t: 60\t \tNombre de PC \t: 75\r\nEffectif société \t: 64\t \tActivité \t: Organisations patronales et consulaires (911A)\r\nEffectif informatique \t: 2\t \tNb sites interconnectés \t: 2\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 200\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 27\r\n \r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tLINUX\t2\t65\t05\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2000\t3\t65\t08\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2003\t2\t65\t06\r\nServeurs micro\tDELL\tSERVEUR\tLINUX\t1\t65\t05\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t65\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t10\t\t\r\nEcrans plats\tDELL\t\t\t65\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2000\t\t\t\t\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tAASTRA/MATRA TELECOM\t\t\t\t\t\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tILIAD\tALICE\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\t3COM\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tORACLE\t\t\t\t\t\r\nSgbd\tACCESS\t\t\t\t\t\r\nCompta/Finance\tSPECIFIQUE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tDIVERS\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\tLINUX\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tMCAFEE\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t15\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t1\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 13:08:36.672327	2012-06-16 13:08:36.672327	2	Suspect	02 37 24 45 45	02 37 24 45 90		http://www.eure-et-loir.chambagri.fr	\N
312	CHAMBRE D AGRICULTURE DE LAVAL	Parc Technopole rue Albert Einstein BP 36155 CHANGE		53061	LAVAL CEDEX 9	FRANCE		Appartient à un groupe \t: Oui\t \tSIRET \t: 18530045600026\r\nGroupe \t: MINISTERE DE L AGRICULTURE\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 2\r\nEffectif sur site \t: 50\t \tNombre de PC \t: 70\r\nEffectif société \t: 70\t \tActivité \t: Organisations patronales et consulaires (911A)\r\nEffectif informatique \t: 3\t \tNb sites interconnectés \t: 3\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 150\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 0\r\n \r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t2\t35\t08\r\nOs virtualisation\tWINDOWS 2003\t\t\t1\t\t\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tNEC\tPC\tWINDOWS XP\t35\t\t\r\nPortable\tNEC\tPORTABLE\tWINDOWS XP\t35\t\t\r\nEcrans plats\tNEC/MITSUBISHI\t\t\t35\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tSDSL\t\t\t\t\t\r\nOpérateur Fixe\tSFR\t\t\t\t\t\r\nPABX/IPBX\tAASTRA/MATRA TELECOM\t\t\t\t\t06\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tHP/COMPAQ\t\t\t\t\t\r\nSwitch\tHP/COMPAQ\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tORACLE\t\t\t\t\t\r\nCompta/Finance\tSPECIFIQUE\t\t\t\t\t\r\nOutils décisionnel\tSAP/BO\t\t\t\t\t\r\nCRM\tSPECIFIQUE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tLOTUSNOTES\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tSOPHOS\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t19\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tHP/COMPAQ\t\t\t\t\t\r\nStockage Software\tATEMPO\tTIME NAVIGATOR\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t450\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 13:37:40.713369	2012-06-16 13:37:40.713369	2	Suspect	02 43 67 37 00	02 43 67 38 99		http://www.chambreagrimayenne.fr	\N
313	CHAMBRE D AGRICULTURE	52 Boulevard du 1er chasseur		61000	ALENCON	FRANCE		Appartient à un groupe \t: Oui\t \tSIRET \t: 18610004600017\r\nGroupe \t: MINISTERE DE L AGRICULTURE\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 8\r\nEffectif sur site \t: 60\t \tNombre de PC \t: 91\r\nEffectif société \t: 80\t \tActivité \t: Organisations patronales et consulaires (911A)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 3\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 35\r\nEffectif BE \t: 4\t \tNb téléphones mobiles \t: 20\r\n \r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t8\t80\t08\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS XP\t40\t\t\r\nMicro\tDELL\tPC\tWINDOWS XP\t20\t\t\r\nPortable\tACER\tPORTABLE\tWINDOWS XP\t5\t\t\r\nPortable\tTOSHIBA\tPORTABLE\tWINDOWS XP\t20\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t6\t\t\r\nEcrans plats\tHP/COMPAQ\t\t\t40\t\t\r\nEcrans plats\tDELL\t\t\t20\t\t\r\nMobilité\tPALM\tPDA\tPALM/OS\t20\t\t09\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tGIGA ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nTechnologie d accès\tBLR\t\t\t\t\t\r\nTechnologie d accès\tRESEAU HERTZIEN\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nOpérateur Fixe\tSFR\t\t\t\t\t\r\nOpérateur Fixe\tILIAD\tALTITUDE TELECOM\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t09\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nWAN\tGLOBAL INTRANET\t\t\t\t\t\r\nWAN\tVOIP\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nOpérateur Mobile\tBOUYGUES\t\t\t\t\t\r\nFourniss. Accès Internet\tILIAD\tALTITUDE TELECOM\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tHP/COMPAQ\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tORACLE\t\t\t\t\t\r\nSgbd\tWINDEV\t\t\t\t\t\r\nSgbd\tHYPERFILE\t\t\t\t\t\r\nCfao\tAUTODESK\tAUTOCAD\t\t\t\t\r\nCompta/Finance\tSPECIFIQUE\t\t\t\t\t\r\nOutils décisionnel\tSAP/BO\t\t\t\t\t\r\nGED\tSPECIFIQUE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tEXCHANGE\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tCHECK POINT\t\t\t\t\t\r\nAntivirus\tNOD 32\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tKONICA/MINOLTA\t\t\t\t\t\r\nImprimantes\tBROTHER\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tDELL\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t12\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\tLTO\t\t\t\t\r\nStockage Software\tCOMPUTER ASSOCIATES\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t1000\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t1	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 13:47:16.324228	2012-06-16 13:47:16.324228	2	Suspect	02 33 31 48 00	02 33 29 47 99		http://www.orne.chambagri.fr	\N
314	CHAMBRE DE COMMERCE ET INDUSTRIE	5 avenue marcel proust BP 20062		28002	CHARTRES CEDEX	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 18280001100104\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 6\r\nEffectif sur site \t: 67\t \tNombre de PC \t: 141\r\nEffectif société \t: 67\t \tActivité \t: Organisations patronales et consulaires (911A)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 1\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 60\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 20\r\n \r\n \r\n Les serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2003\t5\t60\t06\r\nServeurs micro\tDELL\tSERVEUR\tLINUX\t1\t60\t01\r\nVirtualisation\tDELL\tVMWARE\t\t1\t60\t08\r\nOs virtualisation\tWINDOWS 2003\t\t\t1\t\t\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDIVERS\tPC\tWINDOWS XP\t120\t\t\r\nMicro\tDIVERS\tPC\tWINDOWS 2000\t1\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t20\t\t\r\nEcrans plats\tDIVERS\t\t\t120\t\t\r\nMobilité\tAPPLE\tIPHONE\tIPHONE OS\t4\t\t09\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nTechnologie d accès\tFIBRE OPTIQUE\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t04\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tSMC/NETWORKS\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tORACLE\t\t\t\t\t\r\nCompta/Finance\tSPECIFIQUE\t\t\t\t\t\r\nOutils décisionnel\tSAP/BO\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tEXCHANGE\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFORTINET\t\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tDIVERS\t\t\t\t\t\r\nAntivirus\tTREND MICRO\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tKYOCERA/MITA\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tSHARP\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t15\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDELL\t\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t800\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t1	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 13:53:19.69979	2012-06-16 13:53:19.69979	2	Suspect	02 37 84 28 28	02 37 84 28 29		http://www.eureetloire.cci.fr	\N
315	CHAMBRE DES METIERS	39 quai Gambetta BP 30227		53002	LAVAL CEDEX	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 18530043100037\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 0\r\nEffectif sur site \t: 43\t \tNombre de PC \t: 35\r\nEffectif société \t: 60\t \tActivité \t: Organisations patronales et consulaires (911A)\r\nEffectif informatique \t: 2\t \tNb sites interconnectés \t: 2\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 30\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 5\r\n \r\n\r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nVirtualisation\tHP/COMPAQ\tVMWARE\t\t4\t\t10\r\nOs virtualisation\tWINDOWS 2003\t\t\t1\t\t\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDIVERS\tPC\tWINDOWS 7\t1\t\t\r\nMicro\tFUJITSU/SIEMENS\tPC\tWINDOWS XP\t30\t\t\r\nPortable\tHP/COMPAQ\tPORTABLE\tWINDOWS 7\t4\t\t\r\nEcrans plats\tDIVERS\t\t\t30\t\t\r\nEcrans plats\tFUJITSU/SIEMENS\t\t\t10\t\t\r\nEcrans plats\tIIYAMA\t\t\t10\t\t\r\nMobilité\tBLACKBERRY\tPDA\tRIM\t3\t\t11\r\nMobilité\tAPPLE\tIPHONE\tIPHONE OS\t2\t\t11\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t03\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tZYXEL\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tACCESS\t\t\t\t\t\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nCompta/Finance\tDIVERS\tLINEAL\t\t\t\t\r\nCompta/Finance\tDIVERS\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tSONICWALL\t\t\t\t\t\r\nAntivirus\tF SECURE\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tEPSON\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t14\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tHP/COMPAQ\tLTO\t\t\t\t\r\nStockage Software\tCOMPUTER ASSOCIATES\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t800\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 14:04:03.042265	2012-06-16 14:04:03.042265	2	Suspect	02 43 49 88 88	02 43 49 88 99		http://www.cm-laval.fr	\N
316	CHASTAGNER DELAIZE INDUSTRIELLE	ZI Du Joncheray route de Mamers\t		72400	LA FERTE BERNARD	FRANCE		HORS CIBLE\r\nPortable M. Rosillette : 06 89 51 24 79\r\nClient Oceanet\r\n\r\n\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 38019479500015\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 5\r\nEffectif sur site \t: 90\t \tNombre de PC \t: 80\r\nEffectif société \t: 250\t \tActivité \t: Mécanique générale (285D)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 2\r\nEffectif Production \t: 65\t \tNb téléphones fixes \t: 30\r\nEffectif BE \t: 7\t \tNb téléphones mobiles \t: 15\r\n Les serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t5\t80\t09\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tASSEMBLE\tPC\tWINDOWS XP\t70\t\t\r\nPortable\tHP/COMPAQ\tPORTABLE\tWINDOWS XP\t10\t\t\r\nEcrans plats\tLG/GOLDSTAR\t\t\t25\t\t\r\nEcrans plats\tHYUNDAI\t\t\t20\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nTechnologie d accès\tFIBRE OPTIQUE\t\t\t\t\t\r\nOpérateur Fixe\tSFR\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t05\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tSFR\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nCfao\tDIVERS\tTHINK\t\t\t\t\r\nCfao\tCATIA\t\t\t\t\t\r\nCfao\tMISSLER\t\t\t\t\t\r\nGpao\tMISSLER\t\t\t\t\t\r\nCompta/Finance\tCEGID\tCCMX\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tCISCO\t\t\t\t\t\r\nAntivirus\tSOPHOS\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t20\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\tLTO\t\t\t\t\r\nStockage Software\tCOMPUTER ASSOCIATES\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t420\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 14:15:18.683793	2012-06-16 14:15:18.683793	2	Suspect	02 43 60 11 88	02 43 93 33 55		http://www.groupechastagner.fr/	\N
317	CIMEL	ZA de Voutre		53600	VOUTRE	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 45087547100028\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 2\r\nEffectif sur site \t: 68\t \tNombre de PC \t: 23\r\nEffectif société \t: 68\t \tActivité \t: Assemblage de cartes électroniques pour compte de tiers (321D)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 41\t \tNb téléphones fixes \t: 30\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 10\r\n \r\n \r\n Les serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2003\t2\t23\t07\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t20\t\t\r\nPortable\tTOSHIBA\tPORTABLE\tWINDOWS XP\t3\t\t\r\nEcrans plats\tDELL\t\t\t20\t\t\r\nMobilité\tBLACKBERRY\tPDA\tRIM\t1\t\t08\r\nMobilité\tPALM\tPDA\tPALM/OS\t2\t\t06\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t07\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nWAN\tVOIP\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tFUNKWERK\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nGpao\tSPECIFIQUE\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tMCAFEE\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tTOSHIBA\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t13\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t400\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 14:20:26.548446	2012-06-16 14:20:26.548446	2	Suspect	02 43 91 05 43	02 43 91 05 44		http://www.cimel.eu	\N
318	CLAIRCELL CLASSEMENT	ZI route de Chartres		28160	BROU	FRANCE		Appartient à un groupe \t: Oui\t \tSIRET \t: 43235735800014\r\nGroupe \t: EXACOMPTA CLAIREFONTAINE\t \tType Ets \t: Siege\r\nSite informatique distant \t: Oui\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 68\t \tNombre de PC \t: 38\r\nEffectif société \t: 68\t \tActivité \t: Autre imprimerie (labeur) (222C)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 1\r\nEffectif Production \t: 50\t \tNb téléphones fixes \t: 60\r\nEffectif BE \t: 2\t \tNb téléphones mobiles \t: 5\r\n \r\n \r\n Les serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2003\t1\t30\t09\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t33\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t5\t\t\r\nEcrans plats\tDELL\t\t\t33\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tSDSL\t\t\t\t\t\r\nOpérateur Fixe\tSFR\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t08\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tHP/COMPAQ\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nCfao\tAUTODESK\tAUTOCAD\t\t\t\t\r\nErp\tSAP\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMessagerie\tEXCHANGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tTREND MICRO\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tKONICA/MINOLTA\t\t\t\t\t\r\nImprimantes\tBROTHER\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t12\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\tLTO\t\t\t\t\r\nStockage Software\tCOMPUTER ASSOCIATES\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t72\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 14:24:03.564073	2012-06-16 14:24:03.564073	2	Suspect	02 37 44 49 49	02 37 96 06 79			\N
319	COLART INTERNATIONAL	5 rue René Panhard		72021	LE MANS CEDEX 2	FRANCE		Envoyer courriel a M. Ollier virtualisation et stockage\r\nInjoignable...\r\n\r\n\r\nAppartient à un groupe \t: Oui\t \tSIRET \t: 57665039400017\r\nGroupe \t: COLART\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 20\r\nEffectif sur site \t: 250\t \tNombre de PC \t: 197\r\nEffectif société \t: 250\t \tActivité \t: Fabrication de peintures et vernis (243Z)\r\nEffectif informatique \t: 3\t \tNb sites interconnectés \t: 2\r\nEffectif Production \t: 120\t \tNb téléphones fixes \t: 150\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 30\r\n Les serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs mini\tIBM\tISERIES\tOS 400\t1\t200\t05\r\nServeurs micro\tDELL\tSERVEUR\tLINUX\t4\t200\t05\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2003\t14\t200\t08\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2008\t1\t200\t09\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t150\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t45\t\t\r\nStation de travail\tDELL\tWORKSTATION\tWINDOWS XP\t2\t\t07\r\nEcrans plats\tDELL\t\t\t150\t\t\r\nMobilité\tAPPLE\tIPHONE\tIPHONE OS\t8\t\t09\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2008\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tWINDOWS 2008\t\t\t\t\r\nTechnologie d accès\tFIBRE OPTIQUE\t\t\t\t\t\r\nOpérateur Fixe\tSFR\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t09\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nWAN\tVOIP\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tSFR\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tDB2/BAS400\t\t\t\t\t\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nErp\tMOVEX\t\t\t\t\t\r\nOutils décisionnel\tIBM/COGNOS\t\t\t\t\t\r\nCRM\tKDP INFORMATIQUE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tEXCHANGE\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tCISCO\t\t\t\t\t\r\nFirewall\tMICROSOFT\t\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tMCAFEE\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tRICOH\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t20\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDELL\tNAS\t\t\t\t\r\nStockage Hardware\tDELL\tBAIE\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t6000\t\t	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 14:32:24.530339	2012-06-16 14:36:10.232591	2	Suspect	02 43 83 83 00	02 43 83 83 09		http://www.lefranc-bourgeois.com	\N
320	COMPEDIT BEAUREGARD	ZI Beauregard		61600	LA FERTE MACE	FRANCE		Essaye de faire travailler en informatique ses propres clients\r\nLui envoyer un mail demain\r\nConnait ITF\r\n\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 30902475000015\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 3\r\nEffectif sur site \t: 70\t \tNombre de PC \t: 35\r\nEffectif société \t: 70\t \tActivité \t: Autre imprimerie (labeur) (222C)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 70\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 3\r\n \r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t3\t30\t07\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tAPPLE\tMAC\tMAC/OS\t10\t\t\r\nMicro\tNEC\tPC\tWINDOWS XP\t22\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t3\t\t\r\nEcrans plats\tAPPLE\t\t\t8\t\t\r\nEcrans plats\tNEC/MITSUBISHI\t\t\t22\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tFIBRE OPTIQUE\t\t\t\t\t\r\nTechnologie d accès\tSDSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t05\r\nWAN\tVOIP\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tDIVERS\t\t\t\t\t\r\nSwitch\tHP/COMPAQ\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tACCESS\t\t\t\t\t\r\nSgbd\t4D\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tEXCHANGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tTREND MICRO\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t12\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tHP/COMPAQ\t\t\t\t\t\r\nStockage Hardware\tHP/COMPAQ\tLTO\t\t\t\t\r\nStockage Software\tCOMPUTER ASSOCIATES\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t400\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 22:28:34.936913	2012-06-16 22:28:54.229246	2	Suspect	02 33 37 08 33	02 33 37 25 36		http://www.compedit-beauregard.fr	\N
321	CONSTRUCTIONS B FOURNIGAULT	Lieu dit le bas Palluau		72650	LA CHAPELLE SAINT AUBIN	FRANCE		Client visité\r\nFournisseurs bien installés\r\nVa revoir sa téléphonie dans 12 mois\r\nPense virtualiser ses serveurs dans 2 ans\r\nA inviter à la journée virtualisation en septembre\r\n\r\n\r\nAppartient à un groupe \t: Oui\t \tSIRET \t: 31427109900058\r\nGroupe \t: ELYSSA\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 4\r\nEffectif sur site \t: 250\t \tNombre de PC \t: 40\r\nEffectif société \t: 250\t \tActivité \t: Travaux de maçonnerie générale (452V)\r\nEffectif informatique \t: 2\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 50\r\nEffectif BE \t: 15\t \tNb téléphones mobiles \t: 35\r\n \r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tNAS\tWINDOWS 2003\t1\t\t08\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t2\t\t08\r\nServeurs micro\tASSEMBLE\tSERVEUR\tWINDOWS 2003\t1\t32\t06\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS XP\t38\t\t\r\nPortable\tASUS\tPORTABLE\tWINDOWS VISTA\t2\t\t\r\nEcrans plats\tHP/COMPAQ\t\t\t38\t\t\r\nMobilité\tBLACKBERRY\tPDA\tRIM\t2\t\t09\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nTechnologie d accès\tFIBRE OPTIQUE\t\t\t\t\t\r\nOpérateur Fixe\tDIVERS\tSMART TELECOM\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t10\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tDIVERS\t\t\t1\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tHP/COMPAQ\t\t\t\t\t\r\nSwitch\tHP/COMPAQ\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nCfao\tAUTODESK\tAUTOCAD\t\t\t\t\r\nErp\tDIVERS\t\t\t\t\t\r\nErp\tCEGID/CCMX\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tARKOON NS\t\t\t\t\t\r\nAntivirus\tF SECURE\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t4\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\tNAS\t\t\t\t\r\nStockage Hardware\tHP/COMPAQ\t\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t1800\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 22:31:50.582286	2012-06-16 22:31:50.582286	2	Suspect	02 43 24 10 64	02 43 28 80 87		http://www.elyssa.fr	\N
322	CONSTRUCTIONS GHIZZO	Route de Paris BP 142		61204	ARGENTAN CEDEX	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 31934621900037\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 70\t \tNombre de PC \t: 11\r\nEffectif société \t: 70\t \tActivité \t: Travaux de maçonnerie générale (452V)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 10\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 7\r\n \r\n \r\n Les serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tFUJITSU/SIEMENS\tSERVEUR\tWINDOWS 2003\t1\t10\t05\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tFUJITSU/SIEMENS\tPC\tWINDOWS XP\t10\t\t\r\nPortable\tFUJITSU/SIEMENS\tPORTABLE\tWINDOWS XP\t1\t\t\r\nEcrans plats\tFUJITSU/SIEMENS\t\t\t10\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tFUNKWERK\t\t\t\t\t\r\nSwitch\tD-LINK\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nCompta/Finance\tDIVERS\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nAntivirus\tVIGUARD\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tEPSON\t\t\t\t\t\r\nImprimantes\tTOSHIBA\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t10\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 22:34:34.905566	2012-06-16 22:34:34.905566	1	Suspect	02 33 67 35 32	02 33 36 95 57			\N
323	CONSTRUCTIONS METALLIQUES	67, avenue Coursimault		72120	SAINT CALAIS	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 57645064700010\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 57\t \tNombre de PC \t: 15\r\nEffectif société \t: 57\t \tActivité \t: Fabrication de constructions métalliques (281A)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 0\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 0\r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tDIVERS\tSERVEUR\tWINDOWS 2003\t1\t\t08\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDIVERS\tPC\tWINDOWS XP\t15\t\t\r\n   \r\n\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 22:36:41.307579	2012-06-16 22:36:41.307579	2	Suspect	02 43 35 00 70	02 43 35 83 79			\N
324	COOP D INSEMINATION ANIMALE	38, rue de la Merilliere		61300	L AIGLE	FRANCE		Rappeler M. de Preaumont en novembre\r\n\r\n\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 78096047200014\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 30\t \tNombre de PC \t: 37\r\nEffectif société \t: 87\t \tActivité \t: Services annexes à l'élevage (014D)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 12\t \tNb téléphones fixes \t: 15\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 15\r\n \r\n\r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2003\t1\t35\t09\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t22\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t15\t\t\r\nEcrans plats\tDELL\t\t\t22\t\t\r\nMobilité\tHP/COMPAQ\tPDA\tWINDOWS CE\t60\t\t07\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tSFR\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tHP/COMPAQ\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tACCESS\t\t\t\t\t\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nGpao\tSPECIFIQUE\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tEPSON\t\t\t\t\t\r\nImprimantes\tKYOCERA/MITA\t\t\t\t\t\r\nImprimantes\tOKI\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t10\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\nStockage Hardware\tDIVERS\tLTO\t\t\t\t\r\nStockage Software\tCOMPUTER ASSOCIATES\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t72\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t1\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 22:39:34.954917	2012-06-16 22:41:02.416262	2	Suspect	02 33 84 48 84	02 33 84 48 90		http://www.cia-laigle.com	\N
326	COUVOIRS MAINE ET NORMANDIE	Chemin de la Pointe		72440	VOLNAY	FRANCE		HORS CIBLE\r\n\r\nDecision groupe infra et telecoms\r\n\r\nAppartient à un groupe \t: Oui\t \tSIRET \t: 78637231800018\r\nGroupe \t: GRELIER\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 2\r\nEffectif sur site \t: 150\t \tNombre de PC \t: 31\r\nEffectif société \t: 200\t \tActivité \t: Elevage d'autres animaux (012J)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 5\r\nEffectif Production \t: 130\t \tNb téléphones fixes \t: 20\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 30\r\n \r\n\r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2003\t1\t30\t03\r\nServeurs micro\tDELL\tTSE\tWINDOWS 2003\t1\t30\t06\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tNEC\tPC\tWINDOWS XP\t26\t\t\r\nPortable\tDIVERS\tPORTABLE\tWINDOWS XP\t5\t\t\r\nEcrans plats\tACER\t\t\t10\t\t\r\nEcrans plats\tNEC/MITSUBISHI\t\t\t16\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nTechnologie d accès\tSDSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nOpérateur Fixe\tSFR\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t02\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nWAN\tEQUANT\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tFUNKWERK\t\t\t\t\t\r\nSwitch\tHP/COMPAQ\t\t\t\t\t\r\nSwitch\tNETGEAR\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tACCESS\t\t\t\t\t\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tBITDEFENDER\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tEPSON\t\t\t\t\t\r\nImprimantes\tBROTHER\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t6\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\tLTO\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t200\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 22:43:18.193566	2012-06-16 22:45:10.403211	2	Suspect	02 43 63 11 00	02 43 35 69 34			\N
327	CROISEES PLAST	7, avenue Saint Exupéry		41100	SAINT OUEN	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 31938094500026\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 48\t \tNombre de PC \t: 24\r\nEffectif société \t: 48\t \tActivité \t: Fabrication d'éléments en matières plastiques pour la (252E)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 15\t \tNb téléphones fixes \t: 20\r\nEffectif BE \t: 6\t \tNb téléphones mobiles \t: 10\r\n \r\n \r\n Les serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2003\t1\t24\t07\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t20\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t4\t\t\r\nEcrans plats\tDELL\t\t\t20\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t02\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tDIVERS\tSAGEM\t\t\t\t\r\nSwitch\tNETGEAR\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tACCESS\t\t\t\t\t\r\nCfao\tDIVERS\tARCHICAD\t\t\t\t\r\nGpao\tSPECIFIQUE\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tNOD 32\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t7\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tHP/COMPAQ\t\t\t\t\t\r\nStockage Software\tCOMPUTER ASSOCIATES\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t72\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 22:46:44.389491	2012-06-16 22:46:44.389491	2	Suspect	02 54 73 37 00	02 54 73 37 09			\N
328	JANVIER	Route des Chênes Secs		53940	LE GENEST SAINT ISLE	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 34066307900010\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 110\t \tNombre de PC \t: 110\r\nEffectif société \t: 110\t \tActivité \t: Services annexes à l'élevage (014D)\r\nEffectif informatique \t: 3\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 10\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 12\r\n \r\n \r\n \r\n\r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t1\t12\t08\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS XP\t10\t\t\r\nPortable\tHP/COMPAQ\tPORTABLE\tWINDOWS XP\t100\t\t\r\nEcrans plats\tHP/COMPAQ\t\t\t10\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t09\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nWAN\tVOIP\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tD-LINK\t\t\t\t\t\r\nSwitch\tD-LINK\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tACCESS\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tKONICA/MINOLTA\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t2\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\tDAT\t\t\t\t\r\nStockage Software\tCOMPUTER ASSOCIATES\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t3000\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 22:49:51.460061	2012-06-16 22:49:51.460061	2	Suspect	02 43 02 11 91	02 43 02 00 15		http://www.janviereurope.com	\N
329	DAS ASSURANCES MUTUELLES	33, rue de Sydney		72045	LE MANS CEDEX 2	FRANCE		HORS CIBLE\r\nExpression des besoins auprès des MMA qui gèrent les achats.\r\nAucun DDL\r\n\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 22:53:43.637966	2012-06-16 22:53:43.637966	2	Suspect	02 43 47 54 00	02 43 47 57 07	http://www.ladas.fr		\N
330	DEC	Chemin des roses		41170	CORMENON	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 77569239500038\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 2\r\nEffectif sur site \t: 100\t \tNombre de PC \t: 39\r\nEffectif société \t: 100\t \tActivité \t: Traitement et revêtement des métaux (285A)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 60\t \tNb téléphones fixes \t: 35\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 5\r\n \r\n \r\n \r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t2\t20\t08\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t35\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t4\t\t\r\nEcrans plats\tDELL\t\t\t35\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tAASTRA/MATRA TELECOM\t\t\t\t\t02\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tFUNKWERK\t\t\t\t\t\r\nSwitch\tDIVERS\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tEXCHANGE\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tTALLY GENICOM\t\t\t\t\t\r\nImprimantes\tEPSON\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t10\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\tDAT\t\t\t\t\r\nStockage Hardware\tDIVERS\tLTO\t\t\t\t\r\nStockage Software\tHP\tDATA PROTECTOR\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t200\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 22:56:04.624876	2012-06-16 22:56:04.624876	2	Suspect	02 54 73 45 40	02 54 73 45 49		http://www.dec-sa.fr	\N
331	DELABOUDINIERE	30, boulevard Pierre Lefaucheux		72100	LE MANS	FRANCE		virtualise chez Mixtrio. Acces internet depuis 2011 chez Sarthe Telecom\r\n\r\nAppartient à un groupe \t: Oui\t \tSIRET \t: 33135772300021\r\nGroupe \t: SADRIN ET RAPIN\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 4\r\nEffectif sur site \t: 54\t \tNombre de PC \t: 63\r\nEffectif société \t: 134\t \tActivité \t: Installation d'eau et de gaz (453E)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 1\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 21\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 45\r\n \r\n \r\n Les serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs mini\tIBM\tISERIES\tOS 400\t1\t50\t07\r\nServeurs micro\tIBM\tTSE\tWINDOWS 2003\t1\t50\t07\r\nServeurs micro\tIBM\tTSE\tWINDOWS 2000\t2\t50\t02\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tWYSE\tTW\tWINDOWS CE\t30\t\t\r\nMicro\tDELL\tPC\tWINDOWS XP\t23\t\t\r\nPortable\tIBM/LENOVO\tPORTABLE\tWINDOWS XP\t3\t\t\r\nPortable\tFUJITSU/SIEMENS\tPORTABLE\tWINDOWS 2000\t3\t\t\r\nPortable\tSONY\tPORTABLE\tWINDOWS XP\t4\t\t\r\nEcrans plats\tDIVERS\t\t\t55\t\t\r\nMobilité\tBLACKBERRY\tPDA\tRIM\t2\t\t10\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2000\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nTechnologie d accès\tFIBRE OPTIQUE\t\t\t\t\t\r\nOpérateur Fixe\tSFR\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t07\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tFUNKWERK\t\t\t\t\t\r\nSwitch\t3COM\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tDB2/BAS400\t\t\t\t\t\r\nCompta/Finance\tSPECIFIQUE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tSOPHOS\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tKONICA/MINOLTA\t\t\t\t\t\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tBROTHER\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t30\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\tDAT\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t1000\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 22:59:26.602142	2012-06-16 22:59:26.602142	2	Prospect	02 43 84 50 50	02 43 72 72 45			\N
332	DELTA COMPOSANTS	ZA des Ajeux		72400	LA FERTE BERNARD	FRANCE		Appartient à un groupe \t: Oui\t \tSIRET \t: 34484433700032\r\nGroupe \t: DELTA\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 5\r\nEffectif sur site \t: 200\t \tNombre de PC \t: 121\r\nEffectif société \t: 250\t \tActivité \t: Fabrication de composants électroniques actifs (321C)\r\nEffectif informatique \t: 4\t \tNb sites interconnectés \t: 1\r\nEffectif Production \t: 100\t \tNb téléphones fixes \t: 0\r\nEffectif BE \t: 5\t \tNb téléphones mobiles \t: 0\r\n \r\n \r\n Les serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2003\t4\t70\t05\r\nServeurs micro\tASSEMBLE\tSERVEUR\tLINUX\t1\t70\t06\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tASSEMBLE\tPC\tWINDOWS XP\t76\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t45\t\t\r\nEcrans plats\tDELL\t\t\t30\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nTechnologie d accès\tRESEAU HERTZIEN\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t\r\nOpérateur Mobile\tBOUYGUES\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tALCATEL\t\t\t\t\t\r\nSwitch\t3COM\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tACCESS\t\t\t\t\t\r\nSgbd\tMY SQL\t\t\t\t\t\r\nCfao\tAUTODESK\tAUTOCAD\t\t\t\t\r\nGpao\tSPECIFIQUE\t\t\t\t\t\r\nCompta/Finance\tCIEL\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tLOCAL\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tZYXEL\t\t\t\t\t\r\nAntivirus\tTREND MICRO\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tBROTHER\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t20\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:02:12.758926	2012-06-16 23:02:12.758926	2	Suspect	02 43 71 65 10	02 43 71 65 11		http://www.dic.fr/	\N
224	DESFIS	ZI de la Taille	Route de Courcemont	72110	BONNÉTABLE	FRANCE		 \t\r\nAppartient à un groupe \t: Oui\t \tSIRET \t: 35172220200014\r\nGroupe \t: DANISH CROWN\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 2\r\nEffectif sur site \t: 100\t \tNombre de PC \t: 23\r\nEffectif société \t: 100\t \tActivité \t: Production de viandes de boucherie (151A)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 85\t \tNb téléphones fixes \t: 12\r\nEffectif BE \t: 1\t \tNb téléphones mobiles \t: 5\r\n \r\n \r\n Les serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tIBM\tSERVEUR\tWINDOWS 2003\t2\t16\t06\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS XP\t7\t\t\r\nMicro\tIBM/LENOVO\tPC\tWINDOWS XP\t13\t\t\r\nPortable\tIBM/LENOVO\tPORTABLE\tWINDOWS XP\t3\t\t\r\nEcrans plats\tHP/COMPAQ\t\t\t11\t\t\r\nEcrans plats\tDELL\t\t\t9\t\t\r\nMobilité\tDIVERS\tPDA\tWINDOWS MOBILE\t7\t\t06\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tSDSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nSgbd\tWINDEV\t\t\t\t\t\r\nGpao\tSPECIFIQUE\t\t\t\t\t\r\nErp\tMICROSOFT BS\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tEXCHANGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tMCAFEE\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tBROTHER\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t10\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tIBM\t\t\t\t\t\r\n   \r\n	g.guivarch@sigire.fr	g.forestier@sigire.fr	2012-05-24 14:17:15.204877	2012-06-16 23:04:18.112724	2	Prospect	02 43 29 71 64	02 43 29 64 51			\N
333	DROUAULT	84, rue Constant Drouault		72018	LE MANS CEDEX 2	FRANCE		Achat infra par le groupe\r\nLien internet : SFR\r\nTéléphonie mobile : SFR\r\nLe tout géré par le groupe\r\n\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 57565005600014\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 4\r\nEffectif sur site \t: 100\t \tNombre de PC \t: 61\r\nEffectif société \t: 160\t \tActivité \t: Fabrication de petits articles textiles de literie (174B)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 2\r\nEffectif Production \t: 80\t \tNb téléphones fixes \t: 20\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 5\r\n \r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tTSE\tWINDOWS 2000\t1\t25\t04\r\nServeurs micro\tHP/COMPAQ\tTSE\tWINDOWS 2003\t3\t\t06\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDIVERS\tTW\tWINDOWS CE\t30\t\t\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS CE\t30\t\t\r\nPortable\tHP/COMPAQ\tPORTABLE\tWINDOWS XP\t1\t\t\r\nEcrans plats\tHP/COMPAQ\t\t\t60\t\t\r\nMobilité\tBLACKBERRY\tPDA\tRIM\t1\t\t10\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2000\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nTechnologie d accès\tLL 1024K\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tNERIM\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tALCATEL\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nSwitch\tALCATEL\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nGpao\tSILOG\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tMCAFEE\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tLEXMARK\t\t\t\t\t\r\nImprimantes\tKONICA/MINOLTA\t\t\t\t\t\r\nImprimantes\tKYOCERA/MITA\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tDELL\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t10\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\nStockage Software\tSTOCKAGE SOFTWARE\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t1000	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:06:31.888561	2012-06-16 23:06:31.888561	2	Suspect	 02 43 43 65 65	02 43 28 20 16		http://www.drouault.fr	\N
334	DROUIN	Lieu dit l'Ange Marie		72290	MEZIERES SUR PONTHOUIN	FRANCE		Envoyer mail presentation a sasrouin@drouin.fr . A l'attantion de M Pioger\r\n\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 35280274800025\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Oui\t \tNombre de Serveurs \t: 0\r\nEffectif sur site \t: 140\t \tNombre de PC \t: 28\r\nEffectif société \t: 140\t \tActivité \t: Fabrication d'emballages en bois (204Z)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 130\t \tNb téléphones fixes \t: 30\r\nEffectif BE \t: 1\t \tNb téléphones mobiles \t: 10\r\n \r\n\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tASSEMBLE\tPC\tWINDOWS XP\t25\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t3\t\t\r\nEcrans plats\tIIYAMA\t\t\t20\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tFIBRE OPTIQUE\t\t\t\t\t\r\nOpérateur Fixe\tSFR\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t03\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tSFR\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tACCESS\t\t\t\t\t\r\nCfao\tAUTODESK\tAUTOCAD\t\t\t\t\r\nGpao\tSPECIFIQUE\t\t\t\t\t\r\nCompta/Finance\tSPECIFIQUE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tBITDEFENDER\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t10\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Software\tSTOCKAGE SOFTWARE\tSAUV. EXTERNE\t\t\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:09:59.428115	2012-06-16 23:10:43.304272	2	Suspect	02 43 97 45 05	02 43 33 45 97		http://www.drouin.fr	\N
335	DURR ECOCLEAN	Rue des Etats-Unis		72540	LOUE	FRANCE		HORS CIBLE\r\n \t\r\nAppartient à un groupe \t: Oui\t \tSIRET \t: 35153034000022\r\nGroupe \t: DURR\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 16\r\nEffectif sur site \t: 195\t \tNombre de PC \t: 239\r\nEffectif société \t: 195\t \tActivité \t: Fabrication de machines spécialisées diverses (295R)\r\nEffectif informatique \t: 2\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 100\t \tNb téléphones fixes \t: 150\r\nEffectif BE \t: 40\t \tNb téléphones mobiles \t: 45\r\n\r\n   \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs mini\tIBM\tISERIES\tOS 400\t1\t20\t98\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2003\t12\t120\t08\r\nServeurs micro\tDELL\tSERVEUR\tLINUX\t1\t100\t08\r\nServeurs risc\tSUN\tSERVEUR\tUNIX\t2\t50\t97\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t131\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t93\t\t\r\nStation de travail\tSUN\tSPARCSTATION\tUNIX\t15\t\t\r\nEcrans plats\tDELL\t\t\t70\t\t\r\nMobilité\tBLACKBERRY\tPDA\tRIM\t2\t\t08\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tSDSL\t\t\t\t\t\r\nOpérateur Fixe\tDIVERS\t\t\t\t\t\r\nPABX/IPBX\tAASTRA/MATRA TELECOM\t\t\t\t\t08\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nWAN\tMPLS\t\t\t\t\t\r\nOpérateur Mobile\tBOUYGUES\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tHP/COMPAQ\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tDB2/BAS400\t\t\t\t\t\r\nSgbd\tMY SQL\t\t\t\t\t\r\nCfao\tMEDUSA\t\t\t\t\t\r\nCfao\tSOLIDWORKS\t\t\t\t\t\r\nErp\tSAP\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tEXCHANGE\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tCISCO\t\t\t\t\t\r\nFirewall\tMICROSOFT\t\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tMCAFEE\t\t\t\t\t\r\nAntivirus\tKASPERSKY\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tXEROX/TEKTRONIX\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t10\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDELL\tLTO\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t1500\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:14:59.41018	2012-06-16 23:14:59.41018	2	Suspect	02 43 39 78 00	02 43 39 78 01		http://www.durrecoclean.fr	\N
336	DUVAL METALU	155, rue d'Isaac		72000	LE MANS	FRANCE		Barrage secretaire. \r\npas le nom du dsi\r\n\r\n\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 44879660700019\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 75\t \tNombre de PC \t: 40\r\nEffectif société \t: 75\t \tActivité \t: Menuiserie métallique , serrurerie (454D)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 40\t \tNb téléphones fixes \t: 25\r\nEffectif BE \t: 8\t \tNb téléphones mobiles \t: 35\r\n \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2003\t1\t30\t06\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t20\t\t\r\nMicro\tDELL\tPC\tWINDOWS VISTA\t10\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS VISTA\t10\t\t\r\nEcrans plats\tDELL\t\t\t30\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t08\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tACCESS\t\t\t\t\t\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nCfao\tAUTODESK\tAUTOCAD\t\t\t\t\r\nCompta/Finance\tCEGID\tCCMX\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t4\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t200\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:17:16.707393	2012-06-16 23:18:02.413777	2	Suspect	02 43 74 34 34	02 43 76 03 15		http://www.duval-metalu.fr	\N
337	ECOFIT	ZI sud rue Marc Seguin BP 60008		41101	VENDOME CEDEX	FRANCE		\r\n \t\r\nAppartient à un groupe \t: Oui\t \tSIRET \t: 30817214700032\r\nGroupe \t: ROSENBERG\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 2\r\nEffectif sur site \t: 185\t \tNombre de PC \t: 66\r\nEffectif société \t: 185\t \tActivité \t: Fabrication de moteurs (311A)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 120\t \tNb téléphones fixes \t: 60\r\nEffectif BE \t: 4\t \tNb téléphones mobiles \t: 5\r\n \r\n\r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t1\t50\t05\r\nServeurs micro\tFUJITSU/SIEMENS\tSERVEUR\tWINDOWS 2003\t1\t50\t05\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tASSEMBLE\tPC\tWINDOWS XP\t60\t\t\r\nPortable\tACER\tPORTABLE\tWINDOWS XP\t4\t\t\r\nPortable\tSONY\tPORTABLE\tWINDOWS XP\t2\t\t\r\nEcrans plats\tACER\t\t\t1\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tFIBRE OPTIQUE\t\t\t\t\t\r\nTechnologie d accès\tTDSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tAASTRA/MATRA TELECOM\t\t\t\t\t04\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tFUNKWERK\t\t\t\t\t\r\nSwitch\tHP/COMPAQ\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tACCESS\t\t\t\t\t\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nCfao\tMISSLER\tTOPCAD\t\t\t\t\r\nGpao\tSILOG\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tEXCHANGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tKASPERSKY\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tTOSHIBA\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t12\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tHP/COMPAQ\tLTO\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t200\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:21:30.338202	2012-06-16 23:21:30.338202	2	Suspect	02 54 23 14 54	02 54 72 22 73		http://www.ecofit.com	\N
342	ETS DILANGE	Route d'Argentré la petite Motte		53960	BONCHAMP LES LAVAL	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 55715045500029\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 30\t \tNombre de PC \t: 10\r\nEffectif société \t: 50\t \tActivité \t: Récupération de matières métalliques recyclables (371Z)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 7\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 0\r\n \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tDIVERS\tSERVEUR\tWINDOWS 2003\t1\t7\t06\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tNEC\tPC\tWINDOWS XP\t10\t\t\r\nEcrans plats\tNEC/MITSUBISHI\t\t\t10\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tDIVERS\t\t\t\t\t\r\nSwitch\tDIVERS\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tDIVERS\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tKYOCERA/MITA\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t4\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:56:35.701695	2012-06-16 23:56:35.701695	2	Suspect	02 43 53 71 08	02 43 53 21 70			\N
343	EURO WIPES	ZA de l'Aunay rue de la Bruyère		28400	NOGENT LE ROTROU	FRANCE		Appartient à un groupe \t: Oui\t \tSIRET \t: 43522652700024\r\nGroupe \t: KOJAK\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 4\r\nEffectif sur site \t: 120\t \tNombre de PC \t: 42\r\nEffectif société \t: 120\t \tActivité \t: Fabrication de savons, détergents et produits d'entretien (245A)\r\nEffectif informatique \t: 2\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 70\t \tNb téléphones fixes \t: 35\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 5\r\n \r\n\r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs mini\tIBM\tISERIES\tOS 400\t1\t35\t09\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2003\t1\t35\t06\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2008\t1\t41\t11\r\nServeurs micro\tASSEMBLE\tSERVEUR\tWINDOWS 2003\t1\t35\t07\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tFUJITSU/SIEMENS\tPC\tWINDOWS XP\t16\t\t\r\nMicro\tDELL\tPC\tWINDOWS XP\t20\t\t\r\nMicro\tDELL\tPC\tWINDOWS 7\t1\t\t\r\nPortable\tFUJITSU/SIEMENS\tPORTABLE\tWINDOWS XP\t5\t\t\r\nEcrans plats\tDIVERS\t\t\t33\t\t\r\nEcrans plats\tFUJITSU/SIEMENS\t\t\t16\t\t\r\nEcrans plats\tDELL\t\t\t20\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2008\t\t\t\t\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nTechnologie d accès\tFIBRE OPTIQUE\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t01\r\nWAN\tTRANSPAC\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tNETGEAR\t\t\t\t\t\r\nSwitch\tDIVERS\tPEABIRD\t\t\t\t\r\nSwitch\tDIVERS\tDACOMEX\t\t\t\t\r\nSwitch\tSMC/NETWORKS\t\t\t\t\t\r\nSwitch\tNETGEAR\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tDB2/BAS400\t\t\t\t\t\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nErp\tDIVERS\tMINOS\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tZYXEL\t\t\t\t\t\r\nAntivirus\tMCAFEE\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tXEROX/TEKTRONIX\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t6\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\tDAT\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t1000\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 15:05:13.067533	2012-06-17 15:05:13.067533	2	Suspect	02 37 54 50 70	02 37 54 57 69		http://www.eurowipes.com	\N
344	EUROPE INDUSTRIES SERVICES	ZA Des Alignes 11, rue Emile Brault		53000	LAVAL	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 43970597100042\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 8\r\nEffectif sur site \t: 30\t \tNombre de PC \t: 315\r\nEffectif société \t: 300\t \tActivité \t: Administration d'entreprises (741J)\r\nEffectif informatique \t: 6\t \tNb sites interconnectés \t: 69\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 200\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 70\r\nContacts\t\r\n \r\n \t\r\nCivilité\tNom\tPrénom\tFonction\tEmail\r\n \r\n  M  \t  TUAL  \t  GERARD  \t  PRESIDENT DIRECTEUR GENERAL  \t  gerard.tual@groupeactual.eu  \r\nCommentaire:  \r\n  M  \t  TRUFFAULT  \t  PHILIPPE  \t  DIRECTEUR INFORMATIQUE  \t  philippe.truffault@groupeactual.eu  \r\nCommentaire:  \r\n  M  \t  PLANCHAIS  \t  BRUNO  \t  DIRECTEUR RESSOURCES HUMAINES  \t  bruno.planchais@groupeactual.eu  \r\nCommentaire:  \r\n  M  \t  JULIEN  \t  ERIC  \t  DIRECTEUR ADMIN ET FINANCIER  \t  eric.julien@groupeactual.eu  \r\nCommentaire:  \r\n  M  \t  TUAL  \t  DANIEL  \t  DIRECTEUR COMMUNICATION  \t  daniel.tual@groupeactual.eu  \r\nCommentaire:  \r\n \r\n\r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2003\t1\t315\t06\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2000\t6\t315\t05\r\nServeurs micro\tDELL\tSERVEUR\tWIN LINUX\t1\t315\t05\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t300\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t15\t\t\r\nEcrans plats\tDELL\t\t\t300\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2000\t\t\t\t\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nTechnologie d accès\tSDSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t\r\nWAN\tEQUANT\t\t\t\t\t\r\nWAN\tVOIP\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tFUNKWERK\t\t\t\t\t\r\nSwitch\tD-LINK\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tMY SQL\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCRM\tSPECIFIQUE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tDIVERS\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tTREND MICRO\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tRICOH\t\t\t\t\t\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t20\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDELL\t\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t1000\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t1\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 15:51:35.726056	2012-06-17 15:51:35.726056	2	Suspect	02 43 01 20 34	02 43 26 03 50		http://www.groupeactual.com	\N
345	EUROPEENNE DE PLATS CUISINES	ZI de Beaufeu		72210	ROEZE SUR SARTHE	FRANCE		Groupe LDC\r\nHORS CIBLE\r\n\r\n\r\n\r\nAppartient à un groupe \t: Oui\t \tSIRET \t: 34339778200016\r\nGroupe \t: LDC\t \tType Ets \t: Siege\r\nSite informatique distant \t: Oui\t \tNombre de Serveurs \t: 4\r\nEffectif sur site \t: 280\t \tNombre de PC \t: 130\r\nEffectif société \t: 280\t \tActivité \t: Préparation industrielle de produits à base de viande (151E)\r\nEffectif informatique \t: 3\t \tNb sites interconnectés \t: 1\r\nEffectif Production \t: 200\t \tNb téléphones fixes \t: 100\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 15\r\n \r\n \r\n \r\n \t\r\n\tContacts\t\r\n \r\n \t\r\nCivilité\tNom\tPrénom\tFonction\tEmail\r\n \r\n  M  \t  ROUBY  \t  JEAN MARC  \t  RESPONSABLE ERP  \t   \r\nCommentaire:  \r\n  M  \t  CAPOULADE  \t  ARNAUD  \t  RESPONSABLE MICRO  \t   \r\nCommentaire:  \r\n  M  \t  PAGEOT  \t  DIDIER  \t  RESPONSABLE ETUDES INFORMATIQ  \t   \r\nCommentaire:  \r\n  M  \t  LERUEZ  \t  MICHEL  \t  DIRECTEUR TECHNIQUE  \t   \r\nCommentaire:  \r\n  M  \t  CUENO  \t  PATRICK  \t  DIRECTEUR COMMERCIAL  \t   \r\nCommentaire:  \r\n \r\n \r\n   \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tLINUX\t2\t50\t04\r\nServeurs risc\tBULL\tESCALA\tUNIX\t2\t50\t02\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tNEC\tPC\tWINDOWS XP\t100\t\t\r\nPortable\tFUJITSU/SIEMENS\tPORTABLE\tWINDOWS XP\t20\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t10\t\t\r\nEcrans plats\tBELINEA/MAXDATA\t\t\t50\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nTechnologie d accès\tSDSL\t\t\t\t\t\r\nTechnologie d accès\tLL 1 MEGA\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tAASTRA/MATRA TELECOM\t\t\t\t\t08\r\nWAN\tMPLS\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\t3COM\t\t\t\t\t\r\nSwitch\tD-LINK\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tORACLE\t\t\t\t\t\r\nSgbd\tPROGRESS\t\t\t\t\t\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nErp\tMFGPRO\t\t\t\t\t\r\nCompta/Finance\tDIVERS\tINFOLOGIC\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tLOTUSNOTES\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tDIVERS\t\t\t\t\t\r\nImprimantes\tRICOH\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t15\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\nStockage Software\tSTOCKAGE SOFTWARE\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t80\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 15:54:03.043999	2012-06-17 15:54:03.043999	2	Suspect	02 43 39 59 50	02 43 77 48 24		http://www.epc.fr	\N
346	EUROPLASTIQUES	ZI des Touches 45, boulevard de Buffon BP 0727		53007	LAVAL CEDEX	FRANCE		Appartient à un groupe \t: Oui\t \tSIRET \t: 35021224700018\r\nGroupe \t: FEP\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 3\r\nEffectif sur site \t: 100\t \tNombre de PC \t: 85\r\nEffectif société \t: 100\t \tActivité \t: Fabrication d'emballages en matières plastiques (252C)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 81\t \tNb téléphones fixes \t: 65\r\nEffectif BE \t: 5\t \tNb téléphones mobiles \t: 5\r\n \r\n \r\n \r\n \t\r\n\tContacts\t\r\n \r\n \t\r\nCivilité\tNom\tPrénom\tFonction\tEmail\r\n \r\n  M  \t  BARBEROT  \t  NICOLAS  \t  PRESIDENT DIRECTEUR GENERAL  \t   \r\nCommentaire:  \r\n  M  \t  SIMONNEAUX  \t  ERIC  \t  RESPONSABLE INFORMATIQUE  \t   \r\nCommentaire:  \r\n  M  \t  ORY  \t  GILBERT  \t  DIRECTEUR PRODUCTION  \t   \r\nCommentaire:  \r\n  M  \t  AUBIN  \t  MICHEL  \t  RESPONSABLE BUREAU D ETUDE  \t   \r\nCommentaire:  \r\n  M  \t  MICHEL  \t  GUY  \t  DIRECTEUR COMMERCIAL  \t   \r\nCommentaire:  \r\n \r\n \r\n   \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs mini\tFUJITSU/SIEMENS\tMINI SYSTEME\tUNIX\t1\t40\t03\r\nServeurs micro\tDIVERS\tSERVEUR\tLINUX\t1\t80\t02\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t1\t80\t05\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS XP\t70\t\t\r\nMicro\tDELL\tPC\tWINDOWS XP\t5\t\t\r\nPortable\tHP/COMPAQ\tPORTABLE\tWINDOWS XP\t10\t\t\r\nEcrans plats\tSAMSUNG\t\t\t70\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nTechnologie d accès\tSDSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nWAN\tVOIP\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\t3COM\t\t\t\t\t\r\nSwitch\t3COM\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tINFORMIX/IBM\t\t\t\t\t\r\nSgbd\tACCESS\t\t\t\t\t\r\nCfao\tUNIGRAPHICS\t\t\t\t\t\r\nErp\tDIVERS\tSYLOB\t\t\t\t\r\nCompta/Finance\tCEGID\tCCMX\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tEXCHANGE\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tNETASQ\t\t\t\t\t\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t30\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t1\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 15:56:00.711278	2012-06-17 15:56:00.711278	2	Suspect	02 43 49 56 56	02 43 49 56 66		http://www.europlastiques.com	\N
347	EVERIAL	9, rue Edmond Poillot 		28000	CHARTRES	FRANCE		Appartient à un groupe \t: Oui\t \tSIRET \t: 35055386300258\r\nGroupe \t: SPF\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 30\r\nEffectif sur site \t: 52\t \tNombre de PC \t: 100\r\nEffectif société \t: 250\t \tActivité \t: Conseil pour les affaires et la gestion (741G)\r\nEffectif informatique \t: 20\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 50\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 20\r\n \r\n \r\n \r\n \t\r\n\tContacts\t\r\n \r\n \t\r\nCivilité\tNom\tPrénom\tFonction\tEmail\r\n \r\n  M  \t  GARCIA  \t   \t  DIRECTEUR GENERAL  \t   \r\nCommentaire:  \r\n  M  \t  MONTESE  \t  HENRI  \t  RESPONSABLE INFORMATIQUE  \t   \r\nCommentaire: D-0478796481  \r\n  M  \t  SCHOTT  \t  EMMANUEL  \t  ADMINISTRATEUR SYST. ET RESEAU  \t   \r\nCommentaire:  \r\n  M  \t  GARNON  \t   \t  DIRECTEUR RESSOURCES HUMAINES  \t   \r\nCommentaire:  \r\n  M  \t  IZOIRD  \t   \t  DIRECTEUR FINANCIER  \t   \r\nCommentaire:  \r\n \r\n \r\n   \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2003\t26\t100\t08\r\nServeurs risc\tHP/COMPAQ\tSERVEUR\tUNIX\t4\t\t08\r\nVirtualisation\tDELL\tVMWARE\t\t4\t\t08\r\nOs virtualisation\tWINDOWS 2003\t\t\t1\t\t\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t80\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t20\t\t\r\nEcrans plats\tDELL\t\t\t80\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nTechnologie d accès\tFIBRE OPTIQUE\t\t\t\t\t\r\nTechnologie d accès\tSDSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tAASTRA/MATRA TELECOM\t\t\t\t\t\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nWAN\tVOIP\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tHP/COMPAQ\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nCRM\tSPECIFIQUE\t\t\t\t\t\r\nGED\tDIVERS\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tLOCAL\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nExtranet\tEXTRANET\t\t\t\t\t\r\nMessagerie\tEXCHANGE\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tDIVERS\tFOREFRONT\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t20\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t1\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 17:29:37.582736	2012-06-17 17:29:37.582736	2	Suspect	02 37 91 54 80	02 37 91 54 81		http://www.everial.com	\N
348	FARAL	60, boulevard Léon Bollée		53000	LAVAL	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 55575038900036\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 60\t \tNombre de PC \t: 13\r\nEffectif société \t: 60\t \tActivité \t: Mécanique générale (285D)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 40\t \tNb téléphones fixes \t: 15\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 4\r\n \r\n \r\n \r\n \t\r\n\tContacts\t\r\n \r\n \t\r\nCivilité\tNom\tPrénom\tFonction\tEmail\r\n \r\n  M  \t  HUNAUT  \t  ERIC  \t  DIRECTEUR GENERAL  \t   \r\nCommentaire:  \r\n  M  \t  MERIENNE  \t  JEAN LOUIS  \t  DIRECTEUR PRODUCTION  \t  jeanlouis.merienne-faral@orange.fr  \r\nCommentaire:  \r\n  MME  \t  ROLLAND  \t  VIVIANNE  \t  DIRECTEUR COMPTABLE  \t   \r\nCommentaire:  \r\n  M  \t  ROLLAND  \t  JEAN PIERRE  \t  DIRECTEUR COMMERCIAL  \t   \r\nCommentaire:  \r\n  M  \t  STAUMONT  \t  PATRICK  \t  COMMERCIAL  \t   \r\nCommentaire:  \r\n  MME  \t  ROLLAND  \t  VIVIANE  \t  RESPONSABLE QHSE  \t   \r\nCommentaire:  \r\n \r\n \r\n   \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2000\t1\t15\t06\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS XP\t12\t\t\r\nPortable\tHP/COMPAQ\tPORTABLE\tWINDOWS XP\t1\t\t\r\nEcrans plats\tHP/COMPAQ\t\t\t12\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2000\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tHP/COMPAQ\t\t\t\t\t\r\nSwitch\tHP/COMPAQ\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tDIVERS\t\t\t\t\t\r\nSgbd\tACCESS\t\t\t\t\t\r\nErp\tSAGE\tXR3\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tDIVERS\t\t\t\t\t\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tKYOCERA/MITA\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t5\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\nStockage Hardware\tDIVERS\tDAT\t\t\t\t\r\nStockage Software\tCOMPUTER ASSOCIATES\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t80\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\tMISMO\t\t1\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 17:32:50.38151	2012-06-17 17:32:50.38151	2	Suspect	02 43 59 29 59	02 43 56 61 22		http://www.faral.fr	\N
349	FASSIER	ZI Nord rue de l'Industrie		72320	VIBRAYE	FRANCE		M. Rolland ne veut pas me prendre au téléphone\r\n\r\n\r\n\r\n \t\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 32348008700010\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 2\r\nEffectif sur site \t: 200\t \tNombre de PC \t: 17\r\nEffectif société \t: 212\t \tActivité \t: Préparation industrielle de produits à base de viande (151E)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 180\t \tNb téléphones fixes \t: 0\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 0\r\n \r\n \r\n \r\n \t\r\n\tContacts\t\r\n \r\n \t\r\nCivilité\tNom\tPrénom\tFonction\tEmail\r\n \r\n  MME  \t  FASSIER  \t  ISABELLE  \t  ADJOINT DU DIRECTEUR GENERAL  \t  sa.fassier@wanadoo.fr  \r\nCommentaire:  \r\n  M  \t  ROLLAND  \t  FABRICE  \t  CORRESPONDANT INFORMATIQUE  \t   \r\nCommentaire:  \r\n  M  \t  FASSIER  \t  JEAN LUC  \t  DIRECTEUR PRODUCTION  \t   \r\nCommentaire:  \r\n  M  \t  ROUSSEAU  \t  DOMINIQUE  \t  DIRECTEUR TECHNIQUE  \t   \r\nCommentaire:  \r\n  M  \t  CARROY  \t  JEAN MARC  \t  DIRECTEUR COMMERCIAL  \t   \r\nCommentaire:  \r\n \r\n \r\n   \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs risc\tHP/COMPAQ\t9000\tUNIX\t2\t17\t94\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS XP\t17\t\t\r\nEcrans plats\tHP/COMPAQ\t\t\t17\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tETHERNET\tTCPIP\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t\r\nWAN\tTRANSPAC\t\t\t\t\t\r\nOpérateur Mobile\tBOUYGUES\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nCompta/Finance\tCEGID\tCCMX\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMessagerie\tLOTUSNOTES\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nAntivirus\tMCAFEE\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t5\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tHP/COMPAQ\t\t\t\t\t\r\nStockage Software\tCOMPUTER ASSOCIATES\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t100\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t1\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 17:34:40.068494	2012-06-17 17:34:40.068494	2	Suspect	02 43 60 63 63	02 43 71 95 54			\N
350	FAUCHEUX	29, rue du Président Kennedy BP 90050		28111	LUCE CEDEX	FRANCE		Appartient à un groupe \t: Oui\t \tSIRET \t: 44389322700019\r\nGroupe \t: ALAMO\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 3\r\nEffectif sur site \t: 100\t \tNombre de PC \t: 46\r\nEffectif société \t: 100\t \tActivité \t: Fabrication d'équipements de levage et de manutention (292D)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 2\r\nEffectif Production \t: 60\t \tNb téléphones fixes \t: 25\r\nEffectif BE \t: 7\t \tNb téléphones mobiles \t: 10\r\n \r\n \r\n \r\n \t\r\n\tContacts\t\r\n \r\n \t\r\nCivilité\tNom\tPrénom\tFonction\tEmail\r\n \r\n  M  \t  GILBERT  \t  JEAN BAPTISTE  \t  DIRECTEUR GENERAL  \t   \r\nCommentaire:  \r\n  M  \t  DAVIES  \t  GEOFFREY  \t  PRESIDENT  \t   \r\nCommentaire:  \r\n  M  \t  REBIFFE  \t  JEAN PIERRE  \t  RESPONSABLE ERP  \t  jp.rebiffe@faucheux.fr  \r\nCommentaire:  \r\n  M  \t  PINTON  \t  ERIC  \t  DIRECTEUR PRODUCTION  \t  e.pinton@faucheux.fr  \r\nCommentaire:  \r\n  M  \t  ANGELUY  \t   \t  RESPONSABLE BUREAU D ETUDE  \t   \r\nCommentaire:  \r\n  MME  \t  MARC  \t  NADINE  \t  DIRECTEUR ADMIN ET FINANCIER  \t   \r\nCommentaire:  \r\n  MME  \t  LORIOT  \t  CATHERINE  \t  DIRECTEUR COMPTABLE  \t  c.loriot@faucheux.fr  \r\nCommentaire:  \r\n  M  \t  AUBERT  \t  PHILIPPE  \t  DIRECTEUR COMMERCIAL  \t  p.aubert@faucheux.fr  \r\nCommentaire:  \r\n \r\n \r\n   \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2000\t1\t30\t04\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2008\t1\t30\t09\r\nServeurs risc\tIBM\tRISC 6000\tUNIX\t1\t16\t04\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS XP\t35\t\t\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS 7\t1\t\t\r\nPortable\tHP/COMPAQ\tPORTABLE\tWINDOWS XP\t10\t\t\r\nEcrans plats\tHP/COMPAQ\t\t\t10\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2008\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2000\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tTRANSFIX\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t06\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tUNIVERSE\t\t\t\t\t\r\nCfao\tSOLIDWORKS\t\t\t\t\t\r\nGpao\tSPECIFIQUE\t\t\t\t\t\r\nCompta/Finance\tSPECIFIQUE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tMCAFEE\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t8\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t630\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t1\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 17:36:25.879422	2012-06-17 17:36:58.486533	2	Suspect	02 37 30 40 50	02 37 30 16 43		http://www.faucheux.fr/	\N
351	FLECHARD	ZI du Port Morin		61140	LA CHAPELLE D ANDAINE	FRANCE		A rappeler en fin d'année !!!\r\n\r\nAppartient à un groupe \t: Oui\t \tSIRET \t: 30351400400017\r\nGroupe \t: FLECHARD\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 3\r\nEffectif sur site \t: 140\t \tNombre de PC \t: 32\r\nEffectif société \t: 140\t \tActivité \t: Fabrication de beurre (155B)\r\nEffectif informatique \t: 2\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 100\t \tNb téléphones fixes \t: 18\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 10\r\n \r\n \r\n \r\n \t\r\n\tContacts\t\r\n \r\n \t\r\nCivilité\tNom\tPrénom\tFonction\tEmail\r\n \r\n  M  \t  FLECHARD  \t  JACQUES  \t  PRESIDENT DIRECTEUR GENERAL  \t  j.flechard@flechard.com  \r\nCommentaire:  \r\n  M  \t  FLECHARD  \t  GUY  \t  DIRECTEUR ETABLISSEMENT  \t   \r\nCommentaire:  \r\n  M  \t  GALLOT  \t  JEAN JACQUES  \t  RESPONSABLE INFORMATIQUE  \t  j.gallot@flechard.com  \r\nCommentaire:  \r\n  MME  \t  LERAT  \t  ELISABETH  \t  SECRETAIRE INFORMATIQUE  \t  e.lerat@flechard.com  \r\nCommentaire:  \r\n  M  \t  FLECHARD  \t  PATRICK  \t  DIRECTEUR TECHNIQUE  \t  p.flechard@flechard.com  \r\nCommentaire: 0233303628  \r\n  M  \t  LE BESCOND  \t  BERNARD  \t  DIRECTEUR FINANCIER  \t  b.lebescond@flechard.com  \r\nCommentaire:  \r\n  M  \t  VAN HULLE  \t  JEAN CLAUDE  \t  DIRECTEUR COMMERCIAL  \t  j.vanhulle@flechard.com  \r\nCommentaire:  \r\n \r\n \r\n   \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs mini\tIBM\tISERIES\tOS 400\t1\t32\t06\r\nServeurs micro\tDIVERS\tSERVEUR\tLINUX\t1\t\t08\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2000\t1\t\t07\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t20\t\t\r\nMicro\tDELL\tPC\tWINDOWS VISTA\t6\t\t\r\nMicro\tDELL\tPC\tWINDOWS 2000\t5\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS NT\t1\t\t\r\nEcrans plats\tDIVERS\t\t\t30\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tETHERNET\tWINDOWS 2000\t\t\t\t\r\nRéseaux locaux\tETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t\r\nWAN\tDIVERS\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tNORTEL NETWORKS\t\t\t\t\t\r\nSwitch\t3COM\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tDB2/BAS400\t\t\t\t\t\r\nSgbd\tACCESS\t\t\t\t\t\r\nGpao\tSPECIFIQUE\t\t\t\t\t\r\nCompta/Finance\tSPECIFIQUE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tDIVERS\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tNOD 32\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tEPSON\t\t\t\t\t\r\nImprimantes\tKYOCERA/MITA\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t10\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tIBM\t\t\t\t\t\r\nStockage Software\tIBM/TIVOLI\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t70\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 17:38:39.565501	2012-06-17 17:38:39.565501	2	Suspect	02 33 30 36 37	02 33 38 45 65		http://www.flechard.com	\N
352	FLOWSERVE POMPES	13, rue Maurice Trintignant		72230	ARNAGE	FRANCE		Connu et deja rencontre\r\nAppartient à un groupe \t: Oui\t \tSIRET \t: 44402752800017\r\nGroupe \t: FLOWSERVE\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 6\r\nEffectif sur site \t: 300\t \tNombre de PC \t: 310\r\nEffectif société \t: 300\t \tActivité \t: Fabrication de pompes (291B)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 1\r\nEffectif Production \t: 150\t \tNb téléphones fixes \t: 180\r\nEffectif BE \t: 20\t \tNb téléphones mobiles \t: 60\r\n \r\n \r\n \r\n \t\r\n\tContacts\t\r\n \r\n \t\r\nCivilité\tNom\tPrénom\tFonction\tEmail\r\n \r\n  M  \t  GELIN  \t  STEPHANE  \t  DIRECTEUR GENERAL  \t  sgelin@flowserve.com  \r\nCommentaire:  \r\n  M  \t  CHEVALIER  \t  ANTOINE  \t  RESPONSABLE INFORMATIQUE  \t  achevalier@flowserve.com  \r\nCommentaire:  \r\n  MME  \t  LE CATONNAUX  \t  SANDRA  \t  DIRECTEUR RESSOURCES HUMAINES  \t  slecatonnaux@flowserve.com  \r\nCommentaire:  \r\n  M  \t  LEDUC  \t  GAEL  \t  DIRECTEUR PRODUCTION  \t  gleduc@flowserve.com  \r\nCommentaire:  \r\n  M  \t  PERRIN  \t  FRANCOIS  \t  RESPONSABLE QUALITE  \t  fperrin@flowserve.com  \r\nCommentaire:  \r\n  M  \t  BEROT  \t  FRANCOIS  \t  RESPONSABLE BUREAU D ETUDE  \t  fberot@flowserve.com  \r\nCommentaire:  \r\n  M  \t  OLIVEIRA  \t  CHARLES PHILIPPE  \t  DIRECTEUR FINANCIER  \t  coliveira@flowserve.com  \r\nCommentaire:  \r\n  M  \t  DUBOIS  \t  ALAIN  \t  RESPONSABLE QHSE  \t  adubois@flowserve.com  \r\nCommentaire:  \r\n \r\n \r\n   \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t4\t280\t08\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2003\t2\t280\t08\r\nVirtualisation\tDELL\tVMWARE\t\t2\t\t11\r\nOs virtualisation\tWINDOWS 2003\t\t\t1\t\t\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t250\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t60\t\t\r\nEcrans plats\tDELL\t\t\t250\t\t\r\nMobilité\tBLACKBERRY\tPDA\tRIM\t10\t\t08\r\nMobilité\tBLACKBERRY\tPDA\tRIM\t5\t\t10\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nTechnologie d accès\tFIBRE OPTIQUE\t\t\t\t\t\r\nTechnologie d accès\tLL 10 MEGA\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tCISCO\t\t\t\t\t06\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nWAN\tVOIP\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tORACLE\t\t\t\t\t\r\nCfao\tPROENGINER\t\t\t\t\t\r\nErp\tORACLE APL\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nExtranet\tEXTRANET\t\t\t\t\t\r\nMessagerie\tLOTUSNOTES\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tMCAFEE\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tXEROX/TEKTRONIX\t\t\t\t\t\r\nImprimantes\tRICOH\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t10\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\tSAN\t\t\t\t\r\nStockage Hardware\tDIVERS\tLTO\t\t\t\t\r\nStockage Software\tCOMPUTER ASSOCIATES\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t1000\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t1\t	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 17:44:54.84487	2012-06-17 17:44:54.84487	2	Prospect	02 43 40 57 57	02 43 40 57 10		http://www.flowserve.com	\N
353	FOISNET BATIMENT	La Croix des Quatres Epines BP 16		53120	GORRON	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 34104766000020\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 65\t \tNombre de PC \t: 6\r\nEffectif société \t: 80\t \tActivité \t: Construction de bâtiments divers (452B)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 1\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 14\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 20\r\n \r\n \r\n \r\n \t\r\n\tContacts\t\r\n \r\n \t\r\nCivilité\tNom\tPrénom\tFonction\tEmail\r\n \r\n  M  \t  BOITTIN  \t  PATRICK  \t  PRESIDENT  \t   \r\nCommentaire:  \r\n  M  \t  DUVAL  \t  JEAN  \t  DIRECTEUR ADMIN ET FINANCIER  \t   \r\nCommentaire:  \r\n \r\n \r\n   \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tTSE\tWINDOWS 2003\t1\t8\t08\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tASSEMBLE\tPC\tWINDOWS XP\t4\t\t\r\nPortable\tASUS\tPORTABLE\tWINDOWS XP\t2\t\t\r\nEcrans plats\tDELL\t\t\t2\t\t\r\nEcrans plats\tIIYAMA\t\t\t2\t\t\r\nMobilité\tBLACKBERRY\tPDA\tRIM\t3\t\t10\r\nMobilité\tAPPLE\tIPHONE\tIPHONE OS\t1\t\t10\r\nMobilité\tPALM\tPDA\tPALM/OS\t1\t\t06\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tAASTRA/MATRA TELECOM\tERICSSON\t\t\t\t04\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tFUNKWERK\t\t\t\t\t\r\nSwitch\tD-LINK\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tACCESS\t\t\t\t\t\r\nCompta/Finance\tCEGID\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tAVAST\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tKONICA/MINOLTA\t\t\t\t\t\r\nImprimantes\tBROTHER\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t3\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tHP/COMPAQ\tDAT\t\t\t\t\r\nStockage Software\tSTOCKAGE SOFTWARE\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t450\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t1\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 17:47:03.870086	2012-06-17 17:47:03.870086	2	Suspect	02 43 08 63 32	02 43 08 07 96		http://www.foisnet-batiment.com	\N
354	FONDERIE MAYENNAISE 	ZI de Brives Brives		53100	MAYENNE	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 49814071400011\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 100\t \tNombre de PC \t: 32\r\nEffectif société \t: 100\t \tActivité \t: Fonderie de fonte (275A)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 58\t \tNb téléphones fixes \t: 36\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 5\r\n \r\n \r\n \r\n \t\r\n\tContacts\t\r\n \r\n \t\r\nCivilité\tNom\tPrénom\tFonction\tEmail\r\n \r\n  M  \t  PESLIER  \t  JOEL  \t  DIRECTEUR ETABLISSEMENT  \t   \r\nCommentaire:  \r\n  MME  \t  QUELIN  \t  MARIE LAURE  \t  SECRETAIRE  \t   \r\nCommentaire:  \r\n  M  \t  TRIDON  \t  JACKY  \t  DIRECTEUR PRODUCTION  \t   \r\nCommentaire:  \r\n \r\n \r\n   \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tNEC\tSERVEUR\tWINDOWS 2003\t1\t18\t07\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS XP\t20\t\t\r\nMicro\tDELL\tPC\tWINDOWS XP\t7\t\t\r\nPortable\tDIVERS\tPORTABLE\tWINDOWS XP\t5\t\t\r\nEcrans plats\tHP/COMPAQ\t\t\t15\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tDIVERS\t\t\t\t\t08\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tDIVERS\t\t\t\t\t\r\nSwitch\tDIVERS\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nGpao\tSAGE/ADONIX\t\t\t\t\t\r\nCompta/Finance\tCEGID\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t7\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t1\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 17:49:17.464261	2012-06-17 17:49:17.464261	2	Suspect	02 43 08 21 50	02 43 00 07 53		http://www.fonderiemayennaise.fr	\N
355	EIFFAGE ENERGIE ANJOU MAINE	8, boulevard de Buffon BP 2239		53810	CHANGE	FRANCE		Appartient à un groupe \t: Oui\t \tSIRET \t: 38878695600010\r\nGroupe \t: EIFFAGE\t \tType Ets \t: Siege\r\nSite informatique distant \t: Oui\t \tNombre de Serveurs \t: 3\r\nEffectif sur site \t: 170\t \tNombre de PC \t: 110\r\nEffectif société \t: 220\t \tActivité \t: Travaux d'installation électrique (453A)\r\nEffectif informatique \t: 2\t \tNb sites interconnectés \t: 2\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 50\r\nEffectif BE \t: 15\t \tNb téléphones mobiles \t: 120\r\n \r\n \r\n \r\n \t\r\n\tContacts\t\r\n \r\n \t\r\nCivilité\tNom\tPrénom\tFonction\tEmail\r\n \r\n  M  \t  DAL  \t  FRANCOIS  \t  DIRECTEUR ETABLISSEMENT  \t   \r\nCommentaire:  \r\n  M  \t  PAGEOT  \t  ANTHONY  \t  RESPONSABLE INFORMATIQUE  \t  anthony.pageot@eiffage.com  \r\nCommentaire: 0228214377  \r\n  M  \t  PAUMARD  \t  ERIC  \t  RESPONSABLE INFORMATIQUE  \t  eric.paumard@eiffage.com  \r\nCommentaire:  \r\n  M  \t  PAILLARD  \t  JEAN LUC  \t  RESPONSABLE BUREAU D ETUDE  \t   \r\nCommentaire:  \r\n  M  \t  POISSON  \t  EMMANUEL  \t  DIRECTEUR COMPTABLE  \t   \r\nCommentaire:  \r\n \r\n \r\n   \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tTSE\tWINDOWS 2003\t2\t110\t08\r\nServeurs micro\tHP/COMPAQ\tTSE\tWINDOWS 2000\t1\t110\t08\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS XP\t60\t\t\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS 2000\t30\t\t\r\nPortable\tTOSHIBA\tPORTABLE\tWINDOWS XP\t20\t\t\r\nEcrans plats\tHP/COMPAQ\t\t\t60\t\t\r\nMobilité\tDIVERS\tSMARTPHONE\tWINDOWS MOBILE\t2\t\t08\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2000\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tWINDOWS 2000\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t04\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tACCESS\t\t\t\t\t\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nCfao\tDIVERS\tSCHEMA\t\t\t\t\r\nCfao\tAUTODESK\tAUTOCAD\t\t\t\t\r\nCompta/Finance\tSPECIFIQUE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tRICOH\t\t\t\t\t\r\nImprimantes\tKYOCERA/MITA\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t12\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t800\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 17:51:23.81136	2012-06-17 17:51:23.81136	2	Suspect	02 43 56 10 31	02 43 53 97 26		http://www.eiffage.fr	\N
356	FPEE INDUSTRIES	ZI route de Sillé		72350	BRULON	FRANCE		Envoyer mail a sgobin@fpee.fr\r\n\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 32348006100015\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 3\r\nEffectif sur site \t: 260\t \tNombre de PC \t: 80\r\nEffectif société \t: 260\t \tActivité \t: Fabrication d'éléments en matières plastiques pour la (252E)\r\nEffectif informatique \t: 3\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 130\t \tNb téléphones fixes \t: 0\r\nEffectif BE \t: 2\t \tNb téléphones mobiles \t: 0\r\n \r\n \r\n \r\n \t\r\n\tContacts\t\r\n \r\n \t\r\nCivilité\tNom\tPrénom\tFonction\tEmail\r\n \r\n  M  \t  BULOT  \t  CHRISTIAN  \t  DIRECTEUR GENERAL  \t   \r\nCommentaire:  \r\n  M  \t  ETTIENNE  \t  MARC  \t  PRESIDENT DIRECTEUR GENERAL  \t   \r\nCommentaire:  \r\n  M  \t  GOBIN  \t  SEBASTIEN  \t  DIRECTEUR INFORMATIQUE  \t   \r\nCommentaire:  \r\n  M  \t  SAUVAGE  \t  DOMINIQUE  \t  DIRECTEUR PRODUCTION  \t   \r\nCommentaire: RBE  \r\n  MME  \t  RIGOUIN  \t  SYLVIE  \t  DIRECTEUR FINANCIER  \t   \r\nCommentaire:  \r\n  M  \t  LESAULNIER  \t  BRUNO  \t  DIRECTEUR COMMERCIAL  \t   \r\nCommentaire:  \r\n  MME  \t  BORDIER  \t  HELENE  \t  DIRECTEUR MARKETING  \t   \r\nCommentaire:  \r\n \r\n \r\n   \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tASSEMBLE\tSERVEUR\tWINDOWS 2003\t2\t60\t06\r\nServeurs micro\tASSEMBLE\tSERVEUR\tNETWARE\t1\t60\t02\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t70\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t10\t\t\r\nEcrans plats\tDELL\t\t\t30\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tNETWARE\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tSDSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t04\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\t3COM\t\t\t\t\t\r\nSwitch\t3COM\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tORACLE\t\t\t\t\t\r\nSgbd\tACCESS\t\t\t\t\t\r\nCfao\tCATIA\t\t\t\t\t\r\nGpao\tMOVEX\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tTREND MICRO\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tRICOH\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t20\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 17:54:48.897856	2012-06-17 17:54:48.897856	2	Suspect	02 43 62 15 15	02 43 62 15 28			\N
357	FRANCE INDUSTRIE	ZI 3, rue de la Croix Bourgot		28800	BONNEVAL	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 30807669400014\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 2\r\nEffectif sur site \t: 11\t \tNombre de PC \t: 18\r\nEffectif société \t: 11\t \tActivité \t: Fabrication de savons, détergents et produits d'entretien (245A)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 2\t \tNb téléphones fixes \t: 15\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 5\r\n \r\n \r\n \r\n \t\r\n\tContacts\t\r\n \r\n \t\r\nCivilité\tNom\tPrénom\tFonction\tEmail\r\n \r\n  M  \t  VENNIN  \t  CHRISTOPHE  \t  PRESIDENT DIRECTEUR GENERAL  \t   \r\nCommentaire:  \r\n  MME  \t  FONTAINE  \t  NADINE  \t  DIRECTEUR COMPTABLE  \t  nadine.fontaine@wanadoo.fr  \r\nCommentaire: 0237477180  \r\n  M  \t  BRUNEAU  \t  ERIC  \t  DIRECTEUR COMMERCIAL  \t  eric.bruneau@wanadoo.fr  \r\nCommentaire:  \r\n  MME  \t  TCHIKOU  \t  RATIBA  \t  DIRECTEUR DES ACHATS  \t   \r\nCommentaire: 0237477178  \r\n \r\n \r\n   \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t2\t15\t07\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tASSEMBLE\tPC\tWINDOWS XP\t15\t\t\r\nPortable\tFUJITSU/SIEMENS\tPORTABLE\tWINDOWS XP\t3\t\t\r\nEcrans plats\tLG/GOLDSTAR\t\t\t15\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tFUNKWERK\t\t\t\t\t\r\nSwitch\t3COM\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tACCESS\t\t\t\t\t\r\nGpao\tSPECIFIQUE\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tMCAFEE\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tBROTHER\t\t\t\t\t\r\nImprimantes\tKYOCERA/MITA\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t6\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\nStockage Software\tHP\tDATA PROTECTOR\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t100\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 17:57:55.352998	2012-06-17 17:57:55.352998	2	Suspect	02 37 47 26 24	02 37 96 23 47		http://www.france-industrie.com	\N
358	FRANCE TRAITEMENT	ZA de Beaumont		61230	CROISILLES	FRANCE		A rappeler absolument - M Lathuille\r\nRDV avec Mme Bernard sur conseil de M. Lathuille\r\n\r\n\r\nAppartient à un groupe \t: Oui\t \tSIRET \t: 47997884300023\r\nGroupe \t: ANKER TELECOMMUNICATION\t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 2\r\nEffectif sur site \t: 30\t \tNombre de PC \t: 23\r\nEffectif société \t: 30\t \tActivité \t: Ingénierie, études techniques (742C)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 1\r\nEffectif Production \t: 10\t \tNb téléphones fixes \t: 12\r\nEffectif BE \t: 3\t \tNb téléphones mobiles \t: 7\r\n \r\n \r\n \r\n \t\r\n\tContacts\t\r\n \r\n \t\r\nCivilité\tNom\tPrénom\tFonction\tEmail\r\n \r\n  M  \t  LATHUILLE  \t  ERIC  \t  DIRECTEUR GENERAL  \t   \r\nCommentaire:  \r\n  MME  \t  BERNARD  \t  FLORENCE  \t  SECRETAIRE  \t   \r\nCommentaire:  \r\n  M  \t  PINSON  \t  LIONEL  \t  RESPONSABLE FABRICATION  \t   \r\nCommentaire:  \r\n  M  \t  PRUVOST  \t  MICKAEL  \t  RESPONSABLE BUREAU D ETUDE  \t   \r\nCommentaire:  \r\n  MME  \t  VANEK  \t  SEVERINE  \t  DIRECTEUR COMPTABLE  \t   \r\nCommentaire:  \r\n \r\n \r\n   \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tIBM\tSERVEUR\tWINDOWS 2003\t2\t18\t07\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t18\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t5\t\t\r\nEcrans plats\tDELL\t\t\t18\t\t\r\nMobilité\tAPPLE\tIPHONE\tIPHONE OS\t7\t\t11\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nTechnologie d accès\tSDSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tCISCO\t\t\t\t\t\r\nWAN\tVOIP\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tORACLE\t\t\t\t\t\r\nCfao\tAUTODESK\tAUTOCAD\t\t\t\t\r\nGpao\tSPECIFIQUE\t\t\t\t\t\r\nCompta/Finance\tSPECIFIQUE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tMCAFEE\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tRICOH\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t2\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDELL\t\t\t\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 18:09:13.888401	2012-06-17 18:09:13.888401	2	Suspect	02 33 36 96 37	02 33 35 20 31		http://www.france-traitement.com	\N
359	FRENEHARD ET MICHAUX	ZA les Bredollieres		61300	ST SYMPHORIEN DES BRUYERES	FRANCE		Barrage secrétaire - Envoyer courrier electronique\r\n\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 53545005000120\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 4\r\nEffectif sur site \t: 200\t \tNombre de PC \t: 87\r\nEffectif société \t: 300\t \tActivité \t: Fabrication d'articles métalliques divers (287Q)\r\nEffectif informatique \t: 4\t \tNb sites interconnectés \t: 3\r\nEffectif Production \t: 10\t \tNb téléphones fixes \t: 30\r\nEffectif BE \t: 3\t \tNb téléphones mobiles \t: 30\r\n \r\n \r\n \r\n \t\r\n\tContacts\t\r\n \r\n \t\r\nCivilité\tNom\tPrénom\tFonction\tEmail\r\n \r\n  M  \t  FRENEHARD  \t  JACQUES  \t  PRESIDENT DIRECTEUR GENERAL  \t  jacques.frenehard@frenehard-michaux.com  \r\nCommentaire:  \r\n  M  \t  GAIGNARD  \t  JEAN CHRISTOPHE  \t  RESPONSABLE INFORMATIQUE  \t  jeanchristophe.gaignard@frenehard-michaux.com  \r\nCommentaire:  \r\n  M  \t  MOINNE LOCOZ  \t  PATRICK  \t  DIRECTEUR PRODUCTION  \t   \r\nCommentaire:  \r\n  M  \t  VAN HOORNE  \t  PHILIPPE  \t  DIRECTEUR ADMIN ET FINANCIER  \t  philippe.vanhoorne@frenehard-michaux.com  \r\nCommentaire:  \r\n  MLLE  \t  COTE  \t  ANNIE  \t  DIRECTEUR COMPTABLE  \t  annie.cote@frenehard-michaux.com  \r\nCommentaire:  \r\n  M  \t  FOUCAULT  \t  JEROME  \t  DIRECTEUR COMMERCIAL  \t  jerome.foucault@frenehard-michaux.com  \r\nCommentaire:  \r\n \r\n \r\n   \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs mini\tIBM\tISERIES\tOS 400\t1\t80\t03\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t1\t80\t05\r\nServeurs micro\tHP/COMPAQ\tTSE\tWINDOWS 2003\t1\t80\t05\r\nServeurs micro\tIBM\tSERVEUR\tWINDOWS 2003\t1\t\t09\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS XP\t43\t\t\r\nMicro\tHP/COMPAQ\tTW\tWINDOWS CE\t20\t\t\r\nPortable\tHP/COMPAQ\tPORTABLE\tWINDOWS XP\t20\t\t\r\nStation de travail\tDIVERS\tSTATION DE TRAVAIL\tWINDOWS XP\t3\t\t\r\nStation de travail\tHP/COMPAQ\tWORKSTATION\tWINDOWS XP\t1\t\t03\r\nMobilité\tAPPLE\tIPHONE\tIPHONE OS\t8\t\t12\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nTechnologie d accès\tBLR\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nOpérateur Fixe\tSFR\t\t\t\t\t\r\nOpérateur Fixe\tILIAD\tALTITUDE TELECOM\t\t\t\t\r\nPABX/IPBX\tAASTRA/MATRA TELECOM\t\t\t\t\t07\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tZYXEL\t\t\t\t\t\r\nSwitch\tHP/COMPAQ\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tDB2/BAS400\t\t\t\t\t\r\nCfao\tSOLID DESIGNER\t\t\t\t\t\r\nErp\tDIVERS\tALIZEE\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tEXCHANGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tZYXEL\t\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tMCAFEE\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tLEXMARK\t\t\t\t\t\r\nImprimantes\tRICOH\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t18\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tIBM\t\t\t\t\t\r\nStockage Software\tHP\tDATA PROTECTOR\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t800\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 18:12:14.399845	2012-06-17 18:12:14.399845	2	Suspect	02 33 84 21 21	02 33 24 45 12		http://www.frenehard-michaux.com	\N
362	GABRIEL EUROPE	Le Clos aux Moines		28800	BONNEVAL	FRANCE		Appartient à un groupe \t: Oui\t \tSIRET \t: 58202671200023\r\nGroupe \t: ARVINMERITOR\t \tType Ets \t: Siege\r\nSite informatique distant \t: Oui\t \tNombre de Serveurs \t: 3\r\nEffectif sur site \t: 127\t \tNombre de PC \t: 110\r\nEffectif société \t: 127\t \tActivité \t: Fabrication d'équipements automobiles (343Z)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 1\r\nEffectif Production \t: 60\t \tNb téléphones fixes \t: 80\r\nEffectif BE \t: 12\t \tNb téléphones mobiles \t: 10\r\n \r\n \r\n \r\n \t\r\n\tContacts\t\r\n \r\n \t\r\nCivilité\tNom\tPrénom\tFonction\tEmail\r\n \r\n  M  \t  CASTILLEAU  \t  ANTONIO  \t  DIRECTEUR GENERAL  \t   \r\nCommentaire:  \r\n  M  \t  NOYEAU  \t  FRANCIS  \t  RESPONSABLE INFORMATIQUE  \t   \r\nCommentaire:  \r\n  M  \t  LAUDIER  \t  THIERRY  \t  DIRECTEUR PRODUCTION  \t   \r\nCommentaire:  \r\n  M  \t  MENGAL  \t  JEAN FRANCOIS  \t  RESPONSABLE METHODE  \t   \r\nCommentaire:  \r\n  M  \t  JOLY  \t  FABRICE  \t  RESPONSABLE BUREAU D ETUDE  \t   \r\nCommentaire:  \r\n  M  \t  BOST  \t  EMMANUEL  \t  DIRECTEUR FINANCIER  \t   \r\nCommentaire:  \r\n  MME  \t  THOUVIGNON  \t  PAULINE  \t  RESPONSABLE QHSE  \t   \r\nCommentaire: 0237444811  \r\n \r\n \r\n   \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t3\t100\t09\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t90\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t20\t\t\r\nEcrans plats\tDELL\t\t\t90\t\t\r\nMobilité\tAPPLE\tIPHONE\tIPHONE OS\t5\t\t11\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tFIBRE OPTIQUE\t\t\t\t\t\r\nTechnologie d accès\tLL 512K\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t09\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tORACLE\t\t\t\t\t\r\nSgbd\tACCESS\t\t\t\t\t\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nCfao\tSOLIDWORKS\t\t\t\t\t\r\nErp\tMICROSOFT BS\tAXAPTA\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tEXCHANGE\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tLEXMARK\t\t\t\t\t\r\nImprimantes\tEPSON\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t40\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\tLTO\t\t\t\t\r\nStockage Hardware\tHP/COMPAQ\tDLT\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t600\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 19:06:11.650331	2012-06-17 19:06:11.650331	2	Suspect	02 37 44 48 00	02 37 44 48 24		http://www.arvinmeritor.com	\N
363	GANDON TRANSPORTS	Coulonges BP 410 Aron		53104	MAYENNE CEDEX	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 31548540900066\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 7\r\nEffectif sur site \t: 70\t \tNombre de PC \t: 32\r\nEffectif société \t: 180\t \tActivité \t: Transports routiers de marchandises interurbains (602M)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 2\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 40\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 140\r\n \r\n \r\n \r\n \t\r\n\tContacts\t\r\n \r\n \t\r\nCivilité\tNom\tPrénom\tFonction\tEmail\r\n \r\n  M  \t  GANDON  \t  JOEL  \t  PRESIDENT DIRECTEUR GENERAL  \t   \r\nCommentaire:  \r\n  M  \t  METAIRIE  \t  FABRICE  \t  RESPONSABLE INFORMATIQUE  \t  fabrice.metairie@gandon.fr  \r\nCommentaire:  \r\n  M  \t  LOUVARD  \t  FRANCK  \t  DIRECTEUR COMPTABLE  \t   \r\nCommentaire:  \r\n  MME  \t  MEROT  \t  SONIA  \t  DIRECTEUR COMMERCIAL  \t   \r\nCommentaire:  \r\n \r\n \r\n   \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2000\t5\t25\t05\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2003\t1\t25\t06\r\nServeurs risc\tIBM\tPSERIES\tUNIX\t1\t25\t04\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t25\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t7\t\t\r\nEcrans plats\tDELL\t\t\t24\t\t\r\nMobilité\tBLACKBERRY\tPDA\tRIM\t6\t\t07\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2000\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tWINDOWS 2000\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tSDSL\t\t\t\t\t\r\nOpérateur Fixe\tSFR\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t05\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nFourniss. Accès Internet\tSFR\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tD-LINK\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tORACLE\t\t\t\t\t\r\nSgbd\tPROGRESS\t\t\t\t\t\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nErp\tDIVERS\tPROGINOV\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tLOCAL\t\t\t\t\t\r\nIntranet\tINTRANET\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tAVG\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tLEXMARK\t\t\t\t\t\r\nImprimantes\tRICOH\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t12\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDELL\t\t\t\t\t\r\nStockage Software\tCOMPUTER ASSOCIATES\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t350\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 19:08:16.148894	2012-06-17 19:08:16.148894	2	Suspect	02 43 30 12 12	02 43 30 18 15		http://www.gandon.fr	\N
364	GENERALE FRANCAISE DE LITERIE	Lieu dit le Bord d'Eau		72530	YVRE L'EVEQUE	FRANCE		Mail envoyé. Elle ne prend pas par téléphone\r\n\r\nAppartient à un groupe \t: Oui\t \tSIRET \t: 37958310700030\r\nGroupe \t: COMPTOIR DE BOIS DANIEL SABBE\t \tType Ets \t: Siege\r\nSite informatique distant \t: Oui\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 30\t \tNombre de PC \t: 18\r\nEffectif société \t: 30\t \tActivité \t: Fabrication de matelas (361M)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 1\r\nEffectif Production \t: 16\t \tNb téléphones fixes \t: 15\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 3\r\n \r\n \r\n \r\n \t\r\n\tContacts\t\r\n \r\n \t\r\nCivilité\tNom\tPrénom\tFonction\tEmail\r\n \r\n  M  \t  CREPIN  \t  MICHEL  \t  DIRECTEUR GENERAL  \t   \r\nCommentaire:  \r\n  MME  \t  FALHUN  \t  FRANCOISE  \t  RESPONSABLE INFORMATIQUE  \t   \r\nCommentaire:  \r\n  M  \t  GUILLERME  \t  MARC  \t  DIRECTEUR PRODUCTION  \t   \r\nCommentaire:  \r\n  M  \t  VAUGARNY  \t  PASCAL  \t  RESPONSABLE MAINTENANCE  \t   \r\nCommentaire:  \r\n  MME  \t  MERCIER  \t  SYLVIE  \t  DIRECTEUR COMPTABLE  \t   \r\nCommentaire:  \r\n  MME  \t  BERNARD  \t  CHRISTEL  \t  DIRECTEUR COMMERCIAL  \t   \r\nCommentaire:  \r\n \r\n \r\n   \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2003\t1\t18\t10\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDELL\tPC\tWINDOWS XP\t15\t\t\r\nPortable\tDELL\tPORTABLE\tWINDOWS XP\t3\t\t\r\nEcrans plats\tDELL\t\t\t15\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tDIVERS\t\t\t\t\t\r\nPABX/IPBX\tAASTRA/MATRA TELECOM\t\t\t\t\t\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tOPERATEUR MOBILE\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tCISCO\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tACCESS\t\t\t\t\t\r\nGpao\tSPECIFIQUE\t\t\t\t\t\r\nCompta/Finance\tSPECIFIQUE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tDELL\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t3\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\tDAT\t\t\t\t\r\nStockage Software\tCOMPUTER ASSOCIATES\t\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t72\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 19:10:44.3949	2012-06-17 19:10:44.3949	2	Suspect	02 43 74 01 01	02 43 76 10 91		http://www.maliterie.com	\N
365	YSCO FRANCE	53, avenue de la 2e DB BP 229		61208	ARGENTAN CEDEX	FRANCE		Appartient à un groupe \t: Oui\t \tSIRET \t: 43531711000011\r\nGroupe \t: YSCO\t \tType Ets \t: Siege\r\nSite informatique distant \t: Oui\t \tNombre de Serveurs \t: 4\r\nEffectif sur site \t: 196\t \tNombre de PC \t: 80\r\nEffectif société \t: 196\t \tActivité \t: Fabrication de glaces et sorbets (155F)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 1\r\nEffectif Production \t: 100\t \tNb téléphones fixes \t: 80\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 23\r\n \r\n \r\n \r\n \t\r\n\tContacts\t\r\n \r\n \t\r\nCivilité\tNom\tPrénom\tFonction\tEmail\r\n \r\n  M  \t  JARDINET  \t  LAURENT  \t  CORRESPONDANT INFORMATIQUE  \t   \r\nCommentaire:  \r\n  MME  \t  TERNYNCK  \t  ISABELLE  \t  DIRECTEUR RESSOURCES HUMAINES  \t  isabelle.ternynck@ysco.eu  \r\nCommentaire:  \r\n  M  \t  GOHIER  \t  LIONEL  \t  DIRECTEUR PRODUCTION  \t  lionel.gohier@ysco.eu  \r\nCommentaire:  \r\n  MME  \t  GALLE  \t  MICHELLE  \t  ADJ DIRECTEUR ADMINISTRATIF  \t   \r\nCommentaire:  \r\n  MME  \t  DIVARET  \t  DOMINIQUE  \t  DIRECTEUR COMPTABLE  \t  dominique.divaret@ysco.eu  \r\nCommentaire:  \r\n  M  \t  LEROY  \t  PIERRE  \t  RESPONSABLE QHSE  \t   \r\nCommentaire:  \r\n \r\n \r\n   \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs mini\tIBM\tISERIES\tOS 400\t1\t70\t08\r\nServeurs micro\tIBM\tSERVEUR\tWINDOWS 2003\t1\t70\t08\r\nServeurs micro\tDELL\tSERVEUR\tWINDOWS 2003\t1\t70\t08\r\nServeurs risc\tSUN\tSERVEUR\tUNIX\t1\t70\t07\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tIBM/LENOVO\tPC\tWINDOWS XP\t62\t\t\r\nMicro\tIBM/LENOVO\tPC\tWINDOWS 7\t8\t\t\r\nPortable\tTOSHIBA\tPORTABLE\tWINDOWS XP\t10\t\t\r\nEcrans plats\tIBM\t\t\t70\t\t\r\nMobilité\tHTC\tPDA\tWINDOWS MOBILE\t2\t\t10\r\nMobilité\tNOKIA\tPDA\tWINDOWS MOBILE\t3\t\t11\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2003\t\t\t\t\r\nRéseaux locaux\tSANS FIL\t\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tFIBRE OPTIQUE\t\t\t\t\t\r\nTechnologie d accès\tSDSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t02\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nWAN\tVOIP\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tFUNKWERK\t\t\t\t\t\r\nSwitch\tCISCO\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tDB2/BAS400\t\t\t\t\t\r\nErp\tPEOPLE ENTERPRISE1/ORACLE\t\t\t\t\t\r\nErp\tMFGPRO\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tLOTUSNOTES\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tWATCHGUARD\t\t\t\t\t\r\nAntivirus\tSYMANTEC\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tDIVERS\tZEBRA\t\t\t\t\r\nImprimantes\tLEXMARK\t\t\t\t\t\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t14\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\tDLT\t\t\t\t\r\nStockage Hardware\tDIVERS\tLTO\t\t\t\t\r\nStockage Software\tSYMANTEC\tBACKUP EXEC\t\t\t\t\r\nCapacité\tCAPACITE\t\t\t2000	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 19:13:23.704776	2012-06-17 19:13:23.704776	2	Suspect	02 33 36 48 00	02 33 36 48 17		http://www.ysco.eu	\N
366	VOYAGES AIGLONS	ZI 1, route de Crulai BP 16		61302	L AIGLE CEDEX	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 33773492500031\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 50\t \tNombre de PC \t: 12\r\nEffectif société \t: 50\t \tActivité \t: Autres transports routiers de voyageurs (602G)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 1\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 11\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 20\r\n \r\n \r\n \r\n \t\r\n\tContacts\t\r\n \r\n \t\r\nCivilité\tNom\tPrénom\tFonction\tEmail\r\n \r\n  M  \t  GALPIN  \t  PIERRICK  \t  DIRECTEUR GENERAL  \t   \r\nCommentaire:  \r\n  M  \t  GUILLEMAIN  \t  HERVE  \t  PRESIDENT DIRECTEUR GENERAL  \t   \r\nCommentaire:  \r\n  MME  \t  BIANQUI  \t  MARIE NOELLE  \t  ADJ DIRECTEUR ADMINISTRATIF  \t   \r\nCommentaire:  \r\n  MME  \t  DUMOULIN  \t  MARTINE  \t  ADJ DIRECTEUR ADMINISTRATIF  \t   \r\nCommentaire:  \r\n \r\n \r\n   \r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS XP\t1\t10\t05\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tDIVERS\tPC\tWINDOWS XP\t10\t\t\r\nPortable\tHP/COMPAQ\tPORTABLE\tWINDOWS XP\t2\t\t\r\nEcrans plats\tLG/GOLDSTAR\t\t\t2\t\t\r\nMobilité\tBLACKBERRY\tPDA\tRIM\t2\t\t11\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS XP\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tRNIS\t\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tAASTRA/MATRA TELECOM\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tDIVERS\t\t\t\t\t\r\nRouteurs\tFUNKWERK\t\t\t\t\t\r\nSwitch\tDIVERS\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tACCESS\t\t\t\t\t\r\nCompta/Finance\tSAGE\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tDIVERS\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tCANON\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t3\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\t\t\t\t\t\r\nInfos Diverses\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nInfos Diverses\tFait appel a une ssii\t\t\t1\t\t\r\n   	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 19:16:15.598382	2012-06-17 19:16:15.598382	2	Suspect	02 33 24 30 00	02 33 34 59 15		http://www.voyagesaiglons.fr	\N
367	LAPLACE	48 r Marcel Proust 		72000	LE MANS	FRANCE			n.retout@sigire.fr	g.guivarch@sigire.fr	2012-06-18 10:02:36.112903	2012-06-18 16:03:19.374346	3	Client	02 43 50 24 70				\N
174	IMPRIMERIE ITF	RUE Pierre Mendès France		72230	MULSANNES				n.retout@sigire.fr	m.ozan@sigire.fr	2012-05-10 13:40:43.519597	2012-06-19 09:21:56.252512	3	Client	02 43 42 00 38				\N
291	BEQUET	12, rue du Prieuré		61400	COURGEON	FRANCE		Appartient à un groupe \t: Non\t \tSIRET \t: 53695017300016\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 2\r\nEffectif sur site \t: 70\t \tNombre de PC \t: 13\r\nEffectif société \t: 70\t \tActivité \t: Réalisation de couvertures par éléments (452J)\r\nEffectif informatique \t: 1\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 40\r\nEffectif BE \t: 1\t \tNb téléphones mobiles \t: 10\r\n \r\n \r\n Les serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2003\t2\t13\t09\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS XP\t13\t\t\r\nEcrans plats\tDIVERS\t\t\t13\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tGIGA ETHERNET\tTCPIP\t\t\t\t\r\nRéseaux locaux\tGIGA ETHERNET\tWINDOWS 2003\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tFRANCE TELECOM\t\t\t\t\t\r\nPABX/IPBX\tALCATEL LUCENT\t\t\t\t\t\r\nWAN\tVPN/IP VPN\t\t\t\t\t\r\nOpérateur Mobile\tORANGE\t\t\t\t\t\r\nFourniss. Accès Internet\tORANGE INTERNET\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\t3COM\t\t\t\t\t\r\nSwitch\tHP/COMPAQ\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nSgbd\tSQL SERVER\t\t\t\t\t\r\nCfao\tAUTODESK\t\t\t\t\t\r\nCompta/Finance\tEBP\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nIntranet\tINTRANET\t\t\t\t\t\r\nExtranet\tEXTRANET\t\t\t\t\t\r\nMessagerie\tEXCHANGE\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nProxy\tPROXY\t\t\t\t\t\r\nAntivirus\tNOD 32\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tBROTHER\t\t\t\t\t\r\nImprimantes\tSHARP\t\t\t\t\t\r\nImprimantes\tNB IMPRIMANTES\t\t\t4\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tDIVERS\tDLT\t\t\t\t\r\nStockage Software\tSTOCKAGE SOFTWARE\t\t\t\t\t\r\n   \r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 10:18:26.096046	2012-06-22 20:57:37.458559	1	Prospect	02 33 85 00 00	02 33 85 00 01			\N
52	BRULE TP	ZA du Coutier		72400	CHERE	FRANCE		 \t\r\nAppartient à un groupe \t: Non\t \tSIRET \t: 38249564600053\r\nGroupe \t: \t \tType Ets \t: Siege\r\nSite informatique distant \t: Non\t \tNombre de Serveurs \t: 1\r\nEffectif sur site \t: 90\t \tNombre de PC \t: 18\r\nEffectif société \t: 90\t \tActivité \t: Terrassements en grande masse (451B)\r\nEffectif informatique \t: 0\t \tNb sites interconnectés \t: 0\r\nEffectif Production \t: 0\t \tNb téléphones fixes \t: 20\r\nEffectif BE \t: 0\t \tNb téléphones mobiles \t: 30\r\n \r\n\r\n\r\nLes serveurs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nServeurs micro\tHP/COMPAQ\tSERVEUR\tWINDOWS 2000\t1\t15\t03\r\nLes postes de travail\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nMicro\tHP/COMPAQ\tPC\tWINDOWS XP\t15\t\t\r\nPortable\tHP/COMPAQ\tPORTABLE\tWINDOWS XP\t3\t\t\r\nEcrans plats\tHP/COMPAQ\t\t\t15\t\t\r\nLes réseaux\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRéseaux locaux\tFAST ETHERNET\tWINDOWS 2000\t\t\t\t\r\nRéseaux locaux\tFAST ETHERNET\tTCPIP\t\t\t\t\r\nTechnologie d accès\tADSL\t\t\t\t\t\r\nOpérateur Fixe\tSFR\t\t\t\t\t\r\nOpérateur Mobile\tSFR\t\t\t\t\t\r\nLes produits actifs\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nRouteurs\tDIVERS\t\t\t\t\t\r\nSwitch\tDIVERS\t\t\t\t\t\r\nLes logiciels\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nCompta/Finance\tEBP\t\t\t\t\t\r\nCommunication\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nWeb\tHEBERGE\t\t\t\t\t\r\nMessagerie\tOUTLOOK\t\t\t\t\t\r\nSécurité\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nFirewall\tFIREWALL\t\t\t\t\t\r\nAntivirus\tTREND MICRO\t\t\t\t\t\r\nImprimantes\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nImprimantes\tHP/COMPAQ\t\t\t\t\t\r\nStockage\t\r\nCatégorie\tMarque\tModele\tOS\tQuantite\tNb Term\tAnnée\r\nStockage Hardware\tHP/COMPAQ\t\t\t\t\t\r\n   \r\n	s.martin@sigire.fr	g.forestier@sigire.fr	2012-04-18 10:17:49.971427	2012-06-22 21:00:16.979919	2	Prospect	02 43 60 18 18	02 43 60 18 19		http://www.bruletp.com	\N
\.


--
-- Data for Name: comptes_produits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY comptes_produits (compte_id, produit_id) FROM stdin;
17	3
1	3
24	4
24	5
24	6
\.


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY contacts (id, nom, prenom, civilite, tel, fax, mobile, email, fonction, notes, created_by, modified_by, created_at, updated_at, compte_id) FROM stdin;
1	BLAIS	Marie	Mme					Responsable Administrative	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-15 17:53:53.147301	2012-04-15 17:53:53.147301	2
2	BLANCHET	Johann	M.	02 44 71 82 10		06 24 45 19 24 	johann.blanchet@labosport.com	Responsable informatique		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-15 19:05:26.620765	2012-04-15 19:05:45.19293	3
7	OLLIVIER	Delphine	Mme						\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-15 19:31:42.731718	2012-04-15 19:31:42.731718	6
5	VIVIER	Jean-Luc	M.	02 43 54 00 51		06 14 55 16 93	jeanlucvivier@moulinsreunis.fr	Directeur		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-15 19:16:14.637403	2012-04-16 07:47:27.440331	5
8	ROBERT	Jacques	M.					Directeur commercial	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-16 08:35:24.365046	2012-04-16 08:35:24.365046	3
14	RISSER	Johann	M.	08 05 54 01 23			risser.j@apple.com	Commercial	Extension : 489138	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-16 13:32:00.101415	2012-04-16 13:32:34.798543	12
13	MAURICE		M.			06 85 21 89 51				g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-16 13:14:52.523274	2012-04-16 13:37:45.494644	11
15	LORILLEUX		M.			06 23 78 02 92	p.lorilleux@andrebeule.com			n.retout@sigire.fr	n.retout@sigire.fr	2012-04-16 15:22:33.374392	2012-04-16 15:37:31.338565	14
17	LORET	Amélie	Mme	02 43 95 04 53			aloret@sablesienne.com	Gérante	\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-16 16:06:55.390851	2012-04-16 16:06:55.390851	13
18	GASSE	Elodie	Mme	02 43 95 04 53			contact@sablesienne.com	Assistante de gestion	\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-16 16:08:03.874922	2012-04-16 16:08:03.874922	13
19	CERQUEIRA	Irène	Mme	01 69 32 84 05	01 69 32 07 60		icerqueira@lacie.com	Chargée de compte		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-17 07:58:36.725934	2012-04-17 07:58:36.725934	16
28	GILLET	Elodie	Mme							m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-17 09:12:35.360397	2012-04-17 16:03:44.620812	15
22	HABRIAL	Dominique	M.					Directeur		n.retout@sigire.fr	n.retout@sigire.fr	2012-04-17 08:09:39.503479	2012-04-17 08:10:21.920247	17
24	GATTI	Marie	Mme	04 96 17 10 01		06 23 77 21 14	marie.gatti@futurtelecom.com	Responsable des Programmes Partenaires		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-17 08:41:53.13308	2012-04-17 08:41:53.13308	18
25	BELLIER	Isabelle	Mme	02 51 13 25 90			isabelle.bellier@futurtelecom.com			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-17 08:43:38.742892	2012-04-17 08:43:38.742892	18
26	MAESTRE	Pascale	Mme	02 51 13 25 96		06 18 66 32 29	pascale.maestre@futurtelecom.com	Directrice Région Ouest		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-17 08:45:04.281714	2012-04-17 08:45:04.281714	18
27	DE LANOUVELLE	Ludovic	M.					Associé	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-17 08:49:24.211502	2012-04-17 08:49:24.211502	19
41	DERVAL	Pierrick	M.				pderval@deutsch.net	Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 10:06:15.388395	2012-04-18 10:06:15.388395	48
29	PORTES	Jean-Michel	M.	05 57 35 63 21	05 56 89 14 05	06 19 02 73 80	jean-michel.portes@funkwerk-ec.com	Contact technique		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-17 12:15:03.235803	2012-04-17 12:15:03.235803	20
30	CHARBONNIER	Béatrice	Mme				bcharbonnier@albea.fr	PDG		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-17 13:03:23.134426	2012-04-17 13:03:23.134426	21
20	L'HELGUEN	Patrick	M.				patrick.lhelguen@habrial.fr	Directeur		n.retout@sigire.fr	n.retout@sigire.fr	2012-04-17 08:09:09.735147	2012-04-17 13:04:29.586518	17
21	PAPIN	Marie-Christine	Mme							n.retout@sigire.fr	n.retout@sigire.fr	2012-04-17 08:09:22.941304	2012-04-17 13:05:25.090341	17
31	BLANC		Mme						\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-17 13:05:52.138247	2012-04-17 13:05:52.138247	7
34	MAHE	Marie-Pierre	Mme					Responsable des achats	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-17 15:26:10.84426	2012-04-17 15:26:10.84426	23
37	MORGAND	Loys	M.				lmorgand@i-cone.fr	Chef de projet	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 08:41:45.804502	2012-04-18 08:41:45.804502	28
33	SABOUREAU	Christophe	M.	02 43 57 45 92	02 43 57 45 15		christophe.saboureau@sesam-vitale.fr	Ingénieur Réseaux	Contact technique pour les accès internet	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-17 15:25:45.201941	2012-04-18 08:45:21.995117	23
12	ROSAY		Mme	02 43 40 21 87						g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-16 13:10:42.101254	2012-04-27 08:41:27.805306	10
36	LE DILLY	Olivier	M.	08 25 82 80 80		06 76 73 57 58	o.le.dilly@imsbackup.com	Gérant		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 08:40:00.1992	2012-04-18 08:48:05.088201	26
38	CANDIDATURE	Marchés Publics	M.				candidature@sesam-vitale.fr		\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 08:52:33.327697	2012-04-18 08:52:33.327697	23
40	VANLIERDE	Frédéric	M.	02 41 73 00 22			f.vanlierde@anact.fr	Conseiller	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 09:41:02.920601	2012-04-18 09:41:02.920601	21
44	CULLATI	Juan	M.	02 53 04 82 36	02 43 77 15 56	06 60 52 73 96	j.cullati@axione.fr	Responsable développement local	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 10:10:01.698627	2012-04-18 10:10:01.698627	50
45	LOBEZ	Stanislas	M.			06 64 54 66 21	s.lobez@axione.fr	Directeur	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 10:10:46.474572	2012-04-18 10:10:46.474572	50
43	MARTINEAU	Rodolphe	M.			06 66 20 28 36	r.martineau@axione.fr	Responsable Commercial		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 10:09:00.411769	2012-04-18 10:12:05.61746	50
47	PEREZ	Carmen	Mme				cperez@opcom.fr	Assistante commerciale	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 10:20:41.144737	2012-04-18 10:20:41.144737	53
10	LEVERT	Franck	M.	02 43 72 74 28		06 22 98 27 91		Gérant		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-16 09:14:27.243571	2012-04-20 07:43:25.706976	55
6	BROU	Jean-Louis	M.	0243874373		0608317853		Maire	Maire d'Yvré Le POLIN.	g.forestier@sigire.fr	m.ozan@sigire.fr	2012-04-15 19:20:30.1227	2012-05-07 13:28:55.519046	4
9	PERRAULT	Mickaël	M.	02 43 48 19 16		06 82 94 72 48	mperrault@zoo-la-fleche.com	Responsable informatique		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-16 08:40:10.899514	2012-04-23 08:31:13.622982	8
39	OSSUN	Isabelle	Mme			06 15 21 54 14	iossun@destinationcircuit.com	Responsable		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 09:20:48.356485	2012-04-23 09:41:15.283342	36
16	SEVERE	Christine	Mme				info@cis-sipod.fr	Responsable informatique		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-16 15:52:50.199267	2012-04-24 07:25:28.779056	15
11	GESLIN	Stéphane	M.				stephane.geslin@geslin-sas.fr			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-16 09:28:52.376635	2012-04-24 08:27:07.724452	1
35	MONCHATRE	Benoît	M.	08 25 82 80 80		06 43 78 48 46	benoit@imsbackup.com	Technicien	Pour le support préférer le "support@imsbackup.com" !	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 08:37:53.788679	2012-04-26 08:09:17.094063	26
3	RIBOULET	Sébastien	M.	02 43 87 42 48 		06 65 26 00 54	communeyvrelepolin@wanadoo.fr 			g.forestier@sigire.fr	m.ozan@sigire.fr	2012-04-15 19:09:49.66183	2012-05-04 08:09:05.361257	4
46	BERGERET	François	M.			06 99 40 60 83	fbergeret@opcom.fr	Directeur		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 10:20:14.427924	2012-05-10 09:46:09.702446	53
32	GUEHO	Jean-Baptiste	M.				jbgueho@serac.fr	Responsable SI		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-17 14:14:14.375269	2012-05-15 14:53:52.932198	22
23	HABRIAL	Didier	M.				didier.habrial@habrial.fr	Directeur		n.retout@sigire.fr	m.ozan@sigire.fr	2012-04-17 08:10:55.968283	2012-05-24 14:20:15.482904	17
42	CRAPIS		M.				acrapis@deutsch.net	Responsable informatique		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 10:06:32.971825	2012-04-18 17:02:24.870159	48
48	LE ROYER	Alexandre	M.						\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-19 08:41:34.487379	2012-04-19 08:41:34.487379	32
52	PLU		Mme	02 43 75 94 58	02 43 75 97 43			Assistante commerciale		s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 13:34:19.537859	2012-04-19 13:34:19.537859	30
51	SAILLARD	Sylvie	Mme	02 43 84 95 95				Gerante		s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 13:26:36.605664	2012-04-19 13:35:19.327808	29
87	MONACHON	Frédéric	M.	02 43 46 76 43	02 43 46 76 42		direction@anti-germ.fr	DG	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-25 08:32:24.070151	2012-04-25 08:32:24.070151	128
53	BRULE	Alain	M.	02 43 60 76 58				Gerant		s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 13:38:44.721662	2012-04-19 13:38:44.721662	31
54	LEROYER	Alexandre	M.	02 43 84 77 88	02 43 84 79 61					s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 13:46:17.608535	2012-04-19 13:46:17.608535	32
55	SALIDO	Juan	M.		02 43 35 49 18	02 43 35 48 82		Gerant		s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 13:52:31.483607	2012-04-19 13:52:31.483607	34
56	FROGER	Jean-Luc	M.	02 43 89 01 07				Gerant		s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 13:54:20.915606	2012-04-19 13:54:20.915606	35
57	GUICHARD		Mme	02 43 29 03 51	02 43 29 03 52			Secrétaire		s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 13:56:47.296618	2012-04-19 13:56:47.296618	37
58	VALLEE	Louis	M.	02 43 24 31 71	02 43 28 20 03			Gerant		s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 14:04:48.393875	2012-04-19 14:04:48.393875	38
59	BRILLAND	Philippe	M.	02 43 76 39 93				Responsable		s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 14:11:22.065396	2012-04-19 14:11:22.065396	39
60	BESOMBES	Alain	M.	02 43 89 01 68				Directeur		s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 14:14:02.248953	2012-04-19 14:14:02.248953	43
50	DESUR	PhIlippe	M.					Gerant		s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 13:23:04.223151	2012-04-19 14:14:17.893408	27
61	LEVASSEUR		M.							s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 14:15:13.152418	2012-04-19 14:15:13.152418	44
64	CHLOPIN	Christian	M.	02 43 87 01 58	02 43 87 01 11			Directeur adjoin		s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 14:31:10.096392	2012-04-19 14:31:10.096392	49
65	CULERIER		Mme	02 43 40 14 15	02 43 40 05 02					s.martin@sigire.fr	s.martin@sigire.fr	2012-04-19 14:36:12.579309	2012-04-19 14:36:12.579309	51
67	CELLE	Olivier	M.	02 43 39 96 66						s.martin@sigire.fr	s.martin@sigire.fr	2012-04-20 08:02:56.188274	2012-04-20 08:02:56.188274	56
68	CHALAIN	Erick	M.	02 43 76 05 57						s.martin@sigire.fr	s.martin@sigire.fr	2012-04-20 08:13:20.316067	2012-04-20 08:13:20.316067	58
70	VINCENT		M.	02 43 55 17 80						s.martin@sigire.fr	s.martin@sigire.fr	2012-04-20 08:48:29.417791	2012-04-20 08:48:29.417791	62
69	BLIN		M.	02 43 23 96 09						s.martin@sigire.fr	s.martin@sigire.fr	2012-04-20 08:27:24.697571	2012-04-20 08:48:46.632413	61
71	ROISNE	Sabine	Mme	02 43 84 21 50				Directrice		s.martin@sigire.fr	s.martin@sigire.fr	2012-04-20 09:15:48.900001	2012-04-20 09:15:48.900001	99
72	ROUILLARD	Didier	M.							s.martin@sigire.fr	s.martin@sigire.fr	2012-04-20 09:17:24.660165	2012-04-20 09:17:24.660165	100
73	GOUPIL		M.	02 43 40 00 90	02 43 40 00 66					s.martin@sigire.fr	s.martin@sigire.fr	2012-04-20 09:25:49.613754	2012-04-20 09:25:49.613754	101
74	FOUCAULT PLACAIS	Frédéric	M.							s.martin@sigire.fr	s.martin@sigire.fr	2012-04-20 09:54:23.201688	2012-04-20 09:54:23.201688	106
89	BOUVET	Isabelle	M.					Assistante	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-25 08:33:20.608313	2012-04-25 08:33:20.608313	128
75	THULLIER	Marc	M.					Gestionnaire		s.martin@sigire.fr	s.martin@sigire.fr	2012-04-20 13:01:51.960865	2012-04-20 13:07:18.452053	107
4	BELLANGER	Jean-François	M.			06 50 85 72 48	jf.bellanger@yvre-le-polin.com	Responsable informatique		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-15 19:12:49.409374	2012-04-23 08:28:28.738668	4
76	DE RIENZO	Pascal	M.	02 90 92 05 55	02 43 29 61 68		pascal@datagrex.com	Directeur Technique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-23 09:35:41.954156	2012-04-23 09:35:41.954156	123
77	DAVAULT	Cindy	Mme				comptabilite@cis-sipod.fr		\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-24 07:18:29.385332	2012-04-24 07:18:29.385332	15
78	NICOLET	Julien	M.	02 43 75 94 58			j.adekma@orange.fr	Responsable administratif	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-24 13:47:27.117168	2012-04-24 13:47:27.117168	2
79	BILLOT	Christophe	M.			06 11 32 87 74			\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-24 14:13:42.887585	2012-04-24 14:13:42.887585	36
80	LECOCQ	Sébastien	M.	01 41 91 55 82 		06 77 09 16 19	sebastien.lecocq@avnet.com	Responsable Avant-Vente 	\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-24 14:40:44.606492	2012-04-24 14:40:44.606492	125
90	MIREBEAU	Estelle	Mme				e.mirebeau@medisport.fr	Directrice		m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-25 08:56:24.349007	2012-04-25 08:56:24.349007	129
81	PLESSE	Hervé	M.	01 41 91 55 86		06 10 48 60 22	Herve.PLESSE@avnet.com	Commercial référant		m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-24 14:52:13.467267	2012-04-24 15:20:23.575152	125
86	DREUX	Bruno	M.				bruno.dreux@habrial.fr			m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-25 07:17:40.927492	2012-04-25 07:20:54.031614	17
91	CAMUS	Valérie	Mme				valerie.camus@juriouest.fr	Avocate	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 06:49:38.838123	2012-04-26 06:49:38.838123	130
92	VANNIER		Mme					Assistante	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 06:49:52.600078	2012-04-26 06:49:52.600078	130
93	DELARUE	Nicolas	M.				ndelarue@cosnet.fr	Service Achats	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 07:36:23.799861	2012-04-26 07:36:23.799861	104
94	DUTERTRE	Charly	M.			06 17 02 30 75		Gérant	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 07:53:13.066728	2012-04-26 07:53:13.066728	131
95	ECARLAT	Sébastien	M.	02 40 32 16 90	02 40 32 16 91	06 17 33 27 62	secarlat@cris-reseaux.com	Chef d'agence		m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-26 08:32:53.937202	2012-04-26 08:33:43.96696	132
96	BERTAGNA 	Magalie 	Mme	02 40 32 16 90	02 40 32 16 91		mbertagna@cris-reseaux.com	Assistante		m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-26 08:33:30.853991	2012-04-26 08:40:58.225152	132
97	OGER	Martine	Mme				moger@albea.fr	Comptable		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 12:20:35.140656	2012-04-26 12:20:48.69058	21
98		Nadine	Mme					Comptable	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 12:45:34.954903	2012-04-26 12:45:34.954903	130
101	BELLOIS	Bruno	M.					Commercial	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 14:21:53.072226	2012-04-26 14:21:53.072226	17
102	DA COSTA		M.						\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 14:44:31.58022	2012-04-26 14:44:31.58022	135
63	BELLESORT	Franck	M.					Gerant		s.martin@sigire.fr	g.forestier@sigire.fr	2012-04-19 14:24:49.579662	2012-04-29 16:44:16.25509	46
88	BLIN	Laurent	M.	02 43 46 71 72		06 80 11 29 43	lblin@anti-germ.fr	Contrôleur de gestion		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-25 08:33:06.550117	2012-05-29 09:47:42.742565	128
49	LHERMITTE	David	M.	02 43 7650 50	02 43 76 50 60			Responsable		s.martin@sigire.fr	Manuel OZAN	2012-04-19 13:19:27.475085	2012-07-17 13:03:29.35847	24
62	BEAUPOUX		M.	02 43 85 97 45	02 43 85 67 37	06 14 07 72 96	c.beaupoux@bccharpentes.fr	Gerant		s.martin@sigire.fr	g.forestier@sigire.fr	2012-04-19 14:23:12.934514	2012-05-31 14:38:44.95438	45
99	LEVERRIER	Hervé	M.				hleverrier@cosnet.fr	Responsable Supply Chain		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 13:06:56.336243	2012-04-26 15:00:38.992937	104
103	STRABONI	Marianne	Mme	02 43 40 24 72			m.straboni@lemans.org	Service comptabilité	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-27 07:34:27.865073	2012-04-27 07:34:27.865073	136
104	GERARD	Fabrice	M.	02 43 40 24 86		06 10 45 64 69	f.gerard@lemans.org	Service informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-27 07:35:29.699191	2012-04-27 07:35:29.699191	136
105	VAILLE	Laurence	Mme	02 43 40 24 96	02 43 40 21 25		l.vaille@lemans.org	Service comptabilité	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-27 07:36:46.136394	2012-04-27 07:36:46.136394	136
107	BAILLIEUX	Michèle	Mme	02 43 40 25 12			m.baillieux@lemans.org	DRH		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-27 07:40:15.550175	2012-04-27 07:40:36.264707	136
108	HOULBERT	Frédéric	M.	02 43 40 25 47			f.houlbert@lemans.org	Gestionnaire de Paie	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-27 07:41:26.168795	2012-04-27 07:41:26.168795	136
109	GEOFFROY	Laurent	M.			06 61 12 56 73 	laurent@watt-communication.fr	Dev Web	\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-27 08:18:12.848333	2012-04-27 08:18:12.848333	137
110	FAVRE	Guillaume	M.			06 60 35 93 82	guillaume.favre@eklo-design.com	Dev Web		m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-27 09:43:17.793834	2012-04-27 09:44:05.806613	138
112	CRIS	Support	M.	08 92 69 55 79			support@cris-reseaux.com		\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-27 13:36:39.599687	2012-04-27 13:36:39.599687	132
114	PRIOLLAUD	François	M.			06 12 70 20 97	fp@ariane.fr	PDG		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-30 06:31:55.895842	2012-04-30 06:32:20.506663	139
115	BROCHET	Pascale	Mme					Scrétaire		m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-30 07:54:11.276028	2012-04-30 07:59:13.091399	129
117	VANNIER	Guillaume	M.	02 43 92 80 00			guillaume.vannier@lamandorle.com		\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-30 08:32:37.892027	2012-04-30 08:32:37.892027	142
119	LOUALI	Benali	M.				louali@cojef.fr	Avocat	\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-30 12:04:33.109553	2012-04-30 12:04:33.109553	145
120	BOBELIN	Yves	M.				yvesbobelin@moulindeligne.fr	Directeur	\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-30 12:50:49.005938	2012-04-30 12:50:49.005938	146
121	BROQUN	Patricia	M.	01 30 28 91 98				Comptable et contact technique	\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-30 12:57:08.490197	2012-04-30 12:57:08.490197	146
122	DUTERTRE	Thomas	M.	02 43 89 51 68			thomasdutertre@moulinsreunis.fr	Boulanger	Situé à la boulangerie à CHAMPAGNE.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-30 13:17:34.911296	2012-04-30 13:18:54.826173	5
113	PRIOLLAUD	Marie-Dominique	Mme			06 03 51 20 08	mdp@ariane.fr			g.forestier@sigire.fr	m.ozan@sigire.fr	2012-04-30 06:31:23.933613	2012-04-30 13:23:12.734027	139
123	MASSOT	Nathalie	M.						\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-30 15:31:19.417221	2012-04-30 15:31:19.417221	38
124		Aurore	M.						\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-30 15:36:19.432854	2012-04-30 15:36:19.432854	38
125	GARNIER	Elodie	Mme						\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-02 07:29:40.375735	2012-05-02 07:29:40.375735	36
146	GENTY	Gérard	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 13:49:06.292854	2012-05-09 13:49:06.292854	165
126	COSNET	Alban	M.				acosnet@galva-72.fr	Dirigeant	\N	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-02 08:41:35.461477	2012-05-02 08:41:35.461477	147
106	FURET	Franck	M.				franck.furet@habrial.fr			g.forestier@sigire.fr	m.ozan@sigire.fr	2012-04-27 07:38:12.360476	2012-05-03 09:56:41.254392	17
129		Véronique	M.	02 33 80 39 60				Contact Alençon	Contact sur le site d'Alençon	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-02 09:10:34.205368	2012-05-02 09:11:04.750819	148
128		Olivier	M.	02 33 80 39 60				Contact Alençon	Contact sur le site d'Alençon	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-02 09:10:04.059342	2012-05-02 09:11:15.667311	148
130	SAV		M.	08 92 70 01 31			sav@actn.fr	Service après-vente	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-02 09:17:46.127779	2012-05-02 09:17:46.127779	149
131	JOYEUX	Katia	M.						\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-02 09:27:00.295963	2012-05-02 09:27:00.295963	1
127	CHAPEAU	Amaria	M.	02 43 50 19 82			achapeau@neuf.fr	Responsable informatique		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-02 09:09:33.564239	2012-05-02 12:43:38.465236	148
132	THUAUDET	Emmanuel	M.					Gérant	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-02 13:18:43.957881	2012-05-02 13:18:43.957881	150
133	PANNIER	Dominique	M.			06 08 25 33 61		Associé		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-02 13:19:32.37867	2012-05-02 13:19:49.357657	150
135	FARENEAU	Olivier	M.				olivier.fareneau@mosaine.com	Responsable internet	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-04 08:50:37.944574	2012-05-04 08:50:37.944574	152
136	FOURNIER	Thierry	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-04 09:59:46.663038	2012-05-04 09:59:46.663038	157
137	LE TROUHER	Olivier	M.	01 40 52 84 65			olt@force-ouvriere-hebdo.fr	Webmaster - Journaliste	\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-04 11:50:05.9923	2012-05-04 11:50:05.9923	158
138	VEYRIER	Yves	M.				yves.veyrier@force-ouvriere.fr	Secrétaire confédéral chargée du Secteur Communication	\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-04 11:51:32.184578	2012-05-04 11:51:32.184578	158
139	CAMPION	Kevin	M.	02 43 72 26 27			k.campion@prefeo.fr	Webmaster	\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-04 12:30:38.939087	2012-05-04 12:30:38.939087	141
140	CHALOPIN	Séverine	M.						\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-04 14:50:54.230574	2012-05-04 14:50:54.230574	17
141	EVRARD	Loïc	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 07:47:52.449867	2012-05-09 07:47:52.449867	159
142	BLIN	Régis	M.			06 09 79 00 09	regisblin@wanadoo.fr	Gérant	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-09 09:02:59.875999	2012-05-09 09:02:59.875999	60
143	Xavier	BOURGEAIS	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 13:30:55.190001	2012-05-09 13:30:55.190001	162
144	Jean-François	CHIRON	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 13:32:38.390735	2012-05-09 13:32:38.390735	163
145	MONNIER	Christophe	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 13:37:00.605855	2012-05-09 13:37:00.605855	164
147	GOURMEL	Eric	M.							g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 14:14:23.795358	2012-05-09 14:19:28.85978	167
148	LUCAS	Bruno	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 14:21:13.599309	2012-05-09 14:21:13.599309	168
149	QUEMERE	Françoise	Mme						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 14:59:51.54724	2012-05-09 14:59:51.54724	169
151	GERMAIN	Philippe	M.				direction.lemans@speedpark.fr	Direction site du Mans	\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 15:09:01.070868	2012-05-09 15:09:01.070868	170
111	MAIGROT	Anne	Mme				am@ariane.fr			g.forestier@sigire.fr	m.ozan@sigire.fr	2012-04-27 09:47:09.113456	2012-05-29 07:45:14.883605	139
134	PORTE	Béatrice	Mme			06 73 27 23 67	beatriceporte@moulinsreunis.fr	Responsable qualité		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-02 15:04:40.824283	2012-06-11 07:19:49.444476	5
116	PARIS	Hervé	M.	02 43 72 77 78		06 17 08 56 13	h.paris@prefeo.fr			m.ozan@sigire.fr	g.forestier@sigire.fr	2012-04-30 08:11:58.225518	2012-06-14 08:42:44.929702	141
150	FONTAINE	Stéphane-Paul	M.							g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 15:03:13.44162	2012-05-09 15:09:17.111597	170
152	JEGOU	Gaëlle	Mme				assistante.direction@speedpark.fr	Assistante de direction (Assistante de M. Fontaine)	\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 15:10:21.029452	2012-05-09 15:10:21.029452	170
153	FOUGEROLLE	Claude	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 15:20:06.347138	2012-05-09 15:20:06.347138	171
154	TREMOUREUX	Loïc	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-10 08:14:23.233819	2012-05-10 08:14:23.233819	172
155	MACHERET		M.				FONDERIE.ART.MACHERET@WANADOO.FR		\N	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-10 13:35:59.088088	2012-05-10 13:35:59.088088	173
156	BREMON	NICOLAS	M.				nicolas@itf-imprimeurs.fr		\N	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-10 13:41:10.905439	2012-05-10 13:41:10.905439	174
157	SEVERE	CHRISTINE	M.				christine@itf-imprimeurs.fr		\N	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-10 13:41:38.89373	2012-05-10 13:41:38.89373	174
158	DABEL	Frédéric	M.	01 49 63 92 50			f.dabel@ecoffi.com	Technicien	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-10 14:01:53.620572	2012-05-10 14:01:53.620572	175
159		Olivier	M.	01 49 63 92 50				Technicien	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-10 14:02:10.226763	2012-05-10 14:02:10.226763	175
161	GIRAULT	Flore	M.						\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-10 15:56:06.80298	2012-05-10 15:56:06.80298	36
162	PETIT	Jérôme	M.				j.petit@lavigne.fr		\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-10 17:03:17.745495	2012-05-10 17:03:17.745495	177
163	DESHAYES	Laurent	M.							g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-11 07:51:17.741828	2012-05-11 07:54:35.705959	178
164	BOUGET	Denis	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-11 08:39:51.685217	2012-05-11 08:39:51.685217	180
191	OLIVIER	Alassane	M.	01 76 77 37 57			aolivier1@lenovo.com	Chargé de comptes partenaires	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-18 07:25:39.554307	2012-05-18 07:25:39.554307	208
165	WEBER	Serge	M.				direction@thyssen.fr	direction		g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-11 08:48:52.370944	2012-05-14 12:57:04.409629	181
167	BELLOY	Jean-Philippe	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 13:10:04.116986	2012-05-14 13:10:04.116986	184
160	LETOURNEUX	Christian	M.	02 43 48 20 76			christian.letourneux@lacme.com	Responsable informatique		g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-10 15:01:33.074469	2012-05-14 13:36:16.167115	176
168	GREMY	Olivier	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 13:39:15.335323	2012-05-14 13:39:15.335323	186
169	CHARRIER	Eric	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 13:42:02.638703	2012-05-14 13:42:02.638703	187
170	NOUYOU	Jean-Luc	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 13:47:00.004664	2012-05-14 13:47:00.004664	189
172	LADOUL	Karim	M.	01 49 97 59 78			karim.ladoul@arrowecs.fr	Spécialiste Polycom		m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-14 14:44:53.857198	2012-05-14 14:47:40.994043	191
173	HERY	Jean-Louis	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 15:02:48.09873	2012-05-14 15:02:48.09873	192
174	GRIVEAU	François	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 15:06:56.588596	2012-05-14 15:06:56.588596	193
175	SARELOT	Stéphane	M.			06 21 60 28 49	stephane.sarelot@gmail.com	Commercial	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-15 07:02:34.712891	2012-05-15 07:02:34.712891	102
176	DOISNEAU	Fabrice	M.	02 43 64 14 42				Contact Laval	\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-15 07:30:32.92861	2012-05-15 07:30:32.92861	148
171	FOURNIER	Bertrand	M.			06 23 39 43 92				g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 13:50:17.528119	2012-05-15 08:37:47.651335	190
178	THOS	Patrick	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 09:43:09.216909	2012-05-15 09:43:09.216909	194
179	FAURE	Chantal	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 09:44:37.839708	2012-05-15 09:44:37.839708	195
180	LUCET	Sylvie	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 09:51:30.137832	2012-05-15 09:51:30.137832	196
181	VIENNE	Philippe	M.					Directeur	\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-15 09:52:07.694355	2012-05-15 09:52:07.694355	102
182	ROCHEFORT	Stéphane	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 14:41:00.051416	2012-05-15 14:41:00.051416	197
118	BEAU	Mickaël	M.	02 43 39 12 39		06 20 10 41 49	mickael.beau@segeca.com	Admin système et réseau		m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-30 09:16:34.438423	2012-05-18 12:16:57.242614	143
183	ROBERT	François	M.	01 47 86 43 43			groupe.transflex@wanadoo.fr			g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 14:44:54.930564	2012-05-15 14:48:54.228025	200
184	ROSIETTE		M.							g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 15:00:46.485766	2012-05-15 15:02:33.929137	201
185	GAZERES	Patrick	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 15:05:55.348711	2012-05-15 15:05:55.348711	202
186	LERET	Eric	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 15:19:36.382185	2012-05-15 15:19:36.382185	203
187	NIOT	Thierry	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 15:22:26.005522	2012-05-15 15:22:26.005522	204
188	QUERU	Emmanuel	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 15:43:36.529373	2012-05-15 15:43:36.529373	205
192	CONAN	Gaïc	M.	01 47 62 80 05			gconan@vmware.com	Inside Partner Business Manager	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-18 15:19:32.983654	2012-05-18 15:19:32.983654	209
189	LE BIHAN	Pascal	M.				pascal@oceanet.com	Technicien		m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-16 07:57:49.45994	2012-05-16 07:59:59.363041	206
190	MOISON-PICHARD	Sylvie	Mme	02 43 28 97 97	02 43 28 14 20	07 77 26 10 48	s.moison-pichard@ligepack.com	Directrice		i.moison@sigire.fr	i.moison@sigire.fr	2012-05-16 13:05:40.964575	2012-05-16 13:05:40.964575	207
193	KHALFOUNI	Guilaume	M.	01 53 05 99 64			vmwarefr2@pnbemea.com	Marketing Bureau	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-18 15:20:30.134935	2012-05-18 15:20:30.134935	209
194	SUPPORT PARTENAIRES		M.	01 47 62 80 20			partnernetwork@vmware.com	Support Partenaires	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-18 15:21:55.220783	2012-05-18 15:21:55.220783	209
195	FRIBAULT	Vincent	M.	02 41 24 13 57			vincent.fribault@ville.angers.fr	Responsable informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-21 09:25:29.531203	2012-05-21 09:25:29.531203	210
197		Christelle	Mme				medisport-group@wanadoo.fr		\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-21 15:28:22.337358	2012-05-21 15:28:22.337358	129
198	PUREN	Régis	M.			06 78 04 27 93		Gérant	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-21 15:33:57.327339	2012-05-21 15:33:57.327339	212
199	CHAVERON	Emmanuel	M.					PDG	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-22 08:23:32.385416	2012-05-22 08:23:32.385416	213
200	BLIN	Régis	M.				regis.blin@creationcuisinesetbains.fr	Gérant		m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-22 08:45:10.67592	2012-06-22 07:50:33.621925	214
196	BOUSSER	Dominique	M.	02 43 72 45 85			dominique.bousser@wanadoo.fr	Vétérinaire		g.forestier@sigire.fr	m.ozan@sigire.fr	2012-05-21 13:02:19.038973	2012-05-23 15:34:24.539509	211
166	ALLIGIER	Marie	Mme	02 43 21 22 08			m.alligier@myoken.fr	Responsable		m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-11 12:42:21.152995	2012-07-02 20:20:29.399566	182
202	TABUT	Emmanuel	M.				emmanuel.tabut@bouet.fr	Service Comptabilité	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-22 08:48:31.839119	2012-05-22 08:48:31.839119	213
100		Pauline	Mme				secretariat@prunier.fr	Secrétaire		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 13:37:55.880156	2012-05-22 09:48:39.844394	97
204	COSNET	Marie-Christine	Mme				mcosnet@orange.fr	Service Comptabilité	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-22 10:15:19.24473	2012-05-22 10:15:19.24473	144
205	ROBERT		M.				sav@ponthou.fr	Responsable SAV	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-23 07:10:41.922876	2012-05-23 07:10:41.922876	148
177	GROSSO	Serge	M.				sgrosso@cris-reseaux.com	Support CRIS-RESEAU		m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-15 08:48:42.706788	2012-05-23 07:27:54.155098	132
206	QUERU	Sébastien	M.				sebastien.queru@querudistribution.fr		\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-23 08:51:09.500229	2012-05-23 08:51:09.500229	205
207	USCLADE	Serge	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-23 09:25:55.871945	2012-05-23 09:25:55.871945	216
208	BAZANTAY 	Jerome	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-23 09:32:31.757111	2012-05-23 09:32:31.757111	217
209	GROLLEAU 	Olivier	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-23 09:41:13.921408	2012-05-23 09:41:13.921408	218
210	MOUTIERS	Dominique	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-23 09:47:14.066697	2012-05-23 09:47:14.066697	219
211	CASTELAIN	Bruno	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-23 09:54:57.009619	2012-05-23 09:54:57.009619	220
212	FRESLON	Nadia	M.						\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-23 14:51:54.312369	2012-05-23 14:51:54.312369	17
213	ROLLAND	Sylvain	M.			06 21 50 23 93	fscrolland@wanadoo.fr	Gérant	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-23 15:44:52.076331	2012-05-23 15:44:52.076331	221
214	JOUVET	Eric	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-24 08:35:41.187209	2012-05-24 08:35:41.187209	222
216	CARREAU	Nathalie	Mme	02 43 61 45 16				Responsable Paie	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-24 13:36:35.124052	2012-05-24 13:36:35.124052	48
217	Support	POLYCOM	M.	01 49 97 49 21					\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-24 13:58:46.853394	2012-05-24 13:58:46.853394	191
218	VERON	Cécile	Mme					Responsable informatique	\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-24 14:18:09.688164	2012-05-24 14:18:09.688164	224
219	TROUILLET 	Gerard	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-24 14:20:51.446706	2012-05-24 14:20:51.446706	225
220	GROB	Bruno	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-24 14:24:19.814301	2012-05-24 14:24:19.814301	226
221	BRAYET	Samuel	M.	01 49 97 59 69			samuel.brayet@arrowecs.fr	Technicien POLYCOM		m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-24 14:56:27.721375	2012-05-24 14:56:51.498851	191
222	BERTIN	Murielle	Mme	02 43 35 13 91			tpmbatiment@orange.fr			g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-25 08:16:42.747415	2012-05-25 08:17:32.248128	116
224	MARTINEAU	Jérome	M.	02 43 86 77 49			jmartineau@impriouest.fr	Contact Technique	\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-29 09:43:56.207255	2012-05-29 09:43:56.207255	228
223	LE FLEM	Marc	M.			06 09 82 42 25	mleflem@impriouest.fr	Directeur		m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-29 09:43:12.913392	2012-05-29 09:45:56.209727	228
225	GAUDRE	Solange	M.				solange@impriouest.fr	Standardiste	\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-29 09:57:54.751685	2012-05-29 09:57:54.751685	228
226	MILLON	Chloé	M.				chloe.millon@eklo-design.com	Gérante	\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-29 10:03:44.085203	2012-05-29 10:03:44.085203	138
227	BOULLARD	Laurent	M.	05 62 48 74 83		06 15 72 22 11	lboullard@actn.fr	Commercial	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-30 08:59:28.252171	2012-05-30 08:59:28.252171	149
228	CORRE	Sylvia	M.				sylvia@cis-sipod.fr		\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-30 13:01:30.792405	2012-05-30 13:01:30.792405	15
230	RICHARD	Mathieu	M.				mathieu.richard@lamandorle.com		\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-31 09:34:51.638739	2012-05-31 09:34:51.638739	142
231	NARCY	Stephen	M.	01 41 30 93 91	01 41 30 91 61		stephen.narcy@metrologie.fr	Spécialiste SYMANTEC	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-04 06:36:59.861274	2012-06-04 06:36:59.861274	229
234	ROBERT	Lucie	Mme						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-04 12:26:20.202269	2012-06-04 12:26:20.202269	227
235	Yann	BOUGLÉ	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-04 12:37:13.072618	2012-06-04 12:37:13.072618	231
236	MAILLARD	Eric	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-04 12:39:22.076334	2012-06-04 12:39:22.076334	232
237	MORIN	Mickael	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-04 13:33:43.198198	2012-06-04 13:33:43.198198	233
238	CORBIN	Pierre	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-04 13:36:57.437007	2012-06-04 13:36:57.437007	234
239	GROUARD		M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-04 13:40:53.330836	2012-06-04 13:40:53.330836	234
240	RENARD	Catherine	Mme						\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-04 13:47:49.485823	2012-06-04 13:47:49.485823	235
242	GIRARD	Vincent	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-04 13:49:11.829767	2012-06-04 13:49:11.829767	236
243	PROT	William	M.			07 77 26 08 22	william.prot@futurtelecom.com	Chef des Ventes Centre	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-04 15:04:56.248668	2012-06-04 15:04:56.248668	18
244	AMBROISE	Francis	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-04 15:19:12.654333	2012-06-04 15:19:12.654333	237
245	HARDONNIERE	Franck	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-04 15:20:40.202523	2012-06-04 15:20:40.202523	238
246	BUFFET	Dominique	Mme	02 43 64 16 65			administration@stylcouture.fr	Responsable administrative et RH	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-05 07:22:24.306004	2012-06-05 07:22:24.306004	239
247	MONRREAL	Lucien	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:25:55.587605	2012-06-05 13:25:55.587605	240
248	CORDIER	Damien	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:29:23.612057	2012-06-05 13:29:23.612057	241
249	MANUEL	Florent	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:31:12.229087	2012-06-05 13:31:12.229087	242
251	DEFFIN	Laurent	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:39:14.617311	2012-06-05 13:39:14.617311	244
252	LELIEVRE	Laurent	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:40:44.613124	2012-06-05 13:40:44.613124	245
253	THOMAS	Emmanuel	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:41:53.35329	2012-06-05 13:41:53.35329	246
229	ROUILLON	Mélina	Mme				melinarouillon@moulinsreunis.fr	Comptabilité		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-31 08:09:24.575082	2012-06-11 07:18:05.202372	5
232	LEGER	Christophe	M.							n.retout@sigire.fr	g.forestier@sigire.fr	2012-06-04 08:29:01.86203	2012-06-11 16:07:23.953961	230
233	LEGER	Isabelle	Mme			06 12 07 49 44				n.retout@sigire.fr	g.forestier@sigire.fr	2012-06-04 08:29:24.833623	2012-06-11 16:07:36.099655	230
215	OMET	Philippe	M.							g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-24 08:46:33.392113	2012-06-12 08:32:22.270917	223
203	TILLAUD	Didier	M.			06 75 94 65 97	tillaud.didier@neuf.fr	Gérant		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-22 09:10:29.496522	2012-06-20 15:50:38.678788	215
241	DOUYER	Gilles	M.	02 37 49 15 08			webmaster@boutaux.fr	Responsable Informatique		g.forestier@sigire.fr	m.ozan@sigire.fr	2012-06-04 13:47:59.217002	2012-06-22 14:24:12.762039	235
255	CORBIN	Pierre	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:44:23.730026	2012-06-05 13:44:23.730026	248
256	GROUARD		M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:44:35.274418	2012-06-05 13:44:35.274418	248
257	RAYNAUD	Jean	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:46:06.913843	2012-06-05 13:46:06.913843	249
258	LEGER	Claude	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:50:32.822786	2012-06-05 13:50:32.822786	251
259	ANNE	Alain	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:51:44.597249	2012-06-05 13:51:44.597249	252
260	GAUGAIN	Gerard	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:53:22.275259	2012-06-05 13:53:22.275259	253
261	BAUMANN	Alain	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:54:42.211448	2012-06-05 13:54:42.211448	254
262	LEBOIS	Gilles	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:55:51.036727	2012-06-05 13:55:51.036727	255
263	BOIZIAU	Sergina	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:58:44.648161	2012-06-05 13:58:44.648161	259
264	HAYE	Jean-Michel	M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 14:00:02.545476	2012-06-05 14:00:02.545476	260
250	LELIEVRE		M.							g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:33:11.101241	2012-06-05 14:50:04.946642	243
265	MOREAU		M.						\N	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 15:29:34.318165	2012-06-05 15:29:34.318165	250
266	LEMOINE		Mme						\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-06 10:03:23.868191	2012-06-06 10:03:23.868191	261
267	Marcade		Mme	02 43 85 66 75		06 27 17 15 57			\N	n.retout@sigire.fr	n.retout@sigire.fr	2012-06-07 14:31:14.352175	2012-06-07 14:31:14.352175	262
268	ROSAY	Agnès	Mme	02 43 40 21 87	02 43 40 21 84		a.rosay@fiawec.com	Comptable	\N	i.moison@sigire.fr	i.moison@sigire.fr	2012-06-08 09:32:26.96075	2012-06-08 09:32:26.96075	263
269	YOUSSOUFA	Zaharya	Mme	01 55 64 11 90	01 55 64 14 89	06 37 34 39 74	zaharya.youssoufa@on-channel.com	Chef de projet marketing	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-08 09:32:46.652491	2012-06-08 09:32:46.652491	264
270	CAZIN	Cédric	M.						\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-11 07:18:43.659597	2012-06-11 07:18:43.659597	5
271	ROGEON	Stéphane	M.				stephane.rogeon@3mo.com	Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-11 19:33:41.600472	2012-06-11 19:33:41.600472	266
272	JACQUES	Frédéric	M.				frederic.jacques@3mo.com	Directeur Informatique 	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-11 19:34:16.67508	2012-06-11 19:34:16.67508	266
273	BEILLARD	Vanessa	Mme				vanessa.beillard@3mo.com	Directeur des Achats	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-11 19:36:31.912136	2012-06-11 19:36:31.912136	266
274	AVIGNON		Mme							g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-12 08:36:31.460925	2012-06-12 08:36:42.618884	232
275	LEVEAU	Francis	M.				francis.leveau@vallegrain.com	Gérant	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 09:06:58.819039	2012-06-12 09:06:58.819039	267
276	MAUGUIN	Isabelle	Mme				isabelle.mauguin@vallegrain.com	Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 09:08:15.687078	2012-06-12 09:08:15.687078	267
277	NOURRY	Alain	M.				alain.nourry@vallegrain.com	Responsable Maintenance	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 09:09:44.507002	2012-06-12 09:09:44.507002	267
278	TUAN	Gérard	M.					Président Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 09:16:35.739214	2012-06-12 09:16:35.739214	268
279	GATIMEAU	Emanuel	M.					Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 09:17:05.530817	2012-06-12 09:17:05.530817	268
280	TRUFFAUT	Philippe 	M.					Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 09:17:46.505509	2012-06-12 09:17:46.505509	268
281	BAROUX	Pascal	M.					Président Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 09:21:20.966957	2012-06-12 09:21:20.966957	269
282	VACHON	Romain	M.	01 41 30 90 96		06 61 14 22 26	romain.vachon@metrologie.fr	IBM Business Development Manager		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 10:15:37.451542	2012-06-12 10:18:58.531493	229
283	JOUBERT	Patrice	M.				patrice.joubert@agem.fr	Président Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 13:06:17.09889	2012-06-12 13:06:17.09889	270
285	ABOT	Didier	M.				didier.abot@agem.fr	Responsable Achats	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 13:08:28.342373	2012-06-12 13:08:28.342373	270
284	HEMON	Laurent	M.				laurent.hemon@agem.fr	Responsable Informatique		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 13:06:55.176687	2012-06-12 13:08:57.616913	270
286	PINCONNET	Valérie	Mme				valerie.pinconnet@agem.fr	Secrétaire de Direction	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 13:10:17.308514	2012-06-12 13:10:17.308514	270
287	SERNEAU	Pascal	M.					Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 13:20:27.812604	2012-06-12 13:20:27.812604	271
288	ROBLOT	Sébastien	M.					Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 13:20:49.984933	2012-06-12 13:20:49.984933	271
290	COSNET	FRANCIS	M.						\N	n.retout@sigire.fr	n.retout@sigire.fr	2012-06-12 13:57:22.736632	2012-06-12 13:57:22.736632	273
289	DERIGOND	Antoine	M.					Responsable Informatique		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 13:27:49.77302	2012-06-12 15:29:04.559258	272
291	PELOIL	Laurent	M.				l-peloil@aim-grp.fr	Président	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 15:29:33.034939	2012-06-12 15:29:33.034939	272
292	JILLEMETEAU	Freddy	M.				f-jillemeteau@aim-grp.fr 	Responsable Achats	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 15:30:33.579897	2012-06-12 15:30:33.579897	272
293	GUIBERT	Franck	M.					Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 15:34:07.216631	2012-06-12 15:34:07.216631	274
294	SANDER	Bertrand	M.				bertrand.sander@alsetex.fr	Directeur Etablissement	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 15:38:11.648707	2012-06-12 15:38:11.648707	275
295	LAGARRIGUE	Didier	M.				didier.lagarrigue@alsetex.fr	Responsable Achats	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 15:40:30.440063	2012-06-12 15:40:30.440063	275
296	BARES	Jean-Jacques	M.					Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 15:42:06.105864	2012-06-12 15:42:06.105864	275
297	BROSSARD	Sonia	M.				sonia.brossard@alsetex.fr	Assistant de Direction	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 15:42:47.740927	2012-06-12 15:42:47.740927	275
298	FOUCAULT	Philippe	M.				philippe.foucault@sippac.fr	Gérant	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 15:43:09.733335	2012-06-12 15:43:09.733335	276
299	FOUASSIER	Agnès	M.				agnes.fouassier@alsetex.fr	Assistant Commerciale	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 15:43:32.893066	2012-06-12 15:43:32.893066	275
300	BRETON	Stéphane	M.					Président Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 15:51:00.959818	2012-06-12 15:51:00.959818	277
301	COUDRAY	Maryse	Mme					Adjoint Directeur Administratif	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 15:51:45.355177	2012-06-12 15:51:45.355177	277
302	GRENIER	Sébastien	M.	02 33 31 28 11			compta@appliplast.fr	Directeur Comptable	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 15:55:33.938418	2012-06-12 15:55:33.938418	278
303	VAILLANT	Jacques	M.					Gérant	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 15:55:59.866768	2012-06-12 15:55:59.866768	278
345	COZION	Thomas	M.					Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 18:48:52.100013	2012-06-13 18:48:52.100013	297
305	TULLIER	Etienne	M.				etullier@aprochim.fr	Adjoint Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:01:27.054209	2012-06-12 16:01:27.054209	279
306	RENARD	Tiphaine	Mme				sevicesgeneraux@aprochim.fr	Responsable Achats	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:02:06.879668	2012-06-12 16:02:06.879668	279
304	KERAVEC	Alain	M.				ahkeravec@aprochim.fr	Directeur Général		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:00:29.016725	2012-06-12 16:02:37.38626	279
307	LEROY	Jean-Philippe	M.				jpleroy@aprochim.fr	Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:03:10.243922	2012-06-12 16:03:10.243922	279
308	EYMERY	Hervé	M.					Président Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:06:33.425237	2012-06-12 16:06:33.425237	280
309	LE GOUPIL	Laurent	M.				laurent.legoupil@sna.coop	Directeur Informatique 	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:07:16.424792	2012-06-12 16:07:16.424792	280
310	TANQUERAY	Richard	M.				rtanqueray@ariel.fr	Directeur Etablissement	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:10:48.495976	2012-06-12 16:10:48.495976	281
311	GROSSMANN	Sylvie	Mme				sgrossmann@ariel.fr	Secrétaire de Direction	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:11:32.71056	2012-06-12 16:11:32.71056	281
312	RATOAVINARIVO	Elian	M.					Adjoint Directeur Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:14:59.66297	2012-06-12 16:14:59.66297	282
313	LACOMBE	Philippe 	M.					Président	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:15:29.289287	2012-06-12 16:15:29.289287	282
314	MEREAU	Jean-Pierre	M.					Président Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:18:21.68441	2012-06-12 16:18:21.68441	283
315	CRAIG	Adam	M.					Administrateur Système et Réseau	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:18:58.530777	2012-06-12 16:18:58.530777	283
316	BLACCO	Hervé	M.					Responsable Etudes Informatiques	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:19:30.97035	2012-06-12 16:19:30.97035	283
318	GOUTIER	Thierry	M.				thierry.goutier@arotechnologies.com	Directeur des Achats	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:20:45.949342	2012-06-12 16:20:45.949342	283
317	CORMIER	Pascal	M.				pascal.cornier@arotechnologies.com	Adjoint Directeur Informatique		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:20:00.305983	2012-06-12 16:21:05.349179	283
319	CHEDHOMME	Claude	M.				claude.chedhomme@agroto.com	Président Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:26:27.262294	2012-06-12 16:26:27.262294	284
320	LEROY	Thierry	M.					Directeur Informatique 	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:29:39.9715	2012-06-12 16:29:39.9715	285
321	RICOURT	Christine	Mme					Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:32:59.417102	2012-06-12 16:32:59.417102	286
322	LEPOITEVIN	Nathalie	Mme					Directeur Etablissement	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:36:22.689972	2012-06-12 16:36:22.689972	287
323	SAINTLEGER	Christophe	M.					Secrétaire Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:36:52.8257	2012-06-12 16:36:52.8257	287
324	GUILLOIS	Jean-Claude	M.					Président	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:37:26.138283	2012-06-12 16:37:26.138283	287
325	ATLAN	Catherine	Mme				catherine@atlan.fr	Président Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 16:43:56.416952	2012-06-12 16:43:56.416952	288
326	BRUNEL	François	M.					Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 10:11:23.212093	2012-06-13 10:11:23.212093	289
327	DIDIER	Gérard	M.					Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 10:11:41.46511	2012-06-13 10:11:41.46511	289
328	BRAUD	Bénédicte	Mme					Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 10:15:39.371196	2012-06-13 10:15:39.371196	290
329	BARBIER	Pascal	M.				p.barbier@belipa.fr	Service Achats	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 10:16:22.957631	2012-06-13 10:16:22.957631	290
330	PEINADO	Christian	M.				c.peinado@belipa.com	Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 10:16:53.685706	2012-06-13 10:16:53.685706	290
331	BEQUET	Christophe	M.					Président	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 10:19:00.240779	2012-06-13 10:19:00.240779	291
332	BEQUET	Laurence	Mme					Directeur Informatique 	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 10:19:20.809623	2012-06-13 10:19:20.809623	291
333	CHAPTMAN		M.					Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 10:31:51.378253	2012-06-13 10:31:51.378253	292
334	MARCK	Laurent	M.					Président Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 10:34:30.098478	2012-06-13 10:34:30.098478	293
335	PENRU	Anne	Mme					Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 10:34:51.54063	2012-06-13 10:34:51.54063	293
336	BOULFRAY	Thierry	M.				boulfray@wanadoo.fr	Président Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 10:37:59.880105	2012-06-13 10:37:59.880105	294
337	ANDRE	Dominique	M.				andre.saboulfray@orange.fr	Directeur des Achats	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 10:38:28.750934	2012-06-13 10:38:28.750934	294
338	BESSON	Jean-Pierre	M.				besson.saboulfray@orange.fr	Service Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 10:39:13.537361	2012-06-13 10:39:13.537361	294
339	MAZOYER	Jean-Paul	M.					Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 18:42:05.741421	2012-06-13 18:42:05.741421	295
341	OLIVIER	Cyril	M.					Président Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 18:45:01.918716	2012-06-13 18:45:01.918716	296
342	HENNEQUIN	Stéphane	M.					Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 18:45:21.484484	2012-06-13 18:45:21.484484	296
343	LACHAZE	Philippe 	M.					Président Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 18:47:47.055648	2012-06-13 18:47:47.055648	297
344	BOURDONNAIS	Jérôme	M.				jerome.bourdonnais@agir-graphic.fr	Directeur Informatique 	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 18:48:30.188264	2012-06-13 18:48:30.188264	297
346	PICARD	Bruno	M.				bruno.picard@agir-graphic.fr	Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 18:49:33.903342	2012-06-13 18:49:33.903342	297
347	BORRA	Jean-Pierre	M.					Président Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 18:51:57.92617	2012-06-13 18:51:57.92617	298
348	CHARTIER	Etienne	M.					Gérant	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 18:55:06.611747	2012-06-13 18:55:06.611747	299
349	CHOLOUX	Pascal	M.				pcholoux@cpi-group.net	Directeur Usine	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 18:58:00.869331	2012-06-13 18:58:00.869331	300
350	BRIQUET	Emmanuel	M.				ebriquet@cpi-group.net	Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 18:58:33.942788	2012-06-13 18:58:33.942788	300
351	MAXIMIL	Thierry	M.				tmaximil@cpi-group.net	Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 18:59:03.813278	2012-06-13 18:59:03.813278	300
352	LEGENDRE	Yohann	M.	02 51 82 82 48		06 18 22 20 61		Agence de Nantes	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 08:49:16.510675	2012-06-14 08:49:16.510675	141
340	LULE	Laurent	M.				l.lule@bvs-fixations.com	Responsable Informatique		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 18:42:36.153673	2012-06-14 14:22:26.967207	295
353	ECKERT	Céline	Mme			06 46 16 15 54			\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 15:24:51.987622	2012-06-14 15:24:51.987622	137
354	GOUDERGS	Patrick	M.				patrick.goudergs@geodis.com	Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 22:41:14.78898	2012-06-14 22:41:14.78898	301
355	PORTIER	Mickaël	M.				mickael.portier@geodis.com	Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 22:42:05.056557	2012-06-14 22:42:05.056557	301
356	LEVERRIER	Thierry	M.					Président Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 22:46:04.839984	2012-06-14 22:46:04.839984	302
357	ROBVEILLE	Olivier	M.					Responsable Informatique		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 22:46:09.393774	2012-06-14 22:46:22.53967	302
358	DARCY	Henri	M.					Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 22:48:36.064282	2012-06-14 22:48:36.064282	303
359	COUSIN	Aurélie	Mme					Secrétaire Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 22:49:01.192903	2012-06-14 22:49:01.192903	303
360	SCHMIDT	Michel	M.					Président Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 22:51:10.082387	2012-06-14 22:51:10.082387	304
361	COSTE	Jérôme	M.				jerome.coste@lgr-emballages.com	Directeur Etablissement	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 22:54:08.07425	2012-06-14 22:54:08.07425	305
362	PIEL BAUZON	Nicolas	M.				nicolas.pielbauzon@lgr-emballages.com	Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 22:54:39.281256	2012-06-14 22:54:39.281256	305
363	CIQANKOWITZ	Marc	M.					Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 22:57:03.710871	2012-06-14 22:57:03.710871	306
364	REIFFERS	Bertrand	M.					Président Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 22:57:24.039502	2012-06-14 22:57:24.039502	306
365	MARION	Philippe 	M.					Directeur Etablissement	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 23:01:10.699323	2012-06-14 23:01:10.699323	307
366	PLUMAS	Stéphane	M.				Stephane.Plumas@ldc.fr	Directeur Informatique 	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 23:01:45.78894	2012-06-14 23:01:45.78894	307
367	LASSERRE	Ammie	Mme					Gérant	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 23:17:29.097541	2012-06-14 23:17:29.097541	308
368	NELKE	Eric	M.					Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 23:17:41.663731	2012-06-14 23:17:41.663731	308
369	BOURDIN STEPAK	Céline	Mme					Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 23:20:40.716663	2012-06-14 23:20:40.716663	309
370	BIGNON	Jean-Pascal	M.				j.bignon@cgmp.fr	Directeur Informatique 	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 23:21:09.285324	2012-06-14 23:21:09.285324	309
371	RAHMANI	Malika	Mme	01 41 91 55 94			malika.rahmani@avnet.com	Commerciale		m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-15 08:58:11.78276	2012-06-15 08:58:50.804649	125
374	LOQUET	Bruno	M.					Directeur Informatique 	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 13:09:28.062208	2012-06-16 13:09:28.062208	311
373	GODET	Jean	M.					Directeur Général 		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 13:09:02.601601	2012-06-16 13:09:38.895594	311
375	LANNAU	Thierry	M.					Directeur Général 	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 13:38:41.902845	2012-06-16 13:38:41.902845	312
376	APPER	Steeve	M.					Adjoint Directeur Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 13:40:17.500225	2012-06-16 13:40:17.500225	312
377	CHEVALLIER	Régis	M.					Président Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 13:47:51.127517	2012-06-16 13:47:51.127517	313
378	LETOUZE	Nathalie	Mme				nathalie.letouze@orne.chambagri.fr	Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 13:48:46.828786	2012-06-16 13:48:46.828786	313
379	HEDRICOURT RIGAUT	Françoise	Mme					Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 13:54:42.627686	2012-06-16 13:54:42.627686	314
380	LEFEVRE	Emmanuel	M.	0237842866				Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 13:55:25.726564	2012-06-16 13:55:25.726564	314
381	MIGNON	Jean-Marc	M.					Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 14:04:44.437888	2012-06-16 14:04:44.437888	315
382	GAUTHIER	Damien	M.					Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 14:06:47.695943	2012-06-16 14:06:47.695943	315
383	CAMARET	Christophe	M.					Président Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 14:16:43.850995	2012-06-16 14:16:43.850995	316
384	ROSILLETTE	Gérard	M.				qualite@chastagner-delaize.fr	Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 14:17:04.960142	2012-06-16 14:17:04.960142	316
385	THOMMERET	Benoît	M.					Directeur des Achats	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 14:17:34.186784	2012-06-16 14:17:34.186784	316
386	SABLE	Laurent	M.				lsable@cimel.eu	Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 14:21:04.115457	2012-06-16 14:21:04.115457	317
387	POMMIE	Sébastien	M.					Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 14:21:55.990035	2012-06-16 14:21:55.990035	317
388	NUSSE	François	M.				fnusse@claircell.com	Président Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 14:24:51.044449	2012-06-16 14:24:51.044449	318
389	LECOMTE	Pascal	M.				plecomte@claircell.com	Correspondant Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 14:25:35.710678	2012-06-16 14:25:35.710678	318
390	COLLOT	Thierry	M.				t.collot@colart.fr	Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 14:33:10.730409	2012-06-16 14:33:10.730409	319
391	GAYANT	Armelle	Mme				a.gayant@colart.fr	Directeur des Achats	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 14:34:00.956296	2012-06-16 14:34:00.956296	319
392	OLLIER	Patrick	M.				p.ollier@colart.fr	Directeur Informatique 	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 14:35:17.813661	2012-06-16 14:35:17.813661	319
393	GALLIER	Benoît	M.					Directeur Général 	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 22:29:16.504426	2012-06-16 22:29:16.504426	320
395	LARGEAU	Thomas	M.					Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 22:32:39.674781	2012-06-16 22:32:39.674781	321
394	CONSTAN	Yan	M.					Directeur Général 		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 22:32:23.017849	2012-06-16 22:32:45.057514	321
396	LAUNAY	Guy	M.					Président Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 22:35:00.445846	2012-06-16 22:35:00.445846	322
397	VIAN	Régis	M.					DIrecteur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 22:37:05.268246	2012-06-16 22:37:05.268246	323
66	CADEAU		M.	02 43 60 18 19	02 43 60 18 19		francois.cadeau@bruletp.com	Directeur Administratif et Financier		s.martin@sigire.fr	g.forestier@sigire.fr	2012-04-19 14:37:38.864557	2012-06-22 20:58:54.908392	52
398	GERPRON	Sébastian	M.					Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 22:37:31.644209	2012-06-16 22:37:31.644209	323
399	BLOCHER	François	M.				f.blocher@cia-laigle.com	Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 22:40:22.092664	2012-06-16 22:40:22.092664	324
400	BOTTE	Martine	Mme					Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 22:40:41.80685	2012-06-16 22:40:41.80685	324
401	PLUMET	Bertrand	M.					Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 22:44:35.5186	2012-06-16 22:44:35.5186	326
402	LEBLANC	Robert	M.				robert.leblanc@janvier-europe.fr	Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 22:50:52.153463	2012-06-16 22:50:52.153463	328
403	PASQUIER	Séverine 	Mme					Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 22:51:33.858936	2012-06-16 22:51:33.858936	328
404	QUANTIN	Dominique	M.					Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 22:54:19.274074	2012-06-16 22:54:19.274074	329
405	TREHOUX	Philippe 	M.				philippe.trehoux@dec-sa.fr	Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 22:56:48.579094	2012-06-16 22:56:48.579094	330
406	BOUVET	Jean-Luc	M.					Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:00:09.504288	2012-06-16 23:00:09.504288	331
407	LAANAYA	Tawfik	M.					Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:00:31.665951	2012-06-16 23:00:31.665951	331
408	TAFFIN	Antoine	M.				ataffin@dic.fr	Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:02:54.777282	2012-06-16 23:02:54.777282	332
409	REYNAERT	Florian	M.				freynaert@dic.fr	Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:03:20.751212	2012-06-16 23:03:20.751212	332
410	CERF	Marc	M.					Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:06:57.478029	2012-06-16 23:06:57.478029	333
411	CHAYEUX	Benoît	M.					Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:07:13.073203	2012-06-16 23:07:13.073203	333
412	HARDY	Xavier	M.					Président Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:10:24.56973	2012-06-16 23:10:24.56973	334
413	POSCHWITZ		M.					Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:15:25.377465	2012-06-16 23:15:25.377465	335
414	HUMAN	François	M.					Directeur Informatique 	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:15:43.299604	2012-06-16 23:15:43.299604	335
415	PEYRAMAYOU	Noël	M.					Gérant	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:17:46.366046	2012-06-16 23:17:46.366046	336
416	ANGINOT	Jean-Baptiste	M.					Président Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:22:15.973417	2012-06-16 23:22:15.973417	337
417	DAVID	Stéphane	M.					Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:24:18.1159	2012-06-16 23:24:18.1159	338
418	DAVID	Stéphane	M.					Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:24:18.284254	2012-06-16 23:24:18.284254	338
419	LEBOUBE	François	M.				francois.leboube@epi-sa.com	Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:26:49.118992	2012-06-16 23:26:49.118992	339
420	GUESDON	Vincent	M.				vincent.guesdon@epi-sa.com	Responsable Informatique		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:26:52.016155	2012-06-16 23:27:36.688706	339
421	GAYET	Isabelle	Mme					Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:32:58.494376	2012-06-16 23:32:58.494376	340
422	MOYANO	Valentin	M.				valentinmoyano@etoileroutiere.fr	Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:33:43.658852	2012-06-16 23:33:43.658852	340
423	LIZANBARD	Stéphane	M.				stephane.lizanbard@denis.fr	Président Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:53:51.915413	2012-06-16 23:53:51.915413	341
424	ADDE	Arnaud	M.				arnaud.adde@denis.fr	Responsable Informatique	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:54:17.54167	2012-06-16 23:54:17.54167	341
425	DILANGE	Morgan	M.					Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-16 23:57:04.022019	2012-06-16 23:57:04.022019	342
426	GERARD	Eric	M.					Président Directeur Général	\N	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 15:05:41.669615	2012-06-17 15:05:41.669615	343
427	DUPONT	Frédéric	M.				infolog@eurowipes.com	Responsable Informatique		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-17 15:05:41.950533	2012-06-17 15:06:15.544471	343
372	QUENUM	Arnaud	M.	01 41 91 55 80			arnaud.quenum@avnet.com	Avant-vente VMware + VEEAM		m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-15 14:32:28.063144	2012-06-18 09:20:40.644145	125
429	PONTHOU		Mme	02 43 50 20 69				PDG		g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-20 08:23:33.189279	2012-06-20 08:24:42.908433	148
201	HAGUET	Bruno	M.			06 16 02 33 53	bruno.haguet@creationcuisinesetbains.fr			m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-22 08:45:38.713183	2012-06-22 07:50:05.348781	214
430	NOM	Prénom	M.	02 37 49 15 08			communeyvrelepolin@wanadoo.fr 	Directeur		m.ozan@sigire.fr	\N	2012-07-10 08:41:32.956583	2012-07-10 08:41:32.956583	139
428		Christelle	Mme				laplace72@wanadoo.fr	Comptable	Notes	n.retout@sigire.fr	Guillaume BONVOUST	2012-06-18 10:03:00.001232	2012-07-17 08:25:33.114669	367
431	Test	Testeur	M.	0606060606	1234567890	0697070707	Test@email.fr	Testeur pro	\N	Guillaume BONVOUST	\N	2012-07-24 12:41:24.693993	2012-07-24 12:41:24.693993	267
\.


--
-- Data for Name: contacts_produits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY contacts_produits (contact_id, produit_id) FROM stdin;
430	3
430	5
428	2
49	7
\.


--
-- Data for Name: evenements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY evenements (id, debut, fin, notes, created_by, modified_by, created_at, updated_at, contact_id, compte_id, type_id, user_id, fichier_joint_file_name, fichier_joint_content_type, fichier_joint_file_size, fichier_joint_updated_at, tache_id) FROM stdin;
1	2012-04-13 17:15:00	2012-04-13 17:15:00	Commande reçue pour :\r\n\r\niMac 27 pouces 2,7 GHz\r\n4 Go\r\nDisque dur serial ATA de 1To\r\nMagic mouse Apple\r\nClavier Apple avec pavé numérique (français) et guide de l’utilisateur (français)\r\nDisque dur portable Porsche Designe 1 To P’9221\r\nTablette Wacom Bamboo Fun Medium Pen and Touch\r\nMicrosoft Office pour Mac 2011 \r\nAdobe CS5.5 Designe Standard \r\n\r\niMac 21,5 pouces 2,5 GHz\r\n4 Go\r\nMagic mouse Apple\r\nClavier Apple avec pavé numérique (français) et guide de l’utilisateur (français)\r\nImprimante sans fil HP Envy 114 e-All-in-one compatible AirPrint\r\nDisque dur portable Porsche Designe 1 To P’9221\r\n1 cartouche d’encre noire\r\n1 cartouche 3 couleurs\r\nMicrosoft Office pour Mac 2011 \r\n\r\nPas d'installation, ni de garantie.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-15 19:35:27.283073	2012-04-15 19:35:27.283073	7	6	14	\N	\N	\N	\N	\N	\N
6	2012-04-16 11:21:00	2012-04-16 11:21:00	Prise de rendez-vous le 19/04/2012 à 11h00 pour faire le point suite au départ de Stéphane Sarélot.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-16 09:28:09.515618	2012-04-16 09:28:09.515618	10	9	2	\N	\N	\N	\N	\N	\N
7	2012-04-16 11:28:00	2012-04-16 11:28:00	Problème de mémoire sur leur serveur.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-16 09:29:17.121849	2012-04-16 09:29:17.121849	11	1	1	\N	\N	\N	\N	\N	\N
8	2012-04-16 15:05:00	2012-04-16 15:10:00	Problème de TVA sur une facture d'achat (19,6% au lieu de 7%) : la fiche article était correcte (bon taux de TVA) mais pas le compte de tiers, qui était resté en Ventes 19,6%. Problème résolu.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-16 13:11:59.225079	2012-04-16 13:11:59.225079	12	10	1	\N	\N	\N	\N	\N	\N
9	2012-04-16 15:12:00	2012-04-16 15:14:00	Souhaite RIB de SIGIRE	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-16 13:15:22.611051	2012-04-16 13:15:22.611051	13	11	1	\N	\N	\N	\N	\N	\N
10	2012-04-16 15:15:00	2012-04-16 15:15:00	Envoi du RIB sur admin@agrimarques.com.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-16 13:15:52.642548	2012-04-16 13:15:52.642548	13	11	4	\N	\N	\N	\N	\N	\N
11	2012-04-16 15:32:00	2012-04-16 15:32:00	Commande passée pour CDC du Val de Sarthe.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-16 13:33:15.507923	2012-04-16 13:33:15.507923	14	12	2	\N	\N	\N	\N	\N	\N
14	2012-04-16 17:24:00	2012-04-16 17:24:00	Demande licence "éducative" pour lightroom, vu avec Gilles pour les versions Photoshop auparavant.	n.retout@sigire.fr	n.retout@sigire.fr	2012-04-16 15:25:11.28766	2012-04-16 15:25:11.28766	15	14	1	\N	\N	\N	\N	\N	\N
15	2012-04-16 17:52:00	2012-04-16 17:52:00	Appel pour déterminer la procédure de migration des e-mails et s'assurer que le client a bien déjà envoyé sa demande de transfert de nom de domaine à ALTITUDE TELECOM. Occupée : doit rappeler.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-16 15:54:03.048189	2012-04-16 15:54:03.048189	16	15	2	\N	\N	\N	\N	\N	\N
17	2012-04-16 18:15:00	2012-04-16 18:15:00	Le client a bien envoyé son courrier de résiliation à ALTITUDE TELECOM. Il faut donc procéder au transfert de son nom de domaine, de ses e-mails et à la mise en place d'une nouvelle liaison ADSL avec routeur (actuellement, le client paie 80 EUR HT / mois).	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-16 16:19:31.863473	2012-04-16 16:19:31.863473	16	15	1	\N	\N	\N	\N	\N	\N
18	2012-04-16 18:19:00	2012-04-16 18:19:00	Devis n°DC120058 envoyé (licence Lightroom EDUC = 69 EUR HT + Media = 25 EUR HT + port)	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-16 16:22:53.656604	2012-04-16 16:22:53.656604	15	14	4	\N	\N	\N	\N	\N	\N
19	2012-04-17 09:50:00	2012-04-17 09:50:00	Accord pour règlement à 30 jours et encours de 2.000 EUR. La commande pour la CDC du Val de Sarthe part aujourd'hui.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-17 08:00:11.602704	2012-04-17 08:00:11.602704	19	16	1	\N	\N	\N	\N	\N	\N
20	2012-04-17 08:11:00	2012-04-17 08:11:00	Office pro 2010 ne veut pas s'activer, période d'essai 30 jours. Réinstallation complète nécessaire	n.retout@sigire.fr	n.retout@sigire.fr	2012-04-17 08:12:04.58049	2012-04-17 08:12:04.58049	20	17	1	\N	\N	\N	\N	\N	\N
21	2012-04-18 07:37:00	2012-04-18 07:37:00	Appel pour indiquer que la configuration de sécurité pour LE MANS HOTEL RESERVATION était prête et qu'il fallait la tester. Le rappeler.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 08:38:38.516723	2012-04-18 08:38:38.516723	35	26	1	\N	\N	\N	\N	\N	\N
22	2012-04-13 15:41:00	2012-04-13 15:41:00	Souhaite plus de précisions sur l'offre A-FTTB et les usages. Semble intéressé par : Centrex, Externalisation, Accès distant/VPN ... Je dois lui envoyer un e-mail semaine 16 pour lui préciser tout cela.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 08:43:50.117397	2012-04-18 08:43:50.117397	37	28	1	\N	\N	\N	\N	\N	\N
23	2012-04-18 08:52:00	2012-04-18 08:52:00	Proposition envoyée pour "Cahier des charges : Fourniture d'un service d'accès Internet permanent de production". Comprend 2 liens + partage de charge et fail-over.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 08:54:01.42074	2012-04-18 08:54:01.42074	38	23	1	\N	\N	\N	\N	\N	\N
24	2012-04-18 08:58:00	2012-04-18 08:58:00	Bonjour,\r\n\r\nSuite à l’entretient que vous avez eu avec M Le Dilly, voici la liste des ports et protocoles ouverts pour le serveur dédié LMHR\r\n\r\nEn sortant : novastor(308), dns,microsoft-ts,http,https,smtp,smtps.\r\n\r\nEn entrant : microsoft-ts, novastor.\r\n\r\n                               Icmp pour RouteurSIGIRE et ServeurMonitoringSIGIRE\r\n\r\nCdrlmnt,\r\n\r\nBenoit.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 08:59:10.903713	2012-04-18 08:59:10.903713	35	26	3	\N	\N	\N	\N	\N	\N
25	2012-04-18 09:16:00	2012-04-18 09:16:00	Présentation A-FTTB et ses usages envoyée par e-mail.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 09:16:42.235159	2012-04-18 09:16:42.235159	37	28	4	\N	\N	\N	\N	\N	\N
26	2012-04-18 09:41:00	2012-04-18 09:41:00	Devis envoyé pour démontage disque dur du portable et réintégration dans boîtier externe + récupération fichier Outlook .PST.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 09:41:38.409129	2012-04-18 09:41:38.409129	40	21	4	\N	\N	\N	\N	\N	\N
27	2012-04-18 09:50:00	2012-04-18 09:50:00	E-mail envoyé pour demande de RDV téléphonique afin de valider la proposition de NICOLAY LANOUVELLE.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-18 09:54:29.546821	2012-04-18 09:54:29.546821	26	18	4	\N	\N	\N	\N	\N	\N
28	2012-04-04 07:04:00	2012-04-04 07:04:00	Renouvellement de la maintenance SYMANTEC Backup Exec + EndPoint Protection	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-19 08:42:41.809977	2012-04-19 08:42:41.809977	48	32	14	\N	\N	\N	\N	\N	\N
29	2012-04-19 09:19:00	2012-04-19 09:19:00	Authentification Portail NETASQ causé par le connecteur Active-Sync Google Apps --> Exclusion des serveurs de Google dans le Netasq.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-19 09:20:51.449503	2012-04-19 09:20:51.449503	11	1	1	\N	\N	\N	\N	\N	\N
30	2012-04-23 09:41:00	2012-04-23 09:41:00	Demande de complément d'info : Compte Google Apps + Compte user Serveur LMHR	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-23 09:52:37.953566	2012-04-23 09:52:37.953566	39	36	2	\N	\N	\N	\N	\N	\N
32	2012-04-23 09:30:00	2012-04-23 10:30:00	Mme Papin - souci d'ouverture Sage Paie suite à installat° poste Win7 Pro 64bits => Propriétés sur le programme pstw32.exe  pour le faire fonctionner en émulation XP + récup des états (pst.sga + pst.fga + dossier GA).	i.moison@sigire.fr	i.moison@sigire.fr	2012-04-23 14:00:58.914081	2012-04-23 14:00:58.914081	21	17	1	\N	\N	\N	\N	\N	\N
33	2012-04-23 14:28:00	2012-04-23 14:28:00	Demande d'accès à l'interface de gestion des NDD de DRI...	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-23 14:29:01.375822	2012-04-23 14:29:01.375822	39	36	4	\N	\N	\N	\N	\N	\N
34	2012-04-23 15:21:00	2012-04-23 15:21:00	2 questions  : alimentation + perte de bande passante 30 Ko/s !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-23 15:41:19.647746	2012-04-23 15:41:19.647746	2	3	1	\N	\N	\N	\N	\N	\N
35	2012-04-24 07:26:00	2012-04-24 07:26:00	Demande d'info concernant : la messagerie (NDD + liste des comptes e-mail), numéro associé à la ligne ADSL + FAX (02 43 28 67 97).	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-24 07:34:03.519166	2012-04-24 07:34:03.519166	77	15	2	\N	\N	\N	\N	\N	\N
36	2012-04-24 13:47:00	2012-04-24 13:47:00	Voir pour Tarifs SFR pour Ipad (tarification grand compte). Prévoir de le tenir au courant.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-24 13:48:25.280584	2012-04-24 13:48:25.280584	78	2	1	\N	\N	\N	\N	\N	\N
37	2012-04-24 15:20:00	2012-04-24 15:20:00	Demande d'info produit VEEEAM...	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-24 15:21:06.24535	2012-04-24 15:21:06.24535	80	125	2	\N	\N	\N	\N	\N	\N
42	2012-04-25 07:17:00	2012-04-25 07:17:00	Soucis avec la messagerie Google Apps	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-25 07:18:01.468126	2012-04-25 07:18:01.468126	86	17	1	\N	\N	\N	\N	\N	\N
43	2012-04-13 08:00:00	2012-04-13 08:01:00	Je reviens vers vous suite à notre dernier rendez-vous. J'ai rencontré hier la directrice régionale de FUTUR TELECOM pour évoquer votre projet de migration de votre parc de mobiles vers FUTUR TELECOM. J'ai obtenu des améliorations tarifaires notables mais afin de pouvoir établir une proposition ferme, j'ai besoin de connaître l'étendue du parc, ainsi que, pour chaque ligne, le forfait actuel et les consommations réelles. Ceci nous permettra de mener une analyse précise et donc de vous proposer la meilleure tarification possible.\r\n\r\n\r\nPouvez-vous nous faire parvenir ces éléments ?\r\n\r\nJe reste aussi à votre disposition si vous souhaitez basculer quelques lignes "à titre d'essai" pour valider que la procédure de migration se passe correctement.\r\nG. Forestier	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-25 08:34:21.682774	2012-04-25 08:34:21.682774	88	128	4	\N	\N	\N	\N	\N	\N
44	2012-04-25 08:34:00	2012-04-25 08:34:00	Tentative de rappel suite à mon dernier e-mail : en réunion (pas dispo).	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-25 08:34:49.001221	2012-04-25 08:34:49.001221	88	128	2	\N	\N	\N	\N	\N	\N
45	2012-04-25 08:34:00	2012-04-25 08:34:00	J'ai tenté de vous joindre ce matin, mais sans succès. Avez-vous eu le temps de faire le point sur les éléments indiqués dans mon dernier e-mail ?\r\n\r\nN'hésitez pas à me contacter si nécessaire. \r\nG. Forestier	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-25 08:35:13.883149	2012-04-25 08:35:13.883149	88	128	4	\N	\N	\N	\N	\N	\N
46	2012-04-26 06:49:00	2012-04-26 06:49:00	Souhaite recevoir l'imprimante commandée rapidement car elle est en panne	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 06:50:25.009625	2012-04-26 06:50:25.009625	92	130	1	\N	\N	\N	\N	\N	\N
47	2012-04-26 06:57:00	2012-04-26 06:57:00	Devis envoyé pour alimentation NETASQ.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 06:58:23.491019	2012-04-26 06:58:23.491019	2	3	4	\N	\N	\N	\N	\N	\N
48	2012-04-25 13:48:00	2012-04-25 13:48:00	Veuillez nous établir une offre pour 1 PC avec office pro + 1 écran 22 ‘’.\r\nD’autre part veuillez nous chiffrer un écran 19 ou 20’’ + 1 batterie pour portable HP Notebook ZZ08 N° série : 6AQWF09AXYF02Q.\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 07:37:24.166058	2012-04-26 07:37:24.166058	93	104	3	\N	\N	\N	\N	\N	\N
49	2012-04-26 07:37:00	2012-04-26 07:37:00	2 devis envoyés. Référence de la batterie de portable HP 4710s = NZ375AA 	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 07:38:22.475252	2012-04-26 07:38:22.475252	93	104	4	\N	\N	\N	\N	\N	\N
50	2012-04-24 09:00:00	2012-04-24 10:30:00	Souhaite migrer le 06 11 57 72 96 de SFR vers FUTUR + résilier la ligne 06 34 21 28 40 + souscrire option ZEN SmartPhone chez FUTUR (pas possible avant le renouvellement) + passer en forfait illimité sur son numéro 06 17 02 30 75 (pas possible avant renouvellement). \r\nRésolution d'un pb de lenteur sur son ordinateur (remplacement Avast par Microsoft Security Essential + nettoyage CCleaner).	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 07:58:04.778203	2012-04-26 07:58:04.778203	94	131	9	\N	\N	\N	\N	\N	\N
51	2012-04-26 07:31:00	2012-04-26 07:31:00	Les fichiers ne sont toujours pas copiés !\r\nInstallation d'un Serveur FTP sur la VM pour copier via le LAN (Hyper-V <----> VM LMHR) et non via la connexion TS (mapage local).	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-26 08:01:17.945691	2012-04-26 08:01:17.945691	39	36	1	\N	\N	\N	\N	\N	\N
52	2012-04-26 07:58:00	2012-04-26 07:58:00	Faisant suite à notre dernier rendez-vous, je vous confirme les points suivants :\r\n- La ligne que vous souhaitez résilier (06 34 21 28 40) est (apparemment) encore engagée jusqu'au 30/07/2012. Vous pouvez le vérifier en allant dans votre espace client SFR et en vérifiant la date de fin d'engagement. Si cette information est correcte, vous ne pourrez pas résilier cet abonnement avant, sauf à payer d'avance les sommes encore dues.\r\n- Pour résilier un abonnement SFR, il suffit d'appeler le 1023 et de leur donner le numéro de la ligne à résilier.\r\n- La ligne 06 11 57 72 96 est encore engagée (apparemment) jusqu'au 17/01/2013. Il n'est donc pas possible de la faire migrer avant cette date, sauf à payer les sommes encore dues.\r\n- Pour votre abonnement actuel chez FUTUR TELECOM, nous vous conseillons de migrer votre ligne vers un abonnement illimité (59 EUR HT / mois) qui (d'après vos consommations) devrait être plus avantageux. Cela ne pourra s'effectuer que dans un an, lors de renouvellement de l'abonnement de votre mobile. A cette occasion, nous vous conseillons aussi de prendre l'option "Smartphone Zen" qui permet de renouveler son mobile tous les 12 mois (au lieu de 24 mois). Cette option coûte moins de 3 EUR HT par mois.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 08:09:27.858631	2012-04-26 08:09:27.858631	94	131	4	\N	\N	\N	\N	\N	\N
53	2012-04-26 08:40:00	2012-04-26 08:40:00	Toujours pas de nouvelles concernant la pose du modem.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 08:53:24.368617	2012-04-26 08:53:24.368617	4	4	2	\N	\N	\N	\N	\N	\N
54	2012-04-26 08:53:00	2012-04-26 08:53:00	Tentative d'appel pour savoir si modem était posé ou non. Pas de réponse.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 08:56:26.32846	2012-04-26 08:56:26.32846	3	4	2	\N	\N	\N	\N	\N	\N
56	2012-04-26 12:20:00	2012-04-26 12:20:00	Ne comprend pas pourquoi elle doit la facture FC110572 alors que les produits ne sont pas installés (SAGE). Je lui ai expliqué que les produits n'ont pas été installés sur sa demande, car la banque leur a donné un délai supplémentaire et qu'elle avait préféré (à l'époque) différer l'installation.\r\nA noter que les produits correspondants provenaient d'une promo du mois de septembre !\r\nElle va envoyer un e-mail pour prévoir l'installation de la compta + Moyens de paiement. elle veut aussi installer (et acheter) la Gestion Commerciale.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 12:37:06.577445	2012-04-26 12:37:06.577445	97	21	1	\N	\N	\N	\N	\N	\N
57	2012-04-26 12:45:00	2012-04-26 12:45:00	Pb. A cliqué sur "impression différée" dans la Compta SAGE et ses impressions ne sortent pas. Je lui ai fait supprimer ces impressions différées (Fichier/Impressions Différées puis Supprimer). Elle peut à nouveau imprimer son grand livre. Pb réglé.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 12:47:12.89868	2012-04-26 12:47:12.89868	98	130	1	\N	\N	\N	\N	\N	\N
58	2012-04-24 07:32:00	2012-04-24 07:32:00	Comme convenu je vous transmet le nom de notre commercial: Xavier FOUGEROUSE et son numéro: 06 27 28 69 90.\r\nIl n'a pas de messagerie vocale.\r\nC'est un numéro qui n'était plus utilisé.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 13:39:00.980849	2012-04-26 13:39:00.980849	100	97	3	\N	\N	\N	\N	\N	\N
59	2012-04-26 14:13:00	2012-04-26 14:21:00	Problème avec Paie SAGE : une fois lancé, après l'identification de l'utilisateur, le programme reste "réduit" dans la barre de tâches.\r\nSolution : Sous Windows 7, aller dans le gestionnaire des tâches, puis clic droit sur Sage PAie et choisir "Agrandir". Pb résolu.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 14:21:36.253609	2012-04-26 14:21:36.253609	21	17	1	\N	\N	\N	\N	\N	\N
60	2012-04-26 14:22:00	2012-04-26 14:22:00	La messagerie des commerciaux n'est pas installée sur leurs BlackBerry (3 mobiles à paramétrer). Il doit faire le point pour savoir quand les 3 commerciaux seront à l'entreprise pour que l'on puisse passer. Il nous rappelle.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 14:22:54.933372	2012-04-26 14:22:54.933372	101	17	1	\N	\N	\N	\N	\N	\N
61	2012-04-26 14:44:00	2012-04-26 14:44:00	Tentative d'appel suite à la demande de M. DA COSTA pour de la téléphonie mobile.\r\nRépondeur. Message laissé avec mes coordonnées.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 14:45:25.924094	2012-04-26 14:45:25.924094	102	135	2	\N	\N	\N	\N	\N	\N
620	2012-07-09 22:00:00	2012-07-09 22:00:00	\N	m.ozan@sigire.fr	\N	2012-07-10 20:12:01.643507	2012-07-10 20:12:01.643507	42	48	16	\N	\N	\N	\N	\N	8
62	2012-04-26 14:47:00	2012-04-26 14:47:00	Tentative d'appel pour savoir si l'on peut travailler ensemble. Personne ne décroche... puis cela finit par sonner occupé.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 14:48:46.049092	2012-04-26 14:48:46.049092	\N	134	2	\N	\N	\N	\N	\N	\N
63	2012-04-26 14:48:00	2012-04-26 14:48:00	Faisant suite à votre demande, nous vous confirmons les points suivants :\r\n- offre FUTUR TELECOM (réseau SFR) pour un abonnement DATA illimité pour Ipad = 29 EUR HT / mois\r\n- la souscription à l'offre FUTUR TELECOM ne change rien en ce qui concerne les autres abonnements dont vous disposez\r\n- je n'ai pas réussi à obtenir le tarif de l'abonnement DATA chez SFR directement : nous travaillons dorénavant presque exclusivement avec FUTUR TELECOM (du fait de leurs offres bien placées, tout en conservant le réseau SFR)...\r\n\r\nSi vous souhaitez souscrire à l'offre, je peux vous faire parvenir les documents sous 24 heures.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 14:58:17.903661	2012-04-26 14:58:17.903661	78	2	4	\N	\N	\N	\N	\N	\N
64	2012-04-26 15:00:00	2012-04-26 17:05:00	Longue discussion sur l'outil logistique + proposition SIGIRE + développement envisagé!\r\nPoints à voir : commande d'achat Cosnet calquée sur la commande du client final + suivi du BL Polymoule qui génère un BL COSNET.\r\nRDV téléphonique pris pour Lundi après-midi.\r\nSouhaite formation supplémentaire par Isabelle.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-26 17:10:45.866271	2012-04-26 17:10:45.866271	99	104	2	\N	\N	\N	\N	\N	\N
65	2012-04-27 07:38:00	2012-04-27 07:38:00	Souhaite avoir Manuel (qui est en ligne). A rappeler.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-27 07:38:38.169892	2012-04-27 07:38:38.169892	106	17	1	\N	\N	\N	\N	\N	\N
66	2012-04-26 07:54:00	2012-04-26 07:56:00	Souhaite avoir Isabelle (en congés). Voudrait pouvoir éditer un état particulier dans la compta (échéances dues au 31/12 pour un certain nombre de fournisseurs). Doit fournir l'état à M. Dattin cet après-midi! Elle va tenter de se débrouiller toute seule.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-27 07:50:12.496409	2012-04-27 07:50:12.496409	103	136	1	\N	\N	\N	\N	\N	\N
67	2012-04-27 07:35:00	2012-04-27 07:35:00	Pbm poste Mr MORICE, pas accès INTERNET --> demande de tests (PING, NSLOOKUP...), paramétrage de la carte Réseau (DNS fournis par DHCP) et non les DNS de Google (les flux DNS ne sont autorisé que pour le serveur).\r\nTests OK !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-27 07:57:40.051364	2012-04-27 07:57:40.051364	11	1	1	\N	\N	\N	\N	\N	\N
68	2012-04-27 08:18:00	2012-04-27 08:18:00	Mail pour indiquer que le fichier error_log fait 2,5Go !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-27 08:23:33.713632	2012-04-27 08:23:33.713632	109	137	4	\N	\N	\N	\N	\N	\N
69	2012-04-27 08:37:00	2012-04-27 08:37:00	Modification de configuration NETASQ (25minutes).	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-27 08:37:38.118547	2012-04-27 08:37:38.118547	2	3	1	\N	\N	\N	\N	\N	\N
70	2012-04-27 08:37:00	2012-04-27 08:38:00	Souhaite avoir Isabelle (en congés). A un pb d'impression de ses relances dans SAGE. Une fenêtre "assistant de connexion internet" s'affiche. Après vérification, il semblerait qu'elle ait choisi de générer un fichier au lieu de simplement lancer l'impression. Elle essaie et nous rappelle si cela ne marche pas.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-27 08:40:35.090131	2012-04-27 08:40:35.090131	12	10	1	\N	\N	\N	\N	\N	\N
71	2012-04-27 09:47:00	2012-04-27 09:47:00	Pb de virus sur son poste "Windows Premium Guard". Nécessite intervention pour nettoyage. Intervention prévue aujourd'hui ou lundi pour reprise du PC en leurs locaux et traitement chez SIGIRE.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-27 09:48:19.228545	2012-04-27 09:48:19.228545	111	139	1	\N	\N	\N	\N	\N	\N
72	2012-04-27 09:44:00	2012-04-27 10:14:00	Conseils sur le positionnement des droits d'accès sur les répertoires Wordpress pour le site "www.eklo-design.com".\r\nOK.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-27 10:14:50.081002	2012-04-27 10:14:50.081002	110	138	2	\N	\N	\N	\N	\N	\N
78	2012-04-27 13:58:00	2012-04-27 13:58:00	Escalade du pbm Netasq (BP + mail) avec le Support CRIS-RESEAUX !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-27 14:06:21.712406	2012-04-27 14:06:21.712406	2	3	1	\N	\N	\N	\N	\N	\N
79	2012-04-27 14:12:00	2012-04-27 14:12:00	Options de partage des Agendas Google Apps !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-27 14:52:41.889241	2012-04-27 14:52:41.889241	5	5	2	\N	\N	\N	\N	\N	\N
83	2012-04-30 06:10:00	2012-04-30 07:05:00	Pb Trojan "Windows Premium Guard". Démarrage en mode sans échec avec support réseau. Téléchargement de "Malware Byte's" (http://fr.malwarebytes.org). Redémarrage en mode sans échec avec support réseau. Lancement du programme Malware Byte's. Suppression des éléments infectés (766 !).	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-30 07:29:37.861673	2012-04-30 07:29:37.861673	111	139	12	\N	\N	\N	\N	\N	\N
84	2012-04-30 07:54:00	2012-04-30 07:54:00	Prévenir Coupure NETASQ (Bug du 1er Mai)	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-30 07:54:35.369404	2012-04-30 07:54:35.369404	115	129	2	\N	\N	\N	\N	\N	\N
85	2012-04-30 08:11:00	2012-04-30 08:11:00	Prévenir coupure Netasq - Bug 1er Mai !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-30 08:16:04.734219	2012-04-30 08:16:04.734219	116	141	2	\N	\N	\N	\N	\N	\N
86	2012-04-30 08:34:00	2012-04-30 08:34:00	Prévenir pour opération NETASQ du 1er Mai	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-30 08:40:36.020858	2012-04-30 08:40:36.020858	117	142	2	\N	\N	\N	\N	\N	\N
87	2012-04-30 08:51:00	2012-04-30 08:51:00	Opération NETASQ 1er Mai - Reboot du NETASQ !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-30 08:56:28.641977	2012-04-30 08:56:28.641977	9	8	2	\N	\N	\N	\N	\N	\N
88	2012-04-30 10:07:00	2012-04-30 10:07:00	Opération NETASQ 1er Mai !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-30 10:08:10.424798	2012-04-30 10:08:10.424798	27	19	2	\N	\N	\N	\N	\N	\N
89	2012-04-30 11:59:00	2012-04-30 11:59:00	"Petit soucis, vendredi Elodie et moi avions nos contacts , mais ce matin nous n’avons plus de contacts dans notre outlook !!!"\r\nCorrection des soucis lié aux "contacts" sur Outlook	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-30 12:24:46.883909	2012-04-30 12:24:46.883909	39	36	3	\N	\N	\N	\N	\N	\N
90	2012-04-30 12:57:00	2012-04-30 12:57:00	Opération Netasq 1er Mai !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-30 12:58:11.556288	2012-04-30 12:58:11.556288	121	146	2	\N	\N	\N	\N	\N	\N
91	2012-04-30 13:23:00	2012-04-30 13:23:00	Opération NETASQ 1er Mai !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-30 13:24:17.158159	2012-04-30 13:24:17.158159	111	139	1	\N	\N	\N	\N	\N	\N
92	2012-04-30 13:55:00	2012-04-30 13:55:00	Opération NETASQ 1er Mai !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-30 14:19:13.058326	2012-04-30 14:19:13.058326	122	5	1	\N	\N	\N	\N	\N	\N
93	2012-04-30 15:36:00	2012-04-30 16:00:00	Pbm réseau sur le poste à Nathalie MASSOT !\r\nLeur switch D'Link est HS (switch DAO)\r\nGilles est informé.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-04-30 16:06:39.79839	2012-04-30 16:06:39.79839	123	38	1	\N	\N	\N	\N	\N	\N
94	2012-05-02 07:29:00	2012-05-02 07:29:00	"Petit soucis ce matin, impossible d’imprimer de mon pc sur mon imprimante – aucun parametres n ont été changés !!!!\r\nLundi soir ça fonctionnait très bien ?\r\nMerci de prendre la main sur mon PC, je suis absente ce matin mais Elodie est au buro si besoin. Isabelle OSSUN"\r\nL'imprimante est bien sur le SSID Livebox-9620, elle fonctionne sur le poste à Elodie.\r\nReboot du poste à Isabelle >> pbm corrigé.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-02 07:45:36.81654	2012-05-02 07:45:36.81654	125	36	1	\N	\N	\N	\N	\N	\N
95	2012-05-02 07:51:00	2012-05-02 07:51:00	N'est pas joignable aujourd'hui !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-02 07:58:31.584744	2012-05-02 07:58:31.584744	106	17	1	\N	\N	\N	\N	\N	\N
96	2012-05-02 08:00:00	2012-05-02 08:15:00	Pb messagerie : prise en main à distance -> scanpst.exe lancé sur le fichier outlook.pst. Réparation OK	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-02 08:42:33.989461	2012-05-02 08:42:33.989461	126	147	1	\N	\N	\N	\N	\N	\N
97	2012-05-02 09:03:00	2012-05-02 09:05:00	Pb pour accéder à leur serveur du Mans. Ils ont appelé Océanet : la liaison SDSL est fonctionnelle et le routeur est joignable. Le modem ONE ACCESS et le routeur CISCO ont été redémarrés. Les voyants sont "normaux". Mais le problème persiste.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-02 09:13:03.404399	2012-05-02 09:13:03.404399	128	148	1	\N	\N	\N	\N	\N	\N
182	2012-05-14 08:17:00	2012-05-14 08:17:00	Plus de connexion INTERNET !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-14 08:17:21.367692	2012-05-14 08:17:21.367692	77	15	1	\N	\N	\N	\N	\N	\N
98	2012-05-02 09:07:00	2012-05-02 09:07:00	Je demande à M. Chapeau de redémarrer le routeur CISCO RVS4000 situé au Mans, ainsi que le modem Bewan.\r\nLa liaison n'est pas gérée par SIGIRE, ni par OCEANET.\r\nM. Chapeau doit me rappeler quand tout a été redémarré.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-02 09:14:34.136455	2012-05-02 09:14:34.136455	127	148	2	\N	\N	\N	\N	\N	\N
99	2012-05-02 09:14:00	2012-05-02 09:14:00	Je préviens Véronique que M. Chapeau doit effectuer des manipulations et que nous la tenons au courant.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-02 09:15:13.424981	2012-05-02 09:15:13.424981	129	148	2	\N	\N	\N	\N	\N	\N
100	2012-05-02 08:53:00	2012-05-02 08:53:00	"Petite découverte, le nouveau PC n’a aucune imprimante de configurée…\r\nJe ne sais pas comment on fait donc je te laisse prendre la main dessus."\r\nInstallation de l'imprimante sur le nouveau poste >> OK !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-02 09:19:06.264057	2012-05-02 09:19:06.264057	125	36	3	\N	\N	\N	\N	\N	\N
101	2012-05-02 09:21:00	2012-05-02 09:21:00	Les équipements ont été redémarrés. La liaison fonctionne à nouveau (M. Chapeau a appelé Alençon pour s'en assurer). Pb résolu.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-02 09:21:53.274354	2012-05-02 09:21:53.274354	127	148	1	\N	\N	\N	\N	\N	\N
102	2012-05-02 08:05:00	2012-05-02 09:05:00	Pbm poste Mr MORICE les pbm est persistent (pas de connexion Outlook - Google Apps)...\r\nConnexion vers des Serveurs INTERNET sur le port 47873 !\r\nDésinstallation de l'Anti-Virus Trend > installation de MSE (analyse Anti-Virus : acun résultat)\r\nMail pour récupération du poste et analyse approfondie.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-02 09:25:19.778062	2012-05-02 09:25:19.778062	11	1	3	\N	\N	\N	\N	\N	\N
103	2012-05-02 13:12:00	2012-05-02 13:12:00	Configuration du copieur Canon ic2020 (SCAN to FTP) !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-02 13:20:49.391582	2012-05-02 13:20:49.391582	125	36	2	\N	\N	\N	\N	\N	\N
104	2012-05-02 13:19:00	2012-05-02 13:19:00	Envoi devis pour remplacement de l'onduleur du serveur (onduleur : SMT2200i, prise : AP9880).	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-02 13:21:25.713279	2012-05-02 13:21:25.713279	133	150	4	\N	profibois.pdf	application/pdf	35880	2012-05-02 13:21:25.711594	\N
105	2012-04-30 09:00:00	2012-04-30 09:30:00	PC de Anne Maigrot rapporté, réparé et mis à jour. Récupération PC M. Priollaud qui ne boote pas sur la bonne partition. Après quelques modifications (table de partition notamment), le PC (Sony Vaio) ne boote plus du tout!	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-02 13:56:08.774064	2012-05-02 13:56:08.774064	114	139	11	\N	\N	\N	\N	\N	\N
106	2012-05-01 13:30:00	2012-05-01 14:00:00	Réparation du PC de M. Priollaud à l'aide du CD d'installation de Windows 7 (réparation secteur de démarrage). M. Priollaud souhaite devis pour compte Google Apps + nouveau domaine pour CGI.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-02 13:57:28.981822	2012-05-02 13:57:28.981822	114	139	11	\N	\N	\N	\N	\N	\N
107	2012-05-02 13:57:00	2012-05-02 13:57:00	Domaine cgi.xxx déjà pris avec toutes les extensions communes.\r\nDomaine cgi-consulting.xxx dispo en .EU .INFO et .BIZ ...\r\ncgi-consultants.fr disponible.\r\n\r\nDemande de confirmation du nombre de comptes Google Apps à souscrire (actuellement : 13 adresses e-mail).	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-02 14:13:51.975894	2012-05-02 14:13:51.975894	113	139	4	\N	\N	\N	\N	\N	\N
108	2012-05-02 14:17:00	2012-05-02 14:17:00	Appel de Mme Anne-Marie Barault - 06 30 37 22 96 - à la demande de Christophe Billot, pour envisager la mise à disposition d'un accès internet (mini 10Mbps) pour la période du 25/05 au 21/06/2012. Message laissé sur son répondeur.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-02 14:19:00.881714	2012-05-02 14:19:00.881714	79	36	2	\N	\N	\N	\N	\N	\N
109	2012-05-02 14:19:00	2012-05-02 14:19:00	Appel pour faire le point sur l'installation :\r\n- tout fonctionne\r\nPoints qui restent à implémenter :\r\n- comptes Google Apps (attente de DRI)\r\n- Mise en service Google Talk (lié à Google Apps)\r\n- Mise en service 2ème box ADSL sur le même réseau interne : faisabilité ?\r\n\r\nOK pour facturer\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-02 14:34:23.034648	2012-05-02 14:34:23.034648	39	36	2	\N	\N	\N	\N	\N	\N
111	2012-05-02 15:05:00	2012-05-02 15:05:00	Pb : suite à la migration Google Apps, ses tâches ont disparu de Outlook. La rappeler.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-02 15:05:42.325741	2012-05-02 15:05:42.325741	134	5	1	\N	\N	\N	\N	\N	\N
112	2012-05-03 07:29:00	2012-05-03 07:39:00	Soucis d'imprimante poste Isabelle OSSUN >> Isabelle n'était pas sur le bon LAN (deux livebox).\r\nLe problème est corrigé.\r\nIsabelle souhaite installé son imprimante (HP L7000) sur le LAN de la seconde Livebox !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-03 07:41:22.35924	2012-05-03 07:41:22.35924	39	36	2	\N	\N	\N	\N	\N	\N
113	2012-05-03 07:45:00	2012-05-03 07:45:00	Mr RIBOULET me confirme la présence de FT pour installation du MODEM.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-03 07:48:15.032472	2012-05-03 07:48:15.032472	3	4	2	\N	\N	\N	\N	\N	\N
114	2012-05-03 07:52:00	2012-05-03 08:22:00	Souci de messagerie sur son poste (+ envoi des mails par la Gescom) !\r\nApparamment des mails perdus (non présent sur le webmail nozicaa ni dans l'ancien fichier de donnée)\r\nModification logiciel de mail par défaut.\r\nOK.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-03 08:27:15.444105	2012-05-03 08:27:15.444105	106	17	1	\N	\N	\N	\N	\N	\N
116	2012-05-03 08:47:00	2012-05-03 08:47:00	Confirmation du RDV pour mise en Service du routeur !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-03 08:47:16.8384	2012-05-03 08:47:16.8384	3	4	1	\N	\N	\N	\N	\N	\N
117	2012-05-03 09:55:00	2012-05-03 09:55:00	Pbm : demande de mot de passe dans "Outlook Express" !\r\nSuppression de l'ancien compte pop "mail.habrial.fr".\r\nTests >> OK	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-03 10:01:20.812365	2012-05-03 10:01:20.812365	106	17	1	\N	\N	\N	\N	\N	\N
118	2012-05-03 12:27:00	2012-05-03 12:27:00	Pb accès internet sur 1 pc : changement DNS (8.8.8.8) -> Plantage serveur DNS courant.	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-03 12:28:08.413658	2012-05-03 12:28:08.413658	124	38	1	\N	\N	\N	\N	\N	\N
119	2012-05-03 15:07:00	2012-05-03 15:07:00	Pbm de synchro sur le mobile, à perdu tous ses contacts !\r\nTéléphone planté..reboot du tel et OK	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-03 15:15:16.235022	2012-05-03 15:15:16.235022	5	5	1	\N	\N	\N	\N	\N	\N
120	2012-05-03 08:07:00	2012-05-03 08:07:00	Configuration du routeur + premier tests de téléphonie.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-04 08:08:02.711145	2012-05-04 08:08:02.711145	3	4	1	\N	\N	\N	\N	\N	\N
121	2012-05-04 08:50:00	2012-05-04 08:50:00	Me confirme que le domaine mosaine-concept.com doit être renouvelé (50 EUR HT).	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-04 08:51:02.151908	2012-05-04 08:51:02.151908	135	152	2	\N	\N	\N	\N	\N	\N
122	2012-05-04 08:51:00	2012-05-04 08:51:00	Siège social en Ardèche. J'ai toutefois appelé le service informatique à Privas dès fois que... Pas de besoin en FO	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-04 08:58:11.585716	2012-05-04 08:58:11.585716	\N	153	1	\N	\N	\N	\N	\N	\N
123	2012-05-04 09:59:00	2012-05-04 09:59:00	FAI Orange en ADSL - Pas intéressé par FO	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-04 10:00:09.25394	2012-05-04 10:00:09.25394	136	157	1	\N	\N	\N	\N	\N	\N
124	2012-05-04 11:51:00	2012-05-04 11:51:00	Pbm de RAM sur la VM VH2 (1Go est trop peut) !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-04 11:52:23.530526	2012-05-04 11:52:23.530526	138	158	4	\N	\N	\N	\N	\N	\N
125	2012-05-04 12:30:00	2012-05-04 12:30:00	Impossibilité de joindre PREFEO (Pbm Téléphonique + Réseau ?)	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-04 12:31:03.959166	2012-05-04 12:31:03.959166	116	141	2	\N	\N	\N	\N	\N	\N
126	2012-05-04 14:50:00	2012-05-04 14:50:00	Pb dans SAGE pour envoyer les documents par e-mail. Suite intervention de Manuel et plantage, code d'activation à re-saisir dans SAGE. La rappeler après avoir pris la main à distance.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-04 14:54:05.747697	2012-05-04 14:54:05.747697	140	17	1	\N	\N	\N	\N	\N	\N
127	2012-05-04 14:54:00	2012-05-04 14:54:00	Lancement de SAGE OK, mais toujours pb d'envoi des documents par e-mail. Prévoir d'appeler SAGE Lundi et rappeler le client à la suite de cela.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-04 15:17:50.49871	2012-05-04 15:17:50.49871	140	17	2	\N	\N	\N	\N	\N	\N
177	2012-05-11 12:42:00	2012-05-11 12:42:00	Récupération du code auth pour le domaine : geslin-mecanique-precision.com	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-11 12:50:13.543572	2012-05-11 12:50:13.543572	166	182	1	\N	\N	\N	\N	\N	\N
128	2012-05-07 08:18:00	2012-05-07 08:18:00	Bonjour,\r\nPour info, la récupération de votre nom de domaine prosport.fr (afin de le faire rediriger vers medisport.fr) "bloque" à l'étape suivante :\r\nValidation du transfert par l'ancien prestataire (AMEN / Agence des Medias Numeriques) !\r\n\r\nAvez-vous reçu un mail de "AMEN" afin de valider ce transfert ?	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-07 08:23:59.862087	2012-05-07 08:23:59.862087	90	129	4	\N	\N	\N	\N	\N	\N
129	2012-05-07 08:24:00	2012-05-07 08:24:00	Bonjour,\r\nJe pense que 1Go de RAM supplémentaire est nécessaire.\r\n\r\nConcernant le dimensionnement originel : la capacité en mémoire RAM d'un VPS est très fortement liée à la charge du serveur Web (et donc à la popularité de votre site).\r\nPour simplifier le côté technique, plus vous avez de connexions HTTP à votre site et plus le serveur web consommera de mémoire. Les fortes charges étant aléatoires et bien sûr impossibles à prévoir "avant" la mise en ligne du site.\r\n\r\nL'ajout de mémoire permettra donc de soutenir le serveur lors de fortes charges qui en fonction de la popularité de votre site seront de plus en plus nombreuses, on vous le souhaite...\r\n\r\nPour ce qui de la convention d'hébergement : un simple accord par mail est suffisant pour nous (une facture vous sera alors transmise).\r\nCependant si souhaitez un avenant/bon de commande séparé cela ne pose aucun problème.\r\n\r\nCordialement.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-07 08:24:28.530541	2012-05-07 08:24:28.530541	138	158	1	\N	\N	\N	\N	\N	\N
130	2012-05-07 14:54:00	2012-05-07 14:54:00	J’essaie de paramétrer le Black Berry de *Gerald POUSSIN* mais cela ne\r\nfonctionne pas comme je voudrais.\r\nQuelqu’un pourrait-il me contacter à ce sujet ?\r\nProcédure --> http://aide.nuxit.com/doku.php/hebergement_mutualise/emails/parametrer_son_logiciel_de_messagerie/blackberry 	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-07 15:04:22.406116	2012-05-07 15:04:22.406116	20	17	3	\N	\N	\N	\N	\N	\N
131	2012-05-07 13:51:00	2012-05-07 14:41:00	Appel à la demande de Dominique Pannier pour clôturer l'exercice N-5 et ouvrir l'exercice suivant. Traitement effectué.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-07 16:32:30.910308	2012-05-07 16:32:30.910308	133	150	2	\N	\N	\N	\N	\N	\N
132	2012-05-08 12:09:00	2012-05-08 12:09:00	Bonjour M. Forestier,\r\n\r\nJe viens de voir cette pub sur votre site  http://www.sigire.fr/operations/i-love-la-fibre/\r\nPouvez vous m'en dire plus ? Le local jeune d'Yvré le Pôlin est il élligible ?\r\n\r\n \r\nPour tout vous dire je réfléchis à une solution de sauvegarde des données des différents serveurs que je pourrais mettre en place au printemps 2013. Pour l'instant avec une connexion adsl, rien d'autre qu'un nas en local est possible.\r\n\r\nAvec une liaison montante à 2 Méga faut voir....\r\n\r\nCordialement	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-09 05:45:42.009105	2012-05-09 05:45:42.009105	4	4	3	\N	\N	\N	\N	\N	\N
133	2012-05-09 05:45:00	2012-05-09 05:45:00	Pour répondre à votre question : la commune d'Yvré le Pôlin n'est pas éligible. Seules sont éligibles un certain nombre de zones d'activités du Mans ou de la Sarthe (zones déjà fibrées généralement).\r\n\r\nCela dit, en ce qui vous concerne, il est toujours possible de prévoir un lien SDSL 2M (voire plus) si vous le désirez. Nous avons aussi des solutions de stockage distant à notre catalogue (plusieurs To si nécessaire). 	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-09 05:46:03.84523	2012-05-09 05:46:03.84523	4	4	4	\N	\N	\N	\N	\N	\N
134	2012-05-09 07:40:00	2012-05-09 07:40:00	Est lui même opérateur...	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 07:41:11.997192	2012-05-09 07:41:11.997192	\N	156	1	\N	\N	\N	\N	\N	\N
135	2012-05-09 07:47:00	2012-05-09 07:47:00		g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 07:47:57.865207	2012-05-09 07:47:57.865207	141	159	1	\N	\N	\N	\N	\N	\N
136	2012-05-09 07:47:00	2012-05-09 07:47:00	Appel le 9 mai - Personne ne décroche puis tonalité fax.	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 07:48:36.492969	2012-05-09 07:48:36.492969	141	159	1	\N	\N	\N	\N	\N	\N
137	2012-05-09 09:53:00	2012-05-09 09:53:00	HP : pb impression sur HP P2035 -> N° Dossier 4674346058 (attente appel HP)	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-09 09:54:03.497584	2012-05-09 09:54:03.497584	91	130	1	\N	\N	\N	\N	\N	\N
138	2012-05-09 10:18:00	2012-05-09 10:18:00	Bjr \r\nimpossible de se connecter au serveur de tous nos Pc !!!!\r\nIsabelle Ossun \r\nPas de défaut de connexion constaté !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-09 10:20:38.807268	2012-05-09 10:20:38.807268	39	36	3	\N	\N	\N	\N	\N	\N
139	2012-05-09 13:09:00	2012-05-09 13:09:00	Ne veut pas entendre parler de FO - A tout ce qu'il faut - Ne veut pas parler	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 13:11:16.332989	2012-05-09 13:11:16.332989	\N	151	1	\N	\N	\N	\N	\N	\N
140	2012-05-09 13:19:00	2012-05-09 13:19:00	Accès internet géré en Bretagne - Secrétaire agressive - A na pas rappeler	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 13:21:30.662677	2012-05-09 13:21:30.662677	\N	160	1	\N	\N	\N	\N	\N	\N
141	2012-05-09 13:22:00	2012-05-09 13:22:00	Numero de fax manifestement	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 13:25:02.513724	2012-05-09 13:25:02.513724	\N	161	1	\N	\N	\N	\N	\N	\N
142	2012-05-09 13:26:00	2012-05-09 13:26:00	Magasin Mobalpa - A rappeler en soirée	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 13:28:38.500993	2012-05-09 13:28:38.500993	\N	162	1	\N	\N	\N	\N	\N	\N
143	2012-05-09 13:32:00	2012-05-09 13:32:00	Absent ce jour - Rappel Vendredi matin	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 13:35:40.638537	2012-05-09 13:35:40.638537	144	163	1	\N	\N	\N	\N	\N	\N
144	2012-05-09 13:37:00	2012-05-09 13:37:00	Numero occupé en permanence	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 13:46:51.818069	2012-05-09 13:46:51.818069	145	164	1	\N	\N	\N	\N	\N	\N
145	2012-05-09 13:49:00	2012-05-09 13:49:00	Déjà équipé par un FAI en haut débit. N'a pas voulu me dire qui. Il a déjà une GTR sous 4 heures. Qui ???	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 13:54:59.864227	2012-05-09 13:54:59.864227	146	165	1	\N	\N	\N	\N	\N	\N
146	2012-05-09 13:56:00	2012-05-09 13:56:00	Téléphone toujours occupé !	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 13:57:50.107699	2012-05-09 13:57:50.107699	\N	166	1	\N	\N	\N	\N	\N	\N
147	2012-05-09 14:14:00	2012-05-09 14:14:00	Appeler le jeudi soir	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 14:16:40.263642	2012-05-09 14:16:40.263642	147	167	1	\N	\N	\N	\N	\N	\N
149	2012-05-09 14:21:00	2012-05-09 14:21:00	Appeler siège à Laval au 02 43 49 58 58	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 14:23:22.934825	2012-05-09 14:23:22.934825	148	168	1	\N	\N	\N	\N	\N	\N
150	2012-05-09 14:23:00	2012-05-09 14:23:00	Ne veut pas nous prendre	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 14:25:35.719513	2012-05-09 14:25:35.719513	148	168	1	\N	\N	\N	\N	\N	\N
151	2012-05-09 14:59:00	2012-05-09 14:59:00	On tombe sur un répondeur	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 15:00:55.600412	2012-05-09 15:00:55.600412	149	169	1	\N	\N	\N	\N	\N	\N
152	2012-05-09 15:10:00	2012-05-09 15:10:00	Envoyer courrier electronique	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 15:10:39.288862	2012-05-09 15:10:39.288862	151	170	1	\N	\N	\N	\N	\N	\N
153	2012-05-09 15:10:00	2012-05-09 15:10:00	Mail envoyé à direction du Mans et assistante de direction en RP	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 15:18:26.371339	2012-05-09 15:18:26.371339	151	170	1	\N	\N	\N	\N	\N	\N
154	2012-05-09 15:20:00	2012-05-09 15:20:00	Pas intéressé par FO - ADSL suffit largement	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-09 15:21:47.048163	2012-05-09 15:21:47.048163	153	171	1	\N	\N	\N	\N	\N	\N
155	2012-05-09 15:24:00	2012-05-09 15:24:00	Modification Conf Bornes DECT !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-09 15:24:35.071283	2012-05-09 15:24:35.071283	9	8	1	\N	\N	\N	\N	\N	\N
156	2012-05-09 12:30:00	2012-05-09 14:30:00	Démonstration Pilotage XL et échanges sur le projet logistique\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-10 08:43:59.784277	2012-05-10 08:43:59.784277	99	104	9	\N	\N	\N	\N	\N	\N
178	2012-05-11 08:50:00	2012-05-11 08:50:00	Siège en RP : 01 30 69 67 00	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-11 12:54:06.792482	2012-05-11 12:54:06.792482	165	181	1	\N	\N	\N	\N	\N	\N
179	2012-05-14 07:48:00	2012-05-14 07:48:00	Pas de résiliation de NDD enregistré côté Altitude Télécom (uniquement l'ADSL)....	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-14 08:02:26.928135	2012-05-14 08:02:26.928135	77	15	1	\N	\N	\N	\N	\N	\N
180	2012-05-14 08:02:00	2012-05-14 08:02:00	Information Hosting GESLIN.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-14 08:06:22.489623	2012-05-14 08:06:22.489623	166	182	4	\N	\N	\N	\N	\N	\N
579	2012-07-09 22:00:00	2012-07-09 22:00:00	\N	m.ozan@sigire.fr	\N	2012-07-10 08:36:22.798165	2012-07-10 08:36:22.798165	\N	265	11	\N	\N	\N	\N	\N	6
157	2012-05-10 05:37:00	2012-05-10 05:37:00	\r\nTout d'abord, je vous confirme que l'inventaire PASDELOU a bien été importé cette nuit.\r\n\r\nConcernant notre réunion hier, je souhaite en résumer la teneur en quelques lignes :\r\n- La solution n°1 (avec développement SIGIRE) reprend le fonctionnement normal de SAGE (BC/BL/Facture) dans chaque structure. Elle est basée sur les objets métiers qui permettent de suivre les recommandations de SAGE en matière de développement utilisant des bases SAGE. Elle peut inclure (ou non) la solution SATELIX ou la solution SIGIRE en ce qui concerne la saisie des codes-barres par douchette.\r\n- La solution n°2 (avec développement BK SYSTEME) déporte la gestion des stocks dans le produit BK SYSTEME. Deux points restent en suspens :\r\n* Comment sont gérées techniquement les "interfaces" (import/export via des fichiers texte ou lecture/écriture directe dans la base SAGE ?)  et avec quelle fréquence (toutes les heures ?) ?\r\n* Si BK SYSTEME ne génère pas de BL ou de facture (que ce soit de vente ou d'achat), alors il y a un problème de cohérence sur le plan de la gestion (COSNET achète à POLYMOULE et POLYMOULE vend à COSNET mais il n'y a aucune pièce comptable correspondante). Cela pose aussi un problème sur le plan des statistiques dans le produit SAGE. Si BK SYSTEME génère un BL ou une facture, alors il y a risque que les mouvements de stocks soient comptabilisés en double puisque (un mouvement géré par BK SYSTEME pour faire la sortie de stock et un nouveau mouvement dans le BL pour faire cette même sortie de stock).\r\n\r\nQuestion subsidiaire : si les stocks sont gérés par BK SYSTEME, comment se passe l'inventaire (sans doute géré aussi dans BK SYSTEME), ainsi que la valorisation à l'instant T du stock ?\r\n\r\nEn résumé, dans l'état actuel de mes connaissances sur le produit de BK SYSTEME, je ne vois pas comment cela peut fonctionner sans dégrader l'utilisation de SAGE.\r\nJe tempère malgré tout mes propos car :\r\n- je ne connais pas suffisamment ce produit pour en parler\r\n- je suis "juge et partie" dans ce projet; c'est donc une position délicate.\r\n\r\nQuoiqu'il en soit, il me semble que tout cela mérite des explications techniques  supplémentaires de la part de BK SYSTEME... 	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-10 08:50:37.520057	2012-05-10 08:50:37.520057	99	104	4	\N	\N	\N	\N	\N	\N
158	2012-05-10 07:44:00	2012-05-10 07:44:00	Merci pour l'import de l'inventaire Pasdelou pour la démo SQL Entreprise et\r\npour vos commentaires ci-dessous.\r\nNous faisons éclaircir ces points techniques.\r\n\r\nConcernant vos propositions pour SQL Entreprise, nous avons bien noté que\r\nc'est un préalable fortement souhaitable pour la simplicité et la pérennité\r\ndes développements entre plusieurs SAGE ou bien pour la création\r\nd'interfaces entre SAGE et une autre base de données (ex: BK Systèmes):\r\n- Merci de m'envoyer la démo.\r\n- Est-ce que le passage sur SQL Entreprise sur V16 oblige à reparamétrer les\r\nformats d'impression ? ou bien est-ce le passage sur i7 qui oblige à les\r\nreparamétrer ? (question importante pour Mme Cosnet)\r\n- Pouvez-vous séparer les chiffrages de la mise en place de SQL Entreprise\r\nsur la version actuelle V16 (permet de bénéficier de l'édition pilotée\r\nExcel) ET le passage ultérieur sur i7.\r\n- Dans votre proposition d'origine, quel serait le temps maxi admis avec SQL\r\nEntreprise sur V16 avant de passer sur i7 ?\r\n- Votre chiffrage de contrat de maintenance remplacerait les contrats\r\nactuels pour gestion commerciale, compta et moyens de paiement ? Il faudrait\r\ngarder à part le contrat existant pour paie ?\r\n- En cas de mise en place de SQL Entreprise, le nouveau contrat de\r\nmaintenance remplacerait les contrats existants (paiement de la différence\r\nde prix ou bien avoir au prorata des durées non consommées des contrats\r\nsouscrits) ?\r\n\r\nConcernant les développements SIGIRE:\r\n- Le développement pour lecture du stock multi-bases pendant la saisie d'un\r\nbon de commande par un double-click sur l'article ouvrant un pop-up, devrait\r\nlire toutes les bases (Sage Cosnet, Polymoule, Pasdelou, Galva72) ?\r\n- La génération d'un BL de Sage Polymoule est nécessaire à chaque sortie\r\nphysique pour que le stock système soit correct. Mais une facture par BL\r\nselon la logique Sage compliquerait le traitement des factures par Mme\r\nCosnet. Quel moyen pour n'éditer qu'une facture mensuelle avec 1 ligne\r\nrécapitulative par article ? Bien sûr, cette facture ne devrait pas refaire\r\ndes sorties de stock (ou bien elle devrait annuler les sorties de stock des\r\nBL qu'elle facture).\r\n- Vous avez chiffré le développement de l'automatisation de: Bon de commande\r\nd'achat Sage Cosnet => Bon de commande de vente Sage Polymoule. Quel serait\r\nle montant des 2 autres automatisations:\r\n\t- Bon de commande de vente vers client final dans SAGE Cosnet => Bon\r\nde commande d'achat Sage Cosnet\r\n\t- BL Sage Polymoule => BR Sage Cosnet \r\n\tNous comprenons que le passage intermédiaire par le Sage Cosnet est\r\nune source de complications.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-10 08:51:10.044434	2012-05-10 08:51:10.044434	99	104	3	\N	\N	\N	\N	\N	\N
159	2012-05-10 12:26:00	2012-05-10 12:26:00	La coupure de LMHR vient de chez eux, à cause d'un basculement entre le NETASQ actif et le passif. Ils lancent des investigations auprès de NETASQ...	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-10 12:31:37.91335	2012-05-10 12:31:37.91335	36	26	2	\N	\N	\N	\N	\N	\N
160	2012-05-10 13:35:00	2012-05-10 13:35:00	Pb messagerie -> non reception des mails. -> prise en main à distance -> tous les paramètres sont bons -> réception des mails et envois OK après plusieurs tests et après avoir enlevé un mail bloqué en envoi (cause : mauvaise adresse ".f")	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-10 13:37:09.162567	2012-05-10 13:37:09.162567	155	173	1	\N	\N	\N	\N	\N	\N
161	2012-05-10 13:37:00	2012-05-10 13:37:00	Nouvel appel : pb mail à nouveau -> qu'ils voient avec orange...	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-10 13:37:53.966703	2012-05-10 13:37:53.966703	155	173	1	\N	\N	\N	\N	\N	\N
162	2012-05-10 13:38:00	2012-05-10 13:38:00	Suite HP : contact (technicien mohamed.rafrafi@hp.com) -> pb driver usb avec win 7 64 bits -> installation carte réseau sur imprimante P2035	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-10 13:39:09.349463	2012-05-10 13:39:09.349463	91	130	1	\N	\N	\N	\N	\N	\N
163	2012-05-10 13:41:00	2012-05-10 13:41:00	PB pc claude : écran noir -> récupération pc -> carte mère HS\r\nMail envoyé : \r\n"Comme je le craignais il s’agit de la carte mère.\r\nOn peut lire le disque dur, la mémoire n’est pas défaillante, c’est bien la carte mère qui ne réagit plus.\r\n \r\nNous n’avons plus de pc autre qu’en windows 7, donc pour patienter as tu un pc que l’on pourrait réutiliser pour claude ?"\r\n	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-10 13:42:38.581169	2012-05-10 13:42:38.581169	156	174	1	\N	\N	\N	\N	\N	\N
164	2012-05-10 15:13:00	2012-05-10 15:13:00	Absent jeudi soir. Secrétaire me conseille lundi 9 h 30	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-10 15:15:46.017852	2012-05-10 15:15:46.017852	147	167	1	\N	\N	\N	\N	\N	\N
165	2012-05-10 14:27:00	2012-05-10 14:27:00	Support sur NETASQ - routage sur plusieurs passerelles !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-10 15:46:23.762415	2012-05-10 15:46:23.762415	118	143	1	\N	\N	\N	\N	\N	\N
166	2012-05-10 15:59:00	2012-05-10 15:59:00	Par suite d'encombrement, nous ne donnons pas suite à votre appel (sic !)	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-10 15:59:34.113978	2012-05-10 15:59:34.113978	143	162	1	\N	\N	\N	\N	\N	\N
167	2012-05-10 15:56:00	2012-05-10 15:56:00	Nécessite installation de "Adobe Flash Player" --> Installation OK !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-10 16:04:51.243184	2012-05-10 16:04:51.243184	161	36	3	\N	\N	\N	\N	\N	\N
168	2012-05-10 17:03:00	2012-05-10 17:03:00	Voici le devis ci-joint.\r\n\r\nJe tiens à préciser les points suivants :\r\n- l'iMac 21,5" est livré en OSX V10.7 (Lion)\r\n- La dernière version disponible de ADOBE Creative Suite est la CS6\r\n- SuitCase Fusion V4 fonctionne sous Lion mais les plug-ins pour Adobe CS6 ne sont pas encore sortis (ils devraient sortir dans les semaines qui viennent). En attendant, l'activation des polices dans ADOBE CS6 se fait manuellement.\r\n\r\n\r\nNote : Mac = MC309F/A + KTA-MB1333K2/8G / CS6 = 65163191 / AppleCare = MD007F/A	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-10 17:05:16.288327	2012-05-10 17:05:16.288327	162	177	4	\N	sofac.pdf	application/pdf	36720	2012-05-10 17:05:16.286389	\N
169	2012-05-11 07:19:00	2012-05-11 07:19:00	Relance de "Backup Exec" Serveur HABRIAL !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-11 07:19:48.799862	2012-05-11 07:19:48.799862	21	17	13	\N	\N	\N	\N	\N	\N
170	2012-05-11 07:41:00	2012-05-11 07:41:00	Abonnement trop cher	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-11 07:48:28.86269	2012-05-11 07:48:28.86269	144	163	1	\N	\N	\N	\N	\N	\N
171	2012-05-11 07:54:00	2012-05-11 07:54:00	Rappeler lundi matin	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-11 07:54:49.838751	2012-05-11 07:54:49.838751	163	178	1	\N	\N	\N	\N	\N	\N
172	2012-05-11 08:13:00	2012-05-11 08:13:00	Demande d'information concernant la téléphonie sur IP (nom des comptes CENTREX, SDA...)	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-11 08:14:40.351141	2012-05-11 08:14:40.351141	142	60	4	\N	\N	\N	\N	\N	\N
173	2012-05-11 08:20:00	2012-05-11 08:20:00	Egalement Linconyl - Pas intéressé	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-11 08:37:49.566308	2012-05-11 08:37:49.566308	\N	179	1	\N	\N	\N	\N	\N	\N
174	2012-05-11 08:39:00	2012-05-11 08:39:00	Point P	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-11 08:40:29.694854	2012-05-11 08:40:29.694854	164	180	1	\N	\N	\N	\N	\N	\N
175	2012-05-11 08:40:00	2012-05-11 08:40:00	Siège à Nantes. J'ai appelé Nantes. Les décisions se font au niveau du groupe St Gobain	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-11 08:45:56.007952	2012-05-11 08:45:56.007952	164	180	1	\N	\N	\N	\N	\N	\N
176	2012-05-11 08:48:00	2012-05-11 08:48:00	Contacter siège social au 01 30 69 67 00	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-11 08:50:33.586292	2012-05-11 08:50:33.586292	165	181	1	\N	\N	\N	\N	\N	\N
183	2012-05-14 08:42:00	2012-05-14 08:42:00	ADSL Orange qui suffit amplement	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 08:43:14.911015	2012-05-14 08:43:14.911015	163	178	1	\N	\N	\N	\N	\N	\N
184	2012-05-14 10:18:00	2012-05-14 10:35:00	Voici la liste des articles PASDELOU dont le suivi en stock n'est pas le CMUP :\r\n\r\nPG1009999    Code divers\r\nPGESC        Escompte\r\nPGPORT        Particpation Transport\r\nSA802169    ARTICLE SUPPRIME\r\nPG8152139    Chape simple buse Ø300mm\r\nPG2800401    Main d'oeuvre finition\r\nPGFF        Frais Fixes\r\nPG2900101    Achats divers\r\nPGCOMM        Remise Gestion Communication\r\nPGPREST        Prestation diverse\r\nPGPRESL        Prestation Service Plateforme finition\r\nPGPORT8        Messagerie\r\nPGPORT9        Affrêtement\r\nPG2000203    Libre\r\nPG20001121    Libre\r\nPG2900102    Achats maintenance\r\nPG2900103    Achats bureau d'études\r\n\r\n\r\n\r\nJ'attends votre feu vert avant de réincorporer l'inventaire.\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-14 12:21:01.057906	2012-05-14 12:21:01.057906	99	104	4	\N	\N	\N	\N	\N	\N
185	2012-05-14 12:34:00	2012-05-14 12:34:00	J'ai changé les 3 articles nécessaires.\r\n\r\nVous pouvez maintenant réintégrer l'inventaire au 31/03/2012 selon le\r\nfichier envoyé vendredi, sur le dépôt Pasdelou et aussi sur le dépôt Galva\r\n72.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-14 12:38:28.088997	2012-05-14 12:38:28.088997	99	104	3	\N	\N	\N	\N	\N	\N
186	2012-05-14 12:52:00	2012-05-14 12:52:00	Mail envoyé à la direction	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 12:55:56.868935	2012-05-14 12:55:56.868935	165	181	1	\N	\N	\N	\N	\N	\N
187	2012-05-14 13:01:00	2012-05-14 13:01:00	Siège à Angers - 02 41 33 31 00	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 13:02:10.90036	2012-05-14 13:02:10.90036	\N	183	1	\N	\N	\N	\N	\N	\N
188	2012-05-14 13:02:00	2012-05-14 13:02:00	Mail envoyé	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 13:06:35.920255	2012-05-14 13:06:35.920255	\N	183	1	\N	\N	\N	\N	\N	\N
189	2012-05-14 13:10:00	2012-05-14 13:10:00	Mail envoyé à Lorient	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 13:29:25.378315	2012-05-14 13:29:25.378315	167	184	1	\N	\N	\N	\N	\N	\N
190	2012-05-14 13:29:00	2012-05-14 13:29:00	Claude utilise pc Christine (en attendant pc en trop chez CIS SIPOD ?) ou changement masterprint (car pc win 7 tout neuf pour claude en attente).	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-14 13:35:54.50507	2012-05-14 13:35:54.50507	156	174	1	\N	\N	\N	\N	\N	\N
191	2012-05-14 13:39:00	2012-05-14 13:39:00	Très difficile à joindre	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 13:39:25.785982	2012-05-14 13:39:25.785982	168	186	1	\N	\N	\N	\N	\N	\N
192	2012-05-14 13:40:00	2012-05-14 13:40:00	Telephone occupé en permanence	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 13:40:38.522165	2012-05-14 13:40:38.522165	\N	185	1	\N	\N	\N	\N	\N	\N
193	2012-05-14 13:43:00	2012-05-14 13:43:00	Faux numéro	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 13:43:16.124029	2012-05-14 13:43:16.124029	169	187	1	\N	\N	\N	\N	\N	\N
194	2012-05-14 13:47:00	2012-05-14 13:47:00	A rappeler	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 13:48:13.209166	2012-05-14 13:48:13.209166	170	189	1	\N	\N	\N	\N	\N	\N
195	2012-05-14 13:48:00	2012-05-14 13:48:00	Compagne M. Cosnet : prise en main à distance -> réparation fichier outlook.pst	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-14 13:48:40.667424	2012-05-14 13:48:40.667424	93	104	1	\N	\N	\N	\N	\N	\N
197	2012-05-14 13:51:00	2012-05-14 13:51:00	Voici quelques réponses à vos questions ...\r\n\r\n\r\nLe 10/05/12 09:44, Hervé LEVERRIER a écrit :\r\n> Bonjour Monsieur Forestier,\r\n> \r\n> Merci pour l'import de l'inventaire Pasdelou pour la démo SQL Entreprise et\r\n> pour vos commentaires ci-dessous.\r\n> Nous faisons éclaircir ces points techniques.\r\n> \r\n> Concernant vos propositions pour SQL Entreprise, nous avons bien noté que\r\n> c'est un préalable fortement souhaitable pour la simplicité et la pérennité\r\n> des développements entre plusieurs SAGE ou bien pour la création\r\n> d'interfaces entre SAGE et une autre base de données (ex: BK Systèmes):\r\n> - Merci de m'envoyer la démo.\r\n\r\nFait.\r\n\r\n> - Est-ce que le passage sur SQL Entreprise sur V16 oblige à reparamétrer les\r\n> formats d'impression ? ou bien est-ce le passage sur i7 qui oblige à les\r\n> reparamétrer ? (question importante pour Mme Cosnet)\r\n\r\n\r\nEn Sage 100 Entreprise V16, on conserve la même version : pas de conversion d'état. En i7, il n'y a (a priori) pas de conversion d'états à faire non plus. Toutefois, au vu des problèmes de drivers d'imprimante rencontrés ces derniers temps, des problèmes sont toujours possibles, aussi bien en i7 qu'en v16 car la nouvelle installation s'effectuera sans doute sous un nouveau système d'exploitation (Windows 2008 Server).\r\n\r\n\r\n> - Pouvez-vous séparer les chiffrages de la mise en place de SQL Entreprise\r\n> sur la version actuelle V16 (permet de bénéficier de l'édition pilotée\r\n> Excel) ET le passage ultérieur sur i7.\r\n\r\nAttention, le passage en SAGE 100 Entreprise V16 ne permet PAS de bénéficier du pilotage Excel (seulement présent en version i7). Pour séparer le chiffrage, je dois demander une nouvelle cotation à SAGE. Une chose est certaine : cela oblige à faire à peu près deux fois la même chose (donc à doubler le budget prestations). A chaque mise à jour, il faut passer sur tous les postes !\r\n\r\n\r\n> - Dans votre proposition d'origine, quel serait le temps maxi admis avec SQL\r\n> Entreprise sur V16 avant de passer sur i7 ?\r\n\r\n??\r\nIl n'y a pas de "temps admis" : les deux versions existent actuellement et sont maintenues... \r\n\r\n> - Votre chiffrage de contrat de maintenance remplacerait les contrats\r\n> actuels pour gestion commerciale, compta et moyens de paiement ? Il faudrait\r\n> garder à part le contrat existant pour paie ?\r\n\r\nLa Maintenance de SAGE 100 Entreprise remplace la maintenance que vous payez actuellement pour Gestion Commerciale/Compta/Moyens de Paiement. La paie reste à part.\r\n\r\n\r\n> - En cas de mise en place de SQL Entreprise, le nouveau contrat de\r\n> maintenance remplacerait les contrats existants (paiement de la différence\r\n> de prix ou bien avoir au prorata des durées non consommées des contrats\r\n> souscrits) ?\r\n\r\nLes abonnements seront facturés au prorata. Si vous n'avez pas consommé les trois mois restants (par exemple) de votre constrat actuel, un avoir est effectué qui viendra en déduction du nouveau contrat.\r\n\r\n\r\n> \r\n> Concernant les développements SIGIRE:\r\n> - Le développement pour lecture du stock multi-bases pendant la saisie d'un\r\n> bon de commande par un double-click sur l'article ouvrant un pop-up, devrait\r\n> lire toutes les bases (Sage Cosnet, Polymoule, Pasdelou, Galva72) ?\r\n\r\nNon. La lecture du stock multi-bases est effectuée par un outil externe. Cela signifie qu'il ne sera pas accessible directement en cliquant deux fois sur l'article. Il faudra simplement aller sur la fenêtre de cet outil externe à SAGE afin de saisir le code article : l'outil affichera alors les stocks dans les différentes entreprises (sous réserve qu'il y ait une correspondance dans la codification).\r\n\r\n\r\n> - La génération d'un BL de Sage Polymoule est nécessaire à chaque sortie\r\n> physique pour que le stock système soit correct. Mais une facture par BL\r\n> selon la logique Sage compliquerait le traitement des factures par Mme\r\n> Cosnet. Quel moyen pour n'éditer qu'une facture mensuelle avec 1 ligne\r\n> récapitulative par article ? Bien sûr, cette facture ne devrait pas refaire\r\n> des sorties de stock (ou bien elle devrait annuler les sorties de stock des\r\n> BL qu'elle facture).\r\n\r\nSage n'oblige pas à créer une facture par BL (même si on peut paramétrer le produit ainsi). On peut très bien avoir 10 BL qui soient générés à l'instant T en une seule facture. Par contre, il me semble que si le même code article apparait plusieurs fois, il y aura autant de lignes dans la facture.\r\n\r\n\r\n> - Vous avez chiffré le développement de l'automatisation de: Bon de commande\r\n> d'achat Sage Cosnet =>  Bon de commande de vente Sage Polymoule. Quel serait\r\n> le montant des 2 autres automatisations:\r\n> \t- Bon de commande de vente vers client final dans SAGE Cosnet =>  Bon\r\n> de commande d'achat Sage Cosnet\r\n\r\nCe développement n'est pas nécessaire : SAGE gère déjà la génération des commandes d'achat en fonction des commandes de vente (réapprovisionnement)\r\n\r\n> \t- BL Sage Polymoule =>  BR Sage Cosnet\r\n\r\nCe développement est plus compliqué puisqu'il faut retrouver le bon de commande d'origine chez COSNET, et gérer tous les cas particuliers (bon de commande modifié entre temps, voire supprimé. Le plus simple me semblait plutôt que l'opérateur transforme directement le bon de commande d'achat COSNET en BL (ou BR) d'achat en utilisant la fonction "transformer". Il y a un traitement manuel, mais très réduit (2 clics) et cela permet de gérer les cas particuliers.\r\n\r\nToutefois, on peut envisager un développement, qui sera nécessairement plus long que le premier (évaluation : 3.500/4.000 EUR HT, à affiner en fonction de la gestion des cas particuliers)\r\n\r\n> \tNous comprenons que le passage intermédiaire par le Sage Cosnet est\r\n> une source de complications.\r\n\r\nOui et Non. A mon sens, ce passage est obligatoire : chaque société doit avoir sa gestion propre et sa cohérence interne, sans tenir compte de l'autre. On obtient un processus plus rigoureux, mais qui engendre un peu plus de manipulations.\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-14 13:56:11.589677	2012-05-14 13:56:11.589677	99	104	4	\N	\N	\N	\N	\N	\N
198	2012-05-14 13:50:00	2012-05-14 13:50:00	A eappeler	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 14:03:06.193056	2012-05-14 14:03:06.193056	171	190	1	\N	\N	\N	\N	\N	\N
199	2012-05-14 14:31:00	2012-05-14 14:31:00	Impression : toutes les 5 min : "Get /DevMgmt/DiscoveryTree.xml HTTP/1.1 Host: 127.0.0.1:8080" -> 1. Right click on the driver and select "Printer properties" 2. Go to "Device Settings" tab 3. Go to "Installable Options" settings 4. Duplex Unit: Installed 5. Change the status notification to DISABLED. 6. Press "OK" to save the changes. \r\n\r\n	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-14 14:33:34.81003	2012-05-14 14:33:34.81003	91	130	1	\N	\N	\N	\N	\N	\N
201	2012-05-14 15:02:00	2012-05-14 15:02:00	Au courant. Passe par quelqu'un d'autre	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-14 15:05:20.937232	2012-05-14 15:05:20.937232	173	192	1	\N	\N	\N	\N	\N	\N
202	2012-05-14 16:09:00	2012-05-14 16:09:00	Bon de commande : Noms de domaine + messagerie !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-14 16:10:12.352595	2012-05-14 16:10:12.352595	142	60	4	\N	\N	\N	\N	\N	\N
203	2012-05-14 20:35:00	2012-05-14 21:03:00	L'importation de l'inventaire au 31/03/2012 a été effectuée pour les dépôts PASDELOU et GALVA de la société PASDELOU.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-14 21:03:16.17701	2012-05-14 21:03:16.17701	99	104	13	\N	\N	\N	\N	\N	\N
204	2012-05-15 07:03:00	2012-05-15 07:28:00	Souhaite comprendre pourquoi la valorisation de son inventaire est erronée pour une douzaine d'articles. \r\nCertains articles ont été entrés en stock avec un prix d'achat à 0 ---> CMUP erroné. Souhaite comprendre notion de prix de revient et de CMUP. Je dois le rappeler pour cela.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-15 07:30:00.102286	2012-05-15 07:30:00.102286	99	104	1	\N	\N	\N	\N	\N	\N
205	2012-05-15 07:30:00	2012-05-15 07:30:00	Pbm de "langue" sur poste informatique de Fabrice DOISNEAU suite à la mise à jour de Windows XP...\r\nPremier diagnostique sans succès (pbm de police de caractères, virus ?)	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-15 08:04:24.104231	2012-05-15 08:04:24.104231	176	148	1	\N	Capture_Ponthou_Laval.PNG	image/png	171103	2012-05-15 08:04:24.102589	\N
206	2012-05-15 08:04:00	2012-05-15 08:04:00	Il envoie le poste sur Le Mans --> examen plus complet puis devis à PONTHOU.\r\n	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-15 08:17:15.533473	2012-05-15 08:17:15.533473	176	148	2	\N	\N	\N	\N	\N	\N
207	2012-05-15 08:19:00	2012-05-15 08:19:00	Appel d'Amaria Chapeau\r\nUn portable HP démarre mais n'affiche plus les icônes. Windows XP dans le sac ?\r\nJe lui ai conseillé de faire lui même un recovery du poste s'il trouve un CD / DVD\r\nSinon ce sera un devis pour un nouveau poste	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 08:22:01.361966	2012-05-15 08:22:01.361966	129	148	1	\N	\N	\N	\N	\N	\N
208	2012-05-15 08:24:00	2012-05-15 08:24:00	Site non fibrable.\r\nM. Letourneux souhaite devis sur SDSL ==> devis 6 MB sur 4 paires envoyé.\r\nTrop cher\r\nLui envoyer un devis 3 Mb sur 2 paires\r\n\r\nDe plus il aimerait de la redondance de modem	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 08:26:14.351974	2012-05-15 08:26:14.351974	160	176	1	\N	\N	\N	\N	\N	\N
209	2012-05-15 08:26:00	2012-05-15 08:26:00	Appel du support pour pbm SPNEGO (SEGECA) et Bande passante anormale (LABOSPORT) !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-15 08:32:26.132062	2012-05-15 08:32:26.132062	112	132	1	\N	\N	\N	\N	\N	\N
210	2012-05-15 08:37:00	2012-05-15 08:37:00	Appel sur son portable - Répondeur	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 08:45:37.931613	2012-05-15 08:45:37.931613	171	190	1	\N	\N	\N	\N	\N	\N
211	2012-05-15 08:46:00	2012-05-15 08:46:00	Absent	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 08:46:58.294217	2012-05-15 08:46:58.294217	174	193	1	\N	\N	\N	\N	\N	\N
212	2012-05-15 08:53:00	2012-05-15 08:53:00	S'impatiente des lenteurs de mise en place de la ligne téléphonique\r\nMagasin ouvert et toujours pas de téléphone.\r\nMoyen d'avoir au moins un message avec une annonce du numero de l'autre magasin sur un répondeur ?	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 08:55:56.695468	2012-05-15 08:55:56.695468	142	60	1	\N	\N	\N	\N	\N	\N
213	2012-05-15 09:40:00	2012-05-15 09:40:00	Validations points techniques pour création SDSL !\r\nADSL ORANGE (Modem/routeur Bewan).\r\nCâblage a priori en Cat.5.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-15 09:49:58.794895	2012-05-15 09:49:58.794895	175	102	1	\N	\N	\N	\N	\N	\N
249	2012-05-21 07:30:00	2012-05-21 07:30:00	Souhaite devis pour Maintenance NETASQ U30. \r\nJe lui ai précisé que la maintenance repartait du jour où l'ancienne maintenance s'était arrêtée.\r\nSon boitier n'est plus sous maintenance depuis le 06/09/2011.\r\nCotation demandée à CRIS RESEAUX sachant que c'est un compte EDUC (tarif spécial : -40% par rapport au prix public).\r\nDevis à envoyer par e-mail.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-21 09:27:44.667337	2012-05-21 09:27:44.667337	195	210	1	\N	\N	\N	\N	\N	\N
214	2012-05-15 10:06:00	2012-05-15 10:06:00	Appel suite à la modification des règles de NETASQ.\r\nTests :\r\nTéléchargement HTTP depuis Free max de 113 ko/s avec proxy HTTP Activé (slot actif : Pass-all et idem LBS).\r\nTéléchargement HTTP depuis Free max de 120 ko/s avec proxy HTTP Désactivé (slot actif : Pass-all et idem LBS).\r\nTéléchargement FTP depuis FAI max de 800 ko/s avec proxy HTTP Désactivé (slot actif : Pass-all).\r\nTéléchargement HTTP depuis SpeedTest.net max de 9,59 Mbits/s avec proxy HTTP Désactivé (slot actif : LBS). Upload 9,59 Mbits/s\r\nTéléchargement HTTP depuis SpeedTest.net max de 9,57 Mbits/s avec proxy HTTP Activé (slot actif : LBS). Upload 4 Mbits/s\r\nTéléchargement FTP depuis FAI max de 800 ko/s avec proxy HTTP Activé (slot actif : LBS).\r\n\r\nTéléchargement HTTP depuis Free directement sur un PC : 1Mo/s\r\nTéléchargement HTTP depuis Free max de 100 ko/s avec proxy HTTP Activé (slot actif : LBS).\r\n\r\n\r\nPbm de MTU vers Free ?	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-15 11:52:34.096161	2012-05-15 11:52:34.096161	2	3	1	\N	\N	\N	\N	\N	\N
215	2012-05-15 13:04:00	2012-05-15 13:04:00	RDV 23 mai	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 13:19:04.201499	2012-05-15 13:19:04.201499	179	195	1	\N	\N	\N	\N	\N	\N
216	2012-05-15 13:19:00	2012-05-15 13:19:00	ADSL Orange suffisant - Fibre trop chère	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 13:21:45.769487	2012-05-15 13:21:45.769487	180	196	1	\N	\N	\N	\N	\N	\N
217	2012-05-15 13:31:00	2012-05-15 13:31:00	ADSL Orange - 70 EUR / mois. Cela rame un peu mais suffit amplement pour l'usage qui en est fait	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 13:36:05.192454	2012-05-15 13:36:05.192454	\N	198	1	\N	\N	\N	\N	\N	\N
218	2012-05-15 13:37:00	2012-05-15 13:37:00	A un SDSL chez SFR - 5 / 5 - Tout va bien	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 13:40:54.0911	2012-05-15 13:40:54.0911	\N	199	1	\N	\N	\N	\N	\N	\N
219	2012-05-15 14:41:00	2012-05-15 14:41:00	Personne ne répond	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 14:42:12.486081	2012-05-15 14:42:12.486081	182	197	1	\N	\N	\N	\N	\N	\N
221	2012-05-15 14:46:00	2012-05-15 14:46:00	Mail envoyé	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 14:48:34.445671	2012-05-15 14:48:34.445671	183	200	1	\N	\N	\N	\N	\N	\N
224	2011-10-19 09:28:00	2011-10-19 09:28:00	Nouvelle proposition sur 12 mois au lieu de 24.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-15 14:51:22.754407	2012-05-15 14:51:22.754407	32	22	4	\N	SERAC-IXEN_V2.pdf	application/pdf	382796	2012-05-15 14:51:22.753188	\N
225	2011-10-19 09:21:00	2011-10-19 09:21:00	Proposition envoyée (IXEN) pour interconnexion site à site.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-15 14:53:23.908995	2012-05-15 14:53:23.908995	32	22	4	\N	SERAC-IXEN_V1.pdf	application/pdf	382142	2012-05-15 14:53:23.907925	\N
226	2012-05-15 14:51:00	2012-05-15 14:51:00	J'ai eu M. Blin au téléphone ce jour. J'ai pris une vraie soufflante ! Le numéro sur lequel il communique (affichage 4 x 3 et dépliants est le 02 43 72 01 42.\r\nIl aimerait avoir au moins un téléphone au magasin pour pouvoir répondre.\r\n	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 14:53:43.763242	2012-05-15 14:53:43.763242	142	60	1	\N	\N	\N	\N	\N	\N
227	2012-05-15 15:02:00	2012-05-15 15:02:00	Groupe Chastagner - Deleze à la Ferté Bernard	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 15:03:01.165046	2012-05-15 15:03:01.165046	184	201	1	\N	\N	\N	\N	\N	\N
229	2012-05-15 15:01:00	2012-05-15 15:01:00	Validation des comptes e-mail !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-15 15:05:19.18752	2012-05-15 15:05:19.18752	77	15	2	\N	\N	\N	\N	\N	\N
230	2012-05-15 15:19:00	2012-05-15 15:19:00	Faux numéro	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 15:20:45.820517	2012-05-15 15:20:45.820517	186	203	1	\N	\N	\N	\N	\N	\N
231	2012-05-15 15:22:00	2012-05-15 15:22:00	Appeler service informatique à Antony 01 55 54 24 70	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 15:28:09.359467	2012-05-15 15:28:09.359467	187	204	1	\N	\N	\N	\N	\N	\N
232	2012-05-15 15:43:00	2012-05-15 15:43:00	Personne ne répond.	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-15 15:44:37.722406	2012-05-15 15:44:37.722406	188	205	1	\N	\N	\N	\N	\N	\N
233	2012-05-15 15:49:00	2012-05-15 15:49:00	Gerald Poussin : à enlevé la barre d'envoi etc... -> restauration barre menu + pb elements supprimés trop lourd : vidage mails -> Suite à vidage, dossier client supprimé (sans doute situé dans elements supprimés)... a suivre -> récupération pst pour récup mails supprimés...	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-15 15:51:04.774825	2012-05-15 15:51:04.774825	20	17	1	\N	\N	\N	\N	\N	\N
234	2012-05-15 15:44:00	2012-05-15 15:44:00	Non joignable sur son GSM - objectif : faire un point sur CENTREX !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-15 15:58:35.563315	2012-05-15 15:58:35.563315	142	60	1	\N	\N	\N	\N	\N	\N
236	2012-05-16 08:19:00	2012-05-16 08:19:00	Info ligne analogique HBR (0243720142).\r\nPas de tonalité suite à une création de ligne ADSL --> Confirmation de Pascal : "Dégroupage partiel demandé" !\r\nPour info, si on migre le "0243720142" cela va casser le service ADSL existant ! \r\n(donc le recréer si possible avant de faire la portabilité de cette SDA)\r\n	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-16 08:30:36.617033	2012-05-16 08:30:36.617033	189	206	1	\N	\N	\N	\N	\N	\N
237	2012-05-16 08:30:00	2012-05-16 08:30:00	Appel ORANGE Technique au 1015 : Pourquoi il n'y a pas de tonalité sur le 0243720142 ?\r\nRéponse du 1015 : Dossier en cours - pas plus d'information merci d'appeler l'agence commercial au 1016 !\r\n\r\nAppel ORANGE Commercial au 1016 : Quel est ce "dossier en cours" et pourquoi il n'y a pas de tonalité ?\r\nRéponse du 1016 : Intervention dans le répartiteur FT en cours (vérification du transport de la tonalité)\r\n\r\nORANGE doit me rappeler pour me tenir informé de l'avancement de la situation.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-16 09:03:48.570778	2012-05-16 09:03:48.570778	142	60	2	\N	\N	\N	\N	\N	\N
238	2012-05-16 09:03:00	2012-05-16 09:03:00	Appel pour accompagnement de configuration suite à la migration de la messagerie.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-16 09:10:36.130969	2012-05-16 09:10:36.130969	28	15	2	\N	\N	\N	\N	\N	\N
239	2012-05-16 09:32:00	2012-05-16 09:32:00	Appel d'ORANGE --> Il y a bien de la tonalité sur la ligne.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-16 09:51:17.153	2012-05-16 09:51:17.153	142	60	1	\N	\N	\N	\N	\N	\N
240	2012-05-16 12:42:00	2012-05-16 12:42:00	Mail concernant une question de Mr BEAU - SEGECA (SPNEGO)	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-16 12:53:42.964522	2012-05-16 12:53:42.964522	177	132	4	\N	\N	\N	\N	\N	\N
241	2012-05-16 12:53:00	2012-05-16 12:53:00	Mail concernant les résultats des tests de Mr BLANCHET - LABOSPORT (perte de bande passante depuis Free avec le Netasq) !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-16 12:54:16.074475	2012-05-16 12:54:16.074475	177	132	4	\N	\N	\N	\N	\N	\N
242	2012-05-16 14:08:00	2012-05-16 14:08:00	Support NETASQ	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-16 14:08:21.332077	2012-05-16 14:08:21.332077	118	143	3	\N	\N	\N	\N	\N	\N
243	2012-05-16 14:32:00	2012-05-16 14:32:00	Pb configuration mail sur blackberry -> aucune réponse à ce jour... (pr info aucun pb avec celle de M. Dominique Habrial ou M. Dreux...)	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-16 14:32:46.488647	2012-05-16 14:32:46.488647	101	17	1	\N	\N	\N	\N	\N	\N
244	2012-05-16 15:00:00	2012-05-16 15:00:00	Mail envoyé - A montré de l'intérêt	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-16 15:06:30.93176	2012-05-16 15:06:30.93176	178	194	1	\N	\N	\N	\N	\N	\N
245	2012-05-16 15:40:00	2012-05-16 15:40:00	Appel pour vérifier si la modification borne DECT est toujours valide (groupe d'appel DECT + poste secrétariat)\r\n5 tests d'appels --> OK	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-16 15:58:16.581575	2012-05-16 15:58:16.581575	9	8	1	\N	\N	\N	\N	\N	\N
246	2012-05-18 09:58:00	2012-05-18 09:58:00	Le rappeler (Pour Manuel) -> pb technique depuis modification. il n'a plus la main sur son netasq. 	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-18 09:59:20.411214	2012-05-18 09:59:20.411214	118	143	1	\N	\N	\N	\N	\N	\N
247	2012-05-18 09:59:00	2012-05-18 09:59:00	06 20 10 41 49	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-18 10:00:15.395124	2012-05-18 10:00:15.395124	118	143	1	\N	\N	\N	\N	\N	\N
248	2012-05-18 12:47:00	2012-05-18 12:47:00	Ok pour accès page d'administration de Netasq - utilisation du port 8443.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-18 12:49:02.141701	2012-05-18 12:49:02.141701	118	143	2	\N	\N	\N	\N	\N	\N
453	2012-06-08 10:11:00	2012-06-08 10:11:00	Tjs pb de mail avec pièces jointes qui n'arrivent pas. Je les recontacte début semaine prochaine pour faire des tests de chez eux.	n.retout@sigire.fr	n.retout@sigire.fr	2012-06-08 10:12:18.721781	2012-06-08 10:12:18.721781	111	139	3	\N	\N	\N	\N	\N	\N
250	2012-05-21 09:16:00	2012-05-21 09:24:00	Son adresse e-mail ne marche toujours pas sur son mobile. Sur son ordinateur portable, le logiciel Outlook lui demande un mot de passe pour accéder à son compte.\r\nLe rappeler pour régler ces problèmes.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-21 09:38:36.229651	2012-05-21 09:38:36.229651	101	17	1	\N	\N	\N	\N	\N	\N
251	2012-05-16 05:20:00	2012-05-16 05:39:00	Mise à jour des cumuls et re-calcul du CMUP sur société PASDELOU.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-21 10:14:03.174258	2012-05-21 10:14:03.174258	99	104	13	\N	\N	\N	\N	\N	\N
252	2012-05-21 09:38:00	2012-05-21 10:07:00	Souhaitait s'assurer quei la mise à jour du CMUP avait été faite pour PASDELOU. Il va refaire un inventaire au 31/03 pour vérifier la valorisation.\r\nIl rencontre aussi un souci de stock et de valorisation sur 55 articles de POLYMOULE. Pour la valorisation : peut-être normal car plusieurs articles ont été mouvementés depuis son dernier inventaire : cela a donc une incidence sur le prix de revient. Pour les stocks, je lui suggère de regarder si un document n'a pas été saisi récemment avec une date antérieure au 31/03 (ce qui expliquerait les différences constatées).\r\nIl n'a pas bien compris comment fonctionne l'import/export dans SAGE. Prévoir une formation sur ce sujet.\r\nSouhaite aussi importer des nouveaux tarifs dans POLYMOULE pour le client COSNET uniquement.\r\nJe conseille d'attendre le retour d'Isabelle. Si c'est urgent, je ferai la manipulation moi-même.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-21 10:24:14.421188	2012-05-21 10:24:14.421188	99	104	1	\N	\N	\N	\N	\N	\N
253	2012-05-21 10:34:00	2012-05-21 10:34:00	Faisant suite à votre demande, veuillez trouver ci-joint notre devis pour le renouvellement de votre maintenance (qui démarrera rétro-activement au 06/09/2011).\r\n\r\nEn plus de contrat (qui comprend mises à jour et échange du boitier en cas de panne), nous proposons à nos clients de souscrire (en option) un contrat d'assistance pour leur boitier, qui comprend l'accès à notre hot-line, ainsi que l'éventuelle prise en main à distance. Les déplacements et les interventions sur site ne sont pas compris et sont toujours facturées en sus, au temps passé. Ce contrat couvre les dysfonctionnements et n'a pas vocation de formation.\r\n\r\nTarif de cette option "assistance" pour un boitier NETASQ U30 = 100 EUR HT / an.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-21 10:35:56.216991	2012-05-21 10:35:56.216991	195	210	4	\N	esbaa.pdf	application/pdf	35792	2012-05-21 10:35:56.215259	\N
254	2012-05-21 12:02:00	2012-05-21 12:02:00	Plus de connexion AFTTB !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-21 12:03:10.942489	2012-05-21 12:03:10.942489	11	1	1	\N	\N	\N	\N	\N	\N
255	2012-05-21 12:36:00	2012-05-21 12:37:00	Souhaite savoir si la CS6 peut enregistrer au format CS5.5 --> Oui. Souhaite devis pour mise à jour de leur version actuelle vers CS6.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-21 12:58:41.612164	2012-05-21 12:58:41.612164	162	177	1	\N	\N	\N	\N	\N	\N
256	2012-05-21 13:02:00	2012-05-21 13:02:00	Souhaite devis sur LaCie 2Biq Quadra 4To	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-21 13:12:46.715719	2012-05-21 13:12:46.715719	196	211	2	\N	\N	\N	\N	\N	\N
257	2012-05-21 13:13:00	2012-05-21 13:13:00	Prix de vente 2Big Quadra 4 To (301432EK) = 424 EUR HT. Il en parle à son associé et nous rappelle.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-21 13:15:53.632627	2012-05-21 13:15:53.632627	196	211	2	\N	\N	\N	\N	\N	\N
259	2012-05-21 13:27:00	2012-05-21 13:27:00	PB Bellois réglé : mot de passe : brunobellois72.\r\n+ Compte mail paramétré sur son pocket pc. + Tjs pb sur mobile.....	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-21 13:27:35.60474	2012-05-21 13:27:35.60474	101	17	1	\N	\N	\N	\N	\N	\N
260	2012-05-21 13:30:00	2012-05-21 13:30:00	Liste PC parc informatique	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-21 13:31:37.745741	2012-05-21 13:31:37.745741	156	174	3	\N	INFO_ORDI_ITF.xls	application/vnd.ms-excel	53248	2012-05-21 13:31:37.744387	\N
262	2012-05-21 13:58:00	2012-05-21 13:58:00	Je vous confirme les points suivants :\r\n- Vous possédez actuellement des versions ADOBE Creative Suite Standard 5.5\r\n- Vous pouvez enregistrer les fichiers CS6 à un format lisible par la version CS5.5 \r\n- La mise à jour de CS5.5 vers CS6 coûte 329 EUR HT par licence (3 licences dans votre cas). Dans ce cas, il faudra aussi mettre à jour SuiteCase vers la version 4 (78 EUR HT / poste).\r\n\r\nLa config recommandée pour CS6 est la suivante :\r\n- OS X 10.6.8 ou sup.\r\n- RAM 2 Go minimum (8Go recommandés)	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-21 13:58:29.103213	2012-05-21 13:58:29.103213	162	177	4	\N	\N	\N	\N	\N	\N
263	2012-05-21 13:27:00	2012-05-21 13:27:00	Bonjour Monsieur Forestier,\r\n\r\n \r\n\r\nSuite au recalcul des cumuls et au rechargement de l’inventaire, il n’y a plus d’écart de prix unitaire entre le fichier chargé et l’extraction du livre d’inventaire à date du 31/03/2012 : OK.\r\n\r\nCeci montre que le recalcul des cumuls est à faire avant chaque chargement d’inventaire, donc à inclure dans notre procédure ?\r\n\r\n \r\n\r\nJ’ai fait aussi une extraction du livre d’inventaire au 21/05/12. Comme nous le supposions, dans cette extraction, le prix de revient est bien calculé avec la valeur du stock au 31 mars et la valeur des pièces entrées en stock depuis le 31/03.\r\n\r\nExemple PG 1000523 :\r\n\r\n-          Stock au 31/03/12 : 7 pces x 71.08 €\r\n\r\n-          2 sorties réelles le 16/04 et 26/04. Reste 5 x 71.08 = 355.40 €.\r\n\r\n-          10 entrées le 04/05 à PU = 0. Valeur totale = 0 €\r\n\r\n-          Valeur totale (355.40 + 0) / Stock total au 21/05 (5+10=15) = Nouveau prix de revient (23.69€). Le livre d’inventaire au 21/05 donne bien aussi 23.69 €.\r\n\r\n-          Le prix de revient moyen indiqué dans l’onglet « Statistiques » de la fiche article est lui = 11.85 €. Il doit garder un historique complet.\r\n\r\n \r\n\r\nExemple PG 1000521 :\r\n\r\n-          Stock au 31/03/12 : 11 pces x 58.55 €\r\n\r\n-          4 sorties réelles le 16/04 et 26/04. Reste 7 x 58.55 = 409.85 €.\r\n\r\n-          10 entrées le 04/05 à PU = 0. Valeur totale = 0 €\r\n\r\n-          Valeur totale (409.85 + 0) / Stock total au 21/05 (7+10=17) = Nouveau prix de revient (24.11€). Le livre d’inventaire au 21/05 donne bien aussi 24.11 €.\r\n\r\n-          Le prix de revient moyen indiqué dans l’onglet « Statistiques » de la fiche article est lui = 15.61 €. Il doit garder un historique complet.\r\n\r\n \r\n\r\nNB : dans ces 2 exemples, il n’y a pas de sorties de stock après les entrées en stock. Je pense que les prochaines sorties se feront avec la valeur actuelle de prix de revient (23.69 et 24.11 €) ? Si le suivi de stock était en FIFO, elle se ferait avec la valeur du stock le plus ancien (71.08 et 58.55€) jusqu’à épuisement de ce stock ?	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-21 13:59:53.548398	2012-05-21 13:59:53.548398	99	104	3	\N	\N	\N	\N	\N	\N
265	2012-05-21 14:01:00	2012-05-21 14:01:00	Configuration blackberry M. Bellois OK + tests ok (activation sur http://mobileemail.vodafone.fr/) identifiant : b.bellois / mot de passe : Sfr12345	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-21 14:01:20.256816	2012-05-21 14:01:20.256816	101	17	2	\N	\N	\N	\N	\N	\N
266	2012-05-21 14:44:00	2012-05-21 14:51:00	Souhaite ré-importer l'inventaire POLYMOULE. Il renvoie le fichier par e-mail.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-21 14:52:44.40066	2012-05-21 14:52:44.40066	99	104	1	\N	\N	\N	\N	\N	\N
267	2012-05-21 14:53:00	2012-05-21 14:53:00	Les écarts entre le stock chargé et le livre d'inventaire viennent bien de\r\nmouvements avec une date antérieure au 31/03 mais enregistrés après le\r\nchargement de l'inventaire dans SAGE (vérifié sur l'article 6015000 (Qté\r\nchargée = 51 et mouvement de 9.156 enregistré en avril. Livre d'inventaire\r\nau 31/03 = 60.526).\r\n\r\nJ'ai vérifié que tous les mouvements antérieurs au 31/03/12 ont bien été\r\nenregistrés. L'an prochain, nous prendrons garde de bien enregistrer tous le\r\nmouvements avant de charger l'inventaire.\r\nComme convenu, merci de charger à nouveau l'inventaire Polymoule selon\r\nfichier ci-joint, sur le dépôt Polymoule à date du 31/03/2012.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-21 14:54:22.570883	2012-05-21 14:54:22.570883	99	104	3	\N	articles_polymoule4.xls	application/vnd.ms-excel	733696	2012-05-21 14:54:22.569697	\N
268	2012-05-16 12:46:00	2012-05-16 12:46:00	Je viens de prendre possession de mon nouveau PC : POSTE 7  (j’étais en congés hier) et je viens de m’apercevoir que le logiciel des tarifs n’a pas été réinstallé sur mon poste sous le TSE.\r\n\r\n \r\n\r\nJ’ai essayé de le faire moi-même en créant un raccourci mais à chaque fois que je l’ouvre il me demande d’exécuter le programme. De plus, pour saisir des décimales je suis obligé de saisir une virgule avec le clavier alphanumérique, je ne peux pas saisir le point du clavier numérique.\r\n\r\n \r\n\r\nMerci de bien vouloir faire le nécessaire.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-21 15:29:16.73989	2012-05-21 15:29:16.73989	197	129	3	\N	\N	\N	\N	\N	\N
392	2012-05-31 14:30:00	2012-05-31 14:30:00	Imprimante Epson C62 (compatible Windows 98) en carafe. Cherche une solution de remplacement. Je l'ai prévenue que l'on remontait au néolithique avec ce genre de produits... Difficile à trouver	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-31 14:32:16.207085	2012-05-31 14:32:16.207085	31	7	1	\N	\N	\N	\N	\N	\N
269	2012-05-18 07:22:00	2012-05-18 07:22:00	Le logiciel des tarifs est installé sur le serveur, en mode TSE. Il est \r\ndonc nécessairement accessible par tous les postes.\r\n\r\nAvez-vous bien essayé de lancer le logiciel en passant par le TSE (et \r\nnon allant directement chercher le fichier sur le serveur) ?	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-21 15:30:06.355605	2012-05-21 15:30:06.355605	197	129	4	\N	\N	\N	\N	\N	\N
270	2012-05-21 07:06:00	2012-05-21 07:06:00	J'ai créé un raccourci sur le bureau en mode TSE.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-21 15:30:42.111754	2012-05-21 15:30:42.111754	197	129	3	\N	\N	\N	\N	\N	\N
271	2012-05-21 14:38:00	2012-05-21 14:38:00	Monsieur,\r\n\r\n \r\n\r\nLorsque je suis en local (hors TSE), je ne peux pas me servir de l’imprimante couleur ADV5035 : impossibilité de choisir une cassette (même pas de proposition avec le dessin pour le choix du bac), impossibilité d’agrafer, …\r\n\r\n \r\n\r\nPour information, je ne travail pas sous TSE en ce qui concerne Word et Excel. J’utilise le TSE pour Sage et le logiciel des tarifs sinon je suis en local.\r\n\r\n \r\n\r\nMerci de voir le problème.\r\n\r\n \r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-21 15:31:04.033373	2012-05-21 15:31:04.033373	197	129	3	\N	\N	\N	\N	\N	\N
272	2012-05-21 15:33:00	2012-05-21 15:33:00	Appel pour prendre REV afin de faire le point sur : installation Office 2011 sur 2 Mac / Conversion fichier AppleWorks en Word / Téléphonie (qui semble bien marcher d'après M. Puren). RDV pris Vendredi 25/05/2012 à 14h00.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-21 15:44:55.430218	2012-05-21 15:44:55.430218	198	212	2	\N	\N	\N	\N	\N	\N
273	2012-05-21 15:08:00	2012-05-21 15:08:00	Monsieur Forestier,\r\n\r\n \r\n\r\nVoici le tarif à enregistrer dans le SAGE Polymoule.\r\n\r\nColonne A : Référence Polymoule\r\n\r\nColonne D : tarif à enregistrer dans la fiche article / Catégorie tarifaire « Cos »\r\n\r\nLes tarifs vers les autres catégories que « Cos » ne doivent pas être modifiés.\r\n\r\n \r\n\r\n \r\n\r\nCordialement,	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-21 15:47:44.333596	2012-05-21 15:47:44.333596	99	104	3	\N	Tarif_de_vente_de_Polymoule_à_Cosnet.xlsx	application/vnd.openxmlformats-officedocument.spreadsheetml.sheet	76043	2012-05-21 15:47:44.331781	\N
274	2012-05-21 16:06:00	2012-05-21 16:07:00	Bonsoir,\r\n\r\nAprès concertation, voici ce que nous pouvons vous proposer pour l'acquisition du nouvel iMac ET la mise à jour des iMac existants.\r\n\r\nJe vous rappelle que SuitCase 4 ne dispose pas encore de plugins compatible CS6 (disponibles normalement gratuitement très prochainement) et que les polices doivent donc être activées manuellement ans chaque document.\r\n\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-21 16:06:51.798721	2012-05-21 16:06:51.798721	162	177	4	\N	sofac.pdf	application/pdf	38834	2012-05-21 16:06:51.797019	\N
275	2012-05-22 04:17:00	2012-05-22 05:01:00	Sauvegarde de la base de données POLYMOULE.\r\nMise en forme du fichier Excel envoyé par M. Leverrier.\r\nSuppression de l'inventaire du 31/03/2012 précédemment importé (certains documents liés à cet inventaire ne peuvent apparemment pas être supprimés ?).\r\nImportation de l'inventaire.\r\nPb lors de l'importation de l'inventaire : "l'article 6200284 n'existe pas. Ligne 463". Je supprime cette ligne et recommence.\r\nNouveau pb : "l'article 6736292 n'existe pas. Ligne 1858".Je supprime cette ligne et recommence.\r\nImportation terminée. 	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-22 05:01:42.903001	2012-05-22 05:01:42.903001	99	104	13	\N	SAGE-imporation_inventaire.rtf	text/rtf	1653	2012-05-22 05:01:42.901263	\N
276	2012-05-22 07:40:00	2012-05-22 07:49:00	Souhaite des précisions sur l'activation manuelle des polices. Je lui ai indiqué que cela ne faisait qu'alourdir un peu le processus mais que le logiciel SuitCase 4 est bien compatible. Le plug-in devrait être disponibles dans les semaines à venir.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-22 07:50:12.003348	2012-05-22 07:50:12.003348	162	177	1	\N	\N	\N	\N	\N	\N
277	2012-05-22 08:32:00	2012-05-22 08:32:00	Pb de vitesse sur l'A-FTTB. Semble très lent. Speedtest indique 9Mbps descendant et 1,4 Mbps montants. Donc a priori, pas de problèmes... 	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-22 08:37:31.518844	2012-05-22 08:37:31.518844	11	1	1	\N	\N	\N	\N	\N	\N
278	2012-05-22 08:48:00	2012-05-22 08:48:00	Appel pour faire le point sur le contrat FUTUR TELECOM. M. Tabut est occupé, le rappeler demain.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-22 08:50:22.297713	2012-05-22 08:50:22.297713	202	213	2	\N	\N	\N	\N	\N	\N
279	2012-05-22 08:40:00	2012-05-22 09:00:00	Prise en main à distance pc Christelle : pb bac et agrafage non dispo sur imp Canon 5035 -> "propriétés imp -> lire info imp" + tests ok.\r\nSession TSE : suppression fenetre "gestionnaire serveur" + pb accès logiciel "Tarifs" -> création raccourci + tests ok\r\n	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-22 08:57:17.920258	2012-05-22 08:57:17.920258	197	129	2	\N	\N	\N	\N	\N	\N
281	2012-05-22 09:05:00	2012-05-22 09:05:00	Demande rdv à domicile pour vérification et/ou paramétrage wifi (jeudi matin ou apm)	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-22 09:05:17.943872	2012-05-22 09:05:17.943872	90	129	4	\N	\N	\N	\N	\N	\N
282	2012-05-22 09:10:00	2012-05-22 09:10:00	Souhaite intervention sur site pour installation LibreOffice + "nettoyage" PC.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-22 09:10:52.803638	2012-05-22 09:10:52.803638	203	215	1	\N	\N	\N	\N	\N	\N
283	2012-05-22 09:25:00	2012-05-22 09:25:00	Message laissé sur son répondeur pour lui dire que le principe d'une intervention jeudi 24/05 est OK et qu'on le rappelle pour lui préciser l'heure.\r\nAttention à ne pas dépasser 2 heures pour l'intervention (ou bien lui dire avant).	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-22 09:25:36.598881	2012-05-22 09:25:36.598881	203	215	2	\N	\N	\N	\N	\N	\N
284	2012-05-22 09:31:00	2012-05-22 09:31:00	Appel pour faire le point sur proposition + contrat téléphonie mobile. En rendez-vous. Rappeler cet après-midi.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-22 09:33:25.888683	2012-05-22 09:33:25.888683	78	2	2	\N	\N	\N	\N	\N	\N
285	2012-05-22 09:33:00	2012-05-22 09:33:00	Bonjour,\r\n\r\nJ'ai tenté de vous joindre par téléphone à l'instant mais sans succès.\r\n\r\n Je revenais vers vous concernant la proposition d'abonnement "data" pour un ipad. Avez-vous avancé sur ce sujet ?\r\n\r\nJe souhaiterais aussi faire le point avec vous concernant votre parc de téléphones mobiles, et, par la même occasion, vous rencontrer puisque nous n'en avons pas encore eu l'occasion depuis le départ de Stéphane.\r\n\r\nAvez-vous une disponibilité semaine prochaine (ou la suivante) ?\r\n\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-22 09:37:19.674708	2012-05-22 09:37:19.674708	78	2	4	\N	\N	\N	\N	\N	\N
286	2012-05-22 09:39:00	2012-05-22 09:39:00	RDV jeudi après midi à partir de 14h30	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-22 09:39:51.445452	2012-05-22 09:39:51.445452	90	129	3	\N	\N	\N	\N	\N	\N
287	2012-05-22 09:37:00	2012-05-22 09:37:00	Appel pour faire le point. Souhaite 2 nouveaux abonnements mobiles + 1 transfert d'un abonnement existant. Lui envoyer un e-mail pour qu'il réponde avec les caractéristiques.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-22 09:41:57.01034	2012-05-22 09:41:57.01034	88	128	2	\N	\N	\N	\N	\N	\N
289	2012-05-22 09:42:00	2012-05-22 09:42:00	Message laissé à sa secrétaire : proposition intervention jeudi matin à partir de 9h30	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-22 09:42:19.538495	2012-05-22 09:42:19.538495	203	215	2	\N	\N	\N	\N	\N	\N
290	2012-05-22 09:41:00	2012-05-22 09:41:00	Monsieur,\r\n\r\nComme convenu par téléphone à l'instant, je vous prie de bien vouloir me faire parvenir par retour les caractéristiques des abonnements souhaités (2 nouveaux abonnements mobiles + 1 transfert).\r\n\r\nJe reste bien évidemment à votre disposition pour toute question.\r\n\r\n\r\nCordialement.\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-22 09:43:50.188429	2012-05-22 09:43:50.188429	88	128	4	\N	\N	\N	\N	\N	\N
563	2012-07-01 22:00:00	2012-07-01 22:00:00	\N	g.bonvoust@sigire.fr	g.bonvoust@sigire.fr	2012-07-02 08:02:25.810717	2012-07-02 08:02:25.810717	\N	24	11	\N	\N	\N	\N	\N	2
580	2012-07-09 22:00:00	2012-07-09 22:00:00	\N	\N	m.ozan@sigire.fr	2012-07-10 08:37:00.851911	2012-07-10 08:37:00.851911	\N	265	11	\N	\N	\N	\N	\N	6
581	2012-07-09 22:00:00	2012-07-09 22:00:00	\N	\N	m.ozan@sigire.fr	2012-07-10 08:42:25.218568	2012-07-10 08:42:25.218568	20	17	11	\N	\N	\N	\N	\N	5
292	2012-05-22 09:48:00	2012-05-22 09:48:00	Bonjour,\r\n\r\n\r\nJe reviens vers vous pour savoir si vous avez eu l'occasion de planifier un rendez-vous avec M. Prunier afin que nous puissions refaire un point complet sur le parc de mobiles. Ce sera aussi l'occasion de nous rencontrer et de présenter à nouveau notre structure depuis le départ de Stéphane Sarélot.\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-22 09:52:03.710046	2012-05-22 09:52:03.710046	100	97	4	\N	\N	\N	\N	\N	\N
293	2012-05-22 09:53:00	2012-05-22 09:53:00	RDV confirmé jeudi matin 9h30	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-22 09:54:18.558377	2012-05-22 09:54:18.558377	203	215	1	\N	\N	\N	\N	\N	\N
294	2012-05-22 10:05:00	2012-05-22 10:05:00	Appel à propos de la cartouche de sauvegarde. Personne ne répond.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-22 10:06:21.070868	2012-05-22 10:06:21.070868	\N	144	2	\N	\N	\N	\N	\N	\N
295	2012-05-22 10:15:00	2012-05-22 10:15:00	Bonjour,\r\n\r\nJ'ai tenté de vous joindre à l'instant mais sans succès.\r\nMme Moison (avant de partir en congés) m'a laissé un message en m'indiquant de vous rappeler à propos d'une cartouche de sauvegarde qui serait en commande.\r\n\r\nNe trouvant aucun bon de commande ayant trait à cela, je reviens vers vous pour avoir plus de précisions. S'agit-il d'une cartouche pour l'ancien serveur de la jardinerie ?\r\n\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-22 10:15:34.664507	2012-05-22 10:15:34.664507	204	144	4	\N	\N	\N	\N	\N	\N
296	2012-05-22 14:57:00	2012-05-22 14:57:00	Paramètrage mobile blackberry sfr : http://mobileemail.vodafone.fr/ (Id: jl.vivier Password: Cmmv49img)	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-22 14:58:41.652028	2012-05-22 14:58:41.652028	5	5	11	\N	\N	\N	\N	\N	\N
298	2012-05-22 15:58:00	2012-05-22 15:58:00	Demande d'infos concernant les e-mail Google Apps.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-22 16:57:19.617195	2012-05-22 16:57:19.617195	39	36	4	\N	\N	\N	\N	\N	\N
299	2012-05-22 12:27:00	2012-05-22 12:27:00	Bonjour Monsieur Forestier,\r\n\r\nLes quantités sont OK (vérifié avec extraction d'inventaire). Vous avez bien fait de supprimer les 2 lignes en question.\r\nCependant, je note de très gros écart sur le PR unitaire (on pouvait s'attendre à de faibles variations). Exemples:\r\n- 6000009: PR en avril 1.3 €.  PR de l'extraction de ce jour: 15.97 (plus de 10 fois plus !).  mouvement d'entrée depuis le 31/03 avec 1.3 €\r\n- P1130537: PR avril 221.17€. PR de l'extraction de ce jour: -1443.55 €. Pas de mouvements d'entrée depuis l'inventaire.\r\nJe ne comprends pas ces variations brutales. A quoi sont-elles dues (détail dans le fichier ci-joint)?\r\n\r\nCordialement,	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-23 06:47:56.325992	2012-05-23 06:47:56.325992	99	104	3	\N	\N	\N	\N	\N	\N
300	2012-05-23 07:10:00	2012-05-23 07:10:00	Souhaite devis pour borne Wifi pour couvrir atelier. Le recontacter.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-23 07:11:07.53382	2012-05-23 07:11:07.53382	205	148	1	\N	\N	\N	\N	\N	\N
301	2012-05-23 07:22:00	2012-05-23 07:29:00	Bonjour,\r\n\r\nConcernant ces deux produits, la seule façon de retrouver un prix de revient "correct" serait de réajuster les cumuls (comme pour PASDELOU).\r\n\r\nD'où cela peut-il venir ?\r\n\r\n- de saisies erronées qui sont ensuite modifiées,\r\n- de mouvements saisis qui sont ensuite supprimés,\r\netc.\r\n\r\n\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-23 07:29:49.443599	2012-05-23 07:29:49.443599	99	104	4	\N	\N	\N	\N	\N	\N
302	2012-05-23 07:28:00	2012-05-23 07:28:00	Support Netasq LABOSPORT (Bande passante vers Free + e-mailing) + SEGECA (HA)	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-23 07:37:48.492394	2012-05-23 07:37:48.492394	177	132	2	\N	\N	\N	\N	\N	\N
303	2012-05-23 08:49:00	2012-05-23 08:49:00	RDV avec Sébastien Queru le 06 septembre	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-23 08:50:23.326513	2012-05-23 08:50:23.326513	188	205	1	\N	\N	\N	\N	\N	\N
304	2012-05-23 07:29:00	2012-05-23 09:02:00	Souhaite encore des précisions sur les valorisations, le calcul du CMUP, la meilleure méthode pour valoriser l'inventaire.. etc.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-23 09:05:19.376133	2012-05-23 09:05:19.376133	99	104	1	\N	\N	\N	\N	\N	\N
305	2012-05-23 09:19:00	2012-05-23 09:19:00	Travaille dorénavant avec MODULO pour la téléphonie mobile. N'a rien contre nous, mais c'est un choix de la direction. Ils ont aussi déjà un prestataire pour l'informatique dont ils sont contents. Pour la fibre, ils sont au courant, mais pas de besoin pour le moment.\r\nClient à priori perdu.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-23 09:25:47.792179	2012-05-23 09:25:47.792179	78	2	2	\N	\N	\N	\N	\N	\N
306	2012-05-23 09:25:00	2012-05-23 09:25:00	Toutes les décisions passent par le groupe	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-23 09:31:14.390789	2012-05-23 09:31:14.390789	207	216	1	\N	\N	\N	\N	\N	\N
307	2012-05-23 09:32:00	2012-05-23 09:32:00	A rappeler le 24 mai	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-23 09:39:21.571384	2012-05-23 09:39:21.571384	208	217	1	\N	\N	\N	\N	\N	\N
308	2012-05-23 09:41:00	2012-05-23 09:41:00	Décision groupe	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-23 09:45:37.171745	2012-05-23 09:45:37.171745	209	218	1	\N	\N	\N	\N	\N	\N
309	2012-05-23 09:47:00	2012-05-23 09:47:00	ADSL Orange pour 3 ans. Largement suffisant	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-23 09:49:56.468046	2012-05-23 09:49:56.468046	210	219	1	\N	\N	\N	\N	\N	\N
310	2012-05-23 09:54:00	2012-05-23 09:54:00	Aujourd'hui personne ne répond...	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-23 09:56:02.441004	2012-05-23 09:56:02.441004	211	220	1	\N	\N	\N	\N	\N	\N
311	2012-05-23 13:34:00	2012-05-23 13:34:00	Tests NETASQ !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-23 13:42:29.689574	2012-05-23 13:42:29.689574	2	3	1	\N	\N	\N	\N	\N	\N
312	2012-05-23 14:43:00	2012-05-23 14:43:00	Plus de connexion INTERNET	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-23 14:44:56.496488	2012-05-23 14:44:56.496488	22	17	1	\N	\N	\N	\N	\N	\N
313	2012-05-23 14:51:00	2012-05-23 14:51:00	Reboot du Modem sans succès, tests de ping (8.8.8.8) : KO.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-23 14:52:36.900123	2012-05-23 14:52:36.900123	212	17	2	\N	\N	\N	\N	\N	\N
314	2012-05-23 15:34:00	2012-05-23 15:34:00	La connexion est très instable. Reboot du routeur par acquis de conscience...	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-23 15:42:22.068568	2012-05-23 15:42:22.068568	212	17	1	\N	\N	\N	\N	\N	\N
315	2012-05-23 15:44:00	2012-05-23 15:44:00	Souhaite un RDV. A un pb avec un Blackberry Torch. Doit passer le 24/05 apm.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-23 15:45:36.194068	2012-05-23 15:45:36.194068	213	221	2	\N	\N	\N	\N	\N	\N
316	2012-05-23 15:45:00	2012-05-23 15:45:00	2 divisions : VOLVO et FORD à la même adresse\r\nFORD : lien SDSL 1 Mb Orange souscrit en sept 2011 pour 36 mois ==> Il paye 308 EUR / mois. Il aimerait également une fibre AFTTB, mais l'engagement de 36 mois freine ses ardeurs.\r\nVOLVO : lien ADSL Orange 512 K à remplacer par une fibre AFTTB (qui évoluera sans doute en FTTB par la suite)\r\n\r\nTéléphonie fixe Orange catastrophique. Il a RDV le 07 juin avec Orange pour régler pbms.Vivement intéressé par notre solution de téléphonie. Aimerait rencontrer Gabriel après le 7 juin en fonction de ce qui se sera passé avec Orange\r\nFlotte de 10 mobiles Orange ==> Voir par la suite pour passer en Futur Telecom\r\n	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-23 15:51:13.427655	2012-05-23 15:51:13.427655	179	195	1	\N	\N	\N	\N	\N	\N
317	2012-05-23 16:09:00	2012-05-23 16:09:00	Cher Monsieur,\r\n\r\n\r\nVeuillez trouver ci-joint le devis souhaité.\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-23 16:13:51.514243	2012-05-23 16:13:51.514243	196	211	4	\N	Documents.pdf	application/pdf	35573	2012-05-23 16:13:51.512088	\N
318	2012-05-24 07:19:00	2012-05-24 07:19:00	Prise de RDV pour suite déploiement de poste IP.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-24 07:24:39.411537	2012-05-24 07:24:39.411537	3	4	2	\N	\N	\N	\N	\N	\N
319	2012-05-24 07:01:00	2012-05-24 07:32:00	Pb sur son ordinateur : impossible de fermer Outlook qui "tourne dans le vide". Même pb d'après lui après redémarrage de la machine. J'ai pris la main en Teamviewer : en fait, il mettait la machine en veille. J'ai supprimé le processus Outlook planté via le gestionnaire des tâches, puis, j'ai redémarré le poste (Menu Démarrer/Redémarrer). Outlook se lance correctement. L'affichage des dossiers avait été désactive : je le réactive (Menu Affichage/Liste des dossiers). Test OK.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-24 07:34:37.103679	2012-05-24 07:34:37.103679	23	17	1	\N	\N	\N	\N	\N	\N
320	2012-05-24 07:29:00	2012-05-24 07:29:00	Bonjour Monsieur Forestier,\r\n\r\n \r\n\r\nJ’ai fait le réajustement des cumuls Polymoule cette nuit. Ce matin mon PC était déloggé (mais pas éteint).\r\n\r\nJ’ai refait une extraction de livre d’inventaire au 31/03/2012. Comme les chiffres ont changé par rapport à la dernière extraction, je me dis que le réajustement est bien fait.\r\n\r\n-          Pas d’écart quantité par rapport à l’import d’inventaire.\r\n\r\n-          Des écarts sur les PR unitaires.\r\n\r\n \r\n\r\nDétails dans le fichier ci-joint.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-24 07:38:04.032749	2012-05-24 07:38:04.032749	99	104	3	\N	Inventaire_Polymoule_2012_Fichier_import_dans_SAGE_Vérification.xls	application/vnd.ms-excel	6057472	2012-05-24 07:38:04.031435	\N
321	2012-05-24 08:00:00	2012-05-24 08:00:00	ADSL lui suffit. Aurait pu être intéressé par SDSL pour téléphonie, mais il est engagé pour 36 mois chez un opérateur de minutes en volume. Il ne m'a pas craché le nom de cet opérateur	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-24 08:06:05.734132	2012-05-24 08:06:05.734132	208	217	1	\N	\N	\N	\N	\N	\N
322	2012-05-24 08:35:00	2012-05-24 08:35:00	Client Sarthe Telecom. A priori signera la fibre avec eux	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-24 08:43:40.239527	2012-05-24 08:43:40.239527	214	222	1	\N	\N	\N	\N	\N	\N
323	2012-05-24 08:46:00	2012-05-24 08:46:00	Absent	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-24 08:47:30.953005	2012-05-24 08:47:30.953005	215	223	1	\N	\N	\N	\N	\N	\N
324	2012-05-24 09:17:00	2012-05-24 09:17:00	Demande devis pour VPN + demande devis formation word et excel (Libre Office)	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-24 09:17:32.26885	2012-05-24 09:17:32.26885	203	215	9	\N	\N	\N	\N	\N	\N
325	2012-05-24 12:36:00	2012-05-24 12:36:00	Suite à la nouvelle installation sur le poste de Mme Martineau, elle n'a plus accès à ses bulletins modèles, ni à ses éditions GA.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-24 13:37:40.595686	2012-05-24 13:37:40.595686	216	48	1	\N	\N	\N	\N	\N	\N
326	2012-05-24 13:58:00	2012-05-24 13:58:00	Pbs résolus :\r\n- "Mémoire insuffisante ou espace disque insuffisant" : lancer la Paie en utilisant un lecteur logique (M: par exemple) et pas un chemin de type UNC.\r\n- Bulletins modèles disparus : copier le dossier GA du serveur, ainsi que les fichiers pms.sga et pms.fga dans le dossier programmes/SagePaie du poste de l'utilisateur.\r\nTests OK.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-24 14:00:37.144402	2012-05-24 14:00:37.144402	216	48	2	\N	\N	\N	\N	\N	\N
327	2012-05-24 14:18:00	2012-05-24 14:18:00	Pas mal de décisions prises au Danemark\r\nIdem pour l'administration de l'infra. Ils n'ont pas les mots de passe "serveur" par exemple.\r\nEn revanche, gros projet de téléphonie fixe en septembre. Prévoir visite avec Gabriel. Ne sont pas encore fixés entre IPBX et Centrex.\r\nTéléphonie mobile administrée d'Orléans	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-24 14:18:17.636414	2012-05-24 14:18:17.636414	218	224	1	\N	\N	\N	\N	\N	\N
328	2012-05-24 14:18:00	2012-05-24 14:18:00		g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-24 14:18:37.582652	2012-05-24 14:18:37.582652	218	224	10	\N	\N	\N	\N	\N	\N
329	2012-05-24 14:54:00	2012-05-24 14:54:00	Demande de support pour configuration de pieuvre POLYCOM !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-24 14:54:17.708937	2012-05-24 14:54:17.708937	217	191	1	\N	\N	\N	\N	\N	\N
330	2012-05-24 14:56:00	2012-05-24 14:56:00	Mail pour demande de support.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-24 15:04:01.881774	2012-05-24 15:04:01.881774	221	191	4	\N	\N	\N	\N	\N	\N
331	2012-05-24 15:39:00	2012-05-24 15:39:00	PC nettoyer et OpenOffice installé disponible dans bureau avec BL dessus	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-24 15:40:12.740099	2012-05-24 15:40:12.740099	203	215	12	\N	\N	\N	\N	\N	\N
332	2012-05-24 15:41:00	2012-05-24 15:41:00	PC récupéré de Laval -> système HS -> données sauvegardées -> Réinstall système nécessaire -> Cd de restauration fournis (iso) : inexploitable. Attente nouveaux cd (vu avec Gilles)	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-24 15:42:24.002305	2012-05-24 15:42:24.002305	127	148	12	\N	\N	\N	\N	\N	\N
334	2012-05-24 15:52:00	2012-05-24 15:52:00	CD de réinstallation donné à GG par Amaria en main propres le 23 mai en fin d'après-midi	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-24 15:53:33.9279	2012-05-24 15:53:33.9279	129	148	1	\N	\N	\N	\N	\N	\N
335	2012-05-24 15:53:00	2012-05-24 15:53:00	J'ai appelé Amaria le 24 mai en milieu d'AM pour lui dire que son CD était inexploitable. Il va faire plus de recherches. C'est comme s'il laissait une voiture au garage sans les clés !	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-24 15:55:01.448379	2012-05-24 15:55:01.448379	129	148	1	\N	\N	\N	\N	\N	\N
336	2012-05-24 15:55:00	2012-05-24 15:55:00	Appel de M. Doisneau (Ponthou Laval) le 23 mai pour savoir où en est la réparation. Je lui ai annoncé qu'on ne travaillait pas encore la nuit, étant donné que le CD de restauration était dans nos mains que depuis la veille au soir !	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-24 15:56:20.84535	2012-05-24 15:56:20.84535	129	148	1	\N	\N	\N	\N	\N	\N
337	2012-05-24 15:27:00	2012-05-24 15:27:00	Configuration des comptes Google Apps - redirection/transfert	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-24 16:09:17.301091	2012-05-24 16:09:17.301091	39	36	2	\N	\N	\N	\N	\N	\N
338	2012-05-24 07:33:00	2012-05-24 09:02:00	Le réajustement des cumuls a provoqué quelques modifications importantes dans le prix de revient de certains articles. Il pense qu'il n'aurait pas dû faire cette manipulation. Semble complètement perdu. \r\nJe lui ai redonné quelques explications : les articles concernés ont subi des mouvements avec des prix totalement erronés (en 2008 et 2009 notamment). Cela explique pourquoi le CMUP est impacté.\r\nIl s'oriente vers une modification manuelle des prix de revient pour retrouver des prix cohérents.\r\nJ'attends un e-mail pour me confirmer tout cela.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-25 07:01:09.662063	2012-05-25 07:01:09.662063	99	104	1	\N	\N	\N	\N	\N	\N
339	2012-05-25 06:36:00	2012-05-25 06:36:00	La liaison internet ne marche plus. J'ai remonté le pb à OCEANET : effectivement, il semble qu'il y ait une coupure sur toutes les liaisons en porte nationale.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-25 07:02:10.651506	2012-05-25 07:02:10.651506	93	104	1	\N	\N	\N	\N	\N	\N
340	2012-05-25 07:29:00	2012-05-25 07:29:00	Envoi le 24 mai de 2 devis pour obtenir un Outlook récent\r\n\r\n1/ Office standard 2010 Open business avec installation de la version 2007 sur le poste de M. Habrial\r\n\r\nou\r\n2/ Nouveau poste avec Office 2010 PKC	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-25 07:31:47.928867	2012-05-25 07:31:47.928867	22	17	1	\N	\N	\N	\N	\N	\N
341	2012-05-25 07:33:00	2012-05-25 07:33:00	OK pour commande de l'Office 2010 uniquement (pas de nouveau poste).	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-25 07:40:47.148871	2012-05-25 07:40:47.148871	23	17	1	\N	\N	\N	\N	\N	\N
342	2012-05-25 08:05:00	2012-05-25 08:05:00	Configuration des comptes Google Apps - redirection/transfert (suite).	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-25 08:05:45.007286	2012-05-25 08:05:45.007286	39	36	2	\N	\N	\N	\N	\N	\N
343	2012-05-24 16:18:00	2012-05-24 16:18:00	Bonjour Monsieur Forestier,\r\n\r\n \r\n\r\nComme convenu ce matin, merci de charger à nouveau l'inventaire Polymoule\r\n\r\nsur le dépôt Polymoule à date du 31/03/2012 et après avoir supprimé les 2 lignes qui n’existent plus dans SAGE.\r\n\r\n \r\n\r\nCordialement,	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-25 08:10:50.643896	2012-05-25 08:10:50.643896	99	104	3	\N	\N	\N	\N	\N	\N
344	2012-05-25 08:12:00	2012-05-25 08:12:00	Message laissé sur portable de M. Tillaud :\r\n\r\nSoit il vient le chercher aujourd'hui, soit Nicolas le lui amène mardi 29	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-25 08:15:41.445765	2012-05-25 08:15:41.445765	203	215	1	\N	\N	\N	\N	\N	\N
345	2012-05-25 08:17:00	2012-05-25 08:17:00	Souhaite devis pour 1 poste (UV + écran + Office PME + install).	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-25 08:17:25.01386	2012-05-25 08:17:25.01386	222	116	1	\N	\N	\N	\N	\N	\N
394	2012-05-31 14:58:00	2012-05-31 14:58:00	Messages d'erreur taille max de sauvegarde atteinte sur certains pc (sans doute le recovery des pc -> à désactiver) 	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-31 15:00:10.470022	2012-05-31 15:00:10.470022	124	38	1	\N	\N	\N	\N	\N	\N
395	2012-05-31 15:00:00	2012-05-31 15:00:00	J'ai rappelé mais personne est au courant et aurore était indisponible. Je rappelle vendredi dans la journée.	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-31 15:00:47.344855	2012-05-31 15:00:47.344855	124	38	2	\N	\N	\N	\N	\N	\N
347	2012-05-25 08:51:00	2012-05-25 08:51:00	Madame,\r\n\r\nVeuillez trouver ci-joint le devis souhaité.\r\nPour information, le poste proposé est au format Tour. Il est livré avec Windows 7 Pro. Si vous avez une imprimante, il faut bien s'assurer que celle-ci est compatible Windows 7.\r\n\r\nL'unité centrale est livrée avec un port ethernet qui permet de connecter avec un câble réseau l'ordinateur à votre réseau.\r\n\r\nJe reste à votre disposition pour toute information.\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-25 08:51:57.324236	2012-05-25 08:51:57.324236	222	116	4	\N	Documents.pdf	application/pdf	37451	2012-05-25 08:51:57.323125	\N
348	2012-05-25 08:15:00	2012-05-25 08:15:00	M. Tillaud vient normalement cet après-midi	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-25 09:12:24.366543	2012-05-25 09:12:24.366543	203	215	1	\N	\N	\N	\N	\N	\N
349	2012-05-25 08:40:00	2012-05-25 09:28:00	Pb d'impression en Gestion Avancée dans la Paie SAGE.\r\nEn allant voir les modèles (GA/Modèles) : ils sont vides. Il suffit de fermer le logiciel et de le réouvrir (en lançant l'exécutable), puis de faire Fichier/Ouvrir et d'aller chercher le fichier PRH. Le raccourci était incorrect. Pb réglé.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-25 09:30:10.024356	2012-05-25 09:30:10.024356	216	48	1	\N	\N	\N	\N	\N	\N
350	2012-05-25 15:00:00	2012-05-25 15:00:00	Monsieur,\r\n\r\nNous avons bien reçu votre commande d'extension de garantie NETASQ et vous en remercions. Pour la valider, NETASQ demande à connaître le numéro de série du boitier. Pouvez-vous nous le fournir ?\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-25 15:01:10.115279	2012-05-25 15:01:10.115279	195	210	4	\N	\N	\N	\N	\N	\N
351	2012-05-25 15:10:00	2012-05-25 15:10:00	Bonjour,\r\n\r\nVoici le numéro de série\r\n\r\nU30XXA0A09  2367 0\r\n\r\nCordialement	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-25 15:11:09.148758	2012-05-25 15:11:09.148758	195	210	3	\N	\N	\N	\N	\N	\N
352	2012-05-25 15:19:00	2012-05-25 15:30:00	A nouveau, discussion sur prix de revient et valorisation de l'inventaire. M. Leverrier va faire quelques tests et nous refaisons le point semaine prochaine avant d'entamer toute action.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-25 15:31:40.497678	2012-05-25 15:31:40.497678	99	104	2	\N	\N	\N	\N	\N	\N
353	2012-05-25 07:34:00	2012-05-25 07:34:00	Le lien SDSL remonte à 09h14m. Pb lié au dysfonctionnement d'un serveur RADIUS. 	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-25 15:32:59.402279	2012-05-25 15:32:59.402279	93	104	2	\N	\N	\N	\N	\N	\N
355	2012-05-29 07:55:00	2012-05-29 07:55:00	Pbm de réception de mail depuis Mr PRIOLLAUD - Pas de pbm de réception de PJ sur le poste d'Anne.\r\nTests depuis le serveur : Ok vers mon poste mais toujours KO vers le poste de Anne.\r\nCréation de Ticket chez OCEANET	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-29 08:07:09.889494	2012-05-29 08:07:09.889494	111	139	1	\N	\N	\N	\N	\N	\N
356	2012-05-24 16:23:00	2012-05-24 16:23:00	Bonjour\r\n\r\nIl me faudrait :\r\n\r\n- un abonnement Blackberry avec l'appareil téléphonique\r\n- un devis pour un changement de Blackberry cassé\r\n- un clé 3G (nouvelle) avec abonnement correxpondant\r\n- le transfert de la ligne SFR n°06.16.03.45.06 ( contrat 01-OLC589) vers la flotte Futur Télécom\r\n\r\nMerci de me tenir informé par mail ( lblin@anti-germ.fr et laurentblin@sfr.fr) ou par téléphone 06.80.11.29.43. (Tel privé). Je suis en congé demain mais tenez moi informé.\r\n\r\nCordialement	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-29 09:46:14.708745	2012-05-29 09:46:14.708745	88	128	3	\N	\N	\N	\N	\N	\N
357	2012-05-29 09:46:00	2012-05-29 09:46:00	Bonjour,\r\n\r\n\r\nJ'ai bien pris note de votre demande.\r\n\r\nPouvez-vous me préciser les points suivants :\r\n- "abonnement Blackberry avec l'appareil téléphonique" : abonnement voix au compteur ou bien illimité ? abonnement data 100Mo ou bien illimité ? Modèle préféré de Blackberry ?\r\n- "changement de Blackberry cassé" : quel modèle souhaitez-vous ? Est-ce sur une ligne qui est éligible au renouvellement ?\r\n- "nouvelle clé 3G avec abonnement" ---> OK\r\n- "transfert de la ligne SFR 06 16 03 45 06" : pouvez-vous m'indiquer le type d'abonnement souhaité (voix et/ou data ? au compteur ou illimité ?)\r\n\r\n\r\nLa liste des mobiles :\r\nhttp://www.futurtelecom.com/index.php/telephone-mobile/catalogue-mobile.html\r\n\r\n\r\nJe reste à votre disposition pour tout complément d'informations.\r\n\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-29 09:46:59.009308	2012-05-29 09:46:59.009308	88	128	4	\N	\N	\N	\N	\N	\N
358	2012-05-29 09:58:00	2012-05-29 09:58:00	Tests de connexion TSE en Local : OK	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-29 10:00:34.184172	2012-05-29 10:00:34.184172	225	228	2	\N	\N	\N	\N	\N	\N
359	2012-05-29 10:03:00	2012-05-29 10:03:00	Pbm de reception de mail !\r\nDomaine en "non Active" sur PHAMM.\r\nRemise du domaine en "Active" puis tests : OK.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-29 10:09:19.949232	2012-05-29 10:09:19.949232	226	138	1	\N	\N	\N	\N	\N	\N
360	2012-05-29 13:16:00	2012-05-29 13:16:00	Bonjour,\r\n\r\nNous avons bien noté votre souhait de conserver le nom de domaine mosaine-concept.com . Souhaitez-vous que nous redirigions le site www.mosaine-concept.com vers www.mosaine.com ?\r\n\r\nPour information, actuellement, le site www.mosaine-concept.com est un site indépendant.\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-29 13:16:25.847256	2012-05-29 13:16:25.847256	135	152	4	\N	\N	\N	\N	\N	\N
361	2012-05-28 13:47:00	2012-05-28 13:47:00	Bonjour,\r\n\r\n \r\n\r\nJ’ai un message d’erreur sur mon portable de microsoft office pro plus 2010 m’indiquant que je n’ai + qu’un seul jour pour utiliser les programmes étant non référencé ??\r\n\r\n \r\n\r\nCode erreur OXC 004 FO 74\r\n\r\n \r\n\r\nQue dois je faire ?\r\n\r\n \r\n\r\nPouvez vous intervenir ?	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-29 13:31:39.685313	2012-05-29 13:31:39.685313	114	139	3	\N	\N	\N	\N	\N	\N
362	2012-05-29 13:31:00	2012-05-29 13:31:00	Concernant le pb du message d'erreur Office : je pense que cela est dû à la fin de la période de gratuité des modules de Office Pro (sachant que M. Priollaud n'a qu'une version Small Business). Si Office devient inutilisable, il nous rappelle.\r\nSignale aussi que le problème de démarrage sur la bonne partition est revenu récemment. Cela l'oblige à cliquer sur 3 messages avant d'arriver sur son système.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-29 13:34:11.492943	2012-05-29 13:34:11.492943	114	139	2	\N	\N	\N	\N	\N	\N
363	2012-05-29 13:51:00	2012-05-29 13:51:00	Prise en main à distance sur PC Anne : test envoi et réception mail avec pièce jointe -> désactivation "Outils" "Options"( "Sécurité" http://www.linternaute.com/images/hightech/maquestion/shoot_oe6.jpg	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-29 13:54:02.902615	2012-05-29 13:54:02.902615	111	139	2	\N	\N	\N	\N	\N	\N
364	2012-05-29 14:15:00	2012-05-29 14:15:00	setup --> 456 --> Serveur Menu --> FTP --> voipt2.polycom.com --> user : PlcmSpip --> Pwd : PlcmSpip --> back --> sauvegarde 	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-29 14:29:14.87966	2012-05-29 14:29:14.87966	172	191	2	\N	\N	\N	\N	\N	\N
365	2012-05-29 13:51:00	2012-05-29 14:34:00	Le routeur a été acheté au nom de WECONNECT (Alençon). \r\nDemande de devis pour 25 licences MICROSOFT Windows 7 64 Pro + 2 x 2008 standard R2 + 30 cals student W2008 +5 cals Academic W2008 + 38 licences anti-virus Kaspersky + 4 Licences 2011 Office Mac + 4 licences Office Std 2010 Win.\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-29 14:34:33.475619	2012-05-29 14:34:33.475619	195	210	1	\N	\N	\N	\N	\N	\N
366	2012-05-29 14:34:00	2012-05-29 15:16:00	Souhaite mettre caméra P1343 en extérieur pour les louveteaux qui sont nés. Voir prix du boitier. Est intéressé par le logiciel CRM.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-29 15:16:48.677895	2012-05-29 15:16:48.677895	9	8	2	\N	\N	\N	\N	\N	\N
367	2012-05-29 15:20:00	2012-05-29 15:40:00	Export des écritures de l'exercice 2011/2012.\r\nFichier/Exporter/Format paramétrable - Modèle "écritures-paramétrables" dans le dossier "exports"- Sélection de dates : 010311 --> 290212.\r\nEnvoi à n.lemaitre@strego.fr .	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-29 15:38:57.577789	2012-05-29 15:38:57.577789	133	150	13	\N	\N	\N	\N	\N	\N
368	2012-05-29 16:37:00	2012-05-29 16:37:00	Je viens de demander à AXIONE de reprendre contact avec toi rapidement pour planifier d'un nouveau RDV.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-29 16:37:38.027444	2012-05-29 16:37:38.027444	37	28	4	\N	\N	\N	\N	\N	\N
369	2012-05-30 06:29:00	2012-05-30 06:29:00	Monsieur,\r\n\r\nVeuillez trouver ci-joint le document de renouvellement de maintenance NETASQ. Il vous reste à vous connecter à votre espace client NETASQ, sur lequel la nouvelle licence est disponible. Vous pourrez ainsi la charger dans votre boitier.\r\n\r\nLe devis pour les licences vous sera envoyé ce jour.\r\n\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-30 06:31:59.354037	2012-05-30 06:31:59.354037	195	210	4	\N	Pack_Netasq_U30XXA0A0923670_EcoleBeauxArts_290512.pdf	application/pdf	7783	2012-05-30 06:31:59.352339	\N
370	2012-05-30 07:20:00	2012-05-30 07:20:00	Migration MX (destinationcircuit.com et destinationlemans.com) !\r\nPlus de connexion INTERNET (Les deux Livebox)\r\nPremiers Tests d'e-mail OK (émission et réception)	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-30 07:27:18.338463	2012-05-30 07:27:18.338463	39	36	2	\N	\N	\N	\N	\N	\N
371	2012-05-30 07:27:00	2012-05-30 07:27:00	Plus d'impression sur les postes !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-30 08:30:54.929152	2012-05-30 08:30:54.929152	39	36	1	\N	\N	\N	\N	\N	\N
372	2012-05-30 09:33:00	2012-05-30 09:33:00	Monsieur,\r\n\r\nVeuillez trouver ci-joint le devis pour les licences souhaitées.\r\n\r\nQuelques remarques :\r\n- Pour les licences Windows 7 Pro, j'ai supposé que vous alliez mettre à jour des ordinateurs existants : j'ai donc prévu une mise à jour.\r\n- Les CALS "student" sont réservés à un accès à l'extérieur de l'école. si les étudiants accèdent au serveur à l'intérieur de l'école, il faut alors prévoir plutôt des CALs "Academic" simples à 8,40 EUR HT.\r\n- Les licences Kaspersky incluent 1 an d'abonnement et ne prévoient pas de protection pour des OS serveurs.\r\n- Le tarif indiqué est dans la tranche "B". Si vous prenez moins de licences que prévu, il est possible que vous retombiez en tranche "A" (un tout petit peu plus chère).\r\n\r\n\r\nCordialement.\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-30 09:33:35.485628	2012-05-30 09:33:35.485628	195	210	4	\N	esbaa.pdf	application/pdf	36555	2012-05-30 09:33:35.484539	\N
374	2012-05-30 12:10:00	2012-05-30 12:20:00	Souci sur un tableau Excel: ne visualise pas les onglets du bas => Menu Pomme, dock pour déplacer la barre Apple ailleurs ou la masquer, ou bien cliquer sur le cercle vert qui adapte le document à l'écran. \r\n	i.moison@sigire.fr	i.moison@sigire.fr	2012-05-30 12:26:10.840434	2012-05-30 12:26:10.840434	198	212	1	\N	\N	\N	\N	\N	\N
375	2012-05-30 12:20:00	2012-05-30 12:20:00	Contact à propos du pc : pas de cd de recovery mais cd windows xp -> demande devis pour réinstall pc windows xp + drivers (4h de boulot) -> vu avec Gilles	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-30 12:35:54.975041	2012-05-30 12:35:54.975041	127	148	1	\N	\N	\N	\N	\N	\N
376	2012-05-30 12:44:00	2012-05-30 13:44:00	Création d'un espace FTP	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-30 12:58:51.177068	2012-05-30 12:58:51.177068	16	15	13	\N	\N	\N	\N	\N	\N
377	2012-05-30 13:30:00	2012-05-30 13:30:00	Le "reset" des livebox rendait les imprimantes injoignables !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-30 13:30:46.208979	2012-05-30 13:30:46.208979	125	36	1	\N	\N	\N	\N	\N	\N
378	2012-05-30 13:30:00	2012-05-30 13:30:00	Pbm de "Scan-to-File" vers le serveur FTP LMHR !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-30 13:31:17.026419	2012-05-30 13:31:17.026419	125	36	1	\N	\N	\N	\N	\N	\N
379	2012-05-30 14:36:00	2012-05-30 14:36:00	Panne de 15 minutes de la liaison SDSL VOIX !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-30 14:49:57.870661	2012-05-30 14:49:57.870661	9	8	2	\N	\N	\N	\N	\N	\N
380	2012-05-30 10:12:00	2012-05-30 10:12:00	Bonjour,\r\n\r\nMerci pour ce devis\r\n\r\nPouvez vous m'en envoyer un autre s'il vous plait pour la config suivante ?\r\n\r\nTour PC / Serveur  :\r\n6 à 8 Go RAM\r\nSystèmes disque 1To avec sauvegarde (Raid ou armoire baie)\r\nDeux cartes réseau 1Go\r\n\r\nCordialement\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-31 06:28:43.869619	2012-05-31 06:28:43.869619	195	210	3	\N	\N	\N	\N	\N	\N
381	2012-05-31 06:28:00	2012-05-31 06:28:00	onjour,\r\n\r\n\r\nJ'ai bien noté votre demande. Pouvez-vous me préciser les points suivants :\r\n- "Système disque 1To avec sauvegarde" : entendez-vous par là un système de disques redondants (RAID 1 ou RAID 5) et/ou un péripéhrique de sauvegarde utilisant des média amovibles (type RDX ou LTO) ?\r\n- Quel système d'exploitation sur le serveur ? Faut-il le prévoir dans le devis ?\r\n- Quel usage pour ce serveur ? (important pour le choix des disques et du processeur)\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-31 06:29:00.899445	2012-05-31 06:29:00.899445	195	210	4	\N	\N	\N	\N	\N	\N
382	2012-05-31 07:50:00	2012-05-31 07:50:00	Google affiche des pages comme :\r\nwww.geslin-mecanique-precision.com/htfr/0001.htm\r\nqui n'aboutissent plus depuis la redirection.\r\nPrévoir de rediriger toutes les requêtes commençant par www.geslin-mecanique-precision.com/* vers www.geslin-sas.fr et la rappeler quand c'est OK.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-31 07:53:48.885147	2012-05-31 07:53:48.885147	166	182	1	\N	\N	\N	\N	\N	\N
383	2012-05-31 08:09:00	2012-05-31 08:09:00	N'arrive pas à imprimer sur son imprimante à partir du logiciel CEREM : l'imprimante a été installée en USB au lieu d'être installée en réseau. Prévoir de repasser pour l'installer en réseau, et donner le nom de partage sur le serveur à Mélina pour qu'elle paramètre une nouvelle imprimante dans CEREM. Prévoir switch 5 ports + câbles.\r\nVoir aussi son pb de plantage dans Word à la fermeture.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-31 08:11:00.272565	2012-05-31 08:11:00.272565	229	5	1	\N	\N	\N	\N	\N	\N
384	2012-05-31 09:03:00	2012-05-31 09:03:00	Bonjour,\r\n\r\nPour faire suite à votre demande, il est possible d'adapter un caisson sur la P1343, avec une fixation tubulaire (mât non fourni).\r\n\r\nTarif (caisson + collier de fixation) = 392,85 EUR HT\r\nDélai : 15 jours, à confirmer\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-31 09:03:45.691581	2012-05-31 09:03:45.691581	9	8	4	\N	\N	\N	\N	\N	\N
385	2012-05-31 08:54:00	2012-05-31 08:54:00	Prise en main distante pc mélina : paramètrage logiciel pour impression TSE -> "Admin -> Imprimantes" modification et/ou création impr (copie des paramètres).\r\nTest ok !	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-31 09:31:39.548599	2012-05-31 09:31:39.548599	229	5	2	\N	\N	\N	\N	\N	\N
386	2012-05-31 09:31:00	2012-05-31 09:31:00	Test connexion téléphone pour configuration blackberry messagerie Google -> echec -> erreur identifiant... ? M. Vivier recontact SFR pour leur demander plus d'info -> Cf ticket N°296 (cela fonctionne mais pas sur le téléphone)	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-31 09:33:22.410315	2012-05-31 09:33:22.410315	5	5	2	\N	\N	\N	\N	\N	\N
387	2012-05-31 09:30:00	2012-05-31 09:34:00	Demande de devis pour 1 poste à remplacer (celui de l'accueil) + paramétrage sage / réseau / imprimantes. E-mails à faire migrer (supplex.fr).\r\nSAGE version ? : doit le préciser par e-mail. La partie EDI serait installée par AGP. \r\nDemande d'aide pour qu'il installe lui-même le logiciel : j'ai refusé puisque pas de contrat de maintenance.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-31 09:38:34.357916	2012-05-31 09:38:34.357916	230	142	1	\N	\N	\N	\N	\N	\N
388	2012-05-31 07:22:00	2012-05-31 07:22:00	Bonjour,\r\n\r\nIl s'agirait d'un serveur de bureautique pour 50 personnes maxi\r\n\r\n- AD et syteme d'exploitation w2008R2 (OS a mettre en option sur le devis)\r\n- Serveurs de fichiers et stockage profile\r\n- Spooler\r\n\r\nSauvegarde sur baie disque externe ou autre si moin cher ou plus adapté.\r\n\r\nCordialement	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-31 09:39:27.193355	2012-05-31 09:39:27.193355	195	210	3	\N	\N	\N	\N	\N	\N
389	2012-05-31 10:08:00	2012-05-31 10:08:00	La recontacter Pb Pdf -> Isabelle + Nicolas	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-31 10:09:19.525697	2012-05-31 10:09:19.525697	21	17	1	\N	\N	\N	\N	\N	\N
390	2012-05-31 10:13:00	2012-05-31 10:13:00	Problème internet -> plus de connexion, les recontacter -> Gabriel	n.retout@sigire.fr	n.retout@sigire.fr	2012-05-31 10:13:57.843688	2012-05-31 10:13:57.843688	27	19	1	\N	\N	\N	\N	\N	\N
391	2012-05-31 14:20:00	2012-05-31 14:20:00	Appel cet après-midi. Ne reçoivent plus de mails mais accèdent correctement à internet.\r\nJ'ai transmis le numero de GSM de Manuel	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-05-31 14:21:54.877712	2012-05-31 14:21:54.877712	28	15	1	\N	\N	\N	\N	\N	\N
419	2012-06-05 08:30:00	2012-06-05 08:30:00	A rapprocher de Cretot / Iveco	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 08:30:59.397179	2012-06-05 08:30:59.397179	238	234	1	\N	\N	\N	\N	\N	\N
397	2012-05-31 15:03:00	2012-05-31 15:17:00	A récupéré son téléphone cassé. Je ne peux pas lui proposer un renouvellement, c'est du SFR SETIPP avec un contrat cadre et des tarifs très bas. Pour le cordon de son téléphone, il va l'acheter lui-même. \r\nVeut un RDV pour son site internet.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-31 15:18:15.114501	2012-05-31 15:18:15.114501	62	45	10	\N	\N	\N	\N	\N	\N
398	2012-05-31 15:22:00	2012-05-31 15:22:00	Plus de lien SDSL.\r\nVoir pour sauvegarde.\r\n\r\nA tenir au courant.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-31 15:26:43.719861	2012-05-31 15:26:43.719861	93	104	1	\N	\N	\N	\N	\N	\N
399	2012-05-31 15:26:00	2012-05-31 15:26:00	SDSL rétablie. J'ai fait une demande à OCEANET pour connaitre la cause.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-31 15:46:19.603755	2012-05-31 15:46:19.603755	93	104	2	\N	\N	\N	\N	\N	\N
400	2012-05-31 10:23:00	2012-05-31 10:23:00	Bonjour,\r\n\r\nSuite à notre conversation téléphonique, je vous informe que le poste accueil de l'entreprise SUPPLEX est équipé de la version 16.05 du logiciel Sage.\r\n\r\nA partir de cette information, pourriez-vous m'établir le devis dont nous avons discuté. A savoir un poste informatique avec installation du réseau et de sage.\r\n\r\nCordialement	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-31 15:48:36.163397	2012-05-31 15:48:36.163397	230	142	3	\N	\N	\N	\N	\N	\N
401	2012-05-31 11:45:00	2012-05-31 11:45:00	Pourriez-vous également m'établir un devis pour un contrat de maintenance ?\r\n\r\nCordialement	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-31 15:49:02.335711	2012-05-31 15:49:02.335711	230	142	3	\N	\N	\N	\N	\N	\N
402	2012-05-31 16:03:00	2012-05-31 16:03:00	Bonsoir,\r\n\r\nVeuillez trouver ci-joint le devis correspondant.\r\n\r\nCe sont des tarifs promotionnels liés au catalogue IBM du mois de mai. Je ne sais pas si ceux-ci seront reconduits en juin.\r\n\r\nJe suis en déplacement demain, mais aurait sans doute accès à mes e-mails. \r\n\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-31 16:03:37.869393	2012-05-31 16:03:37.869393	195	210	4	\N	esbaa.pdf	application/pdf	38389	2012-05-31 16:03:37.868283	\N
403	2012-05-31 16:20:00	2012-05-31 16:20:00	Bonsoir,\r\n\r\nVeuillez trouver ci-joint le devis souhaité.\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-31 16:21:14.163871	2012-05-31 16:21:14.163871	230	142	4	\N	supplex.pdf	application/pdf	37650	2012-05-31 16:21:14.162166	\N
404	2012-05-31 17:13:00	2012-05-31 17:13:00	Propagation DNS en cours donc normal !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-05-31 17:25:03.635609	2012-05-31 17:25:03.635609	166	182	1	\N	\N	\N	\N	\N	\N
405	2012-05-31 17:39:00	2012-05-31 17:39:00	Bonsoir,\r\n\r\nLe contrat de télé-assistance est tarifé de la façon suivante :\r\n- 100 EUR HT par an et par poste de travail\r\n- 300 EUR HT par an et par serveur\r\n- 100 EUR HT par an et par périphérique actif (routeur par exemple)\r\n\r\n\r\nCombien de postes de travail avez-vous ?\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-05-31 17:40:04.143899	2012-05-31 17:40:04.143899	230	142	4	\N	\N	\N	\N	\N	\N
406	2012-06-01 14:00:00	2012-06-01 14:00:00	Reçu appel de Mme Ossin très énervée. Elle ne reçoit pas ses mails, et les clients appellent pour savoir pourquoi elle ne répond pas !\r\nPour elle c'est intolérable au moment des 24 heures du Mans\r\nElle a exigé le GSM de Gabriel que je lui ai fourni.\r\nManuel au courant du shisme !	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-01 14:05:19.866693	2012-06-01 14:05:19.866693	39	36	1	\N	\N	\N	\N	\N	\N
407	2012-06-01 14:26:00	2012-06-01 14:26:00	Je viens de faire les tests avec le compte d'Isabelle --> aucun souci de réception avec un client qui "posait" problème (cboschet@mecenat-cardiaque.org).\r\nJe continue les tests sachant que je n'ai toujours pas réussi à mettre notre système de messagerie Google Apps en défaut (redirections, transfert, alias...) !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-01 14:30:07.842665	2012-06-01 14:30:07.842665	39	36	1	\N	\N	\N	\N	\N	\N
408	2012-06-04 08:29:00	2012-06-04 08:29:00	Ligne téléphonique fonctionnelle chez 7Bulles > Attente proposition internet.	n.retout@sigire.fr	n.retout@sigire.fr	2012-06-04 08:29:53.589458	2012-06-04 08:29:53.589458	233	230	1	\N	\N	\N	\N	\N	\N
409	2012-06-04 12:37:00	2012-06-04 12:37:00	Pas de besoins de débit pour le moment	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-04 12:37:28.874223	2012-06-04 12:37:28.874223	235	231	1	\N	\N	\N	\N	\N	\N
410	2012-05-31 12:00:00	2012-05-31 14:00:00	RDV pour analyse des besoins et démo CRM.\r\nBesoins :\r\n- site web (déjà en cours de réalisation avec autre prestataire)\r\n- e-mailing (outil à déterminer : lui envoyer doc sur sarbacane)\r\n- facturation et compta (gestion/compta SAGE 30)\r\n- CRM (outil "maison")\r\n\r\nRemarques par rapport au CRM "maison"\r\n- Gestion des produits par comptes (à ajouter)\r\n- Gestion des Centres d'intérêt par contact (à ajouter)\r\n- Recherche et extraction CSV multi-critères (à préciser)\r\n- "Activité récente" (à ajouter)\r\n- Gestion des devis (à ajouter) : libellé, qté, PUHT, Total HT\r\n\r\nEnvoyer précisions + budget pour semaine prochaine.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-04 12:38:28.593903	2012-06-04 12:38:28.593903	190	207	9	\N	\N	\N	\N	\N	\N
411	2012-06-04 12:55:00	2012-06-04 12:55:00	Appel support GANDI pour transfert NDD "prosport.fr" (initié le 24.04.2012).	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-04 13:28:44.342184	2012-06-04 13:28:44.342184	90	129	1	\N	\N	\N	\N	\N	\N
412	2012-06-04 13:48:00	2012-06-04 13:48:00	Appel pour signaler que seule une partie des cartouches commandées (CF003127) est arrivée. Souhaite être livrée dès que possible des cartouches déjà arrivées.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-04 13:49:50.988201	2012-06-04 13:49:50.988201	240	235	2	\N	\N	\N	\N	\N	\N
413	2012-06-04 13:28:00	2012-06-04 13:28:00	Appel support Amen pour ajouter l'e-mail prosport-medical@wanadoo.fr au sein du contact propriétaire !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-04 14:00:25.871751	2012-06-04 14:00:25.871751	90	129	2	\N	\N	\N	\N	\N	\N
414	2012-06-04 14:03:00	2012-06-04 14:03:00	Bonjour,\r\n\r\nJe reviens vers vous concernant la portabilité des numéros, que nous sommes désormais en mesure de lancer puisque les équipements ont été installés.\r\n\r\nDans la dernière version de la proposition, il était indiqué la portabilité de 8 numéros :\r\n0243874248, 0243570043, 0243875549, 0243872488, 0243874970, 0243874914\r\nainsi que deux autres numéros non communiqués.\r\n\r\nEtes-vous en mesure de nous communiquer ces "deux autres numéros" ?\r\n\r\nDans le même temps, merci de nous confirmer que les numéros ci-dessus sont bien à porter sur la nouvelle solution de téléphonie...\r\n\r\n\r\nCordialement. 	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-04 14:03:36.076035	2012-06-04 14:03:36.076035	4	4	4	\N	\N	\N	\N	\N	\N
415	2012-06-04 15:01:00	2012-06-04 15:01:00	Pas de besoins en internet	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-04 15:04:10.418942	2012-06-04 15:04:10.418942	237	233	1	\N	\N	\N	\N	\N	\N
416	2012-06-05 07:22:00	2012-06-05 07:22:00	Bâtiment à ARGENTRE. Demande de devis pour déconnexion des postes et ré-installation sur le site.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-05 07:31:07.89989	2012-06-05 07:31:07.89989	246	239	2	\N	\N	\N	\N	\N	\N
417	2012-06-05 07:41:00	2012-06-05 07:41:00	Souhaite avoir Gilles (déjà au téléphone). Veut aussi des renseignements sur les brouilleurs de téléphone portable.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-05 07:42:17.824565	2012-06-05 07:42:17.824565	11	1	1	\N	\N	\N	\N	\N	\N
418	2012-06-05 07:48:00	2012-06-05 07:48:00	Bonjour,\r\n\r\nNous avons bien pris note de votre demande de devis pour la déconnexion sur le site actuel et la reconnexion sur le nouveau site de vos ordinateurs.\r\n\r\nSite actuel : Saint Berthevin\r\nNouveau site : Argentré\r\nMatériels concernés : 1 serveur et 5 à 10 postes de travail + switches + 2 imprimantes (hors matériel Lectra)\r\nPrestation : arrêt et déconnexion des postes + reconnexion et redémarrage sur nouveau site\r\nTransport : effectué par vos soins\r\nCâblage : effectué par vos soins (électricien)\r\n\r\nDurée estimée : 0,5 jour à 1 jour (soit 315 à 630 EUR HT)\r\nDéplacement : 150 EUR HT\r\n\r\n\r\nIl faudra peut-être prévoir des câbles réseau de remplacement car avec l'âge, certains câbles deviennent "cassants" et supportent mal les manipulations.\r\n\r\n(tarif d'un cordon réseau : entre 5 et 10 EUR HT)\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-05 08:15:22.866035	2012-06-05 08:15:22.866035	246	239	4	\N	\N	\N	\N	\N	\N
420	2012-05-31 11:55:00	2012-05-31 11:55:00	Bonjour\r\nPour Tous les appareils : Abonnements 54 euros "voix" et 29 euros "data".\r\nPour les blackberry le modèle "gamme moyenne"\r\nPour le blackberry cassé : 06.26.92.13.59 (passage sur futur telecom car elligible au renouvellement)\r\nPOur le 06.16.03.45.06 : Passage Voix 54 euros\r\nCordialement	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-05 10:25:34.896405	2012-06-05 10:25:34.896405	88	128	3	\N	\N	\N	\N	\N	\N
421	2012-06-05 12:59:00	2012-06-05 12:59:00	Pas dispo. Rappeler en fin de semaine.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-05 13:06:40.741963	2012-06-05 13:06:40.741963	202	213	2	\N	\N	\N	\N	\N	\N
422	2012-06-05 13:11:00	2012-06-05 13:11:00	Pbm d'accès à la messagerie Google Apps (demande sans cesse le mot de passe Google Apps) ! \r\nSuppression du compte mail.habrial.fr (NOZICAA).\r\nModification du mot de passe de la session Windows.\r\nOK	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-05 13:21:44.212416	2012-06-05 13:21:44.212416	22	17	1	\N	\N	\N	\N	\N	\N
423	2012-06-05 13:24:00	2012-06-05 13:24:00	Accès ADSL largement suffisant	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 13:24:15.485718	2012-06-05 13:24:15.485718	245	238	1	\N	\N	\N	\N	\N	\N
424	2012-06-05 13:57:00	2012-06-05 13:57:00	Installation Serveur SRV-DATA + lancement de la synchronisation NAS --> SRV-DATA	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-05 13:57:57.737408	2012-06-05 13:57:57.737408	\N	256	1	\N	\N	\N	\N	\N	\N
425	2012-06-05 14:38:00	2012-06-05 14:38:00	A rappeler	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 14:40:54.269553	2012-06-05 14:40:54.269553	248	241	1	\N	\N	\N	\N	\N	\N
426	2012-06-05 14:41:00	2012-06-05 14:41:00	Pas de besoins Telecom - Ne veut pas me recevoir pour le moment	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 14:45:30.401053	2012-06-05 14:45:30.401053	249	242	1	\N	\N	\N	\N	\N	\N
427	2012-06-05 14:50:00	2012-06-05 14:50:00	Groupe PRECOM (Ouest-France)\r\nNe prend pas d'appels	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 14:50:34.217229	2012-06-05 14:50:34.217229	250	243	1	\N	\N	\N	\N	\N	\N
428	2012-06-05 14:51:00	2012-06-05 14:51:00	Décision groupe	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 14:53:00.401176	2012-06-05 14:53:00.401176	251	244	1	\N	\N	\N	\N	\N	\N
429	2012-06-05 14:53:00	2012-06-05 14:53:00	Numero de fax	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 15:13:21.727657	2012-06-05 15:13:21.727657	252	245	1	\N	\N	\N	\N	\N	\N
430	2012-06-05 15:19:00	2012-06-05 15:19:00	Décision groupe à Joué les Tours	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 15:22:06.308919	2012-06-05 15:22:06.308919	254	247	1	\N	\N	\N	\N	\N	\N
431	2012-06-05 15:23:00	2012-06-05 15:23:00	Citroën - Est engagé sur de l'ADSL Orange pendant encore 24 mois - Contrat cadre\r\nPas de ddl en informatique	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-05 15:27:59.856647	2012-06-05 15:27:59.856647	257	249	1	\N	\N	\N	\N	\N	\N
432	2012-06-05 16:27:00	2012-06-05 16:42:00	Mr TILLAUD, problème de popup sur son poste (Firefox en version 3) !\r\nDésinstallation de beaucoup de plugins "publicitaire".\r\nInstallation de la dernière version (13.0). 	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-05 16:43:07.522966	2012-06-05 16:43:07.522966	203	215	1	\N	\N	\N	\N	\N	\N
433	2012-06-06 08:25:00	2012-06-06 08:25:00	Pb mail M. Lecomte : demande de mot de passe -> Prise en main à distance -> Suppression ancien compte mail.habrial.fr (Pb résolu) + Tests envoi et réponse mail OK	n.retout@sigire.fr	n.retout@sigire.fr	2012-06-06 08:26:41.960293	2012-06-06 08:26:41.960293	212	17	2	\N	\N	\N	\N	\N	\N
434	2012-06-06 08:27:00	2012-06-06 08:27:00	Pb écran IMAC de Annie : mac sous garantie 3 ans acheté l'année dernière (2011) (à voir avec Apple directement)	n.retout@sigire.fr	n.retout@sigire.fr	2012-06-06 08:28:22.909443	2012-06-06 08:28:22.909443	162	177	3	\N	\N	\N	\N	\N	\N
435	2012-06-06 09:48:00	2012-06-06 09:48:00	Pb mise en page word ou pdf ??? Cf fichiers liés -> personnellement je ne vois que le saut de ligne en haut du document pc...	n.retout@sigire.fr	n.retout@sigire.fr	2012-06-06 09:49:13.410861	2012-06-06 09:49:13.410861	\N	256	3	\N	WORD_PC.doc	application/vnd.ms-word	218624	2012-06-06 09:49:13.408485	\N
436	2012-06-06 09:49:00	2012-06-06 09:49:00	suite pdf	n.retout@sigire.fr	n.retout@sigire.fr	2012-06-06 09:49:36.102504	2012-06-06 09:49:36.102504	\N	256	1	\N	PDF_PC.pdf	application/pdf	115175	2012-06-06 09:49:36.101414	\N
437	2012-06-06 09:49:00	2012-06-06 09:49:00	suite pdf mac	n.retout@sigire.fr	n.retout@sigire.fr	2012-06-06 09:49:50.650035	2012-06-06 09:49:50.650035	\N	256	1	\N	PDF_MAC.pdf	application/pdf	241767	2012-06-06 09:49:50.648914	\N
438	2012-06-06 10:03:00	2012-06-06 10:09:00	Appel de Mme LEMOINE avec le technicien FT suite remplacement de leur Livebox.\r\nJ'ai guidé le "technicien" FT afin de vérifier la configuration réseau des postes.\r\nOK	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-06 10:04:37.353365	2012-06-06 10:04:37.353365	266	261	1	\N	\N	\N	\N	\N	\N
439	2012-06-06 14:44:00	2012-06-06 14:44:00	Dépend d'un groupe - Aucun DDL - Contrat cadre avec opérateur pour toutes les filiales	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-06 14:48:39.066374	2012-06-06 14:48:39.066374	248	241	1	\N	\N	\N	\N	\N	\N
440	2012-06-06 15:50:00	2012-06-06 15:50:00	Contrat de groupe. Décision prise en Ille et Vilaine	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-06 15:55:34.739096	2012-06-06 15:55:34.739096	234	227	1	\N	\N	\N	\N	\N	\N
441	2012-06-07 08:07:00	2012-06-07 08:07:00	Plus de lien d'accès sur Nantes : la SDSL semble HS.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-07 08:17:43.207447	2012-06-07 08:17:43.207447	116	141	1	\N	\N	\N	\N	\N	\N
442	2012-06-07 08:17:00	2012-06-07 08:17:00	Création d'un ticket chez AXIONE / OCEANET pour investiguer le problème + demande à M. Paris de rebooter modem + routeur.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-07 08:18:51.836228	2012-06-07 08:18:51.836228	116	141	13	\N	\N	\N	\N	\N	\N
443	2012-06-07 08:23:00	2012-06-07 08:23:00	Après reboot du routeur et du modem, l'accès est revenu. Côture du ticket chez AXIONE/OCEANET.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-07 08:24:27.931007	2012-06-07 08:24:27.931007	116	141	1	\N	\N	\N	\N	\N	\N
444	2012-06-07 08:33:00	2012-06-07 08:33:00	Mail envoyé à M. Grouard	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-07 08:35:07.948003	2012-06-07 08:35:07.948003	255	248	1	\N	\N	\N	\N	\N	\N
445	2012-06-07 09:52:00	2012-06-07 09:52:00	Décision groupe	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-07 09:52:33.966535	2012-06-07 09:52:33.966535	265	250	1	\N	\N	\N	\N	\N	\N
446	2012-06-07 14:31:00	2012-06-07 14:31:00	Pb pc personnel -> le dépose vendredi 8 juin pour réparation	n.retout@sigire.fr	n.retout@sigire.fr	2012-06-07 14:31:39.836547	2012-06-07 14:31:39.836547	267	262	1	\N	\N	\N	\N	\N	\N
447	2012-06-07 15:48:00	2012-06-07 15:48:00	Souci concernant le CMUP, concernant valeur CMUP dans fiche article et valeur CMUP dans les mouvements de stock. Envoie fichiers.	i.moison@sigire.fr	i.moison@sigire.fr	2012-06-07 15:52:19.527675	2012-06-07 15:52:19.527675	99	104	1	\N	\N	\N	\N	\N	\N
448	2012-06-01 15:52:00	2012-06-07 15:52:00	Souci sur un compte banque entre le solde au 31/12/11 et le solde au 01/01/12. Regénaration des AN ne change pas, pointage correct.\r\nImpossible de prendre la main avec TeamViewer car version Host => faire une réinstallation de TeamViewer Quick Support.	i.moison@sigire.fr	i.moison@sigire.fr	2012-06-07 15:55:55.29945	2012-06-07 15:55:55.29945	246	239	1	\N	\N	\N	\N	\N	\N
449	2012-06-08 08:37:00	2012-06-08 08:40:00	RDV pris pour installation et mise en service EBIS le 18/06/2012 à 14h30/15h00	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-08 08:45:26.35198	2012-06-08 08:45:26.35198	97	21	2	\N	\N	\N	\N	\N	\N
450	2012-06-08 09:32:00	2012-06-08 09:32:00	Donner la possibilté à Mme Rosay d'utiliser le programme des Immos.	i.moison@sigire.fr	i.moison@sigire.fr	2012-06-08 09:33:44.441016	2012-06-08 09:33:44.441016	268	263	1	\N	\N	\N	\N	\N	\N
451	2012-06-08 09:50:00	2012-06-08 09:50:00	Le rappeler en Septembre. Il aurait des nouvelles lignes + 11 lignes à migrer (à partir d'Orange). Date FPC : Juin  et Octobre. Il garderait quand même quelques lignes ORANGE.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-08 10:00:36.119597	2012-06-08 10:00:36.119597	202	213	2	\N	\N	\N	\N	\N	\N
452	2012-06-08 09:40:00	2012-06-08 09:45:00	Résumé du programme :\r\nAccueil 08h30\r\nPrésentation Virtualisation VMWARE et IBM\r\nPause : 10h15\r\nMise en oeuvre VMWARE et sauvegarde VEEAM Backup\r\nFin 11h30 avec cocktail de cloture\r\n\r\nDoit nous envoyer un fichier Word reprenant ces éléments pour concevoir un e-mail.\r\nPage "contact/inscription" à réaliser par nos soins.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-08 10:07:39.679726	2012-06-08 10:07:39.679726	269	264	1	\N	\N	\N	\N	\N	\N
565	2012-07-01 22:00:00	2012-07-01 22:00:00	\N	g.bonvoust@sigire.fr	g.bonvoust@sigire.fr	2012-07-02 09:39:25.458932	2012-07-02 09:39:25.458932	49	24	11	\N	\N	\N	\N	\N	2
573	2012-07-01 22:00:00	2012-07-01 22:00:00	\N	g.bonvoust@sigire.fr	\N	2012-07-02 14:10:05.859198	2012-07-02 14:10:05.859198	23	17	11	\N	\N	\N	\N	\N	4
454	2012-06-08 10:13:00	2012-06-08 10:13:00	Mail envoyé : "J’attends de votre part que vous me disiez si je peux récupérer votre pc semaine prochaine (ou si quelqu’un peut le déposer dans nos locaux) pour faire la réparation et les vérifications de votre machine." Comme convenu avec elle semaine dernière.	n.retout@sigire.fr	n.retout@sigire.fr	2012-06-08 10:15:20.073489	2012-06-08 10:15:20.073489	229	5	4	\N	\N	\N	\N	\N	\N
455	2012-06-08 15:26:00	2012-06-08 15:26:00	Souci avec inventaire Polymoule et CMUP =>Modif° avec requête SQL du CMUP et Prix Revient de l'article P1135107. Besoin de faire un recalcul des cumuls pour vérifier si Montant amélioré.\r\n	i.moison@sigire.fr	i.moison@sigire.fr	2012-06-08 15:27:28.515229	2012-06-08 15:27:28.515229	99	104	1	\N	\N	\N	\N	\N	\N
456	2012-06-10 21:26:00	2012-06-10 21:30:00	Réajustement des cumuls sur la société POLYMOULE pour l'article P1135107.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-10 21:27:30.974249	2012-06-10 21:27:30.974249	99	104	13	\N	\N	\N	\N	\N	\N
457	2012-06-11 06:47:00	2012-06-11 06:47:00	Son poste ne fonctionne toujours pas. Le rappeler.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-11 07:19:14.243708	2012-06-11 07:19:14.243708	270	5	1	\N	\N	\N	\N	\N	\N
458	2012-06-11 07:57:00	2012-06-11 07:57:00	Besoin pour M. ADEN d'un ultra-portable pour e-mail/bureautique. Tablette ne convient pas. Avec Office Small Business et 13". Urgent !	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-11 08:04:03.254185	2012-06-11 08:04:03.254185	93	104	1	\N	\N	\N	\N	\N	\N
459	2012-06-11 08:04:00	2012-06-11 08:04:00	Devis envoyé	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-11 08:13:16.763883	2012-06-11 08:13:16.763883	93	104	4	\N	cosnet.pdf	application/pdf	35913	2012-06-11 08:13:16.761783	\N
460	2012-06-11 09:03:00	2012-06-11 09:03:00	Pc à récupérer pour réparation système et logiciels. (Gabriel doit le récupérer ce lundi 11 juin)	n.retout@sigire.fr	n.retout@sigire.fr	2012-06-11 09:04:35.060466	2012-06-11 09:04:35.060466	229	5	3	\N	\N	\N	\N	\N	\N
461	2012-06-11 09:57:00	2012-06-11 09:57:00	Pbm avec l'envoi de mail (serveur SMTP Googlemail injoignable) \r\nLatence réseau exceptionnel : jusqu'à 2sec !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-11 10:09:43.355527	2012-06-11 10:09:43.355527	22	17	1	\N	\N	\N	\N	\N	\N
462	2012-06-11 12:18:00	2012-06-11 12:18:00	Support pour mise en place de l'authentification via SPNEGO sur un serveur TSE (avec Proxy Explicite) !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-11 12:19:20.778317	2012-06-11 12:19:20.778317	118	143	1	\N	\N	\N	\N	\N	\N
463	2012-06-11 12:25:00	2012-06-11 12:25:00	Prise en main à distance pour configuration messagerie nfouassier@albea.fr sur nouveau pc (pwd : nfouassier01)	n.retout@sigire.fr	n.retout@sigire.fr	2012-06-11 12:26:28.56849	2012-06-11 12:26:28.56849	97	21	1	\N	\N	\N	\N	\N	\N
465	2012-06-11 14:08:00	2012-06-11 14:08:00	Souci entre solde banque et An => saisie des OD en extoune au 01/01 (car déjà pris en cpte ds les AN) + Interro. Affaire par client	i.moison@sigire.fr	i.moison@sigire.fr	2012-06-11 14:09:53.359692	2012-06-11 14:09:53.359692	246	239	1	\N	\N	\N	\N	\N	\N
466	2012-06-06 12:00:00	2012-06-11 13:30:00	RDV pour site internet. Besoin site statique 4 pages (Accueil / Présentation / Réalisations / Contact). A destination des particuliers. \r\nActivités : Charpente traditionnelle (neuf et rénovation), Ossature bois, Couverture, Isolation par extérieur, Bardage, Zinguerie, Etanchéité, Toît plat.\r\nConcurrent : Tréhard\r\nRéalisations : 15 photos environ avec "avant" et "après".\r\nModifications facturées à l'acte.\r\nDevis à envoyer !\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-11 15:57:04.625459	2012-06-11 15:57:04.625459	62	45	9	\N	\N	\N	\N	\N	\N
469	2012-06-08 16:26:00	2012-06-08 16:26:00	Bonjour,\r\n\r\nTjs les mêmes problèmes qui s’affichent au démarrage du sony depuis le \r\npassage en 32 bits.\r\n\r\nEn ce qui concerne office, message systématique informant que mon \r\nordinateur ne possède pas la licence d’exploitationn2010 ??\r\n\r\nPour la synchro tablette /ordi c’est le pire : a chaque synchro on \r\ndouble toutes les infos :  je suis passé de 1 000 contact à 3000 avec 3 \r\nsynchro réalisées.\r\n\r\nJe suis dispo lundi prochain. Après sur les « routes » toute la semaine.\r\n\r\nComment résoudre ces problèmes ?\r\n\r\nCordialement,\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 07:48:14.4524	2012-06-12 07:48:14.4524	114	139	3	\N	\N	\N	\N	\N	\N
470	2012-06-12 07:34:00	2012-06-12 07:34:00	Mise en place de l'authentification via SPNEGO sur un serveur TSE (avec Proxy Explicite) avec CRIS-RESEAU.\r\nValidation de la conf avec Serge GROSSO --> Conf OK mais toujours le même souci ! (dès qu'un user est authentifié, tous les autres le sont)\r\nCréation d'un Ticket chez NETASQ !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-12 08:04:45.135838	2012-06-12 08:04:45.135838	118	143	1	\N	\N	\N	\N	\N	\N
471	2012-06-12 08:21:00	2012-06-12 08:21:00	Mail envoyé ce jour	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-12 08:32:07.472703	2012-06-12 08:32:07.472703	215	223	1	\N	\N	\N	\N	\N	\N
472	2012-06-12 08:36:00	2012-06-12 08:36:00	Décision groupe - Ne peut pas changer d'opérateur	g.guivarch@sigire.fr	g.guivarch@sigire.fr	2012-06-12 08:37:03.837022	2012-06-12 08:37:03.837022	236	232	1	\N	\N	\N	\N	\N	\N
473	2012-06-12 09:55:00	2012-06-12 09:55:00	Demande de validation (technique + licence) de l'infra VEEAM SARTEL - Moulins Réunis.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-12 10:10:05.950339	2012-06-12 10:10:05.950339	80	125	1	\N	infra_a_valider.pdf	application/pdf	304494	2012-06-12 10:10:05.948584	\N
474	2012-06-07 18:21:00	2012-06-07 18:21:00	Bonsoir\r\n\r\nJ'attends encore la validation définitive de mes budgets Q3 2012 mais je peux déjà vous annoncer que nous avons provisionné 700€ afin de vous accompagner financièrement sur cet évènement\r\n\r\nBonne soirée\r\n \r\nCordialement,	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 10:16:18.924271	2012-06-12 10:16:18.924271	282	229	3	\N	\N	\N	\N	\N	\N
475	2012-06-12 12:16:00	2012-06-12 12:16:00	Objet = installation de Sage  poste client\r\n\r\nà l'attention de Monsieur Forestier ( Sigiré )\r\n\r\nBonjour\r\nSuite aux installations de poste clients , nous avons noté un point négatif\r\n\r\nEn effet , pour que le logiciel SAGE sur les postes client fonctionne , il\r\nfaut actuellement que les utilisateurs finaux soient administrateur du\r\nposte\r\nDes tests ont été mené avec les deux profils avec Mme Moisan\r\n\r\nHors la démarche société ( deutsch ) , oblige à ce que les utilisateurs\r\nrestent "simple" utilisateurs du poste\r\n\r\nMerci de trouver une solution pour ce besoin\r\n\r\nCordialement\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 12:22:14.193021	2012-06-12 12:22:14.193021	41	48	3	\N	\N	\N	\N	\N	\N
476	2012-06-12 12:41:00	2012-06-12 12:41:00	Pb de ralentissement du réseau. Ne voit pas d'où cela vient... A rappeler.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 12:41:47.262595	2012-06-12 12:41:47.262595	11	1	1	\N	\N	\N	\N	\N	\N
477	2012-05-04 12:57:00	2012-05-04 12:58:00	Rappel \r\n\r\nNe prend pas au téléphone, uniquement par mail. 	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 13:14:26.191931	2012-06-12 13:14:26.191931	283	270	3	\N	\N	\N	\N	\N	\N
478	2012-06-12 13:41:00	2012-06-12 13:41:00	Réparation normal.dot sur pc Mélina : http://support.microsoft.com/kb/821715/fr 	n.retout@sigire.fr	n.retout@sigire.fr	2012-06-12 13:41:46.062452	2012-06-12 13:41:46.062452	229	5	12	\N	\N	\N	\N	\N	\N
479	2012-06-12 13:37:00	2012-06-12 14:08:00	Pb sur Excel. Formule de calcul qui ne se calcule plus!\r\nJ'ai vérifié les options de Excel en prenant la main via Teamviewer : options OK. Format des cellules OK. Pas de références ciruclaires. Si on fait un copier/coller dans un autre classeur : même pb!\r\nA suivre ....	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 14:08:58.510526	2012-06-12 14:08:58.510526	23	17	1	\N	\N	\N	\N	\N	\N
574	2012-07-01 22:00:00	2012-07-01 22:00:00	\N	m.ozan@sigire.fr	\N	2012-07-02 16:23:19.160088	2012-07-02 16:23:19.160088	20	17	11	\N	\N	\N	\N	\N	5
576	2012-07-01 22:00:00	2012-07-01 22:00:00	\N	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-07-02 20:18:02.321938	2012-07-02 20:18:02.321938	273	266	11	\N	\N	\N	\N	\N	3
577	2012-07-02 20:35:00	2012-07-02 20:35:00	Test	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-07-02 20:36:37.266455	2012-07-02 20:36:37.266455	49	24	1	\N	\N	\N	\N	\N	\N
582	2012-07-09 22:00:00	2012-07-09 22:00:00	\N	\N	m.ozan@sigire.fr	2012-07-10 08:42:36.396716	2012-07-10 08:42:36.396716	\N	265	11	\N	\N	\N	\N	\N	6
621	2012-07-10 20:12:00	2012-07-10 20:12:00	Événement de test !\r\n	m.ozan@sigire.fr	\N	2012-07-10 20:13:25.249662	2012-07-10 20:13:25.249662	216	48	1	\N	\N	\N	\N	\N	\N
480	2012-06-12 14:13:00	2012-06-12 14:13:00	Monsieur,\r\n\r\nNous avons bien reçu votre bon de commande et vous en remercions. Les informations ont été saisies.\r\n\r\nLa date de portabilité des lignes existantes a été fixée au 22/06/2012.\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 14:13:54.597651	2012-06-12 14:13:54.597651	88	128	4	\N	\N	\N	\N	\N	\N
481	2012-06-12 14:13:00	2012-06-12 14:13:00	onjour,\r\n\r\nFaisant suite à notre dernier rendez-vous, veuillez trouver ci-joint notre devis pour la réalisation de votre site internet.\r\n\r\nJe joins aussi deux copies d'écran conçues par notre graphiste pour vous donner un aperçu de ce que pourrait donner la visualisation de votre site.\r\n\r\nCordialement. 	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 14:14:36.081386	2012-06-12 14:14:36.081386	62	45	4	\N	SITE_WEB-BEAUPOUX.pdf	application/pdf	170073	2012-06-12 14:14:36.08001	\N
482	2012-06-12 15:05:00	2012-06-12 15:05:00	Appel suite à coupure brutale de son micro. Quand elle ouvre SAGE, cela lui répond que des utilisateurs sont déjà connectés.\r\nJe lui ai expliqué qu'elle devait lancer la maintenance après avoir fait une sauvegarde de ses fichiers.\r\nElle nous rappelle si pb.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 15:07:22.33125	2012-06-12 15:07:22.33125	246	239	1	\N	\N	\N	\N	\N	\N
484	2012-06-12 15:10:00	2012-06-12 15:10:00	Didier,\r\n\r\nJ'ai retrouvé les infos dont je vous ai parlé : avez-vous redémarré votre poste (Menu démarrer / Redémarrer) ?\r\n\r\n\r\nCela peut corriger votre problème.\r\n\r\n\r\nCordialement. 	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 15:10:38.822356	2012-06-12 15:10:38.822356	23	17	4	\N	\N	\N	\N	\N	\N
485	2012-06-12 15:28:00	2012-06-12 15:28:00	Konica Minolta souhaite installer une imprimante virtuelle sur le serveur pour les pc win 7 64 bits (les nouveaux), hors le serveur demande le cd du serveur (32 bits) pour installer des drivers 64 bits. Le Technicien de Konica (Aymeric Virvoulet 06 19 98 62 96) préconise la mise à jour SP3 sur le serveur Habrial... A suivre...	n.retout@sigire.fr	n.retout@sigire.fr	2012-06-12 15:31:48.758328	2012-06-12 15:31:48.758328	21	17	1	\N	\N	\N	\N	\N	\N
486	2012-06-12 15:35:00	2012-06-12 15:35:00	Souhaite savoir si la version de SAGE installée chez SUPPLEX est compatible Windows 7. Semble fournir du matériel à Supplex !\r\nContact agréable malgré tout. Peut-être partenariat à envisager....	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 15:44:00.40786	2012-06-12 15:44:00.40786	298	276	1	\N	\N	\N	\N	\N	\N
487	2012-05-31 12:00:00	2012-05-31 12:05:00	Vient de s'équiper avec une société voisine	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-12 15:56:52.558035	2012-06-12 15:56:52.558035	302	278	1	\N	\N	\N	\N	\N	\N
490	2012-06-13 09:13:00	2012-06-13 09:13:00	Souhaite être aidé pour migrer son NETASQ en v9. A aussi un souci car le NETASQ bloque les accès à YouTube.\r\nJe lui signale que normalement, ce type de prestation doit faire l'objet d'un contrat de maintenance, mais que, exceptionnellement, nous allons lui répondre pour cette fois.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-13 09:17:37.951455	2012-06-13 09:17:37.951455	195	210	1	\N	\N	\N	\N	\N	\N
491	2012-06-13 14:55:00	2012-06-13 14:55:00	Pb impression sous logiciel dos : besoin de repartager l'imprimante lexmark E120 (installée en local usb sur portable Mélina) sur le serveur (dans logiciel "admin" "imprimantes" -> \\\\serveur\\LexmarkE120) + Test OK (si pb persiste -> swtich 5 ports pr install imprimante en réseau)	n.retout@sigire.fr	n.retout@sigire.fr	2012-06-13 14:57:18.42473	2012-06-13 14:57:18.42473	229	5	1	\N	\N	\N	\N	\N	\N
492	2012-06-13 13:50:00	2012-06-13 13:50:00	M. FORESTIER,\r\n\r\n \r\n\r\nLa batterie de l’autre portable HP 4710S est également HS, j’ai contacté la hotline de HP et cela n’est pris en garantie que la première année.\r\n\r\n \r\n\r\nVeuillez donc m’envoyer un devis pour 1 batterie\r\n\r\n \r\n\r\nCordialement	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 06:02:09.588673	2012-06-14 06:02:09.588673	93	104	3	\N	\N	\N	\N	\N	\N
493	2012-06-14 06:05:00	2012-06-14 06:05:00	Bonjour,\r\n\r\nVeuillez trouver ci-joint le devis correspondant.\r\n\r\nCordialement.\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 06:07:52.778759	2012-06-14 06:07:52.778759	93	104	4	\N	cosnet.pdf	application/pdf	35209	2012-06-14 06:07:52.777228	\N
494	2012-06-14 08:42:00	2012-06-14 08:42:00	Liaison SDSL de NANTES est tombée.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 08:42:20.278757	2012-06-14 08:42:20.278757	116	141	1	\N	\N	\N	\N	\N	\N
495	2012-06-14 08:44:00	2012-06-14 08:44:00	Souci d'impression vers SagePdf et envoi de mail directement de Sage => \r\n”Afin de valider le bon fonctionnement de l'imprimante PDF Sage en Windows 7 x64,\r\nSe rendre dans les imprimantes\r\nOuvrir les propriétés de l'imprimante PDF Sage\r\nDans l'onglet Ports\r\nCréer un nouveau port local nommé NUL\r\nL'activer comme port pour l'imprimante en question\r\nValider les nouveaux paramètres\r\nSe rendre dans les services (Exécuter services.msc)\r\nRedémarrer le service Spouleur d'impression\r\n	i.moison@sigire.fr	i.moison@sigire.fr	2012-06-14 08:46:46.904275	2012-06-14 08:46:46.904275	21	17	2	\N	\N	\N	\N	\N	\N
496	2012-06-14 08:50:00	2012-06-14 08:50:00	Le lien est tombé depuis 30 minutes.\r\nLe routeur et le modem ont été redémarrés. Sans succès.\r\n\r\nVoyants du modem SDSL :\r\nstatut : vert\r\nuplink : vert\r\nip : rouge\r\ntrois suivants : pas allumé\r\n\r\nCréation d'un ticket chez OCEANET.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 08:58:10.130989	2012-06-14 08:58:10.130989	352	141	2	\N	\N	\N	\N	\N	\N
497	2012-06-14 08:28:00	2012-06-14 08:28:00	Souhaite nous rencontrer pour envisager un serveur dédié. RDV pris le 21/06 à 08h30.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 09:42:18.947942	2012-06-14 09:42:18.947942	109	137	1	\N	\N	\N	\N	\N	\N
498	2012-06-14 12:13:00	2012-06-14 12:13:00	Semble possible de mettre le BINTEC pour gérer les 2 liens. Pas forcément besoin que le VPN soit réactivé car le portable de M. LEGENDRE a déjà un client IPSEC. Pour la téléphonie, le téléphone sur IP ne lui sert que pour émettre.\r\nA revoir dès que le pb sera terminé.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 12:21:10.48865	2012-06-14 12:21:10.48865	116	141	2	\N	\N	\N	\N	\N	\N
499	2012-06-14 12:21:00	2012-06-14 12:21:00	Appel pour vérifier l'état des Leds du modem SDSL suite à intervention FT : diode IP toujours rouge.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 13:30:23.654333	2012-06-14 13:30:23.654333	352	141	2	\N	\N	\N	\N	\N	\N
500	2012-06-14 13:48:00	2012-06-14 13:48:00	\r\nFaisant suite à nos récents échanges ce matin, et à votre entretien téléphonique avec M. Ozan, veuillez trouver ci-joint notre proposition pour 15 clients IPSec et le paramétrage du pare-feu NETASQ.\r\nLe déploiement des clients IpSec reste à votre charge : il peut être effectué par nos soins en option.\r\n\r\nCordialement.\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 13:49:13.405846	2012-06-14 13:49:13.405846	2	3	4	\N	labosport.pdf	application/pdf	35712	2012-06-14 13:49:13.404543	\N
501	2012-06-14 14:01:00	2012-06-14 14:01:00	Madame,\r\n\r\nFaisant suite à nos récents échanges, veuillez trouver ci-joint notre proposition reprenant les différents éléments abordés.\r\n\r\n\r\nJe reste à votre disposition pour de plus amples renseignements.\r\n\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 14:03:35.129116	2012-06-14 14:03:35.129116	190	207	4	\N	LIGEPACK_LOGICIELS-V1.pdf	application/pdf	265981	2012-06-14 14:03:35.127552	\N
502	2012-06-14 14:39:00	2012-06-14 14:39:00	Monsieur,\r\n\r\nMerci pour cette proposition. J'ai quelques précisions à vous demander :\r\n- Ce que vous incluez dans les mensualités, (sarbacane, gestion des\r\ncomptes CRM) est-il à prévoir tous les mois? - Y a-t-il possibilité\r\nd'avoir plus de 5 utilisateurs (multi sites) pour l'outil CRM?\r\n- avez-vous inclus la possibilité de donner plusieurs qualifications à un\r\nmême contact ?\r\n\r\nDans l'attente de votre retour\r\n\r\nCordialement\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 14:39:42.916717	2012-06-14 14:39:42.916717	190	207	3	\N	\N	\N	\N	\N	\N
567	2012-07-01 22:00:00	2012-07-01 22:00:00	\N	g.bonvoust@sigire.fr	\N	2012-07-02 10:14:41.612115	2012-07-02 10:14:41.612115	271	266	11	\N	\N	\N	\N	\N	3
583	2012-07-10 08:55:00	2012-07-10 09:55:00	Appel concernant "plein de chose"...	m.ozan@sigire.fr	\N	2012-07-10 08:56:43.657662	2012-07-10 08:56:43.657662	101	17	2	\N	Capture_VH1_RAM.PNG	image/png	187037	2012-07-10 08:56:43.606484	7
617	2012-07-09 22:00:00	2012-07-09 22:00:00	\N	\N	g.bonvoust@sigire.fr	2012-07-10 10:17:14.839932	2012-07-10 10:17:14.839932	23	17	1	\N	\N	\N	\N	\N	4
503	2012-06-14 14:42:00	2012-06-14 14:42:00	Bonsoir,\r\n\r\n- les mensualités indiquées sont à régler tous les mois. Il n'y a pas d'engagement de durée.\r\n- il est possible de prévoir bien plus de 5 comptes utilisateurs. J'ai estimé, suite à nos différents échanges, qu'il y aurait environ 5 utilisateurs à prévoir. Si vous avez besoin de 8 ou 10 comptes, cela ne pose aucun problème. Le coût est fixé à 10 EUR HT par compte et par mois.\r\n- Qu'entendez-vous par "plusieurs qualifications à un même contact" ?\r\n\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 14:42:31.059474	2012-06-14 14:42:31.059474	190	207	4	\N	\N	\N	\N	\N	\N
504	2012-06-14 14:55:00	2012-06-14 14:55:00	Bonjour,\r\n\r\nNous avons fait avec Laurent une petite fiche récap de nos besoins et interrogations pour l'achat de notre serveur dédié.\r\nNous parlerons de tout cela en détail lors de notre rdv de jeudi prochain.\r\n\r\nMerci d'avance, 	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 15:25:28.800222	2012-06-14 15:25:28.800222	353	137	3	\N	serveur_dedie.odt	application/vnd.oasis.opendocument.text	15724	2012-06-14 15:25:28.798913	\N
505	2012-06-14 15:33:00	2012-06-14 15:33:00	Bonsoir\r\n\r\nPar qualifications aux contacts, j'entends ce dont nous avions parlé :\r\nLa possibilité qu'un contact ait le statut administrateur, membre d'un\r\ngroupe de travail, expert sur une thématique,....pour me permettre de\r\nfaire des extractions rapides en vue d'invitations ciblées\r\n\r\nCordialement	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 15:33:25.291169	2012-06-14 15:33:25.291169	190	207	3	\N	\N	\N	\N	\N	\N
506	2012-06-14 15:34:00	2012-06-14 15:34:00	Bonjour,\r\n\r\n \r\n\r\nPouvez vous, s’il vous plait nous envoyer le devis pour un serveur Windows 2008R2 dans le cadre d’une étude dévolution du réseau pédagogique ?\r\n\r\n \r\n\r\nCaractéristiques souhaité et attendue :\r\n\r\n \r\n\r\nServeur rackable avec alimentation redondante\r\n\r\n \r\n\r\nContrôleur de domaine Active Directory, DNS, DHCP (50 à 100 postes, 400 utilisateurs)\r\n\r\nLe serveur gérera aussi le spooler d’impression de l’école.\r\n\r\n \r\n\r\n16Go de RAM avec possibilité d’extension si besoin\r\n\r\nDisques SAS en RAID5 600Go utiles\r\n\r\n \r\n\r\n2 Cartes réseaux Ethernet 1Go compatible 2008R2\r\n\r\n \r\n\r\nSystèmes de sauvegardes sur baie NAS (format boîtier 8 baies disques) avec 2To utile. QNAP\r\n\r\n \r\n\r\nSystème antivirus Kaspersky server pour trois serveurs et 15 postes Windows\r\n\r\n \r\n\r\nKVM avec port PS2 et USB\r\n\r\nEcran 19’’\r\n\r\n \r\n\r\nOnduleur compatible avec le serveur\r\n\r\n \r\n\r\n \r\n\r\n \r\n\r\nCordialement	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 15:34:41.216451	2012-06-14 15:34:41.216451	195	210	3	\N	\N	\N	\N	\N	\N
507	2012-06-14 15:36:00	2012-06-14 15:36:00	Lien qui remonte !	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 15:37:14.232515	2012-06-14 15:37:14.232515	352	141	1	\N	\N	\N	\N	\N	\N
508	2012-06-14 15:37:00	2012-06-14 15:37:00	Appel pour prévenir que lien OK. Rapport à communiquer. Procédure de repli à mettre en place avec leur ADSL Orange.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-14 15:40:14.301075	2012-06-14 15:40:14.301075	116	141	2	\N	\N	\N	\N	\N	\N
509	2012-06-14 16:02:00	2012-06-14 16:02:00	Bonsoir Madame Moison, Monsieur Forestier,\r\n\r\n \r\n\r\nATTENTION, le fichier des données est modifié. Merci de prendre en compte cette version pour le chargement au 31/03/2012.\r\n\r\nNous nous excusons pour la modification de dernière minute.\r\n\r\n \r\n\r\nCordialement,	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-15 04:10:16.81372	2012-06-15 04:10:16.81372	99	104	3	\N	Articles_polymoule_pour_chargement_inventaire_au_310312_VERSION_2.xls	application/vnd.ms-excel	1030656	2012-06-15 04:10:16.812193	\N
510	2012-06-15 03:38:00	2012-06-15 04:10:00	Bonjour,\r\n\r\nL'importation du fichier a été effectuée.\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-15 04:11:31.530164	2012-06-15 04:11:31.530164	99	104	4	\N	\N	\N	\N	\N	\N
511	2012-06-15 04:29:00	2012-06-15 04:29:00	Bonjour,\r\n\r\nChaque contact pourra avoir un ou plusieurs "centres d'intérêts" et une extraction des contacts sera possible en utilisant ce critère.\r\n\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-15 04:31:43.839191	2012-06-15 04:31:43.839191	190	207	4	\N	\N	\N	\N	\N	\N
512	2012-06-15 04:33:00	2012-06-15 04:33:00	Bonjour,\r\n\r\nLa rédaction du devis est en cours.\r\n\r\nNous devrions pouvoir vous le faire parvenir aujourd'hui ou lundi.\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-15 04:36:09.997044	2012-06-15 04:36:09.997044	195	210	4	\N	\N	\N	\N	\N	\N
513	2012-06-15 08:58:00	2012-06-15 08:58:00	Demande de cotation : infra VEEAM	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-15 08:59:17.803393	2012-06-15 08:59:17.803393	371	125	4	\N	\N	\N	\N	\N	\N
514	2012-06-15 08:59:00	2012-06-15 08:59:00	Demande de cotation : infra VEEAM	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-15 08:59:22.641947	2012-06-15 08:59:22.641947	81	125	1	\N	\N	\N	\N	\N	\N
515	2012-06-15 09:43:00	2012-06-15 09:43:00	Appel du support car plus de sauvegarde IMS sur le serveur 3 !\r\nTicket en cours...	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-15 10:04:15.348064	2012-06-15 10:04:15.348064	36	26	2	\N	\N	\N	\N	\N	\N
516	2012-06-15 13:05:00	2012-06-15 13:05:00	1 - Outils --> Réajustement des cumuls.\r\n2 - Import de l'inventaire \r\n3 - Correction éventuelle du prix par saisie manuelle\r\n4 - Recalcul du CMUP par le logiciel => Montant OK\r\nConclusion : cette logique rend les valeurs correctes. L'import de l'inventaire ne lance pas de recalcul du CMUP, ce qui fait que la modification du prix n'est pas prise en compte pour les opérations suivantes. Automatiser ce recalcul suite à l'import?	i.moison@sigire.fr	i.moison@sigire.fr	2012-06-15 13:11:12.083049	2012-06-15 13:11:12.083049	99	104	1	\N	\N	\N	\N	\N	\N
517	2012-06-15 14:25:00	2012-06-15 14:25:00	Appel à Agefos PME concernant le règlt de la facture pour la format° Paie. Agefos attend des fonds de l'ACO avant de pouvoir nous régler.	i.moison@sigire.fr	i.moison@sigire.fr	2012-06-15 14:27:22.416994	2012-06-15 14:27:22.416994	107	136	2	\N	\N	\N	\N	\N	\N
518	2012-06-18 10:03:00	2012-06-18 10:03:00	Demande de récupération du Mac pour réinstallation parallels + windows + office + project, attente de réponse	n.retout@sigire.fr	n.retout@sigire.fr	2012-06-18 10:03:27.448169	2012-06-18 10:03:27.448169	428	367	4	\N	\N	\N	\N	\N	\N
519	2012-06-18 09:20:00	2012-06-18 09:20:00	Validation de l'architecture Technique "Infra VEEAM" par Arnaud QUENUM.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-18 11:53:50.554954	2012-06-18 11:53:50.554954	372	125	1	\N	\N	\N	\N	\N	\N
520	2012-06-19 07:52:00	2012-06-19 07:52:00	"Pour répondre à votre question, il n’est pas possible que vous preniez mon ordinateur, car mes collègues ont besoin d’accéder à Entourage si besoin."\r\n\r\nIl vous sera impossible de travailler sur ce poste tout au long de l’intervention (donc entourage non disponible, mais votre adresse est consultable sur les autres mac...) et je ne peux déterminer le temps de réinstallation nécessaire.\r\nSur ce genre de réinstallation qui peut durer un moment nous préconisons une réinstallation dans nos locaux.\r\nY a t’il prochainement une date pour la récupération du mac dans nos locaux qui vous arrangerait ?\r\n\r\n\r\n	n.retout@sigire.fr	n.retout@sigire.fr	2012-06-19 07:53:50.245491	2012-06-19 07:53:50.245491	428	367	4	\N	\N	\N	\N	\N	\N
521	2012-06-19 08:28:00	2012-06-19 08:28:00	Installation Norton antivirus par prise en main distante sur nouveau mac !	n.retout@sigire.fr	n.retout@sigire.fr	2012-06-19 08:29:27.445817	2012-06-19 08:29:27.445817	162	177	13	\N	\N	\N	\N	\N	\N
522	2012-06-19 13:06:00	2012-06-19 13:06:00	Pb internet : est ce orange ou le pc ? Je passe chez elle vendredi 22/06	n.retout@sigire.fr	n.retout@sigire.fr	2012-06-19 14:30:37.601056	2012-06-19 14:30:37.601056	267	262	1	\N	\N	\N	\N	\N	\N
523	2012-06-11 12:45:00	2012-06-11 12:45:00	Bonjour Monsieur FORESTIER,\r\n\r\n \r\n\r\nNous envisageons de changer de prestataire pour la gestion et l’hébergement de notre site WEB.\r\n\r\nDans la mesure où vous avez dans le passé été prestataire d’HABRIAL MANUTENTION pour cette même activité, je me permets de vous solliciter pour me faire part de votre meilleure offre.\r\n\r\n \r\n\r\nCordialement	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-20 03:12:08.741157	2012-06-20 03:12:08.741157	20	17	3	\N	\N	\N	\N	\N	\N
568	2012-07-01 22:00:00	2012-07-01 22:00:00	\N	g.bonvoust@sigire.fr	g.bonvoust@sigire.fr	2012-07-02 12:47:54.787719	2012-07-02 12:47:54.787719	273	266	11	\N	\N	\N	\N	\N	3
569	2012-07-01 22:00:00	2012-07-01 22:00:00	\N	g.bonvoust@sigire.fr	g.bonvoust@sigire.fr	2012-07-02 12:48:17.423975	2012-07-02 12:48:17.423975	271	266	11	\N	\N	\N	\N	\N	2
524	2012-06-11 13:51:00	2012-06-11 13:51:00	Cher Monsieur,\r\n\r\nTout d'abord, je tiens à vous remercier pour cette consultation!\r\n\r\nAfin d'établir la meilleure offre, je dois connaître les points suivants :\r\n- qu'entendez-vous par "gestion" : modifications mineures de l'application ? Modifications de contenu ? Support technique ?\r\n- pouvez-vous nous préciser les technologies (et leurs versions) employées dans le site www.habrial.fr ? (bases de données, langage de développement, etc.) ?\r\n\r\nMerci.\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-20 03:13:13.324756	2012-06-20 03:13:13.324756	20	17	4	\N	\N	\N	\N	\N	\N
525	2012-06-11 14:08:00	2012-06-11 14:08:00	Monsieur FORESTIER,\r\n\r\nL'objectif de cette consultation est de reprendre l'hébergement du site et\r\nde pouvoir en assurer le support technique.\r\n\r\nPour ce qui est des technologies, je peux vous préciser les\r\ncaractéristiques de l'hébergement actuel:\r\n\r\nAlias\r\nRouteur CISCO/Firewall Linux\r\nMonitoring 24/24 et 7/7\r\nAccès statistiques\r\nPHP/MyQSL\r\nBande passante: 2,5 Gbps\r\nLiaison internet: fibre optique\r\n\r\nVoilà pour ce que je sais, en espérant que cela vous suffise.\r\n\r\nCordialement	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-20 03:14:16.368003	2012-06-20 03:14:16.368003	20	17	3	\N	\N	\N	\N	\N	\N
526	2012-06-20 03:40:00	2012-06-20 03:40:00	Monsieur,\r\n\r\nJ'ai tenté de joindre DéclicWeb pour obtenir ds informations techniques complémentaires sur vos hébergements actuels. Cette société n'a pas donné suite à ma requête. Il semblerait que leur situation actuelle (dépôt de bilan) gèle les réponses à ce type de demande...\r\n\r\nVoici les éléments importants à connaître :\r\n- espace disque nécessaire ?\r\n- Base de données utilisée (et version) ---> a priori uniquement MySQL, mais quelle version ?\r\n- Langage utilisé et version ---> a priori uniquement PHP mais quelle version ?\r\n- Le site est-il basé sur un CMS ou un outil de vente en ligne standard ? (WordPress, Prestashop, etc.)\r\n- Paiement en ligne existant ? Si oui, quelle solution, avec quelle banque ?\r\n- Statut du code source du site web : appartenant à HABRIAL MANUTENTION ou bien certaines parties sont sous licence tierce ?\r\n- nombre de pages vues par mois ?\r\n- Statistiques générées par quel outil ?\r\n- sites concernés avec leurs noms de domaine (a priori www.habrial.fr et www.autoequipement.fr alias www.amenagement-vehicule.com)\r\n\r\nEn fonction des réponses à ces questions, nous pourrons déterminer la meilleure offre adaptée à votre situation.\r\n\r\nActuellement, nos plans d'hébergement démarrent à 99 EUR HT par an (site statique, sur serveur mutualisé, sans administration ni monitoring) et vont crescendo jusqu'au serveur dédié, en passant par des machines virtuelles dédiées (bon compromis entre hébergement mutualisé et hébergement dédié).\r\n\r\nVu de l'extérieur, sans connaissance des éléments techniques décrits ci-dessus, j'aurais tendance à vous orienter vers une machine virtuelle dédiée qui possède les avantages suivants :\r\n- environnement dédié à la société Habrial (pas mutualisé avec d'autres clients)\r\n- forte capacité d'évolution (ajout de mémoire ou de stockage en quelques minutes)\r\n- forte capacité d'adaptation aux environnements spécifiques nécessitant des versions particulières de logiciels\r\n- forte capacité à gérer la sécurité de façon personnalisée\r\n- supervision des services\r\n\r\nCe type de solution se situe dans une fourchette de prix allant de 50 à 200 EUR HT par mois environ, selon la puissance souhaitée et le stockage attribué (espace disque).\r\n\r\nNous avons aussi des options permettant de gérer automatiquement la sauvegarde des données de cette machine virtuelle vers un site secondaire, permettant ainsi une protection maximale de vos données contre l'écrasement ou la corruption.\r\n\r\n\r\nJe reste bien entendu à votre disposition si vous souhaitez mettre en place un plan d'action pour tenter d'avancer, même sans l'aide de DéclicWeb. A mon sens, la première démarche serait de contacter le mandataire nommé afin de garantir la sauvegarde de vos intérêts : communication des codes sources de votre site (ou de vos sites) et transfert des éventuels noms de domaine gérés actuellement par DéclicWeb.\r\n\r\nJe peux vous assister dans cette démarche si vous le désirez.\r\n\r\n\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-20 03:40:33.011518	2012-06-20 03:40:33.011518	20	17	4	\N	\N	\N	\N	\N	\N
527	2012-06-20 03:42:00	2012-06-20 03:42:00	Monsieur,\r\n\r\nFaisant suite à vos récents échanges avec M. Retout, je vous renvoie la proposition concernant les comptes Google Apps.\r\n\r\n\r\nCordialement.\r\n\r\n\r\nGabriel Forestier\r\nSIGIRE\r\n20 rue de Sardaigne\r\n72100 LE MANS - France\r\nTel: +33 (0)2 43 82 75 00\r\nFax: +33 (0)2 43 82 75 75\r\nhttp://www.sigire.fr\r\n[_Informatique & Telecom pour l'entreprise_]\r\n\r\n\r\n\r\n-------- Message original --------\r\nSujet: Re: Adresse mail CGI\r\nDate : Fri, 18 May 2012 17:15:06 +0200\r\nDe : Gabriel Forestier <g.forestier@sigire.fr>\r\nPour : François Priollaud - ARIANE <fp@ariane.fr>\r\nCopie à : mdp@ariane.fr\r\n\r\nMonsieur,\r\n\r\nJe vous confirme que le nom de domaine CGIC.PRO a bien été réservé.\r\n\r\nVous trouverez ci-joint le formulaire de commande pour les comptes \r\n"Google Apps" pour les 4 utilisateurs que vous nous avez indiqués.\r\n\r\n\r\nCordialement.\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-20 03:43:08.249269	2012-06-20 03:43:08.249269	114	139	4	\N	cgic.pdf	application/pdf	149878	2012-06-20 03:43:08.24756	\N
528	2012-06-20 04:38:00	2012-06-20 04:38:00	Bonjour Monsieur FORESTIER,\r\n\r\nMerci pour votre mail que j'ai lu avec attention.\r\nJe vais dès ce matin préparer un courrier adressé à l'administrateur\r\njudiciaire en charge du suivi de la société Déclic Web et me\r\npermettrai de vous le soumettre pour avis.\r\n\r\nCordialement	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-20 06:29:55.236539	2012-06-20 06:29:55.236539	20	17	3	\N	\N	\N	\N	\N	\N
530	2012-06-20 06:30:00	2012-06-20 06:30:00	Bonjour,\r\n\r\nJe vous donnerai mes éventuelles remarques avec plaisir.\r\n\r\nCordialement. 	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-20 06:30:24.611773	2012-06-20 06:30:24.611773	20	17	4	\N	\N	\N	\N	\N	\N
531	2012-06-20 06:40:00	2012-06-20 06:40:00	Monsieur FORESTIER,\r\n\r\nVeuillez trouver ci-dessous le projet de courrier que j'envisage de faire\r\npartir ce jour.\r\n\r\nMerci de me faire part de vos éventuelles remarques\r\n\r\nCordialement\r\n\r\nPatrick L'HELGUEN\r\nHABRIAL MANUTENTION S.A.S.\r\n\r\nNota: j'ai retiré la question relative au site commercial et au paiement en\r\nligne car notre site ne dispose pas de cette fonctionnalité à ce jour\r\n\r\n\r\nHABRIAL MANUTENTION\r\nS.A.S. au capital de 145.302 €\r\nSiret 307 604 108 00034 – APE 4669 B\r\nZA 3Bd des Ravalières – BP  28\r\n72560 CHANGE\r\nTél. 02.43.40.19.00\r\ninfo@habrial.fr\r\n\r\n\r\n\r\n\r\nBGM Associés\r\nA l’attention de Maître François MERCIER\r\nAdministrateur judiciaire\r\n5, avenue Pierre Mendes FRANCE\r\n72000 LE MANS\r\n\r\n\r\nMonsieur l’Administrateur judiciaire,\r\n\r\n\r\nNotre société spécialisée dans le négoce de matériels de manutention a\r\nconfié à la société DeclicWeb, sise au 29 rue LENOIR au MANS (72000),\r\nl’hébergement\r\nde son site INTERNET.\r\n\r\nCet outil est indispensable à la vente de nos équipements et une rupture\r\nmême temporaire de son hébergement aurait inévitablement des conséquences\r\nirrémédiables pour notre société.\r\n\r\nCompte tenu de la situation précaire de la société DeclicWeb placée en\r\nredressement judiciaire depuis le 22 mai 2012, nous souhaitons prendre nos\r\ndispositions pour, le cas échéant, faire héberger notre site chez un autre\r\nprestataire dans l’éventualité d’une cessation d’activité de notre\r\nprestataire actuel.\r\n\r\nPour ce faire nous avons besoin des éléments techniques suivants :\r\n\r\n- Espace disque nécessaire ?\r\n- Base de données utilisée et version actuelle ?\r\n- Langage utilisé et version actuelle ?\r\n- Le site est-il basé sur un CMS ou un outil de vente en ligne standard (si\r\noui, lequel) ?\r\n- Statut du code source du site web : appartenant à HABRIAL MANUTENTION ou\r\nbien certaines parties sont sous licence tierce ?\r\n- Nombre de pages vues par mois ?\r\n- Statistiques générées par quel outil ?\r\n- sites concernés avec leurs noms de domaine\r\n\r\nJe vous saurai gré de bien vouloir faire le nécessaire pour que nous\r\npuissions obtenir ces informations dans les meilleurs délais afin de prendre\r\nnos dispositions en fonction de l’évolution de la situation de la société\r\nDeclicWeb.\r\n\r\nNous vous prions d'agréer, Monsieur l'Administrateur, l'expression de nos\r\nsalutations distinguées.\r\n\r\nPatrick L’HELGUEN	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-20 06:45:02.629466	2012-06-20 06:45:02.629466	20	17	3	\N	\N	\N	\N	\N	\N
532	2012-06-20 06:45:00	2012-06-20 06:45:00	C'est parfait.\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-20 06:45:20.183427	2012-06-20 06:45:20.183427	20	17	4	\N	\N	\N	\N	\N	\N
533	2012-06-20 06:56:00	2012-06-20 06:56:00	Bonjour,\r\n\r\nL'un des adaptateurs secteur des boitiers convertisseurs MICRONET (SP3501) commandés chez vous dernièrement est en panne. \r\n\r\nQuelle est la procédure pour le remplacement ?\r\n\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-20 06:56:34.446177	2012-06-20 06:56:34.446177	46	53	4	\N	\N	\N	\N	\N	\N
534	2012-06-20 08:10:00	2012-06-20 08:10:00	Ticket OLM pour Accès ADSL HS : https://ogic.oceanet.com:843//ticket_details.php?sti_id=320&notif=message_ok	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-20 08:11:44.736284	2012-06-20 08:11:44.736284	28	15	2	\N	\N	\N	\N	\N	\N
535	2012-06-20 08:23:00	2012-06-20 08:23:00	Souhaite avoir devis pour Wifi (apparemment demandé en Mai). A reçu proposition concurrente, mais souhaite travailler avec nous : ne veut pas multiplier les interlocuteurs. A recontacter au 02 43 50 20 69.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-20 08:24:23.621067	2012-06-20 08:24:23.621067	429	148	1	\N	\N	\N	\N	\N	\N
536	2012-06-20 09:18:00	2012-06-20 09:18:00	Des discussions sont en cours avec M. Chapeau au sujet du Wifi. Rappeler Mme Ponthou en début d'après-midi.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-20 09:25:44.718257	2012-06-20 09:25:44.718257	429	148	2	\N	\N	\N	\N	\N	\N
537	2012-06-18 13:00:00	2012-06-18 15:30:00	Mise en place Mises à jour SAGE Compta/Moyens de Paiements sur poste Mme OGER + paramétrage EBICS.\r\n\r\nTest OK.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-20 12:51:42.479412	2012-06-20 12:51:42.479412	97	21	11	\N	\N	\N	\N	\N	\N
538	2012-06-20 12:51:00	2012-06-20 12:58:00	Pb pour lire fichier Excel en pièce jointe dans un e-mail : le fichier comporte un tiret dans l'extension (.-xls) !\r\nDossier "sauvegarde" sur le réseau contient de fichiers person de Mme Charbonnier ainsi qu'une copie de la compta : Mme Oger le supprime.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-20 13:01:52.533027	2012-06-20 13:01:52.533027	97	21	1	\N	\N	\N	\N	\N	\N
539	2012-06-20 13:01:00	2012-06-20 13:01:00	Appel pour faire le point sur sauvegarde + vidéo. M. Vivier n'est pas dispo. Le rappeler dans 1 heure.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-20 13:03:29.684246	2012-06-20 13:03:29.684246	5	5	2	\N	\N	\N	\N	\N	\N
540	2012-06-20 13:03:00	2012-06-20 13:19:00	OK pour transfert du NAS vers serveur windows + mise en place TSE et licences Office associées. Intervention à distante prévue le 13/07 à 21h00 puis intervention sur site prévue le 16/07 à 08h30.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-20 13:20:46.75214	2012-06-20 13:20:46.75214	27	19	2	\N	\N	\N	\N	\N	\N
541	2012-06-20 13:32:00	2012-06-20 13:32:00	Dernière commande OK. Souhaite tarif des clés 3G sans abonnement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-20 13:34:37.396932	2012-06-20 13:34:37.396932	88	128	1	\N	\N	\N	\N	\N	\N
570	2012-07-01 22:00:00	2012-07-01 22:00:00	\N	g.bonvoust@sigire.fr	g.bonvoust@sigire.fr	2012-07-02 12:53:52.792248	2012-07-02 12:53:52.792248	273	266	11	\N	\N	\N	\N	\N	3
584	2012-07-09 22:00:00	2012-07-09 22:00:00	\N	\N	g.bonvoust@sigire.fr	2012-07-10 09:07:50.490737	2012-07-10 09:07:50.490737	22	17	11	\N	\N	\N	\N	\N	4
542	2012-06-20 13:37:00	2012-06-20 13:37:00	Mes Chers associés,\r\n\r\nA ma demande Monsieur Forestier va intervenir pour rétablir l'accès distant au serveur au profit des trois associés.\r\nIl faut pour cela :\r\n1) corriger l'anomalie actuelle de l'architecture du système en basculant les données du NAS vers le WINDOWS\r\nL'opération sera lancée à distance le 13 juillet à 21h\r\n2) changer les raccourcis sur tous les postes du cabinet pour qu'ils se connectent au WINDOWS et non plus au NAS.\r\nCette opération sera faite sur place le lundi 16 juillet à la première heure\r\n3) fournir et installer le mode TSE qui permet un accès distant beaucoup plus rapide que celui qu'on a connu par le passé.\r\nCe qui suppose trois licences TSE + trois licences Word et Excel dédiées pour l'activation du TSE.\r\nMonsieur Forestier va nous adresser un devis actualisé.\r\nBien à vous.\r\n\r\nLudovic \r\n\r\n\r\nP.S. Il vaudra mieux ne pas utiliser le serveur entre le 13 juillet à 21h et le 16 juillet (en fin de matinée pour les derniers postes équipés des nouveaux raccourcis) 	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-20 13:50:12.099305	2012-06-20 13:50:12.099305	27	19	3	\N	\N	\N	\N	\N	\N
543	2012-06-20 14:03:00	2012-06-20 14:03:00	Cindy souhaite trouver une solution au plus vite pour dépanner la ligne internet. Nous envisageons d'utiliser le lien SDSL temporairement, le temps de résoudre le problème.\r\n\r\nJe dois les recontacter dans l'après-midi pour leur donner des infos à ce sujet.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-20 14:09:35.155779	2012-06-20 14:09:35.155779	77	15	2	\N	\N	\N	\N	\N	\N
544	2012-06-20 15:08:00	2012-06-20 15:08:00	Nous venons de vous retourner les documents nécessaires à l'ouverture de compte. L'original suit par courrier.\r\n\r\nJe vous contacte aussi dans le cadre de la demie-journée que nous organisons le 27 septembre prochain, autour de la virtualisation et du stockage.\r\nNous avons mandaté une agence de communication (ON-CHANNEL) pour monter l'évènement : l'objectif est de faire venir 20 prospects dans un château proche du Mans durant une demie-journée. L'agence de communication se charge de l'e-mailing et du phoning de relance (300 contacts ciblés).\r\n\r\nSeront présents à cette matinée : \r\n- IBM (Thierry Prevault)\r\n- ETC/METROLOGIE (grossiste IBM), à qui nous achetons nos serveurs et nos baies de stockage IBM\r\n\r\nJe souhaiterais que AVNET puisse participer et intervenir sur le thème de la sauvegarde en environnement virtualisé (Veeam Backup).\r\nDans le même temps, j'aimerais que AVNET puisse nous aider dans le cadre d'un co-financement. Etes-vous en mesure :\r\n- d'intervenir sur le thème de Veeam Backup\r\n- de nous assurer ce co-financement ?\r\n\r\n\r\nActuellement, il nous reste environ 1.600 EUR HT à notre charge, une fois déduite la participation d'IBM. Il va de soi que si vous participez et assurez ce co-financement, nous commanderons les licences Veeam vendues chez vous.\r\n\r\n\r\nParallèlement, nous préparons la certification Veeam, sachant que nous sommes déjà certifiés sur vmware. \r\n\r\n\r\nDans l'attente de votre réponse...	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-20 15:08:38.086047	2012-06-20 15:08:38.086047	81	125	4	\N	\N	\N	\N	\N	\N
545	2012-06-20 17:13:00	2012-06-20 17:13:00	Bonsoir,\r\n\r\nNous avons reçu de nouveaux éléments concernant la demande de portabilité :\r\n\r\n- le numéro de fax (02 43 87 40 32) est lié à la tête de ligne (02 43 87 42 48), tout comme les numéros 02 43 87 41 31, 02 43 87 43 02 et 02 43 87 42 43. Cela signifie qu'il faut impérativement tout migrer : France Telecom refuse de faire des portabilités partielles.\r\n\r\n--> cela pose le problème du fax. Des solutions existent (boitier convertisseur ou portabilité SIGIRE vers FT à effectuer une fois la migration faite). A étudier ...\r\n\r\n\r\n- le numéro 02 43 87 55 49 est situé (d'après FT) à une autre adresse que "Place de l'Eglise". Pouvez-vous nous transmettre cette adresse ?\r\n\r\n\r\n\r\nPour le reste, FRANCE TELECOM nous indique qu'il n'y a pas (a priori) d'autres erreurs.\r\n\r\n\r\nJe reviens vers vous demain après-midi pour aborder le problème du fax.\r\n	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-20 17:14:10.149937	2012-06-20 17:14:10.149937	3	4	4	\N	\N	\N	\N	\N	\N
546	2012-06-21 07:52:00	2012-06-21 08:02:00	Modification de la session TSE d'Elodie GILLET pour donner accès à "Internet Explorer" (et donc au Webmail) situé sur le serveur d'ITF !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-21 08:04:39.469065	2012-06-21 08:04:39.469065	16	15	13	\N	\N	\N	\N	\N	\N
547	2012-06-21 08:05:00	2012-06-21 08:15:00	Téléchargement + installation du soft SAMSUNG pour transférer les photos !	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-21 08:06:37.408836	2012-06-21 08:06:37.408836	62	45	13	\N	\N	\N	\N	\N	\N
548	2012-06-21 09:35:00	2012-06-21 10:00:00	Dépannage connexion TSE (pour enregistrer les fichiers à travers la connexion TSE)	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-21 10:02:38.117313	2012-06-21 10:02:38.117313	77	15	1	\N	\N	\N	\N	\N	\N
549	2012-06-21 13:36:00	2012-06-21 13:36:00	Rappelé mais pas dispo et pas devant son pc...\r\nAttends son appel.	n.retout@sigire.fr	n.retout@sigire.fr	2012-06-21 13:38:57.099075	2012-06-21 13:38:57.099075	62	45	2	\N	\N	\N	\N	\N	\N
550	2012-06-22 13:48:00	2012-06-22 13:48:00	Bonjour,\r\n\r\nBonne nouvelle : j'ai fini par trouver les clés 3G !\r\n\r\nJ'ai demandé à Futur Telecom de vous les envoyer directement à VAAS.\r\n\r\nTenez-moi au courant quand vous les aurez...\r\n\r\nCordialement.	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-06-22 13:49:51.865079	2012-06-22 13:49:51.865079	88	128	4	\N	\N	\N	\N	\N	\N
551	2012-06-22 14:24:00	2012-06-22 14:24:00	Netasq HS ?	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-22 14:25:03.453913	2012-06-22 14:25:03.453913	241	235	1	\N	\N	\N	\N	\N	\N
552	2012-06-25 14:27:00	2012-06-25 14:27:00	Diverses questions sur le CCTP.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-25 15:08:35.700153	2012-06-25 15:08:35.700153	195	210	2	\N	\N	\N	\N	\N	\N
553	2012-06-26 12:20:00	2012-06-26 12:20:00	Contacter pour pb écran Hannotin : rien de visuel en prise de main à distance. Certainement un pb d'écran (écran plus sombre d'un côté...).	n.retout@sigire.fr	n.retout@sigire.fr	2012-06-26 12:21:33.183174	2012-06-26 12:21:33.183174	27	19	1	\N	\N	\N	\N	\N	\N
555	2012-06-27 13:48:00	2012-06-27 13:48:00	Les utilisateurs ne doivent pas être administrateurs => Installer la paie en C:\\ (et non par défaut dans Program Files (x86).\r\nAvt l'installation, faire une sauvegarde du dossier GA, des fichiers pms.sga et pms.fga.\r\nPour les paies version 20, avoir téléchargé sur le site de Sage le patch, puis l'installer également (sinon, les fiches de personnels perdent des données lors d'importations).\r\nAttention, les raccourcis de paie Sage doivent avoir pour cible C:\\SagePaie\\pmsw32.exe \\\\s2008-uniflow\\SAGE\\CKB.prh,\r\nsinon impossible d'imprimer les Etats GA.	i.moison@sigire.fr	i.moison@sigire.fr	2012-06-27 13:49:14.774541	2012-06-27 13:49:14.774541	216	48	1	\N	\N	\N	\N	\N	\N
556	2012-06-26 14:00:00	2012-06-27 14:00:00	Reçu les clés 3G de Futur Télécom de n° de IMEI: 355083019052874 - 355083019053278 - 355083019053054;\r\nM. Blin ne pouvant les récupérer au Mans, envoi en Colissimo recommandé avec signature ce 26/06/12.\r\nPrêt jq 30 Novembre 2012.	i.moison@sigire.fr	i.moison@sigire.fr	2012-06-27 14:03:40.391223	2012-06-27 14:03:40.391223	88	128	1	\N	\N	\N	\N	\N	\N
557	2012-06-28 07:25:00	2012-06-28 07:25:00	Mail pour prévenir de la date de portabilité : *Jeudi 5 juillet 2012 à 10H00*	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-06-28 07:41:07.28394	2012-06-28 07:41:07.28394	3	4	4	\N	\N	\N	\N	\N	\N
558	2012-06-28 10:09:00	2012-06-28 10:09:00	Pour la HP P2035, souhaitait savoir s'il existait des cartouches de plus de 2300p (non!). Durée de la cartouche => 1 mois. Il faudra penser au débit et cartouche grande capacité pour les prochaines offres.	i.moison@sigire.fr	i.moison@sigire.fr	2012-06-28 10:12:06.927719	2012-06-28 10:12:06.927719	92	130	1	\N	\N	\N	\N	\N	\N
559	2012-06-28 22:00:00	2012-06-28 22:00:00	\N	m.ozan@sigire.fr	\N	2012-06-29 15:12:36.911823	2012-06-29 15:12:36.911823	\N	230	11	\N	\N	\N	\N	\N	1
561	2012-07-01 22:00:00	2012-07-01 22:00:00	\N	g.bonvoust@sigire.fr	\N	2012-07-02 07:52:41.728172	2012-07-02 07:52:41.728172	\N	24	11	\N	\N	\N	\N	\N	2
562	2012-07-01 22:00:00	2012-07-01 22:00:00	\N	g.bonvoust@sigire.fr	g.bonvoust@sigire.fr	2012-07-02 08:02:15.412976	2012-07-02 08:02:15.412976	\N	149	11	\N	\N	\N	\N	\N	2
578	2012-07-09 22:00:00	2012-07-09 22:00:00	\N	\N	m.ozan@sigire.fr	2012-07-10 08:19:25.261385	2012-07-10 08:19:25.261385	20	17	11	\N	\N	\N	\N	\N	5
623	2012-07-09 22:00:00	2012-07-09 22:00:00	\N	\N	m.ozan@sigire.fr	2012-07-10 20:21:22.186682	2012-07-10 20:21:22.186682	\N	265	16	\N	\N	\N	\N	\N	6
624	2012-07-10 22:00:00	2012-07-10 22:00:00	\N	g.bonvoust@sigire.fr	\N	2012-07-11 09:14:10.265711	2012-07-11 09:14:10.265711	49	24	11	\N	\N	\N	\N	\N	9
625	2012-07-10 22:00:00	2012-07-10 22:00:00	\N	\N	g.bonvoust@sigire.fr	2012-07-11 09:16:02.139104	2012-07-11 09:16:02.139104	49	24	11	\N	\N	\N	\N	\N	9
626	2012-07-10 22:00:00	2012-07-10 22:00:00	\N	\N	g.bonvoust@sigire.fr	2012-07-11 09:17:22.257653	2012-07-11 09:17:22.257653	49	24	11	\N	\N	\N	\N	\N	9
627	2012-07-10 22:00:00	2012-07-10 22:00:00	\N	m.ozan@sigire.fr	\N	2012-07-11 09:18:55.311353	2012-07-11 09:18:55.311353	111	139	11	\N	\N	\N	\N	\N	10
628	2012-07-10 22:00:00	2012-07-10 22:00:00	\N	\N	g.bonvoust@sigire.fr	2012-07-11 09:51:09.694067	2012-07-11 09:51:09.694067	\N	24	11	\N	\N	\N	\N	\N	9
629	2012-07-10 22:00:00	2012-07-10 22:00:00	\N	\N	g.bonvoust@sigire.fr	2012-07-11 09:52:01.246382	2012-07-11 09:52:01.246382	\N	24	11	\N	\N	\N	\N	\N	9
630	2012-07-10 22:00:00	2012-07-10 22:00:00	\N	\N	m.ozan@sigire.fr	2012-07-11 09:52:56.335789	2012-07-11 09:52:56.335789	114	139	11	\N	\N	\N	\N	\N	10
631	2012-07-10 22:00:00	2012-07-10 22:00:00	\N	\N	g.bonvoust@sigire.fr	2012-07-11 09:57:03.342572	2012-07-11 09:57:03.342572	49	24	11	\N	\N	\N	\N	\N	9
632	2012-07-10 22:00:00	2012-07-10 22:00:00	\N	\N	g.bonvoust@sigire.fr	2012-07-11 09:59:44.972504	2012-07-11 09:59:44.972504	49	24	11	\N	\N	\N	\N	\N	9
633	2012-07-10 22:00:00	2012-07-10 22:00:00	\N	m.ozan@sigire.fr	\N	2012-07-11 12:23:00.021939	2012-07-11 12:23:00.021939	\N	145	11	\N	\N	\N	\N	\N	11
634	2012-07-10 22:00:00	2012-07-10 22:00:00	\N	m.ozan@sigire.fr	\N	2012-07-11 12:24:06.644963	2012-07-11 12:24:06.644963	\N	145	11	\N	\N	\N	\N	\N	12
635	2012-07-10 22:00:00	2012-07-10 22:00:00	\N	g.bonvoust@sigire.fr	\N	2012-07-11 12:24:07.828765	2012-07-11 12:24:07.828765	\N	24	11	\N	\N	\N	\N	\N	13
636	2012-07-10 22:00:00	2012-07-10 22:00:00	\N	g.bonvoust@sigire.fr	\N	2012-07-11 12:25:42.369259	2012-07-11 12:25:42.369259	119	145	11	\N	\N	\N	\N	\N	14
637	2012-07-10 22:00:00	2012-07-10 22:00:00	\N	\N	g.bonvoust@sigire.fr	2012-07-11 12:27:23.283192	2012-07-11 12:27:23.283192	119	145	11	\N	\N	\N	\N	\N	14
638	2012-07-10 22:00:00	2012-07-10 22:00:00	\N	\N	m.ozan@sigire.fr	2012-07-11 12:29:01.99723	2012-07-11 12:29:01.99723	\N	265	11	\N	\N	\N	\N	\N	6
639	2012-07-10 22:00:00	2012-07-10 22:00:00	\N	\N	m.ozan@sigire.fr	2012-07-11 12:29:26.756024	2012-07-11 12:29:26.756024	\N	265	11	\N	\N	\N	\N	\N	6
642	2012-07-16 22:00:00	2012-07-16 22:00:00	\N	\N	Guillaume BONVOUST	2012-07-17 08:26:32.094689	2012-07-17 08:26:32.094689	49	24	11	\N	\N	\N	\N	\N	13
643	2012-07-16 22:00:00	2012-07-16 22:00:00	\N	\N	Guillaume BONVOUST	2012-07-17 08:30:18.152576	2012-07-17 08:30:18.152576	49	24	11	\N	\N	\N	\N	\N	13
644	2012-07-18 22:00:00	2012-07-18 22:00:00	\N	Manuel OZAN	\N	2012-07-19 14:00:53.840046	2012-07-19 14:00:53.840046	50	27	11	\N	\N	\N	\N	\N	15
645	2012-07-19 14:01:00	2012-07-19 14:04:00	even. test	Manuel OZAN	\N	2012-07-19 14:01:51.895119	2012-07-19 14:01:51.895119	49	24	1	\N	\N	\N	\N	\N	16
646	2012-07-23 07:31:00	2012-07-23 07:31:00		Guillaume BONVOUST	\N	2012-07-23 08:22:07.328866	2012-07-23 08:22:07.328866	49	24	1	\N	\N	\N	\N	\N	17
647	2012-07-22 22:00:00	2012-07-22 22:00:00	\N	\N	Guillaume BONVOUST	2012-07-23 09:35:50.483407	2012-07-23 09:35:50.483407	23	17	11	\N	\N	\N	\N	\N	4
648	2012-07-22 22:00:00	2012-07-22 22:00:00	\N	\N	Guillaume BONVOUST	2012-07-23 09:39:51.223768	2012-07-23 09:39:51.223768	23	17	11	\N	\N	\N	\N	\N	4
649	2012-07-22 22:00:00	2012-07-22 22:00:00	\N	\N	Guillaume BONVOUST	2012-07-23 09:40:20.513876	2012-07-23 09:40:20.513876	23	17	11	\N	\N	\N	\N	\N	4
650	2012-07-23 09:44:00	2012-07-23 09:44:00		Guillaume BONVOUST	\N	2012-07-23 09:48:24.570744	2012-07-23 09:48:24.570744	101	17	1	\N	\N	\N	\N	\N	18
651	2012-07-23 09:48:00	2012-07-23 09:48:00		Guillaume BONVOUST	\N	2012-07-23 09:49:03.241571	2012-07-23 09:49:03.241571	101	17	1	\N	\N	\N	\N	\N	19
652	2012-07-23 22:00:00	2012-07-23 22:00:00	\N	\N	Guillaume BONVOUST	2012-07-24 14:17:12.751298	2012-07-24 14:17:12.751298	\N	0	11	\N	\N	\N	\N	\N	9
653	2012-07-23 22:00:00	2012-07-23 22:00:00	\N	\N	Guillaume BONVOUST	2012-07-24 15:37:26.591265	2012-07-24 15:37:26.591265	\N	0	11	\N	\N	\N	\N	\N	9
654	2012-07-23 22:00:00	2012-07-23 22:00:00	\N	\N	Guillaume BONVOUST	2012-07-24 15:38:12.191315	2012-07-24 15:38:12.191315	\N	0	11	\N	\N	\N	\N	\N	9
\.


--
-- Data for Name: opportunites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY opportunites (id, nom, description, statut, remarque, montant, echeance, fichier_joint_file_name, fichier_joint_content_type, fichier_joint_file_size, fichier_joint_updated_at, created_by, updated_by, created_at, updated_at, compte_id, contact_id, user_id, marge) FROM stdin;
\.


--
-- Data for Name: origines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY origines (id, nom, description, created_by, updated_by, created_at, updated_at) FROM stdin;
1	GO2MM	Test	Guillaume BONVOUST	\N	2012-07-23 15:41:05.511612	2012-07-23 15:41:05.511612
2	INTERNE		Manuel OZAN	\N	2012-07-23 16:01:24.722167	2012-07-23 16:01:24.722167
\.


--
-- Data for Name: produits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY produits (id, nom, description, created_by, updated_by, created_at, updated_at) FROM stdin;
1	VMware	VMware C'est bien !	m.ozan@sigire.fr	\N	2012-06-29 14:13:51.712947	2012-06-29 14:13:51.712947
2	Accès SDSL	Liaison INTERNET SDSL	m.ozan@sigire.fr	\N	2012-06-29 21:44:04.565922	2012-06-29 21:44:04.565922
3	Accès AFTTB	Liaison INTERNET AFTTB.	m.ozan@sigire.fr	\N	2012-06-29 21:44:20.640636	2012-06-29 21:44:20.640636
4	Gestion SAGE	Compta / Gestion / Paie...	m.ozan@sigire.fr	\N	2012-06-29 21:44:39.502524	2012-06-29 21:44:39.502524
5	Téléphonie mobile	offres de téléphonie mobile en partenariat avec Future Telecom.	m.ozan@sigire.fr	\N	2012-06-30 09:01:24.482045	2012-06-30 09:01:24.482045
6	Téléphonie CENTREX	Le serveur IPBX est hébergé dans le DATACENTER de SIGIRE.	m.ozan@sigire.fr	m.ozan@sigire.fr	2012-07-02 14:39:58.798638	2012-07-02 14:40:36.037596
7	Hébergement Web	Serveur LAMP (Linux, Apache, MySQL et PHP).	m.ozan@sigire.fr	\N	2012-07-02 14:41:28.480911	2012-07-02 14:41:28.480911
8	Produit test		m.ozan@sigire.fr	\N	2012-07-14 20:09:36.733405	2012-07-14 20:09:36.733405
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY schema_migrations (version) FROM stdin;
20120218071616
20120218071940
20120218072017
20120218072036
20120218072103
20120218075659
20120227190442
20120227200451
20120227200452
20120322213445
20120428160402
20120513053831
20120621143121
20120627122129
20120627151302
20120628092714
20120702153424
20120705093257
20120717084452
20120720134635
20120723124706
20120723151416
20120723152354
\.


--
-- Data for Name: taches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY taches (id, notes, statut, created_at, created_by, modified_at, modified_by, updated_at, contact_id, compte_id, user_id, echeance, fichier_joint_file_name, fichier_joint_content_type, fichier_joint_file_size, fichier_joint_updated_at) FROM stdin;
6	Ceci est une tâche bidon.	Terminé	2012-07-10 08:36:22.747355	m.ozan@sigire.fr	\N	m.ozan@sigire.fr	2012-07-11 12:29:26.551723	\N	265	4	2012/07/20	Capture_VEEAMZip_MRS.PNG	image/png	151807	2012-07-10 08:42:36.37281
2	test tache	A faire	2012-07-02 07:52:41.617374	g.bonvoust@sigire.fr	\N	g.bonvoust@sigire.fr	2012-07-02 12:48:17.513063	271	266	7	2012/07/12	\N	\N	\N	\N
13	test nom collaborateur	A faire	2012-07-11 12:24:07.673401	g.bonvoust@sigire.fr	\N	Guillaume BONVOUST	2012-07-17 08:30:17.793893	49	24	7	2012/07/12	\N	\N	\N	\N
15	Tache test	A faire	2012-07-19 14:00:53.447853	Manuel OZAN	\N	Manuel OZAN	2012-07-19 14:00:53.447853	50	27	4	2012/07/04	Capture.PNG	image/png	2291	2012-07-19 14:00:53.445781
16	Tâche test	A faire	2012-07-19 14:01:51.878881	Manuel OZAN	\N	\N	2012-07-19 14:01:51.878881	49	24	4	2012/07/14	\N	\N	\N	\N
1	Ma première tâche !\r\nModification faite sur iPad :)\r\nModification le 20120702 à 10h02	Terminé	2012-06-29 15:12:36.88044	m.ozan@sigire.fr	\N	m.ozan@sigire.fr	2012-07-02 19:48:37.955295	232	230	4	2012/06/30	\N	\N	\N	\N
3	test num 2	Annulé	2012-07-02 10:14:41.545868	g.bonvoust@sigire.fr	\N	m.ozan@sigire.fr	2012-07-02 20:18:02.362041	273	266	4	2012/07/29	\N	\N	\N	\N
17	Test mailing création d'une tâche depuis un événement	A faire	2012-07-23 08:22:06.919617	Guillaume BONVOUST	\N	\N	2012-07-23 08:22:06.919617	49	24	7	2012/07/23	\N	\N	\N	\N
4	test checkbox mail + ajout echeance	En cours	2012-07-02 14:10:05.806719	g.bonvoust@sigire.fr	\N	Guillaume BONVOUST	2012-07-23 09:40:20.496992	23	17	7	2012/07/25	\N	\N	\N	\N
18	RAAAAAAAAAAAAAAAAAAAAH !	A faire	2012-07-23 09:48:24.553224	Guillaume BONVOUST	\N	\N	2012-07-23 09:48:24.553224	101	17	7	2012/07/25	\N	\N	\N	\N
19	RAAAAAAAAAAAAAAAH ! (avec mail !)	A faire	2012-07-23 09:49:02.935208	Guillaume BONVOUST	\N	\N	2012-07-23 09:49:02.935208	101	17	7	2012/07/28	\N	\N	\N	\N
5	Mise en service des sites Web : Habrial et Auto équipement.\r\nwww.google.fr	Terminé	2012-07-02 16:23:19.045749	m.ozan@sigire.fr	\N	m.ozan@sigire.fr	2012-07-10 20:11:09.647661	20	17	4	2012/07/13	\N	\N	\N	\N
7	Faire "plein de chose"...	En cours	2012-07-10 08:56:43.609648	m.ozan@sigire.fr	\N	m.ozan@sigire.fr	2012-07-10 20:21:13.849824	101	17	4	2012/07/14	\N	\N	\N	\N
9	test mail edition	En cours	2012-07-11 09:14:09.66842	g.bonvoust@sigire.fr	\N	Guillaume BONVOUST	2012-07-24 14:17:12.270115	\N	0	7	2012/07/12	\N	\N	\N	\N
10	Test Mailing !\r\nModification de la tâche...	En cours	2012-07-11 09:18:55.137215	m.ozan@sigire.fr	\N	m.ozan@sigire.fr	2012-07-11 09:52:56.206893	114	139	4	2012/07/14	pc.nfo	application/octet-stream	1489886	2012-07-11 09:18:55.135984
11	Communiquer à Manuel les répertoires à sauvegarder sur notre serveur de Backup chez OVH !	A faire	2012-07-11 12:22:59.823709	m.ozan@sigire.fr	\N	m.ozan@sigire.fr	2012-07-11 12:22:59.823709	\N	145	1		\N	\N	\N	\N
\.


--
-- Data for Name: types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY types (id, libelle, direction, created_by, modified_by, created_at, updated_at) FROM stdin;
1	Appel téléphonique	entrant	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-15 10:33:08.22007	2012-04-15 10:33:08.22007
2	Appel téléphonique	sortant	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-15 10:33:38.02688	2012-04-15 10:33:38.02688
3	E-mail	entrant	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-15 13:01:29.447877	2012-04-15 13:01:29.447877
4	E-mail	sortant	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-15 13:03:32.694024	2012-04-15 13:03:32.694024
5	Appel téléphonique	interne	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-15 13:05:46.611224	2012-04-15 13:05:46.611224
6	E-mail	interne	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-15 13:06:46.366424	2012-04-15 13:06:46.366424
7	Courrier	entrant	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-15 13:52:02.964634	2012-04-15 13:52:02.964634
8	Courrier	sortant	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-15 13:53:41.930704	2012-04-15 13:53:41.930704
9	Rendez-vous	sortant	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-15 14:10:43.425724	2012-04-15 14:10:43.425724
10	Rendez-vous	entrant	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-15 14:12:04.549669	2012-04-15 14:12:04.549669
11	Intervention technique	sur site	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-15 18:49:37.556324	2012-04-15 18:49:37.556324
12	Intervention technique	en atelier	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-15 18:49:58.597076	2012-04-15 18:49:58.597076
13	Intervention technique	à distance	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-15 18:50:18.481029	2012-04-15 18:50:18.481029
14	Télécopie	entrante	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-15 19:33:23.003184	2012-04-15 19:33:23.003184
15	Télécopie	sortante	g.forestier@sigire.fr	g.forestier@sigire.fr	2012-04-15 19:33:32.153295	2012-04-15 19:33:32.153295
16	Tâche	Interne	g.bonvoust@sigire.fr	g.bonvoust@sigire.fr	2012-07-10 10:12:50.682462	2012-07-10 10:12:50.682462
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, prenom, nom, tel, mobile, created_at, updated_at) FROM stdin;
7	g.bonvoust@sigire.fr	$2a$10$L6Ynmo/jYdR3Vt3JwfGxauJWboufs5J02iRjUHrQQn.0m8NdJJGu6	\N	\N	2012-07-24 14:16:31.573085	49	2012-07-24 14:16:31.590676	2012-07-24 10:07:39.960939	46.226.131.55	46.226.131.55	Guillaume	BONVOUST	02 43 44 45 46	06 45 60 12 63	2012-06-08 07:41:06.420193	2012-07-24 14:16:31.591247
3	n.retout@sigire.fr	$2a$10$oiDvji78A5JJeBtMLVkfCu/conFGwr.eUFq12zeuND9yvELg54I2C	\N	\N	\N	50	2012-06-28 06:56:09.685336	2012-06-27 07:03:38.937108	46.226.131.55	46.226.131.55	Nicolas	RETOUT	\N	\N	2012-04-16 07:20:17.055997	2012-06-28 06:56:09.686215
5	i.moison@sigire.fr	$2a$10$tH766iuKyZjklK1iuzyoyeAyvFbuf0wQN0h9HvZ.FVrP5f2/3I4ai	\N	\N	\N	21	2012-06-28 10:09:26.631183	2012-06-27 14:00:08.992384	46.226.131.55	46.226.131.55	Isabelle	MOISON	\N	\N	2012-04-17 07:16:22.802095	2012-06-28 10:09:26.632005
2	g.guivarch@sigire.fr	$2a$10$YAfe5Hl9.xt/b75bzb7pwOvVE2op5UolM94xR1a2QC5H4dyDG1I5m		\N	2012-06-27 12:20:00.150281	18	2012-06-27 12:20:00.165507	2012-06-04 08:46:47.182886	46.226.131.55	46.226.131.55	Gilles	GUIVARCH	\N	\N	2012-04-15 19:26:20.392962	2012-06-27 12:20:00.166012
1	g.forestier@sigire.fr	$2a$10$K9VelS4B0MAY2Zk72mYhuOhlCFrKxpsNgaqKt0wBs6BI2CGgqPUPq	\N	\N	\N	89	2012-07-23 10:14:43.895588	2012-07-20 21:19:41.571935	92.90.21.5	88.161.55.104	Gabriel	FORESTIER	\N	\N	2012-04-15 09:51:47.407242	2012-07-23 10:14:43.896693
4	m.ozan@sigire.fr	$2a$10$yG0HQKzO20nouxFd8lQ3PuBJe9zjHH.XDRvD3DwV4tKY8bDy0Pfee	\N	\N	\N	196	2012-07-24 08:10:31.100888	2012-07-23 21:33:22.573065	46.226.131.55	88.165.75.71	Manuel	OZAN	101	06 20 60 76 58	2012-04-16 07:57:03.141137	2012-07-24 08:10:31.102097
\.


--
-- Name: admin_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY active_admin_comments
    ADD CONSTRAINT admin_notes_pkey PRIMARY KEY (id);


--
-- Name: admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: comptes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY comptes
    ADD CONSTRAINT comptes_pkey PRIMARY KEY (id);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: evenements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY evenements
    ADD CONSTRAINT evenements_pkey PRIMARY KEY (id);


--
-- Name: opportunitees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY opportunites
    ADD CONSTRAINT opportunitees_pkey PRIMARY KEY (id);


--
-- Name: origines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY origines
    ADD CONSTRAINT origines_pkey PRIMARY KEY (id);


--
-- Name: produits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY produits
    ADD CONSTRAINT produits_pkey PRIMARY KEY (id);


--
-- Name: taches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taches
    ADD CONSTRAINT taches_pkey PRIMARY KEY (id);


--
-- Name: types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY types
    ADD CONSTRAINT types_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_active_admin_comments_on_author_type_and_author_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_author_type_and_author_id ON active_admin_comments USING btree (author_type, author_id);


--
-- Name: index_active_admin_comments_on_namespace; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_namespace ON active_admin_comments USING btree (namespace);


--
-- Name: index_admin_notes_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX index_admin_notes_on_resource_type_and_resource_id ON active_admin_comments USING btree (resource_type, resource_id);


--
-- Name: index_admin_users_on_email; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_admin_users_on_email ON admin_users USING btree (email);


--
-- Name: index_admin_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_admin_users_on_reset_password_token ON admin_users USING btree (reset_password_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


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

\connect postgres

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

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

\connect template1

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template database';


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

--
-- PostgreSQL database cluster dump complete
--

