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

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: JAmesB0nd; Tablespace: 
--

CREATE TABLE alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE alembic_version OWNER TO "JAmesB0nd";

--
-- Name: country; Type: TABLE; Schema: public; Owner: JAmesB0nd; Tablespace: 
--

CREATE TABLE country (
    id character varying NOT NULL,
    name character varying
);


ALTER TABLE country OWNER TO "JAmesB0nd";

--
-- Name: country_dvellers; Type: TABLE; Schema: public; Owner: JAmesB0nd; Tablespace: 
--

CREATE TABLE country_dvellers (
    country_id character varying,
    person_id character varying
);


ALTER TABLE country_dvellers OWNER TO "JAmesB0nd";

--
-- Name: family; Type: TABLE; Schema: public; Owner: JAmesB0nd; Tablespace: 
--

CREATE TABLE family (
    id character varying NOT NULL,
    creator_id character varying
);


ALTER TABLE family OWNER TO "JAmesB0nd";

--
-- Name: family_members; Type: TABLE; Schema: public; Owner: JAmesB0nd; Tablespace: 
--

CREATE TABLE family_members (
    family_id character varying,
    person_id character varying
);


ALTER TABLE family_members OWNER TO "JAmesB0nd";

--
-- Name: legend; Type: TABLE; Schema: public; Owner: JAmesB0nd; Tablespace: 
--

CREATE TABLE legend (
    id character varying NOT NULL,
    text text
);


ALTER TABLE legend OWNER TO "JAmesB0nd";

--
-- Name: legendparticipant; Type: TABLE; Schema: public; Owner: JAmesB0nd; Tablespace: 
--

CREATE TABLE legendparticipant (
    person_id character varying,
    legend_id character varying
);


ALTER TABLE legendparticipant OWNER TO "JAmesB0nd";

--
-- Name: person; Type: TABLE; Schema: public; Owner: JAmesB0nd; Tablespace: 
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


ALTER TABLE person OWNER TO "JAmesB0nd";

--
-- Name: photo; Type: TABLE; Schema: public; Owner: JAmesB0nd; Tablespace: 
--

CREATE TABLE photo (
    id character varying NOT NULL,
    description text,
    path character varying
);


ALTER TABLE photo OWNER TO "JAmesB0nd";

--
-- Name: photoparticipant; Type: TABLE; Schema: public; Owner: JAmesB0nd; Tablespace: 
--

CREATE TABLE photoparticipant (
    person_id character varying,
    photo_id character varying
);


ALTER TABLE photoparticipant OWNER TO "JAmesB0nd";

--
-- Name: spouses; Type: TABLE; Schema: public; Owner: JAmesB0nd; Tablespace: 
--

CREATE TABLE spouses (
    leftspouse_id character varying,
    rightspouse_id character varying
);


ALTER TABLE spouses OWNER TO "JAmesB0nd";

--
-- Name: users; Type: TABLE; Schema: public; Owner: JAmesB0nd; Tablespace: 
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


ALTER TABLE users OWNER TO "JAmesB0nd";

--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: JAmesB0nd
--

COPY alembic_version (version_num) FROM stdin;
5b7bd7bc2404
\.


--
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: JAmesB0nd
--

COPY country (id, name) FROM stdin;
8281544eca4d11e5b03a3c970e1933ad	Afghanistan
8287aec0ca4d11e5b03a3c970e1933ad	Albania
8287b42eca4d11e5b03a3c970e1933ad	Algeria
8287b7d0ca4d11e5b03a3c970e1933ad	American Samoa
8287bb22ca4d11e5b03a3c970e1933ad	Andorra
8287be92ca4d11e5b03a3c970e1933ad	Angola
8287c1b2ca4d11e5b03a3c970e1933ad	Anguilla
8287c4beca4d11e5b03a3c970e1933ad	Antarctica
8287c892ca4d11e5b03a3c970e1933ad	Antigua and Barbuda
8287cc20ca4d11e5b03a3c970e1933ad	Argentina
8287cf0eca4d11e5b03a3c970e1933ad	Armenia
8287d210ca4d11e5b03a3c970e1933ad	Aruba
8287d4f4ca4d11e5b03a3c970e1933ad	Ascension and Tristan Da Cunha Saint Helena
8287d7ceca4d11e5b03a3c970e1933ad	Australia
8287dab2ca4d11e5b03a3c970e1933ad	Austria
8287dda0ca4d11e5b03a3c970e1933ad	Azerbaijan
8287e07aca4d11e5b03a3c970e1933ad	Bahamas
8287e340ca4d11e5b03a3c970e1933ad	Bahrain
8287e610ca4d11e5b03a3c970e1933ad	Bangladesh
8287e8c2ca4d11e5b03a3c970e1933ad	Barbados
8287eb88ca4d11e5b03a3c970e1933ad	Belarus
8287ee4eca4d11e5b03a3c970e1933ad	Belgium
8287f150ca4d11e5b03a3c970e1933ad	Belize
8287f43eca4d11e5b03a3c970e1933ad	Benin
8287f718ca4d11e5b03a3c970e1933ad	Bermuda
8287f9d4ca4d11e5b03a3c970e1933ad	Bhutan
8287fc9aca4d11e5b03a3c970e1933ad	Bolivarian Republic of Venezuela
8287ff60ca4d11e5b03a3c970e1933ad	Bolivia, Plurinational State of
8288021cca4d11e5b03a3c970e1933ad	Bonaire, Sint Eustatius and Saba
828804e2ca4d11e5b03a3c970e1933ad	Bosnia and Herzegovina
8288079eca4d11e5b03a3c970e1933ad	Botswana
82880a64ca4d11e5b03a3c970e1933ad	Bouvet Island
82880d20ca4d11e5b03a3c970e1933ad	Brazil
82880ffaca4d11e5b03a3c970e1933ad	British Indian Ocean Territory
828812f2ca4d11e5b03a3c970e1933ad	British Virgin Islands
828815f4ca4d11e5b03a3c970e1933ad	Brunei Darussalam
828818baca4d11e5b03a3c970e1933ad	Bulgaria
82881b9eca4d11e5b03a3c970e1933ad	Burkina Faso
82881e78ca4d11e5b03a3c970e1933ad	Burundi
82882148ca4d11e5b03a3c970e1933ad	Cambodia
8288240eca4d11e5b03a3c970e1933ad	Cameroon
828826caca4d11e5b03a3c970e1933ad	Canada
8288297cca4d11e5b03a3c970e1933ad	Cape Verde
82882c38ca4d11e5b03a3c970e1933ad	Cayman Islands
82882f1cca4d11e5b03a3c970e1933ad	Central African Republic
828831e2ca4d11e5b03a3c970e1933ad	Chad
82883494ca4d11e5b03a3c970e1933ad	Chile
82883750ca4d11e5b03a3c970e1933ad	China
82883a0cca4d11e5b03a3c970e1933ad	Christmas Island
82883d68ca4d11e5b03a3c970e1933ad	Cocos (Keeling) Islands
828840e2ca4d11e5b03a3c970e1933ad	Colombia
8288439eca4d11e5b03a3c970e1933ad	Comoros
8288468cca4d11e5b03a3c970e1933ad	Congo
82884948ca4d11e5b03a3c970e1933ad	Congo, The Democratic Republic of the
82884c18ca4d11e5b03a3c970e1933ad	Cook Islands
82884ed4ca4d11e5b03a3c970e1933ad	Costa Rica
8288519aca4d11e5b03a3c970e1933ad	Croatia
82885456ca4d11e5b03a3c970e1933ad	Cuba
82885afaca4d11e5b03a3c970e1933ad	Curaçao
82885de8ca4d11e5b03a3c970e1933ad	Cyprus
828860a4ca4d11e5b03a3c970e1933ad	Czech Republic
8288637eca4d11e5b03a3c970e1933ad	Côte D'ivoire
82886680ca4d11e5b03a3c970e1933ad	Democratic People's Republic of Korea
82886932ca4d11e5b03a3c970e1933ad	Denmark
82886beeca4d11e5b03a3c970e1933ad	Djibouti
82886eaaca4d11e5b03a3c970e1933ad	Dominica
8288715cca4d11e5b03a3c970e1933ad	Dominican Republic
82887436ca4d11e5b03a3c970e1933ad	Ecuador
828876e8ca4d11e5b03a3c970e1933ad	Egypt
828879a4ca4d11e5b03a3c970e1933ad	El Salvador
82887c92ca4d11e5b03a3c970e1933ad	Equatorial Guinea
82887f44ca4d11e5b03a3c970e1933ad	Eritrea
828881f6ca4d11e5b03a3c970e1933ad	Estonia
828884e4ca4d11e5b03a3c970e1933ad	Ethiopia
828887b4ca4d11e5b03a3c970e1933ad	Falkland Islands (Malvinas)
82888a70ca4d11e5b03a3c970e1933ad	Faroe Islands
82888d5eca4d11e5b03a3c970e1933ad	Federated States of Micronesia
8288901aca4d11e5b03a3c970e1933ad	Fiji
828892d6ca4d11e5b03a3c970e1933ad	Finland
828895b0ca4d11e5b03a3c970e1933ad	France
8288986cca4d11e5b03a3c970e1933ad	French Guiana
82889b32ca4d11e5b03a3c970e1933ad	French Polynesia
82889deeca4d11e5b03a3c970e1933ad	French Southern Territories
8288a0aaca4d11e5b03a3c970e1933ad	Gabon
8288a37aca4d11e5b03a3c970e1933ad	Gambia
8288a62cca4d11e5b03a3c970e1933ad	Georgia
8288a924ca4d11e5b03a3c970e1933ad	Germany
8288abfeca4d11e5b03a3c970e1933ad	Ghana
8288aececa4d11e5b03a3c970e1933ad	Gibraltar
8288b216ca4d11e5b03a3c970e1933ad	Greece
8288b59aca4d11e5b03a3c970e1933ad	Greenland
8288b856ca4d11e5b03a3c970e1933ad	Grenada
8288bb08ca4d11e5b03a3c970e1933ad	Guadeloupe
8288bdd8ca4d11e5b03a3c970e1933ad	Guam
8288c08aca4d11e5b03a3c970e1933ad	Guatemala
8288c33cca4d11e5b03a3c970e1933ad	Guernsey
8288c5f8ca4d11e5b03a3c970e1933ad	Guinea
8288c8c8ca4d11e5b03a3c970e1933ad	Guinea-bissau
8288cb84ca4d11e5b03a3c970e1933ad	Guyana
8288ce40ca4d11e5b03a3c970e1933ad	Haiti
8288d0fcca4d11e5b03a3c970e1933ad	Heard Island and McDonald Islands
8288d3ccca4d11e5b03a3c970e1933ad	Holy See (Vatican City State)
8288d688ca4d11e5b03a3c970e1933ad	Honduras
8288d962ca4d11e5b03a3c970e1933ad	Hong Kong
8288dc28ca4d11e5b03a3c970e1933ad	Hungary
8288dedaca4d11e5b03a3c970e1933ad	Iceland
8288e1aaca4d11e5b03a3c970e1933ad	India
8288e47aca4d11e5b03a3c970e1933ad	Indonesia
8288e736ca4d11e5b03a3c970e1933ad	Iran, Islamic Republic of
8288e9e8ca4d11e5b03a3c970e1933ad	Iraq
8288ecc2ca4d11e5b03a3c970e1933ad	Ireland
8288ef88ca4d11e5b03a3c970e1933ad	Islamic Republic of Iran
8288f23aca4d11e5b03a3c970e1933ad	Isle of Man
8288f4ecca4d11e5b03a3c970e1933ad	Israel
8288f79eca4d11e5b03a3c970e1933ad	Italy
8288fa5aca4d11e5b03a3c970e1933ad	Jamaica
8288fd0cca4d11e5b03a3c970e1933ad	Japan
8288fffaca4d11e5b03a3c970e1933ad	Jersey
828902d4ca4d11e5b03a3c970e1933ad	Jordan
82890586ca4d11e5b03a3c970e1933ad	Kazakhstan
82890842ca4d11e5b03a3c970e1933ad	Kenya
82890afeca4d11e5b03a3c970e1933ad	Kiribati
82890db0ca4d11e5b03a3c970e1933ad	Korea, Democratic People's Republic of
82891062ca4d11e5b03a3c970e1933ad	Korea, Republic of
828913b4ca4d11e5b03a3c970e1933ad	Kuwait
828916caca4d11e5b03a3c970e1933ad	Kyrgyzstan
828919aeca4d11e5b03a3c970e1933ad	Lao People's Democratic Republic
82891c88ca4d11e5b03a3c970e1933ad	Latvia
82891f6cca4d11e5b03a3c970e1933ad	Lebanon
8289226eca4d11e5b03a3c970e1933ad	Lesotho
82892552ca4d11e5b03a3c970e1933ad	Liberia
8289285eca4d11e5b03a3c970e1933ad	Libya
82892b42ca4d11e5b03a3c970e1933ad	Liechtenstein
82892e3aca4d11e5b03a3c970e1933ad	Lithuania
82893114ca4d11e5b03a3c970e1933ad	Luxembourg
828933eeca4d11e5b03a3c970e1933ad	Macao
828936dcca4d11e5b03a3c970e1933ad	Macedonia, The Former Yugoslav Republic of
82893a2eca4d11e5b03a3c970e1933ad	Madagascar
82893cfeca4d11e5b03a3c970e1933ad	Malawi
82893fceca4d11e5b03a3c970e1933ad	Malaysia
8289428aca4d11e5b03a3c970e1933ad	Maldives
8289453cca4d11e5b03a3c970e1933ad	Mali
8289480cca4d11e5b03a3c970e1933ad	Malta
82894ac8ca4d11e5b03a3c970e1933ad	Marshall Islands
8289502cca4d11e5b03a3c970e1933ad	Martinique
82895324ca4d11e5b03a3c970e1933ad	Mauritania
828955feca4d11e5b03a3c970e1933ad	Mauritius
828958baca4d11e5b03a3c970e1933ad	Mayotte
82895b6cca4d11e5b03a3c970e1933ad	Mexico
82895e5aca4d11e5b03a3c970e1933ad	Micronesia, Federated States of
8289612aca4d11e5b03a3c970e1933ad	Moldova, Republic of
828963e6ca4d11e5b03a3c970e1933ad	Monaco
82896698ca4d11e5b03a3c970e1933ad	Mongolia
82896954ca4d11e5b03a3c970e1933ad	Montenegro
82896c10ca4d11e5b03a3c970e1933ad	Montserrat
82896eccca4d11e5b03a3c970e1933ad	Morocco
82897188ca4d11e5b03a3c970e1933ad	Mozambique
8289744eca4d11e5b03a3c970e1933ad	Myanmar
82897728ca4d11e5b03a3c970e1933ad	Namibia
828979e4ca4d11e5b03a3c970e1933ad	Nauru
82897cb4ca4d11e5b03a3c970e1933ad	Nepal
82897f84ca4d11e5b03a3c970e1933ad	Netherlands
82898240ca4d11e5b03a3c970e1933ad	New Caledonia
828984f2ca4d11e5b03a3c970e1933ad	New Zealand
828987b8ca4d11e5b03a3c970e1933ad	Nicaragua
82898a74ca4d11e5b03a3c970e1933ad	Niger
82898d26ca4d11e5b03a3c970e1933ad	Nigeria
82898fe2ca4d11e5b03a3c970e1933ad	Niue
82899294ca4d11e5b03a3c970e1933ad	Norfolk Island
82899550ca4d11e5b03a3c970e1933ad	Northern Mariana Islands
82899802ca4d11e5b03a3c970e1933ad	Norway
82899ae6ca4d11e5b03a3c970e1933ad	Occupied Palestinian Territory
82899f8cca4d11e5b03a3c970e1933ad	Oman
8289a252ca4d11e5b03a3c970e1933ad	Pakistan
8289a50eca4d11e5b03a3c970e1933ad	Palau
8289a7c0ca4d11e5b03a3c970e1933ad	Palestinian Territory, Occupied
8289aa7cca4d11e5b03a3c970e1933ad	Panama
8289ad2eca4d11e5b03a3c970e1933ad	Papua New Guinea
8289b008ca4d11e5b03a3c970e1933ad	Paraguay
8289b2baca4d11e5b03a3c970e1933ad	Peru
8289b58aca4d11e5b03a3c970e1933ad	Philippines
8289b846ca4d11e5b03a3c970e1933ad	Pitcairn
8289bb34ca4d11e5b03a3c970e1933ad	Plurinational State of Bolivia
8289bdf0ca4d11e5b03a3c970e1933ad	Poland
8289c0a2ca4d11e5b03a3c970e1933ad	Portugal
8289c37cca4d11e5b03a3c970e1933ad	Province of China Taiwan
8289c642ca4d11e5b03a3c970e1933ad	Puerto Rico
8289c91cca4d11e5b03a3c970e1933ad	Qatar
8289cbe2ca4d11e5b03a3c970e1933ad	Republic of Korea
8289ce9eca4d11e5b03a3c970e1933ad	Republic of Moldova
8289d146ca4d11e5b03a3c970e1933ad	Romania
8289d3f8ca4d11e5b03a3c970e1933ad	Russian Federation
8289d6aaca4d11e5b03a3c970e1933ad	Rwanda
8289d95cca4d11e5b03a3c970e1933ad	Réunion
8289dc0eca4d11e5b03a3c970e1933ad	Saint Barthélemy
8289dec0ca4d11e5b03a3c970e1933ad	Saint Helena, Ascension and Tristan Da Cunha
8289e1a4ca4d11e5b03a3c970e1933ad	Saint Kitts and Nevis
8289e456ca4d11e5b03a3c970e1933ad	Saint Lucia
8289e726ca4d11e5b03a3c970e1933ad	Saint Martin (French Part)
8289e9d8ca4d11e5b03a3c970e1933ad	Saint Pierre and Miquelon
8289ecb2ca4d11e5b03a3c970e1933ad	Saint Vincent and the Grenadines
8289ef64ca4d11e5b03a3c970e1933ad	Samoa
8289f220ca4d11e5b03a3c970e1933ad	San Marino
8289f4d2ca4d11e5b03a3c970e1933ad	Sao Tome and Principe
8289f784ca4d11e5b03a3c970e1933ad	Saudi Arabia
8289fa40ca4d11e5b03a3c970e1933ad	Senegal
8289fcfcca4d11e5b03a3c970e1933ad	Serbia
8289ffaeca4d11e5b03a3c970e1933ad	Seychelles
828a027eca4d11e5b03a3c970e1933ad	Sierra Leone
828a0530ca4d11e5b03a3c970e1933ad	Singapore
828a07e2ca4d11e5b03a3c970e1933ad	Sint Eustatius and Saba Bonaire
828a0a94ca4d11e5b03a3c970e1933ad	Sint Maarten (Dutch Part)
828a0d64ca4d11e5b03a3c970e1933ad	Slovakia
828a1016ca4d11e5b03a3c970e1933ad	Slovenia
828a1476ca4d11e5b03a3c970e1933ad	Solomon Islands
828a1732ca4d11e5b03a3c970e1933ad	Somalia
828a19e4ca4d11e5b03a3c970e1933ad	South Africa
828a1cb4ca4d11e5b03a3c970e1933ad	South Georgia and the South Sandwich Islands
828a1f84ca4d11e5b03a3c970e1933ad	South Sudan
828a2254ca4d11e5b03a3c970e1933ad	Spain
828a2506ca4d11e5b03a3c970e1933ad	Sri Lanka
828a27aeca4d11e5b03a3c970e1933ad	Sudan
828a2a60ca4d11e5b03a3c970e1933ad	Suriname
828a2d1cca4d11e5b03a3c970e1933ad	Svalbard and Jan Mayen
828a2fceca4d11e5b03a3c970e1933ad	Swaziland
828a3280ca4d11e5b03a3c970e1933ad	Sweden
828a3532ca4d11e5b03a3c970e1933ad	Switzerland
828a37f8ca4d11e5b03a3c970e1933ad	Syrian Arab Republic
828a3adcca4d11e5b03a3c970e1933ad	Taiwan, Province of China
828a3d8eca4d11e5b03a3c970e1933ad	Tajikistan
828a42deca4d11e5b03a3c970e1933ad	Tanzania, United Republic of
828a45d6ca4d11e5b03a3c970e1933ad	Thailand
828a48b0ca4d11e5b03a3c970e1933ad	The Democratic Republic of the Congo
828a4b76ca4d11e5b03a3c970e1933ad	The Former Yugoslav Republic of Macedonia
828a4e32ca4d11e5b03a3c970e1933ad	Timor-leste
828a50eeca4d11e5b03a3c970e1933ad	Togo
828a53b4ca4d11e5b03a3c970e1933ad	Tokelau
828a568eca4d11e5b03a3c970e1933ad	Tonga
828a5940ca4d11e5b03a3c970e1933ad	Trinidad and Tobago
828a5bfcca4d11e5b03a3c970e1933ad	Tunisia
828a5eccca4d11e5b03a3c970e1933ad	Turkey
828a61b0ca4d11e5b03a3c970e1933ad	Turkmenistan
828a646cca4d11e5b03a3c970e1933ad	Turks and Caicos Islands
828a673cca4d11e5b03a3c970e1933ad	Tuvalu
828a69f8ca4d11e5b03a3c970e1933ad	U.S. Virgin Islands
828a6caaca4d11e5b03a3c970e1933ad	Uganda
828a6f66ca4d11e5b03a3c970e1933ad	Ukraine
828a720eca4d11e5b03a3c970e1933ad	United Arab Emirates
828a74caca4d11e5b03a3c970e1933ad	United Kingdom
828a7786ca4d11e5b03a3c970e1933ad	United Republic of Tanzania
828a7a60ca4d11e5b03a3c970e1933ad	United States
828a7d30ca4d11e5b03a3c970e1933ad	United States Minor Outlying Islands
828a7fecca4d11e5b03a3c970e1933ad	Uruguay
828a829eca4d11e5b03a3c970e1933ad	Uzbekistan
828a856eca4d11e5b03a3c970e1933ad	Vanuatu
828a8988ca4d11e5b03a3c970e1933ad	Venezuela, Bolivarian Republic of
828a8c44ca4d11e5b03a3c970e1933ad	Viet Nam
828a8f00ca4d11e5b03a3c970e1933ad	Virgin Islands, British
828a91bcca4d11e5b03a3c970e1933ad	Virgin Islands, U.S.
828a948cca4d11e5b03a3c970e1933ad	Wallis and Futuna
828a973eca4d11e5b03a3c970e1933ad	Western Sahara
828a99f0ca4d11e5b03a3c970e1933ad	Yemen
828a9cc0ca4d11e5b03a3c970e1933ad	Zambia
828a9f86ca4d11e5b03a3c970e1933ad	Zimbabwe
828aa242ca4d11e5b03a3c970e1933ad	Åland Islands
\.


--
-- Data for Name: country_dvellers; Type: TABLE DATA; Schema: public; Owner: JAmesB0nd
--

COPY country_dvellers (country_id, person_id) FROM stdin;
8289d3f8ca4d11e5b03a3c970e1933ad	c404a4f6ca5d11e5a2db3c970e1933ad
8289d3f8ca4d11e5b03a3c970e1933ad	362b9462cb3111e5bd753c970e1933ad
8289d3f8ca4d11e5b03a3c970e1933ad	1f719182d5b711e59dc6247703a3195c
8289d3f8ca4d11e5b03a3c970e1933ad	3a0fdbaed5bf11e59dc6247703a3195c
8289d3f8ca4d11e5b03a3c970e1933ad	18f4a0d2d5c211e59dc6247703a3195c
8289d3f8ca4d11e5b03a3c970e1933ad	cce77972d81811e5aae9247703a3195c
8289d3f8ca4d11e5b03a3c970e1933ad	2b68bd12d81911e5b8db247703a3195c
8289d3f8ca4d11e5b03a3c970e1933ad	2b35a6a4d89411e5bd123c970e1933ad
\.


--
-- Data for Name: family; Type: TABLE DATA; Schema: public; Owner: JAmesB0nd
--

COPY family (id, creator_id) FROM stdin;
cc442452ca5d11e5a2db3c970e1933ad	b6d4309eca5d11e5a2db3c970e1933ad
2b98f716d81911e5b8db247703a3195c	196f78e6d81711e5aae9247703a3195c
\.


--
-- Data for Name: family_members; Type: TABLE DATA; Schema: public; Owner: JAmesB0nd
--

COPY family_members (family_id, person_id) FROM stdin;
cc442452ca5d11e5a2db3c970e1933ad	c404a4f6ca5d11e5a2db3c970e1933ad
cc442452ca5d11e5a2db3c970e1933ad	362b9462cb3111e5bd753c970e1933ad
cc442452ca5d11e5a2db3c970e1933ad	1f719182d5b711e59dc6247703a3195c
cc442452ca5d11e5a2db3c970e1933ad	3a0fdbaed5bf11e59dc6247703a3195c
cc442452ca5d11e5a2db3c970e1933ad	18f4a0d2d5c211e59dc6247703a3195c
2b98f716d81911e5b8db247703a3195c	2b68bd12d81911e5b8db247703a3195c
cc442452ca5d11e5a2db3c970e1933ad	2b35a6a4d89411e5bd123c970e1933ad
\.


--
-- Data for Name: legend; Type: TABLE DATA; Schema: public; Owner: JAmesB0nd
--

COPY legend (id, text) FROM stdin;
3bbadbcacce111e5b2b2525400e25cae	ewrvwervw
782bcd30cce111e59a34525400e25cae	ewrvwervw
30e168a4cea311e5ae10525400e25cae	Ulalala
\.


--
-- Data for Name: legendparticipant; Type: TABLE DATA; Schema: public; Owner: JAmesB0nd
--

COPY legendparticipant (person_id, legend_id) FROM stdin;
362b9462cb3111e5bd753c970e1933ad	3bbadbcacce111e5b2b2525400e25cae
c404a4f6ca5d11e5a2db3c970e1933ad	3bbadbcacce111e5b2b2525400e25cae
362b9462cb3111e5bd753c970e1933ad	782bcd30cce111e59a34525400e25cae
c404a4f6ca5d11e5a2db3c970e1933ad	782bcd30cce111e59a34525400e25cae
c404a4f6ca5d11e5a2db3c970e1933ad	30e168a4cea311e5ae10525400e25cae
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: JAmesB0nd
--

COPY person (id, name, second_name, surname, sex, alive, b_date, d_date, ava_id, father_id, mother_id, description, maiden_surname) FROM stdin;
1f719182d5b711e59dc6247703a3195c	Олег	Григорьевич	Фаянс	male	f	1927-08-29	2002-10-07	1f6c87dcd5b711e59dc6247703a3195c	\N	\N	\N	\N
c404a4f6ca5d11e5a2db3c970e1933ad	Oleg Fayans	Fayans	Fayans	male	t	1979-05-17	\N	c3ff4042ca5d11e5a2db3c970e1933ad	1f719182d5b711e59dc6247703a3195c	362b9462cb3111e5bd753c970e1933ad	\N	\N
3a0fdbaed5bf11e59dc6247703a3195c	Юрий	Олегович	Фаянс	male	t	1956-02-05	\N	\N	1f719182d5b711e59dc6247703a3195c	\N	\N	\N
18f4a0d2d5c211e59dc6247703a3195c	Лариса	Алексеевна	Фаянс	female	t	1957-02-16	\N	\N	\N	\N	\N	\N
cce77972d81811e5aae9247703a3195c	Vasily		Pupkin	male	t	1981-04-01	\N	\N	\N	\N	\N	\N
2b68bd12d81911e5b8db247703a3195c	Vasily		Pupkin	male	t	1981-04-01	\N	\N	\N	\N	\N	\N
2b35a6a4d89411e5bd123c970e1933ad	Илья	Моисеевич	Явиц	male	f	1919-01-01	1941-08-01	\N	\N	\N	\N	
362b9462cb3111e5bd753c970e1933ad	Ludmila	Iljinichna	Fayans	female	f	1941-08-12	2015-06-07	35d48226cb3111e5bd753c970e1933ad	2b35a6a4d89411e5bd123c970e1933ad	\N	\N	\N
\.


--
-- Data for Name: photo; Type: TABLE DATA; Schema: public; Owner: JAmesB0nd
--

COPY photo (id, description, path) FROM stdin;
154394b6ca5011e599d73c970e1933ad	\N	/home/ofayans/tmp/familyalbum/154394b6ca5011e599d73c970e1933ad
83351b00ca5c11e5a5f53c970e1933ad	\N	/home/ofayans/tmp/familyalbum/83351b00ca5c11e5a5f53c970e1933ad
c3ff4042ca5d11e5a2db3c970e1933ad	\N	/home/ofayans/tmp/familyalbum/c3ff4042ca5d11e5a2db3c970e1933ad
41932a1acb2a11e586bb3c970e1933ad	\N	/home/ofayans/tmp/familyalbum/41932a1acb2a11e586bb3c970e1933ad
35d48226cb3111e5bd753c970e1933ad	\N	/home/ofayans/tmp/familyalbum/35d48226cb3111e5bd753c970e1933ad
1f6c87dcd5b711e59dc6247703a3195c	\N	/home/ofayans/tmp/familyalbum/photos/1f6c87dcd5b711e59dc6247703a3195c
\.


--
-- Data for Name: photoparticipant; Type: TABLE DATA; Schema: public; Owner: JAmesB0nd
--

COPY photoparticipant (person_id, photo_id) FROM stdin;
c404a4f6ca5d11e5a2db3c970e1933ad	c3ff4042ca5d11e5a2db3c970e1933ad
362b9462cb3111e5bd753c970e1933ad	35d48226cb3111e5bd753c970e1933ad
1f719182d5b711e59dc6247703a3195c	1f6c87dcd5b711e59dc6247703a3195c
\.


--
-- Data for Name: spouses; Type: TABLE DATA; Schema: public; Owner: JAmesB0nd
--

COPY spouses (leftspouse_id, rightspouse_id) FROM stdin;
1f719182d5b711e59dc6247703a3195c	362b9462cb3111e5bd753c970e1933ad
362b9462cb3111e5bd753c970e1933ad	1f719182d5b711e59dc6247703a3195c
18f4a0d2d5c211e59dc6247703a3195c	3a0fdbaed5bf11e59dc6247703a3195c
3a0fdbaed5bf11e59dc6247703a3195c	18f4a0d2d5c211e59dc6247703a3195c
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: JAmesB0nd
--

COPY users (id, email, password_hash, name, second_name, surname, sex, country_id, b_date, person_id, is_new, confirmed) FROM stdin;
b6d4309eca5d11e5a2db3c970e1933ad	ofajans@gmail.com	pbkdf2:sha1:1000$JW9gwscL$1fcd2530b2190634259b7c60b0d8d2cd5cb3db0b	Oleg Fayans	Fayans	Fayans	male	8289d3f8ca4d11e5b03a3c970e1933ad	1979-05-17	c404a4f6ca5d11e5a2db3c970e1933ad	f	t
196f78e6d81711e5aae9247703a3195c	shadow@gmail.com	pbkdf2:sha1:1000$iHgqEiPG$271960c3157c934ef5e8ca3eecd33eee69ec528b	Vasily		Pupkin	male	8289d3f8ca4d11e5b03a3c970e1933ad	1981-04-01	2b68bd12d81911e5b8db247703a3195c	f	t
\.


--
-- Name: country_pkey; Type: CONSTRAINT; Schema: public; Owner: JAmesB0nd; Tablespace: 
--

ALTER TABLE ONLY country
    ADD CONSTRAINT country_pkey PRIMARY KEY (id);


--
-- Name: family_pkey; Type: CONSTRAINT; Schema: public; Owner: JAmesB0nd; Tablespace: 
--

ALTER TABLE ONLY family
    ADD CONSTRAINT family_pkey PRIMARY KEY (id);


--
-- Name: legend_pkey; Type: CONSTRAINT; Schema: public; Owner: JAmesB0nd; Tablespace: 
--

ALTER TABLE ONLY legend
    ADD CONSTRAINT legend_pkey PRIMARY KEY (id);


--
-- Name: person_pkey; Type: CONSTRAINT; Schema: public; Owner: JAmesB0nd; Tablespace: 
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- Name: photo_pkey; Type: CONSTRAINT; Schema: public; Owner: JAmesB0nd; Tablespace: 
--

ALTER TABLE ONLY photo
    ADD CONSTRAINT photo_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: JAmesB0nd; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: ix_country_id; Type: INDEX; Schema: public; Owner: JAmesB0nd; Tablespace: 
--

CREATE INDEX ix_country_id ON country USING btree (id);


--
-- Name: ix_family_creator_id; Type: INDEX; Schema: public; Owner: JAmesB0nd; Tablespace: 
--

CREATE INDEX ix_family_creator_id ON family USING btree (creator_id);


--
-- Name: ix_family_id; Type: INDEX; Schema: public; Owner: JAmesB0nd; Tablespace: 
--

CREATE INDEX ix_family_id ON family USING btree (id);


--
-- Name: ix_legend_id; Type: INDEX; Schema: public; Owner: JAmesB0nd; Tablespace: 
--

CREATE INDEX ix_legend_id ON legend USING btree (id);


--
-- Name: ix_person_id; Type: INDEX; Schema: public; Owner: JAmesB0nd; Tablespace: 
--

CREATE INDEX ix_person_id ON person USING btree (id);


--
-- Name: ix_photo_id; Type: INDEX; Schema: public; Owner: JAmesB0nd; Tablespace: 
--

CREATE INDEX ix_photo_id ON photo USING btree (id);


--
-- Name: ix_users_email; Type: INDEX; Schema: public; Owner: JAmesB0nd; Tablespace: 
--

CREATE INDEX ix_users_email ON users USING btree (email);


--
-- Name: ix_users_id; Type: INDEX; Schema: public; Owner: JAmesB0nd; Tablespace: 
--

CREATE INDEX ix_users_id ON users USING btree (id);


--
-- Name: country_dvellers_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: JAmesB0nd
--

ALTER TABLE ONLY country_dvellers
    ADD CONSTRAINT country_dvellers_country_id_fkey FOREIGN KEY (country_id) REFERENCES country(id);


--
-- Name: country_dvellers_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: JAmesB0nd
--

ALTER TABLE ONLY country_dvellers
    ADD CONSTRAINT country_dvellers_person_id_fkey FOREIGN KEY (person_id) REFERENCES person(id);


--
-- Name: family_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: JAmesB0nd
--

ALTER TABLE ONLY family
    ADD CONSTRAINT family_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES users(id);


--
-- Name: family_members_family_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: JAmesB0nd
--

ALTER TABLE ONLY family_members
    ADD CONSTRAINT family_members_family_id_fkey FOREIGN KEY (family_id) REFERENCES family(id);


--
-- Name: family_members_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: JAmesB0nd
--

ALTER TABLE ONLY family_members
    ADD CONSTRAINT family_members_person_id_fkey FOREIGN KEY (person_id) REFERENCES person(id);


--
-- Name: legendparticipant_legend_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: JAmesB0nd
--

ALTER TABLE ONLY legendparticipant
    ADD CONSTRAINT legendparticipant_legend_id_fkey FOREIGN KEY (legend_id) REFERENCES legend(id);


--
-- Name: legendparticipant_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: JAmesB0nd
--

ALTER TABLE ONLY legendparticipant
    ADD CONSTRAINT legendparticipant_person_id_fkey FOREIGN KEY (person_id) REFERENCES person(id);


--
-- Name: person_ava_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: JAmesB0nd
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_ava_id_fkey FOREIGN KEY (ava_id) REFERENCES photo(id);


--
-- Name: person_father_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: JAmesB0nd
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_father_id_fkey FOREIGN KEY (father_id) REFERENCES person(id);


--
-- Name: person_mother_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: JAmesB0nd
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_mother_id_fkey FOREIGN KEY (mother_id) REFERENCES person(id);


--
-- Name: photoparticipant_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: JAmesB0nd
--

ALTER TABLE ONLY photoparticipant
    ADD CONSTRAINT photoparticipant_person_id_fkey FOREIGN KEY (person_id) REFERENCES person(id);


--
-- Name: photoparticipant_photo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: JAmesB0nd
--

ALTER TABLE ONLY photoparticipant
    ADD CONSTRAINT photoparticipant_photo_id_fkey FOREIGN KEY (photo_id) REFERENCES photo(id);


--
-- Name: spouses_leftspouse_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: JAmesB0nd
--

ALTER TABLE ONLY spouses
    ADD CONSTRAINT spouses_leftspouse_id_fkey FOREIGN KEY (leftspouse_id) REFERENCES person(id);


--
-- Name: spouses_rightspouse_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: JAmesB0nd
--

ALTER TABLE ONLY spouses
    ADD CONSTRAINT spouses_rightspouse_id_fkey FOREIGN KEY (rightspouse_id) REFERENCES person(id);


--
-- Name: users_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: JAmesB0nd
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_country_id_fkey FOREIGN KEY (country_id) REFERENCES country(id);


--
-- Name: users_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: JAmesB0nd
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

