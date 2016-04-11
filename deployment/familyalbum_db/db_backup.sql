--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: familyalbum_dev; Type: DATABASE; Schema: -; Owner: jamesb0nd
--

CREATE DATABASE familyalbum_dev WITH TEMPLATE = template0 ENCODING = 'SQL_ASCII' LC_COLLATE = 'C' LC_CTYPE = 'C';


ALTER DATABASE familyalbum_dev OWNER TO jamesb0nd;

\connect familyalbum_dev

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'SQL_ASCII';
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

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: jamesb0nd; Tablespace: 
--

CREATE TABLE alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE alembic_version OWNER TO jamesb0nd;

--
-- Name: country; Type: TABLE; Schema: public; Owner: jamesb0nd; Tablespace: 
--

CREATE TABLE country (
    id character varying NOT NULL,
    name character varying
);


ALTER TABLE country OWNER TO jamesb0nd;

--
-- Name: country_dvellers; Type: TABLE; Schema: public; Owner: jamesb0nd; Tablespace: 
--

CREATE TABLE country_dvellers (
    country_id character varying,
    person_id character varying
);


ALTER TABLE country_dvellers OWNER TO jamesb0nd;

--
-- Name: family; Type: TABLE; Schema: public; Owner: jamesb0nd; Tablespace: 
--

CREATE TABLE family (
    id character varying NOT NULL,
    creator_id character varying
);


ALTER TABLE family OWNER TO jamesb0nd;

--
-- Name: family_members; Type: TABLE; Schema: public; Owner: jamesb0nd; Tablespace: 
--

CREATE TABLE family_members (
    family_id character varying,
    person_id character varying
);


ALTER TABLE family_members OWNER TO jamesb0nd;

--
-- Name: family_possible_members; Type: TABLE; Schema: public; Owner: jamesb0nd; Tablespace: 
--

CREATE TABLE family_possible_members (
    family_id character varying,
    possible_member_id character varying
);


ALTER TABLE family_possible_members OWNER TO jamesb0nd;

--
-- Name: legend; Type: TABLE; Schema: public; Owner: jamesb0nd; Tablespace: 
--

CREATE TABLE legend (
    id character varying NOT NULL,
    text text
);


ALTER TABLE legend OWNER TO jamesb0nd;

--
-- Name: legendparticipant; Type: TABLE; Schema: public; Owner: jamesb0nd; Tablespace: 
--

CREATE TABLE legendparticipant (
    person_id character varying,
    legend_id character varying
);


ALTER TABLE legendparticipant OWNER TO jamesb0nd;

--
-- Name: message; Type: TABLE; Schema: public; Owner: jamesb0nd; Tablespace: 
--

CREATE TABLE message (
    id character varying NOT NULL,
    subject character varying,
    text text,
    acknowledged boolean
);


ALTER TABLE message OWNER TO jamesb0nd;

--
-- Name: person; Type: TABLE; Schema: public; Owner: jamesb0nd; Tablespace: 
--

CREATE TABLE person (
    id character varying NOT NULL,
    name character varying,
    second_name character varying,
    surname character varying,
    sex character varying,
    alive boolean,
    b_date date,
    d_date date,
    ava_id character varying,
    father_id character varying,
    mother_id character varying,
    description character varying,
    maiden_surname character varying
);


ALTER TABLE person OWNER TO jamesb0nd;

--
-- Name: photo; Type: TABLE; Schema: public; Owner: jamesb0nd; Tablespace: 
--

CREATE TABLE photo (
    id character varying NOT NULL,
    description text,
    path character varying,
    large_thumbnail_path character varying,
    small_thumbnail_path character varying
);


ALTER TABLE photo OWNER TO jamesb0nd;

--
-- Name: photoparticipant; Type: TABLE; Schema: public; Owner: jamesb0nd; Tablespace: 
--

CREATE TABLE photoparticipant (
    person_id character varying,
    photo_id character varying
);


ALTER TABLE photoparticipant OWNER TO jamesb0nd;

--
-- Name: spouses; Type: TABLE; Schema: public; Owner: jamesb0nd; Tablespace: 
--

CREATE TABLE spouses (
    leftspouse_id character varying,
    rightspouse_id character varying
);


ALTER TABLE spouses OWNER TO jamesb0nd;

--
-- Name: usermessages; Type: TABLE; Schema: public; Owner: jamesb0nd; Tablespace: 
--

CREATE TABLE usermessages (
    user_id character varying,
    message_id character varying
);


ALTER TABLE usermessages OWNER TO jamesb0nd;

--
-- Name: users; Type: TABLE; Schema: public; Owner: jamesb0nd; Tablespace: 
--

CREATE TABLE users (
    id character varying NOT NULL,
    email character varying,
    password_hash character varying(128),
    name character varying,
    second_name character varying,
    surname character varying,
    sex character varying,
    country_id character varying,
    b_date date,
    person_id character varying,
    is_new boolean,
    confirmed boolean
);


ALTER TABLE users OWNER TO jamesb0nd;

--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: jamesb0nd
--

COPY alembic_version (version_num) FROM stdin;
ef86598b14db
\.


--
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: jamesb0nd
--

COPY country (id, name) FROM stdin;
0	Afghanistan
1	Albania
2	Algeria
3	American Samoa
4	Andorra
5	Angola
6	Anguilla
7	Antarctica
8	Antigua and Barbuda
9	Argentina
10	Armenia
11	Aruba
12	Ascension and Tristan Da Cunha Saint Helena
13	Australia
14	Austria
15	Azerbaijan
16	Bahamas
17	Bahrain
18	Bangladesh
19	Barbados
20	Belarus
21	Belgium
22	Belize
23	Benin
24	Bermuda
25	Bhutan
26	Bolivarian Republic of Venezuela
27	Bolivia, Plurinational State of
28	Bonaire, Sint Eustatius and Saba
29	Bosnia and Herzegovina
30	Botswana
31	Bouvet Island
32	Brazil
33	British Indian Ocean Territory
34	British Virgin Islands
35	Brunei Darussalam
36	Bulgaria
37	Burkina Faso
38	Burundi
39	Cambodia
40	Cameroon
41	Canada
42	Cape Verde
43	Cayman Islands
44	Central African Republic
45	Chad
46	Chile
47	China
48	Christmas Island
49	Cocos (Keeling) Islands
50	Colombia
51	Comoros
52	Congo
53	Congo, The Democratic Republic of the
54	Cook Islands
55	Costa Rica
56	Croatia
57	Cuba
58	Curaçao
59	Cyprus
60	Czech Republic
61	Côte D'ivoire
62	Democratic People's Republic of Korea
63	Denmark
64	Djibouti
65	Dominica
66	Dominican Republic
67	Ecuador
68	Egypt
69	El Salvador
70	Equatorial Guinea
71	Eritrea
72	Estonia
73	Ethiopia
74	Falkland Islands (Malvinas)
75	Faroe Islands
76	Federated States of Micronesia
77	Fiji
78	Finland
79	France
80	French Guiana
81	French Polynesia
82	French Southern Territories
83	Gabon
84	Gambia
85	Georgia
86	Germany
87	Ghana
88	Gibraltar
89	Greece
90	Greenland
91	Grenada
92	Guadeloupe
93	Guam
94	Guatemala
95	Guernsey
96	Guinea
97	Guinea-bissau
98	Guyana
99	Haiti
100	Heard Island and McDonald Islands
101	Holy See (Vatican City State)
102	Honduras
103	Hong Kong
104	Hungary
105	Iceland
106	India
107	Indonesia
108	Iran, Islamic Republic of
109	Iraq
110	Ireland
111	Islamic Republic of Iran
112	Isle of Man
113	Israel
114	Italy
115	Jamaica
116	Japan
117	Jersey
118	Jordan
119	Kazakhstan
120	Kenya
121	Kiribati
122	Korea, Democratic People's Republic of
123	Korea, Republic of
124	Kuwait
125	Kyrgyzstan
126	Lao People's Democratic Republic
127	Latvia
128	Lebanon
129	Lesotho
130	Liberia
131	Libya
132	Liechtenstein
133	Lithuania
134	Luxembourg
135	Macao
136	Macedonia, The Former Yugoslav Republic of
137	Madagascar
138	Malawi
139	Malaysia
140	Maldives
141	Mali
142	Malta
143	Marshall Islands
144	Martinique
145	Mauritania
146	Mauritius
147	Mayotte
148	Mexico
149	Micronesia, Federated States of
150	Moldova, Republic of
151	Monaco
152	Mongolia
153	Montenegro
154	Montserrat
155	Morocco
156	Mozambique
157	Myanmar
158	Namibia
159	Nauru
160	Nepal
161	Netherlands
162	New Caledonia
163	New Zealand
164	Nicaragua
165	Niger
166	Nigeria
167	Niue
168	Norfolk Island
169	Northern Mariana Islands
170	Norway
171	Occupied Palestinian Territory
172	Oman
173	Pakistan
174	Palau
175	Palestinian Territory, Occupied
176	Panama
177	Papua New Guinea
178	Paraguay
179	Peru
180	Philippines
181	Pitcairn
182	Plurinational State of Bolivia
183	Poland
184	Portugal
185	Province of China Taiwan
186	Puerto Rico
187	Qatar
188	Republic of Korea
189	Republic of Moldova
190	Romania
191	Russian Federation
192	Rwanda
193	Réunion
194	Saint Barthélemy
195	Saint Helena, Ascension and Tristan Da Cunha
196	Saint Kitts and Nevis
197	Saint Lucia
198	Saint Martin (French Part)
199	Saint Pierre and Miquelon
200	Saint Vincent and the Grenadines
201	Samoa
202	San Marino
203	Sao Tome and Principe
204	Saudi Arabia
205	Senegal
206	Serbia
207	Seychelles
208	Sierra Leone
209	Singapore
210	Sint Eustatius and Saba Bonaire
211	Sint Maarten (Dutch Part)
212	Slovakia
213	Slovenia
214	Solomon Islands
215	Somalia
216	South Africa
217	South Georgia and the South Sandwich Islands
218	South Sudan
219	Spain
220	Sri Lanka
221	Sudan
222	Suriname
223	Svalbard and Jan Mayen
224	Swaziland
225	Sweden
226	Switzerland
227	Syrian Arab Republic
228	Taiwan, Province of China
229	Tajikistan
230	Tanzania, United Republic of
231	Thailand
232	The Democratic Republic of the Congo
233	The Former Yugoslav Republic of Macedonia
234	Timor-leste
235	Togo
236	Tokelau
237	Tonga
238	Trinidad and Tobago
239	Tunisia
240	Turkey
241	Turkmenistan
242	Turks and Caicos Islands
243	Tuvalu
244	U.S. Virgin Islands
245	Uganda
246	Ukraine
247	United Arab Emirates
248	United Kingdom
249	United Republic of Tanzania
250	United States
251	United States Minor Outlying Islands
252	Uruguay
253	Uzbekistan
254	Vanuatu
255	Venezuela, Bolivarian Republic of
256	Viet Nam
257	Virgin Islands, British
258	Virgin Islands, U.S.
259	Wallis and Futuna
260	Western Sahara
261	Yemen
262	Zambia
263	Zimbabwe
264	Åland Islands
\.


--
-- Data for Name: country_dvellers; Type: TABLE DATA; Schema: public; Owner: jamesb0nd
--

COPY country_dvellers (country_id, person_id) FROM stdin;
191	59794800f91d11e580960242ac110003
191	3326e014f92111e5be8b0242ac110003
191	b4454d70f92111e5be8b0242ac110003
191	d085ed2ef92a11e582a60242ac110003
191	0dd32fa2f92b11e582a60242ac110003
60	06672b8cf92c11e593dc0242ac110003
191	4b8c0d8cf9df11e5b5040242ac110003
191	e4c100e0fc3011e595830242ac110003
191	da9a8a9afc3111e595830242ac110003
191	55a741f6fc3211e595830242ac110003
20	ee3a3c54fc3511e58c380242ac110003
191	ee3a3c54fc3511e58c380242ac110003
20	371b159cfc3611e58c380242ac110003
191	371b159cfc3611e58c380242ac110003
191	a9345314fcc211e5a78c0242ac11001c
191	46101992fcc411e5a78c0242ac11001c
191	b29ab826fdc611e5a4220242ac11001c
191	a8595444ff2911e58b940242ac11001c
191	387bc30eff2a11e58b940242ac11001c
191	93587948ff2a11e58b940242ac11001c
191	b9a30aecff2e11e58b940242ac11001c
\.


--
-- Data for Name: family; Type: TABLE DATA; Schema: public; Owner: jamesb0nd
--

COPY family (id, creator_id) FROM stdin;
59a5cc9af91d11e580960242ac110003	f68133caf91c11e580960242ac110003
a88bac8cff2911e58b940242ac11001c	ff69898aff2811e58b940242ac11001c
\.


--
-- Data for Name: family_members; Type: TABLE DATA; Schema: public; Owner: jamesb0nd
--

COPY family_members (family_id, person_id) FROM stdin;
59a5cc9af91d11e580960242ac110003	59794800f91d11e580960242ac110003
59a5cc9af91d11e580960242ac110003	3326e014f92111e5be8b0242ac110003
59a5cc9af91d11e580960242ac110003	b4454d70f92111e5be8b0242ac110003
59a5cc9af91d11e580960242ac110003	d085ed2ef92a11e582a60242ac110003
59a5cc9af91d11e580960242ac110003	0dd32fa2f92b11e582a60242ac110003
59a5cc9af91d11e580960242ac110003	06672b8cf92c11e593dc0242ac110003
59a5cc9af91d11e580960242ac110003	4b8c0d8cf9df11e5b5040242ac110003
59a5cc9af91d11e580960242ac110003	e4c100e0fc3011e595830242ac110003
59a5cc9af91d11e580960242ac110003	da9a8a9afc3111e595830242ac110003
59a5cc9af91d11e580960242ac110003	55a741f6fc3211e595830242ac110003
59a5cc9af91d11e580960242ac110003	ee3a3c54fc3511e58c380242ac110003
59a5cc9af91d11e580960242ac110003	371b159cfc3611e58c380242ac110003
59a5cc9af91d11e580960242ac110003	a9345314fcc211e5a78c0242ac11001c
59a5cc9af91d11e580960242ac110003	46101992fcc411e5a78c0242ac11001c
59a5cc9af91d11e580960242ac110003	b29ab826fdc611e5a4220242ac11001c
a88bac8cff2911e58b940242ac11001c	a8595444ff2911e58b940242ac11001c
a88bac8cff2911e58b940242ac11001c	387bc30eff2a11e58b940242ac11001c
a88bac8cff2911e58b940242ac11001c	93587948ff2a11e58b940242ac11001c
59a5cc9af91d11e580960242ac110003	b9a30aecff2e11e58b940242ac11001c
\.


--
-- Data for Name: family_possible_members; Type: TABLE DATA; Schema: public; Owner: jamesb0nd
--

COPY family_possible_members (family_id, possible_member_id) FROM stdin;
\.


--
-- Data for Name: legend; Type: TABLE DATA; Schema: public; Owner: jamesb0nd
--

COPY legend (id, text) FROM stdin;
\.


--
-- Data for Name: legendparticipant; Type: TABLE DATA; Schema: public; Owner: jamesb0nd
--

COPY legendparticipant (person_id, legend_id) FROM stdin;
\.


--
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: jamesb0nd
--

COPY message (id, subject, text, acknowledged) FROM stdin;
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: jamesb0nd
--

COPY person (id, name, second_name, surname, sex, alive, b_date, d_date, ava_id, father_id, mother_id, description, maiden_surname) FROM stdin;
da9a8a9afc3111e595830242ac110003	Галина	Александровна	Березюк	female	f	1920-01-01	2010-01-01	da98947efc3111e595830242ac110003.jpeg	\N	\N	\N	\N
55a741f6fc3211e595830242ac110003	Илья	Моисеевич	Явиц	male	f	1919-01-01	1941-09-01	55a6e300fc3211e595830242ac110003.jpeg	\N	\N	\N	\N
e4c100e0fc3011e595830242ac110003	Людмила	Ильинична	Фаянс	female	f	1941-08-12	2015-06-07	e4c02b84fc3011e595830242ac110003.jpeg	55a741f6fc3211e595830242ac110003	da9a8a9afc3111e595830242ac110003	\N	Явиц
ee3a3c54fc3511e58c380242ac110003	Григорий	Кивович	Фаянс	male	f	1905-01-01	1965-01-01	ee39afa0fc3511e58c380242ac110003.jpeg	\N	\N	\N	\N
371b159cfc3611e58c380242ac110003	Виктория	Антоновна	Фаянс	female	f	1905-01-01	1959-01-01	371a4996fc3611e58c380242ac110003.jpeg	\N	\N	\N	\N
4b8c0d8cf9df11e5b5040242ac110003	Олег	Григорьевич	Фаянс	male	f	1927-08-30	2002-10-07	4b8bf1e4f9df11e5b5040242ac110003.jpg	ee3a3c54fc3511e58c380242ac110003	371b159cfc3611e58c380242ac110003	\N	\N
06672b8cf92c11e593dc0242ac110003	Евгений	Олегович	Фаянс	male	t	2013-04-20	\N	2cbb2de2f92c11e593dc0242ac110003.jpg	59794800f91d11e580960242ac110003	\N	\N	\N
3326e014f92111e5be8b0242ac110003	Юрий	Олегович	Фаянс	male	t	1956-02-05	\N	3326c6baf92111e5be8b0242ac110003.jpg	4b8c0d8cf9df11e5b5040242ac110003	\N	\N	\N
b4454d70f92111e5be8b0242ac110003	Инна	Олеговна	Юрганова	female	t	1967-03-31	\N	b4453952f92111e5be8b0242ac110003.jpg	4b8c0d8cf9df11e5b5040242ac110003	\N	\N	Фаянс
59794800f91d11e580960242ac110003	Олег	Олегович	Фаянс	male	t	1979-05-17	\N	5978d38ef91d11e580960242ac110003.JPG	4b8c0d8cf9df11e5b5040242ac110003	e4c100e0fc3011e595830242ac110003	\N	\N
a9345314fcc211e5a78c0242ac11001c	Владимир	Григорьевич	Фаянс	male	t	1937-11-10	\N	a9343d7afcc211e5a78c0242ac11001c.jpeg	ee3a3c54fc3511e58c380242ac110003	371b159cfc3611e58c380242ac110003	\N	\N
46101992fcc411e5a78c0242ac11001c	Елена	Григорьевна	Юшина	female	t	1930-10-05	\N	460ffb88fcc411e5a78c0242ac11001c.jpeg	ee3a3c54fc3511e58c380242ac110003	371b159cfc3611e58c380242ac110003	\N	Фаянс
b29ab826fdc611e5a4220242ac11001c	Лариса	Алексеевна	Фаянс	female	t	1957-02-26	\N	b29aa6e2fdc611e5a4220242ac11001c.jpg	\N	\N	\N	Цветкова
d085ed2ef92a11e582a60242ac110003	Алексей	Юрьевич	Фаянс	male	t	1982-04-10	\N	d085d992f92a11e582a60242ac110003.jpg	3326e014f92111e5be8b0242ac110003	b29ab826fdc611e5a4220242ac11001c	\N	\N
0dd32fa2f92b11e582a60242ac110003	Сергей	Юрьевич	Фаянс	male	t	1986-06-23	\N	0dd3158af92b11e582a60242ac110003.jpg	3326e014f92111e5be8b0242ac110003	b29ab826fdc611e5a4220242ac11001c	\N	\N
387bc30eff2a11e58b940242ac11001c	Тамара	Гертрудовна	Злобина	female	t	1950-10-18	\N	387bae96ff2a11e58b940242ac11001c.jpg	\N	\N	\N	Созинова
a8595444ff2911e58b940242ac11001c	Мария	Владимировна	Злобина	female	t	1981-07-21	\N	a859424cff2911e58b940242ac11001c.jpg	93587948ff2a11e58b940242ac11001c	387bc30eff2a11e58b940242ac11001c	\N	\N
93587948ff2a11e58b940242ac11001c	Владимир	Александрович	Злобин	male	t	1951-06-12	\N	\N	\N	\N	\N	\N
b9a30aecff2e11e58b940242ac11001c	Григорий	Владимирович	Фаянс	male	t	1976-01-01	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: photo; Type: TABLE DATA; Schema: public; Owner: jamesb0nd
--

COPY photo (id, description, path, large_thumbnail_path, small_thumbnail_path) FROM stdin;
5978d38ef91d11e580960242ac110003.JPG	\N	/data/photos/5978d38ef91d11e580960242ac110003.JPG	/data/thumbnails/photos/5978d38ef91d11e580960242ac110003_400x400_85.JPG	/data/thumbnails/photos/5978d38ef91d11e580960242ac110003_200x200_85.JPG
3326c6baf92111e5be8b0242ac110003.jpg	\N	/data/photos/3326c6baf92111e5be8b0242ac110003.jpg	/data/thumbnails/photos/3326c6baf92111e5be8b0242ac110003_400x400_85.jpg	/data/thumbnails/photos/3326c6baf92111e5be8b0242ac110003_200x200_85.jpg
6a6e4d6ef92111e5be8b0242ac110003.jpg	\N	/data/photos/6a6e4d6ef92111e5be8b0242ac110003.jpg	/data/thumbnails/photos/6a6e4d6ef92111e5be8b0242ac110003_400x400_85.jpg	/data/thumbnails/photos/6a6e4d6ef92111e5be8b0242ac110003_200x200_85.jpg
b4453952f92111e5be8b0242ac110003.jpg	\N	/data/photos/b4453952f92111e5be8b0242ac110003.jpg	/data/thumbnails/photos/b4453952f92111e5be8b0242ac110003_400x400_85.jpg	/data/thumbnails/photos/b4453952f92111e5be8b0242ac110003_200x200_85.jpg
8c420c8ef92411e5ba070242ac110003.jpg	\N	/data/photos/8c420c8ef92411e5ba070242ac110003.jpg	/data/thumbnails/photos/8c420c8ef92411e5ba070242ac110003_400x400_85.jpg	/data/thumbnails/photos/8c420c8ef92411e5ba070242ac110003_200x200_85.jpg
32d835a0f92511e5a08b0242ac110003.jpg	\N	/data/photos/32d835a0f92511e5a08b0242ac110003.jpg	/data/thumbnails/photos/32d835a0f92511e5a08b0242ac110003_400x400_85.jpg	/data/thumbnails/photos/32d835a0f92511e5a08b0242ac110003_200x200_85.jpg
a3ce8704f92611e59b0e0242ac110003.jpg	\N	/data/photos/a3ce8704f92611e59b0e0242ac110003.jpg	/data/thumbnails/photos/a3ce8704f92611e59b0e0242ac110003_400x400_85.jpg	/data/thumbnails/photos/a3ce8704f92611e59b0e0242ac110003_200x200_85.jpg
d085d992f92a11e582a60242ac110003.jpg	\N	/data/photos/d085d992f92a11e582a60242ac110003.jpg	/data/thumbnails/photos/d085d992f92a11e582a60242ac110003_400x400_85.jpg	/data/thumbnails/photos/d085d992f92a11e582a60242ac110003_200x200_85.jpg
0dd3158af92b11e582a60242ac110003.jpg	\N	/data/photos/0dd3158af92b11e582a60242ac110003.jpg	/data/thumbnails/photos/0dd3158af92b11e582a60242ac110003_400x400_85.jpg	/data/thumbnails/photos/0dd3158af92b11e582a60242ac110003_200x200_85.jpg
2cbb2de2f92c11e593dc0242ac110003.jpg	\N	/data/photos/2cbb2de2f92c11e593dc0242ac110003.jpg	/data/thumbnails/photos/2cbb2de2f92c11e593dc0242ac110003_400x400_85.jpg	/data/thumbnails/photos/2cbb2de2f92c11e593dc0242ac110003_200x200_85.jpg
4b8bf1e4f9df11e5b5040242ac110003.jpg	\N	/data/photos/4b8bf1e4f9df11e5b5040242ac110003.jpg	/data/thumbnails/photos/4b8bf1e4f9df11e5b5040242ac110003_400x400_85.jpg	/data/thumbnails/photos/4b8bf1e4f9df11e5b5040242ac110003_200x200_85.jpg
e4c02b84fc3011e595830242ac110003.jpeg	\N	/data/photos/e4c02b84fc3011e595830242ac110003.jpeg	/data/thumbnails/photos/e4c02b84fc3011e595830242ac110003_400x400_85.jpeg	/data/thumbnails/photos/e4c02b84fc3011e595830242ac110003_200x200_85.jpeg
da98947efc3111e595830242ac110003.jpeg	\N	/data/photos/da98947efc3111e595830242ac110003.jpeg	/data/thumbnails/photos/da98947efc3111e595830242ac110003_400x400_85.jpeg	/data/thumbnails/photos/da98947efc3111e595830242ac110003_200x200_85.jpeg
55a6e300fc3211e595830242ac110003.jpeg	\N	/data/photos/55a6e300fc3211e595830242ac110003.jpeg	/data/thumbnails/photos/55a6e300fc3211e595830242ac110003_400x400_85.jpeg	/data/thumbnails/photos/55a6e300fc3211e595830242ac110003_200x200_85.jpeg
ee39afa0fc3511e58c380242ac110003.jpeg	\N	/data/photos/ee39afa0fc3511e58c380242ac110003.jpeg	/data/thumbnails/photos/ee39afa0fc3511e58c380242ac110003_400x400_85.jpeg	/data/thumbnails/photos/ee39afa0fc3511e58c380242ac110003_200x200_85.jpeg
371a4996fc3611e58c380242ac110003.jpeg	\N	/data/photos/371a4996fc3611e58c380242ac110003.jpeg	/data/thumbnails/photos/371a4996fc3611e58c380242ac110003_400x400_85.jpeg	/data/thumbnails/photos/371a4996fc3611e58c380242ac110003_200x200_85.jpeg
a9343d7afcc211e5a78c0242ac11001c.jpeg	\N	/data/photos/a9343d7afcc211e5a78c0242ac11001c.jpeg	/data/thumbnails/photos/a9343d7afcc211e5a78c0242ac11001c_400x400_85.jpeg	/data/thumbnails/photos/a9343d7afcc211e5a78c0242ac11001c_200x200_85.jpeg
460ffb88fcc411e5a78c0242ac11001c.jpeg	\N	/data/photos/460ffb88fcc411e5a78c0242ac11001c.jpeg	/data/thumbnails/photos/460ffb88fcc411e5a78c0242ac11001c_400x400_85.jpeg	/data/thumbnails/photos/460ffb88fcc411e5a78c0242ac11001c_200x200_85.jpeg
0b9f01acfd7c11e59d410242ac11001c.jpeg	День рождения Олега Григорьевича Фаянса 2001 год 29 августа. Семейные посиделки	/data/photos/0b9f01acfd7c11e59d410242ac11001c.jpeg	/data/thumbnails/photos/0b9f01acfd7c11e59d410242ac11001c_400x400_85.jpeg	/data/thumbnails/photos/0b9f01acfd7c11e59d410242ac11001c_200x200_85.jpeg
10b2b35efd7d11e59d410242ac11001c.jpeg	2001 год,	/data/photos/10b2b35efd7d11e59d410242ac11001c.jpeg	/data/thumbnails/photos/10b2b35efd7d11e59d410242ac11001c_400x400_85.jpeg	/data/thumbnails/photos/10b2b35efd7d11e59d410242ac11001c_200x200_85.jpeg
e63b3276fd7d11e5bb300242ac11001c.jpeg		/data/photos/e63b3276fd7d11e5bb300242ac11001c.jpeg	/data/thumbnails/photos/e63b3276fd7d11e5bb300242ac11001c_400x400_85.jpeg	/data/thumbnails/photos/e63b3276fd7d11e5bb300242ac11001c_200x200_85.jpeg
6b0f95d4fd9011e5bfba0242ac11001c.jpeg		/data/photos/6b0f95d4fd9011e5bfba0242ac11001c.jpeg	/data/thumbnails/photos/6b0f95d4fd9011e5bfba0242ac11001c_400x400_85.jpeg	/data/thumbnails/photos/6b0f95d4fd9011e5bfba0242ac11001c_200x200_85.jpeg
b29aa6e2fdc611e5a4220242ac11001c.jpg	\N	/data/photos/b29aa6e2fdc611e5a4220242ac11001c.jpg	/data/thumbnails/photos/b29aa6e2fdc611e5a4220242ac11001c_400x400_85.jpg	/data/thumbnails/photos/b29aa6e2fdc611e5a4220242ac11001c_200x200_85.jpg
a859424cff2911e58b940242ac11001c.jpg	\N	/data/photos/a859424cff2911e58b940242ac11001c.jpg	/data/thumbnails/photos/a859424cff2911e58b940242ac11001c_400x400_85.jpg	/data/thumbnails/photos/a859424cff2911e58b940242ac11001c_200x200_85.jpg
387bae96ff2a11e58b940242ac11001c.jpg	\N	/data/photos/387bae96ff2a11e58b940242ac11001c.jpg	/data/thumbnails/photos/387bae96ff2a11e58b940242ac11001c_400x400_85.jpg	/data/thumbnails/photos/387bae96ff2a11e58b940242ac11001c_200x200_85.jpg
\.


--
-- Data for Name: photoparticipant; Type: TABLE DATA; Schema: public; Owner: jamesb0nd
--

COPY photoparticipant (person_id, photo_id) FROM stdin;
59794800f91d11e580960242ac110003	5978d38ef91d11e580960242ac110003.JPG
3326e014f92111e5be8b0242ac110003	3326c6baf92111e5be8b0242ac110003.jpg
b4454d70f92111e5be8b0242ac110003	b4453952f92111e5be8b0242ac110003.jpg
d085ed2ef92a11e582a60242ac110003	d085d992f92a11e582a60242ac110003.jpg
0dd32fa2f92b11e582a60242ac110003	0dd3158af92b11e582a60242ac110003.jpg
06672b8cf92c11e593dc0242ac110003	2cbb2de2f92c11e593dc0242ac110003.jpg
4b8c0d8cf9df11e5b5040242ac110003	4b8bf1e4f9df11e5b5040242ac110003.jpg
e4c100e0fc3011e595830242ac110003	e4c02b84fc3011e595830242ac110003.jpeg
da9a8a9afc3111e595830242ac110003	da98947efc3111e595830242ac110003.jpeg
55a741f6fc3211e595830242ac110003	55a6e300fc3211e595830242ac110003.jpeg
ee3a3c54fc3511e58c380242ac110003	ee39afa0fc3511e58c380242ac110003.jpeg
371b159cfc3611e58c380242ac110003	371a4996fc3611e58c380242ac110003.jpeg
a9345314fcc211e5a78c0242ac11001c	a9343d7afcc211e5a78c0242ac11001c.jpeg
46101992fcc411e5a78c0242ac11001c	460ffb88fcc411e5a78c0242ac11001c.jpeg
3326e014f92111e5be8b0242ac110003	0b9f01acfd7c11e59d410242ac11001c.jpeg
b4454d70f92111e5be8b0242ac110003	0b9f01acfd7c11e59d410242ac11001c.jpeg
4b8c0d8cf9df11e5b5040242ac110003	0b9f01acfd7c11e59d410242ac11001c.jpeg
e4c100e0fc3011e595830242ac110003	0b9f01acfd7c11e59d410242ac11001c.jpeg
a9345314fcc211e5a78c0242ac11001c	0b9f01acfd7c11e59d410242ac11001c.jpeg
46101992fcc411e5a78c0242ac11001c	0b9f01acfd7c11e59d410242ac11001c.jpeg
4b8c0d8cf9df11e5b5040242ac110003	10b2b35efd7d11e59d410242ac11001c.jpeg
e4c100e0fc3011e595830242ac110003	10b2b35efd7d11e59d410242ac11001c.jpeg
b4454d70f92111e5be8b0242ac110003	e63b3276fd7d11e5bb300242ac11001c.jpeg
3326e014f92111e5be8b0242ac110003	6b0f95d4fd9011e5bfba0242ac11001c.jpeg
d085ed2ef92a11e582a60242ac110003	6b0f95d4fd9011e5bfba0242ac11001c.jpeg
0dd32fa2f92b11e582a60242ac110003	6b0f95d4fd9011e5bfba0242ac11001c.jpeg
b29ab826fdc611e5a4220242ac11001c	b29aa6e2fdc611e5a4220242ac11001c.jpg
a8595444ff2911e58b940242ac11001c	a859424cff2911e58b940242ac11001c.jpg
387bc30eff2a11e58b940242ac11001c	387bae96ff2a11e58b940242ac11001c.jpg
\.


--
-- Data for Name: spouses; Type: TABLE DATA; Schema: public; Owner: jamesb0nd
--

COPY spouses (leftspouse_id, rightspouse_id) FROM stdin;
e4c100e0fc3011e595830242ac110003	4b8c0d8cf9df11e5b5040242ac110003
4b8c0d8cf9df11e5b5040242ac110003	e4c100e0fc3011e595830242ac110003
55a741f6fc3211e595830242ac110003	da9a8a9afc3111e595830242ac110003
da9a8a9afc3111e595830242ac110003	55a741f6fc3211e595830242ac110003
371b159cfc3611e58c380242ac110003	ee3a3c54fc3511e58c380242ac110003
ee3a3c54fc3511e58c380242ac110003	371b159cfc3611e58c380242ac110003
b29ab826fdc611e5a4220242ac11001c	3326e014f92111e5be8b0242ac110003
3326e014f92111e5be8b0242ac110003	b29ab826fdc611e5a4220242ac11001c
93587948ff2a11e58b940242ac11001c	387bc30eff2a11e58b940242ac11001c
387bc30eff2a11e58b940242ac11001c	93587948ff2a11e58b940242ac11001c
\.


--
-- Data for Name: usermessages; Type: TABLE DATA; Schema: public; Owner: jamesb0nd
--

COPY usermessages (user_id, message_id) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: jamesb0nd
--

COPY users (id, email, password_hash, name, second_name, surname, sex, country_id, b_date, person_id, is_new, confirmed) FROM stdin;
f68133caf91c11e580960242ac110003	ofajans@gmail.com	pbkdf2:sha1:1000$zl2WMsmY$55e27fe800affbce79878cc1f46cd4806020437f	Олег	Олегович	Фаянс	male	191	1979-05-17	59794800f91d11e580960242ac110003	f	t
ff69898aff2811e58b940242ac11001c	aquimaria@gmail.com	pbkdf2:sha1:1000$y6lr8lgD$5ea6d1abef35d7ffe68c67cf743e5204e203df62	Мария	Владимировна	Злобина	female	191	1981-07-21	a8595444ff2911e58b940242ac11001c	f	t
a021ea48ff2e11e58b940242ac11001c	ololo@alala.com	pbkdf2:sha1:1000$fDpEC6Lz$5a5046b2c0e79e5097209494e54d834c7fef85fb	Григорий	Владимирович	Фаянс	male	191	1976-01-01	b9a30aecff2e11e58b940242ac11001c	f	t
\.


--
-- Name: country_pkey; Type: CONSTRAINT; Schema: public; Owner: jamesb0nd; Tablespace: 
--

ALTER TABLE ONLY country
    ADD CONSTRAINT country_pkey PRIMARY KEY (id);


--
-- Name: family_pkey; Type: CONSTRAINT; Schema: public; Owner: jamesb0nd; Tablespace: 
--

ALTER TABLE ONLY family
    ADD CONSTRAINT family_pkey PRIMARY KEY (id);


--
-- Name: legend_pkey; Type: CONSTRAINT; Schema: public; Owner: jamesb0nd; Tablespace: 
--

ALTER TABLE ONLY legend
    ADD CONSTRAINT legend_pkey PRIMARY KEY (id);


--
-- Name: message_pkey; Type: CONSTRAINT; Schema: public; Owner: jamesb0nd; Tablespace: 
--

ALTER TABLE ONLY message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- Name: person_pkey; Type: CONSTRAINT; Schema: public; Owner: jamesb0nd; Tablespace: 
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- Name: photo_pkey; Type: CONSTRAINT; Schema: public; Owner: jamesb0nd; Tablespace: 
--

ALTER TABLE ONLY photo
    ADD CONSTRAINT photo_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: jamesb0nd; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: ix_country_id; Type: INDEX; Schema: public; Owner: jamesb0nd; Tablespace: 
--

CREATE INDEX ix_country_id ON country USING btree (id);


--
-- Name: ix_family_creator_id; Type: INDEX; Schema: public; Owner: jamesb0nd; Tablespace: 
--

CREATE INDEX ix_family_creator_id ON family USING btree (creator_id);


--
-- Name: ix_family_id; Type: INDEX; Schema: public; Owner: jamesb0nd; Tablespace: 
--

CREATE INDEX ix_family_id ON family USING btree (id);


--
-- Name: ix_legend_id; Type: INDEX; Schema: public; Owner: jamesb0nd; Tablespace: 
--

CREATE INDEX ix_legend_id ON legend USING btree (id);


--
-- Name: ix_message_id; Type: INDEX; Schema: public; Owner: jamesb0nd; Tablespace: 
--

CREATE INDEX ix_message_id ON message USING btree (id);


--
-- Name: ix_person_id; Type: INDEX; Schema: public; Owner: jamesb0nd; Tablespace: 
--

CREATE INDEX ix_person_id ON person USING btree (id);


--
-- Name: ix_photo_id; Type: INDEX; Schema: public; Owner: jamesb0nd; Tablespace: 
--

CREATE INDEX ix_photo_id ON photo USING btree (id);


--
-- Name: ix_users_email; Type: INDEX; Schema: public; Owner: jamesb0nd; Tablespace: 
--

CREATE INDEX ix_users_email ON users USING btree (email);


--
-- Name: ix_users_id; Type: INDEX; Schema: public; Owner: jamesb0nd; Tablespace: 
--

CREATE INDEX ix_users_id ON users USING btree (id);


--
-- Name: country_dvellers_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamesb0nd
--

ALTER TABLE ONLY country_dvellers
    ADD CONSTRAINT country_dvellers_country_id_fkey FOREIGN KEY (country_id) REFERENCES country(id);


--
-- Name: country_dvellers_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamesb0nd
--

ALTER TABLE ONLY country_dvellers
    ADD CONSTRAINT country_dvellers_person_id_fkey FOREIGN KEY (person_id) REFERENCES person(id);


--
-- Name: family_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamesb0nd
--

ALTER TABLE ONLY family
    ADD CONSTRAINT family_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES users(id);


--
-- Name: family_members_family_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamesb0nd
--

ALTER TABLE ONLY family_members
    ADD CONSTRAINT family_members_family_id_fkey FOREIGN KEY (family_id) REFERENCES family(id);


--
-- Name: family_members_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamesb0nd
--

ALTER TABLE ONLY family_members
    ADD CONSTRAINT family_members_person_id_fkey FOREIGN KEY (person_id) REFERENCES person(id);


--
-- Name: family_possible_members_family_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamesb0nd
--

ALTER TABLE ONLY family_possible_members
    ADD CONSTRAINT family_possible_members_family_id_fkey FOREIGN KEY (family_id) REFERENCES family(id);


--
-- Name: legendparticipant_legend_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamesb0nd
--

ALTER TABLE ONLY legendparticipant
    ADD CONSTRAINT legendparticipant_legend_id_fkey FOREIGN KEY (legend_id) REFERENCES legend(id);


--
-- Name: legendparticipant_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamesb0nd
--

ALTER TABLE ONLY legendparticipant
    ADD CONSTRAINT legendparticipant_person_id_fkey FOREIGN KEY (person_id) REFERENCES person(id);


--
-- Name: person_ava_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamesb0nd
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_ava_id_fkey FOREIGN KEY (ava_id) REFERENCES photo(id);


--
-- Name: person_father_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamesb0nd
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_father_id_fkey FOREIGN KEY (father_id) REFERENCES person(id);


--
-- Name: person_mother_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamesb0nd
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_mother_id_fkey FOREIGN KEY (mother_id) REFERENCES person(id);


--
-- Name: photoparticipant_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamesb0nd
--

ALTER TABLE ONLY photoparticipant
    ADD CONSTRAINT photoparticipant_person_id_fkey FOREIGN KEY (person_id) REFERENCES person(id);


--
-- Name: photoparticipant_photo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamesb0nd
--

ALTER TABLE ONLY photoparticipant
    ADD CONSTRAINT photoparticipant_photo_id_fkey FOREIGN KEY (photo_id) REFERENCES photo(id);


--
-- Name: spouses_leftspouse_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamesb0nd
--

ALTER TABLE ONLY spouses
    ADD CONSTRAINT spouses_leftspouse_id_fkey FOREIGN KEY (leftspouse_id) REFERENCES person(id) ON DELETE CASCADE;


--
-- Name: spouses_rightspouse_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamesb0nd
--

ALTER TABLE ONLY spouses
    ADD CONSTRAINT spouses_rightspouse_id_fkey FOREIGN KEY (rightspouse_id) REFERENCES person(id) ON DELETE CASCADE;


--
-- Name: usermessages_message_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamesb0nd
--

ALTER TABLE ONLY usermessages
    ADD CONSTRAINT usermessages_message_id_fkey FOREIGN KEY (message_id) REFERENCES message(id);


--
-- Name: usermessages_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamesb0nd
--

ALTER TABLE ONLY usermessages
    ADD CONSTRAINT usermessages_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: users_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamesb0nd
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_country_id_fkey FOREIGN KEY (country_id) REFERENCES country(id);


--
-- Name: users_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamesb0nd
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_person_id_fkey FOREIGN KEY (person_id) REFERENCES person(id);


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

