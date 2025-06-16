--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13 (Debian 15.13-1.pgdg120+1)
-- Dumped by pg_dump version 17.5

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
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: device_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.device_type_enum AS ENUM (
    'watch',
    'tracker',
    'sensor',
    'other'
);


ALTER TYPE public.device_type_enum OWNER TO postgres;

--
-- Name: gender_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.gender_type AS ENUM (
    'man',
    'woman'
);


ALTER TYPE public.gender_type OWNER TO postgres;

--
-- Name: metric_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.metric_type_enum AS ENUM (
    'heart_rate',
    'blood_pressure',
    'oxygen',
    'temperature',
    'gps',
    'ecg',
    'glucose',
    'hydration',
    'cortisol',
    'stress',
    'body_composition'
);


ALTER TYPE public.metric_type_enum OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: athlete_rating; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.athlete_rating (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    athlete_id uuid NOT NULL,
    rating integer,
    update_date date
);


ALTER TABLE public.athlete_rating OWNER TO postgres;

--
-- Name: athletes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.athletes (
    athlete_id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    sport_category character varying(255),
    club character varying(255),
    coach character varying(255),
    medical_clearance boolean,
    insurance character varying(255),
    rank character varying(255)
);


ALTER TABLE public.athletes OWNER TO postgres;

--
-- Name: coach_certifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coach_certifications (
    certification_id uuid DEFAULT gen_random_uuid() NOT NULL,
    coach_id uuid NOT NULL,
    name character varying(255)
);


ALTER TABLE public.coach_certifications OWNER TO postgres;

--
-- Name: coaches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coaches (
    coach_id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    experience_years integer,
    affiliated_club character varying(255)
);


ALTER TABLE public.coaches OWNER TO postgres;

--
-- Name: competition_applications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.competition_applications (
    application_id uuid DEFAULT gen_random_uuid() NOT NULL,
    athlete_id uuid NOT NULL,
    competition_id uuid NOT NULL,
    status character varying(255),
    submission_date date
);


ALTER TABLE public.competition_applications OWNER TO postgres;

--
-- Name: competition_results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.competition_results (
    result_id uuid DEFAULT gen_random_uuid() NOT NULL,
    athlete_id uuid NOT NULL,
    competition_id uuid NOT NULL,
    result character varying(255),
    rating integer
);


ALTER TABLE public.competition_results OWNER TO postgres;

--
-- Name: competitions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.competitions (
    competition_id uuid DEFAULT gen_random_uuid() NOT NULL,
    organizer_id uuid NOT NULL,
    name character varying(255),
    date date,
    location character varying(255),
    participation_criteria character varying(255)
);


ALTER TABLE public.competitions OWNER TO postgres;

--
-- Name: completed_exercises; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.completed_exercises (
    completed_exercise_id uuid DEFAULT gen_random_uuid() NOT NULL,
    training_id uuid NOT NULL,
    exercise_id uuid NOT NULL,
    notes character varying(255)
);


ALTER TABLE public.completed_exercises OWNER TO postgres;

--
-- Name: completed_sets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.completed_sets (
    completed_set_id uuid DEFAULT gen_random_uuid() NOT NULL,
    completed_exercise_id uuid NOT NULL,
    set_number integer,
    repetitions integer,
    weight double precision,
    duration time without time zone
);


ALTER TABLE public.completed_sets OWNER TO postgres;

--
-- Name: device_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.device_data (
    data_id uuid DEFAULT gen_random_uuid() NOT NULL,
    device_id uuid NOT NULL,
    "timestamp" timestamp without time zone,
    metric_type public.metric_type_enum,
    value double precision,
    unit character varying(50)
);


ALTER TABLE public.device_data OWNER TO postgres;

--
-- Name: devices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.devices (
    device_id uuid DEFAULT gen_random_uuid() NOT NULL,
    athlete_id uuid NOT NULL,
    name character varying(255),
    type public.device_type_enum,
    model character varying(255),
    serial_number character varying(255),
    last_sync timestamp without time zone
);


ALTER TABLE public.devices OWNER TO postgres;

--
-- Name: exercises; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exercises (
    exercise_id uuid DEFAULT gen_random_uuid() NOT NULL,
    training_plan_id uuid NOT NULL,
    description character varying(255)
);


ALTER TABLE public.exercises OWNER TO postgres;

--
-- Name: favorites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favorites (
    favorite_id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    material_id uuid NOT NULL
);


ALTER TABLE public.favorites OWNER TO postgres;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.flyway_schema_history OWNER TO postgres;

--
-- Name: group_chat_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_chat_members (
    member_id uuid DEFAULT gen_random_uuid() NOT NULL,
    group_chat_id uuid NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.group_chat_members OWNER TO postgres;

--
-- Name: group_chats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_chats (
    group_chat_id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(255)
);


ALTER TABLE public.group_chats OWNER TO postgres;

--
-- Name: injuries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.injuries (
    injury_id uuid DEFAULT gen_random_uuid() NOT NULL,
    athlete_id uuid NOT NULL,
    description character varying(255),
    injury_date date,
    recovery_date date
);


ALTER TABLE public.injuries OWNER TO postgres;

--
-- Name: macro_cycles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.macro_cycles (
    macro_cycle_id uuid DEFAULT gen_random_uuid() NOT NULL,
    training_plan_id uuid NOT NULL,
    description character varying(255)
);


ALTER TABLE public.macro_cycles OWNER TO postgres;

--
-- Name: material_comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.material_comments (
    comment_id uuid DEFAULT gen_random_uuid() NOT NULL,
    material_id uuid NOT NULL,
    user_id uuid NOT NULL,
    text character varying(255),
    date date
);


ALTER TABLE public.material_comments OWNER TO postgres;

--
-- Name: materials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.materials (
    material_id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(255),
    type character varying(255),
    content character varying(255),
    publication_date date
);


ALTER TABLE public.materials OWNER TO postgres;

--
-- Name: medical_indicators; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medical_indicators (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    athlete_id uuid NOT NULL,
    pulse integer,
    blood_pressure character varying(255),
    oxygen_level integer,
    heart_rate_variability character varying(255),
    glucose_level integer,
    weight double precision,
    body_mass_index double precision,
    body_composition character varying(255),
    hydration_level character varying(255),
    resting_heart_rate integer,
    exercise_heart_rate integer,
    ecg_data character varying(255),
    measurement_date date
);


ALTER TABLE public.medical_indicators OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    message_id uuid DEFAULT gen_random_uuid() NOT NULL,
    sender_id uuid NOT NULL,
    receiver_id uuid NOT NULL,
    text character varying(255),
    date date,
    group_chat_id uuid
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: micro_cycles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.micro_cycles (
    micro_cycle_id uuid DEFAULT gen_random_uuid() NOT NULL,
    training_plan_id uuid NOT NULL,
    description character varying(255)
);


ALTER TABLE public.micro_cycles OWNER TO postgres;

--
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    notification_id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    message character varying(255),
    date date
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- Name: organizers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organizers (
    organizer_id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    organization character varying(255),
    license_number character varying(255)
);


ALTER TABLE public.organizers OWNER TO postgres;

--
-- Name: pulse_zones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pulse_zones (
    zone_id uuid DEFAULT gen_random_uuid() NOT NULL,
    training_plan_id uuid NOT NULL,
    min integer,
    max integer
);


ALTER TABLE public.pulse_zones OWNER TO postgres;

--
-- Name: rehabilitation_programs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rehabilitation_programs (
    rehabilitation_program_id uuid DEFAULT gen_random_uuid() NOT NULL,
    injury_id uuid NOT NULL,
    description character varying(255),
    start_date date,
    end_date date
);


ALTER TABLE public.rehabilitation_programs OWNER TO postgres;

--
-- Name: schedules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedules (
    schedule_id uuid DEFAULT gen_random_uuid() NOT NULL,
    competition_id uuid NOT NULL,
    event_description character varying(255),
    start_time timestamp without time zone,
    end_time timestamp without time zone
);


ALTER TABLE public.schedules OWNER TO postgres;

--
-- Name: training_plans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.training_plans (
    training_plan_id uuid DEFAULT gen_random_uuid() NOT NULL,
    coach_id uuid NOT NULL,
    name character varying(255),
    goals character varying(255),
    intensity character varying(255)
);


ALTER TABLE public.training_plans OWNER TO postgres;

--
-- Name: trainings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trainings (
    training_id uuid DEFAULT gen_random_uuid() NOT NULL,
    athlete_id uuid NOT NULL,
    training_plan_id uuid NOT NULL,
    date date,
    time_spent time without time zone,
    average_speed double precision,
    max_speed double precision,
    distance double precision
);


ALTER TABLE public.trainings OWNER TO postgres;

--
-- Name: user_credentials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_credentials (
    user_credentials_id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    login character varying(255),
    email character varying(255),
    password_hash character varying(255)
);


ALTER TABLE public.user_credentials OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id uuid DEFAULT gen_random_uuid() NOT NULL,
    full_name character varying(255),
    phone_number character varying(255),
    gender public.gender_type,
    birth_date date,
    citizenship character varying(255)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: athlete_rating; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.athlete_rating (id, athlete_id, rating, update_date) FROM stdin;
5bc70a81-0ddc-4053-8cdb-669df9815ae5	ad059698-d6de-42a7-af6d-6e3cd5a80846	16	2018-09-19
9842c5ec-788a-4b1a-acbf-d890e6a02995	98e78db7-fe89-45ea-a6f6-670350546c61	10	2016-07-24
1b1d7e62-49b1-4214-a8e7-19023830bb00	6f28b3fa-7e7b-4c66-823e-a1efd7993886	28	2024-08-04
c7e91ec1-6263-4f72-b05d-1a8fe97c7189	953cd6cf-72c3-4ffa-98c2-eb96e96c35bf	9	2018-07-05
48a316bc-13c9-46cd-abb2-5ed2d3c0f626	fc39f40d-e36c-4167-9de3-fe95b8ee2936	5	2016-06-06
cfae129b-2ef5-4159-af6b-588e83e0d61b	d622497b-0202-412e-b0b3-19d125499c0a	28	2024-03-20
7b2d7944-7414-4350-9d32-55b522b95522	3a4572b7-0b21-4f81-8052-0192e1fd87f2	24	2018-08-05
3339874e-a8ca-4ae6-a8f0-ae241b1c314f	4377f770-933d-40da-b890-094dc68a3d7e	26	2021-08-06
386fa245-6d9f-4f5d-9175-81e72e9345e7	98be8fb8-c108-41f5-9784-500225d7df73	7	2022-12-19
bc9a0cf7-ecf2-4f99-a9a7-265030f775de	1de452c3-d6a0-4013-b6a9-7823d32caa1e	29	2016-06-09
2d4e7b32-3af6-4dd2-b733-423033c69a7a	131064a7-47f4-4242-80c1-44661e6f0df8	8	2018-11-25
4bc1b3c9-ab73-461a-a539-9bd72b023402	48f8b0c8-3b66-4f02-bed0-47427f33c1e0	29	2020-08-15
f272ff42-bf66-4910-9bf8-fa9dbbbf66c0	4f7f13fe-f7f4-47f8-adcd-624ed032c498	6	2020-11-16
d50b9670-2a65-4a6d-891e-56f46197741c	32620980-8215-4340-a976-50ce6cb74e20	22	2018-10-28
c68d5999-2c04-4714-8cb2-98de92c86851	ba8f8660-ae06-42c2-8131-e19ebd96dabd	2	2018-12-21
2dbf2401-df55-4193-9d81-94e92f3cc687	ad6c6a84-da64-4ca0-a0d1-c56b692b66e2	1	2016-03-16
68e151fa-7624-4608-81f0-51910ace9409	dd151103-5216-4652-b088-8b801f33f90e	3	2022-08-20
e0712b51-f70e-41e0-891c-5964b71557d8	0320789b-2cc9-4e68-a63f-fcb3b6bbd1f3	29	2023-06-28
0b828568-5fb6-454f-b852-24494cccf406	e8ed0b59-2464-46d1-a3ea-760a861c2cfa	23	2024-12-12
03040d5a-8bf1-41ae-845e-71cbf8ffa66d	79f33da8-d2c1-47e5-8b55-a6817791e851	7	2025-02-05
570119ae-3d0d-4492-8979-b6d6b0090bd4	9d292bb9-aaac-4fbd-9500-9404f6052c3b	20	2019-02-18
56d45c91-2630-405e-99cc-eff7a341e294	26bbe248-334f-4642-91b1-4074c81a76b8	4	2017-11-10
59d202aa-e645-48e7-8f52-e76aac64c59d	5ed4532b-b825-4095-8e54-2cd72b9b3cd3	25	2022-08-23
096b47d9-5c67-409c-abb8-9570c537cf68	3781d7b2-ebe8-496b-b595-7c6df03dbc6b	11	2021-02-25
d4f72560-c589-44ab-8da0-36f02236d5f4	f01255a1-b841-4431-b871-ce578e5df7bc	29	2023-12-17
3a199afa-28b2-4c8e-a34c-381d86397049	bff1cbed-6310-4771-bc66-4250edc8b36d	24	2021-03-16
b090121e-9033-484d-822a-ad618cca5441	640c5882-ca7a-4e1e-b35f-dc744816cf19	12	2023-02-02
ee447cb5-0f92-4d26-b252-04d5dbe6dd62	1c0920bd-9da6-458f-8160-f1bb63f79110	30	2020-06-25
0f7ba0a6-fd6e-4078-bd42-51473a1dfed1	ed01eece-7ca3-4431-9dc1-c3e05b075317	15	2022-05-10
ef23bb42-1518-4a32-8134-68b13ebeb9b2	21632412-e2ea-4a43-affd-31d60c58825a	5	2019-08-10
e202a0ed-69f3-4da0-858e-fdaff3727adc	637fc7e1-b31f-4919-8aa9-56a5d18a867f	8	2021-09-20
e4bb497f-8c2e-4332-b0a8-2b64b26a7829	b2aa6266-a156-4b7b-a082-3ed6be62b785	11	2024-08-22
247916b2-272f-4781-8ec6-0d610edf9ed4	af4cef5c-fcfb-4d9e-8311-5f2afbcc4822	27	2025-03-07
b1c8a0a6-a1be-4713-b451-d4e24604ea02	c7db9c19-8c24-4e5f-a4e6-58e7d3cf7e7b	11	2020-03-05
9833226d-1a05-43f0-b66f-727898637740	c807894f-400a-4f5a-a8c5-16a058322b5a	18	2016-11-14
e78ff91d-8cf3-4f50-b073-1f9cf9083561	c4b5132b-0f2f-49f8-95fe-8249386a0c4d	4	2023-07-18
adaff9eb-d3c1-4fc7-816e-b2e9a1bb6a47	3b22f48a-507f-4125-80fe-14fb35f79813	11	2021-02-17
2d1f3289-601a-4d87-b62c-10c33da5e83a	3f3e7100-37be-4cca-bd2b-50076fbf6433	17	2017-04-17
4e4a8038-6335-4fdf-89b6-a4a84bcc0116	5b488f6a-ec5f-4cd7-b33b-07df4f1ad686	4	2016-03-05
964b9fdf-8856-4a6b-8ef4-ff768ae690b5	aaa8eaa2-2de4-483d-83dd-cacddd9c8ca7	4	2023-05-11
37d67552-c9c7-4149-994b-c95d470a5fe3	b03e2327-e236-416b-9a48-1f1d399b0f2f	3	2018-03-13
037a0f0a-0df7-4b7a-bea7-54be164f0161	5c1f7521-a44d-41d7-92d2-0cc010634b51	5	2023-04-24
f638db2e-f17e-4472-ad5a-8f33fdaf5694	591b5c8c-6e59-4ee3-82f3-ac750a58f9ea	30	2016-01-15
4a8056d6-3775-40aa-9831-dbbff7f607b6	7ccc9074-d6a7-41d7-8c78-888af1a02f64	28	2022-05-03
46ed4d90-098d-4015-8f55-c11b50d3a583	6bcfbadc-3ad5-4aa2-b0fe-7bf822a0e348	23	2017-03-01
e9dfa536-5092-4789-8256-d5a81adb831c	4e94fb48-87cf-4ea2-afe4-dad85b86803d	28	2023-07-03
9b90965f-deab-4243-8bce-c084f62d19dd	8a6ecf81-1721-463f-a801-2a3b90146a43	29	2021-12-17
0831d271-6575-49f5-aaf9-7389e8f8499e	1341ba9e-9910-4ad7-a5dd-d929791400a0	29	2022-12-05
dc19bd86-e80c-4342-babf-8650e5e161dc	05d49901-ba9b-4697-8ff4-e7b40e298398	28	2025-02-01
7c5e7b5b-d573-4d3d-bb64-5f3d8e13f02e	7d9dfa62-28c8-4bb0-a163-a0cb871ef3fc	20	2016-10-28
954f7ad1-2ae0-41ff-b1cf-ad146911a1cc	810089bb-05f0-44c4-bd74-2c7ba11f204c	21	2021-08-27
4a52e41b-c2d8-48c1-8ec7-d2b016667bf4	f34e0e68-b2c1-4d38-aafb-1a6be7f98db0	25	2020-04-08
f1cd4fb1-22c9-410f-ad23-35ce2565b566	0379ca12-1fb4-4f34-972f-7808d3917ac9	23	2025-06-18
c162b19d-18bb-4833-8aeb-88dd789f6ceb	d197f940-9bdb-48a1-be54-70e86ba92aaa	26	2023-12-11
c27f4c80-cf1f-418f-8ab5-1ab160210804	8012d9bd-f2b5-424a-b1f2-a81fa3d853da	21	2025-02-04
bf66fe74-1d2c-420b-a530-9d25d910bdee	b89c07b4-0c57-4077-9535-e678989422e5	2	2016-12-09
c15e6395-6c0f-4392-9f77-6bcf3739a9c3	b77f011c-4c73-4659-916b-c7d91ed8667b	30	2018-12-03
011d09cc-1265-43f7-8064-85b9d4a5c7b6	b1a706a8-448d-4a86-857c-877b3d36a909	12	2025-12-01
2a97f82f-444f-434c-a731-7a07daee20ab	caf1758c-d025-4d5e-aea0-8a9cf858617c	10	2017-01-06
5fd72d7e-f920-41cd-8bd1-3cd34d402bdb	67806c4a-b344-45b6-90dc-96e256a46db8	30	2025-04-14
bcc8bf40-aea2-4bfc-9922-0a8d2ca4aff5	c0ddf7eb-77a3-4fda-b3fb-ecb3d3e6daf6	15	2020-07-13
6b12f320-2cfc-427f-a770-4fa869b6345a	bd1a8138-357f-4831-9387-38412bbfe4ee	17	2017-11-13
3351b24a-c130-423c-8cdc-14474ded77be	de5469f5-694d-457c-b0dc-cf1ab74401e1	23	2020-06-18
9a1a4d72-e530-46ee-aafb-9e00fc9b0c23	2de7e285-5063-4bc0-82a2-1d802627fb90	5	2017-11-14
f06ac59b-613a-483c-9f06-8eed6037f9dc	13327720-e8e2-4545-85ab-a5f1dbc0fa9a	12	2018-01-04
4353b1c6-43d0-4552-9d79-ff294a86dbf9	8df7f275-ea8f-47ac-b543-937223141467	19	2016-10-11
\.


--
-- Data for Name: athletes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.athletes (athlete_id, user_id, sport_category, club, coach, medical_clearance, insurance, rank) FROM stdin;
ad059698-d6de-42a7-af6d-6e3cd5a80846	acdfffcf-d93a-4817-87f8-253fc3c4f861	Пауэрлифтинг	ТехноЛабЛтд	Lord Hal Langworth	f	АльфаСтрахование	3 разряд
98e78db7-fe89-45ea-a6f6-670350546c61	3b6e1bff-a157-4c5d-a200-b2565c7eb172	Баскетбол	ГлобалСофтСолюшнс	Prince Maverick Crist	t	Росгосстрах	2 разряд
6f28b3fa-7e7b-4c66-823e-a1efd7993886	e9fc1da8-1c27-4c4f-8d2e-ec6e46550d0a	Дзюдо	ЭкоСистем	Mr. Darrion Quigley	f	Ингосстрах	2 разряд
953cd6cf-72c3-4ffa-98c2-eb96e96c35bf	3edd911b-fcec-4527-9863-46607c8be987	Тяжёлая атлетика	ГлобалЛабСолюшнс	Prof. Bradly Considine	t	Росгосстрах	МС
fc39f40d-e36c-4167-9de3-fe95b8ee2936	ff8a03bd-05cf-4476-9d53-e72527f78b97	Тяжёлая атлетика	ЭкоСофт	Dr. Theo Roob	t	РЕСО-Гарантия	1 разряд
d622497b-0202-412e-b0b3-19d125499c0a	9bec1b18-7ff0-48e8-9f55-ed60e2d4cbfb	Тяжёлая атлетика	ЭкоТрейд	Prince Jennings Hilll	t	Ингосстрах	МС
3a4572b7-0b21-4f81-8052-0192e1fd87f2	15825a85-1d72-452e-9c85-9c281cd2b9ef	Пауэрлифтинг	ГлобалЛаб	Lord Colten Kshlerin	t	АльфаСтрахование	3 разряд
4377f770-933d-40da-b890-094dc68a3d7e	a0d2dc81-9f48-4a61-b622-3ecded01d8d1	Плавание	ТехноЛаб	Prince Emmitt Bogisich	t	СОГАЗ	КМС
98be8fb8-c108-41f5-9784-500225d7df73	1fc48383-ac44-41aa-93b7-cc350b437e0d	Пауэрлифтинг	ГлобалТрейдСолюшнс	Lord Kiel Kunde	t	Росгосстрах	МСМК
1de452c3-d6a0-4013-b6a9-7823d32caa1e	dbc2bc60-18d7-40a5-b6b5-023999f69c7f	Баскетбол	ТехноСервис	King Rasheed Durgan	f	Росгосстрах	3 разряд
131064a7-47f4-4242-80c1-44661e6f0df8	d105751f-5139-45ae-b658-d321dbf4e961	Лёгкая атлетика	ТехноСофт	Dr. Matt Harber	t	Росгосстрах	1 разряд
48f8b0c8-3b66-4f02-bed0-47427f33c1e0	e93a12f3-0bf9-496c-8d3a-5d2f42943f3b	Лёгкая атлетика	ИнфоТрейд	Prof. Greg Pouros	f	СОГАЗ	МСМК
4f7f13fe-f7f4-47f8-adcd-624ed032c498	52c84561-4233-4b5e-a662-692571935818	Плавание	ТехноЛаб	Prince Bernie Smitham	t	Ингосстрах	3 разряд
32620980-8215-4340-a976-50ce6cb74e20	abb3ff00-aff7-4ecc-8e19-ed23d9d6eaff	Фехтование	ЭкоСофтСолюшнс	Prince Louie Moore	t	Росгосстрах	МСМК
ba8f8660-ae06-42c2-8131-e19ebd96dabd	588bcdde-f69e-4aa4-9868-777f659b4d82	Баскетбол	ТехноТрейдСолюшнс	Mr. Rory Fahey	t	Росгосстрах	МС
ad6c6a84-da64-4ca0-a0d1-c56b692b66e2	86470be7-4cf3-4483-9014-289c012be9a5	Пауэрлифтинг	ИнфоСервис	Prince Jarrod Haag	f	Ингосстрах	КМС
dd151103-5216-4652-b088-8b801f33f90e	e0c84fd2-61b3-44c3-96b2-e320099ff540	Баскетбол	ИнфоТрейд	King Ryder Metz	t	АльфаСтрахование	КМС
0320789b-2cc9-4e68-a63f-fcb3b6bbd1f3	9980b872-1ad9-414b-93c9-301e39788bd8	Лёгкая атлетика	ТехноСофт	King Josiah Prosacco	f	Ингосстрах	3 разряд
e8ed0b59-2464-46d1-a3ea-760a861c2cfa	eb3aaa49-49b9-411e-93ff-3309c3f85033	Лёгкая атлетика	ЭкоСофтЛтд	Dr. Jonathan Hilll	t	Ингосстрах	3 разряд
79f33da8-d2c1-47e5-8b55-a6817791e851	7bd7833c-9ea0-4e04-b9e2-f1bca999de28	Плавание	ТехноСистемСолюшнс	Prince Elvis Miller	f	Росгосстрах	2 разряд
9d292bb9-aaac-4fbd-9500-9404f6052c3b	d144b392-0f6b-4a5a-9d47-7404340d3cbf	Лёгкая атлетика	ТехноСервисСолюшнс	Lord Armand Stracke	f	АльфаСтрахование	МС
26bbe248-334f-4642-91b1-4074c81a76b8	663eaf77-4ba3-44a1-a7ef-6414810acb3a	Лёгкая атлетика	ЭкоСистемСолюшнс	Dr. Werner Schaden	t	Росгосстрах	2 разряд
5ed4532b-b825-4095-8e54-2cd72b9b3cd3	6cced495-ec1f-4451-9cfa-79303b413ecf	Плавание	ТехноСервисИнк	Lord Wyatt Heathcote	t	АльфаСтрахование	1 разряд
3781d7b2-ebe8-496b-b595-7c6df03dbc6b	dc33737a-36f6-4d37-8e04-9f09279da0f8	Пауэрлифтинг	ТехноСервис	Lord Clay Gleason	f	АльфаСтрахование	1 разряд
f01255a1-b841-4431-b871-ce578e5df7bc	4845be0f-92e5-4e55-b00e-a21359b5ca1a	Тяжёлая атлетика	ЭкоСистем	Lord Antwan Jones	t	СОГАЗ	2 разряд
bff1cbed-6310-4771-bc66-4250edc8b36d	19eb8f4e-eb7c-4784-ae9c-d992d1e1370a	Плавание	ТехноЛабГрупп	Mr. Skylar Terry	f	Росгосстрах	1 разряд
640c5882-ca7a-4e1e-b35f-dc744816cf19	d8c9f3ac-22ea-42c0-b786-87b0b78bbd21	Тяжёлая атлетика	ЭкоСофт	Prince Terrence Ritchie	f	АльфаСтрахование	2 разряд
1c0920bd-9da6-458f-8160-f1bb63f79110	01ce86d4-54d0-40e7-9bdc-db3cd88cf621	Пауэрлифтинг	ЭкоТрейд	Mr. Marques Gibson	t	АльфаСтрахование	2 разряд
ed01eece-7ca3-4431-9dc1-c3e05b075317	9fbf1314-b152-41e7-bd83-ab909be70c50	Лёгкая атлетика	ТехноСофтЛтд	Prof. Misael Parisian	f	Ингосстрах	3 разряд
21632412-e2ea-4a43-affd-31d60c58825a	32b3c932-48f1-4f6b-9e64-355c7a634b4d	Тяжёлая атлетика	АльфаЛабГрупп	Mr. Mac Rau	f	Росгосстрах	2 разряд
637fc7e1-b31f-4919-8aa9-56a5d18a867f	10ac13d6-73ca-4cbf-a5d2-b85403e7faed	Лёгкая атлетика	ЭкоСофт	Lord Ceasar Hayes	f	Ингосстрах	КМС
b2aa6266-a156-4b7b-a082-3ed6be62b785	d9a3e93c-865e-4cf3-9bee-c313bbe57610	Лёгкая атлетика	ИнфоСофт	Mr. Ben Cremin	f	АльфаСтрахование	КМС
af4cef5c-fcfb-4d9e-8311-5f2afbcc4822	f0fc13f4-13a4-42c2-91f3-d5dffa49d43b	Лёгкая атлетика	ТехноСофтГрупп	Dr. Raleigh Bernhard	t	Росгосстрах	2 разряд
c7db9c19-8c24-4e5f-a4e6-58e7d3cf7e7b	9a2ec07e-02cd-41b9-a9af-f22e909d0b1a	Плавание	ЭкоЛаб	Dr. Ervin Hamill	t	Ингосстрах	2 разряд
c807894f-400a-4f5a-a8c5-16a058322b5a	72b17e5a-a0bb-472a-91a3-b5dbd13caaae	Биатлон	ТехноСистемГрупп	Prince Jordon Rogahn	f	Росгосстрах	МС
c4b5132b-0f2f-49f8-95fe-8249386a0c4d	a24788ba-9862-480a-84b4-0ee112eb7700	Плавание	ТехноТрейдСолюшнс	Mr. Randi Terry	f	СОГАЗ	2 разряд
3b22f48a-507f-4125-80fe-14fb35f79813	fda19059-e00a-4a2d-b68c-d1a7512f1401	Бокс	ТехноСистем	Prince Johnathan O'Kon	t	АльфаСтрахование	МСМК
3f3e7100-37be-4cca-bd2b-50076fbf6433	f53c0e7f-7f99-4cbe-924f-4a852f225b50	Лёгкая атлетика	ГлобалСистемСолюшнс	Dr. Javonte Feest	f	СОГАЗ	2 разряд
5b488f6a-ec5f-4cd7-b33b-07df4f1ad686	5cf96c40-3094-4999-913a-e378e31c82e6	Лёгкая атлетика	ТехноСофтИнк	Dr. Jason Prosacco	f	РЕСО-Гарантия	2 разряд
aaa8eaa2-2de4-483d-83dd-cacddd9c8ca7	854e0483-705e-4950-b861-cb3801c7748e	Баскетбол	ЭкоСистем	Lord Joel Farrell	f	Ингосстрах	3 разряд
b03e2327-e236-416b-9a48-1f1d399b0f2f	d22988e3-453f-4af2-bed8-6b2805dd330d	Фехтование	ЭкоСервис	Prince Rodger Marquardt	f	АльфаСтрахование	1 разряд
5c1f7521-a44d-41d7-92d2-0cc010634b51	9f1bbc93-27a2-440b-8410-115241e1cd6c	Лёгкая атлетика	ТехноСервис	King Jerrod Prosacco	f	Росгосстрах	1 разряд
591b5c8c-6e59-4ee3-82f3-ac750a58f9ea	642df5af-cea9-49c1-a820-f60bc0e5f451	Гимнастика	ТехноСистемГрупп	Lord Winfield Schiller	f	Росгосстрах	3 разряд
7ccc9074-d6a7-41d7-8c78-888af1a02f64	c3567130-5f32-42dc-85f7-cddd10b583e9	Гимнастика	ИнфоСофтСолюшнс	Mr. Rogers Romaguera	f	Ингосстрах	МСМК
6bcfbadc-3ad5-4aa2-b0fe-7bf822a0e348	c1e1b966-9289-470c-838e-c7d706186871	Биатлон	ТехноСервисГрупп	Prof. Khalid Kemmer	f	Ингосстрах	3 разряд
4e94fb48-87cf-4ea2-afe4-dad85b86803d	8f5ff173-7446-43ca-a127-61e51fb2f744	Баскетбол	ИнфоЛабЛтд	Dr. Ronny Stamm	f	Ингосстрах	1 разряд
8a6ecf81-1721-463f-a801-2a3b90146a43	d8855132-907d-4eca-852f-75d40c6402e2	Бокс	ТехноСистемГрупп	Prof. Lambert Kovacek	f	Росгосстрах	КМС
1341ba9e-9910-4ad7-a5dd-d929791400a0	62f01ea8-945b-4884-aa68-6c7572c1d78c	Баскетбол	ТехноСофтСолюшнс	Prince Conner DuBuque	f	АльфаСтрахование	МС
05d49901-ba9b-4697-8ff4-e7b40e298398	47b41895-741c-4b99-8d93-b7dcf413e66c	Пауэрлифтинг	ЭкоСервисГрупп	King Wiley Zulauf	f	Ингосстрах	2 разряд
7d9dfa62-28c8-4bb0-a163-a0cb871ef3fc	8e0ecf55-df9d-4a5f-a24d-2613cc41be4b	Плавание	ЭкоСервисЛтд	King Royce Gusikowski	f	Росгосстрах	3 разряд
810089bb-05f0-44c4-bd74-2c7ba11f204c	0e8e8e3e-ea1a-4248-9c1e-62850a4bed89	Пауэрлифтинг	ТехноТрейд	Mr. Tre Flatley	f	Росгосстрах	Элита
f34e0e68-b2c1-4d38-aafb-1a6be7f98db0	7fd94df0-1a06-4540-9042-36e909db2efb	Плавание	ЭкоСофтЛтд	Dr. Easton Wiegand	f	СОГАЗ	2 разряд
0379ca12-1fb4-4f34-972f-7808d3917ac9	70ca91b6-ad56-4c89-8bc7-983a763077a7	Лёгкая атлетика	ИнфоТрейдГрупп	King Jonas Parker	f	Ингосстрах	2 разряд
d197f940-9bdb-48a1-be54-70e86ba92aaa	bf34227e-cd86-437f-95f5-d48fb096f657	Лёгкая атлетика	АльфаТрейд	King Guillermo Boyle	f	Ингосстрах	2 разряд
8012d9bd-f2b5-424a-b1f2-a81fa3d853da	9b72e6c9-d795-40a9-8d6d-abd1150c9aca	Лёгкая атлетика	ИнфоСистемЛтд	Prince Ahmed Collins	t	СОГАЗ	3 разряд
b89c07b4-0c57-4077-9535-e678989422e5	cf540071-ebc4-4cf2-95d0-ece5567b6a8a	Плавание	ГлобалСервисСолюшнс	Dr. Otto Padberg	f	АльфаСтрахование	МСМК
b77f011c-4c73-4659-916b-c7d91ed8667b	99df127a-484d-44c7-a6e9-d7e744c54053	Тяжёлая атлетика	ТехноСервисСолюшнс	Prince Mustafa Sipes	f	Росгосстрах	Элита
b1a706a8-448d-4a86-857c-877b3d36a909	b17e3885-5d00-439a-bb47-e64cca4c9995	Плавание	ИнфоСистемЛтд	Dr. Timmy Carroll	t	СОГАЗ	МС
caf1758c-d025-4d5e-aea0-8a9cf858617c	6c8bb259-f4c1-44c8-bfb2-f33ff0700b27	Плавание	ЭкоСистем	Dr. Joe Windler	f	АльфаСтрахование	МС
67806c4a-b344-45b6-90dc-96e256a46db8	ab2c6c39-d8f5-4af7-b020-e6eafca298eb	Бокс	ИнфоСофт	Dr. Salvador Crooks	t	СОГАЗ	1 разряд
c0ddf7eb-77a3-4fda-b3fb-ecb3d3e6daf6	94b334d4-8b5d-4200-b863-730e3c6628a8	Тяжёлая атлетика	ТехноСистемГрупп	Mr. Adan Hilll	t	Росгосстрах	МС
bd1a8138-357f-4831-9387-38412bbfe4ee	bee55ca1-cc5d-4e4a-8d4a-249b86a86737	Бокс	ИнфоЛабЛтд	Mr. Thurman Romaguera	t	Ингосстрах	1 разряд
de5469f5-694d-457c-b0dc-cf1ab74401e1	fba1c228-3a75-413e-891e-5bddcffa2007	Биатлон	ИнфоЛабСолюшнс	Lord Napoleon Bogisich	t	Ингосстрах	2 разряд
2de7e285-5063-4bc0-82a2-1d802627fb90	aea78d3a-2b93-4cd1-9b25-c69d5aeba20b	Плавание	ТехноТрейд	Prince Nicholaus Pfeffer	f	АльфаСтрахование	МСМК
13327720-e8e2-4545-85ab-a5f1dbc0fa9a	e56fad7f-f5b5-45f9-82d9-cfa6b761b8cb	Плавание	ТехноСистемСолюшнс	Mr. Gunner DuBuque	f	РЕСО-Гарантия	МС
8df7f275-ea8f-47ac-b543-937223141467	61d282ce-1edd-46d0-8831-801c0f1b82b5	Лёгкая атлетика	ТехноСофтГрупп	Mr. Johnnie Rempel	f	Росгосстрах	МС
\.


--
-- Data for Name: coach_certifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.coach_certifications (certification_id, coach_id, name) FROM stdin;
\.


--
-- Data for Name: coaches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.coaches (coach_id, user_id, experience_years, affiliated_club) FROM stdin;
bb4cb1fc-f530-4120-9b9f-4030e3d231d9	ab9a61bf-60ef-4d02-a79a-e16e1eccd8d1	43	ТехноСервис
3f3c69c0-16c5-43e5-a2ee-e3521a8bee5c	936a095a-c5ae-4f1a-91e7-58e930d38700	50	ЭкоСистемГрупп
aa5a4c3f-85e1-4330-98dd-07a586978a87	216e5a26-41c0-42b2-9622-c89c44f0fc27	23	АльфаСофтГрупп
097a231f-9a98-4d8c-9da6-6720df2fcf52	0ff2642e-2f6f-42e2-a0f6-3c0eebcd765f	23	ИнфоСервис
eebcc6df-9dc9-49d6-8e38-9e2b20d0123a	81419018-a89c-42bb-80c6-3cd70f4fb020	24	ГлобалСофт
e235f796-9500-4f50-b1e5-6952c4fb8381	3164d8d8-2517-4e9b-ac73-84802e3322cc	29	ТехноСервис
a814bb3e-6ddf-4b45-9f6b-bed80971f5ce	648de0b0-332b-4a2a-b6ee-a19b64d20aa7	33	ИнфоЛабСолюшнс
98b861b7-9bc4-469c-8882-2100d4acc966	31e3a92a-deef-464c-9a6c-ce2084ec4e77	24	ГлобалТрейдГрупп
4ee0c506-25df-4217-8b78-ddd39fd6e30c	2dd4b7f1-4779-4e95-8276-9a2a5d4db550	1	ИнфоСервисГрупп
85fa4bb3-8675-46c3-81b3-6c98760d91c1	48117389-3c10-4fee-9b35-172558be8086	3	ИнфоЛабСолюшнс
d4fef24d-fe5a-437c-bb4f-51d564f6dcea	bf6506d5-fc4f-4a3e-914a-5ffac04f487a	28	ЭкоСервис
e0ec283c-e3ef-48b5-a054-0eafdd41e921	4d06c317-d321-4dfc-b52d-a354741fb449	16	ТехноСофтГрупп
d7f6784a-8939-404e-9dfe-fe0c11eb459c	e186b3a9-9944-470b-9c6e-d2f598fe3bae	5	ТехноСофт
be38dc88-9a42-40a3-9914-232aaa16ee7d	4b3e8f5c-f3dc-4338-bfb1-145afeabff33	21	ЭкоСистемГрупп
3fc98f3a-ae5a-4783-a602-f5b6ebdce5d1	15f7316b-4bfc-48e1-b5be-a1b87f731d5f	6	ГлобалТрейд
8f10afa1-db1d-47ec-a806-4016a65962ef	52cf3c15-370d-4e6c-839e-e630a358406a	48	ИнфоТрейдСолюшнс
\.


--
-- Data for Name: competition_applications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.competition_applications (application_id, athlete_id, competition_id, status, submission_date) FROM stdin;
b78c6f4c-18c3-4db5-8aee-da535566cc70	ad059698-d6de-42a7-af6d-6e3cd5a80846	a38b4271-2e58-40a2-a825-d5116b705634	pending	2025-06-02
66fb5df6-65da-4f8d-ac47-122269e2c331	6f28b3fa-7e7b-4c66-823e-a1efd7993886	f54d8923-70c6-4983-94d5-1fc634befe2e	pending	2025-06-03
a27e529e-d475-4bcb-9eb3-22293f14e10d	98be8fb8-c108-41f5-9784-500225d7df73	4540370e-43ad-410e-aecc-2fa2c2082a03	approved	2025-05-28
89b5d045-c324-4308-a5ee-b570ad996f86	ad6c6a84-da64-4ca0-a0d1-c56b692b66e2	f54d8923-70c6-4983-94d5-1fc634befe2e	pending	2025-06-04
f6c3de11-10e0-464e-af22-59ab1ba4f49c	e8ed0b59-2464-46d1-a3ea-760a861c2cfa	3bd14fe7-af8c-47fe-888a-14e2103d23a4	rejected	2025-06-03
6a3dd7a9-6f40-4026-a14a-88a52002b5c0	79f33da8-d2c1-47e5-8b55-a6817791e851	6a95bc88-b42c-4ed9-81a5-157dec755085	approved	2025-05-28
2501a50c-8755-4e80-8c28-53e948055df9	f01255a1-b841-4431-b871-ce578e5df7bc	63fa3904-8855-40eb-8cf5-c01d80e0fa19	rejected	2025-05-31
4691713d-a521-4134-a173-1a99172272ca	bff1cbed-6310-4771-bc66-4250edc8b36d	6a95bc88-b42c-4ed9-81a5-157dec755085	approved	2025-05-29
b6b6cdd2-25ff-4299-9718-8f9406979759	640c5882-ca7a-4e1e-b35f-dc744816cf19	a38b4271-2e58-40a2-a825-d5116b705634	rejected	2025-05-27
331f06fb-c7a6-4faa-ad35-c31f91639824	1c0920bd-9da6-458f-8160-f1bb63f79110	c1cb5834-eaa3-41ad-8c9a-b858a4d0d233	approved	2025-05-27
54c6ab7e-6e58-42b8-a933-791fffeec102	21632412-e2ea-4a43-affd-31d60c58825a	bce3092e-6b2f-43c1-936d-58b768f6f327	approved	2025-05-27
7f182891-b0ee-444b-bcca-0e8908687751	637fc7e1-b31f-4919-8aa9-56a5d18a867f	f54d8923-70c6-4983-94d5-1fc634befe2e	approved	2025-06-01
f860faab-cb31-42e0-bf67-7894120e970b	b2aa6266-a156-4b7b-a082-3ed6be62b785	3bd14fe7-af8c-47fe-888a-14e2103d23a4	pending	2025-05-30
58393363-5100-4a8f-a88b-bcea3a213099	af4cef5c-fcfb-4d9e-8311-5f2afbcc4822	14eea280-f55a-4a15-ab0e-afdbce799216	pending	2025-05-28
e40e3b4d-3318-4641-bf05-2f523834d174	c7db9c19-8c24-4e5f-a4e6-58e7d3cf7e7b	18038d48-ba3e-44d8-af9c-c15ebd59b53b	pending	2025-05-26
67e5af6a-1da4-4179-acc1-01b149ce90d1	c4b5132b-0f2f-49f8-95fe-8249386a0c4d	6a95bc88-b42c-4ed9-81a5-157dec755085	rejected	2025-05-27
ac41ee87-dc97-4dfe-bdcb-acd95d2a67bf	5c1f7521-a44d-41d7-92d2-0cc010634b51	4540370e-43ad-410e-aecc-2fa2c2082a03	pending	2025-05-27
7bc7108a-acbd-4d59-b4c5-b5f723501c74	591b5c8c-6e59-4ee3-82f3-ac750a58f9ea	3bd14fe7-af8c-47fe-888a-14e2103d23a4	rejected	2025-06-01
1f970bd7-79cb-424b-8c2f-831af4996490	4e94fb48-87cf-4ea2-afe4-dad85b86803d	a38b4271-2e58-40a2-a825-d5116b705634	approved	2025-05-26
563a84c7-5909-41ae-a3b3-445f59083378	8a6ecf81-1721-463f-a801-2a3b90146a43	5de02e63-9f70-4d2d-8be5-2f3892595dc6	approved	2025-05-28
9981b46e-771c-49c5-b7df-a87e5632730c	7d9dfa62-28c8-4bb0-a163-a0cb871ef3fc	a38b4271-2e58-40a2-a825-d5116b705634	pending	2025-05-27
0a498f72-325c-47dc-82b0-b6514c6c91fa	8012d9bd-f2b5-424a-b1f2-a81fa3d853da	a38b4271-2e58-40a2-a825-d5116b705634	approved	2025-06-03
e1562010-23fb-472a-9cb3-b9085e554112	b89c07b4-0c57-4077-9535-e678989422e5	3bd14fe7-af8c-47fe-888a-14e2103d23a4	pending	2025-05-29
adb2f670-a794-4d4e-a388-f1ca4912694f	b77f011c-4c73-4659-916b-c7d91ed8667b	f54d8923-70c6-4983-94d5-1fc634befe2e	pending	2025-05-27
17d3b1d6-e01a-47d0-ac4e-e3958f8ec20c	caf1758c-d025-4d5e-aea0-8a9cf858617c	63fa3904-8855-40eb-8cf5-c01d80e0fa19	pending	2025-05-27
7d6d6733-1ad6-41ea-8775-4a07a4aa6869	67806c4a-b344-45b6-90dc-96e256a46db8	63fa3904-8855-40eb-8cf5-c01d80e0fa19	pending	2025-06-04
335ffd5f-5db7-44a3-a114-e0146f296f14	c0ddf7eb-77a3-4fda-b3fb-ecb3d3e6daf6	96439dc7-c1d0-49b1-8a89-3262196a81ad	approved	2025-05-31
21ce44ef-6c60-409e-96fe-1277d2e7c19e	8df7f275-ea8f-47ac-b543-937223141467	607d38a5-08a7-493e-b5dc-6f543f3f0530	rejected	2025-06-02
\.


--
-- Data for Name: competition_results; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.competition_results (result_id, athlete_id, competition_id, result, rating) FROM stdin;
29a31073-d37f-4d91-bb4c-966c14a46b78	6f28b3fa-7e7b-4c66-823e-a1efd7993886	4540370e-43ad-410e-aecc-2fa2c2082a03	1:34	65
29b39a34-97d1-4df4-8759-2b2201b0fa05	98be8fb8-c108-41f5-9784-500225d7df73	607d38a5-08a7-493e-b5dc-6f543f3f0530	3:10	97
41902367-fa3d-4a96-af9a-8321bffbf391	131064a7-47f4-4242-80c1-44661e6f0df8	c1cb5834-eaa3-41ad-8c9a-b858a4d0d233	4:17	4
7d13c684-e351-442c-9925-b58d05c1e592	79f33da8-d2c1-47e5-8b55-a6817791e851	6a95bc88-b42c-4ed9-81a5-157dec755085	4:04	48
311c602f-0f2e-44e5-aa78-49663770f9f6	26bbe248-334f-4642-91b1-4074c81a76b8	14eea280-f55a-4a15-ab0e-afdbce799216	4:29	55
420fdec2-022d-4066-8f26-cb350567531e	640c5882-ca7a-4e1e-b35f-dc744816cf19	5de02e63-9f70-4d2d-8be5-2f3892595dc6	3:05	48
5ecb7722-8edb-470d-b6c6-acbdbfd45978	1c0920bd-9da6-458f-8160-f1bb63f79110	c1cb5834-eaa3-41ad-8c9a-b858a4d0d233	4:55	71
a5718fe5-7161-4e9b-a460-44755c9c038f	ed01eece-7ca3-4431-9dc1-c3e05b075317	987876e1-e4f9-46fe-a136-292eaf5f131b	2:27	53
4d54b06f-ba4f-40a4-a108-bca43249941d	af4cef5c-fcfb-4d9e-8311-5f2afbcc4822	874a9209-6751-4a72-b9be-5ff8e5f295b8	1:27	4
1fc1b8b0-e89b-487f-91e8-31de536a4ab9	c4b5132b-0f2f-49f8-95fe-8249386a0c4d	bce3092e-6b2f-43c1-936d-58b768f6f327	2:32	61
40ee3d24-8116-4435-af2e-6bc55d33d4b5	5b488f6a-ec5f-4cd7-b33b-07df4f1ad686	bce3092e-6b2f-43c1-936d-58b768f6f327	0:35	68
3cd7ae31-d091-44cb-aa2a-ff78e7926797	b03e2327-e236-416b-9a48-1f1d399b0f2f	18038d48-ba3e-44d8-af9c-c15ebd59b53b	2:31	96
8cd0f5f1-b553-476a-950d-42a7ccdecedc	6bcfbadc-3ad5-4aa2-b0fe-7bf822a0e348	a38b4271-2e58-40a2-a825-d5116b705634	0:29	24
177fc834-c02e-4153-85cf-20df9556478f	8a6ecf81-1721-463f-a801-2a3b90146a43	bce3092e-6b2f-43c1-936d-58b768f6f327	3:32	47
306b2d2e-740e-4bc5-91cb-f7962c894eef	05d49901-ba9b-4697-8ff4-e7b40e298398	b3216109-3f13-480d-85c4-c5339d358ab9	1:39	88
f363ebee-2199-4e21-8e5c-c3c16afb809e	7d9dfa62-28c8-4bb0-a163-a0cb871ef3fc	4540370e-43ad-410e-aecc-2fa2c2082a03	0:17	68
b533707d-70cb-4186-9d9f-41ce0cd154c5	8012d9bd-f2b5-424a-b1f2-a81fa3d853da	a38b4271-2e58-40a2-a825-d5116b705634	4:30	59
7e79eb6f-7e22-42fa-880b-65213644e80a	b89c07b4-0c57-4077-9535-e678989422e5	f7ea919a-0a7d-4748-a2ca-4e02a7089a4e	3:54	72
368271cf-4a89-40d4-aed0-39b3a64a0451	bd1a8138-357f-4831-9387-38412bbfe4ee	63fa3904-8855-40eb-8cf5-c01d80e0fa19	3:47	41
\.


--
-- Data for Name: competitions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.competitions (competition_id, organizer_id, name, date, location, participation_criteria) FROM stdin;
b3216109-3f13-480d-85c4-c5339d358ab9	2b5df83f-49f6-4fd1-9772-199308e1334d	Соревнование quia	2025-08-15	aperiam	Уровень допуска: cumque
bce3092e-6b2f-43c1-936d-58b768f6f327	8ac8e5dc-d530-4f32-9862-c92a8e6e80c6	Соревнование corrupti	2025-08-06	sed	Уровень допуска: rerum
874a9209-6751-4a72-b9be-5ff8e5f295b8	e929409b-0536-43dc-86b8-181df183e64a	Соревнование quos	2025-07-01	debitis	Уровень допуска: quia
5de02e63-9f70-4d2d-8be5-2f3892595dc6	e5d6cd9a-ce35-4513-b812-53251fd5f616	Соревнование voluptas	2025-06-24	asperiores	Уровень допуска: doloribus
607d38a5-08a7-493e-b5dc-6f543f3f0530	cee87633-4350-408f-bf06-6f0bcd80d84a	Соревнование sed	2025-08-04	aut	Уровень допуска: impedit
987876e1-e4f9-46fe-a136-292eaf5f131b	c0716880-5231-4e4c-8558-743113546603	Соревнование consequatur	2025-07-05	et	Уровень допуска: eum
c1cb5834-eaa3-41ad-8c9a-b858a4d0d233	c08c87fc-10d7-437e-8f2f-b6a20defd0fc	Соревнование eaque	2025-07-25	exercitationem	Уровень допуска: rerum
3bd14fe7-af8c-47fe-888a-14e2103d23a4	665f1b7c-f2ae-4f36-95f4-ba2f8cb0a258	Соревнование autem	2025-08-19	ducimus	Уровень допуска: magni
dca5717f-d71c-4be3-90db-4fd06e5a74a4	c28b54f1-a3fd-4165-810b-00bf7d424889	Соревнование et	2025-08-19	dolorum	Уровень допуска: voluptatibus
14eea280-f55a-4a15-ab0e-afdbce799216	1dee1201-0598-45aa-be5f-1ea4aa81b422	Соревнование sed	2025-06-27	enim	Уровень допуска: magnam
96439dc7-c1d0-49b1-8a89-3262196a81ad	7c3787b0-8cd0-4da2-929d-ec94fae559b7	Соревнование quia	2025-07-23	rerum	Уровень допуска: accusamus
63fa3904-8855-40eb-8cf5-c01d80e0fa19	6ed7b2fe-8926-4d5d-9b9e-0daa17ff2925	Соревнование ipsum	2025-06-13	minus	Уровень допуска: itaque
a38b4271-2e58-40a2-a825-d5116b705634	511a5414-a12d-40e4-8452-e43e144c3e5b	Соревнование suscipit	2025-08-06	aliquid	Уровень допуска: quas
6a95bc88-b42c-4ed9-81a5-157dec755085	3fc8522c-dc0e-4b2f-accd-dc60e0127633	Соревнование in	2025-08-28	nisi	Уровень допуска: totam
4540370e-43ad-410e-aecc-2fa2c2082a03	afa23a8e-6295-4dc6-bda1-9589a5bae687	Соревнование nihil	2025-07-21	tempore	Уровень допуска: cupiditate
f54d8923-70c6-4983-94d5-1fc634befe2e	69d67748-bc5d-4c4a-88c1-7e9541f56973	Соревнование inventore	2025-07-06	nostrum	Уровень допуска: dolorum
18038d48-ba3e-44d8-af9c-c15ebd59b53b	ea650628-97c3-4770-aee0-101fb6e2701f	Соревнование maiores	2025-08-12	dolore	Уровень допуска: dolor
f7ea919a-0a7d-4748-a2ca-4e02a7089a4e	d5990210-a84f-4229-b63e-41b0771be42f	Соревнование voluptate	2025-07-28	et	Уровень допуска: impedit
\.


--
-- Data for Name: completed_exercises; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.completed_exercises (completed_exercise_id, training_id, exercise_id, notes) FROM stdin;
ee2705cf-3b4c-4afb-bb6c-c01a3dcf75ba	d1559d0e-9d10-4186-a36a-f168ad75c84d	58a3c1dd-fe50-4379-9345-7bfe983cdc1c	Dolores reprehenderit vero occaecati vel non.
25842c18-34f5-4b40-bc46-4fec52c85a68	f49239c7-f384-4171-85b6-288777f3674e	bad4d167-429e-44a0-b8bc-884ba0bbd56c	Dolorem eligendi laudantium distinctio qui quae.
ad9e66a4-bca4-4376-a08b-89cd9427eea9	f49239c7-f384-4171-85b6-288777f3674e	83c8215b-e0c6-4b05-ba94-0ebb6b6ec171	Consequatur esse quis minima cupiditate qui.
846aa592-82ae-48e9-adef-011d6374e0db	f49239c7-f384-4171-85b6-288777f3674e	1a8f3b4d-1d22-4403-99b6-a8d59a2a57db	Facilis eveniet consectetur ab veritatis dolorem.
28705b72-68fe-4281-b6ab-2cdc65127566	0b1932cd-769d-46d9-9d88-9ff51e640fdd	1a8f3b4d-1d22-4403-99b6-a8d59a2a57db	Nobis quae tempora temporibus natus architecto.
967ffc66-b4d9-4b28-81e8-ffaf765a2371	0b1932cd-769d-46d9-9d88-9ff51e640fdd	39f98e2e-5001-40b9-b589-1990858dcbe4	Nostrum non tempore temporibus qui rerum.
2dea0d9e-943b-4615-ae73-97f99272f60b	09d9e681-5d01-468f-a395-6ead8edd6de9	1d875412-b2fe-425b-a870-67f9dc63b6c6	Corrupti et debitis pariatur aut aliquam.
7707ba1f-66d6-4f1e-a708-bb629fd79cf3	09d9e681-5d01-468f-a395-6ead8edd6de9	1d875412-b2fe-425b-a870-67f9dc63b6c6	Earum repellendus sit repudiandae omnis sapiente.
8343b2a1-fb6f-4412-a40d-79d0ba6650a0	520bc736-3d84-4146-9418-30e6a578b3ec	3e535816-0083-4c41-a7bf-4bcdb9096e0e	Modi ab ex sint eligendi architecto.
c1dbe5dc-230e-48e6-87d4-59c65f6db3c7	520bc736-3d84-4146-9418-30e6a578b3ec	a9d271a2-f5a9-4034-9dd5-04a56bd99ab0	Veritatis dolores et quia facilis est.
c9d12bd8-b567-446c-b86d-731f4e56a251	520bc736-3d84-4146-9418-30e6a578b3ec	58a3c1dd-fe50-4379-9345-7bfe983cdc1c	A iste itaque facilis dolor consequatur.
4e196a65-9e64-4d80-ae03-7cecc9a5c9c6	a6bc5ae9-7e25-4031-b238-8ba0af015de9	2ea41f59-034a-4c08-bf03-1823cc556103	Molestias rem iure numquam est ut.
146fbbb1-eb0e-4aea-80bf-426ddbfb8475	8ecfb0ff-5025-4b5b-b8d5-9addd7ba036a	aef783ca-b757-48a6-a2c8-26549e454b28	Molestiae natus quo sed placeat repellat.
9f4caf4c-cd12-4349-a6d0-4f1d3798ef5a	8ecfb0ff-5025-4b5b-b8d5-9addd7ba036a	2ea41f59-034a-4c08-bf03-1823cc556103	Omnis delectus ratione expedita illum quo.
9a157914-ddd0-43c2-9ef8-392a6c37ce38	99a541d2-37e4-422b-8ca2-4adac04f16b5	a9d271a2-f5a9-4034-9dd5-04a56bd99ab0	Quas nulla error eaque sunt eos.
125f0534-b7b9-4626-ad99-633f206f8c25	99a541d2-37e4-422b-8ca2-4adac04f16b5	474699c2-8399-482c-83f9-30b7b659a3a0	Dolore beatae accusamus consectetur inventore quae.
bc328247-aef2-4ebd-a971-40bf986a51ab	99a541d2-37e4-422b-8ca2-4adac04f16b5	a9d271a2-f5a9-4034-9dd5-04a56bd99ab0	Consequatur provident sit veniam iste cupiditate.
d5dba6ca-4fcf-4588-91c0-27e50070dd79	a971882b-7e45-4cda-9819-2835eb59c398	83c8215b-e0c6-4b05-ba94-0ebb6b6ec171	Autem in sed harum velit esse.
e684e615-6fd5-47ae-8ee1-42fc10a031ce	a971882b-7e45-4cda-9819-2835eb59c398	e70d6df1-d259-4903-a12f-15472df30c1c	Ratione magni consequatur molestias dolor nihil.
8c5800dc-23c1-4571-ac74-d4ebf5599275	e426ea6b-2683-46c5-b164-e9f434e4eac0	474699c2-8399-482c-83f9-30b7b659a3a0	Ut libero eius distinctio at ipsa.
28a25d13-9430-4c04-bee0-304eb1f56a4c	e426ea6b-2683-46c5-b164-e9f434e4eac0	3e535816-0083-4c41-a7bf-4bcdb9096e0e	Et qui ut quos vel quis.
0cc80f82-693c-4ba7-b341-f5df9aaccdb2	87d3283a-1688-4827-a016-b3aa18a6d87a	2ea41f59-034a-4c08-bf03-1823cc556103	Ipsam molestias assumenda rerum excepturi dolorum.
8c0dbc63-ed95-4f2e-87aa-829ee9e89cc9	c85f0545-5d0c-4eea-b4b0-13d74f84f91d	aef783ca-b757-48a6-a2c8-26549e454b28	Dolores et ut culpa amet voluptates.
95091058-3a74-409e-a8a2-8bb9d4413801	c85f0545-5d0c-4eea-b4b0-13d74f84f91d	1d875412-b2fe-425b-a870-67f9dc63b6c6	Voluptatum molestiae facere enim maiores sunt.
902103fc-da10-42b9-ab8e-e9190781927b	05d9a869-8150-445d-bf0c-e5d25de621c4	823ae61a-d6e5-4da2-bf0f-2eba9ae51590	Saepe praesentium perspiciatis enim ipsa facilis.
94038f78-b577-4eeb-a7cc-dcc22f2bbf37	05d9a869-8150-445d-bf0c-e5d25de621c4	bb2fa0af-7b84-4b4a-b0e8-c5640eb77b14	Maxime et eos voluptas nihil tempore.
81920fa1-6829-4073-8479-cfdc15c309f3	dfe4c597-5100-45fe-b71d-d5e5f8af8db4	1a8f3b4d-1d22-4403-99b6-a8d59a2a57db	Nisi cumque reiciendis doloremque in earum.
959ba7ce-efba-4d65-839a-dcb71dd799ca	dfe4c597-5100-45fe-b71d-d5e5f8af8db4	474699c2-8399-482c-83f9-30b7b659a3a0	Minima cum odio quos sed eum.
c42f4ad2-a2e2-4277-87d2-3fedd5c22449	dfe4c597-5100-45fe-b71d-d5e5f8af8db4	e70d6df1-d259-4903-a12f-15472df30c1c	Voluptates dolor nobis maiores modi rem.
d7c3869f-2a6f-4859-a6a9-ad425e8dd023	76d13745-1b31-4117-8840-5bb19176ec61	bb2fa0af-7b84-4b4a-b0e8-c5640eb77b14	Sapiente doloremque omnis quis provident repellendus.
20ec5745-0cc5-435e-8477-152fa30d9989	eb94432b-7129-47c9-9d8b-6f59ff490f33	823ae61a-d6e5-4da2-bf0f-2eba9ae51590	Odit quas est ut aut consequatur.
07e8d00f-8b1d-439d-a75a-aac443f0f2d0	eb94432b-7129-47c9-9d8b-6f59ff490f33	58a3c1dd-fe50-4379-9345-7bfe983cdc1c	Earum enim perspiciatis autem vitae sed.
aa225819-7bb9-49fe-804b-52e18ab330aa	9b1f1b9e-8029-4cff-9ce7-f23fd84e0207	474699c2-8399-482c-83f9-30b7b659a3a0	Temporibus odio fuga nemo sequi consequuntur.
68d72b92-87cc-4d3f-88e7-be28c4ca34ac	9b1f1b9e-8029-4cff-9ce7-f23fd84e0207	58a3c1dd-fe50-4379-9345-7bfe983cdc1c	Nisi voluptate reiciendis sed dolores tempore.
89537e34-9920-4094-aa6d-d9cd836b0d9a	b2b63667-b34b-484a-b746-8aacf1d203a6	1a8f3b4d-1d22-4403-99b6-a8d59a2a57db	Vel ad et odit dicta autem.
34cd1720-a613-4b70-b238-8a6082429a97	b2b63667-b34b-484a-b746-8aacf1d203a6	1d875412-b2fe-425b-a870-67f9dc63b6c6	Officia id quo aut dolorem alias.
901a5a6d-876d-413f-9269-b505ccc113f6	8dd8418b-a0be-4a07-84dc-c7b509786b28	aef783ca-b757-48a6-a2c8-26549e454b28	Reiciendis possimus ut soluta omnis mollitia.
1bbe8bb0-f014-459b-8640-a819ab531e7b	522433c4-60a4-458b-878f-0e86ba491331	d0286cdd-a0dd-4c0e-ae00-0d90d5ff5bd4	Aperiam amet est vel ipsum quasi.
6e0156fa-3107-40ac-b337-198fa63cfb0b	f7639873-dbcc-4a40-8763-8cbe254b382f	58a3c1dd-fe50-4379-9345-7bfe983cdc1c	Ad ipsam deleniti asperiores quaerat minus.
e1987023-a599-426f-bcd8-faae3d9b58ff	f7639873-dbcc-4a40-8763-8cbe254b382f	1d875412-b2fe-425b-a870-67f9dc63b6c6	Provident velit quia minima omnis vero.
712c7e15-8c97-4fc7-9375-e6fd3fd61ae9	34a7225c-b3d0-4053-b9cd-8bd6ec994582	39f98e2e-5001-40b9-b589-1990858dcbe4	Sed consequuntur quo tempora ducimus aut.
3db1eaeb-26ae-4225-b81c-a10530784adb	34a7225c-b3d0-4053-b9cd-8bd6ec994582	58a3c1dd-fe50-4379-9345-7bfe983cdc1c	At assumenda et perferendis beatae sit.
baed87be-80d7-4486-84a7-21b962e0e59a	9d0a1303-c64a-42f3-9cb3-a01f83d7556e	aef783ca-b757-48a6-a2c8-26549e454b28	Et eos id aliquid non eius.
da319d97-3752-47d1-9a98-eac77f6fdb86	9d0a1303-c64a-42f3-9cb3-a01f83d7556e	58a3c1dd-fe50-4379-9345-7bfe983cdc1c	Reiciendis id numquam animi iure commodi.
43f10bdf-4d49-40f6-a825-8c2dafe27048	b894e378-6228-4ed9-832f-74d793b7ee80	bad4d167-429e-44a0-b8bc-884ba0bbd56c	Quis aliquid rem corrupti sed impedit.
5cd3c3ce-e8e3-4b72-9b7c-3259dfbaf460	9d672d87-a99b-4ef6-b569-f15886289b65	aef783ca-b757-48a6-a2c8-26549e454b28	Quis molestias neque et et qui.
1e75a0a7-f317-4037-a053-23da25d4c7d5	9d672d87-a99b-4ef6-b569-f15886289b65	bb2fa0af-7b84-4b4a-b0e8-c5640eb77b14	Blanditiis odio assumenda sunt nihil temporibus.
451d3f8c-d359-4bcc-9867-7d25782b2229	1dbaaa51-004e-4b77-a4f8-c7a2e87a7a9a	823ae61a-d6e5-4da2-bf0f-2eba9ae51590	Nesciunt aliquid quibusdam veniam consequatur unde.
e14d1415-7be1-4928-a609-cfc16eb2ffb7	1dbaaa51-004e-4b77-a4f8-c7a2e87a7a9a	58a3c1dd-fe50-4379-9345-7bfe983cdc1c	Impedit itaque ipsum inventore tenetur nihil.
57b178a3-c455-4026-8d30-91526384bd46	41b0eca9-24c9-4e60-8846-1b3897a6009d	1d875412-b2fe-425b-a870-67f9dc63b6c6	Et eligendi suscipit eveniet quis incidunt.
fcad5a08-0641-4926-8594-985cb9d6e2db	0ac0ffd1-d3e2-40cb-ac64-3fb418234084	474699c2-8399-482c-83f9-30b7b659a3a0	A veniam sit aut assumenda id.
0696abc3-bfde-4e0c-8c7b-f11e0bc1d1b9	0ac0ffd1-d3e2-40cb-ac64-3fb418234084	474699c2-8399-482c-83f9-30b7b659a3a0	Eius aliquam pariatur numquam laboriosam facilis.
ede85d9a-42b0-46e3-8bbe-09d81b9beac1	0ac0ffd1-d3e2-40cb-ac64-3fb418234084	a9d271a2-f5a9-4034-9dd5-04a56bd99ab0	Assumenda magni consequuntur sapiente eos dolorem.
552f7aab-b519-42da-8f00-bc0e9b15fe02	1d09e1e1-2a4c-498d-bfb8-f6354365ad8e	bad4d167-429e-44a0-b8bc-884ba0bbd56c	Ut explicabo sint facilis neque assumenda.
ca797600-1d32-4ea7-8026-dc5e04eb933b	1d09e1e1-2a4c-498d-bfb8-f6354365ad8e	1a8f3b4d-1d22-4403-99b6-a8d59a2a57db	Voluptas suscipit in exercitationem debitis et.
5507976b-5d65-4e86-a769-28b49a6c3ecb	1d09e1e1-2a4c-498d-bfb8-f6354365ad8e	3e535816-0083-4c41-a7bf-4bcdb9096e0e	Voluptatem ea error sit dolor ut.
b8b8c149-05a8-4943-bc02-fbba07cb5071	ab30a383-4881-49d8-bbf2-a1a6f8b51db2	2ea41f59-034a-4c08-bf03-1823cc556103	Doloribus est facere facilis nam atque.
970f4565-f923-4ec4-ade6-6ab836f4cbaf	ab30a383-4881-49d8-bbf2-a1a6f8b51db2	2ea41f59-034a-4c08-bf03-1823cc556103	Et voluptatem ad et voluptatem et.
d32bded5-2d55-4c0e-b083-28d7ebd880a6	5397b928-a0d3-4bd7-9b22-9d41702a59ce	1d875412-b2fe-425b-a870-67f9dc63b6c6	Dolorem ea beatae et ut voluptatum.
50125be8-9495-4cbd-a1cd-811982f6d053	4ac907c5-0da1-4615-912b-f92acc7a2d78	58a3c1dd-fe50-4379-9345-7bfe983cdc1c	Odio laudantium harum odit repellendus amet.
46cb9790-7220-4ba9-83d0-31d23f526181	7519f70c-7dd8-4f7a-b611-5ea606bfca65	1d875412-b2fe-425b-a870-67f9dc63b6c6	Tenetur molestiae nihil assumenda id perspiciatis.
5a467799-73d5-4d0d-8682-8631ca6e1f73	5b80bc3a-d997-4d5f-95db-f9ef1b83d826	d0286cdd-a0dd-4c0e-ae00-0d90d5ff5bd4	Non ipsam qui quibusdam libero et.
8333bae2-3ac8-4a76-8a1f-aeba5873e12e	5b80bc3a-d997-4d5f-95db-f9ef1b83d826	823ae61a-d6e5-4da2-bf0f-2eba9ae51590	Et dicta voluptatum cumque aut officia.
741f2100-47bd-4a87-b344-d5d064f03620	f258852d-89ff-4c7d-827b-ca454e944377	bb2fa0af-7b84-4b4a-b0e8-c5640eb77b14	Architecto est eum sed inventore ut.
d85a548b-6b65-49a9-8922-5b9c733cd723	f258852d-89ff-4c7d-827b-ca454e944377	83c8215b-e0c6-4b05-ba94-0ebb6b6ec171	Ea mollitia et asperiores omnis consequatur.
6da0a0d7-6fff-4fdc-8b6e-959a40d66957	df863201-e8a4-424e-b9f6-adb1f4e1a03a	d0286cdd-a0dd-4c0e-ae00-0d90d5ff5bd4	Natus veritatis blanditiis at et molestiae.
eeef8905-4f88-4b3f-9264-1fd8bd172c0a	df863201-e8a4-424e-b9f6-adb1f4e1a03a	e70d6df1-d259-4903-a12f-15472df30c1c	Sit eaque sint nesciunt cum qui.
491b196b-2d20-42ed-85d7-f0ff03d095cd	9c97ba6d-c2de-45c7-82c0-27c0706c0332	39f98e2e-5001-40b9-b589-1990858dcbe4	Voluptas voluptate quasi tempora ea cum.
719ae694-eb47-4c4b-b3e8-2374f3153f33	9c97ba6d-c2de-45c7-82c0-27c0706c0332	2ea41f59-034a-4c08-bf03-1823cc556103	Nisi dolorem in aut qui velit.
c2b8cd19-9241-402f-959a-6cb133009378	e046f72e-8a6e-418d-907b-26a91ea08ae1	aef783ca-b757-48a6-a2c8-26549e454b28	Labore quaerat et consequatur in ut.
149d0f00-1b22-4fe1-8494-b27c576f40e1	e82fe4d2-d583-4673-9692-5cd17747554c	823ae61a-d6e5-4da2-bf0f-2eba9ae51590	Minima voluptatem quidem velit autem accusantium.
4d1cc4f8-d1d9-4ac6-8d70-df48413d0cf5	e82fe4d2-d583-4673-9692-5cd17747554c	3e535816-0083-4c41-a7bf-4bcdb9096e0e	Ut nemo hic magni at quia.
b2e3006f-bacb-4273-ac9e-c06c0922ff99	3750e77d-4e6f-4396-89a3-9fc375d17dae	a9d271a2-f5a9-4034-9dd5-04a56bd99ab0	Ea voluptatem temporibus doloremque quia deserunt.
30948ab6-1798-4be7-a08b-fce0275fb8b1	3750e77d-4e6f-4396-89a3-9fc375d17dae	1a8f3b4d-1d22-4403-99b6-a8d59a2a57db	Voluptas odio vel in voluptate numquam.
29e2eb74-2e90-4a36-a243-6132a4e76894	6aeabf13-6ae3-41cb-a91b-3e80967638cb	aef783ca-b757-48a6-a2c8-26549e454b28	Rerum adipisci at nihil repellat sit.
c5e0624f-9fc5-4ec0-92bd-b018634f21be	6aeabf13-6ae3-41cb-a91b-3e80967638cb	823ae61a-d6e5-4da2-bf0f-2eba9ae51590	Nihil quae tempore velit sed id.
67b2ed6e-301b-481c-af85-789c6d5b3bb6	a8ab4179-f2ed-447e-8fc9-cfcbd07d44be	a9d271a2-f5a9-4034-9dd5-04a56bd99ab0	Natus a iusto eaque minus cumque.
45ee3011-2711-4c28-8429-605ebc90a028	a8ab4179-f2ed-447e-8fc9-cfcbd07d44be	aef783ca-b757-48a6-a2c8-26549e454b28	Suscipit enim dolore dicta asperiores facere.
731eaffe-a349-4445-978d-8b5a666619ff	ea69ad69-e401-4e7c-94d1-d814e22b87ff	83c8215b-e0c6-4b05-ba94-0ebb6b6ec171	Reiciendis aut dolore quos corrupti vel.
0a4b0b02-aaa3-4c4f-80f5-54d616fe5fc8	63f9dad0-99a5-4670-a1dc-0cac51be64f0	e70d6df1-d259-4903-a12f-15472df30c1c	Nulla enim aut eum provident id.
22fcf6a1-8af1-42f7-9e7a-d243f0b002f7	05521a11-ae50-4ec7-b544-71052e2dbb11	bad4d167-429e-44a0-b8bc-884ba0bbd56c	Consectetur totam ullam molestiae nisi at.
b63ad474-1e2f-4d65-9287-88a4f4c7aaef	ae750576-d2ca-4c79-8ed9-821208f2377a	58a3c1dd-fe50-4379-9345-7bfe983cdc1c	Perspiciatis repudiandae et est at dolorem.
00f8fbed-fd2f-454b-9da5-d521607696e0	ae750576-d2ca-4c79-8ed9-821208f2377a	474699c2-8399-482c-83f9-30b7b659a3a0	Ea alias facere eveniet aliquid id.
fe71797a-3479-4086-98d8-0c7b99a18f4b	cf3eb922-7489-4fcb-a916-c1514c962f6a	474699c2-8399-482c-83f9-30b7b659a3a0	Ullam vitae ut reprehenderit ipsum debitis.
076ce1fb-3072-4ea0-9851-ebc7b04bbbb3	cf3eb922-7489-4fcb-a916-c1514c962f6a	aef783ca-b757-48a6-a2c8-26549e454b28	Autem aut ea omnis tempore dicta.
316aad1d-0f5b-4039-9890-487308729b75	9d3f10b4-8b17-4025-a935-ad703c181940	d0286cdd-a0dd-4c0e-ae00-0d90d5ff5bd4	Aspernatur fuga ut molestiae a non.
678907bb-e4ab-4a5a-b419-b2fddb39cc6c	9e7d6c77-b7a3-4f0d-a24d-77f0c42cc9d7	e70d6df1-d259-4903-a12f-15472df30c1c	Esse optio officia molestias eos beatae.
4ee051c8-e8a6-48d3-9125-2e88103f9217	9e7d6c77-b7a3-4f0d-a24d-77f0c42cc9d7	e0bd71e5-f331-474a-bcfb-68126c38643e	Qui qui voluptates non nemo ratione.
38149fb1-228c-4965-9f27-71393ca2c5fb	0a24d693-e957-4c5c-adbd-8957ff275c5a	d0286cdd-a0dd-4c0e-ae00-0d90d5ff5bd4	Officia voluptas veritatis sapiente est blanditiis.
ca9983e7-4ce4-4e39-bcf0-135ca823ef8a	0a24d693-e957-4c5c-adbd-8957ff275c5a	e70d6df1-d259-4903-a12f-15472df30c1c	Ducimus consequatur sunt tenetur suscipit natus.
447a81c1-799b-41c5-a995-fd68b758c162	1811b701-6d6c-46ee-8a46-94c17e09b76c	e70d6df1-d259-4903-a12f-15472df30c1c	Ut doloremque est autem maiores rerum.
59259538-7929-42b6-aafd-acce81c26263	1811b701-6d6c-46ee-8a46-94c17e09b76c	bb2fa0af-7b84-4b4a-b0e8-c5640eb77b14	Consequatur vel necessitatibus animi quam fuga.
9faeff73-bc5b-4f61-b7e6-9d634589271d	b35b48d8-6eee-493f-96a2-077c5cd72ac3	a9d271a2-f5a9-4034-9dd5-04a56bd99ab0	Deserunt sint neque voluptatem itaque unde.
76144e84-dfb3-4bc6-aa66-fc1334978642	94ecc2b8-9199-43a7-9b2f-1737fed8d704	a9d271a2-f5a9-4034-9dd5-04a56bd99ab0	Et distinctio consequatur ex officia exercitationem.
894d2edb-2f69-4ee0-9162-cdb63929edfb	94ecc2b8-9199-43a7-9b2f-1737fed8d704	aef783ca-b757-48a6-a2c8-26549e454b28	Cumque vel deleniti distinctio nam voluptatem.
e58dd2cb-5821-4db3-b96c-64acc1cebb99	94ecc2b8-9199-43a7-9b2f-1737fed8d704	a9d271a2-f5a9-4034-9dd5-04a56bd99ab0	Enim iste molestiae minus aut cum.
89d9050d-8f40-4b5d-beab-5f4b019c6d04	8f228364-0418-4df0-89d5-5a00e7087aec	39f98e2e-5001-40b9-b589-1990858dcbe4	Nihil qui saepe sint non quis.
62f95d3a-9c0f-4d9c-be6d-abf509de398c	6beb87f5-efd8-42a3-b197-5fac07c75fb5	d0286cdd-a0dd-4c0e-ae00-0d90d5ff5bd4	Ea voluptatem provident eius pariatur mollitia.
cc51b51a-e0db-414a-bb38-3c317fa88c85	32d1fc0e-e6da-4322-9324-0e6a2b1b6da6	e0bd71e5-f331-474a-bcfb-68126c38643e	Fugiat sint magnam sit quod voluptatem.
0efebda1-3fb7-4b1d-8811-34772d1a1915	92fc9e26-2f6e-4441-8477-d0855c9da1cf	d0286cdd-a0dd-4c0e-ae00-0d90d5ff5bd4	Ipsum iste dolore quia itaque quia.
4f5c9fb6-c9e5-4650-882f-68335e5b1f0e	92fc9e26-2f6e-4441-8477-d0855c9da1cf	d0286cdd-a0dd-4c0e-ae00-0d90d5ff5bd4	Ipsum praesentium rem quis et rerum.
b932666a-3520-4805-9f5e-a7fd31cfd9fd	9513d5b0-be01-4dea-9abe-8db3957d1349	58a3c1dd-fe50-4379-9345-7bfe983cdc1c	Dolores blanditiis iure nihil temporibus ex.
43532fab-3e51-4e10-bcae-dde8af52b543	18d72505-0726-4bfc-a49d-23a2120c6610	823ae61a-d6e5-4da2-bf0f-2eba9ae51590	Perspiciatis occaecati hic aut iste cumque.
324f28e6-8206-44e1-9864-05c26e871d2f	c65d0ce6-fc09-4382-aa65-af0433c27b0f	823ae61a-d6e5-4da2-bf0f-2eba9ae51590	Nihil quisquam perspiciatis ipsa doloremque est.
b103e1e9-5692-43d3-a141-f6bd3e41e509	8ed0a690-6a9a-4116-a759-be36f1e652fc	e70d6df1-d259-4903-a12f-15472df30c1c	Quaerat assumenda accusantium enim aut corrupti.
738f78ce-42b3-4111-89c1-c8efc2f65e2e	6dd2c11e-25cd-4810-9d3e-9785c694e781	2ea41f59-034a-4c08-bf03-1823cc556103	Nobis quia quos accusantium quia veritatis.
92707d5a-ca65-43a5-9207-d93bf75d9431	8a052d6e-81fb-4631-b72b-67a66781420f	1d875412-b2fe-425b-a870-67f9dc63b6c6	Voluptatem incidunt reiciendis officiis consequatur dolorem.
0ede3d4f-0022-4ba0-b1e4-76f8f1386eb4	1e1b48e7-d3d9-4a09-bebb-5ebfe4ff19a8	58a3c1dd-fe50-4379-9345-7bfe983cdc1c	Expedita quis iste ea atque cum.
bcce287a-4e0c-445a-8339-548ac88c5273	17b1b38f-543f-45c3-9bfd-9182509e3df4	1a8f3b4d-1d22-4403-99b6-a8d59a2a57db	Et molestiae debitis dolor perferendis rerum.
3c29bc94-b0bc-467f-a916-fede13c3929d	17b1b38f-543f-45c3-9bfd-9182509e3df4	2ea41f59-034a-4c08-bf03-1823cc556103	Qui est itaque doloribus dicta amet.
188f2854-eb1f-497a-b633-18bdf566f092	64664861-7fd4-43fb-b321-4ad6cf0e36bb	bad4d167-429e-44a0-b8bc-884ba0bbd56c	Quod odit adipisci unde omnis aut.
\.


--
-- Data for Name: completed_sets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.completed_sets (completed_set_id, completed_exercise_id, set_number, repetitions, weight, duration) FROM stdin;
89dd3a64-ccab-4f3e-a363-a5e1f93aa150	ee2705cf-3b4c-4afb-bb6c-c01a3dcf75ba	1	14	22.237383780022498	00:03:05
e35ff114-0e7e-41fc-820e-a692681548f3	25842c18-34f5-4b40-bc46-4fec52c85a68	1	11	10.130283149348227	00:00:44
101cfdb2-2c3c-4e0f-bd53-f5a94bd2c6e0	25842c18-34f5-4b40-bc46-4fec52c85a68	2	6	48.61968723868007	00:04:09
05aa764e-a9e2-40a7-8783-c0c950e4a77b	ad9e66a4-bca4-4376-a08b-89cd9427eea9	1	7	49.589644478327365	00:00:22
2c143975-cfbc-4585-8830-ccf2f1a0abd6	846aa592-82ae-48e9-adef-011d6374e0db	1	6	46.67583763815098	00:03:43
626b99c1-cb1d-4e8f-89b7-4c0d1781984b	846aa592-82ae-48e9-adef-011d6374e0db	2	11	47.47374630586079	00:04:50
141d89d9-645d-4c0f-b755-5ab255c4c2de	28705b72-68fe-4281-b6ab-2cdc65127566	1	9	47.40968895097342	00:00:52
5ecba5af-e1d3-4bfd-a9cd-bd42bfcb0c7b	967ffc66-b4d9-4b28-81e8-ffaf765a2371	1	7	39.842544544504904	00:04:35
992fd354-0ce6-4248-9746-f0283fe45fb7	967ffc66-b4d9-4b28-81e8-ffaf765a2371	2	9	34.39914611147643	00:01:54
e7c81338-ee02-415b-962c-faf43b8e5024	967ffc66-b4d9-4b28-81e8-ffaf765a2371	3	10	16.174647707176213	00:03:10
37b899b3-d5f0-49ac-be7e-aea4cb06d788	2dea0d9e-943b-4615-ae73-97f99272f60b	1	11	49.45651260511108	00:00:10
44c02c09-ca37-4cf9-84e1-c44b1f813134	7707ba1f-66d6-4f1e-a708-bb629fd79cf3	1	6	27.71390968109361	00:00:16
4fd13ff0-05f6-41a0-bb83-da54bffb9341	7707ba1f-66d6-4f1e-a708-bb629fd79cf3	2	7	24.04324024098159	00:01:16
5f5060bd-1c76-4f3d-aa76-f4514e873761	8343b2a1-fb6f-4412-a40d-79d0ba6650a0	1	13	42.40355265984389	00:00:55
9a08f995-9948-408e-9268-fdc2fe9ec75c	8343b2a1-fb6f-4412-a40d-79d0ba6650a0	2	5	14.645063145088894	00:00:18
e16e6509-7627-41d4-9565-cd17e38d3214	8343b2a1-fb6f-4412-a40d-79d0ba6650a0	3	7	35.84910954504032	00:03:19
cfccb705-e59b-44cd-b524-213f3ac1d15d	c1dbe5dc-230e-48e6-87d4-59c65f6db3c7	1	14	47.92678836169155	00:04:47
748cf99a-7984-483d-809d-d6c78d2f9b83	c1dbe5dc-230e-48e6-87d4-59c65f6db3c7	2	10	18.973780077687504	00:00:40
6c16c7e9-5ee9-4a17-86e4-05b65d43d05d	c9d12bd8-b567-446c-b86d-731f4e56a251	1	11	35.08166925072134	00:03:23
218b0bf3-8ce7-458a-95ae-2c6ec2ee66e0	c9d12bd8-b567-446c-b86d-731f4e56a251	2	7	38.5730574210725	00:02:32
6c6329ba-1488-4de2-9a4b-bd67d2d7012e	4e196a65-9e64-4d80-ae03-7cecc9a5c9c6	1	11	15.411063792410989	00:01:32
55afd95d-6774-4709-a035-9cfced5e33fd	4e196a65-9e64-4d80-ae03-7cecc9a5c9c6	2	13	13.64804611848972	00:01:58
599b094c-1b85-453f-bb6d-da566eeb802a	146fbbb1-eb0e-4aea-80bf-426ddbfb8475	1	14	22.390858331123994	00:04:51
534cddd8-9e62-4b9b-809c-43c73c264949	9f4caf4c-cd12-4349-a6d0-4f1d3798ef5a	1	12	41.895986108717835	00:04:40
6fb3dfd6-6950-4d82-8baa-72558319b4b3	9f4caf4c-cd12-4349-a6d0-4f1d3798ef5a	2	11	16.77970465574776	00:01:45
c1bd6e87-4f5e-4e7f-b241-2f9e907fec87	9f4caf4c-cd12-4349-a6d0-4f1d3798ef5a	3	12	43.96432491702469	00:01:32
6e5e74b9-3619-4922-9e34-6e5308475d2c	9a157914-ddd0-43c2-9ef8-392a6c37ce38	1	11	42.556609828129545	00:01:48
eea4b66f-c8be-42a5-8263-399b6cc1bcd7	125f0534-b7b9-4626-ad99-633f206f8c25	1	14	46.204540349028036	00:02:31
8b39e29e-bd62-4534-93f1-d046aafd69e0	bc328247-aef2-4ebd-a971-40bf986a51ab	1	14	27.878869035294667	00:00:14
17df1b4f-4384-4df1-9153-a696062b81d9	d5dba6ca-4fcf-4588-91c0-27e50070dd79	1	9	42.845495077272396	00:02:28
9a04b97e-3c6a-4ef2-80c6-15574a55387f	e684e615-6fd5-47ae-8ee1-42fc10a031ce	1	11	16.913714220130853	00:00:44
5ffe4a68-c0db-4a51-8b9c-7b18e4861b2b	e684e615-6fd5-47ae-8ee1-42fc10a031ce	2	5	35.31917438497324	00:04:36
403464b1-f607-4a81-9e3f-7801b335fb76	e684e615-6fd5-47ae-8ee1-42fc10a031ce	3	13	49.35421513845073	00:01:34
00692ead-58b1-453f-a434-5349dc0ee50a	8c5800dc-23c1-4571-ac74-d4ebf5599275	1	12	40.8282547997554	00:02:31
427dd8a5-9469-463b-9af1-e193dc512130	8c5800dc-23c1-4571-ac74-d4ebf5599275	2	7	24.698247408993602	00:00:50
bb748b46-8e77-47b9-8555-b5e232e16d77	28a25d13-9430-4c04-bee0-304eb1f56a4c	1	13	31.594172916666224	00:01:39
e2d6cf20-4333-4ad2-9b8e-53aa3741f9b2	28a25d13-9430-4c04-bee0-304eb1f56a4c	2	14	35.04224378845315	00:04:11
73b31171-d14c-4d84-9c89-8b59f4eaf729	0cc80f82-693c-4ba7-b341-f5df9aaccdb2	1	7	25.307030559977477	00:01:28
a35c55c9-0a28-42cd-a235-3aef3bcd0b91	0cc80f82-693c-4ba7-b341-f5df9aaccdb2	2	12	17.223898752155012	00:04:39
0ff72fba-2db9-4e3b-9f6c-0d3838a7725e	8c0dbc63-ed95-4f2e-87aa-829ee9e89cc9	1	6	32.969851719595056	00:00:21
0a5b9c6b-6503-49aa-83c3-c0c277401ec1	8c0dbc63-ed95-4f2e-87aa-829ee9e89cc9	2	10	34.8264744536121	00:00:50
fd267727-1903-4448-ad1b-508f9ee9c15e	95091058-3a74-409e-a8a2-8bb9d4413801	1	13	22.695146559580145	00:03:14
8ef755c0-9378-408f-9021-416022da2b15	95091058-3a74-409e-a8a2-8bb9d4413801	2	13	28.138401868770558	00:02:43
796ccecc-d382-4a86-ae11-d42687d61150	95091058-3a74-409e-a8a2-8bb9d4413801	3	8	19.417351658562858	00:02:26
5d959154-4292-4a17-bea7-1bbd8f710375	902103fc-da10-42b9-ab8e-e9190781927b	1	5	14.87238169686287	00:02:53
4f791524-fbb3-4611-b0dd-37b183433a26	902103fc-da10-42b9-ab8e-e9190781927b	2	9	38.47830180080565	00:00:06
ff8ba5fc-8f29-4830-88e1-4e322eae9490	902103fc-da10-42b9-ab8e-e9190781927b	3	9	38.867409111475155	00:00:14
0f0aea48-655b-4cd3-9f06-904af66b9559	94038f78-b577-4eeb-a7cc-dcc22f2bbf37	1	11	41.90515954693595	00:04:23
9e9b64c8-f4d3-4db6-b329-32656da3e51f	94038f78-b577-4eeb-a7cc-dcc22f2bbf37	2	12	44.3393525486306	00:01:23
7da6e658-40d9-4085-808c-7353f652d348	81920fa1-6829-4073-8479-cfdc15c309f3	1	5	37.66251812848563	00:01:21
6e19cc62-39ff-4bb6-8e96-62860e000e03	81920fa1-6829-4073-8479-cfdc15c309f3	2	6	28.211193473846443	00:03:49
fef67d5f-b8cf-4921-988d-65eb6eb834eb	959ba7ce-efba-4d65-839a-dcb71dd799ca	1	14	43.44584146076333	00:03:18
d4a861f3-c246-47f7-9b7a-cacc54ab4a40	959ba7ce-efba-4d65-839a-dcb71dd799ca	2	12	42.96761973016115	00:02:49
6f22a806-34de-432e-964c-3cbfe84201e1	c42f4ad2-a2e2-4277-87d2-3fedd5c22449	1	12	31.067608014448517	00:03:52
d562f040-4df7-4e79-b320-d34c841bf32f	c42f4ad2-a2e2-4277-87d2-3fedd5c22449	2	5	37.48062073934759	00:04:34
1c2cdc88-f3c6-4b88-9c37-585f48aa8831	c42f4ad2-a2e2-4277-87d2-3fedd5c22449	3	9	14.446969794759365	00:00:40
25e25eae-91d9-4dea-b78c-06c6b40dce04	d7c3869f-2a6f-4859-a6a9-ad425e8dd023	1	12	14.496497406480941	00:00:36
a8330282-3d1d-4c34-9810-631c78ea9c5c	d7c3869f-2a6f-4859-a6a9-ad425e8dd023	2	12	12.366296002107436	00:03:48
b60a1d3b-6e0c-4675-ae25-8831646af3e5	20ec5745-0cc5-435e-8477-152fa30d9989	1	7	17.1333677672715	00:02:13
f9a089ef-12d4-49f2-a7c7-00a1f8cc1db6	20ec5745-0cc5-435e-8477-152fa30d9989	2	6	26.97269133884403	00:04:55
b0e083f7-d9d9-4f55-a8cf-9bbfc1958baa	20ec5745-0cc5-435e-8477-152fa30d9989	3	12	17.520778131015483	00:00:51
f2fe25df-d27d-455c-99b8-fbe9f5f8a200	07e8d00f-8b1d-439d-a75a-aac443f0f2d0	1	14	36.653080941738224	00:04:30
50f304ec-d85e-4760-824e-4c96513d3e87	07e8d00f-8b1d-439d-a75a-aac443f0f2d0	2	6	17.045003939438384	00:02:54
46a6f0bb-84ee-4420-834b-c3fbb725bc3f	aa225819-7bb9-49fe-804b-52e18ab330aa	1	6	15.07908810401041	00:03:00
371dccfa-fc0c-4b91-9302-a3669c7859b3	aa225819-7bb9-49fe-804b-52e18ab330aa	2	9	11.586620877488608	00:03:43
19beee8f-3387-4569-8e36-74475e80497b	aa225819-7bb9-49fe-804b-52e18ab330aa	3	5	14.25159667270541	00:01:23
df10b5e6-c709-4cfc-b1bc-acdc894d2ac8	68d72b92-87cc-4d3f-88e7-be28c4ca34ac	1	10	47.7347920267025	00:03:30
fa49b14f-0e3c-4ea3-892f-509ea50225af	89537e34-9920-4094-aa6d-d9cd836b0d9a	1	13	26.162133444828047	00:03:35
70a07080-7fcf-4d33-8919-b8225c1ee4d1	89537e34-9920-4094-aa6d-d9cd836b0d9a	2	5	10.22301406128521	00:02:57
9a1099a8-3d59-480c-9966-54d914bca3a9	89537e34-9920-4094-aa6d-d9cd836b0d9a	3	7	44.98273459175797	00:03:56
4379502b-c2d7-4c8e-b734-72ee02f02370	34cd1720-a613-4b70-b238-8a6082429a97	1	14	26.1878076199252	00:01:48
0d57d67a-3287-49b2-8ad6-4e14c2e39a2e	901a5a6d-876d-413f-9269-b505ccc113f6	1	7	22.99647147544854	00:03:56
ce28a87c-7b36-48ab-97d0-ee88c2d4362f	901a5a6d-876d-413f-9269-b505ccc113f6	2	6	36.859528372381284	00:01:24
361b3085-fc29-4b75-992b-00978ede363e	901a5a6d-876d-413f-9269-b505ccc113f6	3	9	21.678870973598247	00:03:35
eb55ea13-7d6b-42f5-a328-c85e4f9065b8	1bbe8bb0-f014-459b-8640-a819ab531e7b	1	7	32.139750282664004	00:02:30
8c354002-4348-46b2-b6f4-5d656615aa27	6e0156fa-3107-40ac-b337-198fa63cfb0b	1	7	45.75005835282946	00:03:26
0abf1cb2-bccf-4852-9c39-2ced470296c0	6e0156fa-3107-40ac-b337-198fa63cfb0b	2	6	20.856451421288465	00:04:45
4a2556e6-1452-4bc2-b275-12c1856694f0	6e0156fa-3107-40ac-b337-198fa63cfb0b	3	11	45.768532966709174	00:02:40
19481251-56ae-46b7-8c6c-79f43013c74f	e1987023-a599-426f-bcd8-faae3d9b58ff	1	14	36.88519892767108	00:01:48
17782283-abb6-4ffb-b7cd-95501f5d2d1c	e1987023-a599-426f-bcd8-faae3d9b58ff	2	5	33.100041151683854	00:03:36
7c649f7a-d714-4f84-a06c-6a970d76cd36	e1987023-a599-426f-bcd8-faae3d9b58ff	3	8	43.53529150340557	00:01:51
0e22b945-4b73-4e00-bc98-3afb186cebf2	712c7e15-8c97-4fc7-9375-e6fd3fd61ae9	1	10	26.511953998028304	00:00:22
feb67f63-fd13-4c6a-a392-82947971da80	712c7e15-8c97-4fc7-9375-e6fd3fd61ae9	2	8	30.642225583793174	00:02:12
c86a39cd-ba4e-443b-9b08-52b40ec49d5e	3db1eaeb-26ae-4225-b81c-a10530784adb	1	11	41.189624899202286	00:02:26
39ff5bf6-7d21-45a3-b771-ea324231192e	3db1eaeb-26ae-4225-b81c-a10530784adb	2	7	26.03333370603992	00:04:29
94571a81-1ec1-497b-8648-5e51cb3665ba	baed87be-80d7-4486-84a7-21b962e0e59a	1	7	21.863556838139807	00:02:49
e00614b7-666a-4961-a713-4c1589232c0d	baed87be-80d7-4486-84a7-21b962e0e59a	2	14	17.43128489982957	00:03:03
94400b64-76ab-4b26-aab0-099371e829a4	da319d97-3752-47d1-9a98-eac77f6fdb86	1	11	20.306743484824327	00:01:57
86435973-73bd-4732-bf7b-6cc7c7fee505	da319d97-3752-47d1-9a98-eac77f6fdb86	2	7	22.23021329975032	00:03:14
6c742d9b-e26a-4330-87ec-c82a698e54f1	43f10bdf-4d49-40f6-a825-8c2dafe27048	1	13	13.145184678487364	00:03:34
aa27d52f-09f6-4107-a4a3-56a04bd9ae74	43f10bdf-4d49-40f6-a825-8c2dafe27048	2	7	15.533566160911684	00:04:53
64165a6e-05f4-47b5-bc16-5b9f4ee8a0cd	43f10bdf-4d49-40f6-a825-8c2dafe27048	3	12	23.794931629058304	00:02:55
d379acce-e9ee-4ad0-a2d9-0f5a97cc4e4e	5cd3c3ce-e8e3-4b72-9b7c-3259dfbaf460	1	8	10.917276753346624	00:04:23
c44f3f9b-25f7-4a80-b9fe-5ef4dea1b795	5cd3c3ce-e8e3-4b72-9b7c-3259dfbaf460	2	9	32.02473718295363	00:02:52
c103db47-c7aa-4361-978c-b69a782ea24c	1e75a0a7-f317-4037-a053-23da25d4c7d5	1	13	46.78513044575326	00:01:32
8fc69cb1-abfd-4ac3-9a5c-2d01eb561de3	451d3f8c-d359-4bcc-9867-7d25782b2229	1	6	23.08684007392724	00:00:46
ab009474-3bf5-443e-9209-33928af5f5fb	451d3f8c-d359-4bcc-9867-7d25782b2229	2	9	45.88203725934036	00:01:31
da5ec4c2-1241-476d-accc-02499db4533a	451d3f8c-d359-4bcc-9867-7d25782b2229	3	7	29.157330943918573	00:04:22
cc77fbd0-71ae-4b06-bde5-19a9121d0962	e14d1415-7be1-4928-a609-cfc16eb2ffb7	1	10	36.86323110851489	00:01:55
bc2520fb-57d2-4d59-801b-f35311bc26b4	57b178a3-c455-4026-8d30-91526384bd46	1	12	30.971774043229093	00:00:51
89e31c33-99ff-45e3-b4af-69189e64b4e0	fcad5a08-0641-4926-8594-985cb9d6e2db	1	5	45.334216027934005	00:03:49
678f6631-3a22-425f-b5e9-87e25aa03fc5	0696abc3-bfde-4e0c-8c7b-f11e0bc1d1b9	1	8	18.865459608750054	00:03:17
1ee2e5bb-3306-462c-bdf9-2214e60500e6	0696abc3-bfde-4e0c-8c7b-f11e0bc1d1b9	2	7	42.537661913931196	00:03:46
fc089b9d-cc16-47a1-b925-0d7c9e2618ee	0696abc3-bfde-4e0c-8c7b-f11e0bc1d1b9	3	14	13.7014078778678	00:01:15
6dea0219-f21f-415d-8947-3e917390ea11	ede85d9a-42b0-46e3-8bbe-09d81b9beac1	1	8	44.14387992034081	00:04:26
b1a39b3f-e9b4-41a8-93be-b3da7ea0d451	ede85d9a-42b0-46e3-8bbe-09d81b9beac1	2	12	41.58855659168177	00:01:12
bc507206-ef64-4297-8c2c-e2c49c94ad32	552f7aab-b519-42da-8f00-bc0e9b15fe02	1	10	47.88620511359157	00:02:25
fb87bd93-c68c-47bb-9814-b247f47246bf	552f7aab-b519-42da-8f00-bc0e9b15fe02	2	7	42.58852284556618	00:01:44
4382b204-1073-4095-9d59-9f5ac9704bb9	ca797600-1d32-4ea7-8026-dc5e04eb933b	1	14	26.0192969976464	00:02:37
3ad48032-8775-465f-b47b-a45459cd557b	ca797600-1d32-4ea7-8026-dc5e04eb933b	2	6	12.02108093885618	00:04:15
7577b262-bed4-47c0-8ccb-bb5ce97eda0f	ca797600-1d32-4ea7-8026-dc5e04eb933b	3	10	20.379553619497777	00:01:51
d49dd8a5-f075-4350-9fb0-1ecb6c51916b	5507976b-5d65-4e86-a769-28b49a6c3ecb	1	11	48.55658707403731	00:02:47
fe9d8a84-2ff6-4edb-b17a-e1ce99f027e7	5507976b-5d65-4e86-a769-28b49a6c3ecb	2	14	34.21336462307285	00:00:24
30c1dabd-595a-48dd-ad63-dcf47c5c5635	b8b8c149-05a8-4943-bc02-fbba07cb5071	1	5	20.947168655902786	00:03:41
137659db-bcd4-42c8-9079-90924efb739d	970f4565-f923-4ec4-ade6-6ab836f4cbaf	1	11	35.11218112353876	00:01:04
01808d62-d1ce-4c65-9e6d-e83746cadfb2	970f4565-f923-4ec4-ade6-6ab836f4cbaf	2	5	28.975582046358245	00:03:16
0b55f7d6-343a-4c8f-ae9b-bccf84aec2bd	970f4565-f923-4ec4-ade6-6ab836f4cbaf	3	12	29.410955719653778	00:00:23
87b6342d-9193-4b20-9951-401e513a8a30	d32bded5-2d55-4c0e-b083-28d7ebd880a6	1	12	29.352245197484848	00:01:21
f4eb70ac-87cc-4786-9378-b7fcc4e78115	d32bded5-2d55-4c0e-b083-28d7ebd880a6	2	11	31.67800947939005	00:00:31
9e4ec156-ae45-44bf-b453-ba8337ce1fd4	50125be8-9495-4cbd-a1cd-811982f6d053	1	14	45.37586700174077	00:02:45
b851494e-5224-45bd-bc3c-7aac629d907a	46cb9790-7220-4ba9-83d0-31d23f526181	1	9	11.58264805021837	00:01:34
a9d7ae03-8cf2-4bbe-9088-d32aeae2701a	46cb9790-7220-4ba9-83d0-31d23f526181	2	14	45.00189708129988	00:03:12
ce4cfe2d-399f-4e6f-b965-23f08deafb40	46cb9790-7220-4ba9-83d0-31d23f526181	3	10	11.725938025083982	00:02:22
a1221c58-40d9-4fbf-b6a9-8da0486800c4	5a467799-73d5-4d0d-8682-8631ca6e1f73	1	11	26.95521634075725	00:00:06
5c258b4c-06da-4575-b94a-338a153712e4	5a467799-73d5-4d0d-8682-8631ca6e1f73	2	6	28.847680091253686	00:03:21
5d4e1b14-e58c-40db-a363-e6d068c014a5	8333bae2-3ac8-4a76-8a1f-aeba5873e12e	1	11	48.87520164130108	00:00:03
07801c7b-b721-49ca-b516-5840b811387a	741f2100-47bd-4a87-b344-d5d064f03620	1	5	35.02314892058539	00:01:09
2da86cba-b388-4cdf-9b4f-f79d645e4ac0	d85a548b-6b65-49a9-8922-5b9c733cd723	1	6	41.02947668367108	00:02:35
16a710a9-781d-4283-8f65-010974f4490e	d85a548b-6b65-49a9-8922-5b9c733cd723	2	13	37.12941725770109	00:00:38
855ac6c8-f569-4fbd-abf1-3c67b8ce42c5	d85a548b-6b65-49a9-8922-5b9c733cd723	3	12	43.37444114996773	00:03:25
278c993d-ad56-4c76-96c9-fa5c47cf7e04	6da0a0d7-6fff-4fdc-8b6e-959a40d66957	1	6	32.12498415902227	00:02:06
9236ec93-865b-40c5-967c-6498ef897a88	eeef8905-4f88-4b3f-9264-1fd8bd172c0a	1	12	44.5632726318877	00:02:41
0595b53e-0a0f-4968-aa1a-a458f9010cb2	491b196b-2d20-42ed-85d7-f0ff03d095cd	1	13	44.45715337633985	00:01:12
a69fba3a-bb97-4615-bcc6-4f4f25885965	719ae694-eb47-4c4b-b3e8-2374f3153f33	1	8	36.4709305226868	00:01:25
f63e17aa-4e2e-4ec7-acfc-3286876dd799	c2b8cd19-9241-402f-959a-6cb133009378	1	8	20.68621033906389	00:00:52
bd970614-c084-4035-b957-e6b26ba0bbe1	149d0f00-1b22-4fe1-8494-b27c576f40e1	1	12	11.395609816854263	00:02:36
4a8a43d0-3d5c-4426-8e8d-973ce5932ab4	149d0f00-1b22-4fe1-8494-b27c576f40e1	2	13	17.7299275461419	00:00:04
05a37139-229c-4bce-813a-2d7986f5dce0	4d1cc4f8-d1d9-4ac6-8d70-df48413d0cf5	1	8	16.357354645403113	00:04:26
981e9652-b622-479f-a4bd-04b7fa8395a7	4d1cc4f8-d1d9-4ac6-8d70-df48413d0cf5	2	5	47.78040511300253	00:02:05
0dbe80f0-cf37-49c5-bcb5-0dbb9db72e23	b2e3006f-bacb-4273-ac9e-c06c0922ff99	1	11	27.97200659465468	00:04:09
163ca630-4acf-4381-9116-39eff9aef6d8	b2e3006f-bacb-4273-ac9e-c06c0922ff99	2	10	14.728273775113486	00:02:56
af8531ec-45a6-4d5b-aca9-2597a8515d61	30948ab6-1798-4be7-a08b-fce0275fb8b1	1	12	29.05338876159402	00:01:51
a519d142-3db0-42d5-b476-ca8634a29f53	29e2eb74-2e90-4a36-a243-6132a4e76894	1	6	44.64096377383343	00:00:41
69ade9da-1472-4ea6-988e-ed2e51ef153f	29e2eb74-2e90-4a36-a243-6132a4e76894	2	13	39.11614292015203	00:04:31
229e0e0a-80e9-4575-b93c-526ef1b9a746	c5e0624f-9fc5-4ec0-92bd-b018634f21be	1	9	26.393128577199224	00:04:24
d4a63456-3bc2-4b5d-bb72-ecd3d2d9116a	c5e0624f-9fc5-4ec0-92bd-b018634f21be	2	13	23.794750871789734	00:04:19
230ca904-47f9-45d4-836b-f217c4c63bff	67b2ed6e-301b-481c-af85-789c6d5b3bb6	1	14	27.646841315411645	00:03:06
233dab10-6c25-4cae-9215-9cec03672233	45ee3011-2711-4c28-8429-605ebc90a028	1	8	49.127578475121986	00:01:10
91a5ca29-b3ef-4919-a211-7d181595fae1	45ee3011-2711-4c28-8429-605ebc90a028	2	7	14.388377916360788	00:02:29
247e8e74-18c5-4c84-b008-246dd7185e14	45ee3011-2711-4c28-8429-605ebc90a028	3	14	49.33456631719786	00:01:42
39851ac7-5d27-45ef-abe3-74ef01253918	731eaffe-a349-4445-978d-8b5a666619ff	1	12	22.548149780103348	00:01:56
715ad328-fb84-4982-a60c-725d35ad4bf1	0a4b0b02-aaa3-4c4f-80f5-54d616fe5fc8	1	6	45.44906788852222	00:04:38
c8def770-a8da-4ef3-a8db-2e8977700907	0a4b0b02-aaa3-4c4f-80f5-54d616fe5fc8	2	6	47.50726172085895	00:01:46
2a0c26bd-200f-4b32-8882-3db2206e2611	22fcf6a1-8af1-42f7-9e7a-d243f0b002f7	1	14	13.561231578903673	00:02:57
11e7dbba-ee4e-4968-b16f-fec2dec83987	22fcf6a1-8af1-42f7-9e7a-d243f0b002f7	2	12	47.686052713632414	00:01:39
85252d12-feb9-4312-b572-ee827e246e36	b63ad474-1e2f-4d65-9287-88a4f4c7aaef	1	7	36.36450691439723	00:03:31
df69db50-3566-4ddc-8b50-cf9ee401c230	b63ad474-1e2f-4d65-9287-88a4f4c7aaef	2	12	31.455931957041336	00:04:58
c67db94c-9f6c-4463-bfd6-f586b48a3029	00f8fbed-fd2f-454b-9da5-d521607696e0	1	10	17.92445654458234	00:03:01
26d25101-17e4-421e-be6b-e325f0d63015	00f8fbed-fd2f-454b-9da5-d521607696e0	2	13	46.36043348748678	00:01:43
55b93254-8d43-459d-89a8-6fc4571b620f	00f8fbed-fd2f-454b-9da5-d521607696e0	3	12	20.633759423841923	00:01:31
717780cc-d885-4797-ad4e-e857cb8d46a9	fe71797a-3479-4086-98d8-0c7b99a18f4b	1	14	26.76778054788375	00:02:42
385d4a3d-cf96-4ea6-8a42-fccdee54561f	076ce1fb-3072-4ea0-9851-ebc7b04bbbb3	1	11	13.378206929901165	00:00:44
87107fb8-4627-47cf-98bd-6da96c7c336f	316aad1d-0f5b-4039-9890-487308729b75	1	6	18.083127492424644	00:01:33
5e47829e-8d80-45eb-97b1-7819897ca57c	316aad1d-0f5b-4039-9890-487308729b75	2	11	16.179789137987278	00:01:01
4f63e33b-ee18-4b66-a5f7-8ddf144ca025	678907bb-e4ab-4a5a-b419-b2fddb39cc6c	1	12	35.48929695157294	00:04:10
c1929aec-9725-4995-ab3f-2d7579eaef07	678907bb-e4ab-4a5a-b419-b2fddb39cc6c	2	7	23.93392503051853	00:00:03
f248cbb0-1b96-48b3-a06d-8bb51d89e54e	4ee051c8-e8a6-48d3-9125-2e88103f9217	1	14	40.10842943222317	00:01:38
23f40c54-1295-4200-af61-340aeba816c5	4ee051c8-e8a6-48d3-9125-2e88103f9217	2	6	29.552828088336444	00:04:13
5221fe3b-fec6-4b41-ba5b-16e32bd96355	4ee051c8-e8a6-48d3-9125-2e88103f9217	3	9	12.509234769012275	00:04:58
7d613edf-0de8-4446-9e00-38c4a01b1d02	38149fb1-228c-4965-9f27-71393ca2c5fb	1	7	14.834365097664065	00:01:37
2baf917c-69f8-46e1-9467-10051450b637	38149fb1-228c-4965-9f27-71393ca2c5fb	2	6	12.299514469353038	00:04:41
b9123df5-0343-4ca0-91df-eb8f47f32bc7	38149fb1-228c-4965-9f27-71393ca2c5fb	3	9	38.37901896682221	00:03:57
32ec22f2-68a3-47e6-962c-cb698573d342	ca9983e7-4ce4-4e39-bcf0-135ca823ef8a	1	10	48.498735496522016	00:00:51
ff07d4df-59cb-4641-836b-fd4dc2d68db0	ca9983e7-4ce4-4e39-bcf0-135ca823ef8a	2	9	33.926768195264096	00:02:25
13e22cf7-2a68-4017-9af5-a0f2f8ee91df	ca9983e7-4ce4-4e39-bcf0-135ca823ef8a	3	13	24.99682489362531	00:01:47
bdc2f26f-da24-413a-b905-af0b89de7cfb	447a81c1-799b-41c5-a995-fd68b758c162	1	11	33.162316565510395	00:03:25
72f3cec5-7bf4-486f-8166-e7222ba008a8	59259538-7929-42b6-aafd-acce81c26263	1	14	18.83153167603284	00:02:46
1e3572cc-13fa-4e47-aad2-6748396bed2e	59259538-7929-42b6-aafd-acce81c26263	2	9	16.77874969072437	00:04:50
95822013-6159-483f-9edd-7462496e65a0	9faeff73-bc5b-4f61-b7e6-9d634589271d	1	8	21.398203861750872	00:00:41
21dad4f9-57f8-4069-84e4-d56c5d3412f4	9faeff73-bc5b-4f61-b7e6-9d634589271d	2	8	15.874539298819785	00:04:43
9221090b-58d2-4cab-bcc3-7d3597f9e087	76144e84-dfb3-4bc6-aa66-fc1334978642	1	7	15.67547547658388	00:03:58
c3b6b1ba-2d79-40e3-9dc8-cca636c7136c	894d2edb-2f69-4ee0-9162-cdb63929edfb	1	8	11.126514993192677	00:00:56
9c87e80c-83b1-4e47-8cbb-5e0c4e9b253c	894d2edb-2f69-4ee0-9162-cdb63929edfb	2	8	18.958155295670046	00:01:08
b7fe3f09-ca09-4da9-a5ed-2e2f1536a84b	894d2edb-2f69-4ee0-9162-cdb63929edfb	3	7	27.340359399921287	00:02:01
e84fd1a0-efd3-4fa2-af30-9651c89f0281	e58dd2cb-5821-4db3-b96c-64acc1cebb99	1	13	33.42943508719371	00:01:36
950e3237-a3fd-4008-b0d0-d70d3829ddf4	e58dd2cb-5821-4db3-b96c-64acc1cebb99	2	7	36.57648408301284	00:00:29
1a633eb8-b067-434f-a3d2-5fe62c35df17	89d9050d-8f40-4b5d-beab-5f4b019c6d04	1	12	10.17692367381763	00:02:11
6c2b8004-df87-4fdb-a082-6b7ee556a373	89d9050d-8f40-4b5d-beab-5f4b019c6d04	2	8	31.601197859591732	00:04:11
d94dd936-6584-4d9d-b38f-824fbff5d176	62f95d3a-9c0f-4d9c-be6d-abf509de398c	1	14	34.51644872041838	00:03:04
72e1cea5-fe9e-4abf-9d4a-f09052b8ed34	62f95d3a-9c0f-4d9c-be6d-abf509de398c	2	12	12.057420134004639	00:02:00
b0727b63-2cd9-45eb-8ad3-1f6d507e6606	cc51b51a-e0db-414a-bb38-3c317fa88c85	1	7	40.39981432999049	00:01:07
127c36e4-cb2d-45e6-9410-dce1c2075430	0efebda1-3fb7-4b1d-8811-34772d1a1915	1	10	10.081868178978413	00:01:56
9359dc9d-2bac-454d-af1c-1a0dfe96ddee	0efebda1-3fb7-4b1d-8811-34772d1a1915	2	8	40.33240595880787	00:01:18
c4391fc5-fe52-4d92-b2ef-ed590dcf728d	4f5c9fb6-c9e5-4650-882f-68335e5b1f0e	1	14	36.843668471102276	00:04:45
f441e83c-1bca-4e29-9438-7e7ec7524b4b	4f5c9fb6-c9e5-4650-882f-68335e5b1f0e	2	5	32.24339188629508	00:03:57
a35c6518-1ec9-4da1-bc36-40b077beeea1	b932666a-3520-4805-9f5e-a7fd31cfd9fd	1	14	39.06042474139939	00:00:48
56e76377-0bbe-4b0f-adf2-5894598eb3a9	b932666a-3520-4805-9f5e-a7fd31cfd9fd	2	14	10.187086226107917	00:00:11
30efbaaa-1689-4c89-8a44-af0a1fc9e7c9	43532fab-3e51-4e10-bcae-dde8af52b543	1	14	22.175998292033356	00:02:10
40e2fe93-319e-41df-b40d-3569886fec37	324f28e6-8206-44e1-9864-05c26e871d2f	1	14	40.960204679664656	00:00:46
d267ed7b-453f-4064-a359-5f52b28f22d8	324f28e6-8206-44e1-9864-05c26e871d2f	2	6	37.283637652199644	00:03:38
345eff8b-6a60-4e2d-ba97-058ab5ce2855	324f28e6-8206-44e1-9864-05c26e871d2f	3	6	33.15440383179586	00:02:16
86ce0d5a-aff9-47db-985c-48dffbd61733	b103e1e9-5692-43d3-a141-f6bd3e41e509	1	14	16.180645821544175	00:01:31
98fcf4cb-09cd-4b15-8b48-7d040b29bcbe	b103e1e9-5692-43d3-a141-f6bd3e41e509	2	5	26.490388190978788	00:00:39
61e7c6bc-445f-4a0c-85c6-fd22f25e7fba	738f78ce-42b3-4111-89c1-c8efc2f65e2e	1	13	45.9906850192178	00:01:47
d3dec514-1eda-4521-b936-d6db56f3bd56	738f78ce-42b3-4111-89c1-c8efc2f65e2e	2	13	17.08206085258312	00:00:41
aa9cac5b-7456-4a32-b3a4-c7b95e9f051d	92707d5a-ca65-43a5-9207-d93bf75d9431	1	14	31.22187326235587	00:03:44
2e2662ab-4779-489d-b82a-1abbbe083da3	92707d5a-ca65-43a5-9207-d93bf75d9431	2	10	33.197032147096635	00:03:35
406a2cff-287d-4d91-9d9d-5281f5a0da71	0ede3d4f-0022-4ba0-b1e4-76f8f1386eb4	1	5	44.10388060222746	00:03:00
59982b98-7034-450d-9ff4-e35c9b5cc9b1	0ede3d4f-0022-4ba0-b1e4-76f8f1386eb4	2	8	36.90185271979452	00:04:08
5e011ef4-cfc7-43c7-8ed8-331d28b26409	bcce287a-4e0c-445a-8339-548ac88c5273	1	11	30.15389703545913	00:02:26
4b7b418a-2631-424e-829a-712b986bee27	bcce287a-4e0c-445a-8339-548ac88c5273	2	6	25.018835458534355	00:02:15
14caf062-5acd-44eb-99d3-9113eaf54b63	bcce287a-4e0c-445a-8339-548ac88c5273	3	12	19.901771772113257	00:03:54
4f75a821-2627-4fca-b79e-2b2bb0db84ff	3c29bc94-b0bc-467f-a916-fede13c3929d	1	12	39.63094907143481	00:03:00
a7c1c313-1f25-4b58-9420-724087f302f3	3c29bc94-b0bc-467f-a916-fede13c3929d	2	10	17.636245202927533	00:04:45
4c4fc9dd-d088-498a-9020-ebf94ce0f119	188f2854-eb1f-497a-b633-18bdf566f092	1	12	47.580487218026676	00:02:41
2055f4d9-e4b1-4d69-93a2-c97dd7e9091c	188f2854-eb1f-497a-b633-18bdf566f092	2	9	38.755176013723236	00:01:27
\.


--
-- Data for Name: device_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.device_data (data_id, device_id, "timestamp", metric_type, value, unit) FROM stdin;
bc555930-bd19-4e6b-84af-81ffe126741d	389b29b0-16a0-49ff-8d14-b17fdc6e8485	2024-08-30 11:01:15.670532	cortisol	16.971155471684	nmol/L
80f7cad0-d836-4ade-b4d7-b805785cb474	389b29b0-16a0-49ff-8d14-b17fdc6e8485	2025-03-24 09:01:15.674712	cortisol	22.761900640128708	nmol/L
e6527eb8-bad6-4c97-a89f-f22801aadc00	4189ca29-ca62-4333-b899-6a95a4a92b9d	2024-08-02 15:01:15.678251	blood_pressure	128.56287926297932	mmHg
8af8ecfb-a4c7-4250-ace1-e71440ff0d4c	4189ca29-ca62-4333-b899-6a95a4a92b9d	2025-02-14 23:01:15.681001	gps	-16.078086909792233	degrees
ad556208-4689-4935-8a87-8c31c4d34e7b	176844c9-d910-494a-8122-81450e2f3cdb	2025-02-19 23:01:15.684111	oxygen	97.25431056766995	%
d9a772ea-5ee4-4ccb-8bac-df7ded0f91e3	176844c9-d910-494a-8122-81450e2f3cdb	2025-01-24 00:01:15.686864	cortisol	22.568478885602808	nmol/L
464718c8-db93-48ac-bee0-c15621d73e4d	adee6114-5e9d-423c-9047-9bff41ff6211	2024-08-25 20:01:15.690147	hydration	57.39202107344254	%
f11f5508-70ec-4d17-8648-ce6923329cfc	42cfa65e-0b3e-448d-a4c4-efbad0d77519	2025-02-23 21:01:15.693674	heart_rate	75.57772562143191	bpm
4efce2f9-4465-403a-ac92-531c2d29bf95	42cfa65e-0b3e-448d-a4c4-efbad0d77519	2025-04-20 02:01:15.696591	oxygen	97.49363816272214	%
e6e1fde1-153a-4302-9724-7fccf8dd5685	42cfa65e-0b3e-448d-a4c4-efbad0d77519	2024-09-24 14:01:15.699661	oxygen	96.38299633236412	%
2e3fe3b0-d7f7-4834-93d8-b82ccb57405b	42cfa65e-0b3e-448d-a4c4-efbad0d77519	2024-07-27 01:01:15.702867	stress	7.636297009787692	level
775da827-4d66-44f3-a475-16d192b8a6c2	42cfa65e-0b3e-448d-a4c4-efbad0d77519	2024-07-20 18:01:15.705716	glucose	119.7152004272783	mg/dL
1da744af-4e2d-4bc4-956d-41110bf1038c	d8f1c438-e761-421c-95c9-c9ea04fc07d7	2025-03-02 14:01:15.709228	blood_pressure	90.52948292883715	mmHg
0c4cc815-e057-456e-b9f1-b874b2eb2e86	d8f1c438-e761-421c-95c9-c9ea04fc07d7	2025-04-05 15:01:15.71236	heart_rate	74.0099684760462	bpm
cfc289cc-5ca2-420e-bbf5-33bc1a659fdf	d8f1c438-e761-421c-95c9-c9ea04fc07d7	2025-01-03 12:01:15.715675	cortisol	11.573315216396178	nmol/L
efe173a2-161c-4f0a-a1b8-0798cd9ef0ce	d8f1c438-e761-421c-95c9-c9ea04fc07d7	2024-12-05 22:01:15.718691	cortisol	24.443087142401794	nmol/L
858fa9de-1972-48c0-8e09-5deebe492557	2f0c8cbc-9e7f-4304-92f7-27579f85d052	2025-03-28 16:01:15.72199	stress	1.245889416812759	level
9bdf9790-6356-4cbb-93dc-f0af9cf208fb	956cf925-c1f5-4105-8778-be0905c1d9af	2025-01-05 01:01:15.725412	ecg	4.45341620023083	mV
2edf44f2-858f-410e-a0ed-4fde1fca7c83	956cf925-c1f5-4105-8778-be0905c1d9af	2025-01-01 16:01:15.728157	body_composition	35.34198853946056	%
f7d5084c-3bd0-4f32-ba02-baad44342be1	956cf925-c1f5-4105-8778-be0905c1d9af	2024-09-17 23:01:15.730937	heart_rate	73.47019307708601	bpm
5a458052-9258-4013-bfc3-7684920dd8d6	956cf925-c1f5-4105-8778-be0905c1d9af	2025-01-07 20:01:15.734131	stress	2.818657810320431	level
87cf06c0-81b8-4d9a-acea-8dae9b174f2b	0376d67c-7d53-40ad-9c69-cebdb7266ed8	2024-10-20 02:01:15.737234	heart_rate	67.41222188303075	bpm
a8aaa3b2-b080-447d-a810-5a66de2f5b7e	0376d67c-7d53-40ad-9c69-cebdb7266ed8	2024-12-10 23:01:15.740012	hydration	91.36039706437126	%
179a650f-df61-46e5-9439-05aa4df9cdda	0376d67c-7d53-40ad-9c69-cebdb7266ed8	2024-09-25 05:01:15.742769	stress	6.705848858602375	level
c6eca1bf-76ff-4f8a-8aaa-3391b6e247eb	0376d67c-7d53-40ad-9c69-cebdb7266ed8	2024-07-13 23:01:15.745574	heart_rate	98.66305287052793	bpm
5be3505f-cb7e-4960-b84b-004955ab0c64	0376d67c-7d53-40ad-9c69-cebdb7266ed8	2024-07-27 02:01:15.748745	cortisol	15.687267727023988	nmol/L
60bdeaf4-fdc8-4e90-9146-3265713b9818	3a187f8a-5012-4856-a58e-15c64c7e838a	2024-07-28 05:01:15.751799	heart_rate	98.91728187943383	bpm
9c729311-d5d8-44cb-9a0c-b68c11cdd95e	3a187f8a-5012-4856-a58e-15c64c7e838a	2024-11-04 20:01:15.75472	ecg	4.86490670033157	mV
310b8da1-5951-41f5-a662-cecc00c74051	3a187f8a-5012-4856-a58e-15c64c7e838a	2024-08-03 19:01:15.757562	oxygen	97.36169120689787	%
129696cb-e5fd-4635-acbd-18b79f51684a	3a187f8a-5012-4856-a58e-15c64c7e838a	2024-09-22 00:01:15.760371	ecg	2.1336007625707323	mV
3a042d06-13da-47b7-b567-fa1c5623e50d	4e9fb085-f448-4a10-8882-3cc7fa1a8e0d	2025-02-23 17:01:15.763159	gps	37.77840233232547	degrees
780c7cba-5970-414a-a4da-34891c4d34da	4e9fb085-f448-4a10-8882-3cc7fa1a8e0d	2025-01-04 18:01:15.76581	blood_pressure	98.5849396037908	mmHg
3b66fd8a-7f18-4278-8f4c-d9f7d17bd4ce	4e9fb085-f448-4a10-8882-3cc7fa1a8e0d	2024-11-09 06:01:15.768651	ecg	0.8429227429143917	mV
3f21276e-31b9-4ee5-941f-e53017cce66a	4e9fb085-f448-4a10-8882-3cc7fa1a8e0d	2025-04-07 18:01:15.773871	cortisol	14.985335999224606	nmol/L
cad96d66-9959-4126-8f55-9b81632fcaf4	4e9fb085-f448-4a10-8882-3cc7fa1a8e0d	2024-11-27 01:01:15.776742	oxygen	97.32383207676664	%
57a83412-146e-4274-a8f0-0b3c0bcf432d	6a6b9304-b019-4053-85f9-4596d005d2c8	2024-12-09 13:01:15.780166	temperature	36.518485063913936	°C
9692923f-b1c0-4e3c-83fe-2c96f87e4b40	6a6b9304-b019-4053-85f9-4596d005d2c8	2025-03-10 23:01:15.782926	hydration	71.67531934731812	%
e78d6bba-e06b-4510-9a8e-dcc502a2f31d	6a6b9304-b019-4053-85f9-4596d005d2c8	2024-09-12 13:01:15.786068	heart_rate	96.0888582747643	bpm
e0aeb328-56cf-4e0f-9374-003b89179946	6a6b9304-b019-4053-85f9-4596d005d2c8	2024-08-30 05:01:15.788941	ecg	3.828775534624353	mV
7e23221b-f01b-474a-96fe-e8864358bb1d	6a6b9304-b019-4053-85f9-4596d005d2c8	2024-12-06 10:01:15.791851	gps	-49.141550049464115	degrees
c5894393-6fc5-4b57-aa12-3cdfe02d5b83	7de1e112-34e3-4f40-90c2-c5df2b4cc902	2025-05-04 00:01:15.795003	heart_rate	80.4776955227631	bpm
e422f559-d784-47de-948b-d9d4bc9611ca	7de1e112-34e3-4f40-90c2-c5df2b4cc902	2024-06-06 07:01:15.797794	ecg	2.500076934827981	mV
2fa074ce-d285-405a-a600-e2dc34c8d92d	7de1e112-34e3-4f40-90c2-c5df2b4cc902	2024-07-30 17:01:15.800626	gps	15.908747956840301	degrees
fecf9276-9c43-41c8-a779-a2449e8112c3	7de1e112-34e3-4f40-90c2-c5df2b4cc902	2024-11-07 10:01:15.8038	body_composition	19.678483708698863	%
1fefb515-5c91-4415-b5ec-4dd4ba365bcb	7de1e112-34e3-4f40-90c2-c5df2b4cc902	2024-08-24 07:01:15.806594	oxygen	99.50833603440142	%
6aa763f4-7f77-467f-aad2-42cbf4e2bd51	396a47c1-25a2-4fe1-8709-9451f407ec5f	2024-10-02 00:01:15.809521	cortisol	14.063260530272455	nmol/L
0e636a2a-ed5c-46f9-851a-ad89fba7445c	a6b08480-331c-4cf4-88e1-526f91373584	2024-06-24 07:01:15.813009	body_composition	38.01958937896395	%
0956dd61-8798-4108-b14f-17a1bc3281cd	a6b08480-331c-4cf4-88e1-526f91373584	2024-12-13 05:01:15.815729	ecg	0.29696183584584057	mV
55824b17-d6fe-43a5-b23c-4f8923a874ac	2af22c20-10b3-4c1e-85d6-b5e9e0ee1813	2024-07-22 05:01:15.818654	temperature	36.89892746758382	°C
8f27c2ee-26e4-4ff8-a5ac-f442236f2b84	9fb5276a-0222-45d3-9562-ee062857d3e7	2024-08-16 22:01:15.82152	body_composition	17.861069966137652	%
819f7da6-8cd1-46c9-bffb-5be5f9096a3f	1a0fe3c6-0f9b-4d96-9912-2c9086031513	2024-07-12 08:01:15.824274	gps	34.27586526739438	degrees
89d8125c-4757-4db3-884e-7b40df5460c5	0079839c-cff8-42ac-8208-6abad874d22f	2025-03-14 08:01:15.82717	temperature	36.9507188946856	°C
e7087a3a-6c8d-4c8b-a91e-d5b023ef9480	0079839c-cff8-42ac-8208-6abad874d22f	2024-06-16 00:01:15.829997	temperature	36.76147239842509	°C
e09f7e26-55c3-4812-819b-babca8eed27d	0079839c-cff8-42ac-8208-6abad874d22f	2025-04-21 23:01:15.833076	stress	2.3698658280805	level
cd244752-8b26-4ecc-9f1d-e5f8b61ca83f	168816fb-c589-4402-8a4a-61d86b9102e2	2024-08-23 06:01:15.83634	cortisol	5.903064835943065	nmol/L
701b61fb-07cf-48bd-a2cc-52ab91533a6a	168816fb-c589-4402-8a4a-61d86b9102e2	2025-01-05 08:01:15.83969	oxygen	97.45835986762432	%
74b9fe45-e517-4b53-a417-4888ab33773b	cf78f11a-36f8-49ff-bd31-f5a01aaa7317	2025-03-18 21:01:15.84333	gps	-39.59457655206144	degrees
788c939c-f825-4804-bf15-ab98db9dea69	cf78f11a-36f8-49ff-bd31-f5a01aaa7317	2025-05-28 09:01:15.846188	oxygen	99.6748972060468	%
15051576-1836-457c-b42b-7caad8b6fcbf	d15b2885-3bab-4f9f-ad27-21deaa02f2e3	2024-08-12 15:01:15.849685	cortisol	6.587473453467208	nmol/L
25ce8505-aeec-45e4-be50-1993982be7c3	d15b2885-3bab-4f9f-ad27-21deaa02f2e3	2024-10-20 10:01:15.852774	hydration	79.84852533806406	%
d4c65741-94c3-4100-943a-41c431d70aff	d15b2885-3bab-4f9f-ad27-21deaa02f2e3	2024-06-26 04:01:15.855873	cortisol	8.444254801440279	nmol/L
287f6ad4-e4de-4024-9ebc-bcaa6763f910	d15b2885-3bab-4f9f-ad27-21deaa02f2e3	2024-10-28 01:01:15.858988	glucose	71.76462135238843	mg/dL
2d300868-b4b9-49e6-895f-3989fe392a17	d15b2885-3bab-4f9f-ad27-21deaa02f2e3	2025-05-01 03:01:15.861882	blood_pressure	95.04713141079262	mmHg
df328ea7-8ad5-40ce-8c17-abe05f028804	be9fd286-386f-4c3e-88f2-1caa6ca74f45	2024-10-19 22:01:15.864883	body_composition	16.15513002741414	%
62abcf91-9fd3-4610-92b7-a427a421e7a0	be9fd286-386f-4c3e-88f2-1caa6ca74f45	2024-12-20 22:01:15.867801	temperature	36.59846853522651	°C
365d80b1-1720-4e90-a76e-fdcdaac0b678	97708edd-ef3e-4187-8328-4ab80ed76b97	2025-05-22 10:01:15.870875	stress	1.2526999933821414	level
c5613a70-9233-4d01-8322-5a26e41ee193	97708edd-ef3e-4187-8328-4ab80ed76b97	2024-09-15 21:01:15.873811	heart_rate	71.45102068084262	bpm
f1cbc8a4-9d0f-4743-9965-9aed9341c00d	97708edd-ef3e-4187-8328-4ab80ed76b97	2025-02-07 07:01:15.87704	heart_rate	63.95232423871048	bpm
61f08b44-d918-46a1-bb32-c364ed3c38b6	52aa1682-69a2-4e79-980c-7f9e7814cc0d	2024-07-17 19:01:15.880421	stress	2.8323036903263006	level
9ff4cbfa-9188-47be-9792-c01a4d48cb47	52aa1682-69a2-4e79-980c-7f9e7814cc0d	2024-12-25 11:01:15.884195	cortisol	5.950721788611325	nmol/L
3e6bd907-e32e-4ba0-964c-ff062c2b9b7c	db6d1b08-ec42-4c65-ac29-704fa7adcdf5	2024-12-07 11:01:15.887378	heart_rate	73.53037401100806	bpm
ee325195-d6b0-4937-aa84-e0895783127e	125d4520-4651-4f1d-8a16-b0f79bf3dbe9	2025-04-22 23:01:15.890451	glucose	120.48345351623897	mg/dL
2cd0c052-d538-4eb2-8676-b9fd41a73f31	125d4520-4651-4f1d-8a16-b0f79bf3dbe9	2024-06-24 12:01:15.893791	ecg	0.5611046947241649	mV
40c18d75-877d-4c49-8202-bf433429d868	125d4520-4651-4f1d-8a16-b0f79bf3dbe9	2025-03-07 22:01:15.896668	cortisol	16.83916520067534	nmol/L
51f82b33-c64d-4dd7-a167-124237193722	125d4520-4651-4f1d-8a16-b0f79bf3dbe9	2025-01-23 00:01:15.899643	gps	-2.203912028561831	degrees
7ba48bcf-30ca-4f9a-bcae-fab57728a862	f7f974bb-e756-4d55-960b-68fc576637a3	2025-05-27 09:01:15.902473	ecg	3.428968027801401	mV
9c85e9ac-d76c-4460-90c5-9579b2b43fac	c3a60975-9de4-4bc1-ae09-98dfea06eee5	2024-11-20 11:01:15.905394	blood_pressure	99.88269275416694	mmHg
8b19ade5-028f-43ca-95c3-268a53bdf653	c3a60975-9de4-4bc1-ae09-98dfea06eee5	2024-08-15 15:01:15.9086	glucose	98.74027803595266	mg/dL
70aa6af6-888f-4715-9aaa-0371e6bfadd7	c3a60975-9de4-4bc1-ae09-98dfea06eee5	2025-01-30 00:01:15.91134	heart_rate	77.9105045177553	bpm
94afaa95-260b-4dd7-b2ca-b65e192e7985	c3a60975-9de4-4bc1-ae09-98dfea06eee5	2024-09-29 04:01:15.914138	ecg	1.4785660767454787	mV
dff146f6-cfc2-4a8d-b59f-b174060d4ba9	c3a60975-9de4-4bc1-ae09-98dfea06eee5	2024-08-10 05:01:15.91731	hydration	53.34685816900777	%
30e9e8d4-9187-4490-8064-d356f5d715ea	07501359-f5c1-433b-86d6-68e1d47e41a9	2024-09-17 09:01:15.920743	glucose	133.86563795466196	mg/dL
2757215c-e561-4001-bd31-445708d19bb3	07501359-f5c1-433b-86d6-68e1d47e41a9	2025-02-26 08:01:15.923856	cortisol	7.5330040370015166	nmol/L
941a901a-7e58-4c5b-8e3f-9030a9e2836d	07501359-f5c1-433b-86d6-68e1d47e41a9	2024-11-14 04:01:15.92698	ecg	0.8145745385289151	mV
2c0e4bdc-34e0-45de-8258-1eb62b80fddc	07501359-f5c1-433b-86d6-68e1d47e41a9	2024-08-31 01:01:15.930136	temperature	37.31108162385541	°C
a34a40ec-6759-4bb2-be9e-60ae210854cb	9f67e627-2bf7-4bcb-9918-9db49024911a	2024-11-07 11:01:15.933585	heart_rate	89.68531360770677	bpm
6091b1e4-9885-4bbe-a756-1f6389602700	38f572ee-8ec2-436e-b7bb-b60eb2c00c5b	2024-12-04 21:01:15.936582	glucose	107.3483688348843	mg/dL
a0e880ee-fe15-4259-be1c-e37f1b7b0ec1	38f572ee-8ec2-436e-b7bb-b60eb2c00c5b	2024-07-13 17:01:15.93984	gps	12.600730697696434	degrees
25b482d4-1d63-465c-86dc-7783eccd3c2b	38f572ee-8ec2-436e-b7bb-b60eb2c00c5b	2025-02-02 20:01:15.942769	stress	9.68842160130184	level
da77d96c-bf86-4ebf-98ab-d1ee4d7498e5	38f572ee-8ec2-436e-b7bb-b60eb2c00c5b	2025-04-19 18:01:15.945901	heart_rate	91.66318260890084	bpm
8dd22fb7-7dc0-431a-9579-12400f73571d	7f91c023-9078-49e9-ac76-178c7233073a	2025-01-09 04:01:15.949553	hydration	54.8444695471267	%
8a228616-2158-4cad-a9c6-a30ca380543a	636cb392-e05c-4b4d-b6d3-c6937a2bedb0	2024-10-24 05:01:15.952687	gps	89.2306060818847	degrees
f2247439-6b39-4c8f-8131-8cab8d988cfe	636cb392-e05c-4b4d-b6d3-c6937a2bedb0	2024-11-18 20:01:15.955705	oxygen	96.3703014796657	%
a029f4c0-5e08-41c1-8bcb-da9a436c026e	636cb392-e05c-4b4d-b6d3-c6937a2bedb0	2025-03-15 04:01:15.958643	body_composition	24.666707731159804	%
ed13b25e-d1a2-4c06-8de8-ad68ae01c62c	de02eac5-614f-4ce8-bd07-b15783354782	2024-12-05 22:01:15.961758	cortisol	17.538891585566247	nmol/L
3b752a63-c06f-45d2-bc2c-678327068520	de02eac5-614f-4ce8-bd07-b15783354782	2025-03-12 15:01:15.964966	heart_rate	94.69200904277787	bpm
637905a8-da8b-40a7-a42a-9f777b137ffe	de02eac5-614f-4ce8-bd07-b15783354782	2025-02-18 23:01:15.968486	heart_rate	66.35425488165806	bpm
ad62c227-7418-4a3e-881a-72fc9184cc43	789c0e2e-bd89-4520-967e-dae845788bb5	2025-02-16 07:01:15.971686	cortisol	9.915686424112494	nmol/L
56137a80-a43b-4085-9f49-4f4a5945261d	789c0e2e-bd89-4520-967e-dae845788bb5	2025-04-24 03:01:15.974714	oxygen	95.26740334294146	%
328a0d87-ad3c-4095-a868-8b5e7a14320f	789c0e2e-bd89-4520-967e-dae845788bb5	2024-10-26 10:01:15.977628	temperature	37.41881819745747	°C
404c37da-1142-4e88-9cfb-860fd20cf5cf	789c0e2e-bd89-4520-967e-dae845788bb5	2025-02-07 12:01:15.980499	body_composition	35.854317211303496	%
f9454fa7-2a1a-46d4-8656-6803866841a5	789c0e2e-bd89-4520-967e-dae845788bb5	2025-04-10 01:01:15.983312	stress	2.3621567784494757	level
96b5729b-9ed6-4fa4-ae65-9f00f3b26408	60afc68b-6ccd-4340-ab80-206ce88a0dab	2025-06-03 11:01:15.986708	glucose	93.70445697767747	mg/dL
31ae9b4b-3364-470e-9ee6-4194bb79e1bc	60afc68b-6ccd-4340-ab80-206ce88a0dab	2024-07-10 23:01:15.989683	ecg	1.1953076812343024	mV
95b4ae1d-ac71-4ae1-8e2f-4d5351049f7b	60afc68b-6ccd-4340-ab80-206ce88a0dab	2024-09-07 03:01:15.992641	hydration	97.45710605388348	%
e07f5c54-5a2c-4cd5-834f-1214fb5e18f8	5693988c-0f00-4d45-9688-c6767fd1584d	2024-06-25 14:01:15.995979	glucose	122.18279064696395	mg/dL
bbc040ce-cfb3-42d9-90e6-f9611a8b1903	5693988c-0f00-4d45-9688-c6767fd1584d	2024-12-18 23:01:15.998873	body_composition	27.361558803116573	%
35000ee7-b819-4adf-92fc-44268abe7fcb	5693988c-0f00-4d45-9688-c6767fd1584d	2024-12-25 02:01:16.001673	temperature	36.93546603716062	°C
eac009ec-d1c7-433a-b941-c94361a9a667	5693988c-0f00-4d45-9688-c6767fd1584d	2024-08-09 20:01:16.004648	heart_rate	94.42306511549779	bpm
4d634791-e9a2-4306-b229-4b0a10c6e0c9	5693988c-0f00-4d45-9688-c6767fd1584d	2025-05-10 04:01:16.007689	heart_rate	68.48066032759776	bpm
d2a3377d-7097-4470-822d-5168ebac5143	503080ce-bec7-41c5-9374-a3136718d93f	2024-09-30 03:01:16.010779	gps	-39.55108191865253	degrees
761d4c89-14ed-4b2d-8f4b-b0c9f7aca100	503080ce-bec7-41c5-9374-a3136718d93f	2024-11-03 13:01:16.013644	body_composition	23.312295244835155	%
23210cd3-f2e0-499c-aa2c-fe87edae61c5	503080ce-bec7-41c5-9374-a3136718d93f	2024-06-28 07:01:16.016574	blood_pressure	120.62081407879006	mmHg
90a6a12f-0411-4484-a93d-94080fb3784d	503080ce-bec7-41c5-9374-a3136718d93f	2024-11-16 17:01:16.019476	body_composition	34.47435663856439	%
21f8b278-b3cc-46dc-8f99-b07422c910ef	503080ce-bec7-41c5-9374-a3136718d93f	2024-08-20 16:01:16.022277	body_composition	20.56292609248114	%
2ecb9764-2fb6-455b-8968-c745756642a2	7bf3b767-2f92-475d-8377-031f8912a9b3	2025-02-06 22:01:16.025512	stress	9.21458065435704	level
5f5b6d69-068c-41f7-bec2-c81f90c09ec4	7bf3b767-2f92-475d-8377-031f8912a9b3	2024-12-01 08:01:16.028553	cortisol	13.783486119028186	nmol/L
f06c381f-2238-487e-8293-062ba07f9912	7bf3b767-2f92-475d-8377-031f8912a9b3	2024-12-28 10:01:16.031554	ecg	3.2819780149128355	mV
631eff19-d361-481b-90d2-33d60dfc655c	6f6c48a3-4da7-4a45-ab9a-5febde7393b4	2024-08-18 20:01:16.036122	stress	1.3156184867944178	level
48d08a19-7f63-4f3c-a00d-86cdb0369b84	6f6c48a3-4da7-4a45-ab9a-5febde7393b4	2025-06-01 09:01:16.040653	hydration	97.34985731205188	%
58e33c62-cf1d-4213-a7b9-cbb41f929946	8eed4b93-c4e1-4446-bf89-8ebd345063dd	2025-03-25 01:01:16.044065	heart_rate	65.15482158924807	bpm
78b4ba81-8497-49dc-a99f-bab6795d7e34	8eed4b93-c4e1-4446-bf89-8ebd345063dd	2025-01-18 22:01:16.047725	heart_rate	67.79010612482843	bpm
7acadd85-cddf-43da-aef1-a9cf5d77a17b	8eed4b93-c4e1-4446-bf89-8ebd345063dd	2024-08-29 14:01:16.051785	blood_pressure	128.56513893121183	mmHg
56868493-efe0-4150-850a-95027ca30275	981c8652-5766-4d23-9893-182fccd59b4a	2025-01-21 18:01:16.055453	hydration	54.30837705202353	%
dd3b1d9e-d129-469f-b0b3-2f24caf77450	981c8652-5766-4d23-9893-182fccd59b4a	2024-12-09 23:01:16.060881	glucose	129.4518147269022	mg/dL
294d4212-25bb-4561-bb18-a0ef205377d9	981c8652-5766-4d23-9893-182fccd59b4a	2025-05-02 14:01:16.067047	body_composition	20.35418500516538	%
45d31560-2d21-4a68-bf9e-24723069ab4a	d04074fb-51c9-4896-979d-aa681fdfff4d	2025-02-05 19:01:16.070611	glucose	115.9141427861503	mg/dL
6443731b-1d7e-47c2-b490-a5980a19a1a5	d04074fb-51c9-4896-979d-aa681fdfff4d	2024-07-19 01:01:16.073785	body_composition	32.612651495304284	%
5a3492bf-02c5-4a22-a42d-93d07be45793	d04074fb-51c9-4896-979d-aa681fdfff4d	2025-03-06 08:01:16.076895	blood_pressure	107.21414806451388	mmHg
16777101-bb92-40c8-bc84-d8e99f84010e	d04074fb-51c9-4896-979d-aa681fdfff4d	2025-04-19 02:01:16.079983	cortisol	10.076888165223977	nmol/L
a69f3deb-429d-49ba-8339-0c3efc3db021	d04074fb-51c9-4896-979d-aa681fdfff4d	2024-09-21 00:01:16.084123	cortisol	12.578692980764592	nmol/L
64bafab0-e8be-46ec-865f-ef807c121439	8f9425fd-b1a8-4d8f-af68-9fa12a994aac	2025-01-08 21:01:16.087393	ecg	2.118767855593859	mV
ecc52c6f-ab12-42f9-b833-17ade35b07b0	8f9425fd-b1a8-4d8f-af68-9fa12a994aac	2025-04-01 14:01:16.090494	stress	2.2864841880125835	level
ed0a48f3-e5d7-4852-8fce-79902621360e	84f67b42-431b-40b7-b352-bf676399c860	2024-09-29 22:01:16.093979	gps	-85.1135230381863	degrees
dd03552b-515f-4771-b15f-8b942ca81ea6	84f67b42-431b-40b7-b352-bf676399c860	2024-08-18 20:01:16.096996	hydration	89.88096369594075	%
79ee4659-f58b-42c4-940e-d19e80049efb	84862eba-834b-43df-8fcd-c1837cc23958	2024-11-21 14:01:16.100172	cortisol	23.78911981940967	nmol/L
392119b1-646c-489a-8217-cfca590100c0	84862eba-834b-43df-8fcd-c1837cc23958	2025-05-08 13:01:16.103005	cortisol	10.157470340266304	nmol/L
e019e229-17bc-4ab8-9c16-8772ffe005c8	84862eba-834b-43df-8fcd-c1837cc23958	2025-04-18 13:01:16.10578	cortisol	16.438189867081043	nmol/L
36edbbc6-4319-4b25-bf9d-e1fe4a5196e8	ef159426-522b-4f45-b58f-8f8db6514bee	2025-04-23 10:01:16.108767	gps	47.94608138802141	degrees
c9131202-b307-434a-920f-b1a9e49e02e7	ef159426-522b-4f45-b58f-8f8db6514bee	2024-11-30 02:01:16.111631	body_composition	10.476964430401816	%
fda5d075-023a-4322-a25c-1fc9162fa25a	8c45558b-4a92-4d90-b84d-1dc326d03bd3	2025-02-16 21:01:16.114525	oxygen	95.48873486405896	%
2afa4ea7-a1be-46e9-9ecf-7f58ff0bb7e5	8c45558b-4a92-4d90-b84d-1dc326d03bd3	2024-10-29 01:01:16.117395	stress	9.152148767853598	level
a395adca-0020-4b0a-b789-c4826fb5f72f	8c45558b-4a92-4d90-b84d-1dc326d03bd3	2025-03-05 01:01:16.120143	blood_pressure	104.0847091405115	mmHg
2e79fd8a-f181-463d-9b52-3c75a673d7fc	b3a58eaf-147f-4c10-b1dd-b28082f77cbb	2024-06-22 16:01:16.122953	glucose	86.75418092454223	mg/dL
3a241701-aeec-49ff-9f46-12d564c41d88	b3a58eaf-147f-4c10-b1dd-b28082f77cbb	2024-06-19 22:01:16.125725	temperature	36.9600489954457	°C
e3b1b6d0-28f7-421c-9c38-84e75ca3348c	b3a58eaf-147f-4c10-b1dd-b28082f77cbb	2024-08-20 20:01:16.128565	body_composition	16.13014352722171	%
775e5133-7d08-4820-ab61-d34b03166bfc	b3a58eaf-147f-4c10-b1dd-b28082f77cbb	2024-08-22 20:01:16.131456	stress	8.676372411840013	level
10c3460f-4f94-40f1-b41d-b5e02e58227d	b3a58eaf-147f-4c10-b1dd-b28082f77cbb	2024-08-17 19:01:16.134344	oxygen	99.66703876021784	%
834e596c-ff19-40fa-b8cc-d9df69861ef8	047771f9-04a5-4436-8a4d-29db45abe461	2024-12-18 03:01:16.137544	ecg	0.2636213515128387	mV
3dc2a2e3-a47d-4bfc-b0e3-98c3942496aa	047771f9-04a5-4436-8a4d-29db45abe461	2024-06-11 02:01:16.142621	heart_rate	67.8018348685316	bpm
ddf2b043-40ea-4eae-aa29-d700598eedb9	047771f9-04a5-4436-8a4d-29db45abe461	2025-02-14 17:01:16.145981	stress	0.02208064409746843	level
fb4f30ce-9b94-4378-9857-323ee1168e1e	31b3d2ee-1a12-473c-a4aa-1fc7cb304fbd	2025-05-09 06:01:16.149404	gps	69.06350338249652	degrees
099081c0-89eb-488f-a527-982913d0c09e	31b3d2ee-1a12-473c-a4aa-1fc7cb304fbd	2024-12-26 14:01:16.152444	hydration	91.56789797644832	%
135682f8-9833-4bed-909d-af3846ff7de8	0f232083-b1ad-4ad9-947d-c538aea6867e	2024-07-18 16:01:16.15589	cortisol	8.602766840246803	nmol/L
04d1ae3a-dfb1-494c-a323-d69292bb94ed	ba3e567f-8ca3-4b81-a67d-1e20ef3f63e5	2025-01-04 00:01:16.159307	body_composition	29.834262922972094	%
3afedfaf-781e-4796-bba5-c18fb785c89f	ba3e567f-8ca3-4b81-a67d-1e20ef3f63e5	2025-03-08 14:01:16.162203	gps	-75.08562062759118	degrees
018b81d9-9683-4658-8e75-61fde16efc9e	7b3a72a9-d34a-4dcc-923f-2b57dc786586	2025-05-02 05:01:16.165505	temperature	36.17599677629422	°C
ffeba40a-efbd-4177-8d1d-70546355437a	7b3a72a9-d34a-4dcc-923f-2b57dc786586	2024-11-24 20:01:16.168655	stress	7.952936794239984	level
75fe220f-a102-421d-8e06-e98a809dc3df	7b3a72a9-d34a-4dcc-923f-2b57dc786586	2024-11-11 04:01:16.171777	blood_pressure	139.4991445994841	mmHg
abb14f56-db6d-4811-aac8-4130b47db60a	7cf7ef2a-765f-4b32-ab6e-1ebcb1c5ba02	2024-07-01 09:01:16.177062	body_composition	12.307417496091539	%
90cc098e-aacf-4690-be63-619a39a549ee	7cf7ef2a-765f-4b32-ab6e-1ebcb1c5ba02	2024-10-30 07:01:16.179944	gps	44.05572695723794	degrees
0cdcf373-b90f-4a81-bfec-cc61f09af410	1e68ee0b-e56a-4445-a265-5408b2387bb1	2024-08-12 16:01:16.183316	body_composition	23.48134831539724	%
35b349b7-b4c0-4944-a76c-e89f03d15d98	1e68ee0b-e56a-4445-a265-5408b2387bb1	2024-09-10 22:01:16.186177	body_composition	22.767887328364147	%
b8fa910a-aed5-444a-a455-201ef0b42df8	6f240cd4-22a8-447f-9fb9-d776f8784360	2025-05-23 20:01:16.189447	ecg	2.604079542744812	mV
6b5d7f73-ffb0-4181-a0d6-064e137613f2	2c37e21f-3d18-4746-b472-b22dddbcdafd	2025-03-31 01:01:16.192807	gps	70.22343190059618	degrees
1dee2c83-5c24-4b97-936e-a7ca541cfad6	2c37e21f-3d18-4746-b472-b22dddbcdafd	2024-08-12 18:01:16.195723	heart_rate	85.96811553317686	bpm
7bae4ab3-8f33-41ad-8e29-0a6c0b2cc350	2c37e21f-3d18-4746-b472-b22dddbcdafd	2025-05-26 00:01:16.19906	body_composition	33.07203971051631	%
c1fae926-9f95-471c-ad62-305e49d11274	2c37e21f-3d18-4746-b472-b22dddbcdafd	2024-10-20 17:01:16.201988	glucose	81.02668113289405	mg/dL
a24f84e6-235c-479f-8267-9258f0f2ee75	2c37e21f-3d18-4746-b472-b22dddbcdafd	2025-02-24 05:01:16.204808	hydration	71.91371162340252	%
1a2fc402-96f2-449e-90ce-162230f73105	1962e882-d0a2-4041-bfe6-9ec401ebc09f	2024-07-28 05:01:16.208095	hydration	83.0868875166185	%
6509cacc-b843-463b-8ab0-40dd804206b1	1962e882-d0a2-4041-bfe6-9ec401ebc09f	2025-03-20 12:01:16.210946	temperature	37.425880130088274	°C
5de2f4bf-0eb0-4ad0-b9d0-d8de4cf0e2fb	1962e882-d0a2-4041-bfe6-9ec401ebc09f	2025-02-19 12:01:16.213915	body_composition	10.789182316946155	%
47dbf535-ad5d-4de4-a973-18cd5f76d0f3	adca76ff-ddd2-4351-835d-d1faa10b798d	2025-05-24 04:01:16.216897	heart_rate	61.79174551545602	bpm
32c7787e-cf5e-4151-a7a7-1854abc7179e	adca76ff-ddd2-4351-835d-d1faa10b798d	2024-10-09 03:01:16.21991	gps	6.017391792909379	degrees
0b8b68ac-44c6-4f28-97f2-2ce0a5e6739d	adca76ff-ddd2-4351-835d-d1faa10b798d	2024-12-04 15:01:16.22288	glucose	86.54891355716785	mg/dL
062a64d7-af45-498d-a532-461226853964	44a86f60-d301-4667-a70a-b5393a11e1b9	2024-08-26 01:01:16.226167	oxygen	98.61770289346575	%
1eaeaaff-f656-4129-8b9f-45af774bcad6	44a86f60-d301-4667-a70a-b5393a11e1b9	2024-07-31 22:01:16.229262	blood_pressure	132.64605108341203	mmHg
32dc6c91-2219-467f-968c-7799c46fce47	44a86f60-d301-4667-a70a-b5393a11e1b9	2024-07-25 23:01:16.232207	heart_rate	81.49584915728872	bpm
62e73334-2644-445d-9654-9b5e4a844adb	44a86f60-d301-4667-a70a-b5393a11e1b9	2024-06-07 00:01:16.235139	cortisol	7.079175955700565	nmol/L
2f517bc6-00b5-4939-b238-9d47d22ce55a	b5c72332-1530-4340-ba5e-4034482cd01d	2025-03-27 04:01:16.238226	body_composition	27.881958745368692	%
a5204e3a-827a-4a62-a6d6-b2b54ee8bae3	b5c72332-1530-4340-ba5e-4034482cd01d	2024-12-02 18:01:16.241106	glucose	70.3948162065309	mg/dL
130f5e34-e9b6-42f9-ba08-16ea587a2a96	b5c72332-1530-4340-ba5e-4034482cd01d	2025-02-16 04:01:16.244133	ecg	1.6622963259676258	mV
6014d660-1154-4c2b-9f95-d2d3a1b889bd	b5c72332-1530-4340-ba5e-4034482cd01d	2025-01-17 04:01:16.247426	stress	0.12017721425932759	level
955bfa1b-6ef0-4539-9ef9-83fbeb4032fb	e9dacc6d-7da8-48c0-8a4c-8197191b7e99	2024-07-26 17:01:16.250603	gps	-82.90664344208155	degrees
2cb1561a-f3f0-4439-9a1f-11e31c62abc6	e9dacc6d-7da8-48c0-8a4c-8197191b7e99	2024-06-22 19:01:16.253428	stress	6.004859882217886	level
11fbca1f-b820-4fcb-a3f6-24484719df7a	e9dacc6d-7da8-48c0-8a4c-8197191b7e99	2024-12-23 21:01:16.2563	temperature	37.08029501001259	°C
31e47b65-2463-4d74-a276-2d3eab25bcfa	e9dacc6d-7da8-48c0-8a4c-8197191b7e99	2025-05-25 14:01:16.259089	cortisol	13.000084692233186	nmol/L
d8912149-d1c6-49cc-8d41-4f7e5a19912a	e9dacc6d-7da8-48c0-8a4c-8197191b7e99	2025-01-22 08:01:16.261972	temperature	37.30361642928484	°C
0c44a5bc-fc85-4eaa-84ef-4ad3f130ba2d	13e96689-3136-4621-a215-43c7100ef5fb	2024-09-22 15:01:16.265187	gps	40.78062868309257	degrees
f61f4059-3baf-43d4-9a93-eaddc6a8e89b	13e96689-3136-4621-a215-43c7100ef5fb	2025-05-06 18:01:16.268179	heart_rate	66.95339147310918	bpm
d498a511-d26e-4f50-ab9d-19b16ccd2f50	13e96689-3136-4621-a215-43c7100ef5fb	2024-10-16 00:01:16.274014	hydration	67.80630165763309	%
3d0f5884-805e-44ef-ac98-d31424a3463f	13e96689-3136-4621-a215-43c7100ef5fb	2025-01-01 18:01:16.276976	oxygen	98.96580584354335	%
d404c769-20a1-443d-b5f9-8534a140e67a	13e96689-3136-4621-a215-43c7100ef5fb	2025-02-17 16:01:16.280175	ecg	0.535900531193372	mV
b1ead8f5-cee6-4cc6-9b7e-e037ac2a83ca	6f2a0485-64b2-4898-a624-5cb00404654c	2024-12-19 19:01:16.2833	temperature	36.23094048568343	°C
aca1c4d7-e551-4c8f-8856-c72c9415554f	6f2a0485-64b2-4898-a624-5cb00404654c	2024-06-21 16:01:16.286298	temperature	36.34640774820882	°C
fdeec644-b9bb-48c0-ab62-813b085de93d	6f2a0485-64b2-4898-a624-5cb00404654c	2024-06-30 18:01:16.289197	oxygen	97.77998670752594	%
3f978c4f-8144-4ad3-b281-4b951b5bbe57	6f2a0485-64b2-4898-a624-5cb00404654c	2024-11-24 13:01:16.292178	body_composition	10.207515862719493	%
3aa98cc5-e747-42df-b484-a0e7de725291	6f2a0485-64b2-4898-a624-5cb00404654c	2024-06-08 11:01:16.295179	body_composition	24.998381467353497	%
05c32251-78f2-4b2b-8322-90f498147b55	ca5e89f4-66fd-4807-9b9f-2c03d527209f	2025-05-15 13:01:16.298765	heart_rate	83.09359705684213	bpm
0a6e4374-fbcc-4b04-8506-a3d8e2976c56	ca5e89f4-66fd-4807-9b9f-2c03d527209f	2025-05-24 00:01:16.301885	body_composition	21.274517765000603	%
cbcf3ce3-31e2-400f-8819-807ec90877f2	ca5e89f4-66fd-4807-9b9f-2c03d527209f	2025-05-22 11:01:16.304911	gps	17.79687351504876	degrees
f80196cd-2545-4c65-b221-c25654a64030	2efaeb7e-df77-4e74-bca6-dc5d722e5160	2025-02-19 12:01:16.308257	heart_rate	88.01787426763941	bpm
ee16c16a-3737-4be6-9790-df19a9e93a4e	2efaeb7e-df77-4e74-bca6-dc5d722e5160	2024-11-02 16:01:16.311359	ecg	-0.09182324828783706	mV
6e350683-716c-4da4-b4f4-40e77e53106a	2efaeb7e-df77-4e74-bca6-dc5d722e5160	2025-04-28 14:01:16.314524	blood_pressure	102.18907469353076	mmHg
98e2baca-667f-4a29-a9d0-a8c15f8a9a65	09cf52e3-48ad-489e-a11e-ca7494bc1b06	2025-01-13 06:01:16.318046	glucose	128.27838981539293	mg/dL
ce9596d8-0a9f-4270-911b-86f31b0c2b71	09cf52e3-48ad-489e-a11e-ca7494bc1b06	2025-03-10 14:01:16.321206	body_composition	30.059769150744696	%
9fc48ec3-decd-4f6f-8a90-79428a76c216	09cf52e3-48ad-489e-a11e-ca7494bc1b06	2025-04-26 14:01:16.324373	hydration	96.46920477091419	%
eab6715f-1af7-45b1-aa03-74f11f71984d	de01bce0-04b8-4c74-8400-0938da538a4a	2025-01-05 11:01:16.32763	hydration	93.97514432616893	%
b466c0cd-b625-4213-a516-cc30d528d790	de01bce0-04b8-4c74-8400-0938da538a4a	2024-06-04 15:01:16.330706	temperature	36.80130639777606	°C
bcedb842-3012-4454-ba60-5f639d018d69	de01bce0-04b8-4c74-8400-0938da538a4a	2025-05-18 08:01:16.333736	glucose	135.43373661510287	mg/dL
73944fc0-3e78-41eb-a1d3-4e451438fd50	f35efe1a-fab1-49b0-b902-70f904dd39f0	2025-05-05 14:01:16.337161	blood_pressure	130.8310601334926	mmHg
246ffd28-cee5-4856-99f3-16baf0fbad6f	f35efe1a-fab1-49b0-b902-70f904dd39f0	2025-02-17 22:01:16.340173	oxygen	98.66340455273394	%
60238614-a4b5-4b8c-b508-fe05eccc083f	3fcda711-f90f-4c0f-b51b-31ce587bdb0a	2024-10-12 12:01:16.343605	heart_rate	92.88324318789118	bpm
ac3e188c-69d7-496d-87b3-f7435905909e	3fcda711-f90f-4c0f-b51b-31ce587bdb0a	2024-08-11 02:01:16.346713	ecg	3.0631112120108477	mV
1d4c437e-bbd8-4d3e-ac3a-bdee3fb24f7c	3fcda711-f90f-4c0f-b51b-31ce587bdb0a	2024-09-06 07:01:16.350134	temperature	36.70922428536036	°C
f49ae48c-84cd-4e6b-97b1-e5f7ddcc6e42	3fcda711-f90f-4c0f-b51b-31ce587bdb0a	2025-04-01 21:01:16.353128	ecg	-0.009334987193292343	mV
2b96d33e-eda0-4756-a01a-d3eb6b4358e8	f7cce252-7221-411e-95f6-6f6a35ff914e	2024-12-12 01:01:16.356552	gps	-35.96209425987119	degrees
97d055bb-bf75-4c4a-93a2-1b94818b2487	f7cce252-7221-411e-95f6-6f6a35ff914e	2025-02-03 19:01:16.359538	body_composition	23.03004735481531	%
639278b8-d9c6-4e6d-870d-f4e80bef539e	f7cce252-7221-411e-95f6-6f6a35ff914e	2025-05-23 06:01:16.362617	stress	5.825625761874184	level
eb3acca8-5019-4b2a-981d-05ff58531739	f7cce252-7221-411e-95f6-6f6a35ff914e	2024-08-08 16:01:16.365674	temperature	36.64443963955157	°C
7cc5358e-8fa3-4ae1-91b1-b141ebfe7d48	f7cce252-7221-411e-95f6-6f6a35ff914e	2024-09-28 09:01:16.368761	hydration	69.11231893728649	%
4acf0bd3-7288-499b-9f75-6d9f79a3a7aa	3f2e898c-4fa3-4245-bf6d-9ad30db31289	2025-04-06 10:01:16.372001	heart_rate	72.734736769822	bpm
77d7ebe0-7286-4ece-b676-201fa9bc886d	169c9280-5569-4974-a011-5f8bdc87f1d1	2025-03-15 22:01:16.375456	body_composition	12.161983552385484	%
14c772d1-db3b-46b6-b794-864b20ca8d2b	8b6ace99-6013-4032-bec6-7f97025d832b	2025-01-12 21:01:16.378575	body_composition	14.004368820855992	%
69f4aedf-bbf0-4329-8317-0ebfd317d6b4	8b6ace99-6013-4032-bec6-7f97025d832b	2024-12-12 23:01:16.382228	cortisol	8.70745615044451	nmol/L
3806e877-0a32-4d83-8392-a046c2cf59ef	8b6ace99-6013-4032-bec6-7f97025d832b	2024-08-30 07:01:16.385526	glucose	121.5404859859687	mg/dL
7216c113-b87d-450c-957a-fd6a1078c4f0	8b6ace99-6013-4032-bec6-7f97025d832b	2024-06-29 02:01:16.388713	temperature	37.433865194756955	°C
3aab438b-1e71-4c5c-8bdb-69b7a521b889	8b6ace99-6013-4032-bec6-7f97025d832b	2025-04-20 15:01:16.391946	cortisol	24.580790832972056	nmol/L
b792d3cc-9a48-4ba5-b9d3-c5975c89e90a	9f567659-827a-4aa7-a2f8-cd2ced79cb0e	2024-07-23 12:01:16.395281	heart_rate	78.52013515761378	bpm
a0d33c01-3082-46ff-9287-449e78d0f782	7eaacb40-938f-4881-97f4-e624e03fca54	2025-04-07 06:01:16.398436	temperature	36.990869043329205	°C
3cd2fa8e-34f1-4a7e-b9d7-747911bbf37c	7eaacb40-938f-4881-97f4-e624e03fca54	2025-03-04 06:01:16.401554	temperature	36.685678105513354	°C
559a828e-d50c-482d-b249-509f87e72740	7eaacb40-938f-4881-97f4-e624e03fca54	2025-03-06 20:01:16.404531	cortisol	14.141630745024232	nmol/L
04f092aa-bf83-4eae-9896-850fe7e704e1	7eaacb40-938f-4881-97f4-e624e03fca54	2025-03-24 08:01:16.407584	blood_pressure	91.34999930034137	mmHg
4c5f0b53-9a4c-429c-ba54-a8634293ec55	7eaacb40-938f-4881-97f4-e624e03fca54	2025-03-05 09:01:16.410595	stress	8.623787049107449	level
7f2f1061-0fd0-4733-a33f-aeb4cadefe71	ae188695-c60e-43b2-b7ee-42744d1ed6b7	2025-04-23 01:01:16.414046	cortisol	6.698134935120637	nmol/L
04e5752b-1a3b-4712-b148-9f1eace6fbbe	ae188695-c60e-43b2-b7ee-42744d1ed6b7	2024-09-11 01:01:16.417052	hydration	63.44189276216939	%
ccdcf487-2b96-4c33-aeeb-23d324afb06e	ae188695-c60e-43b2-b7ee-42744d1ed6b7	2024-10-08 14:01:16.420327	ecg	4.636675902676139	mV
c2218ae1-602a-4660-af44-cc56a1f05c6a	ae188695-c60e-43b2-b7ee-42744d1ed6b7	2024-10-13 10:01:16.423264	stress	5.991096772212319	level
9211446b-6189-42af-9d0e-65be806a5de0	5afa3390-6a5a-454f-9b36-d4a76859b2b5	2024-09-13 08:01:16.426412	heart_rate	62.89523371332708	bpm
70582f4b-3b11-4945-955b-d3b84ab6e0cb	34f8477f-3c20-4f01-9156-50151279cf48	2024-07-01 19:01:16.429438	heart_rate	65.870756038433	bpm
0bb513ba-a447-4d26-8619-d580612059bf	9c6d3a02-01fd-4b12-b3ff-3915e5ef3a68	2024-09-06 03:01:16.434514	hydration	59.03792390882364	%
514027f9-4352-408e-81ad-82658d798fad	9c6d3a02-01fd-4b12-b3ff-3915e5ef3a68	2024-12-29 01:01:16.437494	blood_pressure	92.72637208808236	mmHg
834d2f99-fdca-4436-9d0b-34d74097e536	9c6d3a02-01fd-4b12-b3ff-3915e5ef3a68	2025-03-13 01:01:16.440612	heart_rate	73.4853663154235	bpm
d3cd2dd4-621f-4b48-a2c8-590b8fd0cd2e	9c6d3a02-01fd-4b12-b3ff-3915e5ef3a68	2024-07-02 12:01:16.443612	oxygen	96.57857781957134	%
97ed2046-503f-4945-954b-16ee73ba4405	9c6d3a02-01fd-4b12-b3ff-3915e5ef3a68	2024-07-13 08:01:16.446926	blood_pressure	139.8011863693018	mmHg
006a344a-6394-42c7-b3c9-dbadc0017efa	8a8f5fec-fce0-4120-b42c-5cee05a45326	2024-06-29 14:01:16.4503	oxygen	98.52010708183857	%
b999582e-e475-4fd6-932c-e575f0c745b0	4e4b7e0d-c5aa-4d4a-8c56-782529678617	2024-09-11 13:01:16.453704	blood_pressure	99.78654321065737	mmHg
9b86d78e-0d62-4d5c-a245-dcba242c0245	4e4b7e0d-c5aa-4d4a-8c56-782529678617	2024-08-15 18:01:16.45671	glucose	102.22743771671426	mg/dL
73d5d7d0-5e8d-4fde-8cb1-a86131aacd59	4e4b7e0d-c5aa-4d4a-8c56-782529678617	2024-12-30 20:01:16.459864	blood_pressure	132.58973832128842	mmHg
83324632-6372-49e6-ae66-eabce5d8ca42	cc637b4d-0f47-4a11-beff-a7012792d8ea	2024-08-20 22:01:16.463014	glucose	109.24472432953782	mg/dL
2e216a18-d9ec-4d8e-bdad-78b206962cfd	cc637b4d-0f47-4a11-beff-a7012792d8ea	2025-01-26 15:01:16.466033	heart_rate	63.26683921415552	bpm
bb4e753e-b230-4668-bf58-a64bcb1ba6e5	cc637b4d-0f47-4a11-beff-a7012792d8ea	2024-07-11 12:01:16.468918	gps	-85.3663886838484	degrees
59b818cb-8b89-499f-9cda-25b27f3fbd81	cc637b4d-0f47-4a11-beff-a7012792d8ea	2025-04-17 08:01:16.472468	cortisol	20.62416512936665	nmol/L
f46f5056-1c4a-44c5-889c-f4615e46268d	cc637b4d-0f47-4a11-beff-a7012792d8ea	2025-02-08 08:01:16.475432	hydration	94.81130004003785	%
66c4d96a-3af1-41ca-91e5-c315904dc583	a52d9a33-47e8-4f5a-b664-7dcec758c527	2024-07-09 05:01:16.478575	blood_pressure	97.55011733538448	mmHg
d433e743-6861-4065-b375-bf5e98cae633	a52d9a33-47e8-4f5a-b664-7dcec758c527	2025-01-04 07:01:16.481514	temperature	37.447013984402616	°C
42dc16a9-f041-4a4c-bbf0-6e93d76ae87f	a52d9a33-47e8-4f5a-b664-7dcec758c527	2025-03-06 07:01:16.484487	cortisol	5.346923989352061	nmol/L
27ef5345-457b-4616-aa5a-5e78f1a6540a	a52d9a33-47e8-4f5a-b664-7dcec758c527	2024-09-27 08:01:16.48741	body_composition	35.2716842876893	%
a30b0e94-8a85-4de1-8c78-4e8020c5ca08	ec3c98fa-073e-4622-a5a1-6db25eae22f6	2024-12-18 16:01:16.490483	cortisol	24.612253222563997	nmol/L
9fbf48d0-2d8e-4020-b0b1-8e43ab4e2551	ec3c98fa-073e-4622-a5a1-6db25eae22f6	2025-04-19 07:01:16.493444	body_composition	19.551674925694925	%
66686485-bb7c-40cd-b07f-579c01cced6f	ec3c98fa-073e-4622-a5a1-6db25eae22f6	2025-04-11 18:01:16.496347	hydration	62.19218961916526	%
5719f00e-6c8c-44c4-8560-415262707ad3	45bb1a40-a139-4ffe-9c9d-36b8e911797b	2025-01-08 17:01:16.499605	blood_pressure	96.03439876199316	mmHg
fb7ec95d-b61e-4843-be88-69bb9c4ab151	45bb1a40-a139-4ffe-9c9d-36b8e911797b	2024-07-26 04:01:16.502592	oxygen	95.255731439249	%
0f6eb3d1-7c95-405a-9cf8-43d9e90e0c3a	66b21dd5-fef5-4c12-928c-6bd313840514	2025-01-23 12:01:16.505729	heart_rate	80.08794873667848	bpm
1dbc97df-68d7-4548-99a6-bd008483980a	66b21dd5-fef5-4c12-928c-6bd313840514	2025-04-24 17:01:16.508573	glucose	70.50371797300154	mg/dL
62029fb8-6da2-415d-9e7c-5756595c5e9e	66b21dd5-fef5-4c12-928c-6bd313840514	2025-01-13 12:01:16.511478	cortisol	13.2540319593444	nmol/L
1c8d39af-faa7-4978-8291-7edf0078c166	66b21dd5-fef5-4c12-928c-6bd313840514	2024-06-12 08:01:16.514806	body_composition	20.090480313868028	%
ba9585b7-c754-43ae-b69e-3d0b423b2ef3	03756e4f-59c7-4ec4-8401-bd4738c0cc83	2025-03-15 23:01:16.517978	gps	-73.09983335104506	degrees
b3803b05-cfb6-48c7-82c9-4f9aa8b79ada	03756e4f-59c7-4ec4-8401-bd4738c0cc83	2024-12-04 12:01:16.520979	stress	9.989024932888197	level
62bdf268-c2fd-4a08-90d6-c63dedc1ec17	03756e4f-59c7-4ec4-8401-bd4738c0cc83	2025-02-04 04:01:16.524007	blood_pressure	113.74118407382724	mmHg
f4ef0831-4133-4f13-8a70-6cfc71a141ec	03756e4f-59c7-4ec4-8401-bd4738c0cc83	2024-12-31 13:01:16.526922	oxygen	96.58579763572261	%
f18775d3-ff5e-41be-925f-c58c5f105cc9	939006bb-7421-46ce-ab59-fca2416d20d9	2024-06-25 11:01:16.529891	cortisol	10.95143485921784	nmol/L
3fd62032-f6ad-44dc-ba37-84ab63947179	939006bb-7421-46ce-ab59-fca2416d20d9	2024-10-04 14:01:16.532648	body_composition	34.692799416089954	%
c18d6a5f-39ff-468f-a82b-2af22224a9c7	939006bb-7421-46ce-ab59-fca2416d20d9	2025-04-24 04:01:16.5355	body_composition	22.494498243845783	%
ecb51249-432d-4822-9481-c7963c367183	939006bb-7421-46ce-ab59-fca2416d20d9	2025-01-08 16:01:16.538322	ecg	-0.13261689738754462	mV
c0ca86f8-3cbb-489a-9539-ff8d8381e21d	939006bb-7421-46ce-ab59-fca2416d20d9	2024-06-20 15:01:16.541173	hydration	57.66783921503191	%
22808c3c-7647-407f-b228-666d3536ed6d	e5c1f7d5-4b24-47dd-bd34-4a6f11ccd40f	2024-06-06 02:01:16.544825	cortisol	20.874403712264904	nmol/L
1a1d92ec-6418-46df-a5de-2cdf849a9360	e5c1f7d5-4b24-47dd-bd34-4a6f11ccd40f	2024-11-05 13:01:16.547791	glucose	98.0559081339654	mg/dL
30f61d29-cb39-4fd0-952a-27a852037ad6	b7acf28c-a6a2-4060-aea0-2a2301c33060	2024-09-01 16:01:16.550732	body_composition	36.226522644802884	%
c08b6dea-b6da-4d1b-b543-4b7046f53357	4407a9ee-cdc0-48fe-a4a0-8ca8c5d53963	2024-09-24 11:01:16.553648	glucose	80.26521554912364	mg/dL
b41a7c39-d30e-400e-92b3-038f8a5b28f3	1ebdc494-5182-4704-bd00-50e2c710786e	2024-09-19 15:01:16.556779	gps	82.80343450136681	degrees
4125e4fa-3f5d-4b19-a114-5ebcb3b7e1ab	1ebdc494-5182-4704-bd00-50e2c710786e	2024-07-31 04:01:16.559522	gps	45.87320775308501	degrees
a1400719-52e7-4233-a9ce-d396a293daea	1ebdc494-5182-4704-bd00-50e2c710786e	2024-10-01 01:01:16.562517	heart_rate	68.57888630253578	bpm
8d54d624-6f65-4246-b5f2-90bc3c71d277	1ebdc494-5182-4704-bd00-50e2c710786e	2024-12-03 19:01:16.565409	glucose	111.30098505038409	mg/dL
6fb2ddea-ca5a-4484-8227-d229b7f55a89	1ebdc494-5182-4704-bd00-50e2c710786e	2024-12-14 20:01:16.568454	cortisol	15.28294736261371	nmol/L
eb254120-3941-4ece-a09b-899020cc6454	1c631413-d327-4eef-bc3d-68d7f12526de	2025-01-23 09:01:16.571592	temperature	36.35487817931442	°C
279bf4df-31d0-4000-be04-62fa248fdc36	1c631413-d327-4eef-bc3d-68d7f12526de	2025-03-14 07:01:16.574585	hydration	78.64220106055764	%
b6db9ed7-d7e5-4085-b028-7df7da8e9ba5	1c631413-d327-4eef-bc3d-68d7f12526de	2024-08-10 23:01:16.577404	glucose	97.31498733510699	mg/dL
0e71c2fb-fdfb-4fb4-ba85-46ce07ecc571	57c952e0-9786-4a70-87fa-9a7f114e870f	2025-05-28 15:01:16.580605	temperature	37.27579234653456	°C
2646ecfd-d1e0-4d5b-b9cb-c1eed839cf7a	57c952e0-9786-4a70-87fa-9a7f114e870f	2024-08-06 09:01:16.583619	glucose	110.7864652813533	mg/dL
4d4ce77d-af06-4790-b26b-3ece43b8a955	57c952e0-9786-4a70-87fa-9a7f114e870f	2025-05-09 02:01:16.586531	temperature	37.041991682056974	°C
3aab6d0a-c2a9-4c36-ade2-0d0d1b9613e2	57c952e0-9786-4a70-87fa-9a7f114e870f	2025-03-03 03:01:16.589502	oxygen	98.51390521410895	%
392a1805-8de1-4fd2-8bda-ab4c790ed03a	083d92a2-9abe-482c-9a3b-6bffa23c65b4	2024-08-02 19:01:16.592623	gps	53.66253809253021	degrees
e0d60576-e235-4e03-ad6c-8da439188514	083d92a2-9abe-482c-9a3b-6bffa23c65b4	2024-07-01 16:01:16.595558	temperature	36.041505762689674	°C
4fc6dd08-90ee-4eb7-9e87-fd471dc8aadb	083d92a2-9abe-482c-9a3b-6bffa23c65b4	2025-02-25 01:01:16.598856	blood_pressure	102.77395965716347	mmHg
22f255e1-ef0f-4c29-96ef-83cb6321db34	083d92a2-9abe-482c-9a3b-6bffa23c65b4	2024-07-31 20:01:16.601994	blood_pressure	132.37295312812356	mmHg
4f4b9a49-4d7d-4d14-a32d-af8c23bd37e7	3419505b-5139-41b0-9d40-084f63c700d0	2025-03-11 01:01:16.605054	ecg	3.2693055167001006	mV
0f336185-25fd-4f0c-8a50-d43d17ddcaa3	3419505b-5139-41b0-9d40-084f63c700d0	2024-09-29 15:01:16.607883	ecg	0.9853100350412927	mV
0adae99f-6aa0-4074-be44-ba802f97fe90	3419505b-5139-41b0-9d40-084f63c700d0	2024-12-26 21:01:16.610691	temperature	36.25958964772273	°C
35f23781-3028-4577-9f47-a61eaa86b9df	3419505b-5139-41b0-9d40-084f63c700d0	2024-12-31 07:01:16.613718	cortisol	7.53352187801611	nmol/L
87de662b-a1f2-47d2-9463-715e490c29cb	3419505b-5139-41b0-9d40-084f63c700d0	2025-02-08 02:01:16.616709	blood_pressure	114.93399419244291	mmHg
2de9676e-065f-4c2e-8726-473c7855f4df	e3540b6a-7466-4a58-b87f-9bc72915e657	2024-12-19 14:01:16.61988	hydration	72.41928962795231	%
c6933a71-c3ec-4abc-b7c2-063253bcaf04	e3540b6a-7466-4a58-b87f-9bc72915e657	2024-10-30 08:01:16.6227	stress	5.4225683383766015	level
d56015e5-decc-4756-9f35-cadc8221c9e6	e3540b6a-7466-4a58-b87f-9bc72915e657	2024-11-06 11:01:16.625725	ecg	4.018127847279313	mV
da312b9b-45ac-4b03-97d9-76f680b78275	e3540b6a-7466-4a58-b87f-9bc72915e657	2025-04-23 13:01:16.628688	cortisol	10.580688854818867	nmol/L
8b9e3e2d-6316-4569-9d7a-6b0728a81624	f6712c7f-da7f-4b6c-bc07-c85e68e9deb6	2024-09-02 21:01:16.631756	oxygen	99.92476428501679	%
546939b2-cc3c-4719-958b-ddb5323749be	f6712c7f-da7f-4b6c-bc07-c85e68e9deb6	2025-02-18 11:01:16.634606	cortisol	23.60088006549049	nmol/L
32b94f88-cd3a-4719-b035-665b3236791d	f6712c7f-da7f-4b6c-bc07-c85e68e9deb6	2025-05-06 16:01:16.637774	hydration	83.08709744388857	%
c43d7979-a53e-4ea8-9980-ae0b4e70d859	f6712c7f-da7f-4b6c-bc07-c85e68e9deb6	2025-02-20 19:01:16.640779	cortisol	14.723042976632788	nmol/L
190c90c9-5a99-499c-ad11-bc293632402b	eac8a2fe-4b54-4e0c-8c26-b156dd9ff3e0	2024-06-25 20:01:16.644221	heart_rate	79.91158193826212	bpm
ad64624f-d6e1-4746-87e8-47f6f7830495	eac8a2fe-4b54-4e0c-8c26-b156dd9ff3e0	2024-08-14 19:01:16.647128	temperature	36.030239302204755	°C
592209ea-598e-4b86-aaaa-d7bbfa7f0281	eac8a2fe-4b54-4e0c-8c26-b156dd9ff3e0	2024-09-03 09:01:16.650152	cortisol	16.879640953361	nmol/L
0a51a7a2-de09-4c95-8e17-594c906bb60d	eac8a2fe-4b54-4e0c-8c26-b156dd9ff3e0	2025-02-19 20:01:16.653382	heart_rate	96.5769508192268	bpm
6d9f1e9e-5d24-4ff2-a709-b435e36738dc	1df012fc-e2b7-4abd-afc6-2786de486598	2025-05-20 10:01:16.65668	glucose	81.50110844246616	mg/dL
c6b20b72-5f47-4565-a3d3-4e28469f6396	1df012fc-e2b7-4abd-afc6-2786de486598	2025-03-10 23:01:16.659589	stress	1.827751151804945	level
6a5a9a9d-e9e6-4070-90bd-2dac57eac5af	1df012fc-e2b7-4abd-afc6-2786de486598	2025-01-16 18:01:16.66249	temperature	36.523814656744946	°C
bd6f4c3f-4b6c-4bfb-a97d-2b2119138b55	044e57a1-10fd-45d8-a30e-237853bd4a7c	2025-02-08 00:01:16.666084	heart_rate	74.36063777452144	bpm
2d0d0899-f4dc-4106-95b8-e4ae4a3a1a06	a1257866-b425-439c-b717-af799f34ae19	2024-11-27 08:01:16.6691	hydration	76.35365381848334	%
3f2d3e1f-d4f1-4a38-9253-604c1e2e7652	a1257866-b425-439c-b717-af799f34ae19	2025-01-03 07:01:16.671813	oxygen	98.71216432420107	%
766e28e1-4e93-42ad-8e1a-e0643c0b5d22	a1257866-b425-439c-b717-af799f34ae19	2024-09-09 02:01:16.674773	temperature	37.44625328436431	°C
23f0312b-dd02-48ce-8a82-223b8052222d	cb5c1e59-f128-447b-ae8f-5ae374b1961d	2025-03-16 14:01:16.678152	temperature	37.10049023788223	°C
19c2ed74-9c7b-46ec-ab1b-1e87d66fb731	cb5c1e59-f128-447b-ae8f-5ae374b1961d	2024-07-16 19:01:16.681321	blood_pressure	98.18642166424073	mmHg
138c5850-3f7e-4dda-bab8-31c700830a8e	7b1ea02c-5746-4153-ba53-3471219a885a	2025-03-16 20:01:16.684699	glucose	93.61615660324247	mg/dL
e1533ef6-b7f5-43b8-8947-1770dbf8b1b3	7b1ea02c-5746-4153-ba53-3471219a885a	2024-11-16 06:01:16.687631	blood_pressure	98.97016047728034	mmHg
cb2146ac-ed7d-4eb1-8454-777c41d33c59	171c334b-d9b1-4326-b12a-592b9bcf80fd	2024-07-16 21:01:16.690653	body_composition	10.103971945673239	%
451d9807-8dd1-4faa-a23f-f062387fce4c	171c334b-d9b1-4326-b12a-592b9bcf80fd	2025-04-16 13:01:16.693816	gps	62.273599167669374	degrees
0afd9460-3c51-471d-9bf0-4c7cb019038b	171c334b-d9b1-4326-b12a-592b9bcf80fd	2025-03-30 12:01:16.696704	oxygen	99.13026100080155	%
ed4a54ec-cac7-4c3e-887d-a92ca58297e7	171c334b-d9b1-4326-b12a-592b9bcf80fd	2025-02-27 06:01:16.699799	oxygen	96.25801887354734	%
38cc5f8e-5cfa-4759-9757-1b795e77bd5a	171c334b-d9b1-4326-b12a-592b9bcf80fd	2024-09-30 11:01:16.702589	oxygen	98.726581588456	%
d15f65c0-c691-40b0-80e1-638b35ba7e75	cf75182c-079f-408c-87e0-249f14e8116e	2025-03-19 08:01:16.705807	oxygen	97.99749242132907	%
37ec527d-6f1d-499c-b560-172c3e5e5b82	cf75182c-079f-408c-87e0-249f14e8116e	2024-10-14 01:01:16.708608	stress	9.308946523498282	level
d53455b6-3afa-452d-824c-bbbe18ca4ee8	cf75182c-079f-408c-87e0-249f14e8116e	2024-06-05 22:01:16.711757	oxygen	97.7271572827511	%
f0ab3e51-4b32-4034-8928-269037b5d464	cf75182c-079f-408c-87e0-249f14e8116e	2025-03-10 20:01:16.715025	glucose	122.8979353494681	mg/dL
4d0233ff-5c34-45f5-aa0d-4db4b5ad59cd	3621b7ce-8dd3-42ba-ad51-dbb4a259a63f	2024-12-16 21:01:16.718516	ecg	0.3340446408523394	mV
ac586177-de25-426e-a4f3-745ad065d48f	3621b7ce-8dd3-42ba-ad51-dbb4a259a63f	2025-04-07 06:01:16.721519	oxygen	96.725518095448	%
6e253860-bdb4-4d63-aeec-ca4320c5eb97	3621b7ce-8dd3-42ba-ad51-dbb4a259a63f	2025-05-13 18:01:16.724491	ecg	-0.4536903071871272	mV
7bc6f275-28a2-40fb-9d1c-9746350a9d7b	3621b7ce-8dd3-42ba-ad51-dbb4a259a63f	2024-08-22 14:01:16.727343	cortisol	21.27893182738973	nmol/L
1f0db4cd-1a25-4430-b7ce-6bf4d0af759c	3621b7ce-8dd3-42ba-ad51-dbb4a259a63f	2025-01-01 09:01:16.730223	blood_pressure	130.22633579668198	mmHg
cfb8e97f-42b9-4abe-95b6-50308aa07bd3	4222430d-6a96-49c0-9a3b-50dd770ecec0	2024-09-01 20:01:16.733186	glucose	95.15632080233055	mg/dL
16f95f6b-a3f2-4481-ad7e-0461ec800c69	4222430d-6a96-49c0-9a3b-50dd770ecec0	2024-06-22 04:01:16.736055	oxygen	98.78244577056722	%
d3fd4086-5ffb-4631-bb91-674aceb9d73c	4222430d-6a96-49c0-9a3b-50dd770ecec0	2024-08-30 22:01:16.738812	gps	-41.830510374984094	degrees
37037e6f-f6a6-423a-a1d1-4ee863147a0c	4222430d-6a96-49c0-9a3b-50dd770ecec0	2024-09-29 08:01:16.741909	gps	8.970036443946213	degrees
93905074-7c3d-4e07-b488-540556f5f34d	4222430d-6a96-49c0-9a3b-50dd770ecec0	2025-05-22 22:01:16.745126	blood_pressure	106.03358641251425	mmHg
7c75926f-e67b-44ce-8d02-c1d7898d4b2e	9da8e801-3873-47ce-9d17-7de8e0011ca7	2024-12-10 23:01:16.748669	stress	6.431788793583615	level
f8cd3bf5-5c20-4611-af21-d0cbec2ff278	9da8e801-3873-47ce-9d17-7de8e0011ca7	2024-09-19 04:01:16.751884	hydration	85.48772042956409	%
7e3fb4a5-c06f-437c-a5a7-2a48d4952d46	9da8e801-3873-47ce-9d17-7de8e0011ca7	2025-04-16 16:01:16.755028	body_composition	25.015736950891238	%
a3a6f5b6-c590-42e4-b651-df39e2208e93	9da8e801-3873-47ce-9d17-7de8e0011ca7	2024-12-14 14:01:16.758046	body_composition	20.56546406325485	%
b2492fb6-546a-4208-b258-cde9a329b912	9f5c864f-4703-4fb8-95f9-d7cf0ecf9f44	2024-10-25 08:01:16.761403	heart_rate	82.86296278895016	bpm
03b7855a-e280-48c2-83ef-909304e57e08	e5ed1d22-461a-4dcf-ba60-59a1296e70f6	2025-04-12 18:01:16.764613	temperature	36.69130193502241	°C
dd39e9b5-a8a5-4c80-b885-4b2e63d276c8	e5ed1d22-461a-4dcf-ba60-59a1296e70f6	2025-03-19 12:01:16.767919	heart_rate	86.88756210623546	bpm
1abbab40-f996-41ad-a79f-dda5ce1f2c19	e5ed1d22-461a-4dcf-ba60-59a1296e70f6	2024-09-17 18:01:16.773138	temperature	37.29443670760044	°C
1f54cd52-77fc-4699-b13d-ed3753607181	e5ed1d22-461a-4dcf-ba60-59a1296e70f6	2025-04-21 16:01:16.776251	ecg	0.36034580210161227	mV
3b88e134-9fb7-4370-8f10-4ff6490c9bb8	e5ed1d22-461a-4dcf-ba60-59a1296e70f6	2025-05-10 04:01:16.779315	glucose	133.91685397612167	mg/dL
83ecd217-52b5-468d-8fa9-d969b1db17ff	3d852811-66b3-48fb-8222-1eca78c8478a	2024-08-23 17:01:16.782524	hydration	96.37759639047547	%
3efdfd52-eb20-4fd4-9bb2-7f81202882dd	3d852811-66b3-48fb-8222-1eca78c8478a	2025-04-10 11:01:16.785477	stress	2.4815849635307528	level
8396f69c-6718-4f5b-8834-ed487ef2656b	123c8533-7bc4-41a9-bf75-6c9bdf52152d	2025-03-07 22:01:16.788577	body_composition	34.6874735298498	%
c8ed5af3-9b0e-4575-b644-d3d547d225f5	de3f5fff-2189-4f60-ba17-3f9c8e93dca7	2025-03-29 13:01:16.791862	hydration	78.20663789084054	%
2e6fa635-78b8-4f6d-ad95-b9ffcd076fbd	de3f5fff-2189-4f60-ba17-3f9c8e93dca7	2025-05-10 13:01:16.795001	temperature	36.79126077220085	°C
742f618a-3afd-4f67-812a-23a4ea3bba52	de3f5fff-2189-4f60-ba17-3f9c8e93dca7	2025-05-07 07:01:16.798138	cortisol	8.39546668508482	nmol/L
af238ed1-e8c0-4bd3-8e68-85747fdccd05	de3f5fff-2189-4f60-ba17-3f9c8e93dca7	2025-06-02 21:01:16.8011	temperature	36.96832243458048	°C
ee84e775-34c5-4349-a081-912dc0ee8e84	de3f5fff-2189-4f60-ba17-3f9c8e93dca7	2025-02-27 13:01:16.804231	heart_rate	61.434517698069556	bpm
1a174ba0-aa1e-4f21-996b-f17b20a5f7ce	26ddb0b7-2196-4c06-bbee-0f9e5e3574a0	2025-01-20 16:01:16.807578	ecg	-0.44812719541855983	mV
cf60f79d-33dd-4cb2-aedc-0d98deaaa320	26ddb0b7-2196-4c06-bbee-0f9e5e3574a0	2024-11-01 19:01:16.810727	glucose	81.56272328890662	mg/dL
f4571738-a937-4379-a54b-74c74764b338	26ddb0b7-2196-4c06-bbee-0f9e5e3574a0	2025-06-02 07:01:16.814036	glucose	99.34326773972774	mg/dL
1545158c-ee9b-4560-a597-06597924b1b4	26ddb0b7-2196-4c06-bbee-0f9e5e3574a0	2025-04-24 04:01:16.817219	glucose	100.44567112604604	mg/dL
85131cfc-3ddf-486a-9af7-d10bc5b13ae1	1e182e5b-0097-4eeb-a725-3366b18b3385	2025-05-24 15:01:16.820431	blood_pressure	114.53703925859634	mmHg
7c56e525-1c42-4522-941d-5f883c66499c	1e182e5b-0097-4eeb-a725-3366b18b3385	2024-10-29 02:01:16.823409	cortisol	20.017734955183336	nmol/L
282576d6-d6ec-4553-bbb2-79db4e8038be	1e182e5b-0097-4eeb-a725-3366b18b3385	2024-08-19 09:01:16.826634	blood_pressure	117.67774522817828	mmHg
17e7521d-d753-4bfd-b085-092133aada62	2e5d045d-a377-45e7-bba0-66e2b517c548	2024-12-21 05:01:16.829782	temperature	37.053986264771645	°C
8e53104b-0cae-489b-9872-fa1879b4d331	2e5d045d-a377-45e7-bba0-66e2b517c548	2025-04-15 06:01:16.83275	oxygen	96.21475584898295	%
ecb61c5d-829b-4c0b-b4ea-32ff537f8c61	2e5d045d-a377-45e7-bba0-66e2b517c548	2024-09-14 08:01:16.835838	glucose	80.63139214345514	mg/dL
32cb555f-45d0-477a-8efb-d5eca824bbde	2e5d045d-a377-45e7-bba0-66e2b517c548	2025-05-03 11:01:16.838758	ecg	3.047591421034385	mV
66a05592-b171-4b32-a5c3-3c750ca66a15	2e5d045d-a377-45e7-bba0-66e2b517c548	2025-04-02 14:01:16.841762	oxygen	98.02840877467452	%
e74d7d4a-84b1-45cd-bc12-8802d0dce0bc	4c97be54-d097-45be-96af-0ee807333c7e	2025-01-01 20:01:16.845107	heart_rate	69.78244472377563	bpm
b8bde63c-b48b-48d6-8e2a-5764dc8c24f6	ed01c5bc-3d8c-48f2-8f41-650c51da94ce	2024-09-04 16:01:16.848548	stress	4.493051028493317	level
6e66ad8a-4b07-4f67-b565-3377b09d1fd1	ed01c5bc-3d8c-48f2-8f41-650c51da94ce	2025-04-30 04:01:16.851505	heart_rate	94.95853529813131	bpm
1ab6b0dd-cd01-45e7-818c-ef1d5245bcc7	ed01c5bc-3d8c-48f2-8f41-650c51da94ce	2024-06-22 22:01:16.85454	body_composition	11.119044335942473	%
b5de3854-1904-4500-bb33-4676798fe3f5	ed01c5bc-3d8c-48f2-8f41-650c51da94ce	2024-09-08 03:01:16.857559	oxygen	95.03183321912603	%
a3a77f90-cdea-4793-8dcc-64bfe0380af4	642175cd-2e9e-46af-ac33-bb394ce53036	2025-05-26 18:01:16.860715	gps	-48.54647237233788	degrees
1dc2de14-5abe-45ca-b6a1-cddbf3c82a3b	642175cd-2e9e-46af-ac33-bb394ce53036	2024-06-18 21:01:16.863698	ecg	1.9526349283007791	mV
98d93d4f-aea6-4c2d-bd21-df2454c30838	642175cd-2e9e-46af-ac33-bb394ce53036	2024-09-14 10:01:16.866657	heart_rate	75.4214179453847	bpm
f7e82872-d5ed-45f8-a0fe-63a99b8cc0ca	e5dcdf0e-3eab-4799-994a-8ad7dec6d2de	2024-07-16 13:01:16.869989	oxygen	95.87511238315504	%
7f974956-0d15-428c-8086-127dca365c1e	e5dcdf0e-3eab-4799-994a-8ad7dec6d2de	2024-08-21 10:01:16.873028	oxygen	97.02414318355878	%
1c7a890b-a237-43bc-9b07-14b94ecabda8	e5dcdf0e-3eab-4799-994a-8ad7dec6d2de	2025-03-31 19:01:16.876875	ecg	3.904270872207606	mV
20728cdd-ee8a-4a36-b8e8-c04fd890a491	e5dcdf0e-3eab-4799-994a-8ad7dec6d2de	2024-06-12 00:01:16.881067	cortisol	11.237562201314619	nmol/L
29783e1a-319c-4f37-988f-38bac5640c6a	d4e9d8d9-ace5-4341-a828-27bf75db341d	2025-04-22 01:01:16.886029	oxygen	96.18040998307904	%
e3d42e65-a623-4713-92ce-b146b9acbcb2	d4e9d8d9-ace5-4341-a828-27bf75db341d	2024-08-12 19:01:16.889022	gps	2.0716066277398397	degrees
89c1647b-ec51-41f8-a770-f17ee4cd964f	d4e9d8d9-ace5-4341-a828-27bf75db341d	2024-10-17 23:01:16.892061	blood_pressure	118.1617210731792	mmHg
e4b0c05e-2288-4120-aa75-a92b7a1abe1a	d4e9d8d9-ace5-4341-a828-27bf75db341d	2025-01-31 23:01:16.895114	heart_rate	67.06004427153289	bpm
9553bd2d-325a-43d5-a7a4-1608818cf7a8	166fe1d5-0689-4447-b943-6a7b338a03e5	2024-10-18 11:01:16.89839	heart_rate	97.71096549276558	bpm
8096f642-74ce-4bf3-a1f2-787a85802d93	166fe1d5-0689-4447-b943-6a7b338a03e5	2025-06-01 19:01:16.901386	glucose	90.78011979486504	mg/dL
01941feb-4e9f-4545-8adc-4294bf627c4f	166fe1d5-0689-4447-b943-6a7b338a03e5	2024-12-18 20:01:16.904363	cortisol	7.594706070567989	nmol/L
17d764e4-5f7b-4caa-83a1-af902da4a8e4	2c92d018-6661-401c-8df0-302a972f851d	2024-06-12 14:01:16.907552	hydration	65.17165733816694	%
98c9ffc2-8839-4074-8f7a-99c988010e11	2c92d018-6661-401c-8df0-302a972f851d	2025-01-23 05:01:16.910479	stress	1.7273639019911793	level
9532407c-9c29-4c21-8510-ad20293dda69	d6985471-d6f4-4a78-a690-b3e592802ae4	2024-12-14 19:01:16.913748	body_composition	32.91589592639578	%
28c1750f-8a41-433d-8261-bed222420528	2b2df1a6-937d-4dd4-b34e-fa7f7a310f71	2025-02-20 22:01:16.917136	stress	0.3216978430118328	level
c9413519-a3cd-47ca-b02f-d2afa10bf79a	2b2df1a6-937d-4dd4-b34e-fa7f7a310f71	2025-05-26 02:01:16.920292	ecg	1.341483388789828	mV
858e5fec-4003-46f3-9759-28d034b2ac7a	f2a218cd-51a1-4034-b41a-a22f85a58ac5	2025-04-20 13:01:16.923551	hydration	91.10129807017671	%
35d80401-ffa3-42e5-8cc9-b846c14e87a6	f2a218cd-51a1-4034-b41a-a22f85a58ac5	2025-04-09 07:01:16.926543	glucose	112.60242252152796	mg/dL
1c000bb8-930e-4734-bb7f-dc50674440a7	f2a218cd-51a1-4034-b41a-a22f85a58ac5	2024-08-28 06:01:16.929776	cortisol	9.399747915371968	nmol/L
12012313-aa9d-491d-8d5a-2df87ee24d8c	f2a218cd-51a1-4034-b41a-a22f85a58ac5	2024-11-03 18:01:16.932891	temperature	37.36847794794412	°C
f0754c0e-4a4f-4eb1-8ec7-59818e0f0fea	96bf6f7f-55ec-47e0-835b-ce2066ba6efe	2025-04-09 17:01:16.935975	heart_rate	63.49585603213197	bpm
0c96b0f8-7723-4afa-88e1-0a3cd57cd151	96bf6f7f-55ec-47e0-835b-ce2066ba6efe	2024-07-23 02:01:16.938823	oxygen	96.59726991210276	%
c24977a1-894d-4fe6-a424-8242e7afa93c	6f93c18b-6b2e-4fc4-b7d1-7cb40247bcfd	2024-12-02 00:01:16.942	glucose	139.6520157281775	mg/dL
954d28af-98ce-4043-84eb-eeb0cb200501	6f93c18b-6b2e-4fc4-b7d1-7cb40247bcfd	2024-10-18 21:01:16.945021	hydration	88.31366078625427	%
209a0f65-e1a7-4fb8-b511-6bd7bfb3ada6	6f93c18b-6b2e-4fc4-b7d1-7cb40247bcfd	2024-09-05 00:01:16.947901	cortisol	22.040052717517916	nmol/L
7adb0ffd-24c1-4985-96a4-dea5684fe798	6f93c18b-6b2e-4fc4-b7d1-7cb40247bcfd	2024-07-08 08:01:16.950997	cortisol	20.957032757076952	nmol/L
71879772-e2a8-47ac-bf04-da3178b0e191	8fe4f0d5-1417-4bef-af0e-d3e2a6e68b3b	2024-11-16 13:01:16.953989	body_composition	29.158395352705227	%
07490642-11db-4c24-a1a7-2aecc5188555	8fe4f0d5-1417-4bef-af0e-d3e2a6e68b3b	2024-09-06 04:01:16.957002	hydration	57.23867653950734	%
c4269f95-c1e3-4e18-9304-9aa6fca4221f	8fe4f0d5-1417-4bef-af0e-d3e2a6e68b3b	2024-12-15 06:01:16.959923	gps	-73.46103022412314	degrees
31926ec7-d3ce-4537-8a0a-53ea54eb856e	8fe4f0d5-1417-4bef-af0e-d3e2a6e68b3b	2024-06-15 04:01:16.962873	oxygen	99.77601223293414	%
84e0057c-2de4-4878-aa8e-df455819ef38	8fe4f0d5-1417-4bef-af0e-d3e2a6e68b3b	2025-03-17 11:01:16.965714	oxygen	96.95256305001493	%
e28a87c7-8ed0-48b3-9e5a-3cd0de0e895f	d6994738-1944-4bb4-91f2-2884df0f9123	2025-03-04 07:01:16.968723	temperature	36.98347126568845	°C
0d709870-2733-4b19-93c4-4edaaa7a2f19	d30e337c-957d-4487-919f-2a00b64c9454	2025-04-03 02:01:16.971736	oxygen	97.03284745558229	%
4543daca-2d5f-493c-bd0a-fc7cba616bb3	d30e337c-957d-4487-919f-2a00b64c9454	2024-06-30 18:01:16.974642	temperature	36.21670122623063	°C
02404de3-229c-4f56-bb78-8ee79160dbe0	d30e337c-957d-4487-919f-2a00b64c9454	2024-10-24 19:01:16.97748	hydration	73.79900668084656	%
8b0b5f42-bbea-43fe-a109-d6d37f0ed741	d30e337c-957d-4487-919f-2a00b64c9454	2025-01-16 19:01:16.980399	hydration	96.97081884239836	%
2fd5d282-d72d-452e-8a61-a8a27eeaae7a	d30e337c-957d-4487-919f-2a00b64c9454	2024-11-14 09:01:16.983283	body_composition	26.14205865661535	%
a2447593-bf34-41ed-866d-72f9639f346e	6969b70c-0c70-4097-813a-b1f1bd07bbd8	2025-02-07 15:01:16.986646	cortisol	10.912943833005272	nmol/L
a30c4280-ea00-4aa5-b304-476985f9ce99	6969b70c-0c70-4097-813a-b1f1bd07bbd8	2024-08-09 07:01:16.989614	heart_rate	84.55622913058687	bpm
89a7ba5f-a8e5-4d2d-8901-a1890eb5b70d	6969b70c-0c70-4097-813a-b1f1bd07bbd8	2024-06-10 19:01:16.99251	cortisol	17.10318401723689	nmol/L
636a03eb-7ff7-42b9-8d2a-96cba253b001	a0eea107-6fa4-4b73-9aa5-d8b190eb6644	2024-10-25 16:01:16.995597	oxygen	96.76427506033542	%
53a8b14d-55b9-465c-b1f3-60b369db4f03	a0eea107-6fa4-4b73-9aa5-d8b190eb6644	2025-05-31 17:01:16.998694	hydration	67.85409874574654	%
6ccd4bd0-5be9-4d45-af79-bd7c19f56132	25fb7e7f-25ec-48ee-ac78-2f7b39750b31	2024-11-24 21:01:17.001646	ecg	4.576579508706402	mV
7f4f96c6-f202-4e92-a25e-b1281ccf8777	25fb7e7f-25ec-48ee-ac78-2f7b39750b31	2025-02-19 07:01:17.004694	blood_pressure	110.11639824920499	mmHg
84727b51-b5bc-4afb-b8c5-931984e8c0bd	25fb7e7f-25ec-48ee-ac78-2f7b39750b31	2025-05-03 16:01:17.007481	gps	89.03558379912405	degrees
c28d3d58-5d64-4c24-87f4-f6cf1f148c7a	51fb6837-93cb-4f44-80c9-3c00b7fed389	2025-02-20 17:01:17.010722	cortisol	6.318093242258742	nmol/L
\.


--
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.devices (device_id, athlete_id, name, type, model, serial_number, last_sync) FROM stdin;
389b29b0-16a0-49ff-8d14-b17fdc6e8485	ad059698-d6de-42a7-af6d-6e3cd5a80846	watch 665	sensor	dLEmjUT	3c07:e6c8:c72b:486f:2528:2bb8:70f2:79bd	2025-02-13 13:01:15.213233
4189ca29-ca62-4333-b899-6a95a4a92b9d	ad059698-d6de-42a7-af6d-6e3cd5a80846	other 299	sensor	TWYqbky	d35b:6de5:c0d5:5af7:afe8:6faf:e1b0:76ab	2025-01-20 08:01:15.218041
176844c9-d910-494a-8122-81450e2f3cdb	98e78db7-fe89-45ea-a6f6-670350546c61	watch 296	tracker	OTouAaN	6851:8a73:7fc:b2ce:ceaf:3add:9d4f:74d	2024-06-24 10:01:15.221687
adee6114-5e9d-423c-9047-9bff41ff6211	98e78db7-fe89-45ea-a6f6-670350546c61	watch 195	sensor	uQvMFAs	f878:81ef:ae89:ead9:e689:25a9:df58:6f3b	2024-10-06 17:01:15.224814
42cfa65e-0b3e-448d-a4c4-efbad0d77519	6f28b3fa-7e7b-4c66-823e-a1efd7993886	other 9	other	PqOlWUY	9a71:a7a4:512e:ee24:b7b5:326f:87ec:ea6	2025-01-21 02:01:15.228378
d8f1c438-e761-421c-95c9-c9ea04fc07d7	6f28b3fa-7e7b-4c66-823e-a1efd7993886	other 141	sensor	OqWZLKv	2c66:f154:c2c:8b5d:e875:d051:34:4328	2024-10-13 01:01:15.232135
2f0c8cbc-9e7f-4304-92f7-27579f85d052	6f28b3fa-7e7b-4c66-823e-a1efd7993886	other 98	other	UOoosBW	45fa:bfdb:c39:d375:dc02:c25d:531e:db90	2024-06-27 11:01:15.235631
956cf925-c1f5-4105-8778-be0905c1d9af	953cd6cf-72c3-4ffa-98c2-eb96e96c35bf	other 814	other	nBIOGBj	cef9:9acc:6dd6:1331:909b:f4d8:6631:51e6	2024-08-12 10:01:15.239028
0376d67c-7d53-40ad-9c69-cebdb7266ed8	953cd6cf-72c3-4ffa-98c2-eb96e96c35bf	sensor 956	sensor	EyCrspN	58c2:3aae:ecb9:cb1e:6e33:bfa0:3602:3287	2024-10-10 23:01:15.242345
3a187f8a-5012-4856-a58e-15c64c7e838a	953cd6cf-72c3-4ffa-98c2-eb96e96c35bf	sensor 158	watch	qiNhIIU	faac:95a7:1afe:59b8:52a6:b96b:edf4:6ca9	2024-11-01 21:01:15.245577
4e9fb085-f448-4a10-8882-3cc7fa1a8e0d	fc39f40d-e36c-4167-9de3-fe95b8ee2936	watch 662	watch	WyIDILh	6eec:9b57:2782:e3c9:5c25:a723:374a:d0b7	2025-04-28 03:01:15.248884
6a6b9304-b019-4053-85f9-4596d005d2c8	fc39f40d-e36c-4167-9de3-fe95b8ee2936	sensor 531	other	DdjEqxq	dece:a201:6c0:6f3a:e05b:61ee:f1c8:997a	2025-02-19 12:01:15.252206
7de1e112-34e3-4f40-90c2-c5df2b4cc902	d622497b-0202-412e-b0b3-19d125499c0a	watch 55	sensor	POMRFiX	e2e7:4c20:44b0:d1a5:ed82:e30d:36f6:198	2025-04-19 20:01:15.255528
396a47c1-25a2-4fe1-8709-9451f407ec5f	d622497b-0202-412e-b0b3-19d125499c0a	sensor 433	other	CZuPoNi	4761:88d4:2621:b003:e14:242f:910f:e3c3	2025-02-09 21:01:15.258873
a6b08480-331c-4cf4-88e1-526f91373584	d622497b-0202-412e-b0b3-19d125499c0a	tracker 823	sensor	WPMKsfM	ba37:38c6:1016:76c:34d5:845b:a073:c304	2024-06-07 04:01:15.262207
2af22c20-10b3-4c1e-85d6-b5e9e0ee1813	3a4572b7-0b21-4f81-8052-0192e1fd87f2	watch 717	tracker	KfunPwM	4c36:7b40:bb0b:f229:248b:688:20c7:c934	2024-06-10 15:01:15.265634
9fb5276a-0222-45d3-9562-ee062857d3e7	3a4572b7-0b21-4f81-8052-0192e1fd87f2	sensor 947	watch	ZrYFytD	d73f:9b1e:13cd:7b69:4c1f:4d98:c2ac:ae55	2024-06-10 05:01:15.268592
1a0fe3c6-0f9b-4d96-9912-2c9086031513	3a4572b7-0b21-4f81-8052-0192e1fd87f2	watch 961	other	yWmGQum	5cbc:f1b4:e58b:80fc:e321:2486:cc7:3da	2024-12-07 03:01:15.274014
0079839c-cff8-42ac-8208-6abad874d22f	4377f770-933d-40da-b890-094dc68a3d7e	other 862	watch	ygkEsOq	4a3f:28f6:4918:43a6:ed3d:9bb3:e259:9a73	2025-05-07 09:01:15.277019
168816fb-c589-4402-8a4a-61d86b9102e2	98be8fb8-c108-41f5-9784-500225d7df73	watch 211	tracker	ojZFuQm	1e27:b417:5fd1:450:b87:1ab1:85c6:c188	2025-05-07 16:01:15.279885
cf78f11a-36f8-49ff-bd31-f5a01aaa7317	98be8fb8-c108-41f5-9784-500225d7df73	other 637	tracker	ftQGmJc	3f85:ad9e:f8f9:c69a:9291:2d0b:deec:e96d	2025-02-14 19:01:15.282714
d15b2885-3bab-4f9f-ad27-21deaa02f2e3	98be8fb8-c108-41f5-9784-500225d7df73	other 623	other	qhrehPP	4ea8:2638:4799:bade:97a5:6cee:ad9a:632c	2025-03-11 05:01:15.285582
be9fd286-386f-4c3e-88f2-1caa6ca74f45	1de452c3-d6a0-4013-b6a9-7823d32caa1e	other 213	watch	DeuiSVf	e5c8:2d7d:9ae:96f4:6f58:270c:49ca:dc55	2024-11-17 19:01:15.289202
97708edd-ef3e-4187-8328-4ab80ed76b97	131064a7-47f4-4242-80c1-44661e6f0df8	tracker 267	tracker	ByDJOHa	31aa:eac1:7716:794:b4b4:34b:3845:e06e	2025-03-27 08:01:15.292316
52aa1682-69a2-4e79-980c-7f9e7814cc0d	131064a7-47f4-4242-80c1-44661e6f0df8	other 283	tracker	XTIlFKU	4ffc:ca26:a614:e31b:2554:e35d:a84c:3547	2024-07-01 08:01:15.295181
db6d1b08-ec42-4c65-ac29-704fa7adcdf5	131064a7-47f4-4242-80c1-44661e6f0df8	sensor 280	other	MCIdZvy	75d4:2d98:e67c:1e31:cc6:ad79:9932:af23	2024-12-28 18:01:15.298294
125d4520-4651-4f1d-8a16-b0f79bf3dbe9	48f8b0c8-3b66-4f02-bed0-47427f33c1e0	watch 695	other	lmmWQQI	44a9:83cc:2b34:f740:7343:7438:c80a:7d1	2024-10-11 16:01:15.301448
f7f974bb-e756-4d55-960b-68fc576637a3	4f7f13fe-f7f4-47f8-adcd-624ed032c498	tracker 874	tracker	qvkjgNq	d0af:39e4:9c27:ce77:66a1:6e5d:3c21:74d4	2025-02-18 23:01:15.304643
c3a60975-9de4-4bc1-ae09-98dfea06eee5	4f7f13fe-f7f4-47f8-adcd-624ed032c498	tracker 85	watch	tnFpDTv	7b7c:4d7:5cd8:7441:6b8e:a301:c6ca:4649	2024-10-28 00:01:15.308082
07501359-f5c1-433b-86d6-68e1d47e41a9	32620980-8215-4340-a976-50ce6cb74e20	watch 55	tracker	cjWXutw	e5ad:8c00:6ca7:82e1:ef97:fb85:1cde:b0d9	2024-08-05 12:01:15.311403
9f67e627-2bf7-4bcb-9918-9db49024911a	32620980-8215-4340-a976-50ce6cb74e20	sensor 806	tracker	UBPBAAt	104f:a5b0:514a:8180:e167:8f2c:c4ec:da00	2025-04-17 16:01:15.31462
38f572ee-8ec2-436e-b7bb-b60eb2c00c5b	ba8f8660-ae06-42c2-8131-e19ebd96dabd	tracker 957	sensor	pjSOiFp	a9fd:a0bc:80d2:ec7d:f570:e8e8:8a14:3a0b	2024-08-29 23:01:15.317592
7f91c023-9078-49e9-ac76-178c7233073a	ba8f8660-ae06-42c2-8131-e19ebd96dabd	watch 597	watch	vnuSMPd	709a:8f70:e76c:24d7:c492:610c:39ce:68b4	2025-02-05 09:01:15.321083
636cb392-e05c-4b4d-b6d3-c6937a2bedb0	ad6c6a84-da64-4ca0-a0d1-c56b692b66e2	watch 784	sensor	jEVySMo	20dc:e370:5cf:5747:e44d:ad9f:d96f:e4c	2024-09-08 02:01:15.324416
de02eac5-614f-4ce8-bd07-b15783354782	dd151103-5216-4652-b088-8b801f33f90e	sensor 618	other	ejEIBnN	cd76:1cd1:824f:6ab4:9974:b327:678f:af60	2024-11-24 12:01:15.327924
789c0e2e-bd89-4520-967e-dae845788bb5	dd151103-5216-4652-b088-8b801f33f90e	tracker 854	tracker	vJXcljC	5cce:e46a:dddc:30ca:9370:b103:4a82:cfb6	2024-06-26 16:01:15.33209
60afc68b-6ccd-4340-ab80-206ce88a0dab	0320789b-2cc9-4e68-a63f-fcb3b6bbd1f3	watch 61	tracker	VlTfaPL	efb3:11d6:347e:d1d5:6fa6:e90c:6a2f:fdff	2025-05-22 05:01:15.337302
5693988c-0f00-4d45-9688-c6767fd1584d	0320789b-2cc9-4e68-a63f-fcb3b6bbd1f3	watch 794	watch	xtsRpNM	7f98:63bf:c079:4985:7a06:15c1:ded4:16df	2024-07-25 21:01:15.340894
503080ce-bec7-41c5-9374-a3136718d93f	0320789b-2cc9-4e68-a63f-fcb3b6bbd1f3	sensor 414	watch	IZIcZnO	8669:f7d0:684:87dc:fed7:8045:24fb:f498	2024-10-10 07:01:15.344491
7bf3b767-2f92-475d-8377-031f8912a9b3	e8ed0b59-2464-46d1-a3ea-760a861c2cfa	tracker 702	tracker	kqhmOfD	a8ee:fb14:3598:a33a:14bf:e94:9f85:5773	2025-05-18 11:01:15.34787
6f6c48a3-4da7-4a45-ab9a-5febde7393b4	e8ed0b59-2464-46d1-a3ea-760a861c2cfa	sensor 278	tracker	fGLJdZE	48fd:4589:f6fe:3720:cdd8:37e7:e73e:ede2	2024-09-30 07:01:15.35135
8eed4b93-c4e1-4446-bf89-8ebd345063dd	e8ed0b59-2464-46d1-a3ea-760a861c2cfa	sensor 55	sensor	InEyioP	808:e695:702a:e526:e54b:6f5e:4ffc:4ab3	2025-02-19 22:01:15.356817
981c8652-5766-4d23-9893-182fccd59b4a	79f33da8-d2c1-47e5-8b55-a6817791e851	sensor 456	other	SrOvOqb	547a:174b:172f:dfd7:5a5d:ad35:b878:fef2	2024-07-17 06:01:15.360913
d04074fb-51c9-4896-979d-aa681fdfff4d	79f33da8-d2c1-47e5-8b55-a6817791e851	sensor 298	other	ZlfUKFg	1534:63b7:6613:36bb:d9b7:6730:8468:7db2	2025-06-01 17:01:15.368214
8f9425fd-b1a8-4d8f-af68-9fa12a994aac	9d292bb9-aaac-4fbd-9500-9404f6052c3b	tracker 649	sensor	nrJksmY	ba2d:72b6:dc44:cd1d:4890:fad0:d7d4:a852	2025-04-29 18:01:15.373208
84f67b42-431b-40b7-b352-bf676399c860	9d292bb9-aaac-4fbd-9500-9404f6052c3b	sensor 260	watch	yEtvKFM	1b9d:1274:a158:d39:4996:6b6e:1598:1de1	2024-10-23 11:01:15.376775
84862eba-834b-43df-8fcd-c1837cc23958	26bbe248-334f-4642-91b1-4074c81a76b8	other 880	tracker	JuHxNkt	66e0:7d62:84e7:2857:75f7:9495:157e:25bc	2024-11-27 22:01:15.380049
ef159426-522b-4f45-b58f-8f8db6514bee	5ed4532b-b825-4095-8e54-2cd72b9b3cd3	sensor 316	sensor	UREJduf	4cf6:3165:a7ba:5670:886c:bcc0:6d28:ee29	2024-08-12 04:01:15.383496
8c45558b-4a92-4d90-b84d-1dc326d03bd3	5ed4532b-b825-4095-8e54-2cd72b9b3cd3	sensor 524	other	ljJFXYK	ad5:9496:402:3a17:7b40:1079:c755:2efe	2024-12-14 00:01:15.387047
b3a58eaf-147f-4c10-b1dd-b28082f77cbb	3781d7b2-ebe8-496b-b595-7c6df03dbc6b	watch 535	sensor	xKwxxCl	82f0:8afc:963c:c4d6:d9b2:bef5:2c7d:dbeb	2025-05-13 07:01:15.390208
047771f9-04a5-4436-8a4d-29db45abe461	3781d7b2-ebe8-496b-b595-7c6df03dbc6b	sensor 337	tracker	IaJpxkF	8cb3:d580:fcde:6336:e735:7e9e:cb01:c61f	2024-08-21 15:01:15.394178
31b3d2ee-1a12-473c-a4aa-1fc7cb304fbd	f01255a1-b841-4431-b871-ce578e5df7bc	other 681	watch	tTHUsSf	4509:6d7c:3742:9255:1bf4:a9b4:e87c:f586	2024-07-06 10:01:15.398004
0f232083-b1ad-4ad9-947d-c538aea6867e	f01255a1-b841-4431-b871-ce578e5df7bc	sensor 103	watch	lWIauxf	9ce:7fcd:5441:cf03:7382:e7a0:50b5:cea5	2024-12-24 13:01:15.401374
ba3e567f-8ca3-4b81-a67d-1e20ef3f63e5	bff1cbed-6310-4771-bc66-4250edc8b36d	sensor 751	sensor	PiUBjTj	216d:e333:f0e0:68a:41cf:f224:12b:8b2b	2024-11-21 01:01:15.404364
7b3a72a9-d34a-4dcc-923f-2b57dc786586	bff1cbed-6310-4771-bc66-4250edc8b36d	tracker 251	tracker	UarWrsj	5c23:787c:2fd:f770:27d9:bb82:6af:9b70	2025-06-01 09:01:15.407224
7cf7ef2a-765f-4b32-ab6e-1ebcb1c5ba02	640c5882-ca7a-4e1e-b35f-dc744816cf19	tracker 833	other	oSnrdkT	9517:937:1dcb:445e:c760:2137:52cd:6b7e	2025-01-25 14:01:15.410578
1e68ee0b-e56a-4445-a265-5408b2387bb1	640c5882-ca7a-4e1e-b35f-dc744816cf19	watch 202	watch	wjBAuVG	54e7:abd7:560:4f48:8d3e:36c5:d994:bc59	2025-04-18 17:01:15.413936
6f240cd4-22a8-447f-9fb9-d776f8784360	1c0920bd-9da6-458f-8160-f1bb63f79110	sensor 517	tracker	WqFQeqk	7ff5:824f:a3b1:3369:1be9:502:d845:6f	2025-05-14 12:01:15.417183
2c37e21f-3d18-4746-b472-b22dddbcdafd	1c0920bd-9da6-458f-8160-f1bb63f79110	sensor 752	watch	onHiNfv	59a0:cee4:e6d9:35d7:ea7a:83fe:7865:9762	2025-03-23 00:01:15.42013
1962e882-d0a2-4041-bfe6-9ec401ebc09f	ed01eece-7ca3-4431-9dc1-c3e05b075317	watch 271	sensor	vufcjyg	350c:962f:7b74:21bb:d375:f34b:e383:ced7	2025-02-16 07:01:15.423334
adca76ff-ddd2-4351-835d-d1faa10b798d	21632412-e2ea-4a43-affd-31d60c58825a	watch 663	watch	jZtMCOi	b5c3:a12e:e4dd:5f22:b992:9fdb:741f:4ddf	2024-08-12 22:01:15.426725
44a86f60-d301-4667-a70a-b5393a11e1b9	21632412-e2ea-4a43-affd-31d60c58825a	sensor 280	tracker	OQyscYm	70f9:76ff:aaa2:a855:d17a:18cc:107c:66e7	2025-03-28 13:01:15.429589
b5c72332-1530-4340-ba5e-4034482cd01d	637fc7e1-b31f-4919-8aa9-56a5d18a867f	sensor 808	watch	VpADrDx	ab35:31c3:1eb6:a296:4c46:da54:62dd:6d2c	2024-10-01 17:01:15.432637
e9dacc6d-7da8-48c0-8a4c-8197191b7e99	637fc7e1-b31f-4919-8aa9-56a5d18a867f	tracker 689	watch	eCbnwVj	6b92:bd93:d413:90c0:977a:57d1:6abe:c24e	2024-12-30 14:01:15.435503
13e96689-3136-4621-a215-43c7100ef5fb	637fc7e1-b31f-4919-8aa9-56a5d18a867f	other 500	sensor	ytFqlCE	c49f:2836:14c9:2ba9:a6ee:70d2:f681:bee9	2024-07-17 00:01:15.438381
6f2a0485-64b2-4898-a624-5cb00404654c	b2aa6266-a156-4b7b-a082-3ed6be62b785	sensor 725	other	HdjNnoM	8bc7:3c3f:4b3a:6b8f:44b0:d67:5332:6e9e	2024-07-20 02:01:15.441295
ca5e89f4-66fd-4807-9b9f-2c03d527209f	af4cef5c-fcfb-4d9e-8311-5f2afbcc4822	other 64	other	KnWxGnq	277c:74a7:69c3:2486:386b:5052:18fc:e8aa	2024-11-13 14:01:15.444224
2efaeb7e-df77-4e74-bca6-dc5d722e5160	af4cef5c-fcfb-4d9e-8311-5f2afbcc4822	watch 680	other	jEmebjA	1d79:b3b7:ed1b:8658:70e8:5cef:b296:3186	2025-04-30 05:01:15.447138
09cf52e3-48ad-489e-a11e-ca7494bc1b06	c7db9c19-8c24-4e5f-a4e6-58e7d3cf7e7b	watch 471	sensor	FknpJJD	b1ef:1907:c8ff:6d4:f5fe:3c8c:7a3:50b2	2024-12-31 23:01:15.449985
de01bce0-04b8-4c74-8400-0938da538a4a	c807894f-400a-4f5a-a8c5-16a058322b5a	tracker 231	sensor	daNJMDS	e01:da26:5579:7474:7cce:d756:5fea:be9	2025-04-20 14:01:15.452751
f35efe1a-fab1-49b0-b902-70f904dd39f0	c4b5132b-0f2f-49f8-95fe-8249386a0c4d	other 480	tracker	GRpvgyO	dff3:2a37:e09:a855:a725:9532:365f:1290	2024-11-30 16:01:15.455559
3fcda711-f90f-4c0f-b51b-31ce587bdb0a	c4b5132b-0f2f-49f8-95fe-8249386a0c4d	tracker 596	watch	BZRVWbC	cc65:42ba:c5ff:a434:a1ae:b909:63b3:44a	2024-09-18 12:01:15.458413
f7cce252-7221-411e-95f6-6f6a35ff914e	3b22f48a-507f-4125-80fe-14fb35f79813	tracker 144	sensor	ETaYBkc	ea17:e175:d4ec:8c30:8dcb:d8ef:41bc:60ed	2024-06-11 20:01:15.461584
3f2e898c-4fa3-4245-bf6d-9ad30db31289	3f3e7100-37be-4cca-bd2b-50076fbf6433	tracker 889	tracker	suptQmo	6f3d:99e8:23a8:c459:4c5e:9d3:cb1d:94f4	2024-07-01 02:01:15.464473
169c9280-5569-4974-a011-5f8bdc87f1d1	3f3e7100-37be-4cca-bd2b-50076fbf6433	other 666	other	ygIbgsT	f2d0:a3ed:e7f3:92df:8aa0:9660:640c:e08e	2024-12-06 19:01:15.467644
8b6ace99-6013-4032-bec6-7f97025d832b	5b488f6a-ec5f-4cd7-b33b-07df4f1ad686	tracker 396	tracker	lUOOsqt	1ba7:4470:8144:803b:148c:35d0:75fe:454c	2025-02-19 03:01:15.470467
9f567659-827a-4aa7-a2f8-cd2ced79cb0e	aaa8eaa2-2de4-483d-83dd-cacddd9c8ca7	sensor 8	tracker	VDNsOgo	d409:ddb7:3d87:e277:4f14:8e31:e79d:4aa	2024-06-11 22:01:15.473188
7eaacb40-938f-4881-97f4-e624e03fca54	aaa8eaa2-2de4-483d-83dd-cacddd9c8ca7	other 200	other	XmWcpyl	50f9:a84e:6348:17a7:c2ea:3cad:92c:2a10	2024-09-20 09:01:15.476046
ae188695-c60e-43b2-b7ee-42744d1ed6b7	aaa8eaa2-2de4-483d-83dd-cacddd9c8ca7	sensor 116	tracker	KtXGbyh	7a3b:54c5:9ae3:88fb:69d6:797c:f96a:a817	2025-02-22 17:01:15.479105
5afa3390-6a5a-454f-9b36-d4a76859b2b5	b03e2327-e236-416b-9a48-1f1d399b0f2f	other 558	sensor	wjENMsA	739e:bfa4:bb33:b118:e0a1:5098:aeff:112c	2024-08-02 00:01:15.48222
34f8477f-3c20-4f01-9156-50151279cf48	b03e2327-e236-416b-9a48-1f1d399b0f2f	watch 579	other	dYogOjX	1647:89a9:4e:91ca:7a65:39c2:bf3f:42d0	2025-03-19 20:01:15.485172
9c6d3a02-01fd-4b12-b3ff-3915e5ef3a68	b03e2327-e236-416b-9a48-1f1d399b0f2f	other 153	sensor	CErcIIf	c00b:433c:cf5b:8318:68bc:677a:3055:4811	2024-10-19 11:01:15.4881
8a8f5fec-fce0-4120-b42c-5cee05a45326	5c1f7521-a44d-41d7-92d2-0cc010634b51	watch 588	tracker	wLuoTeK	fb39:a74d:1861:8ea5:225d:c7ff:e438:3c14	2025-04-19 09:01:15.491162
4e4b7e0d-c5aa-4d4a-8c56-782529678617	5c1f7521-a44d-41d7-92d2-0cc010634b51	other 154	other	QrYqymR	658b:4a4b:2dcb:cd2e:86c6:4ef2:7182:44b8	2025-03-15 04:01:15.498278
cc637b4d-0f47-4a11-beff-a7012792d8ea	5c1f7521-a44d-41d7-92d2-0cc010634b51	tracker 519	watch	VZStbYM	3f34:c685:e826:ff11:f079:37aa:fccf:f5b9	2025-05-10 21:01:15.503094
a52d9a33-47e8-4f5a-b664-7dcec758c527	591b5c8c-6e59-4ee3-82f3-ac750a58f9ea	other 281	watch	pLBUulw	be68:7877:e4a6:3ffa:a021:a226:bfe5:59b0	2025-04-27 17:01:15.506063
ec3c98fa-073e-4622-a5a1-6db25eae22f6	591b5c8c-6e59-4ee3-82f3-ac750a58f9ea	tracker 205	other	Tojprlx	3e8:54ae:bf36:c28a:25a1:cf10:48b1:93f1	2024-07-27 21:01:15.508929
45bb1a40-a139-4ffe-9c9d-36b8e911797b	591b5c8c-6e59-4ee3-82f3-ac750a58f9ea	other 279	tracker	DKLhmiQ	795d:19fd:1de4:e980:d32a:915:3492:a632	2025-05-19 06:01:15.511874
66b21dd5-fef5-4c12-928c-6bd313840514	7ccc9074-d6a7-41d7-8c78-888af1a02f64	watch 687	watch	workrWN	ea4b:8558:915d:e328:fe98:dc11:786f:6db3	2024-12-31 21:01:15.514775
03756e4f-59c7-4ec4-8401-bd4738c0cc83	7ccc9074-d6a7-41d7-8c78-888af1a02f64	sensor 768	tracker	NxiIYSh	6826:be6e:fb91:4698:b3db:5ebd:a5a7:2724	2024-07-22 16:01:15.517493
939006bb-7421-46ce-ab59-fca2416d20d9	6bcfbadc-3ad5-4aa2-b0fe-7bf822a0e348	watch 281	other	ondWqGE	8844:f456:e3ba:66ed:c16b:faf5:c330:8370	2024-09-27 18:01:15.520224
e5c1f7d5-4b24-47dd-bd34-4a6f11ccd40f	4e94fb48-87cf-4ea2-afe4-dad85b86803d	sensor 430	sensor	vPBpNZV	797f:7eac:1da8:c049:c11c:d6e6:143:d17c	2024-12-24 03:01:15.52343
b7acf28c-a6a2-4060-aea0-2a2301c33060	4e94fb48-87cf-4ea2-afe4-dad85b86803d	tracker 269	tracker	AWkyyCi	2b90:95e8:b855:2e60:991c:5f7b:7b91:5761	2024-06-13 23:01:15.526755
4407a9ee-cdc0-48fe-a4a0-8ca8c5d53963	4e94fb48-87cf-4ea2-afe4-dad85b86803d	tracker 912	tracker	kVSfdTW	d762:8d44:faa8:146c:9abc:6e50:8c29:cda0	2024-11-24 21:01:15.530002
1ebdc494-5182-4704-bd00-50e2c710786e	8a6ecf81-1721-463f-a801-2a3b90146a43	sensor 36	sensor	roPtLWq	f752:c53c:703f:e065:5677:b1a9:4944:7a7a	2025-03-30 17:01:15.532928
1c631413-d327-4eef-bc3d-68d7f12526de	1341ba9e-9910-4ad7-a5dd-d929791400a0	tracker 879	other	SPTEDiv	6856:6911:83d2:827a:4a65:dc50:371f:f921	2024-11-04 14:01:15.536174
57c952e0-9786-4a70-87fa-9a7f114e870f	05d49901-ba9b-4697-8ff4-e7b40e298398	tracker 498	watch	uyyUjNR	5e2b:e823:5e0a:c295:444a:e9f9:c09f:c6d6	2024-08-24 22:01:15.539088
083d92a2-9abe-482c-9a3b-6bffa23c65b4	05d49901-ba9b-4697-8ff4-e7b40e298398	tracker 394	tracker	IUoEUcx	c17a:c546:8d6d:cb1a:3ec6:a1ab:9676:b1d1	2024-11-23 08:01:15.541935
3419505b-5139-41b0-9d40-084f63c700d0	7d9dfa62-28c8-4bb0-a163-a0cb871ef3fc	tracker 473	tracker	bBKpWFc	c6b9:e0c0:aecc:5796:607:9145:2c76:671e	2024-06-09 10:01:15.544902
e3540b6a-7466-4a58-b87f-9bc72915e657	7d9dfa62-28c8-4bb0-a163-a0cb871ef3fc	other 283	tracker	JsbEpsk	d19:39cd:7728:344a:ca1c:9077:66b2:ed0	2025-05-15 13:01:15.54786
f6712c7f-da7f-4b6c-bc07-c85e68e9deb6	7d9dfa62-28c8-4bb0-a163-a0cb871ef3fc	sensor 23	other	viuKhhS	5a84:ce02:df7c:d6c7:d3c8:6794:8d1a:a66d	2024-12-02 19:01:15.550908
eac8a2fe-4b54-4e0c-8c26-b156dd9ff3e0	810089bb-05f0-44c4-bd74-2c7ba11f204c	tracker 824	other	jIHaWnt	5c4d:d10d:2142:4964:107f:8827:abcd:881a	2024-08-11 11:01:15.553847
1df012fc-e2b7-4abd-afc6-2786de486598	810089bb-05f0-44c4-bd74-2c7ba11f204c	sensor 850	sensor	tyfdfMF	27cc:f65:bf68:bab:5884:f02e:6de2:d216	2024-12-21 02:01:15.55673
044e57a1-10fd-45d8-a30e-237853bd4a7c	810089bb-05f0-44c4-bd74-2c7ba11f204c	tracker 998	other	oqbPBHt	e45b:839c:de29:c970:95db:75e5:396f:d3b3	2025-05-17 13:01:15.559617
a1257866-b425-439c-b717-af799f34ae19	f34e0e68-b2c1-4d38-aafb-1a6be7f98db0	watch 192	other	rhsYqPn	d52c:39f:6348:1db3:9d10:a024:d7cd:b117	2024-10-14 12:01:15.562809
cb5c1e59-f128-447b-ae8f-5ae374b1961d	f34e0e68-b2c1-4d38-aafb-1a6be7f98db0	tracker 335	tracker	iyVATFS	b9eb:52b8:c989:66a4:87c:24af:7d3d:3ad9	2025-03-04 10:01:15.56571
7b1ea02c-5746-4153-ba53-3471219a885a	f34e0e68-b2c1-4d38-aafb-1a6be7f98db0	other 702	sensor	bqbicXR	2fff:e6a2:3a08:f937:b1ec:2aec:8fe9:f47a	2024-07-10 02:01:15.568951
171c334b-d9b1-4326-b12a-592b9bcf80fd	0379ca12-1fb4-4f34-972f-7808d3917ac9	sensor 102	sensor	mcDLUJe	42d5:3790:ec71:faab:4449:b203:2d1f:5c44	2025-03-11 02:01:15.571897
cf75182c-079f-408c-87e0-249f14e8116e	0379ca12-1fb4-4f34-972f-7808d3917ac9	tracker 761	sensor	rXZMbEQ	3742:7179:c871:ca8:9014:bcf3:9168:3037	2024-12-02 08:01:15.57483
3621b7ce-8dd3-42ba-ad51-dbb4a259a63f	d197f940-9bdb-48a1-be54-70e86ba92aaa	sensor 608	other	hLqdeHc	7313:14e2:666a:aadc:c5ca:d139:e677:5365	2025-02-19 23:01:15.578046
4222430d-6a96-49c0-9a3b-50dd770ecec0	d197f940-9bdb-48a1-be54-70e86ba92aaa	tracker 754	tracker	MLyfCxQ	2c3f:84a3:8866:8aad:3bdb:f437:e8d:fb53	2024-07-27 19:01:15.581248
9da8e801-3873-47ce-9d17-7de8e0011ca7	8012d9bd-f2b5-424a-b1f2-a81fa3d853da	tracker 799	watch	DlcwyDD	d6a8:dea2:884b:15e4:ad93:2a94:17b4:736e	2024-09-22 02:01:15.584532
9f5c864f-4703-4fb8-95f9-d7cf0ecf9f44	b89c07b4-0c57-4077-9535-e678989422e5	other 329	tracker	FtupYfR	1fca:8a8a:a9a4:924e:878d:6662:59f:c775	2024-08-07 11:01:15.587658
e5ed1d22-461a-4dcf-ba60-59a1296e70f6	b89c07b4-0c57-4077-9535-e678989422e5	sensor 523	tracker	KaEqDbe	d39f:4c23:f765:49d:df39:849f:3c7d:196a	2025-02-18 23:01:15.590575
3d852811-66b3-48fb-8222-1eca78c8478a	b77f011c-4c73-4659-916b-c7d91ed8667b	sensor 28	watch	UTeJJnO	124a:f9d5:5767:12c3:3329:4243:1828:4306	2025-01-30 20:01:15.594
123c8533-7bc4-41a9-bf75-6c9bdf52152d	b77f011c-4c73-4659-916b-c7d91ed8667b	other 769	sensor	OajgqNG	a7ad:1bfd:e855:fb9:cf21:c7cf:e7b8:e16	2025-02-26 14:01:15.59728
de3f5fff-2189-4f60-ba17-3f9c8e93dca7	b77f011c-4c73-4659-916b-c7d91ed8667b	other 492	watch	FEfVxle	965f:50bc:1750:f984:d5c2:39ba:d5b:e366	2025-01-15 21:01:15.600274
26ddb0b7-2196-4c06-bbee-0f9e5e3574a0	b1a706a8-448d-4a86-857c-877b3d36a909	sensor 880	watch	YYLHUqq	22df:c9e3:f9af:26a6:8e7a:6133:9169:afba	2024-10-11 10:01:15.60313
1e182e5b-0097-4eeb-a725-3366b18b3385	b1a706a8-448d-4a86-857c-877b3d36a909	other 787	sensor	wZhOTrY	8ff:1e0a:2f72:a2e6:a092:6160:5d8c:5c91	2024-12-15 01:01:15.606038
2e5d045d-a377-45e7-bba0-66e2b517c548	b1a706a8-448d-4a86-857c-877b3d36a909	sensor 441	watch	aFxJfxV	2280:9f62:163b:9993:f07e:8086:ecf3:62bc	2025-01-15 03:01:15.609014
4c97be54-d097-45be-96af-0ee807333c7e	caf1758c-d025-4d5e-aea0-8a9cf858617c	other 451	other	CsPKHUT	85fa:ff06:1e13:77f:8e2a:a3f7:e696:5db0	2025-04-12 17:01:15.612172
ed01c5bc-3d8c-48f2-8f41-650c51da94ce	caf1758c-d025-4d5e-aea0-8a9cf858617c	watch 392	tracker	NUOKLGG	73c9:75ca:23b2:a1d8:580f:691e:ae27:eed5	2024-06-26 09:01:15.614884
642175cd-2e9e-46af-ac33-bb394ce53036	caf1758c-d025-4d5e-aea0-8a9cf858617c	other 641	other	MGBxohv	b2bc:a4ad:f00f:9066:c8ae:15bc:ec30:a1c2	2024-10-06 22:01:15.617746
e5dcdf0e-3eab-4799-994a-8ad7dec6d2de	67806c4a-b344-45b6-90dc-96e256a46db8	sensor 0	tracker	SqwpBBI	6587:7038:5448:1cb3:a3d0:3e5c:2c93:21ce	2025-03-18 02:01:15.620767
d4e9d8d9-ace5-4341-a828-27bf75db341d	67806c4a-b344-45b6-90dc-96e256a46db8	tracker 473	tracker	IsAWlFh	cd80:dfd:8b3c:6dcb:5d9:5c09:43f1:a117	2024-10-18 13:01:15.623787
166fe1d5-0689-4447-b943-6a7b338a03e5	c0ddf7eb-77a3-4fda-b3fb-ecb3d3e6daf6	watch 500	sensor	cDgEIUq	37ae:c4f:d9f4:c229:7ffb:1d42:e46d:cec7	2025-05-27 04:01:15.626753
2c92d018-6661-401c-8df0-302a972f851d	c0ddf7eb-77a3-4fda-b3fb-ecb3d3e6daf6	other 20	watch	usmYPUj	aad7:a542:e973:bef6:e798:2ce5:aa33:5465	2024-08-03 17:01:15.629641
d6985471-d6f4-4a78-a690-b3e592802ae4	bd1a8138-357f-4831-9387-38412bbfe4ee	other 101	tracker	uDjrXse	5848:739d:6fd3:2a8:519f:5aa0:7c39:9ebe	2024-09-28 21:01:15.632514
2b2df1a6-937d-4dd4-b34e-fa7f7a310f71	bd1a8138-357f-4831-9387-38412bbfe4ee	sensor 628	other	QeGuWWn	29e8:7a3d:b57d:2a1c:e3b7:d8af:cc4e:7d62	2024-08-25 16:01:15.635694
f2a218cd-51a1-4034-b41a-a22f85a58ac5	bd1a8138-357f-4831-9387-38412bbfe4ee	tracker 519	other	KGWkwrV	13d:6312:fb9f:e043:f210:2c34:3bd:6e77	2024-10-07 06:01:15.638924
96bf6f7f-55ec-47e0-835b-ce2066ba6efe	de5469f5-694d-457c-b0dc-cf1ab74401e1	sensor 934	other	LrbjMXT	b603:e3d0:60e8:2b0d:d258:2ba0:a13d:9c6c	2024-09-16 08:01:15.641934
6f93c18b-6b2e-4fc4-b7d1-7cb40247bcfd	de5469f5-694d-457c-b0dc-cf1ab74401e1	watch 970	other	qfKJkdj	290d:4026:ae79:5eb4:fae5:a858:1b01:b73f	2024-09-27 09:01:15.645305
8fe4f0d5-1417-4bef-af0e-d3e2a6e68b3b	de5469f5-694d-457c-b0dc-cf1ab74401e1	watch 879	watch	bBDqPAQ	aa90:17ef:d284:a40c:4a02:b39e:13d3:353	2025-02-17 18:01:15.648552
d6994738-1944-4bb4-91f2-2884df0f9123	2de7e285-5063-4bc0-82a2-1d802627fb90	other 961	other	WVunKKR	1c95:9620:901d:f191:dcef:6188:58d8:d456	2024-12-24 16:01:15.651723
d30e337c-957d-4487-919f-2a00b64c9454	2de7e285-5063-4bc0-82a2-1d802627fb90	watch 789	sensor	FEHtwbB	9f4d:e6fa:a575:9d48:2ac:675d:ff1a:d7a	2025-03-07 20:01:15.654458
6969b70c-0c70-4097-813a-b1f1bd07bbd8	13327720-e8e2-4545-85ab-a5f1dbc0fa9a	watch 714	other	oTminni	3586:ab6d:8d19:aee7:4e7b:5d1a:b77c:f26f	2024-06-04 17:01:15.657593
a0eea107-6fa4-4b73-9aa5-d8b190eb6644	13327720-e8e2-4545-85ab-a5f1dbc0fa9a	watch 752	sensor	aAjLuMi	4e83:e53d:8360:348a:efac:dd0:2582:d364	2024-11-03 00:01:15.660737
25fb7e7f-25ec-48ee-ac78-2f7b39750b31	8df7f275-ea8f-47ac-b543-937223141467	watch 333	other	XlTtOce	63de:8caa:53fe:4916:7a40:4b58:a409:3e49	2024-12-30 02:01:15.663559
51fb6837-93cb-4f44-80c9-3c00b7fed389	8df7f275-ea8f-47ac-b543-937223141467	watch 91	watch	BQXuoYN	c77f:5a04:b492:c743:ea26:449d:5543:734e	2024-07-19 20:01:15.666936
\.


--
-- Data for Name: exercises; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exercises (exercise_id, training_plan_id, description) FROM stdin;
e0bd71e5-f331-474a-bcfb-68126c38643e	6d627e28-6088-4900-9e97-08909387cdb3	Exercise adipisci
58a3c1dd-fe50-4379-9345-7bfe983cdc1c	21ba4295-ae9a-4a08-bb50-53b4deea95ce	Exercise eligendi
e70d6df1-d259-4903-a12f-15472df30c1c	a1b1550f-ba76-45bd-91f6-a332169eb8b4	Exercise nulla
bb2fa0af-7b84-4b4a-b0e8-c5640eb77b14	81dcab73-2a51-47b5-9c1f-58e71f830793	Exercise maxime
2ea41f59-034a-4c08-bf03-1823cc556103	5642958a-a81f-4d97-a311-ed27b6bfe310	Exercise et
474699c2-8399-482c-83f9-30b7b659a3a0	caeb17bf-7281-473a-ad9b-9a278bd24438	Exercise quisquam
bad4d167-429e-44a0-b8bc-884ba0bbd56c	ff7a2937-d771-4dd2-b224-bf828300af5c	Exercise aliquid
823ae61a-d6e5-4da2-bf0f-2eba9ae51590	7a081b53-b542-4be4-b187-5819e56313f4	Exercise omnis
3e535816-0083-4c41-a7bf-4bcdb9096e0e	ce019c61-6be0-4893-acee-782bb8557d21	Exercise earum
a9d271a2-f5a9-4034-9dd5-04a56bd99ab0	19c479be-f7d2-4a92-8c83-18b790549545	Exercise a
1d875412-b2fe-425b-a870-67f9dc63b6c6	31aa8533-7066-49f8-b4c1-a2a9e344f928	Exercise minima
aef783ca-b757-48a6-a2c8-26549e454b28	7214b6e6-3039-43f1-8198-794729d4e1d2	Exercise est
1a8f3b4d-1d22-4403-99b6-a8d59a2a57db	9e8a7879-3fbc-4336-9692-49cf5f696ffc	Exercise est
d0286cdd-a0dd-4c0e-ae00-0d90d5ff5bd4	90cac6cc-6e85-4dd2-a1f5-c7098afca457	Exercise laborum
83c8215b-e0c6-4b05-ba94-0ebb6b6ec171	18d79194-ae3e-4a2d-9c3c-d669d7c68807	Exercise ab
39f98e2e-5001-40b9-b589-1990858dcbe4	03471dd9-56ff-4ad6-ada4-90d27056db8c	Exercise commodi
\.


--
-- Data for Name: favorites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.favorites (favorite_id, user_id, material_id) FROM stdin;
767102ac-b9ca-49ae-9796-cc2e650650cb	acdfffcf-d93a-4817-87f8-253fc3c4f861	b1711f6d-adc6-4573-907f-3d3f5256b7f3
58a1054e-2ed8-4467-a7b7-a0ff095ea795	acdfffcf-d93a-4817-87f8-253fc3c4f861	82516138-85d6-45dd-805d-5192c78bfdb9
a2b57844-f62a-41c1-a668-a6e98ca5b6f0	e9fc1da8-1c27-4c4f-8d2e-ec6e46550d0a	67d430c8-1e07-4fdb-8ea4-441670fc8810
41f3b356-decf-48e6-a7ab-abe0cf6706ae	ff8a03bd-05cf-4476-9d53-e72527f78b97	f2aa3e42-2953-4c38-a9c5-0f3ab55b9d04
f808274c-8dd9-4b6a-89d2-d65c42641333	9bec1b18-7ff0-48e8-9f55-ed60e2d4cbfb	c030478b-6086-47a2-9901-5ade3f5d4a9d
1c8b8456-e1ac-4310-a09c-a7be26dad9b3	9bec1b18-7ff0-48e8-9f55-ed60e2d4cbfb	c030478b-6086-47a2-9901-5ade3f5d4a9d
7b2c5760-f873-4e5f-b312-2a9fe7ae0f53	1fc48383-ac44-41aa-93b7-cc350b437e0d	0db81584-3653-4675-b2d4-fa655077b2f4
86a45900-696a-41d5-a35a-a66b9a993f04	dbc2bc60-18d7-40a5-b6b5-023999f69c7f	cbab6b93-361f-4c85-b031-cc2010928898
cfb3b613-ac37-43b2-ae42-48f8ba29e234	d105751f-5139-45ae-b658-d321dbf4e961	c030478b-6086-47a2-9901-5ade3f5d4a9d
fca32b2e-5b0d-4a1c-bfe0-16d1ceb52154	52c84561-4233-4b5e-a662-692571935818	67d430c8-1e07-4fdb-8ea4-441670fc8810
75ca520b-e395-461c-80bc-6427d5efe569	abb3ff00-aff7-4ecc-8e19-ed23d9d6eaff	67d430c8-1e07-4fdb-8ea4-441670fc8810
8e692d22-a03e-4e51-9083-a57b81e837f9	86470be7-4cf3-4483-9014-289c012be9a5	e8fe88cb-af0c-4658-9a73-f5ba3357c8f8
0773abe2-ecbd-46fd-9d4e-94401c94f274	86470be7-4cf3-4483-9014-289c012be9a5	50dde8d5-90fe-4aa8-b213-29afb2122cb7
b717c7f5-bab3-420d-bd6f-987141565725	e0c84fd2-61b3-44c3-96b2-e320099ff540	cbab6b93-361f-4c85-b031-cc2010928898
3bc653fe-f9ef-4751-8856-1650cbd0a2d0	9980b872-1ad9-414b-93c9-301e39788bd8	c030478b-6086-47a2-9901-5ade3f5d4a9d
f5068b75-34dd-4410-b0ef-7bb6ebf55b19	9980b872-1ad9-414b-93c9-301e39788bd8	c030478b-6086-47a2-9901-5ade3f5d4a9d
b3163e36-2954-48e8-b554-f0979075ded8	663eaf77-4ba3-44a1-a7ef-6414810acb3a	b1711f6d-adc6-4573-907f-3d3f5256b7f3
24221991-720d-48b0-ac29-0263044497cc	4845be0f-92e5-4e55-b00e-a21359b5ca1a	67d430c8-1e07-4fdb-8ea4-441670fc8810
d89bb176-74b3-41ef-9e65-472855f7c867	4845be0f-92e5-4e55-b00e-a21359b5ca1a	2da19c7d-d570-403d-8909-85c63df4bfd6
621d529f-aca3-4ad7-ac56-12ffd54e29ae	19eb8f4e-eb7c-4784-ae9c-d992d1e1370a	cbab6b93-361f-4c85-b031-cc2010928898
5327d08a-9d84-4032-8ae5-5f71cfc95993	d8c9f3ac-22ea-42c0-b786-87b0b78bbd21	24366f50-5a53-420b-b177-c29d7524398e
7581ad7b-91dd-4e07-ab40-0ce04065ac96	9fbf1314-b152-41e7-bd83-ab909be70c50	67d430c8-1e07-4fdb-8ea4-441670fc8810
f8a16d42-092e-4fe2-b01f-5e11c58c373c	10ac13d6-73ca-4cbf-a5d2-b85403e7faed	2da19c7d-d570-403d-8909-85c63df4bfd6
b4663197-0af0-4528-a004-83909e3c30b2	d9a3e93c-865e-4cf3-9bee-c313bbe57610	e8fe88cb-af0c-4658-9a73-f5ba3357c8f8
c99d1484-e717-40a0-aeed-29dd0403d851	d9a3e93c-865e-4cf3-9bee-c313bbe57610	c6a85978-e98e-48f4-a818-5b82214e2a55
0286177b-4ff5-43de-ae33-7e5f03d5d4cf	9a2ec07e-02cd-41b9-a9af-f22e909d0b1a	82516138-85d6-45dd-805d-5192c78bfdb9
a6a41892-0c1f-4cbb-b72d-0ee724026dce	72b17e5a-a0bb-472a-91a3-b5dbd13caaae	d6aa103d-700b-4d6c-8a2b-d333b407ce92
d79a243f-2742-4b5d-b5cf-ae3bb278a83c	a24788ba-9862-480a-84b4-0ee112eb7700	82516138-85d6-45dd-805d-5192c78bfdb9
f0ea2d54-7136-46f6-9f8c-f617ef442092	fda19059-e00a-4a2d-b68c-d1a7512f1401	0db81584-3653-4675-b2d4-fa655077b2f4
2ddf100b-294a-46cc-ac7b-7280da92a36f	f53c0e7f-7f99-4cbe-924f-4a852f225b50	f2aa3e42-2953-4c38-a9c5-0f3ab55b9d04
c18280ea-800c-4da9-a53a-d8f55b2fade8	5cf96c40-3094-4999-913a-e378e31c82e6	558c08b9-4e02-4dd9-8609-fb9ab87b07f6
a9ad011f-4b54-4f18-8fb6-aaa947d5cc1d	d22988e3-453f-4af2-bed8-6b2805dd330d	c030478b-6086-47a2-9901-5ade3f5d4a9d
4c8ea7e3-02de-43d5-9c12-4e0d1e5e3d82	642df5af-cea9-49c1-a820-f60bc0e5f451	558c08b9-4e02-4dd9-8609-fb9ab87b07f6
99b51839-eed9-441f-b4f4-0fe4dbd69551	642df5af-cea9-49c1-a820-f60bc0e5f451	f2aa3e42-2953-4c38-a9c5-0f3ab55b9d04
f32b206d-52b6-4422-9777-5ebdf586e251	c3567130-5f32-42dc-85f7-cddd10b583e9	a98faf2d-fd96-40fe-84fa-756bead91b8c
c4202982-4934-4d10-9f62-57b4da7f2e5c	c3567130-5f32-42dc-85f7-cddd10b583e9	50dde8d5-90fe-4aa8-b213-29afb2122cb7
7d0c2cb4-4c5f-46fa-92b4-d5ae703745d6	8f5ff173-7446-43ca-a127-61e51fb2f744	c030478b-6086-47a2-9901-5ade3f5d4a9d
cb287731-03ff-48ae-969e-7e919ba07687	8f5ff173-7446-43ca-a127-61e51fb2f744	e8fe88cb-af0c-4658-9a73-f5ba3357c8f8
b0d0909d-2722-4fd9-a6ea-5eb4c6fbd4a7	d8855132-907d-4eca-852f-75d40c6402e2	d6aa103d-700b-4d6c-8a2b-d333b407ce92
1b56fb99-8432-4270-be42-8a3904323dda	62f01ea8-945b-4884-aa68-6c7572c1d78c	2da19c7d-d570-403d-8909-85c63df4bfd6
284b79ee-134e-4772-a9c7-2c95ed66c37d	47b41895-741c-4b99-8d93-b7dcf413e66c	e8fe88cb-af0c-4658-9a73-f5ba3357c8f8
eac18052-e274-4a89-a380-03cb33bb8574	47b41895-741c-4b99-8d93-b7dcf413e66c	82516138-85d6-45dd-805d-5192c78bfdb9
6cdd484d-00f1-43be-b0f4-ca3fc8c226ea	8e0ecf55-df9d-4a5f-a24d-2613cc41be4b	c030478b-6086-47a2-9901-5ade3f5d4a9d
3d9ec994-1ad4-43c6-980c-dcd4e76fbbaf	7fd94df0-1a06-4540-9042-36e909db2efb	cbab6b93-361f-4c85-b031-cc2010928898
4237cec8-8f57-460e-9f1a-157926c2e58e	70ca91b6-ad56-4c89-8bc7-983a763077a7	82516138-85d6-45dd-805d-5192c78bfdb9
b5b9b3fa-ec9a-4165-96e5-b9ae2729e27a	70ca91b6-ad56-4c89-8bc7-983a763077a7	cbab6b93-361f-4c85-b031-cc2010928898
f7907dcc-2295-4262-8b9a-2dd77bf7f5c4	bf34227e-cd86-437f-95f5-d48fb096f657	67d430c8-1e07-4fdb-8ea4-441670fc8810
7be77a8d-ab03-4160-815e-3b60bda80650	bf34227e-cd86-437f-95f5-d48fb096f657	0db81584-3653-4675-b2d4-fa655077b2f4
0a13ac64-5cdc-4607-8eaf-8c81948d8645	99df127a-484d-44c7-a6e9-d7e744c54053	2da19c7d-d570-403d-8909-85c63df4bfd6
69c4e7dc-826d-45e9-b388-0c1f01e68a8e	6c8bb259-f4c1-44c8-bfb2-f33ff0700b27	a98faf2d-fd96-40fe-84fa-756bead91b8c
1c3e190f-6faa-4c4d-bda9-cc327b11f673	ab2c6c39-d8f5-4af7-b020-e6eafca298eb	2da19c7d-d570-403d-8909-85c63df4bfd6
93d8c1f5-c632-48f3-9ba5-aa0ef4bd525b	94b334d4-8b5d-4200-b863-730e3c6628a8	c6a85978-e98e-48f4-a818-5b82214e2a55
5cf5bcad-c4f4-4bbb-9845-ebfe0f722062	94b334d4-8b5d-4200-b863-730e3c6628a8	e8fe88cb-af0c-4658-9a73-f5ba3357c8f8
3fc1a9ff-7d6d-4e77-a7fe-87393e4fcfe3	bee55ca1-cc5d-4e4a-8d4a-249b86a86737	50dde8d5-90fe-4aa8-b213-29afb2122cb7
0fc115fd-8c84-404c-bbd9-a422b36e41bb	bee55ca1-cc5d-4e4a-8d4a-249b86a86737	e8fe88cb-af0c-4658-9a73-f5ba3357c8f8
d6d7023b-a768-4f53-be0b-2d940879a902	fba1c228-3a75-413e-891e-5bddcffa2007	cbab6b93-361f-4c85-b031-cc2010928898
61deedb3-6ff7-4c3b-97f4-002da330bb94	fba1c228-3a75-413e-891e-5bddcffa2007	67d430c8-1e07-4fdb-8ea4-441670fc8810
97371c48-c3ca-4384-a363-5a1d0d1f701e	aea78d3a-2b93-4cd1-9b25-c69d5aeba20b	d6aa103d-700b-4d6c-8a2b-d333b407ce92
da5fe441-9d87-4b91-8b98-de3c0fb8aaf9	ab9a61bf-60ef-4d02-a79a-e16e1eccd8d1	f2aa3e42-2953-4c38-a9c5-0f3ab55b9d04
564555fe-1369-47c5-a245-22e4572c4671	936a095a-c5ae-4f1a-91e7-58e930d38700	cbab6b93-361f-4c85-b031-cc2010928898
ad7a965f-0e4f-4fb7-9cfa-a02dcbfb18ad	936a095a-c5ae-4f1a-91e7-58e930d38700	82516138-85d6-45dd-805d-5192c78bfdb9
f32e38a7-13ba-422e-b2d2-f7873d8664ab	216e5a26-41c0-42b2-9622-c89c44f0fc27	f2aa3e42-2953-4c38-a9c5-0f3ab55b9d04
f9021e6b-7fd3-4bb8-9348-e7ff3c19cb72	216e5a26-41c0-42b2-9622-c89c44f0fc27	82516138-85d6-45dd-805d-5192c78bfdb9
4ca53661-431a-483f-b64f-502fb5d65de7	81419018-a89c-42bb-80c6-3cd70f4fb020	82516138-85d6-45dd-805d-5192c78bfdb9
6327a1b6-3fc3-4031-aec4-0fee359d9226	81419018-a89c-42bb-80c6-3cd70f4fb020	c6a85978-e98e-48f4-a818-5b82214e2a55
9f6ea844-ea3f-4f17-a519-dc235c5f403f	3164d8d8-2517-4e9b-ac73-84802e3322cc	50dde8d5-90fe-4aa8-b213-29afb2122cb7
5d655ca7-8c8f-492f-bdae-f65552b91542	648de0b0-332b-4a2a-b6ee-a19b64d20aa7	558c08b9-4e02-4dd9-8609-fb9ab87b07f6
c3f44434-a8ae-477e-8ea9-ebae32ef3c22	31e3a92a-deef-464c-9a6c-ce2084ec4e77	e8fe88cb-af0c-4658-9a73-f5ba3357c8f8
649d99e1-c6bd-41b6-adb2-b92adcb5f31d	2dd4b7f1-4779-4e95-8276-9a2a5d4db550	e8fe88cb-af0c-4658-9a73-f5ba3357c8f8
caf9d422-bb2a-4055-99b7-dd3166a089fa	4d06c317-d321-4dfc-b52d-a354741fb449	24366f50-5a53-420b-b177-c29d7524398e
b386cac3-5850-49d7-aab5-d1832045f380	4b3e8f5c-f3dc-4338-bfb1-145afeabff33	c6a85978-e98e-48f4-a818-5b82214e2a55
13bac8a3-a6ce-4280-a835-c2aa1610b7e4	20c856f4-48fa-436a-9e33-b7286b187a93	2da19c7d-d570-403d-8909-85c63df4bfd6
a4e0a255-d48e-42ad-9b43-c65bce6781ae	2e964c4a-cedd-4729-9f12-88022618d7bf	c6a85978-e98e-48f4-a818-5b82214e2a55
0cb8821f-2315-4ac8-b8b3-b9a5fca07fc9	2e964c4a-cedd-4729-9f12-88022618d7bf	f2aa3e42-2953-4c38-a9c5-0f3ab55b9d04
44a19a28-3177-4464-a3f0-c9114f2123a9	92a5e639-04f8-4af7-80e1-a7c88cc7f236	50dde8d5-90fe-4aa8-b213-29afb2122cb7
98828b6b-29b0-4bf8-aeae-4e7e4425e04a	5968759c-1e1f-4ec1-9ec7-35148d8950db	c030478b-6086-47a2-9901-5ade3f5d4a9d
b7b89e50-a196-4c9a-bc80-f9d7c96a53cb	bea308dd-bb60-461f-9630-ae77362fcf64	f2aa3e42-2953-4c38-a9c5-0f3ab55b9d04
bf6dd87d-6214-41c5-8e7a-bf23a84b48ac	bea308dd-bb60-461f-9630-ae77362fcf64	558c08b9-4e02-4dd9-8609-fb9ab87b07f6
1165c5cf-936a-424e-bd43-7867e11ecc42	97c1fafa-0067-426c-b760-38318cf928b5	2da19c7d-d570-403d-8909-85c63df4bfd6
87b2dadc-a3c8-4219-8925-e25cf5108a12	97c1fafa-0067-426c-b760-38318cf928b5	cbab6b93-361f-4c85-b031-cc2010928898
b5dddc3c-2bae-4918-a5d2-f93fbea1b39c	9324c610-8ba9-4c4e-a811-f9a037eef743	b1711f6d-adc6-4573-907f-3d3f5256b7f3
5eb41b5c-c382-4b35-ad9e-9462388b5f16	dbb087b8-ef56-42a1-a6e4-e3e0fc8afc20	c6a85978-e98e-48f4-a818-5b82214e2a55
3145954c-d8b4-402e-b17b-a019cf5f490b	5afd228f-e289-41e9-ac35-8239149a0eb9	82516138-85d6-45dd-805d-5192c78bfdb9
0116275e-97cb-4f43-84f8-919ddfa5e015	d424ad49-c85f-4357-b1e8-5a07ef0049c0	c030478b-6086-47a2-9901-5ade3f5d4a9d
d5403899-1987-42d6-ad95-e5ca81941e0c	388d6b07-08fa-4d44-a62b-82f4e570f3f0	c6a85978-e98e-48f4-a818-5b82214e2a55
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	main enitities	SQL	V1__main_enitities.sql	625061155	postgres	2025-06-04 12:01:03.718049	63	t
2	2	health	SQL	V2__health.sql	1121523053	postgres	2025-06-04 12:01:03.851645	68	t
3	3	trainings comps	SQL	V3__trainings_comps.sql	394752155	postgres	2025-06-04 12:01:03.950868	82	t
4	4	indexes	SQL	V4__indexes.sql	-13536363	postgres	2025-06-04 12:01:04.066557	62	t
\.


--
-- Data for Name: group_chat_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_chat_members (member_id, group_chat_id, user_id) FROM stdin;
7b0301b1-bb1b-43e5-abf3-1e55808b76cd	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	e9fc1da8-1c27-4c4f-8d2e-ec6e46550d0a
5fbaa14f-6c46-4a34-9e68-621c7f6a7ddf	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	9bec1b18-7ff0-48e8-9f55-ed60e2d4cbfb
fa45e354-79cd-431a-85f7-5190048e9889	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	e93a12f3-0bf9-496c-8d3a-5d2f42943f3b
6cbd5ca6-a83d-4dfa-8b9f-fa0c3c48b046	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	588bcdde-f69e-4aa4-9868-777f659b4d82
6f3db955-613a-4deb-b9cb-a6e3d0199698	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	663eaf77-4ba3-44a1-a7ef-6414810acb3a
282b8a23-494c-4622-a15a-45b168ec6e2d	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	dc33737a-36f6-4d37-8e04-9f09279da0f8
4b002647-150a-49f1-844e-98011d2a666e	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	19eb8f4e-eb7c-4784-ae9c-d992d1e1370a
928acbb7-9be1-493e-bc25-c22d675ca4ec	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	01ce86d4-54d0-40e7-9bdc-db3cd88cf621
2a1d2570-d27c-4116-91d1-23fd7f00f63c	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	d9a3e93c-865e-4cf3-9bee-c313bbe57610
71612dfb-1c90-4c41-8d60-dc338a73e303	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	f0fc13f4-13a4-42c2-91f3-d5dffa49d43b
e9c795b7-211c-44b5-bbf4-a1e516df2e87	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	a24788ba-9862-480a-84b4-0ee112eb7700
c51ee776-dc54-43c1-b228-f94efcb2e451	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	f53c0e7f-7f99-4cbe-924f-4a852f225b50
1058eb08-10bf-4407-b86d-a1a7c1a6da58	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	d22988e3-453f-4af2-bed8-6b2805dd330d
0f5f3abb-ce5a-47ab-a45f-329452ae7e58	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	9f1bbc93-27a2-440b-8410-115241e1cd6c
0c5163ee-fe1b-4d76-b239-ff5b05eb64b6	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	7fd94df0-1a06-4540-9042-36e909db2efb
a46f04ff-36a7-4aa9-8d0d-f94661ed39d6	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	70ca91b6-ad56-4c89-8bc7-983a763077a7
a4bdff66-e46f-4b5c-a2eb-d4bc67b0ada6	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	bf34227e-cd86-437f-95f5-d48fb096f657
a1729e4a-eb03-44a6-82e1-133e4b539b95	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	9b72e6c9-d795-40a9-8d6d-abd1150c9aca
01e9590e-b269-4e53-a25c-48fd82bd2892	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	99df127a-484d-44c7-a6e9-d7e744c54053
a974b83b-e823-49ad-b91e-360a3943661b	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	b17e3885-5d00-439a-bb47-e64cca4c9995
863b7282-16e9-4eaa-a819-c4b8343fc3eb	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	94b334d4-8b5d-4200-b863-730e3c6628a8
940e3250-d7e3-47e8-af43-da850ac6c730	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	aea78d3a-2b93-4cd1-9b25-c69d5aeba20b
383ec82f-3038-4972-93c4-72da6f38b0d6	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	936a095a-c5ae-4f1a-91e7-58e930d38700
d55c8576-29bc-4e21-bab4-78d09c39487f	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	0ff2642e-2f6f-42e2-a0f6-3c0eebcd765f
4fd55905-0a21-4df9-8040-3f8228ba0d58	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	3164d8d8-2517-4e9b-ac73-84802e3322cc
297f63e6-ee14-4606-a018-e2d3611e3029	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	48117389-3c10-4fee-9b35-172558be8086
b913ad36-b25e-4d3a-a351-0c931e1f4046	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	bf6506d5-fc4f-4a3e-914a-5ffac04f487a
82cf8c21-9816-49f8-b15b-d98c9968b9f7	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	15f7316b-4bfc-48e1-b5be-a1b87f731d5f
f7ace4b4-a34d-4003-b258-86251c115aa6	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	2e964c4a-cedd-4729-9f12-88022618d7bf
cc9c7189-1bd5-41e2-8d9d-83d5d6f6868f	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	0eccc020-3ab3-49cf-a218-4bc872002f05
da632528-ceb9-4176-ac95-9352e3818a77	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	21e9cc9e-88bd-4d9e-a19e-1363d8c97997
ea054c44-c327-4309-b93d-3b11dcb4c6dc	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	6dcc02b3-c178-48b7-a534-331ac5613eb2
175a9500-5a88-44d9-a8fb-3bbf7a82cd5b	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	69a18512-a2b1-432c-a767-b4e02b7e8413
61fd0d71-396c-4c0e-9a06-635633e3bdea	4b0efa11-601c-4b93-be89-6eb0d2f17127	acdfffcf-d93a-4817-87f8-253fc3c4f861
d58b64d4-9744-46bb-9124-e09a180bc34b	4b0efa11-601c-4b93-be89-6eb0d2f17127	3b6e1bff-a157-4c5d-a200-b2565c7eb172
758f5002-6bac-463d-ae3d-8368e1865259	4b0efa11-601c-4b93-be89-6eb0d2f17127	e9fc1da8-1c27-4c4f-8d2e-ec6e46550d0a
b63c35c2-166b-4dfb-bc96-b371f2e16ce0	4b0efa11-601c-4b93-be89-6eb0d2f17127	3edd911b-fcec-4527-9863-46607c8be987
367162dd-e47b-4e3a-917e-e440b4a0f6f7	4b0efa11-601c-4b93-be89-6eb0d2f17127	ff8a03bd-05cf-4476-9d53-e72527f78b97
20de3cec-4ba4-4bac-a367-32ce5e5de664	4b0efa11-601c-4b93-be89-6eb0d2f17127	a0d2dc81-9f48-4a61-b622-3ecded01d8d1
5ad2a0e5-838a-4faa-a90a-405087eea613	4b0efa11-601c-4b93-be89-6eb0d2f17127	e93a12f3-0bf9-496c-8d3a-5d2f42943f3b
102666f1-e97e-495f-9994-a64c3b56d8c2	4b0efa11-601c-4b93-be89-6eb0d2f17127	588bcdde-f69e-4aa4-9868-777f659b4d82
ac8f6c81-7c0e-477d-b0bf-c7592b6e971e	4b0efa11-601c-4b93-be89-6eb0d2f17127	e0c84fd2-61b3-44c3-96b2-e320099ff540
cad009f2-a422-4871-b19c-5bfa5f931341	4b0efa11-601c-4b93-be89-6eb0d2f17127	19eb8f4e-eb7c-4784-ae9c-d992d1e1370a
57e5ab2f-2e89-4b05-a25c-f0986cdf28e7	4b0efa11-601c-4b93-be89-6eb0d2f17127	01ce86d4-54d0-40e7-9bdc-db3cd88cf621
1f5f195c-7bac-4019-9636-f1073f50568d	4b0efa11-601c-4b93-be89-6eb0d2f17127	9fbf1314-b152-41e7-bd83-ab909be70c50
fa95bdd3-ae1a-42ab-9ee4-a52f5d46b51d	4b0efa11-601c-4b93-be89-6eb0d2f17127	32b3c932-48f1-4f6b-9e64-355c7a634b4d
75e80b48-032f-4116-b333-69aecd9fdd71	4b0efa11-601c-4b93-be89-6eb0d2f17127	10ac13d6-73ca-4cbf-a5d2-b85403e7faed
f953a148-76c8-4c69-98e9-49e53d0395da	4b0efa11-601c-4b93-be89-6eb0d2f17127	f0fc13f4-13a4-42c2-91f3-d5dffa49d43b
806de45a-00b4-4a6a-a679-f45235011a67	4b0efa11-601c-4b93-be89-6eb0d2f17127	5cf96c40-3094-4999-913a-e378e31c82e6
af8592e1-ca19-476f-b5e5-022ae6cba2f7	4b0efa11-601c-4b93-be89-6eb0d2f17127	d22988e3-453f-4af2-bed8-6b2805dd330d
ccc24969-4f8f-4052-92eb-29f0db858558	4b0efa11-601c-4b93-be89-6eb0d2f17127	642df5af-cea9-49c1-a820-f60bc0e5f451
166678bf-876c-4ea8-b384-3735566e0c71	4b0efa11-601c-4b93-be89-6eb0d2f17127	8f5ff173-7446-43ca-a127-61e51fb2f744
f652e92b-0bc6-48b0-8106-3bc779d791bf	4b0efa11-601c-4b93-be89-6eb0d2f17127	7fd94df0-1a06-4540-9042-36e909db2efb
25c88a51-92c7-4b94-886d-11f5c1854638	4b0efa11-601c-4b93-be89-6eb0d2f17127	bf34227e-cd86-437f-95f5-d48fb096f657
2f5e031c-8290-4b4b-8904-bf94a4d8573c	4b0efa11-601c-4b93-be89-6eb0d2f17127	9b72e6c9-d795-40a9-8d6d-abd1150c9aca
7c7a72f6-4952-4134-83f1-8497877466ba	4b0efa11-601c-4b93-be89-6eb0d2f17127	cf540071-ebc4-4cf2-95d0-ece5567b6a8a
82bb3581-0a95-44b6-96d0-d253163477e8	4b0efa11-601c-4b93-be89-6eb0d2f17127	bee55ca1-cc5d-4e4a-8d4a-249b86a86737
60b395d4-d2a3-4527-a591-2620d0b58178	4b0efa11-601c-4b93-be89-6eb0d2f17127	aea78d3a-2b93-4cd1-9b25-c69d5aeba20b
52683679-c4fc-4555-b8f7-0f3c63bcaf1d	4b0efa11-601c-4b93-be89-6eb0d2f17127	48117389-3c10-4fee-9b35-172558be8086
f12521bf-3c19-4842-b501-070d0945379e	4b0efa11-601c-4b93-be89-6eb0d2f17127	20c856f4-48fa-436a-9e33-b7286b187a93
ba201d2e-bc7b-44dd-afb9-9305dce4d559	4b0efa11-601c-4b93-be89-6eb0d2f17127	5968759c-1e1f-4ec1-9ec7-35148d8950db
155c4320-475e-458c-8649-6daeec79857f	4b0efa11-601c-4b93-be89-6eb0d2f17127	6694c4ba-b82a-4ca1-a8b1-cc5d35a7a372
ccc9f17e-ea21-4e1d-a48d-803c742e130a	4b0efa11-601c-4b93-be89-6eb0d2f17127	bea308dd-bb60-461f-9630-ae77362fcf64
565fb665-eb7d-489d-8085-9d769080e45f	74aea551-52f9-4f5e-9e0b-79e8c090389f	acdfffcf-d93a-4817-87f8-253fc3c4f861
cb32c5c8-5b0d-454a-a272-8f848d2991b0	74aea551-52f9-4f5e-9e0b-79e8c090389f	ff8a03bd-05cf-4476-9d53-e72527f78b97
f688b370-a8c4-4158-ae20-0412429d29bf	74aea551-52f9-4f5e-9e0b-79e8c090389f	15825a85-1d72-452e-9c85-9c281cd2b9ef
ff8594b1-e132-4ad1-bf28-55f59c1fac83	74aea551-52f9-4f5e-9e0b-79e8c090389f	a0d2dc81-9f48-4a61-b622-3ecded01d8d1
d63ff778-2ff3-49a4-8aba-015dca3afab4	74aea551-52f9-4f5e-9e0b-79e8c090389f	e0c84fd2-61b3-44c3-96b2-e320099ff540
791a144b-3fbc-40f2-8fa5-8769bbc79f4a	74aea551-52f9-4f5e-9e0b-79e8c090389f	d144b392-0f6b-4a5a-9d47-7404340d3cbf
d448e7ba-b59a-4046-946d-67382c180fce	74aea551-52f9-4f5e-9e0b-79e8c090389f	dc33737a-36f6-4d37-8e04-9f09279da0f8
ec0365ff-c1a0-494d-869a-cb12d91c9498	74aea551-52f9-4f5e-9e0b-79e8c090389f	d8c9f3ac-22ea-42c0-b786-87b0b78bbd21
114dc241-f18a-4cf2-9703-ae0780075b87	74aea551-52f9-4f5e-9e0b-79e8c090389f	fda19059-e00a-4a2d-b68c-d1a7512f1401
ab4b410f-bec0-433c-bf7b-7d0fd27b81df	74aea551-52f9-4f5e-9e0b-79e8c090389f	5cf96c40-3094-4999-913a-e378e31c82e6
575e5245-b83b-4735-8c7b-b0719e58c456	74aea551-52f9-4f5e-9e0b-79e8c090389f	d22988e3-453f-4af2-bed8-6b2805dd330d
36e94daa-fc9f-4332-b28c-ffb8f8d3f978	74aea551-52f9-4f5e-9e0b-79e8c090389f	642df5af-cea9-49c1-a820-f60bc0e5f451
deaa5191-050e-4652-aab0-eaae1c6cf82d	74aea551-52f9-4f5e-9e0b-79e8c090389f	c3567130-5f32-42dc-85f7-cddd10b583e9
465e34bf-d986-49c1-a5bd-cf96fc070362	74aea551-52f9-4f5e-9e0b-79e8c090389f	c1e1b966-9289-470c-838e-c7d706186871
c8443b09-190b-46c9-978b-2f96506ec8ee	74aea551-52f9-4f5e-9e0b-79e8c090389f	8f5ff173-7446-43ca-a127-61e51fb2f744
98321422-440d-4111-8e5c-a400ac4e573c	74aea551-52f9-4f5e-9e0b-79e8c090389f	62f01ea8-945b-4884-aa68-6c7572c1d78c
7cf516fb-4223-4abd-9581-498a4f273f9e	74aea551-52f9-4f5e-9e0b-79e8c090389f	8e0ecf55-df9d-4a5f-a24d-2613cc41be4b
496ed885-04cd-4ac3-b5e2-e641e7054055	74aea551-52f9-4f5e-9e0b-79e8c090389f	0e8e8e3e-ea1a-4248-9c1e-62850a4bed89
a161ba95-7311-45c6-8b1c-688e69868143	74aea551-52f9-4f5e-9e0b-79e8c090389f	7fd94df0-1a06-4540-9042-36e909db2efb
8f6047e7-49cb-4dd9-941f-776d498bfe2e	74aea551-52f9-4f5e-9e0b-79e8c090389f	99df127a-484d-44c7-a6e9-d7e744c54053
ac3fb0b3-8ee1-43ba-b3e1-11e150f815b6	74aea551-52f9-4f5e-9e0b-79e8c090389f	b17e3885-5d00-439a-bb47-e64cca4c9995
9bbd192c-2fbe-4d11-9035-2218201a457e	74aea551-52f9-4f5e-9e0b-79e8c090389f	6c8bb259-f4c1-44c8-bfb2-f33ff0700b27
f915c8df-d7bd-42b5-813d-6229826c1613	74aea551-52f9-4f5e-9e0b-79e8c090389f	94b334d4-8b5d-4200-b863-730e3c6628a8
07564eac-5153-4ba6-bfcd-74db04a8a8df	74aea551-52f9-4f5e-9e0b-79e8c090389f	ab9a61bf-60ef-4d02-a79a-e16e1eccd8d1
094610d2-6868-4ecd-bc84-86f798800993	74aea551-52f9-4f5e-9e0b-79e8c090389f	216e5a26-41c0-42b2-9622-c89c44f0fc27
9baaf8d8-1519-422a-9ed1-7710210df8d3	74aea551-52f9-4f5e-9e0b-79e8c090389f	0ff2642e-2f6f-42e2-a0f6-3c0eebcd765f
bf13fcd1-5abf-4994-a6db-771f49055f25	74aea551-52f9-4f5e-9e0b-79e8c090389f	81419018-a89c-42bb-80c6-3cd70f4fb020
2ccb9e8d-abba-4f7e-9b3b-ea24a0307977	74aea551-52f9-4f5e-9e0b-79e8c090389f	3164d8d8-2517-4e9b-ac73-84802e3322cc
d3ce4146-7da5-43eb-a4fe-7eba4381b7fb	74aea551-52f9-4f5e-9e0b-79e8c090389f	31e3a92a-deef-464c-9a6c-ce2084ec4e77
6ad2325e-9530-4e11-93ca-1a7264c8acb5	74aea551-52f9-4f5e-9e0b-79e8c090389f	48117389-3c10-4fee-9b35-172558be8086
5a4f5e7c-bdb4-4419-bcb2-f2783dfbaf0b	74aea551-52f9-4f5e-9e0b-79e8c090389f	15f7316b-4bfc-48e1-b5be-a1b87f731d5f
2d3f8717-c579-45d1-934d-d6ef5237d8ef	74aea551-52f9-4f5e-9e0b-79e8c090389f	52cf3c15-370d-4e6c-839e-e630a358406a
af8daa20-f15e-4b84-9065-85095b69f9f4	74aea551-52f9-4f5e-9e0b-79e8c090389f	97c1fafa-0067-426c-b760-38318cf928b5
905113c8-7a3d-46a5-b05c-08656e718057	74aea551-52f9-4f5e-9e0b-79e8c090389f	d424ad49-c85f-4357-b1e8-5a07ef0049c0
f39d82c9-4771-48ef-b3d4-c1bc498dc161	74aea551-52f9-4f5e-9e0b-79e8c090389f	6dcc02b3-c178-48b7-a534-331ac5613eb2
0c21837c-4036-4455-8409-f349e82faf1a	404af2f7-1947-4686-8e12-8066be6339aa	dbc2bc60-18d7-40a5-b6b5-023999f69c7f
1b8c8652-8205-4037-b831-54aa67a495ba	404af2f7-1947-4686-8e12-8066be6339aa	d105751f-5139-45ae-b658-d321dbf4e961
79d0415d-d5d2-439d-bbcb-9d36356d157f	404af2f7-1947-4686-8e12-8066be6339aa	e93a12f3-0bf9-496c-8d3a-5d2f42943f3b
a4d3f1cb-0e3f-4450-b2ab-f8f4c87f08e7	404af2f7-1947-4686-8e12-8066be6339aa	dc33737a-36f6-4d37-8e04-9f09279da0f8
bbab7129-3ec7-4ad9-863e-b3cc422fe67a	404af2f7-1947-4686-8e12-8066be6339aa	4845be0f-92e5-4e55-b00e-a21359b5ca1a
76a7d3da-654a-418e-bb13-fe2ea74568fc	404af2f7-1947-4686-8e12-8066be6339aa	d8c9f3ac-22ea-42c0-b786-87b0b78bbd21
5159d33f-fefd-4569-bd2c-dfcbb4d455a5	404af2f7-1947-4686-8e12-8066be6339aa	01ce86d4-54d0-40e7-9bdc-db3cd88cf621
f8e06021-4a0e-4a6c-95f1-8fdd30d9a445	404af2f7-1947-4686-8e12-8066be6339aa	32b3c932-48f1-4f6b-9e64-355c7a634b4d
731eaed4-77ff-48e6-8b07-6e326b4dba73	404af2f7-1947-4686-8e12-8066be6339aa	f53c0e7f-7f99-4cbe-924f-4a852f225b50
2297e00d-d7f6-4c55-9d29-9cfccf59a252	404af2f7-1947-4686-8e12-8066be6339aa	d22988e3-453f-4af2-bed8-6b2805dd330d
925d08e5-e6c6-4f66-8b12-03d4fbe0ca76	404af2f7-1947-4686-8e12-8066be6339aa	642df5af-cea9-49c1-a820-f60bc0e5f451
70bfa811-d656-4d16-ae00-602b29302b7b	404af2f7-1947-4686-8e12-8066be6339aa	d8855132-907d-4eca-852f-75d40c6402e2
bb21d494-2683-4b01-88fd-daafb23643f7	404af2f7-1947-4686-8e12-8066be6339aa	62f01ea8-945b-4884-aa68-6c7572c1d78c
cc8bf6e8-a648-4b5c-b4b4-3b84688d4ec8	404af2f7-1947-4686-8e12-8066be6339aa	cf540071-ebc4-4cf2-95d0-ece5567b6a8a
686ef252-9402-4dfd-8e4b-2f7c37a5fcf1	404af2f7-1947-4686-8e12-8066be6339aa	ab2c6c39-d8f5-4af7-b020-e6eafca298eb
3d428084-4a73-4569-8883-78b26ec7cfbd	404af2f7-1947-4686-8e12-8066be6339aa	e56fad7f-f5b5-45f9-82d9-cfa6b761b8cb
d5490f98-4e9e-471e-97e2-49a679d71104	404af2f7-1947-4686-8e12-8066be6339aa	61d282ce-1edd-46d0-8831-801c0f1b82b5
b01ec43a-70e4-4284-9fe5-7c09471917f0	404af2f7-1947-4686-8e12-8066be6339aa	216e5a26-41c0-42b2-9622-c89c44f0fc27
29b78175-bcdb-4999-8d5f-1b0df765ff59	404af2f7-1947-4686-8e12-8066be6339aa	15f7316b-4bfc-48e1-b5be-a1b87f731d5f
0fdc30d8-cdb2-4869-9780-df19cf628a38	404af2f7-1947-4686-8e12-8066be6339aa	20c856f4-48fa-436a-9e33-b7286b187a93
ae81bde3-4858-47d4-9acb-667080192f24	404af2f7-1947-4686-8e12-8066be6339aa	2e964c4a-cedd-4729-9f12-88022618d7bf
94ccd68f-c134-441b-9326-6eb3b5cbdb19	404af2f7-1947-4686-8e12-8066be6339aa	5968759c-1e1f-4ec1-9ec7-35148d8950db
c56dd1d8-95d3-40ee-a813-a4731bac561a	404af2f7-1947-4686-8e12-8066be6339aa	0eccc020-3ab3-49cf-a218-4bc872002f05
44ad2e3e-c599-457e-bdd0-8da5563c958b	404af2f7-1947-4686-8e12-8066be6339aa	5afd228f-e289-41e9-ac35-8239149a0eb9
e35c4985-4acd-4412-a8f1-bc9a606cd419	404af2f7-1947-4686-8e12-8066be6339aa	bccc0e62-2471-4133-8392-50732c9ec575
e49f2b0d-c6d5-4ea0-996b-e777a94cad27	5eccc1af-fc58-41ad-90b7-2c47235f6113	acdfffcf-d93a-4817-87f8-253fc3c4f861
891cfbc3-a1f8-413b-bc4e-445a966b4e33	5eccc1af-fc58-41ad-90b7-2c47235f6113	dbc2bc60-18d7-40a5-b6b5-023999f69c7f
31774b32-803d-4c63-b7bc-04a8f7f9b617	5eccc1af-fc58-41ad-90b7-2c47235f6113	e0c84fd2-61b3-44c3-96b2-e320099ff540
d722135c-4e06-43ad-aece-44f35750dd2d	5eccc1af-fc58-41ad-90b7-2c47235f6113	eb3aaa49-49b9-411e-93ff-3309c3f85033
e5f94125-5640-46be-b5ad-64c95a3fa909	5eccc1af-fc58-41ad-90b7-2c47235f6113	dc33737a-36f6-4d37-8e04-9f09279da0f8
c6587044-8eaa-45ce-b4a8-c09a78000760	5eccc1af-fc58-41ad-90b7-2c47235f6113	32b3c932-48f1-4f6b-9e64-355c7a634b4d
8df87998-43b2-48b6-9e88-609f7c1ae31a	5eccc1af-fc58-41ad-90b7-2c47235f6113	10ac13d6-73ca-4cbf-a5d2-b85403e7faed
e2da20b2-373b-4b02-b298-9ef6ba426a1e	5eccc1af-fc58-41ad-90b7-2c47235f6113	9a2ec07e-02cd-41b9-a9af-f22e909d0b1a
29c97eeb-6d97-4a03-8043-2e11c872d896	5eccc1af-fc58-41ad-90b7-2c47235f6113	a24788ba-9862-480a-84b4-0ee112eb7700
70dc0939-5c23-4054-b6a4-6e9e321f93a4	5eccc1af-fc58-41ad-90b7-2c47235f6113	5cf96c40-3094-4999-913a-e378e31c82e6
340f9cd0-3af0-4d29-96b9-3816d53878ce	5eccc1af-fc58-41ad-90b7-2c47235f6113	d22988e3-453f-4af2-bed8-6b2805dd330d
da2ffa31-1562-4012-aae5-26dec4dc541b	5eccc1af-fc58-41ad-90b7-2c47235f6113	8f5ff173-7446-43ca-a127-61e51fb2f744
bd37aace-c10e-459b-9f6c-84133fe22a06	5eccc1af-fc58-41ad-90b7-2c47235f6113	8e0ecf55-df9d-4a5f-a24d-2613cc41be4b
668b3824-fcd7-429a-aa1c-2cab6e44748c	5eccc1af-fc58-41ad-90b7-2c47235f6113	0e8e8e3e-ea1a-4248-9c1e-62850a4bed89
9b0d4088-e773-4973-ba7e-46976852a8e9	5eccc1af-fc58-41ad-90b7-2c47235f6113	7fd94df0-1a06-4540-9042-36e909db2efb
e3894c08-9476-410e-b7e3-22e868b360f9	5eccc1af-fc58-41ad-90b7-2c47235f6113	70ca91b6-ad56-4c89-8bc7-983a763077a7
ce250430-7013-4409-92e8-496db684562c	5eccc1af-fc58-41ad-90b7-2c47235f6113	99df127a-484d-44c7-a6e9-d7e744c54053
ec1c8e24-e747-49dd-ad3e-dade01f8edc5	5eccc1af-fc58-41ad-90b7-2c47235f6113	b17e3885-5d00-439a-bb47-e64cca4c9995
31415140-6134-45b2-9d66-7459339d66fa	5eccc1af-fc58-41ad-90b7-2c47235f6113	ab2c6c39-d8f5-4af7-b020-e6eafca298eb
a1d72709-43c6-496a-96b3-0ac981dbf8d4	5eccc1af-fc58-41ad-90b7-2c47235f6113	94b334d4-8b5d-4200-b863-730e3c6628a8
15776305-aec3-4fb8-b888-7c6c554bc37c	5eccc1af-fc58-41ad-90b7-2c47235f6113	bee55ca1-cc5d-4e4a-8d4a-249b86a86737
024e30fb-6520-4d0c-8090-762122741410	5eccc1af-fc58-41ad-90b7-2c47235f6113	aea78d3a-2b93-4cd1-9b25-c69d5aeba20b
5a8a126b-78fe-4088-9146-d39325968a5e	5eccc1af-fc58-41ad-90b7-2c47235f6113	648de0b0-332b-4a2a-b6ee-a19b64d20aa7
6ec5538f-4f85-4efc-b622-c3209efeea39	5eccc1af-fc58-41ad-90b7-2c47235f6113	31e3a92a-deef-464c-9a6c-ce2084ec4e77
1a4e3ab8-f781-40ff-a143-017bc20fb257	5eccc1af-fc58-41ad-90b7-2c47235f6113	15f7316b-4bfc-48e1-b5be-a1b87f731d5f
4b95f5ee-d2f7-4aa6-9544-0a0cce450a78	5eccc1af-fc58-41ad-90b7-2c47235f6113	52cf3c15-370d-4e6c-839e-e630a358406a
5e1cc185-5ebb-4fef-b5ce-d9963aff6605	5eccc1af-fc58-41ad-90b7-2c47235f6113	2e964c4a-cedd-4729-9f12-88022618d7bf
f5487412-e7b5-4c66-a2d0-19bdb05bbd1c	5eccc1af-fc58-41ad-90b7-2c47235f6113	97c1fafa-0067-426c-b760-38318cf928b5
c0083b70-5b85-4f1b-9679-076f700191d9	5eccc1af-fc58-41ad-90b7-2c47235f6113	21e9cc9e-88bd-4d9e-a19e-1363d8c97997
\.


--
-- Data for Name: group_chats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_chats (group_chat_id, name) FROM stdin;
14c3283c-0aaf-44ea-a3d9-c593e8bf69c5	Group veniam
4b0efa11-601c-4b93-be89-6eb0d2f17127	Group sit
74aea551-52f9-4f5e-9e0b-79e8c090389f	Group sint
404af2f7-1947-4686-8e12-8066be6339aa	Group ipsum
5eccc1af-fc58-41ad-90b7-2c47235f6113	Group rerum
\.


--
-- Data for Name: injuries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.injuries (injury_id, athlete_id, description, injury_date, recovery_date) FROM stdin;
2fd77ddf-e948-425c-9ec0-acea89f0501f	ad059698-d6de-42a7-af6d-6e3cd5a80846	Fracture	2020-10-20	2021-03-23
4eaa620a-d94d-41ba-8133-9677b598ae7d	953cd6cf-72c3-4ffa-98c2-eb96e96c35bf	Back Pain	2012-02-02	2013-11-18
159e98a9-90de-4a1a-b09b-b3a33feff640	3a4572b7-0b21-4f81-8052-0192e1fd87f2	Knee Injury	2008-02-04	2009-05-04
b9447e17-7bd2-403d-b238-952f1bd89e46	98be8fb8-c108-41f5-9784-500225d7df73	Sprained Ankle	2006-06-25	2006-07-05
d23ad13f-8a4e-4ac1-9b45-467430455a34	1de452c3-d6a0-4013-b6a9-7823d32caa1e	Back Pain	2023-04-26	2024-11-21
b3518065-c9b8-46bc-9a8f-a78d954ce54a	48f8b0c8-3b66-4f02-bed0-47427f33c1e0	Concussion	2022-04-25	2024-10-28
cb1290a6-8a35-4c44-82f1-117882c330ef	32620980-8215-4340-a976-50ce6cb74e20	Concussion	2024-05-23	2026-03-01
a25b1b13-23a2-41e5-815e-bac73decd9ae	ba8f8660-ae06-42c2-8131-e19ebd96dabd	Fracture	2015-06-23	2016-07-20
aa502e31-73e6-4289-8912-bd87c476e2bd	0320789b-2cc9-4e68-a63f-fcb3b6bbd1f3	Knee Injury	2021-06-07	2023-04-25
b5a2893f-ebfb-4f13-9013-eaa63a3d2281	e8ed0b59-2464-46d1-a3ea-760a861c2cfa	Back Pain	2018-10-27	2018-01-09
3cf7a3ec-8f4d-46bb-98cc-405eaab10e39	79f33da8-d2c1-47e5-8b55-a6817791e851	Fracture	2017-05-23	2018-03-10
74f2c880-d48f-417c-ac41-36fd6f6e3c0b	26bbe248-334f-4642-91b1-4074c81a76b8	Fracture	2022-02-20	2022-06-15
0058d938-8386-4a47-a31d-a7d51ada2df9	f01255a1-b841-4431-b871-ce578e5df7bc	Back Pain	2023-02-26	2024-02-06
761d5869-73fa-4560-a7d2-850e6df875c2	bff1cbed-6310-4771-bc66-4250edc8b36d	Knee Injury	2018-04-20	2019-03-19
8986fc43-7c5b-4ad4-b6cc-db9f075e587b	640c5882-ca7a-4e1e-b35f-dc744816cf19	Knee Injury	2021-02-18	2023-10-27
e5ad79ec-7566-447a-b450-9c25553df05c	1c0920bd-9da6-458f-8160-f1bb63f79110	Knee Injury	2008-06-26	2009-02-17
01c58269-2e78-469e-a625-a4bd419ff792	ed01eece-7ca3-4431-9dc1-c3e05b075317	Fracture	2024-12-05	2026-02-05
b8d6c529-b02c-4f73-81e1-ea3a634b00ec	21632412-e2ea-4a43-affd-31d60c58825a	Concussion	2008-03-12	2010-05-27
a6a1fff9-9274-40a4-9c80-a77f9be0d411	c807894f-400a-4f5a-a8c5-16a058322b5a	Sprained Ankle	2016-08-24	2017-01-27
4c1358ec-02f7-4c39-952e-91ff0272e0e9	c4b5132b-0f2f-49f8-95fe-8249386a0c4d	Knee Injury	2014-02-14	2015-04-11
bc525662-0964-479e-a83f-e155bedf4208	3f3e7100-37be-4cca-bd2b-50076fbf6433	Sprained Ankle	2011-12-24	2012-12-21
d9906567-2881-464f-b38c-079fa06209e1	5b488f6a-ec5f-4cd7-b33b-07df4f1ad686	Back Pain	2021-12-23	2023-11-03
90e128df-a824-47ae-b203-1c69701a2596	aaa8eaa2-2de4-483d-83dd-cacddd9c8ca7	Knee Injury	2009-12-19	2009-03-07
0ba60a33-8f08-4750-b8f3-eb8072e21f78	7ccc9074-d6a7-41d7-8c78-888af1a02f64	Knee Injury	2017-06-05	2019-03-10
2a6feba9-cd9c-4c65-806c-78f934b37f9d	4e94fb48-87cf-4ea2-afe4-dad85b86803d	Back Pain	2024-02-23	2025-11-21
57122ceb-f2ff-48ea-b745-da6e10aa4305	810089bb-05f0-44c4-bd74-2c7ba11f204c	Knee Injury	2013-12-13	2014-08-04
618430b9-4506-4c53-81b7-a6f62b3e38fe	f34e0e68-b2c1-4d38-aafb-1a6be7f98db0	Sprained Ankle	2019-11-08	2019-03-04
e23825f2-76cc-4752-a95f-58ba8667a138	d197f940-9bdb-48a1-be54-70e86ba92aaa	Sprained Ankle	2011-10-19	2011-04-04
1c6720b0-21d3-44fd-a84e-8f8bcab4dad5	8012d9bd-f2b5-424a-b1f2-a81fa3d853da	Concussion	2007-10-07	2008-02-18
0c0bf659-f381-4593-aac4-0e488df9cebc	b89c07b4-0c57-4077-9535-e678989422e5	Fracture	2009-08-06	2009-11-09
9eaa5edf-ac6f-46e1-8757-98c6e2026fd4	b77f011c-4c73-4659-916b-c7d91ed8667b	Fracture	2021-04-27	2022-03-28
925d8b9d-4929-4561-b87b-37caba1201a9	b1a706a8-448d-4a86-857c-877b3d36a909	Back Pain	2016-11-24	2017-04-02
1c55b019-dca5-4727-bcf2-62a55707a47a	67806c4a-b344-45b6-90dc-96e256a46db8	Concussion	2024-07-27	2024-12-10
\.


--
-- Data for Name: macro_cycles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.macro_cycles (macro_cycle_id, training_plan_id, description) FROM stdin;
5b81ab21-c855-4729-9c59-f885ab7a62c3	6d627e28-6088-4900-9e97-08909387cdb3	MacroCycle nesciunt
00238745-951d-4de7-a559-78a9de0b766f	21ba4295-ae9a-4a08-bb50-53b4deea95ce	MacroCycle odio
a8a797ab-75c3-4b14-9daa-c576ae05d5eb	a1b1550f-ba76-45bd-91f6-a332169eb8b4	MacroCycle et
089fb689-bdbf-40f4-a2fb-4723574a3b34	81dcab73-2a51-47b5-9c1f-58e71f830793	MacroCycle sunt
54547fc9-294e-4238-ad83-dc8111cc0d5e	5642958a-a81f-4d97-a311-ed27b6bfe310	MacroCycle et
6ddc3173-5553-47c7-84c3-846ec4794a17	caeb17bf-7281-473a-ad9b-9a278bd24438	MacroCycle eligendi
2fedf48f-263d-455a-aaa4-013cb89baafc	ff7a2937-d771-4dd2-b224-bf828300af5c	MacroCycle voluptatem
fba755a5-c467-4cd5-bbf3-7aeb280d08b0	7a081b53-b542-4be4-b187-5819e56313f4	MacroCycle dolorem
db90b027-6c8f-4006-8134-6c597a7ac1de	ce019c61-6be0-4893-acee-782bb8557d21	MacroCycle id
c48f816c-1e73-4879-a5d6-fe4a31605bd4	19c479be-f7d2-4a92-8c83-18b790549545	MacroCycle repudiandae
8245235e-6cea-49d3-99b6-c11afb65b410	31aa8533-7066-49f8-b4c1-a2a9e344f928	MacroCycle tenetur
f6118003-a170-430b-bacb-2312074f815a	7214b6e6-3039-43f1-8198-794729d4e1d2	MacroCycle earum
c5fe1aa8-7d12-4175-b7e2-b18b3e5ec079	9e8a7879-3fbc-4336-9692-49cf5f696ffc	MacroCycle rem
305a08ab-7252-455e-a040-13616e7192c9	90cac6cc-6e85-4dd2-a1f5-c7098afca457	MacroCycle non
96049ff2-dc4c-435e-be17-532eb86cc3db	18d79194-ae3e-4a2d-9c3c-d669d7c68807	MacroCycle quibusdam
c560e30d-8505-4c2c-ae1b-0946b4e892f1	03471dd9-56ff-4ad6-ada4-90d27056db8c	MacroCycle unde
\.


--
-- Data for Name: material_comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.material_comments (comment_id, material_id, user_id, text, date) FROM stdin;
57897538-6550-4cf9-814c-db0ccc4197ea	558c08b9-4e02-4dd9-8609-fb9ab87b07f6	bf34227e-cd86-437f-95f5-d48fb096f657	Repellat saepe quia aut omnis blanditiis.	2025-05-22
0fd2c508-087f-489b-b3f7-e5485cfb2b93	558c08b9-4e02-4dd9-8609-fb9ab87b07f6	9a2ec07e-02cd-41b9-a9af-f22e909d0b1a	Vel quod accusamus sapiente qui ut.	2025-05-21
99c02963-0a55-47b2-90d8-38d77f3d44ad	b1711f6d-adc6-4573-907f-3d3f5256b7f3	a24788ba-9862-480a-84b4-0ee112eb7700	Rerum laudantium tempora odit animi dignissimos.	2025-06-03
9ecb5460-af98-4fb6-bf29-d6bb3d04e799	b1711f6d-adc6-4573-907f-3d3f5256b7f3	d144b392-0f6b-4a5a-9d47-7404340d3cbf	Ut reiciendis totam eius ut sunt.	2025-06-03
67a448d9-7347-4ccc-87a8-db87f6c81824	b1711f6d-adc6-4573-907f-3d3f5256b7f3	f0fc13f4-13a4-42c2-91f3-d5dffa49d43b	Similique rerum et sunt et nesciunt.	2025-06-04
86af3fa0-28fb-43cf-a20c-fd8ddb7beef9	67d430c8-1e07-4fdb-8ea4-441670fc8810	4b3e8f5c-f3dc-4338-bfb1-145afeabff33	Autem nemo eveniet aut ut quis.	2025-06-02
4d38d1bd-2556-4b24-a1a6-255cd3d201ab	67d430c8-1e07-4fdb-8ea4-441670fc8810	f53c0e7f-7f99-4cbe-924f-4a852f225b50	Unde est iusto quod explicabo consectetur.	2025-06-01
bff371ab-6ae2-4820-a152-3ff187a5eed7	c030478b-6086-47a2-9901-5ade3f5d4a9d	bea308dd-bb60-461f-9630-ae77362fcf64	Est assumenda provident quod sed autem.	2025-05-25
fb18255a-59bd-41d4-ba13-8a185caab781	c030478b-6086-47a2-9901-5ade3f5d4a9d	a24788ba-9862-480a-84b4-0ee112eb7700	Error dolor molestiae voluptatem corporis quidem.	2025-05-24
ca99c531-f298-4f8e-9110-4ed0455f710f	d6aa103d-700b-4d6c-8a2b-d333b407ce92	7fd94df0-1a06-4540-9042-36e909db2efb	Magni eos id quia doloribus voluptatem.	2025-05-27
b185349a-0ed8-4571-b5fa-d11abaeeb08f	0db81584-3653-4675-b2d4-fa655077b2f4	6c8bb259-f4c1-44c8-bfb2-f33ff0700b27	Commodi repellendus qui eos id eos.	2025-05-27
826a5d39-93a2-4713-a917-93cb2a01d0c1	0db81584-3653-4675-b2d4-fa655077b2f4	15f7316b-4bfc-48e1-b5be-a1b87f731d5f	Nam sint temporibus eligendi autem tempora.	2025-05-29
f371104d-36a9-4a93-a589-6df864c875d0	0db81584-3653-4675-b2d4-fa655077b2f4	01ce86d4-54d0-40e7-9bdc-db3cd88cf621	Incidunt nobis neque quia ducimus pariatur.	2025-05-29
b984746a-934a-4fff-8c32-9ebe48daf8ec	2da19c7d-d570-403d-8909-85c63df4bfd6	0eccc020-3ab3-49cf-a218-4bc872002f05	Laudantium est exercitationem laboriosam error voluptas.	2025-06-01
edec37c4-bb87-429f-ba06-55c8c4a14c20	cbab6b93-361f-4c85-b031-cc2010928898	dbb087b8-ef56-42a1-a6e4-e3e0fc8afc20	Esse sequi consequuntur consectetur voluptatem corrupti.	2025-05-25
fd88ed54-1506-4fa4-9c2c-704176eb54a1	cbab6b93-361f-4c85-b031-cc2010928898	e93a12f3-0bf9-496c-8d3a-5d2f42943f3b	Est quasi qui aut placeat sequi.	2025-05-21
b46e1642-54ee-4b98-84eb-98522ea7fb04	a98faf2d-fd96-40fe-84fa-756bead91b8c	9324c610-8ba9-4c4e-a811-f9a037eef743	Quis omnis aut ratione ea perspiciatis.	2025-06-02
e174db99-7959-4e5e-8158-f8fc917c3671	c6a85978-e98e-48f4-a818-5b82214e2a55	4d06c317-d321-4dfc-b52d-a354741fb449	Ratione optio reprehenderit qui molestiae ut.	2025-05-27
a96aaa3e-a745-4604-9f6b-80c3bfe3e600	c6a85978-e98e-48f4-a818-5b82214e2a55	6694c4ba-b82a-4ca1-a8b1-cc5d35a7a372	Modi excepturi illum esse dolorem necessitatibus.	2025-05-29
963be104-1bb4-491a-b218-3d53e8dbf005	24366f50-5a53-420b-b177-c29d7524398e	dbc2bc60-18d7-40a5-b6b5-023999f69c7f	Non ut eos tempora rerum qui.	2025-05-30
2011e95f-940e-4acd-a0c8-2efde36f9555	82516138-85d6-45dd-805d-5192c78bfdb9	b17e3885-5d00-439a-bb47-e64cca4c9995	Cumque et sit magnam nobis nihil.	2025-06-01
6e1e2418-1860-40cf-ba6e-2c93f7ff77ad	e8fe88cb-af0c-4658-9a73-f5ba3357c8f8	9b72e6c9-d795-40a9-8d6d-abd1150c9aca	Exercitationem et deleniti perspiciatis aut aut.	2025-05-31
05d61016-f495-4b07-9b7d-1d62988e2ed2	f2aa3e42-2953-4c38-a9c5-0f3ab55b9d04	bf34227e-cd86-437f-95f5-d48fb096f657	Quidem sed quia aperiam temporibus fuga.	2025-05-26
842ffb6c-e9f2-418f-9f77-cecd919f3eab	50dde8d5-90fe-4aa8-b213-29afb2122cb7	bf34227e-cd86-437f-95f5-d48fb096f657	Temporibus nam impedit et sunt nesciunt.	2025-06-03
50376b69-84f9-414f-99de-9618e39d1b6c	50dde8d5-90fe-4aa8-b213-29afb2122cb7	e186b3a9-9944-470b-9c6e-d2f598fe3bae	Aut impedit beatae eum reprehenderit quo.	2025-05-30
a3d734ae-1aa6-4ff8-a72b-fad1ab69cc25	50dde8d5-90fe-4aa8-b213-29afb2122cb7	4845be0f-92e5-4e55-b00e-a21359b5ca1a	Rerum ut sed voluptatem excepturi rerum.	2025-05-25
\.


--
-- Data for Name: materials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.materials (material_id, name, type, content, publication_date) FROM stdin;
558c08b9-4e02-4dd9-8609-fb9ab87b07f6	Материал eius	Тип tempore	Consequatur eaque eius corporis alias illo.	2025-06-03
b1711f6d-adc6-4573-907f-3d3f5256b7f3	Материал quidem	Тип quasi	Voluptas dolores temporibus consequatur est dolor.	2025-05-28
67d430c8-1e07-4fdb-8ea4-441670fc8810	Материал ex	Тип dignissimos	Accusantium saepe hic fuga aliquam temporibus.	2025-05-27
c030478b-6086-47a2-9901-5ade3f5d4a9d	Материал sequi	Тип consequatur	Et omnis vel ex voluptatibus accusamus.	2025-05-18
d6aa103d-700b-4d6c-8a2b-d333b407ce92	Материал voluptatem	Тип veniam	Nulla voluptas corporis illum enim aut.	2025-05-19
0db81584-3653-4675-b2d4-fa655077b2f4	Материал velit	Тип nulla	Harum quis tenetur sunt blanditiis id.	2025-05-28
2da19c7d-d570-403d-8909-85c63df4bfd6	Материал nesciunt	Тип dolores	Et consequatur reiciendis modi aut dolorem.	2025-05-20
cbab6b93-361f-4c85-b031-cc2010928898	Материал sequi	Тип quo	Nobis error fugit autem est blanditiis.	2025-05-26
a98faf2d-fd96-40fe-84fa-756bead91b8c	Материал minima	Тип consequatur	Minima rerum ipsum qui recusandae sed.	2025-05-18
c6a85978-e98e-48f4-a818-5b82214e2a55	Материал dolor	Тип et	Eos nihil qui et consequatur praesentium.	2025-05-21
24366f50-5a53-420b-b177-c29d7524398e	Материал pariatur	Тип eos	Autem voluptate iste distinctio ullam sapiente.	2025-05-17
82516138-85d6-45dd-805d-5192c78bfdb9	Материал ex	Тип doloremque	Ea nostrum nam quis tenetur qui.	2025-05-30
e8fe88cb-af0c-4658-9a73-f5ba3357c8f8	Материал porro	Тип vel	Recusandae veniam laboriosam earum et eaque.	2025-05-24
f2aa3e42-2953-4c38-a9c5-0f3ab55b9d04	Материал praesentium	Тип ratione	Dolores quia ut quo adipisci ducimus.	2025-05-30
50dde8d5-90fe-4aa8-b213-29afb2122cb7	Материал provident	Тип nulla	Rerum quos laudantium et praesentium doloribus.	2025-05-27
\.


--
-- Data for Name: medical_indicators; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.medical_indicators (id, athlete_id, pulse, blood_pressure, oxygen_level, heart_rate_variability, glucose_level, weight, body_mass_index, body_composition, hydration_level, resting_heart_rate, exercise_heart_rate, ecg_data, measurement_date) FROM stdin;
88671eb5-ce51-4eef-8c56-9ec1340cf74c	ad059698-d6de-42a7-af6d-6e3cd5a80846	49	102/77	97	74	71	72.44273622190637	24.79505621061153	DistanceRunning: 7%	Euhydrated	59	165	Expedita accusantium quisquam sunt quia molestiae.	2025-05-19
2b54590f-1588-46dd-b046-de963f067f58	98e78db7-fe89-45ea-a6f6-670350546c61	55	101/61	97	97	99	64.94329976880091	20.55728406241196	DistanceRunning: 5%	Hypohydrated	39	200	Tempora quia ut inventore odio sint.	2025-05-05
90d8d311-578b-4d57-aee4-2c1db6fd4e71	6f28b3fa-7e7b-4c66-823e-a1efd7993886	53	111/65	100	61	79	87.74652375084595	29.16558006811827	Basketball: 12%	Hypohydrated	41	187	Nobis suscipit excepturi delectus nulla ab.	2025-05-23
1c15bd2a-d096-4ed5-a6e2-8c457b530804	953cd6cf-72c3-4ffa-98c2-eb96e96c35bf	40	100/68	99	100	71	76.64059312605485	29.322020626676263	Basketball: 7%	Euhydrated	52	173	Error voluptatibus repellendus vel sunt quam.	2025-05-21
3ea8e837-3c1e-4435-84ff-d34fd95c7a3f	fc39f40d-e36c-4167-9de3-fe95b8ee2936	44	100/80	100	74	87	79.07781573951637	21.030585735218676	Swimming: 10%	Euhydrated	51	144	Eos et consequatur maiores officiis omnis.	2025-05-12
c2773a96-e50b-4688-9234-1802d18f020b	d622497b-0202-412e-b0b3-19d125499c0a	41	114/80	99	87	88	64.46850248910778	16.427166463352616	Soccer: 10%	Euhydrated	60	196	Sint neque alias nisi eum quidem.	2025-05-24
d5ad94ff-54b7-465c-8b7a-6017d43444f4	3a4572b7-0b21-4f81-8052-0192e1fd87f2	55	103/63	99	70	93	76.65504047180765	20.483560162643002	DistanceRunning: 11%	Euhydrated	30	200	In quibusdam accusantium et ipsa voluptate.	2025-06-03
e67f15bd-a09d-4556-ab1a-19bf3682accf	4377f770-933d-40da-b890-094dc68a3d7e	45	109/62	97	99	74	87.75785606524698	33.383774942694714	Soccer: 13%	Hyperhydrated	57	121	Et reprehenderit incidunt veniam delectus assumenda.	2025-05-06
55769066-dfa2-4d87-af66-4ee193aa8443	98be8fb8-c108-41f5-9784-500225d7df73	54	112/60	99	62	110	63.58433227934068	17.397995820130514	DistanceRunning: 7%	Euhydrated	56	149	Ex pariatur eius libero est harum.	2025-05-05
c8f597b0-6ccf-40f2-b17f-ce8a7f8e159d	1de452c3-d6a0-4013-b6a9-7823d32caa1e	59	117/77	99	93	74	84.15298253761172	30.152519863360347	Swimming: 9%	Euhydrated	33	139	Ut fugiat cumque blanditiis ut quis.	2025-05-13
f83fb330-55b0-4806-88e2-c6c7f27f1327	131064a7-47f4-4242-80c1-44661e6f0df8	56	109/62	99	62	85	85.79873946225268	21.92448165373234	Swimming: 10%	Euhydrated	59	173	Sunt non libero quas commodi magni.	2025-05-17
0a8f7afb-ead9-4543-a67d-fa1149919b22	48f8b0c8-3b66-4f02-bed0-47427f33c1e0	44	106/67	99	73	89	64.25485122885945	20.85906769994548	Soccer: 11%	Euhydrated	44	166	Vitae ipsam dolor corporis nam ut.	2025-06-01
65ad9c3f-bebf-4242-b787-2029355e1731	4f7f13fe-f7f4-47f8-adcd-624ed032c498	47	112/61	98	84	73	66.97494759424112	19.29968943759584	Basketball: 11%	Euhydrated	31	192	Qui ex impedit qui architecto incidunt.	2025-05-20
4244773c-5d04-4770-8f3f-04f0e4a0762f	32620980-8215-4340-a976-50ce6cb74e20	44	108/73	100	67	109	73.29460682482194	18.887622369245165	Basketball: 11%	Euhydrated	40	190	Aliquid aut dolores aperiam saepe quis.	2025-05-15
b38a2a90-03cf-45be-9b12-9f40da0fe7f6	ba8f8660-ae06-42c2-8131-e19ebd96dabd	57	107/63	97	90	77	86.47524347076174	25.662396595417942	Gymnastics: 6%	Euhydrated	38	171	Est enim velit autem veritatis nisi.	2025-05-17
21c56032-75e1-4f99-b415-67e92c57855f	ad6c6a84-da64-4ca0-a0d1-c56b692b66e2	56	102/74	98	78	72	83.24325421518935	22.031194529470007	DistanceRunning: 8%	Euhydrated	42	172	Ad non nulla fugiat repudiandae ipsa.	2025-05-13
8c8181bf-81a4-47fa-bc7b-773a946baf11	dd151103-5216-4652-b088-8b801f33f90e	44	120/68	100	85	74	85.13304170091489	28.32128130277023	Gymnastics: 7%	Hyperhydrated	53	123	Deleniti porro et autem eius cupiditate.	2025-05-17
a3f8d645-26fc-443f-a92a-e262c981f329	0320789b-2cc9-4e68-a63f-fcb3b6bbd1f3	59	114/73	99	93	77	67.3774281763954	23.13883084803539	Soccer: 10%	Hyperhydrated	58	139	Sit provident qui ad porro enim.	2025-05-19
405681cf-dff9-4134-9f33-df4cb138a8b3	e8ed0b59-2464-46d1-a3ea-760a861c2cfa	46	104/73	97	95	100	83.68729991381392	23.68224221986236	Swimming: 12%	Hyperhydrated	52	156	Maiores excepturi fugit ratione aut aut.	2025-05-27
892bca2d-7276-4097-bee5-da9efcf300b4	79f33da8-d2c1-47e5-8b55-a6817791e851	46	101/65	99	88	72	61.21398111976614	16.841934841884353	Basketball: 8%	Euhydrated	60	170	Qui sit laboriosam iusto aut dignissimos.	2025-05-30
c48eb9bb-b878-4642-a789-4c08903379e1	9d292bb9-aaac-4fbd-9500-9404f6052c3b	56	103/71	98	87	105	80.19029072092704	27.53481646396807	Basketball: 8%	Hypohydrated	39	124	Similique iste cupiditate eveniet est nemo.	2025-05-12
f40df64d-727e-4b9f-a71c-29cd88fe204e	26bbe248-334f-4642-91b1-4074c81a76b8	57	102/65	99	93	107	84.83247346781988	25.619925816627774	Soccer: 12%	Euhydrated	34	158	Ratione dignissimos qui numquam reprehenderit iure.	2025-05-25
61e88d2a-c35b-4cdc-98d5-0449a0e97092	5ed4532b-b825-4095-8e54-2cd72b9b3cd3	55	108/71	98	87	104	72.3600801190267	26.375972166558213	Gymnastics: 10%	Euhydrated	44	189	Alias fugiat magnam harum ipsam quas.	2025-05-13
1b6b2048-6dee-4078-845a-0c90b1091b4e	3781d7b2-ebe8-496b-b595-7c6df03dbc6b	48	112/61	97	84	86	86.08688582007676	24.23959244390818	Gymnastics: 7%	Euhydrated	40	176	Beatae eveniet nihil natus adipisci ut.	2025-05-15
35feb229-4a0a-4022-8a8c-95f6edb2a093	f01255a1-b841-4431-b871-ce578e5df7bc	56	116/72	97	74	83	70.07069458072309	18.82523161764181	Soccer: 15%	Euhydrated	56	143	A voluptas nam cum est fugiat.	2025-05-28
da788008-683e-482f-89f2-706c3c886448	bff1cbed-6310-4771-bc66-4250edc8b36d	50	112/80	98	65	81	67.74541356180649	17.433738815851722	Soccer: 10%	Hyperhydrated	33	190	Aut sed consectetur esse iste modi.	2025-05-07
47e7d336-03fa-4158-bcd4-23af008d5a3c	640c5882-ca7a-4e1e-b35f-dc744816cf19	56	109/64	98	61	85	75.42440842769543	25.69800376505664	Swimming: 11%	Euhydrated	55	155	Aut et rerum at consequatur culpa.	2025-05-29
e317d66a-6108-47ed-aaaa-18cec64ec23c	1c0920bd-9da6-458f-8160-f1bb63f79110	41	105/70	100	91	88	70.42305828127081	17.83967362673479	Basketball: 8%	Euhydrated	54	129	Voluptatem facere sint dolor accusamus nam.	2025-05-30
2ca10500-cee7-4ee3-9bbf-fbdc9bb2ddc2	ed01eece-7ca3-4431-9dc1-c3e05b075317	48	115/74	97	97	99	64.85702137977464	18.266148053639625	DistanceRunning: 11%	Euhydrated	38	174	Est sint quia sunt et libero.	2025-05-13
7151a255-3813-41d4-a9db-1a8bfad5832a	21632412-e2ea-4a43-affd-31d60c58825a	59	113/68	99	97	103	77.94520528436824	21.25673497447652	DistanceRunning: 9%	Euhydrated	31	156	Nihil molestiae itaque est reiciendis aperiam.	2025-05-22
3aec2e90-4d5d-4b56-9c0d-32d5ccd454fd	637fc7e1-b31f-4919-8aa9-56a5d18a867f	45	113/66	99	84	95	76.08158652168355	22.960592945798094	Swimming: 11%	Hyperhydrated	40	178	Quo rerum id est sunt enim.	2025-05-28
ddb72279-7a88-4ae5-aca2-41115ba1c1df	b2aa6266-a156-4b7b-a082-3ed6be62b785	52	118/74	98	63	79	84.87951274343021	21.906614585134644	Soccer: 13%	Euhydrated	38	187	Occaecati fugit cumque unde distinctio aut.	2025-05-22
76040149-eaf0-4c55-ae92-9bf6e7f9ef30	af4cef5c-fcfb-4d9e-8311-5f2afbcc4822	46	108/65	97	83	108	71.56619012632166	22.487169571079857	DistanceRunning: 7%	Euhydrated	51	198	Et ut consequatur distinctio maxime sapiente.	2025-05-25
9b637191-6032-4537-a723-378dbeecfeb5	c7db9c19-8c24-4e5f-a4e6-58e7d3cf7e7b	41	108/74	97	96	77	84.30799831665996	29.869515557547555	Basketball: 10%	Euhydrated	57	148	Totam magnam maxime iusto tempora dolore.	2025-05-30
733b4df1-2d38-46bc-b492-1ef198b42cad	c807894f-400a-4f5a-a8c5-16a058322b5a	49	113/64	100	71	79	81.30073984180649	27.219008912225405	Swimming: 12%	Hypohydrated	34	161	Facere vel ullam illum et consectetur.	2025-05-04
f15c808d-8f19-4ace-8fda-30c0b2459ae4	c4b5132b-0f2f-49f8-95fe-8249386a0c4d	40	114/76	100	84	83	79.1474310441451	22.17294828692219	Gymnastics: 12%	Euhydrated	49	140	Hic ut est molestiae natus beatae.	2025-05-09
29c0e063-459e-4084-b287-06f44077f668	3b22f48a-507f-4125-80fe-14fb35f79813	59	110/61	99	61	88	86.57363283892025	25.06230225122709	Gymnastics: 11%	Euhydrated	48	152	Non nesciunt quo aut dicta iure.	2025-06-04
885aa10f-d3d3-4a0a-bf1e-feba768f7f52	3f3e7100-37be-4cca-bd2b-50076fbf6433	41	116/80	99	74	98	73.47782614345104	19.272834271428106	Basketball: 11%	Hypohydrated	37	196	Quia rerum vitae voluptatibus quasi voluptatem.	2025-05-22
b1891267-13bd-4f52-9357-4b6fb61853a4	5b488f6a-ec5f-4cd7-b33b-07df4f1ad686	57	105/64	97	78	84	60.91523624641684	22.39531825375156	Basketball: 12%	Euhydrated	52	170	Fugiat sed et aspernatur rerum qui.	2025-05-12
71974ff4-6fa3-4889-8b6c-f1f7b185982a	aaa8eaa2-2de4-483d-83dd-cacddd9c8ca7	40	117/60	99	76	101	73.77389891046488	19.468499613824868	Basketball: 7%	Euhydrated	54	158	Aliquam eum et pariatur exercitationem praesentium.	2025-05-08
e7ad589c-d25e-400d-ba5a-d1d746b6d43f	b03e2327-e236-416b-9a48-1f1d399b0f2f	46	100/72	98	95	79	60.19480061830954	21.916343073885738	Swimming: 10%	Euhydrated	38	192	Optio est provident quisquam maxime non.	2025-05-23
57695e7f-dfb1-45b0-9f73-c9ce6d5a0b16	5c1f7521-a44d-41d7-92d2-0cc010634b51	46	116/73	97	68	90	61.95803107008592	22.867268235546174	Gymnastics: 7%	Hyperhydrated	58	151	Tenetur facilis eius atque ea consequatur.	2025-06-03
58050ba9-cc37-49da-a05d-f77c3969a567	591b5c8c-6e59-4ee3-82f3-ac750a58f9ea	41	105/74	97	71	88	84.13627957938529	23.56492413756597	DistanceRunning: 11%	Euhydrated	60	131	Facere quibusdam possimus quisquam recusandae quis.	2025-05-05
12428ab9-fc8b-4dd9-aad1-1bb91d7eeac9	7ccc9074-d6a7-41d7-8c78-888af1a02f64	50	117/64	97	68	81	68.61809748892269	18.49444763107846	Basketball: 11%	Hyperhydrated	57	162	Fuga quia expedita maiores quidem quasi.	2025-05-22
407000ed-24b9-4280-9d92-404a6e137a4d	6bcfbadc-3ad5-4aa2-b0fe-7bf822a0e348	49	115/73	97	77	107	81.87002843785152	29.32658021050484	Soccer: 16%	Euhydrated	44	147	Vel est eum impedit ut minima.	2025-05-25
f1b7405b-f67a-4deb-81bf-ee9c2c58c414	4e94fb48-87cf-4ea2-afe4-dad85b86803d	53	109/77	100	96	104	62.508363309803215	24.273722009827846	Basketball: 7%	Hyperhydrated	44	175	Sequi ipsa rem molestiae et suscipit.	2025-05-15
540c117b-950d-49df-8392-200c740cc636	8a6ecf81-1721-463f-a801-2a3b90146a43	50	105/74	97	80	89	87.60130235374015	23.534227957670623	Gymnastics: 8%	Euhydrated	60	194	Nam qui quis dolorem vero molestias.	2025-05-07
a12d9092-193c-4022-860f-430d87bb18e0	1341ba9e-9910-4ad7-a5dd-d929791400a0	42	114/67	99	74	77	63.1037878462389	16.925644251779016	DistanceRunning: 6%	Euhydrated	50	133	Quaerat porro dolorem laudantium voluptas neque.	2025-05-31
69233531-65c1-4ec2-bd6a-54b412ede4dd	05d49901-ba9b-4697-8ff4-e7b40e298398	58	103/60	98	96	89	65.4826674614385	18.46787656399185	Basketball: 8%	Euhydrated	42	121	Quis aliquid iste exercitationem hic placeat.	2025-05-16
5fabd929-46ce-4e31-8111-0d5468101105	7d9dfa62-28c8-4bb0-a163-a0cb871ef3fc	47	113/60	98	80	94	83.15644807548091	21.737701584018808	Basketball: 6%	Euhydrated	43	186	Dolorem quam in praesentium quidem harum.	2025-05-17
df00ac24-c63d-449e-b319-e2403a2a6bef	810089bb-05f0-44c4-bd74-2c7ba11f204c	55	101/76	97	96	100	66.67183753815765	20.42083238982735	Soccer: 13%	Euhydrated	37	179	Et natus modi aut asperiores officia.	2025-06-01
019fb7b6-7325-42ae-8021-87507eaeef81	f34e0e68-b2c1-4d38-aafb-1a6be7f98db0	42	106/79	97	63	107	81.88439487886805	28.456648118875023	Gymnastics: 11%	Hypohydrated	44	152	Doloremque ab assumenda commodi in adipisci.	2025-05-05
a45b6201-d4d2-41f2-98df-6e46407df342	0379ca12-1fb4-4f34-972f-7808d3917ac9	42	111/76	98	78	84	88.11498346767918	27.334386921641237	Soccer: 11%	Euhydrated	50	160	Provident at dolorem qui magnam a.	2025-05-26
d70492fd-aecd-4f28-ac1d-d2a11244ca89	d197f940-9bdb-48a1-be54-70e86ba92aaa	49	103/66	100	67	87	88.6192975398865	33.093399502856755	Basketball: 10%	Euhydrated	53	162	Qui quia ut nesciunt porro dicta.	2025-05-23
50615f70-2dbb-4f8e-935e-868b58e060b5	8012d9bd-f2b5-424a-b1f2-a81fa3d853da	52	102/71	99	74	107	67.56111234631432	21.642305851458218	Gymnastics: 6%	Euhydrated	44	177	Deserunt alias optio commodi non sit.	2025-05-06
d3332bc7-817d-45cb-9179-6208e1aa5d28	b89c07b4-0c57-4077-9535-e678989422e5	49	107/67	99	62	79	62.83800331894678	18.003472986265738	Swimming: 12%	Hypohydrated	43	125	Sed ab quis praesentium dolores autem.	2025-05-13
57fb7167-2d26-4e53-996a-b46597e69fba	b77f011c-4c73-4659-916b-c7d91ed8667b	43	107/67	99	89	84	80.83802848024764	31.295751329521668	DistanceRunning: 10%	Euhydrated	45	198	Reprehenderit magnam libero maxime delectus earum.	2025-05-08
8db33484-0695-4f4a-a45c-a09f6e1804fd	b1a706a8-448d-4a86-857c-877b3d36a909	45	115/80	97	74	98	87.2026118212216	22.851846945063983	DistanceRunning: 5%	Euhydrated	58	188	Sapiente dolor vel blanditiis omnis dolorem.	2025-05-13
23e05f83-cb8f-48eb-9d4a-7d7e4f867f73	caf1758c-d025-4d5e-aea0-8a9cf858617c	50	102/79	99	64	103	67.56703745707061	23.935795260522145	DistanceRunning: 5%	Hypohydrated	34	193	Quibusdam delectus culpa minus perspiciatis aspernatur.	2025-05-11
9218030d-0acb-4cb3-b454-cdcf3e42b1d3	67806c4a-b344-45b6-90dc-96e256a46db8	48	119/73	99	71	75	78.41609171116826	23.30707159577139	Swimming: 11%	Hypohydrated	35	133	Aut aspernatur similique vitae consectetur qui.	2025-05-23
3545b19a-e03f-46bb-881b-02b55a057167	c0ddf7eb-77a3-4fda-b3fb-ecb3d3e6daf6	59	109/71	100	84	89	82.15298611904649	27.83299358025578	Gymnastics: 7%	Euhydrated	45	155	Sed doloremque at provident consectetur sequi.	2025-05-12
d97e43ee-09e9-4a54-955d-fda2d0f84ee6	bd1a8138-357f-4831-9387-38412bbfe4ee	42	103/73	97	100	93	68.36087942599328	19.047105388509117	Gymnastics: 12%	Hypohydrated	60	193	Hic amet sed dolore minima qui.	2025-05-22
be1a0fae-5d3f-42a3-b11c-f482e2bac05f	de5469f5-694d-457c-b0dc-cf1ab74401e1	55	103/77	98	77	76	65.82399373073756	18.122790638664064	Basketball: 8%	Euhydrated	54	197	Sequi architecto aut rem accusamus repudiandae.	2025-05-10
861f0058-0f20-4a23-b3a9-a4b3b88dc1c6	2de7e285-5063-4bc0-82a2-1d802627fb90	50	117/74	100	62	108	72.5209357789499	21.61279509738376	DistanceRunning: 9%	Euhydrated	49	145	Aut iure facere nostrum alias repellat.	2025-05-14
4fa608ca-85b9-4939-8cf3-e36f35f398b7	13327720-e8e2-4545-85ab-a5f1dbc0fa9a	48	113/62	100	68	96	77.430673648306	21.090407501503062	Gymnastics: 6%	Euhydrated	33	147	Dignissimos mollitia nihil consectetur culpa beatae.	2025-05-29
40d1b1b2-3be2-4fb0-b6bf-2ddfb20dfbc7	8df7f275-ea8f-47ac-b543-937223141467	41	119/77	98	94	110	88.57443125803411	28.68047715190082	Gymnastics: 11%	Hypohydrated	37	131	Voluptates maiores molestias rerum ea consequuntur.	2025-05-16
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (message_id, sender_id, receiver_id, text, date, group_chat_id) FROM stdin;
40a5fd93-3054-498a-950a-2a6b24544f87	aea78d3a-2b93-4cd1-9b25-c69d5aeba20b	d424ad49-c85f-4357-b1e8-5a07ef0049c0	Dignissimos esse quisquam doloremque ut nobis.	2025-06-01	14c3283c-0aaf-44ea-a3d9-c593e8bf69c5
9e1580fd-bd13-463b-be5d-d573b44df71c	31e3a92a-deef-464c-9a6c-ce2084ec4e77	8f5ff173-7446-43ca-a127-61e51fb2f744	Fugiat exercitationem omnis a quia vel.	2025-05-30	4b0efa11-601c-4b93-be89-6eb0d2f17127
177a603e-1cb4-4dab-9632-881c3368e01a	5968759c-1e1f-4ec1-9ec7-35148d8950db	62f01ea8-945b-4884-aa68-6c7572c1d78c	Dignissimos et id voluptas aut facilis.	2025-05-30	4b0efa11-601c-4b93-be89-6eb0d2f17127
eea8e81d-a9c9-4ae6-abf2-3b184d86fee0	7bd7833c-9ea0-4e04-b9e2-f1bca999de28	bf6506d5-fc4f-4a3e-914a-5ffac04f487a	Maiores ea sit deleniti quibusdam assumenda.	2025-06-01	4b0efa11-601c-4b93-be89-6eb0d2f17127
55d1e9d8-fc93-4d17-a3c5-ef0fef1b22a2	490eae7e-06ca-4506-ad9d-cadbec707dfa	6c8bb259-f4c1-44c8-bfb2-f33ff0700b27	Provident voluptates maiores iste nihil dolores.	2025-06-02	74aea551-52f9-4f5e-9e0b-79e8c090389f
c670fc02-b499-48d5-8642-d09b99919577	ab2c6c39-d8f5-4af7-b020-e6eafca298eb	19eb8f4e-eb7c-4784-ae9c-d992d1e1370a	Ut ex ullam et dolor voluptatem.	2025-05-31	404af2f7-1947-4686-8e12-8066be6339aa
6184ebf9-9b42-446d-b6b4-827b62b33f36	9a2ec07e-02cd-41b9-a9af-f22e909d0b1a	c3567130-5f32-42dc-85f7-cddd10b583e9	Quae enim est est quia unde.	2025-05-30	5eccc1af-fc58-41ad-90b7-2c47235f6113
f913aa5f-b485-47ce-8a20-6814c4148305	642df5af-cea9-49c1-a820-f60bc0e5f451	7fd94df0-1a06-4540-9042-36e909db2efb	Rerum quisquam cum deleniti sunt aliquid.	2025-06-02	5eccc1af-fc58-41ad-90b7-2c47235f6113
a311053c-ecf5-40eb-9139-3e4d9f092e16	7fd94df0-1a06-4540-9042-36e909db2efb	8e0ecf55-df9d-4a5f-a24d-2613cc41be4b	Earum voluptatem ut et cumque autem.	2025-05-31	5eccc1af-fc58-41ad-90b7-2c47235f6113
\.


--
-- Data for Name: micro_cycles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.micro_cycles (micro_cycle_id, training_plan_id, description) FROM stdin;
431c54f3-11a5-48cd-bbe9-e1bd006f829c	6d627e28-6088-4900-9e97-08909387cdb3	MicroCycle officia
f6a4da16-b8f5-4253-93b9-7f7e5b1389db	21ba4295-ae9a-4a08-bb50-53b4deea95ce	MicroCycle omnis
1ab30f23-2613-445a-bd90-3496df1b7ea3	a1b1550f-ba76-45bd-91f6-a332169eb8b4	MicroCycle maxime
d0723a76-e42a-4095-9d0b-1684871c9efd	81dcab73-2a51-47b5-9c1f-58e71f830793	MicroCycle pariatur
100a1046-99be-4bca-b145-481de8804f69	5642958a-a81f-4d97-a311-ed27b6bfe310	MicroCycle quo
3e97aaec-4195-421f-a857-8437cfa39c71	caeb17bf-7281-473a-ad9b-9a278bd24438	MicroCycle qui
1bbce47f-98af-4865-a7d8-93995d385957	ff7a2937-d771-4dd2-b224-bf828300af5c	MicroCycle ut
3072025b-35f5-4bb9-a526-01608e50e040	7a081b53-b542-4be4-b187-5819e56313f4	MicroCycle necessitatibus
b4d07539-39e6-468e-9460-111a3ba4690c	ce019c61-6be0-4893-acee-782bb8557d21	MicroCycle et
0207eaad-6296-4a55-ba18-0bc483c29aa9	19c479be-f7d2-4a92-8c83-18b790549545	MicroCycle ipsa
5c6e040c-e837-4bc1-bd1c-47e9f271a06a	31aa8533-7066-49f8-b4c1-a2a9e344f928	MicroCycle facere
564e18df-5403-44a7-8d8c-5cdeec642694	7214b6e6-3039-43f1-8198-794729d4e1d2	MicroCycle non
0e1d2c8e-8e37-4467-bd7f-0b635361d756	9e8a7879-3fbc-4336-9692-49cf5f696ffc	MicroCycle ipsum
86174e18-12a0-4ca5-9684-0db0306e5559	90cac6cc-6e85-4dd2-a1f5-c7098afca457	MicroCycle sunt
06955047-1f03-49a7-93ce-2f3b00034373	18d79194-ae3e-4a2d-9c3c-d669d7c68807	MicroCycle reiciendis
c15233df-b65b-44b2-880b-36e0b8d39d9e	03471dd9-56ff-4ad6-ada4-90d27056db8c	MicroCycle unde
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (notification_id, user_id, message, date) FROM stdin;
4ee5ea36-a4ab-4d06-9615-a8f85f019b35	acdfffcf-d93a-4817-87f8-253fc3c4f861	Уведомление: Nostrum assumenda est magnam quis tenetur.	2025-05-29
e164ee22-0b7b-4d44-a299-48b19192a8f9	3b6e1bff-a157-4c5d-a200-b2565c7eb172	Уведомление: Beatae adipisci reprehenderit vel nam sed.	2025-05-28
3dbea478-084f-49df-a78d-6ae3142932ca	e9fc1da8-1c27-4c4f-8d2e-ec6e46550d0a	Уведомление: Aliquam recusandae accusantium voluptates repellendus velit.	2025-05-31
7c06723c-4fc0-4451-9042-aef3ed455797	3edd911b-fcec-4527-9863-46607c8be987	Уведомление: Debitis et fugit non et labore.	2025-06-02
6745e0c1-b347-4520-ba4a-e52065377a8c	ff8a03bd-05cf-4476-9d53-e72527f78b97	Уведомление: Harum voluptas repellat sit itaque vitae.	2025-05-28
3d264947-f4fa-47a7-abb4-86b3ebc1404b	9bec1b18-7ff0-48e8-9f55-ed60e2d4cbfb	Уведомление: Architecto dicta ad inventore quam quibusdam.	2025-05-30
17a87a29-e667-4649-8220-397dfe51521c	15825a85-1d72-452e-9c85-9c281cd2b9ef	Уведомление: Exercitationem eum fugit quis veritatis molestiae.	2025-05-31
50bfa7b9-34e9-4432-a512-4dfcbb009fc0	a0d2dc81-9f48-4a61-b622-3ecded01d8d1	Уведомление: Eveniet dolore et necessitatibus reiciendis qui.	2025-06-01
d464eaa0-d3ff-4da7-9d0f-932eea06c549	1fc48383-ac44-41aa-93b7-cc350b437e0d	Уведомление: Numquam occaecati molestiae architecto qui ut.	2025-06-04
9aaadd66-c8a1-4f02-b614-1cb5f96b9e76	dbc2bc60-18d7-40a5-b6b5-023999f69c7f	Уведомление: Tenetur sit et dolorum porro necessitatibus.	2025-06-04
d9a8bce5-9b43-4e42-b58e-ad5c88855a3f	d105751f-5139-45ae-b658-d321dbf4e961	Уведомление: Distinctio saepe autem adipisci doloribus laborum.	2025-05-28
d62c01d9-ad2e-463d-8f9e-c1220bec008a	e93a12f3-0bf9-496c-8d3a-5d2f42943f3b	Уведомление: Non incidunt minus consequuntur occaecati laudantium.	2025-05-30
29c11adb-4aff-4cb4-a12c-38f70f974c7e	52c84561-4233-4b5e-a662-692571935818	Уведомление: Fuga veritatis praesentium eius voluptatibus numquam.	2025-06-04
50e9f04b-7ddb-486b-9e61-24f9b9984bf0	abb3ff00-aff7-4ecc-8e19-ed23d9d6eaff	Уведомление: Odit sit eveniet autem rerum temporibus.	2025-06-02
69be7be4-a2e2-4977-81c4-fd1a554f7733	588bcdde-f69e-4aa4-9868-777f659b4d82	Уведомление: Ratione omnis omnis officia aut natus.	2025-06-01
f53780f5-f430-4aa1-b274-5a6bafaf4183	86470be7-4cf3-4483-9014-289c012be9a5	Уведомление: Delectus dolor molestias culpa voluptate aperiam.	2025-06-03
94b5dd43-64d2-4a1a-8958-11405f20bad7	e0c84fd2-61b3-44c3-96b2-e320099ff540	Уведомление: Ut aliquid rerum rerum nam dolor.	2025-05-29
4fea237c-979a-44ad-b6ed-fba00e633d9a	9980b872-1ad9-414b-93c9-301e39788bd8	Уведомление: Nemo vitae voluptatibus sint mollitia perspiciatis.	2025-05-29
b7fdbe3e-a468-47ba-b294-49330a5e1480	eb3aaa49-49b9-411e-93ff-3309c3f85033	Уведомление: Odio dolores sit doloremque maxime consequatur.	2025-06-04
2514c916-3a46-4f7e-9e6d-c3bdcd6e5bec	7bd7833c-9ea0-4e04-b9e2-f1bca999de28	Уведомление: Beatae ullam repudiandae mollitia est omnis.	2025-06-02
4c67eddf-c451-469e-b1fd-4b18da53a034	d144b392-0f6b-4a5a-9d47-7404340d3cbf	Уведомление: Molestiae voluptatibus placeat officiis deserunt ipsum.	2025-06-04
1a1617ce-e0f0-4e54-afc0-ed3a9f37cc9f	663eaf77-4ba3-44a1-a7ef-6414810acb3a	Уведомление: Porro voluptatem id itaque beatae ut.	2025-05-27
e28e9b18-c22d-4065-b9fe-31532d075a1f	6cced495-ec1f-4451-9cfa-79303b413ecf	Уведомление: Soluta voluptate sed qui voluptas doloribus.	2025-05-31
bc6abcb7-2026-4f59-b1d7-94eda081a442	dc33737a-36f6-4d37-8e04-9f09279da0f8	Уведомление: Magni quia sint distinctio corporis officia.	2025-05-28
d475beb7-47fb-4779-afb9-e564e8e53da5	4845be0f-92e5-4e55-b00e-a21359b5ca1a	Уведомление: Numquam ut doloribus quasi exercitationem sed.	2025-05-27
eb85ce57-d333-4248-a8fe-c56acd975d56	19eb8f4e-eb7c-4784-ae9c-d992d1e1370a	Уведомление: Asperiores ut non alias earum eligendi.	2025-06-02
71921270-789c-4868-a476-c8a3e1d6cff4	d8c9f3ac-22ea-42c0-b786-87b0b78bbd21	Уведомление: Illo odit aut accusamus unde perferendis.	2025-05-31
06a38428-1e36-4fbd-8e6f-44799a291473	01ce86d4-54d0-40e7-9bdc-db3cd88cf621	Уведомление: Excepturi voluptatem eligendi ad totam sit.	2025-05-27
7ae4a472-6e56-4030-a0ab-51ca78e04729	9fbf1314-b152-41e7-bd83-ab909be70c50	Уведомление: Labore quis praesentium ipsum nesciunt libero.	2025-05-28
d436e1a6-22ac-4349-9534-c68e021aeaf1	32b3c932-48f1-4f6b-9e64-355c7a634b4d	Уведомление: Sed ducimus molestias sunt aliquam voluptas.	2025-05-31
6adc082a-b645-41a2-a3a9-2a4893d310a1	10ac13d6-73ca-4cbf-a5d2-b85403e7faed	Уведомление: Aut explicabo laudantium itaque in et.	2025-05-26
1211480b-6db7-45e4-9a5b-8913abd2a986	d9a3e93c-865e-4cf3-9bee-c313bbe57610	Уведомление: Omnis sed ratione fugiat velit rerum.	2025-05-27
091ba112-5394-489c-8fa4-4362ed24691a	f0fc13f4-13a4-42c2-91f3-d5dffa49d43b	Уведомление: Exercitationem perspiciatis adipisci cupiditate est eligendi.	2025-05-30
6f247b2b-1840-4bb1-8260-01d9629abd73	9a2ec07e-02cd-41b9-a9af-f22e909d0b1a	Уведомление: Aut ullam corporis doloremque consequatur labore.	2025-06-04
4d09ee81-0539-43bf-bb01-cb7e67cad9c9	72b17e5a-a0bb-472a-91a3-b5dbd13caaae	Уведомление: Minima rem ut accusamus praesentium vero.	2025-05-29
23be3dcf-a200-4d6e-96ec-c5ac27673f45	a24788ba-9862-480a-84b4-0ee112eb7700	Уведомление: Nulla voluptatem mollitia sit iusto fuga.	2025-06-02
0852aa85-ac69-4344-8395-097408cde9be	fda19059-e00a-4a2d-b68c-d1a7512f1401	Уведомление: Architecto nobis vel ducimus amet laborum.	2025-05-27
0a672f5b-8e81-42b9-90fe-2e949c86e7f0	f53c0e7f-7f99-4cbe-924f-4a852f225b50	Уведомление: Aut autem dolore non nihil aut.	2025-05-28
9b18b75f-875e-41a4-8260-7fa7ef15f6b0	5cf96c40-3094-4999-913a-e378e31c82e6	Уведомление: Voluptas eaque iure dicta perferendis ab.	2025-05-27
e64c9017-249f-4f7a-8f1b-dd5292aeb43c	854e0483-705e-4950-b861-cb3801c7748e	Уведомление: Id omnis modi aut molestiae quis.	2025-06-03
0831c226-73ae-4a0a-b278-358196c31d7a	d22988e3-453f-4af2-bed8-6b2805dd330d	Уведомление: Aut repellat animi tenetur ut in.	2025-05-30
aebe4a1d-de12-4b7c-bc93-dc44f6c518d4	9f1bbc93-27a2-440b-8410-115241e1cd6c	Уведомление: Debitis quo reiciendis aut inventore voluptates.	2025-05-29
78a619bd-f2a6-4080-beb6-3aacdad5a8df	642df5af-cea9-49c1-a820-f60bc0e5f451	Уведомление: Sunt ipsa ratione distinctio dicta eius.	2025-05-27
f1036e0d-1c66-4c23-8f0a-912541d20b62	c3567130-5f32-42dc-85f7-cddd10b583e9	Уведомление: Enim autem sit dolorem et nobis.	2025-05-27
f7a7de3f-3a3d-4391-a5ea-bb22aeb51006	c1e1b966-9289-470c-838e-c7d706186871	Уведомление: Maxime ipsam voluptatem omnis et temporibus.	2025-05-27
dd3c1e7a-af56-4535-880f-add9717eacf0	8f5ff173-7446-43ca-a127-61e51fb2f744	Уведомление: Repellat et eligendi occaecati harum id.	2025-05-28
0d5cde2a-dd84-4535-ba7b-68d2745cadcb	d8855132-907d-4eca-852f-75d40c6402e2	Уведомление: A est rerum fugit velit ea.	2025-06-01
a288bfdd-f5ae-4346-a19c-a6bf304a0886	62f01ea8-945b-4884-aa68-6c7572c1d78c	Уведомление: Consectetur nobis rerum dolorum eius quia.	2025-06-03
3588cb3e-5e32-4205-94cd-11e7bf9d7ce3	47b41895-741c-4b99-8d93-b7dcf413e66c	Уведомление: Soluta ab eaque sint eveniet repudiandae.	2025-05-28
fbacc7c9-e7d9-4e2f-9a78-27eef5b89b41	8e0ecf55-df9d-4a5f-a24d-2613cc41be4b	Уведомление: Aut est debitis commodi et modi.	2025-06-02
2b2b077c-c474-4cc1-9774-8a8596e13a8e	0e8e8e3e-ea1a-4248-9c1e-62850a4bed89	Уведомление: Odio qui tempore aut quo consequatur.	2025-05-26
8f25cc7b-5c73-4ab8-a537-c1810b1bd7f0	7fd94df0-1a06-4540-9042-36e909db2efb	Уведомление: Cum quam amet quaerat quas blanditiis.	2025-05-26
6c733d0f-4c72-44e6-b629-680fe94c16d5	70ca91b6-ad56-4c89-8bc7-983a763077a7	Уведомление: Neque dolore iure reprehenderit delectus rem.	2025-06-03
91ef1246-0c59-4f97-ade5-8394b7f4d488	bf34227e-cd86-437f-95f5-d48fb096f657	Уведомление: Ut illum aut rem eligendi ullam.	2025-06-02
5ed6a1c3-c2b1-4314-9327-ef43b35e168a	9b72e6c9-d795-40a9-8d6d-abd1150c9aca	Уведомление: Quibusdam eos asperiores omnis repellendus veritatis.	2025-05-27
1ec40b13-1bf9-4d66-abd8-234afd40e51b	cf540071-ebc4-4cf2-95d0-ece5567b6a8a	Уведомление: Quos quaerat sit odio laboriosam sapiente.	2025-05-29
37bac72a-58b8-4e98-a5eb-81a76cf79872	99df127a-484d-44c7-a6e9-d7e744c54053	Уведомление: Vel aliquam repellat eaque vitae repudiandae.	2025-06-01
ec62ca31-29d5-41da-95f1-780f0a3c9b2c	b17e3885-5d00-439a-bb47-e64cca4c9995	Уведомление: Consequatur suscipit quo eum quo cum.	2025-05-30
bdb10ea8-5c59-4992-81ac-641a07bf2629	6c8bb259-f4c1-44c8-bfb2-f33ff0700b27	Уведомление: Aspernatur eaque deserunt labore at aut.	2025-06-01
4a2a9de2-bcbc-4ba7-9b92-54d2439afbbf	ab2c6c39-d8f5-4af7-b020-e6eafca298eb	Уведомление: Optio deleniti odit voluptatem ea aliquid.	2025-05-28
1761aad0-3243-4ef7-8a05-a7440b95cd01	94b334d4-8b5d-4200-b863-730e3c6628a8	Уведомление: Quia incidunt tenetur voluptatem quisquam consectetur.	2025-06-04
ee2d5c3a-83bc-41b4-b4ad-3df8425fc131	bee55ca1-cc5d-4e4a-8d4a-249b86a86737	Уведомление: Tempore voluptas ratione quibusdam accusamus perspiciatis.	2025-05-28
a45bc85c-ebc0-48f3-abc7-f24b30ef39fc	fba1c228-3a75-413e-891e-5bddcffa2007	Уведомление: Quos qui eaque quae minus eveniet.	2025-05-30
bbbf84c5-0bb4-4c68-8a3b-3223ed1ff211	aea78d3a-2b93-4cd1-9b25-c69d5aeba20b	Уведомление: Voluptas quo nobis voluptatum beatae fugiat.	2025-05-30
0804b95c-c691-4ef3-b4a4-55d587ce239b	e56fad7f-f5b5-45f9-82d9-cfa6b761b8cb	Уведомление: Alias et autem quo occaecati consequatur.	2025-05-28
4ffb79a8-fe87-4520-8252-0228cc1894ec	61d282ce-1edd-46d0-8831-801c0f1b82b5	Уведомление: Et eius incidunt et veritatis aut.	2025-06-02
08265870-887c-4c00-8fa8-8a164d5cf9aa	ab9a61bf-60ef-4d02-a79a-e16e1eccd8d1	Уведомление: Illum sed delectus velit omnis excepturi.	2025-06-02
1d39d351-d6df-4da5-80b4-76a15ad50f5e	936a095a-c5ae-4f1a-91e7-58e930d38700	Уведомление: Aut natus ipsam perferendis aut enim.	2025-05-30
955ff732-ab2a-4d82-9946-d9520a534a9d	216e5a26-41c0-42b2-9622-c89c44f0fc27	Уведомление: At praesentium asperiores modi distinctio ad.	2025-05-27
9e0d62f0-7433-4470-b02b-63a7b974f91f	0ff2642e-2f6f-42e2-a0f6-3c0eebcd765f	Уведомление: Doloremque debitis et eum in ut.	2025-05-31
cecfd4d0-0de5-4cab-872f-6d7e1f2b85a2	81419018-a89c-42bb-80c6-3cd70f4fb020	Уведомление: Voluptas unde nihil possimus ex enim.	2025-06-02
ee587b95-aa28-45b0-9351-b39dd9c73634	3164d8d8-2517-4e9b-ac73-84802e3322cc	Уведомление: Qui iusto facere voluptates quidem praesentium.	2025-05-26
94274dc4-d9c8-47ad-927a-ed52b50e415d	648de0b0-332b-4a2a-b6ee-a19b64d20aa7	Уведомление: Repellat laborum officiis est molestiae iste.	2025-05-31
7c661dd0-afab-4486-bdce-fe8e3eee1322	31e3a92a-deef-464c-9a6c-ce2084ec4e77	Уведомление: Distinctio et ea quia quia sequi.	2025-06-04
0975a9dd-09e5-4836-b5c8-bedf85b3e77e	2dd4b7f1-4779-4e95-8276-9a2a5d4db550	Уведомление: Voluptatibus consequatur minima officia blanditiis accusamus.	2025-05-29
25daae81-e10b-4953-b938-cd7ea77f1b94	48117389-3c10-4fee-9b35-172558be8086	Уведомление: Aperiam repudiandae recusandae sed distinctio omnis.	2025-05-26
af4d26d7-a766-4119-8ed9-35878af8175b	bf6506d5-fc4f-4a3e-914a-5ffac04f487a	Уведомление: Aut id omnis praesentium modi harum.	2025-05-29
d6943e78-c8ab-4f7f-ab71-18a550b1b848	4d06c317-d321-4dfc-b52d-a354741fb449	Уведомление: Voluptatibus consequatur ad vitae sint magnam.	2025-05-31
402ba547-7519-49f3-905f-75571b99e448	e186b3a9-9944-470b-9c6e-d2f598fe3bae	Уведомление: Repellendus exercitationem molestiae eos maxime qui.	2025-06-01
5f5c8afb-186a-4404-b7ba-b0cef012c8aa	4b3e8f5c-f3dc-4338-bfb1-145afeabff33	Уведомление: Cumque vel magni et earum ut.	2025-06-03
e30798f1-b006-4879-9b42-8b4978014c2c	15f7316b-4bfc-48e1-b5be-a1b87f731d5f	Уведомление: Quis eaque dolores molestias voluptatem mollitia.	2025-05-27
fcf4db87-0085-4dfa-a702-229c692e280b	52cf3c15-370d-4e6c-839e-e630a358406a	Уведомление: Non qui et commodi veritatis cupiditate.	2025-06-03
ed79f8d9-f570-486e-9f7d-a4b4af670ce7	490eae7e-06ca-4506-ad9d-cadbec707dfa	Уведомление: Magni illo a possimus id neque.	2025-05-31
7de52eaf-06ac-4793-a7e2-0d1fcd053bcb	20c856f4-48fa-436a-9e33-b7286b187a93	Уведомление: Ut vitae doloremque aspernatur eveniet temporibus.	2025-06-01
e00b3abe-ebbe-490b-bc3d-cabc52e06dc9	2e964c4a-cedd-4729-9f12-88022618d7bf	Уведомление: Et consectetur harum voluptatibus omnis fugiat.	2025-05-26
fd7060b3-6fad-4809-9537-37415dfd4436	92a5e639-04f8-4af7-80e1-a7c88cc7f236	Уведомление: Ea qui illo aut dignissimos inventore.	2025-05-31
60885c59-4237-4c4b-a678-ec134ff71bad	5968759c-1e1f-4ec1-9ec7-35148d8950db	Уведомление: Placeat sunt voluptatem laudantium nisi nulla.	2025-05-30
98163496-7090-4dc0-8e97-130405914c23	6694c4ba-b82a-4ca1-a8b1-cc5d35a7a372	Уведомление: Error numquam doloribus voluptas consequatur unde.	2025-05-26
ca3a9a92-f395-4777-bd79-966b73b5966b	bea308dd-bb60-461f-9630-ae77362fcf64	Уведомление: Cumque est sed est voluptate qui.	2025-06-02
f54737db-a0af-49d0-ba59-cfb41e0a2d34	97c1fafa-0067-426c-b760-38318cf928b5	Уведомление: Qui accusamus voluptatem nemo qui in.	2025-06-03
43ce3ed1-e5ae-41db-9bbe-de77ab08c8f1	9324c610-8ba9-4c4e-a811-f9a037eef743	Уведомление: Sunt fugiat dolor porro eius quos.	2025-06-02
70731440-c65c-4937-a8ac-3c587f0ceac5	0eccc020-3ab3-49cf-a218-4bc872002f05	Уведомление: Repellendus aut voluptatem est repellat provident.	2025-06-03
226d50de-bd81-4135-921a-5910be389f4d	dbb087b8-ef56-42a1-a6e4-e3e0fc8afc20	Уведомление: Possimus consectetur placeat nam sit est.	2025-05-31
8b79fd9c-36e6-4196-bd3f-e84f8740afaa	5afd228f-e289-41e9-ac35-8239149a0eb9	Уведомление: Ut error voluptatem et deleniti molestias.	2025-06-01
9884cf9b-40fa-4ab0-be43-797f6517a29c	d424ad49-c85f-4357-b1e8-5a07ef0049c0	Уведомление: Suscipit magni pariatur ex culpa qui.	2025-05-30
afbefc22-10ab-4485-a427-799cce41ee75	bccc0e62-2471-4133-8392-50732c9ec575	Уведомление: Odit accusantium dolor labore voluptas natus.	2025-05-29
ace59681-16dd-4e02-b20c-797fe4d312ec	21e9cc9e-88bd-4d9e-a19e-1363d8c97997	Уведомление: Quia voluptatem quos eos modi voluptas.	2025-06-01
bc09ae34-09f6-491d-bdcf-b7373d9490a4	6dcc02b3-c178-48b7-a534-331ac5613eb2	Уведомление: Qui impedit atque totam dolores sapiente.	2025-05-31
c6b5eedf-7778-4b4e-adb2-60f36d1c3e2c	388d6b07-08fa-4d44-a62b-82f4e570f3f0	Уведомление: Facere voluptatem soluta reprehenderit laborum aut.	2025-06-03
0c71367a-d482-4cce-a6ea-8eba28830606	69a18512-a2b1-432c-a767-b4e02b7e8413	Уведомление: Sunt voluptatibus aut error harum enim.	2025-06-04
\.


--
-- Data for Name: organizers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.organizers (organizer_id, user_id, organization, license_number) FROM stdin;
2b5df83f-49f6-4fd1-9772-199308e1334d	490eae7e-06ca-4506-ad9d-cadbec707dfa	ТехноСервис	81a0:8a4d:c655:cec1:e6f0:c882:c77e:329e
8ac8e5dc-d530-4f32-9862-c92a8e6e80c6	20c856f4-48fa-436a-9e33-b7286b187a93	ЭкоТрейд	1cc:1937:184f:4aae:4214:99ab:8214:ee64
e929409b-0536-43dc-86b8-181df183e64a	2e964c4a-cedd-4729-9f12-88022618d7bf	ТехноСервис	29ea:c57:aded:416f:5e33:277d:6cb0:3d2b
e5d6cd9a-ce35-4513-b812-53251fd5f616	92a5e639-04f8-4af7-80e1-a7c88cc7f236	ИнфоСофт	1ca9:2f84:df47:3494:48fa:f373:85ef:648f
cee87633-4350-408f-bf06-6f0bcd80d84a	5968759c-1e1f-4ec1-9ec7-35148d8950db	АльфаСистемГрупп	37b2:3985:bf23:8762:cbc7:808f:d121:2d17
c0716880-5231-4e4c-8558-743113546603	6694c4ba-b82a-4ca1-a8b1-cc5d35a7a372	ЭкоСофтЛтд	666d:5c2d:54d9:92c5:1af:e7b8:642f:4f81
c08c87fc-10d7-437e-8f2f-b6a20defd0fc	bea308dd-bb60-461f-9630-ae77362fcf64	ТехноСофтГрупп	1d68:19ed:8a:5dba:93c9:6386:461b:97ef
665f1b7c-f2ae-4f36-95f4-ba2f8cb0a258	97c1fafa-0067-426c-b760-38318cf928b5	ЭкоСервисГрупп	f49d:8cd1:30b3:f019:da32:8e0e:9fa6:9988
c28b54f1-a3fd-4165-810b-00bf7d424889	9324c610-8ba9-4c4e-a811-f9a037eef743	ЭкоСервис	a6e4:7486:75a9:f5f1:fb4f:4f27:5097:3ea
1dee1201-0598-45aa-be5f-1ea4aa81b422	0eccc020-3ab3-49cf-a218-4bc872002f05	АльфаСофт	73e9:4326:39ee:876a:a4df:acf4:e45f:1f03
7c3787b0-8cd0-4da2-929d-ec94fae559b7	dbb087b8-ef56-42a1-a6e4-e3e0fc8afc20	ЭкоСистемГрупп	a59f:4ae1:fb39:ea3e:e466:e2be:d130:d0d0
6ed7b2fe-8926-4d5d-9b9e-0daa17ff2925	5afd228f-e289-41e9-ac35-8239149a0eb9	ГлобалСистемЛтд	8333:d5fd:2ae9:8c21:47e:5b78:cc7e:1b71
511a5414-a12d-40e4-8452-e43e144c3e5b	d424ad49-c85f-4357-b1e8-5a07ef0049c0	ТехноСервисЛтд	61f0:df15:71f7:d981:d152:cf76:e4fe:519f
3fc8522c-dc0e-4b2f-accd-dc60e0127633	bccc0e62-2471-4133-8392-50732c9ec575	ЭкоСервис	41c0:bc01:8b57:cc82:af5c:9056:1859:3a06
afa23a8e-6295-4dc6-bda1-9589a5bae687	21e9cc9e-88bd-4d9e-a19e-1363d8c97997	ИнфоЛабЛтд	2a2f:92f9:25f:f651:435c:6a2f:9672:7cf3
69d67748-bc5d-4c4a-88c1-7e9541f56973	6dcc02b3-c178-48b7-a534-331ac5613eb2	ТехноСервис	e52c:e566:b1d1:495:86dd:8e89:fc0f:a4be
ea650628-97c3-4770-aee0-101fb6e2701f	388d6b07-08fa-4d44-a62b-82f4e570f3f0	ТехноСистемЛтд	4b03:276f:6631:9aa:7109:2822:ad83:be0
d5990210-a84f-4229-b63e-41b0771be42f	69a18512-a2b1-432c-a767-b4e02b7e8413	ТехноСистемГрупп	8eb3:94f4:4597:45e:3582:92de:d4e1:e361
\.


--
-- Data for Name: pulse_zones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pulse_zones (zone_id, training_plan_id, min, max) FROM stdin;
96e5b61d-0f39-490f-a9f2-215de223ad16	6d627e28-6088-4900-9e97-08909387cdb3	52	62
6427aed5-820f-4895-8e58-5e83ba7bf818	21ba4295-ae9a-4a08-bb50-53b4deea95ce	82	105
e16a5feb-df04-49b0-a992-29562896bdc0	a1b1550f-ba76-45bd-91f6-a332169eb8b4	87	127
d415b1ad-e3e9-495f-8950-6192c6468a79	81dcab73-2a51-47b5-9c1f-58e71f830793	55	93
31c1bb5e-c78d-4675-a398-88b223c6a191	5642958a-a81f-4d97-a311-ed27b6bfe310	80	128
123984d8-6946-4024-9e64-a37ff49a99f4	caeb17bf-7281-473a-ad9b-9a278bd24438	59	105
623fb11f-e990-4e14-a7dd-d08f3a761d70	ff7a2937-d771-4dd2-b224-bf828300af5c	70	80
2b0b59ef-ffed-4e7d-ba90-32927184dd77	7a081b53-b542-4be4-b187-5819e56313f4	85	107
80facaa0-2eaa-4ff8-8179-fafec9655a39	ce019c61-6be0-4893-acee-782bb8557d21	63	87
e2e9efb4-f22a-4a4d-8bc9-c27e8a13166a	19c479be-f7d2-4a92-8c83-18b790549545	71	117
8602ee9d-2c5e-45d0-a892-6180be617f94	31aa8533-7066-49f8-b4c1-a2a9e344f928	67	110
b622aa39-77af-45eb-8036-2bdc09595b41	7214b6e6-3039-43f1-8198-794729d4e1d2	57	95
c497c394-ca64-4bdf-be70-cbe17185ad3f	9e8a7879-3fbc-4336-9692-49cf5f696ffc	74	92
aad53b48-4c14-4a2d-a048-e5c90279c0cb	90cac6cc-6e85-4dd2-a1f5-c7098afca457	72	103
1a896254-ec89-4e8b-96b3-1baeae9e91c1	18d79194-ae3e-4a2d-9c3c-d669d7c68807	95	128
944d3475-c9bf-484c-8ff1-138241046872	03471dd9-56ff-4ad6-ada4-90d27056db8c	57	104
\.


--
-- Data for Name: rehabilitation_programs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rehabilitation_programs (rehabilitation_program_id, injury_id, description, start_date, end_date) FROM stdin;
951f15e8-fe01-4b69-b40b-72729d1c33b0	2fd77ddf-e948-425c-9ec0-acea89f0501f	Rehab for in	2016-06-24	2016-12-03
5f828979-9f25-4c43-8bda-1f5fed8fc33d	4eaa620a-d94d-41ba-8133-9677b598ae7d	Rehab for nobis	2021-05-01	2023-01-22
9d4bfae0-4487-490f-8eb7-92f712b6ab38	159e98a9-90de-4a1a-b09b-b3a33feff640	Rehab for magnam	2022-04-25	2024-04-17
c526bbb4-5e13-4727-83b7-9f9a97536c87	b9447e17-7bd2-403d-b238-952f1bd89e46	Rehab for quam	2015-07-04	2016-08-13
3fc26792-1bcc-4f19-a1cc-cc536b938170	d23ad13f-8a4e-4ac1-9b45-467430455a34	Rehab for autem	2013-03-21	2015-09-11
6ebe5bda-f248-4b9f-b75c-2c075027bb7f	b3518065-c9b8-46bc-9a8f-a78d954ce54a	Rehab for necessitatibus	2013-11-25	2015-04-08
10e85162-bc6d-4c5e-a9ea-d29d4f2899d7	cb1290a6-8a35-4c44-82f1-117882c330ef	Rehab for accusantium	2011-07-05	2013-02-14
19c80bdc-c674-408e-bb59-a09e7e2271e9	a25b1b13-23a2-41e5-815e-bac73decd9ae	Rehab for ut	2011-09-03	2012-09-26
30a2dd63-5ae5-4258-9859-b2ed4111cd0b	aa502e31-73e6-4289-8912-bd87c476e2bd	Rehab for soluta	2009-04-04	2010-12-07
e291c8c1-05d7-4d17-8cb1-c8768ad037a3	b5a2893f-ebfb-4f13-9013-eaa63a3d2281	Rehab for est	2011-08-02	2012-04-22
25828d1b-6aad-4f24-8d0c-88465733e3ce	3cf7a3ec-8f4d-46bb-98cc-405eaab10e39	Rehab for sapiente	2016-06-03	2018-06-12
c78a0fe0-0491-45d9-8ea6-30d4147548f6	74f2c880-d48f-417c-ac41-36fd6f6e3c0b	Rehab for ut	2015-08-01	2015-04-19
839b3704-cbf7-4295-9414-6b96da8a278d	0058d938-8386-4a47-a31d-a7d51ada2df9	Rehab for numquam	2020-12-21	2020-05-04
510682f9-6c22-4f38-9011-8a5226178427	761d5869-73fa-4560-a7d2-850e6df875c2	Rehab for repudiandae	2012-03-13	2013-12-23
11a63dec-3eec-4d0f-8e39-c94b29718901	8986fc43-7c5b-4ad4-b6cc-db9f075e587b	Rehab for recusandae	2012-06-05	2012-04-05
7ce3a1c8-ba4c-47c5-a1b4-8b35dea1c1d8	e5ad79ec-7566-447a-b450-9c25553df05c	Rehab for laboriosam	2014-10-24	2016-10-23
9b58b645-e4dd-4783-8c41-2598562bdeb8	01c58269-2e78-469e-a625-a4bd419ff792	Rehab for vero	2010-07-03	2010-05-25
ab6982e6-f6e0-4e86-83d7-a5a347ad7ea9	b8d6c529-b02c-4f73-81e1-ea3a634b00ec	Rehab for odio	2018-04-01	2020-03-02
2b5613b1-8309-4c9c-a278-c1375ec7244e	a6a1fff9-9274-40a4-9c80-a77f9be0d411	Rehab for architecto	2019-03-26	2020-06-09
713411e5-8626-41cd-a5f9-f5dd051d92c2	4c1358ec-02f7-4c39-952e-91ff0272e0e9	Rehab for eveniet	2012-07-12	2014-09-09
8d248f51-d54f-46ea-9e58-02dc3c036c19	bc525662-0964-479e-a83f-e155bedf4208	Rehab for id	2017-10-27	2018-06-26
dd07f06f-572d-4c2b-acfa-20248d825cb6	d9906567-2881-464f-b38c-079fa06209e1	Rehab for et	2017-08-20	2019-12-14
3d480db8-518e-4198-9582-7f8d75725648	90e128df-a824-47ae-b203-1c69701a2596	Rehab for facilis	2015-09-09	2015-05-21
4180b34e-7fb2-4c64-8037-02a48e1c52e8	0ba60a33-8f08-4750-b8f3-eb8072e21f78	Rehab for nulla	2013-09-02	2015-06-21
63a098f6-1645-4c10-a61d-3abbffd79f81	2a6feba9-cd9c-4c65-806c-78f934b37f9d	Rehab for sint	2006-06-15	2006-01-25
2ec71e3c-892e-4ca8-94fc-78555d8dfddf	57122ceb-f2ff-48ea-b745-da6e10aa4305	Rehab for dolore	2012-04-13	2013-02-27
e6c4bf19-3b9c-488c-b16c-b1890b3db91d	618430b9-4506-4c53-81b7-a6f62b3e38fe	Rehab for ducimus	2012-08-13	2013-07-13
f8628731-28bd-4aa0-90d7-c7e85e4251f2	e23825f2-76cc-4752-a95f-58ba8667a138	Rehab for et	2009-06-02	2009-12-25
030ac439-6d2e-4d58-896e-a96001665399	1c6720b0-21d3-44fd-a84e-8f8bcab4dad5	Rehab for est	2024-08-07	2024-12-12
1f1017bb-f700-41a5-b529-697ab2f11da4	0c0bf659-f381-4593-aac4-0e488df9cebc	Rehab for consectetur	2010-10-24	2011-07-02
9dec94da-d6db-43bf-8b48-e135b0926ddf	9eaa5edf-ac6f-46e1-8757-98c6e2026fd4	Rehab for deleniti	2009-03-15	2009-04-23
d3407973-3a76-43fc-a011-6ed127bc7806	925d8b9d-4929-4561-b87b-37caba1201a9	Rehab for quibusdam	2014-11-10	2014-05-03
4ab8c601-ef30-4400-b93a-24d6afcdf497	1c55b019-dca5-4727-bcf2-62a55707a47a	Rehab for ipsum	2021-07-12	2021-11-17
\.


--
-- Data for Name: schedules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schedules (schedule_id, competition_id, event_description, start_time, end_time) FROM stdin;
a6b0d80d-09f3-443b-bf40-6c8af8733360	b3216109-3f13-480d-85c4-c5339d358ab9	Этап excepturi	2025-06-06 01:01:19.366183	2025-06-06 02:01:19.366183
49fb6e84-cfae-45c2-8a77-37fd7dd6caf2	b3216109-3f13-480d-85c4-c5339d358ab9	Этап consectetur	2025-06-04 16:01:19.37007	2025-06-04 18:01:19.37007
047f2ea5-9aaa-4494-ba28-a5702f9a7476	bce3092e-6b2f-43c1-936d-58b768f6f327	Этап illum	2025-06-04 15:01:19.373168	2025-06-04 17:01:19.373168
76456577-92e2-4786-b744-6f513ed9166c	bce3092e-6b2f-43c1-936d-58b768f6f327	Этап et	2025-06-04 12:01:19.376366	2025-06-04 13:01:19.376366
66d178ee-2650-42b3-8fc0-b0291166b670	874a9209-6751-4a72-b9be-5ff8e5f295b8	Этап voluptatem	2025-06-05 18:01:19.379401	2025-06-05 19:01:19.379401
e5cc6c1c-1dfb-4313-a80c-6c100cd741aa	5de02e63-9f70-4d2d-8be5-2f3892595dc6	Этап architecto	2025-06-04 15:01:19.382554	2025-06-04 17:01:19.382554
30e89043-d10e-460b-8b01-34cadcd826a6	5de02e63-9f70-4d2d-8be5-2f3892595dc6	Этап laudantium	2025-06-04 19:01:19.385646	2025-06-04 21:01:19.385646
8c0ff5e8-b711-4a4e-b3eb-6e49e5b91bde	607d38a5-08a7-493e-b5dc-6f543f3f0530	Этап consequatur	2025-06-05 16:01:19.388567	2025-06-05 17:01:19.388567
68195a9d-f647-441c-8707-bf0679e36f8a	987876e1-e4f9-46fe-a136-292eaf5f131b	Этап quibusdam	2025-06-06 05:01:19.391585	2025-06-06 06:01:19.391585
871ceff5-5016-4771-96f7-21632cad4ce9	987876e1-e4f9-46fe-a136-292eaf5f131b	Этап accusantium	2025-06-05 22:01:19.39474	2025-06-05 23:01:19.39474
a0aae4fb-fccd-4f60-8659-00029fcf77a5	987876e1-e4f9-46fe-a136-292eaf5f131b	Этап recusandae	2025-06-05 21:01:19.397869	2025-06-05 23:01:19.397869
e5649608-6068-429a-bcff-5bd79ca8a8b1	c1cb5834-eaa3-41ad-8c9a-b858a4d0d233	Этап sequi	2025-06-05 04:01:19.401082	2025-06-05 06:01:19.401082
6b5f500e-097f-4b3a-89fa-b777e1602167	c1cb5834-eaa3-41ad-8c9a-b858a4d0d233	Этап dolores	2025-06-05 08:01:19.403953	2025-06-05 09:01:19.403953
dfe81784-7768-4512-9942-306ca0f00094	c1cb5834-eaa3-41ad-8c9a-b858a4d0d233	Этап voluptas	2025-06-05 21:01:19.406913	2025-06-05 23:01:19.406913
e4879fd6-0b85-46a3-9f90-b1a162ebf5c9	3bd14fe7-af8c-47fe-888a-14e2103d23a4	Этап ipsum	2025-06-06 00:01:19.411853	2025-06-06 01:01:19.411853
8b18f514-4103-4fb4-b5f5-91d546eb298b	3bd14fe7-af8c-47fe-888a-14e2103d23a4	Этап eos	2025-06-06 06:01:19.415057	2025-06-06 08:01:19.415057
241593f0-1cd0-40bf-97b6-00d5f056607c	dca5717f-d71c-4be3-90db-4fd06e5a74a4	Этап reprehenderit	2025-06-04 19:01:19.418108	2025-06-04 20:01:19.418108
7947ae50-072e-49a9-b65c-f4f369316e92	dca5717f-d71c-4be3-90db-4fd06e5a74a4	Этап quae	2025-06-06 07:01:19.421048	2025-06-06 09:01:19.421048
2f0aa0f2-12db-4725-a4dd-3912fc6bb1df	14eea280-f55a-4a15-ab0e-afdbce799216	Этап esse	2025-06-05 23:01:19.423905	2025-06-06 01:01:19.423905
03ca1f6f-69e3-4b5b-88fa-69b71d403d5f	14eea280-f55a-4a15-ab0e-afdbce799216	Этап eaque	2025-06-05 23:01:19.426942	2025-06-06 01:01:19.426942
4eb47842-7d5a-493d-808c-15c1f6870600	96439dc7-c1d0-49b1-8a89-3262196a81ad	Этап provident	2025-06-06 02:01:19.429778	2025-06-06 03:01:19.429778
240e2bb5-2fb7-4216-af76-f9cc744f5985	96439dc7-c1d0-49b1-8a89-3262196a81ad	Этап rerum	2025-06-06 04:01:19.432809	2025-06-06 06:01:19.432809
4392e8b8-1f17-430d-a12c-1e3168adfcae	63fa3904-8855-40eb-8cf5-c01d80e0fa19	Этап ipsum	2025-06-05 08:01:19.435948	2025-06-05 09:01:19.435948
4bfb780b-e603-4ea7-89b3-d4066f3a3b91	a38b4271-2e58-40a2-a825-d5116b705634	Этап error	2025-06-06 06:01:19.439162	2025-06-06 08:01:19.439162
bfbcb54c-196b-49c0-a5bd-d1865b9df831	a38b4271-2e58-40a2-a825-d5116b705634	Этап esse	2025-06-06 09:01:19.44197	2025-06-06 11:01:19.44197
1762bbf5-3a91-4006-ad7c-cebdc0e68312	6a95bc88-b42c-4ed9-81a5-157dec755085	Этап asperiores	2025-06-06 05:01:19.444901	2025-06-06 07:01:19.444901
c01b808a-2ba4-4d0f-9434-a305f33625c7	6a95bc88-b42c-4ed9-81a5-157dec755085	Этап magni	2025-06-06 02:01:19.44795	2025-06-06 04:01:19.44795
a6100e42-4234-40ed-8978-91f177572445	4540370e-43ad-410e-aecc-2fa2c2082a03	Этап maxime	2025-06-05 06:01:19.450835	2025-06-05 08:01:19.450835
e5323ee2-36bb-43aa-803f-29772cda2e5f	4540370e-43ad-410e-aecc-2fa2c2082a03	Этап nihil	2025-06-05 16:01:19.453604	2025-06-05 17:01:19.453604
f5befdba-6597-410c-a9ce-8aca5c21f222	f54d8923-70c6-4983-94d5-1fc634befe2e	Этап quo	2025-06-06 09:01:19.456692	2025-06-06 11:01:19.456692
40bcaf13-1967-46da-8896-77f67b8be35a	f54d8923-70c6-4983-94d5-1fc634befe2e	Этап dicta	2025-06-06 03:01:19.460118	2025-06-06 05:01:19.460118
52a56e40-4b1a-4306-b63c-210e941e5c44	18038d48-ba3e-44d8-af9c-c15ebd59b53b	Этап quia	2025-06-05 23:01:19.463427	2025-06-06 00:01:19.463427
2f08bf42-7ab3-4309-afbd-348696aec2f2	18038d48-ba3e-44d8-af9c-c15ebd59b53b	Этап dicta	2025-06-06 03:01:19.466453	2025-06-06 05:01:19.466453
6647dc8c-534f-4f97-80e0-53261fe00300	18038d48-ba3e-44d8-af9c-c15ebd59b53b	Этап laborum	2025-06-05 16:01:19.469667	2025-06-05 18:01:19.469667
d3437018-3a74-4d75-a76a-4fde05a814cd	f7ea919a-0a7d-4748-a2ca-4e02a7089a4e	Этап molestiae	2025-06-04 13:01:19.472875	2025-06-04 14:01:19.472875
de871b51-6201-40fa-8f81-d166ef752cfe	f7ea919a-0a7d-4748-a2ca-4e02a7089a4e	Этап ut	2025-06-04 18:01:19.476154	2025-06-04 20:01:19.476154
\.


--
-- Data for Name: training_plans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.training_plans (training_plan_id, coach_id, name, goals, intensity) FROM stdin;
6d627e28-6088-4900-9e97-08909387cdb3	bb4cb1fc-f530-4120-9b9f-4030e3d231d9	Plan voluptas	Goalvoluptatem	Intens possimus
21ba4295-ae9a-4a08-bb50-53b4deea95ce	3f3c69c0-16c5-43e5-a2ee-e3521a8bee5c	Plan officia	Goalaspernatur	Intens voluptatem
a1b1550f-ba76-45bd-91f6-a332169eb8b4	aa5a4c3f-85e1-4330-98dd-07a586978a87	Plan totam	Goalquia	Intens ipsam
81dcab73-2a51-47b5-9c1f-58e71f830793	097a231f-9a98-4d8c-9da6-6720df2fcf52	Plan rem	Goalullam	Intens quia
5642958a-a81f-4d97-a311-ed27b6bfe310	eebcc6df-9dc9-49d6-8e38-9e2b20d0123a	Plan quod	Goalipsam	Intens labore
caeb17bf-7281-473a-ad9b-9a278bd24438	e235f796-9500-4f50-b1e5-6952c4fb8381	Plan ipsam	Goalut	Intens qui
ff7a2937-d771-4dd2-b224-bf828300af5c	a814bb3e-6ddf-4b45-9f6b-bed80971f5ce	Plan eos	Goaldolor	Intens nesciunt
7a081b53-b542-4be4-b187-5819e56313f4	98b861b7-9bc4-469c-8882-2100d4acc966	Plan tempore	Goalenim	Intens officia
ce019c61-6be0-4893-acee-782bb8557d21	4ee0c506-25df-4217-8b78-ddd39fd6e30c	Plan porro	Goalquas	Intens accusamus
19c479be-f7d2-4a92-8c83-18b790549545	85fa4bb3-8675-46c3-81b3-6c98760d91c1	Plan et	Goalquaerat	Intens velit
31aa8533-7066-49f8-b4c1-a2a9e344f928	d4fef24d-fe5a-437c-bb4f-51d564f6dcea	Plan non	Goalvoluptatem	Intens neque
7214b6e6-3039-43f1-8198-794729d4e1d2	e0ec283c-e3ef-48b5-a054-0eafdd41e921	Plan omnis	Goalveniam	Intens nam
9e8a7879-3fbc-4336-9692-49cf5f696ffc	d7f6784a-8939-404e-9dfe-fe0c11eb459c	Plan et	Goalut	Intens consequatur
90cac6cc-6e85-4dd2-a1f5-c7098afca457	be38dc88-9a42-40a3-9914-232aaa16ee7d	Plan fuga	Goaldolor	Intens consequatur
18d79194-ae3e-4a2d-9c3c-d669d7c68807	3fc98f3a-ae5a-4783-a602-f5b6ebdce5d1	Plan nihil	Goalplaceat	Intens voluptates
03471dd9-56ff-4ad6-ada4-90d27056db8c	8f10afa1-db1d-47ec-a806-4016a65962ef	Plan eum	Goalautem	Intens magnam
\.


--
-- Data for Name: trainings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trainings (training_id, athlete_id, training_plan_id, date, time_spent, average_speed, max_speed, distance) FROM stdin;
d1559d0e-9d10-4186-a36a-f168ad75c84d	ad059698-d6de-42a7-af6d-6e3cd5a80846	7214b6e6-3039-43f1-8198-794729d4e1d2	2025-05-07	01:32:37	13.913293349197069	14.407757814935051	6.2880874741855335
f49239c7-f384-4171-85b6-288777f3674e	98e78db7-fe89-45ea-a6f6-670350546c61	caeb17bf-7281-473a-ad9b-9a278bd24438	2025-05-07	00:37:55	5.121628105105509	9.13643556421371	7.4757527418202345
0b1932cd-769d-46d9-9d88-9ff51e640fdd	6f28b3fa-7e7b-4c66-823e-a1efd7993886	caeb17bf-7281-473a-ad9b-9a278bd24438	2025-05-19	00:52:08	5.5354567452121906	8.968132566623142	3.532752113981125
09d9e681-5d01-468f-a395-6ead8edd6de9	953cd6cf-72c3-4ffa-98c2-eb96e96c35bf	03471dd9-56ff-4ad6-ada4-90d27056db8c	2025-05-18	01:58:50	8.749941173322537	9.123744975057898	2.795841698087102
520bc736-3d84-4146-9418-30e6a578b3ec	fc39f40d-e36c-4167-9de3-fe95b8ee2936	ce019c61-6be0-4893-acee-782bb8557d21	2025-05-21	00:58:34	11.784721519150287	16.69489927756731	1.3840962522006521
a6bc5ae9-7e25-4031-b238-8ba0af015de9	d622497b-0202-412e-b0b3-19d125499c0a	03471dd9-56ff-4ad6-ada4-90d27056db8c	2025-05-17	01:28:15	11.574429858989033	12.768944578242305	2.3831815187682013
8ecfb0ff-5025-4b5b-b8d5-9addd7ba036a	3a4572b7-0b21-4f81-8052-0192e1fd87f2	90cac6cc-6e85-4dd2-a1f5-c7098afca457	2025-05-06	00:18:13	8.32211777676299	11.46033193027962	6.831472592366483
99a541d2-37e4-422b-8ca2-4adac04f16b5	4377f770-933d-40da-b890-094dc68a3d7e	5642958a-a81f-4d97-a311-ed27b6bfe310	2025-05-11	00:58:48	6.296460080169988	9.226663480369922	6.144937488532467
a971882b-7e45-4cda-9819-2835eb59c398	98be8fb8-c108-41f5-9784-500225d7df73	7214b6e6-3039-43f1-8198-794729d4e1d2	2025-05-23	01:55:23	14.407603102010018	17.002489852112067	8.780222101386496
e426ea6b-2683-46c5-b164-e9f434e4eac0	1de452c3-d6a0-4013-b6a9-7823d32caa1e	9e8a7879-3fbc-4336-9692-49cf5f696ffc	2025-05-24	01:01:16	5.7049282425296015	8.186633750689555	7.310960633373113
87d3283a-1688-4827-a016-b3aa18a6d87a	131064a7-47f4-4242-80c1-44661e6f0df8	a1b1550f-ba76-45bd-91f6-a332169eb8b4	2025-05-21	01:25:42	12.594058138980735	15.519029450448555	10.676565367057595
c85f0545-5d0c-4eea-b4b0-13d74f84f91d	48f8b0c8-3b66-4f02-bed0-47427f33c1e0	18d79194-ae3e-4a2d-9c3c-d669d7c68807	2025-05-15	01:04:43	5.997491188515866	7.716713675064242	7.5122233670862535
05d9a869-8150-445d-bf0c-e5d25de621c4	4f7f13fe-f7f4-47f8-adcd-624ed032c498	19c479be-f7d2-4a92-8c83-18b790549545	2025-05-06	00:19:53	10.969843182580455	13.068776109251845	10.671707773073356
dfe4c597-5100-45fe-b71d-d5e5f8af8db4	32620980-8215-4340-a976-50ce6cb74e20	18d79194-ae3e-4a2d-9c3c-d669d7c68807	2025-05-12	00:52:05	13.984842232695904	17.524203762998646	9.905688181186042
76d13745-1b31-4117-8840-5bb19176ec61	ba8f8660-ae06-42c2-8131-e19ebd96dabd	90cac6cc-6e85-4dd2-a1f5-c7098afca457	2025-05-09	00:46:24	8.281581406197521	12.572829869063796	10.90080862632068
eb94432b-7129-47c9-9d8b-6f59ff490f33	ad6c6a84-da64-4ca0-a0d1-c56b692b66e2	21ba4295-ae9a-4a08-bb50-53b4deea95ce	2025-05-29	00:56:05	5.6888969892845225	8.178505506763496	9.790633855221198
9b1f1b9e-8029-4cff-9ce7-f23fd84e0207	dd151103-5216-4652-b088-8b801f33f90e	21ba4295-ae9a-4a08-bb50-53b4deea95ce	2025-06-02	00:49:17	11.747751894872406	12.233440370539334	1.899687547545469
b2b63667-b34b-484a-b746-8aacf1d203a6	0320789b-2cc9-4e68-a63f-fcb3b6bbd1f3	81dcab73-2a51-47b5-9c1f-58e71f830793	2025-05-30	01:17:51	6.253075690443259	10.87231192827628	6.073542371671888
8dd8418b-a0be-4a07-84dc-c7b509786b28	e8ed0b59-2464-46d1-a3ea-760a861c2cfa	a1b1550f-ba76-45bd-91f6-a332169eb8b4	2025-05-31	01:48:27	8.930471609170812	10.133776508127415	7.15332452680332
522433c4-60a4-458b-878f-0e86ba491331	79f33da8-d2c1-47e5-8b55-a6817791e851	ce019c61-6be0-4893-acee-782bb8557d21	2025-06-01	01:11:43	12.401167310304887	13.584734210706085	8.678397749795982
f7639873-dbcc-4a40-8763-8cbe254b382f	9d292bb9-aaac-4fbd-9500-9404f6052c3b	6d627e28-6088-4900-9e97-08909387cdb3	2025-05-27	01:10:33	12.776452994342813	17.29978429943484	9.768683916677409
34a7225c-b3d0-4053-b9cd-8bd6ec994582	26bbe248-334f-4642-91b1-4074c81a76b8	a1b1550f-ba76-45bd-91f6-a332169eb8b4	2025-05-18	01:38:51	11.82414947310052	14.63347412101606	8.773861970310195
9d0a1303-c64a-42f3-9cb3-a01f83d7556e	5ed4532b-b825-4095-8e54-2cd72b9b3cd3	03471dd9-56ff-4ad6-ada4-90d27056db8c	2025-05-26	01:51:21	9.532169976514105	13.533044875648429	3.7010660681456846
b894e378-6228-4ed9-832f-74d793b7ee80	3781d7b2-ebe8-496b-b595-7c6df03dbc6b	a1b1550f-ba76-45bd-91f6-a332169eb8b4	2025-06-02	00:27:11	12.970621373721825	15.245215093486589	5.431796183116375
9d672d87-a99b-4ef6-b569-f15886289b65	f01255a1-b841-4431-b871-ce578e5df7bc	7a081b53-b542-4be4-b187-5819e56313f4	2025-05-31	00:00:44	13.38603579606253	16.081427846646122	8.901223016436603
1dbaaa51-004e-4b77-a4f8-c7a2e87a7a9a	bff1cbed-6310-4771-bc66-4250edc8b36d	caeb17bf-7281-473a-ad9b-9a278bd24438	2025-05-24	01:25:29	7.824862069603196	9.834778980658779	8.939470295635537
41b0eca9-24c9-4e60-8846-1b3897a6009d	640c5882-ca7a-4e1e-b35f-dc744816cf19	5642958a-a81f-4d97-a311-ed27b6bfe310	2025-05-15	00:36:17	11.373650701753125	13.571190682067243	4.56338593104887
0ac0ffd1-d3e2-40cb-ac64-3fb418234084	1c0920bd-9da6-458f-8160-f1bb63f79110	81dcab73-2a51-47b5-9c1f-58e71f830793	2025-05-06	00:42:49	14.292146443827482	14.724722297103657	5.964471213211008
1d09e1e1-2a4c-498d-bfb8-f6354365ad8e	ed01eece-7ca3-4431-9dc1-c3e05b075317	18d79194-ae3e-4a2d-9c3c-d669d7c68807	2025-05-30	00:30:19	7.603881218890436	12.088418257553396	4.8318740429616405
ab30a383-4881-49d8-bbf2-a1a6f8b51db2	21632412-e2ea-4a43-affd-31d60c58825a	ce019c61-6be0-4893-acee-782bb8557d21	2025-05-23	00:56:23	9.135245085413509	10.768646168944253	10.118691019333225
5397b928-a0d3-4bd7-9b22-9d41702a59ce	637fc7e1-b31f-4919-8aa9-56a5d18a867f	31aa8533-7066-49f8-b4c1-a2a9e344f928	2025-05-13	00:13:41	7.15357021230299	8.1404910808068	2.020299005431456
4ac907c5-0da1-4615-912b-f92acc7a2d78	b2aa6266-a156-4b7b-a082-3ed6be62b785	19c479be-f7d2-4a92-8c83-18b790549545	2025-05-13	00:04:19	8.813834327023802	12.805849586294567	7.23722877805855
7519f70c-7dd8-4f7a-b611-5ea606bfca65	af4cef5c-fcfb-4d9e-8311-5f2afbcc4822	03471dd9-56ff-4ad6-ada4-90d27056db8c	2025-06-04	00:52:56	6.903945115038265	11.145825168384487	6.552996970318605
5b80bc3a-d997-4d5f-95db-f9ef1b83d826	c7db9c19-8c24-4e5f-a4e6-58e7d3cf7e7b	19c479be-f7d2-4a92-8c83-18b790549545	2025-05-29	00:56:57	11.41895217648723	16.395315707119327	3.0723403412553725
f258852d-89ff-4c7d-827b-ca454e944377	c807894f-400a-4f5a-a8c5-16a058322b5a	7a081b53-b542-4be4-b187-5819e56313f4	2025-05-21	01:51:38	5.891888864950595	10.174433286963243	10.977567547798847
df863201-e8a4-424e-b9f6-adb1f4e1a03a	c4b5132b-0f2f-49f8-95fe-8249386a0c4d	03471dd9-56ff-4ad6-ada4-90d27056db8c	2025-05-28	01:11:03	6.1469965104917	11.006413865306744	1.7056976751617268
9c97ba6d-c2de-45c7-82c0-27c0706c0332	3b22f48a-507f-4125-80fe-14fb35f79813	ff7a2937-d771-4dd2-b224-bf828300af5c	2025-05-28	01:53:25	9.879216177856271	10.54097489173892	10.685405425417432
e046f72e-8a6e-418d-907b-26a91ea08ae1	3f3e7100-37be-4cca-bd2b-50076fbf6433	caeb17bf-7281-473a-ad9b-9a278bd24438	2025-05-30	01:50:45	7.347523324314402	11.669860747931427	6.752853253767803
e82fe4d2-d583-4673-9692-5cd17747554c	5b488f6a-ec5f-4cd7-b33b-07df4f1ad686	ce019c61-6be0-4893-acee-782bb8557d21	2025-05-17	01:25:42	7.038177525826713	8.288408634020627	6.4524811600417635
3750e77d-4e6f-4396-89a3-9fc375d17dae	aaa8eaa2-2de4-483d-83dd-cacddd9c8ca7	90cac6cc-6e85-4dd2-a1f5-c7098afca457	2025-05-06	01:09:00	12.54027669644465	16.99420628120637	9.954640716530896
6aeabf13-6ae3-41cb-a91b-3e80967638cb	b03e2327-e236-416b-9a48-1f1d399b0f2f	6d627e28-6088-4900-9e97-08909387cdb3	2025-05-13	01:08:44	9.86662658892378	11.09317504702825	8.481465506251695
a8ab4179-f2ed-447e-8fc9-cfcbd07d44be	5c1f7521-a44d-41d7-92d2-0cc010634b51	7214b6e6-3039-43f1-8198-794729d4e1d2	2025-05-19	00:49:43	11.869218779549374	13.362517889839603	8.227175158709974
ea69ad69-e401-4e7c-94d1-d814e22b87ff	591b5c8c-6e59-4ee3-82f3-ac750a58f9ea	7a081b53-b542-4be4-b187-5819e56313f4	2025-05-09	00:47:47	13.322839450869589	14.652325482424228	3.364784448953336
63f9dad0-99a5-4670-a1dc-0cac51be64f0	7ccc9074-d6a7-41d7-8c78-888af1a02f64	9e8a7879-3fbc-4336-9692-49cf5f696ffc	2025-05-14	00:48:23	14.628638388508925	18.208843958375326	7.410423289301871
05521a11-ae50-4ec7-b544-71052e2dbb11	6bcfbadc-3ad5-4aa2-b0fe-7bf822a0e348	5642958a-a81f-4d97-a311-ed27b6bfe310	2025-05-29	01:52:38	12.019778605424019	13.537208545065937	4.477554810318269
ae750576-d2ca-4c79-8ed9-821208f2377a	4e94fb48-87cf-4ea2-afe4-dad85b86803d	ce019c61-6be0-4893-acee-782bb8557d21	2025-06-02	00:43:21	10.118311078984771	12.791747467960278	9.212084267280309
cf3eb922-7489-4fcb-a916-c1514c962f6a	8a6ecf81-1721-463f-a801-2a3b90146a43	81dcab73-2a51-47b5-9c1f-58e71f830793	2025-05-18	00:25:46	9.417914570896734	9.939106936136787	4.963176054512587
9d3f10b4-8b17-4025-a935-ad703c181940	1341ba9e-9910-4ad7-a5dd-d929791400a0	18d79194-ae3e-4a2d-9c3c-d669d7c68807	2025-05-07	01:36:37	14.928787356001848	16.30687349323834	10.508234758571383
9e7d6c77-b7a3-4f0d-a24d-77f0c42cc9d7	05d49901-ba9b-4697-8ff4-e7b40e298398	90cac6cc-6e85-4dd2-a1f5-c7098afca457	2025-05-26	00:30:38	7.034901593266562	11.66411079004489	6.8976951891102845
0a24d693-e957-4c5c-adbd-8957ff275c5a	7d9dfa62-28c8-4bb0-a163-a0cb871ef3fc	03471dd9-56ff-4ad6-ada4-90d27056db8c	2025-05-13	01:48:25	7.0748735389622155	8.027234960193352	5.6744375575375985
1811b701-6d6c-46ee-8a46-94c17e09b76c	810089bb-05f0-44c4-bd74-2c7ba11f204c	7a081b53-b542-4be4-b187-5819e56313f4	2025-06-04	00:03:28	5.859410146491611	9.41979348325156	5.8521150374257775
b35b48d8-6eee-493f-96a2-077c5cd72ac3	f34e0e68-b2c1-4d38-aafb-1a6be7f98db0	19c479be-f7d2-4a92-8c83-18b790549545	2025-05-07	01:11:32	9.092243739891511	11.291066178441783	7.864093322156142
94ecc2b8-9199-43a7-9b2f-1737fed8d704	0379ca12-1fb4-4f34-972f-7808d3917ac9	9e8a7879-3fbc-4336-9692-49cf5f696ffc	2025-05-26	01:52:23	12.52683698959706	15.297698777740642	5.156834564223286
8f228364-0418-4df0-89d5-5a00e7087aec	d197f940-9bdb-48a1-be54-70e86ba92aaa	81dcab73-2a51-47b5-9c1f-58e71f830793	2025-05-07	00:32:25	6.295319085690073	9.872683422374042	7.993157420112121
6beb87f5-efd8-42a3-b197-5fac07c75fb5	8012d9bd-f2b5-424a-b1f2-a81fa3d853da	ff7a2937-d771-4dd2-b224-bf828300af5c	2025-05-22	00:41:16	7.854370944731426	7.90366799779116	5.161751867280715
32d1fc0e-e6da-4322-9324-0e6a2b1b6da6	b89c07b4-0c57-4077-9535-e678989422e5	caeb17bf-7281-473a-ad9b-9a278bd24438	2025-05-18	01:18:55	14.593056016455293	19.585804502419006	1.6981057007948024
92fc9e26-2f6e-4441-8477-d0855c9da1cf	b77f011c-4c73-4659-916b-c7d91ed8667b	19c479be-f7d2-4a92-8c83-18b790549545	2025-05-14	00:17:43	9.46258556906615	13.556945734098292	10.299102833552643
9513d5b0-be01-4dea-9abe-8db3957d1349	b1a706a8-448d-4a86-857c-877b3d36a909	21ba4295-ae9a-4a08-bb50-53b4deea95ce	2025-05-25	00:18:30	6.600243113312686	11.449235751169187	8.831647150069733
18d72505-0726-4bfc-a49d-23a2120c6610	caf1758c-d025-4d5e-aea0-8a9cf858617c	90cac6cc-6e85-4dd2-a1f5-c7098afca457	2025-05-14	00:02:00	8.777769820553583	13.131636640090765	6.254610389920856
c65d0ce6-fc09-4382-aa65-af0433c27b0f	67806c4a-b344-45b6-90dc-96e256a46db8	90cac6cc-6e85-4dd2-a1f5-c7098afca457	2025-05-06	00:11:01	9.434415650838373	10.068671054560035	1.737908732425344
8ed0a690-6a9a-4116-a759-be36f1e652fc	c0ddf7eb-77a3-4fda-b3fb-ecb3d3e6daf6	90cac6cc-6e85-4dd2-a1f5-c7098afca457	2025-05-19	01:08:26	11.743358795692249	14.491777306382552	4.79646035261609
6dd2c11e-25cd-4810-9d3e-9785c694e781	bd1a8138-357f-4831-9387-38412bbfe4ee	9e8a7879-3fbc-4336-9692-49cf5f696ffc	2025-05-12	01:22:56	14.310801364894873	16.98701871693346	3.736219634935245
8a052d6e-81fb-4631-b72b-67a66781420f	de5469f5-694d-457c-b0dc-cf1ab74401e1	21ba4295-ae9a-4a08-bb50-53b4deea95ce	2025-05-24	00:23:25	10.14207457519371	13.552292461543125	8.489100436084879
1e1b48e7-d3d9-4a09-bebb-5ebfe4ff19a8	2de7e285-5063-4bc0-82a2-1d802627fb90	19c479be-f7d2-4a92-8c83-18b790549545	2025-05-16	01:30:43	7.419580070192426	7.680268505016719	8.107139857619403
17b1b38f-543f-45c3-9bfd-9182509e3df4	13327720-e8e2-4545-85ab-a5f1dbc0fa9a	ce019c61-6be0-4893-acee-782bb8557d21	2025-05-07	00:38:15	13.828943697939716	17.485935092959238	2.5258662028758927
64664861-7fd4-43fb-b321-4ad6cf0e36bb	8df7f275-ea8f-47ac-b543-937223141467	03471dd9-56ff-4ad6-ada4-90d27056db8c	2025-06-04	00:08:04	14.678012308625132	14.863167024431863	6.732263736125014
\.


--
-- Data for Name: user_credentials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_credentials (user_credentials_id, user_id, login, email, password_hash) FROM stdin;
22856302-c8fd-4c90-89d6-11f8764595fc	3edd911b-fcec-4527-9863-46607c8be987	UMRgUEk	UUQwVHo@OlXRcKF.org	$2a$10$jdpQMxnbj33AdorpelRHg.ZY7nnmxogy.rQ9z3i/wodas.7R/v7BS
d6364e44-bdb8-479f-b470-abfefeb3eaaf	6c8bb259-f4c1-44c8-bfb2-f33ff0700b27	ilIltyv	adorhFe@QXpNxio.top	$2a$10$Abm7kIRcFsVHx4JwG.TWMu0xWUhTUZLzi2eaf9Q1MSxVEhzslWmy.
9e3b04c5-c580-4733-9843-14df191c81c2	31e3a92a-deef-464c-9a6c-ce2084ec4e77	VbtZbra	GktolsZ@uVBpXle.edu	$2a$10$sBuKblTBHaf61Z.1nuNpbe73taXS691TiGr6Bu.7M6eOpzHEsAFD2
572e5d4a-093a-430b-b2b3-ec1b474b8134	bea308dd-bb60-461f-9630-ae77362fcf64	glDCOnp	VyWElvB@NfEHLUU.biz	$2a$10$Qd3aeTnlY3eluyhb8HXjIOR/56b8qfMOXYZa47v7dvsuPEbE5Vxey
ca339e09-ec8a-4234-a259-160a892e4c03	dbb087b8-ef56-42a1-a6e4-e3e0fc8afc20	AQTZvkU	BtfIPTC@vNxoNkY.com	$2a$10$mo8YhswLh8q1GPTcf.UMpuwDNfPUJpDaX3vUlgQZsmZLZyFEF8.UG
df30b64f-16c6-439a-80bc-69f71fbfa034	86470be7-4cf3-4483-9014-289c012be9a5	oVZhutf	rNySYCQ@rkIqixo.top	$2a$10$5M5rU.7qJbPVGXP568XHuu69oqpD6p2qgRUHvI.nEm1LkU8HwBNSu
b92ddc5c-23fc-43a5-b70f-fd89fd76701a	97c1fafa-0067-426c-b760-38318cf928b5	UblCYeU	xABdAKk@yGSccwl.top	$2a$10$fJQE9v5tsr0eKD7vDhDQ5uSUINEodjAUgaiJtL0IR3V2zEcorMXFq
6008df21-1900-4a24-84c9-45380c20178f	e93a12f3-0bf9-496c-8d3a-5d2f42943f3b	rUlRyyr	CngLUNI@gfFkGne.top	$2a$10$lZc0z8gj9gqGNyv1dGWhKutLTNKkeYNSeu1nMcQSx8S4btpBraFk.
64187031-2438-4da5-9355-ed7eea00f58a	b17e3885-5d00-439a-bb47-e64cca4c9995	UrGIXER	kHoooIO@KSnLgwT.net	$2a$10$pTdDHUc19g1Q8VZhYhrsA.0NoyxwCeO6LeMPtvcQofU92jPGLqeG2
245c8aed-6faa-4955-8b0c-e71f409c4008	e186b3a9-9944-470b-9c6e-d2f598fe3bae	VLBJrPq	MOPHlId@eMquaFm.net	$2a$10$rPK/E/phSK2vk7uGTtw/1.QUVY4pxCbXQGotOBscWy1Th0thbwCJa
ff78efe8-d4f9-4641-8314-0fbde10e23c7	94b334d4-8b5d-4200-b863-730e3c6628a8	HVAcdeu	gAyxvpU@pHIsiMA.edu	$2a$10$SFeG1FB3N8qIbB5QLrNwDu6wQHj6xCja0IZPms0saqLnyaQ3Ag6ui
bf804dcf-4bb9-4a1b-b045-41fab6767534	62f01ea8-945b-4884-aa68-6c7572c1d78c	fvAMUKm	tpUAUVn@AhJkKqY.org	$2a$10$KSvNbikn./RgAttahNBvfe98IHUwF.OrCSWaElTA5obv9n57ZhHwe
987545c1-3f93-46b7-8207-7da2ccadda15	9a2ec07e-02cd-41b9-a9af-f22e909d0b1a	psuuiFj	lsGRtfL@OKVGAHu.edu	$2a$10$9AoagOkE56zRcRBEV0XM/eV0fUNUMQYhZFxaVKSbfroIJj6nCygvO
904633a6-011a-4b49-b07b-23b60d8a9f43	d144b392-0f6b-4a5a-9d47-7404340d3cbf	XouTGaQ	QQqAjqT@YwGnjsF.net	$2a$10$nGpPuQRPml3pO4.mRPLuE.CvRr4txNEXYtHY8QbLS6T0F6TR.Wy2G
89cbf791-01da-42ee-9f12-612aec3533ee	5968759c-1e1f-4ec1-9ec7-35148d8950db	miNmxKp	vfbBvOZ@MCPSLNL.biz	$2a$10$Uj.IHCnzx1gGLhJJaHKcm.DVubTan9sCW30E4RmBz3jVj0KWhUG56
a32f7f3e-c6d7-4809-bc47-bb780795442c	9b72e6c9-d795-40a9-8d6d-abd1150c9aca	soSkmqY	ZPoDgMR@xfQMlcv.com	$2a$10$Vka5nr6ff0sIIOVea.YM9esaOj.rx//OeMScPYtoOJ4M9JIzoegQW
b404e533-c39a-4ea9-bd20-2d0d64be1be9	216e5a26-41c0-42b2-9622-c89c44f0fc27	LKKeEIn	swOFMxF@ogiWqCL.ru	$2a$10$ZTu/C0KfWlVYea25NioWBOeRd/H3KTye0ia5mOhVRqrXOi3oAifwC
b1b5b35c-7a6e-48e9-811e-eafd12ce1b0d	cf540071-ebc4-4cf2-95d0-ece5567b6a8a	CavhWZc	unTxjeg@tMyNYWu.org	$2a$10$JkqOfPXsO5RAm8WJMTGvUeF3QRglbNqfNw4S2yCHVRd/53elOIg2q
60403561-c7e9-43f5-b782-40a0b96d52d4	69a18512-a2b1-432c-a767-b4e02b7e8413	EVvBGBd	stSZIOf@RGptowF.ru	$2a$10$yEU2ljLZSk74Gh.MEweKaONeVcTEvX0dKwI8bk4r4xDm9D2Z3UJfy
be51bc8e-a77f-45bc-a7e6-33f7a7948295	4845be0f-92e5-4e55-b00e-a21359b5ca1a	Frrnstq	rhmALJo@rGSKfrR.biz	$2a$10$Ngoq2cKKFXVLrANokObT8.v997IzaPBxmcsCDiv3ttC07ZK4zEu.q
f2f3fc7d-0c9f-4d3e-873f-78d7d5280d4b	936a095a-c5ae-4f1a-91e7-58e930d38700	xWZLjFG	krtqJpo@BcpKfiQ.edu	$2a$10$xT3J.XuirqeZy2IlqDn5ZO7kuDdZHsnc3mhZGQeYfFp0v7bXQt40a
9acf33f3-c142-4d41-ae50-cc8ad220d1e0	bf6506d5-fc4f-4a3e-914a-5ffac04f487a	lXexFmY	HRrrvDo@LZTIYyl.net	$2a$10$1Fra2/X8ZFyFa1zJWM8.TOBGy.0//jndDtK.fj1VLnf.zK.jz/sbi
ffc18575-a925-47b7-9d6d-97e6ab420344	0ff2642e-2f6f-42e2-a0f6-3c0eebcd765f	YmYnRUp	UrrXlZF@DwRAJSr.org	$2a$10$pAE.StvGxy1tcclTjjxt2ugqO4/8X/GPfQSK5YHl359a0sAEINNYy
aab13cfb-969f-42ca-9dca-f03ea05e7340	bf34227e-cd86-437f-95f5-d48fb096f657	sobViOX	WnXmchk@oPILJEt.top	$2a$10$pnypVeVGcmhWYif5zRYKvuAUf65zNa7Y/sdk1wvvg6Gt6qP.hcvyu
4aa1d805-cac7-4b45-8382-9231fcdf15ff	81419018-a89c-42bb-80c6-3cd70f4fb020	LWdTWEY	YmEGjaR@EKBjyFL.ru	$2a$10$LDhEUbOLKwTumwly0cUfuu8voQzCyE.a3C5NJzEV41WGAAOpBjpK6
43ceb917-1950-4169-b7ae-c9b80a60e598	4b3e8f5c-f3dc-4338-bfb1-145afeabff33	UaMCSaX	KiFiZiT@xJgJPgI.edu	$2a$10$5fLJHj1U6VaTmWQ/oLoUOOW8aZAYaCeGo2Z/.jdHu9r0lrKouTuQa
515080a8-3d20-48ac-9eb6-94759244719c	9bec1b18-7ff0-48e8-9f55-ed60e2d4cbfb	KMWhceK	sbpipld@sImbPaJ.top	$2a$10$o8TqiJWgnPmwetYBvZl.H.c/1R5YSRUlw.XTFrtRQsFjKEDiNt2r.
1e60350f-bb66-4e8a-8796-e662e26e5939	21e9cc9e-88bd-4d9e-a19e-1363d8c97997	XBZWdxl	eCxIkLb@QDHaRfO.com	$2a$10$M0AOJV.5J5xka7htfVhReutbJulvim.nRw6LdkKNTl9T3TiRhLC1u
a2e43e7e-a754-4e1d-bdb7-dda6fcf7fbcd	0e8e8e3e-ea1a-4248-9c1e-62850a4bed89	ebhwaSv	JkqYbRn@jmnDQam.edu	$2a$10$hd9C55WvRmefVKLPWqnBcOfx7svwC4xrKGKO0bEZKepqFn6iYyjhW
4b4e5e01-80a2-458c-a2e3-bd1e575d26cc	6694c4ba-b82a-4ca1-a8b1-cc5d35a7a372	RurUHNs	OYwJfXM@hxoCAVJ.ru	$2a$10$HppKLgjpS904vPMrAEFnruFOBpRoIvuvhaK441FSeVa7fpCiOxFAi
618c0a90-cec1-4de3-9e32-fd6594d49290	f53c0e7f-7f99-4cbe-924f-4a852f225b50	NFtyjWb	cdmGGJq@YKHtJdB.net	$2a$10$Q3.QNmsnWElALQbzlzkNJuMRi7Ixn7XDrdCswlfMMShcaXQ6pY.gu
34d88076-7c52-4943-9d74-f34cc1fc98ca	642df5af-cea9-49c1-a820-f60bc0e5f451	XcnpLXZ	BJPxHVn@UcUpjTs.biz	$2a$10$VqGrTknmcKdCBk.1CaJqBOIxtRbADlCisdQ66iPS7YmpEKGgq/mXe
4d795dea-c3d4-43ec-9288-dd80e249f3bc	d8c9f3ac-22ea-42c0-b786-87b0b78bbd21	dgOIQsH	QncEmDx@EgeGirg.org	$2a$10$w2iFskEEG.JbaGFvgwa73OjGd.uLe0EBT7dEUbhUAVq3nQGC08gRi
7fe12e9e-a84c-411d-8bdf-66bda3fe0219	acdfffcf-d93a-4817-87f8-253fc3c4f861	IwKraDI	ilDFLcY@oEJFGSR.info	$2a$10$/81k55Q53ce1rPygnvGz8uFk7FLbWu321xTzeyGN/gPMUv0tmksaK
b1304b58-2dd0-47c3-ac9e-c4af19cc5839	490eae7e-06ca-4506-ad9d-cadbec707dfa	vocCLBk	oVpqodL@aTETSir.top	$2a$10$uxMuy/JIdda5f0EUVVGKWeZJh2m4QM.A016rx4CfiaQj.jts99GI6
67e2899e-1002-44c2-a088-14f3329e947a	61d282ce-1edd-46d0-8831-801c0f1b82b5	uZgoFDo	VMqotpP@UOsbGlR.org	$2a$10$ktlQIofe7DaH3V90dXa1ueO0.ph0ZqbndHT6U39AUgF9auJOdHtia
d6c2d324-0380-40c0-8a74-2f22445072be	15f7316b-4bfc-48e1-b5be-a1b87f731d5f	tXErvMo	WIAGISC@SWkIjmO.edu	$2a$10$won7.ZGtidIzsZhAtT1AVuIQzSzp80brZUcW0SMte03uZNjwypCeS
bd2d25d9-db7f-4bcb-9b6b-bf8c12ce1503	d22988e3-453f-4af2-bed8-6b2805dd330d	buKSuee	OUcIVcy@TdNtokw.com	$2a$10$Maz5r5.8ORhFsBywb0tWouCGeZ8gX1MDwMnh8paQWqYOFxs9ntnx6
77782b2a-c191-4e23-957b-92b110144789	2e964c4a-cedd-4729-9f12-88022618d7bf	lwpUmwj	MZOUUFJ@LhKQXZg.org	$2a$10$ttiwHXJWCBAeDberhzy0uOcfHd.WDzUTjMAHRNFFyNIIuZeR4Kiba
60d0ac18-db98-4f9f-9a2a-c11a5a0245b3	32b3c932-48f1-4f6b-9e64-355c7a634b4d	HnLyKkF	TCRbhhr@DfCKQIL.info	$2a$10$pdI1Pud86onp68vqsOeZNeYBFGaRM.RScAwwRaMaCApPX6z/NmOZK
60e64303-9abe-46b8-bf84-6033bd692ba4	abb3ff00-aff7-4ecc-8e19-ed23d9d6eaff	urBYtkQ	EfyUGXZ@UcwfcCL.com	$2a$10$2cP6AuOP14PIkBgrhTnjSut2AXXWCaAUPOdS2zDmfuX8ceQUoR/XC
f00bc407-0eac-41ed-a373-a5504ce6e4db	c1e1b966-9289-470c-838e-c7d706186871	pfOydVQ	hLbZpLR@MlddjFW.top	$2a$10$X42K8binENRqkrPDGs9yweOoB2Xot6DQ9SWakZpyDJM3KwIToJbfC
8865ca71-4cff-4f55-8cfa-b61777ae850e	70ca91b6-ad56-4c89-8bc7-983a763077a7	teQXiXK	kDObCRe@QHMPdHQ.edu	$2a$10$MaFBM7buHzMxEngf5DNKzO0vE70wSFWdh2./utmF23nNiHu0h8LlW
6b8204ea-6b40-44f2-bcb2-77771d193146	588bcdde-f69e-4aa4-9868-777f659b4d82	tvPYbRS	JeKTSVm@JujjEXG.biz	$2a$10$lh/YKYuS3XGSFsaKvgclPOtJh0EiOegYC2Q6kjAymvD1NqCaX74qK
36a88192-2c70-4196-ad3c-056a4f6027d0	388d6b07-08fa-4d44-a62b-82f4e570f3f0	bFmcYhq	IHbyGRn@eVKFyTa.ru	$2a$10$NN7UqxkWmRqNjCNaM5P8rugNXVaGJd8llmcJU7QeeidA45.UXk99.
dc5c9af6-81bd-42c3-9b6e-7640d9bb5394	8e0ecf55-df9d-4a5f-a24d-2613cc41be4b	paMXFZm	bRvZObS@QXlyjhL.ru	$2a$10$NEo0AfPJmtsNDdJXFiDsGOhpBdZJvTZLIGTMAnAQTeUKOEHg4a3HG
a4d920a1-7914-4233-b073-c1a769b287fa	e9fc1da8-1c27-4c4f-8d2e-ec6e46550d0a	GEnqIDY	beDnrdZ@TeFewKg.top	$2a$10$LF99BQmrMW9vSYuo8JKpU.PQG6RnVDpAR0iDIw98is.zb/pwMr06a
34b2565e-6e9a-4b14-93a1-de114e7effc0	15825a85-1d72-452e-9c85-9c281cd2b9ef	VjDFeJS	oVgIlUC@mGWeqEu.info	$2a$10$7/m0Do74BwGKqHs/qXu6u.4GsV0ZQY1fmFM.aXWdOg3b7AvY8laL.
014da7f3-db7b-473a-af27-9996e6a870a3	eb3aaa49-49b9-411e-93ff-3309c3f85033	HeLGmLm	DkoTygs@jSuxXSS.net	$2a$10$PHOJMsAFH3qV8lgewEvcw.M9XS6by45a3K899RCe5u1r3CPu6r6NK
14a552b9-cedd-4f5e-999a-feb79dade80b	19eb8f4e-eb7c-4784-ae9c-d992d1e1370a	QtXjhMk	yOBtjZc@LISCiKe.ru	$2a$10$co88OjQTPr2RFfX2ahQnW.yS2oxe3BM6AMR2VnXFOpvIQ1zcTbAVu
498e1cc6-fea2-4456-917c-615fec49e196	a0d2dc81-9f48-4a61-b622-3ecded01d8d1	xyaJvVY	wTWtGqr@YwuYOST.edu	$2a$10$wshqiDM5hjtx4.vOlfiwLOqwwqjuY7uHZ9KvvPeDm4nDmdGF9oqzO
7b742bb5-bb4d-4f8d-9014-cd1535223223	2dd4b7f1-4779-4e95-8276-9a2a5d4db550	CegkQjL	mCmiaQD@awkxPap.edu	$2a$10$QHIvNTdepTElCcU/wDZRVOuNy3EC5ICe2m8LeYD1xWyGaRJr5FYwu
0bcdfce8-2e42-4a59-b635-209a5525b22f	99df127a-484d-44c7-a6e9-d7e744c54053	JYIyOpA	rvmvQkT@FcdZwNe.edu	$2a$10$mjegTYBjRaRjrAv1b0SAaOdqzsF44ZzFBiPpIyGF7DyVrl6Ypcidu
87a380b4-3265-4572-9d78-94a4411c0f9e	a24788ba-9862-480a-84b4-0ee112eb7700	hCgNxRd	yLkVnrn@VjIwZqH.edu	$2a$10$aII4oJ9yGeuq2L/eipDqdup1ulCIAwANQ8oASxkQxhAyoAIz85StW
14fb261e-3d5c-4c43-ae21-7f7f4f9d9340	48117389-3c10-4fee-9b35-172558be8086	ORqDcLF	qiPLMSK@tGTntDr.com	$2a$10$73iXGqZGcMEq3PllIfvtmOifQ..urB/U5Zlu4ImLxsT32NSKFczPq
3b6b44fe-3809-48bb-a5e1-db7893f20604	bccc0e62-2471-4133-8392-50732c9ec575	ptZnDsS	OnMrniv@FHWUYWE.org	$2a$10$0RN08hfjy/k0lzgV2CCCCed1t24ikVyfbLe87wIepJYdVqnoCs2ZG
d6cfe4ac-3322-48dd-b306-26d4a4e98a94	20c856f4-48fa-436a-9e33-b7286b187a93	SYtenCs	wMqptuE@PCGaOqZ.com	$2a$10$vOV2qXMRR4tX.2MlyGaGiOEe.VQ6bz5sMG1xm1knKOm7onGd3/nuS
77475f93-4880-4c17-944c-fde7fa7166b2	e0c84fd2-61b3-44c3-96b2-e320099ff540	rNqgwuR	fjcwTGx@xsLyKjZ.ru	$2a$10$futY8MqUnSJxEc8k4/RqO.QAT5oeal2LEWPR4Nx3lYlGCGkVIJz8i
aa8c995f-98bc-45a2-8daa-42b4107accf9	663eaf77-4ba3-44a1-a7ef-6414810acb3a	jVCIVVv	CuPWBCj@TmjxjmJ.com	$2a$10$V6ylzvt2LhYcSiZyASkpOe527R5h901bBPxU44tSNu8LhQRDYYMIW
87d43527-d610-47a3-9d7b-166a9eec2036	d424ad49-c85f-4357-b1e8-5a07ef0049c0	thhcXpY	cLLoexs@NroWIGC.top	$2a$10$mo4pgRhOSWsK0NEinGL/3OmqNbKU1RP70Bqiae0NFjdlmM1.DMz3e
16e896e7-282f-4f99-b2e3-5b95017f2237	d105751f-5139-45ae-b658-d321dbf4e961	mSHLOFn	gZVkApW@yfpNNGJ.info	$2a$10$qqK/UpR10XV/JphkAiWDHuRPpJgxnqZHpCCzF9oSUT6S3szoTNHaq
d40be5fe-392c-4780-813b-13b82daa8070	648de0b0-332b-4a2a-b6ee-a19b64d20aa7	CLiNalg	XOYFijn@KygoKcJ.top	$2a$10$LFEIHnxhtYYmar9pLgataeVH87man9lbCoNnejIgxzIY6qX.DP9X.
fe66cca9-eb18-4277-be98-f6baf6805261	9fbf1314-b152-41e7-bd83-ab909be70c50	BItEfOW	YLJGmfQ@pphYnSU.edu	$2a$10$nnF5MRqYusjtI95kKtVnHOOhtE7u4sHM1kMWFVr2LpRTeWGONFZ5.
31eb960e-0f5f-4721-956f-fcc22f27a1ba	52c84561-4233-4b5e-a662-692571935818	GchAIjq	FbDeajl@qPSDpIW.info	$2a$10$KuSISnAUdXNXwMwKZIu1fOkGDhIbGdeARfXrtbXNobwo57xy13bPC
edc0723c-95eb-4703-801d-04ae0b173c23	10ac13d6-73ca-4cbf-a5d2-b85403e7faed	yUEXhjJ	VbDWKmK@ISkLXnt.info	$2a$10$lvsoWRxQUwJjbCzr/ILjHOPnBFbu0OkfmQwR12T2.mEsuxFsu67HC
fdc6213c-f76d-4078-a86b-ed97f8eb8156	01ce86d4-54d0-40e7-9bdc-db3cd88cf621	QLaGfgO	eIwgNNw@hpOhTEs.top	$2a$10$6HU9St7c9n9l5WKh80EA..dodNQ0dWpxUIulcLsPKOHsZnOeA5ACy
9a01fd71-d889-4c50-a81d-ab1d250fd1d1	47b41895-741c-4b99-8d93-b7dcf413e66c	FeQVCEx	bGoQUPG@xCZlPCF.net	$2a$10$W3Nnu1S.N.mduPbmsmdk/O9IygPL9zwvG4BXiZxZMivbvXq5PDIIK
b8962b11-3151-4fe1-9537-3ee5eca76a92	92a5e639-04f8-4af7-80e1-a7c88cc7f236	CgkvIyA	mdbaskr@LJKDBvW.net	$2a$10$yz6hechWcH5GDB0KmGN.R./YAu0fF4GuAGbVRjNaNEg5HzLaZOBAG
19af1f7c-c8f4-4bd1-99e2-ef30eec2e293	7bd7833c-9ea0-4e04-b9e2-f1bca999de28	SdFLnLp	BNqITEp@ppLVWrv.ru	$2a$10$5yKrOcwCqZX9yyCfj/aLgOnG4jcd7rhpIhW4uAm5SGa7Z5kNHa6zu
9b2d20c8-a84a-4c7a-a129-d45856e82986	5cf96c40-3094-4999-913a-e378e31c82e6	urfrEOD	uDqMiPx@QNcivVU.edu	$2a$10$EfjL3CQ13Wgq5XcFswj6lOioHLNGutW8jcI9IQCGIOPqeKX8NUPAK
8ebb3f51-582b-41d6-88bd-e769b2dbf9f9	72b17e5a-a0bb-472a-91a3-b5dbd13caaae	EKlkEaf	wmSabeO@BhonnfI.com	$2a$10$Glg8DMo/WjsRFjHVFyD3OeNmC2u2CuiWABspsoHAYM23KbdTFuskO
1a4c82f7-815f-4634-9c12-e1c1956dcc95	ff8a03bd-05cf-4476-9d53-e72527f78b97	kFNRviv	YNMCUtC@jtCNMIg.biz	$2a$10$MRVbdv3OeOU.QGC0P68uM.OnFleo3Zl9b2qv9mne1vvxU8NrcYeKW
74345e70-5f5f-4e96-955a-05ff60f4fbf1	0eccc020-3ab3-49cf-a218-4bc872002f05	lAtqDOY	TBhCLdd@ePDShau.net	$2a$10$IiU30naJu57qMEsl.8pIM.W4sIIbIqZdmtWcnMxaRMxsDa0nxaQZm
38eb393c-fff3-4cbd-b7c0-ff47f1886d72	3164d8d8-2517-4e9b-ac73-84802e3322cc	mjcqNWS	qoXVJho@BHynDGV.info	$2a$10$aKqI8JxOWVWp301VLJnaaekR9qLREjt.T8oyYjTPIY5C8Ecfi07/2
148b9d0a-3e05-41a4-ab45-39975258839e	6dcc02b3-c178-48b7-a534-331ac5613eb2	YgAJChW	GufNAws@XTWuRXO.edu	$2a$10$PW6QAI8/3.YuAnndMuniI.bNIKylVqm4mJFAZwEGqPnZmg/46rwgi
6a0740b1-c969-4342-bd0f-5276e105ad4c	4d06c317-d321-4dfc-b52d-a354741fb449	UqytkCv	puSeNwd@WmxqjPg.net	$2a$10$hwf7ti7S.zWPy6V0x/IDxuCRCTmVtRTakyy3RW0Kx02UJDkJd2WPq
d2aee7f1-d942-4581-a5ac-df06028eb119	9980b872-1ad9-414b-93c9-301e39788bd8	VuLJUwl	aybimew@xoXPqlM.biz	$2a$10$AjlKPxf/UvBpUwN7Q.RLguESePOCQhbncsrwBZlgouLqaoNkFAzES
1bdfd0af-67ef-45ec-8d39-088862b18634	9324c610-8ba9-4c4e-a811-f9a037eef743	yFByPKd	hyAUuKN@mthkgWH.org	$2a$10$UJxW20QzJmoc7aaaHYmxmOeNXpLANpYQitAJ32vy/EVOppvCwVG.6
be982380-0cee-4508-8aa8-cd7f520d8601	aea78d3a-2b93-4cd1-9b25-c69d5aeba20b	BWbGAjS	lnVTlRL@RTnVMRe.biz	$2a$10$xuQfjLvlV0Jm5fIRjAZ5e.DooyiBU/VrFD8RKlY4e866xY4sRQkTm
3b8ae8da-5825-4cd5-b949-183786675fb8	c3567130-5f32-42dc-85f7-cddd10b583e9	uVKVskr	DCQfHvL@laFKDdZ.ru	$2a$10$nIbnaHzb5Jt6PpmZLUGgk.aLCkuzS65az78d.mQjRVU6sZXpxpuf.
5e416fee-a701-4f16-89b4-f82efc355eaf	1fc48383-ac44-41aa-93b7-cc350b437e0d	CHUHKnL	UGUbOCM@rsOFapK.ru	$2a$10$BEtB909gb/GrIpUXuyGVY.h4VP1rPH70HR5Br9yuf07mQnK.N9dBy
47ade394-8611-4bb7-bf0d-e67324658c8a	dc33737a-36f6-4d37-8e04-9f09279da0f8	jOYtSuj	JafWePc@UAIGAkW.net	$2a$10$9IrRPrUUw/1xKA.W3xmvBeZ/rL8JPYCUNNiuN0z6tsQhlv8otQWv6
b4146c02-6917-437c-8dd9-f007c2a38122	854e0483-705e-4950-b861-cb3801c7748e	VshJmPB	qSjGcnp@hCUvDQH.ru	$2a$10$MJ.6Xo1hsBmPmzPrTGmxlOH5.GGb60OJut4Uj1jvanwLg4bz6TzNC
b63bf3da-80cd-47dd-b6bf-a63e78442bd6	52cf3c15-370d-4e6c-839e-e630a358406a	OrXiyHk	wEAGlXn@UhXeGTU.top	$2a$10$QBpcuBr4TyWKvkvTwnIJO.fqU7Nh5CeHWVjD5OoPdJ7JNvlrmndce
fcb157da-bf4a-45d6-8070-5ec4b63a5281	d8855132-907d-4eca-852f-75d40c6402e2	woDwskQ	kgDkbed@LKOGwxj.com	$2a$10$RVHKbgPtiF1LAGURvadktetEpd37rSkgcN0icxQQWT07ND27A0.rG
80ada2a4-b480-4622-9872-86b6618b96e0	6cced495-ec1f-4451-9cfa-79303b413ecf	BqKxQTy	hPhLYdU@iGvTvZt.org	$2a$10$jW6Alf2Ax0ZPxehXQtq70.J0nbwthmgC2Lk4F1Ulfq6Z3FTuQAwYy
0f11bb63-b27a-4189-80ee-308b38a8cc73	7fd94df0-1a06-4540-9042-36e909db2efb	arXCYyX	SwrJgqq@qkyFDPq.info	$2a$10$2vboFXfKk/ZTeWSkeDVGdOSR9i/mEhwyuA4gfkOP81w/mXyiYn88y
d774fd69-53d1-4b4a-93ea-a01e55d3c8b9	bee55ca1-cc5d-4e4a-8d4a-249b86a86737	oGCvyge	pBAZejT@XsLCfEw.info	$2a$10$42zMnzLJU6MOMU4QXUCVfuMEP5uWIEDTqWBKlwOIaYdmj8Q7UMFZm
99d61766-3849-4bed-92c4-accace525eb0	fda19059-e00a-4a2d-b68c-d1a7512f1401	lVZguGr	XwYbhPZ@ImwYyqZ.edu	$2a$10$RE2z2kE2SZe0JVgbE/DTuep64x95XATMTofyvFnIG0zLrfKaErzCa
2a15176b-63b3-4799-a936-10a1536a548b	f0fc13f4-13a4-42c2-91f3-d5dffa49d43b	QScbacW	fmkYljv@fNAWehu.com	$2a$10$5SMBxb31rCrqkF3p2BpCqOe/1pRvyP8ZGE2.SUjQ/QPfbLN2zteg2
fdd0f200-5cf4-4d52-9faf-009876fb9c08	3b6e1bff-a157-4c5d-a200-b2565c7eb172	UOJFAPf	SktJopB@qMkNAmk.biz	$2a$10$pPldMVBQZrOGdxEF.XdS0eyozKnRTt//fBDPkz.gryMOaGkJlJUbq
7020b82e-0942-4678-83e4-f2323fd586b6	ab9a61bf-60ef-4d02-a79a-e16e1eccd8d1	eJZifpZ	Ycccitw@mAceTTJ.com	$2a$10$NVvc.s7R5RH9gYYO6yD4fuwtWFMcjjqVjKA67FnsdJghbPyoMH5EG
617da6fb-c312-401d-be51-e86599361681	dbc2bc60-18d7-40a5-b6b5-023999f69c7f	tWgwTVq	NjayvRo@jCdoCmx.top	$2a$10$JHPgC9Jx7VFXx5twzVZ.RebUnPQIpNplkS8yAcWyZV8X2w8sshBBS
96f37b8d-0258-4349-b127-fa68ef959822	fba1c228-3a75-413e-891e-5bddcffa2007	jUACbEJ	GVNDwfU@RMYEbBd.net	$2a$10$JP.EC357OJKsXvuwniwKquJyw1tdbc65kf2XXlvOBjrXJ.etdRtQK
25b43e29-596a-4a56-9045-cd580ed56d42	e56fad7f-f5b5-45f9-82d9-cfa6b761b8cb	DkFEOuO	XwQPENu@lYoJBlv.net	$2a$10$hx9tVXXiaX8T192xY9hTIuYybvxQAVJd8yyCXJ9gTphxaalcTZeFG
69384c5f-56f2-4509-9de2-07e87d0e96ac	d9a3e93c-865e-4cf3-9bee-c313bbe57610	gjSXbkJ	GIqbasV@YeCeAsW.top	$2a$10$FQNZAmD33zAzxnoIefYnFemtgmY401csjuQCR2rljDZVkPCNL2tvu
44e27092-b0d9-46f3-a8d3-499e11a376a6	5afd228f-e289-41e9-ac35-8239149a0eb9	aGLeDCh	enlZoLm@AfEVjlF.com	$2a$10$Y2px7pSJ3N1IJlsqFKjPfe6bV.h0BMpp./gkHICEnWGPXRhTQ2EgW
c76809a4-e546-4716-aeab-4d9d6c875950	9f1bbc93-27a2-440b-8410-115241e1cd6c	jZPxAYU	IQJVfmt@mISOfnO.net	$2a$10$8F4BBgSz1l0xwkbDYgwYcuPEywvX5cru0jpVCTak.OUbzyQ1YdWvm
a8f4999b-b3cb-4cdd-b111-ce042658955e	8f5ff173-7446-43ca-a127-61e51fb2f744	EaPGvES	hEmWjUW@nMPoOku.top	$2a$10$QJ45.2jq0rykku9zHDyy4uy5z.hZv9ydSStsxT8yhHhZ0/YlNl1KK
15057ed8-63e4-4006-94c9-f148e86bfdc9	ab2c6c39-d8f5-4af7-b020-e6eafca298eb	mOMVkON	yECchbi@OQdaDFZ.org	$2a$10$cK.bxLYTqzG9HED/.zqcZekhGmsoKoeDLbWt39yeh4hWqsavN3/4a
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, full_name, phone_number, gender, birth_date, citizenship) FROM stdin;
3edd911b-fcec-4527-9863-46607c8be987	Alvis Lang	510-278-1394	woman	1998-11-06	Russia
6c8bb259-f4c1-44c8-bfb2-f33ff0700b27	Janiya Yost	219-410-5763	man	1990-10-09	Russia
31e3a92a-deef-464c-9a6c-ce2084ec4e77	Billie Cassin	142-763-9851	man	1977-06-23	Russia
bea308dd-bb60-461f-9630-ae77362fcf64	Joyce Nicolas	951-042-7681	man	1973-05-19	Russia
dbb087b8-ef56-42a1-a6e4-e3e0fc8afc20	Sunny Weimann	567-102-9314	woman	1981-05-27	Russia
86470be7-4cf3-4483-9014-289c012be9a5	Brennan Abshire	245-961-3781	man	1982-06-10	Russia
97c1fafa-0067-426c-b760-38318cf928b5	Tyrel Simonis	621-039-7418	woman	1984-09-01	Russia
e93a12f3-0bf9-496c-8d3a-5d2f42943f3b	Carli Bradtke	634-871-0915	man	1973-11-02	Russia
b17e3885-5d00-439a-bb47-e64cca4c9995	Johnson Wiegand	110-875-4693	woman	2006-03-15	Russia
e186b3a9-9944-470b-9c6e-d2f598fe3bae	Liliane Kiehn	481-062-9175	woman	1986-12-25	Russia
94b334d4-8b5d-4200-b863-730e3c6628a8	Hazel Kerluke	793-268-1104	man	1993-08-22	Russia
62f01ea8-945b-4884-aa68-6c7572c1d78c	Eveline Daugherty	126-310-4985	man	1973-01-26	Russia
9a2ec07e-02cd-41b9-a9af-f22e909d0b1a	Emelia Corkery	910-425-8617	woman	1968-07-23	Russia
d144b392-0f6b-4a5a-9d47-7404340d3cbf	Annabelle Kutch	911-052-3678	man	2004-04-20	Russia
5968759c-1e1f-4ec1-9ec7-35148d8950db	Otho McCullough	529-110-7634	woman	1971-09-23	Russia
9b72e6c9-d795-40a9-8d6d-abd1150c9aca	Lottie Schmidt	412-953-6710	man	2004-11-16	Russia
216e5a26-41c0-42b2-9622-c89c44f0fc27	Johnathan Bauch	398-105-4162	man	1992-01-27	Russia
cf540071-ebc4-4cf2-95d0-ece5567b6a8a	Mack Stracke	721-645-9103	man	1980-12-20	Russia
69a18512-a2b1-432c-a767-b4e02b7e8413	Vern Senger	910-251-4786	woman	1981-10-11	Russia
4845be0f-92e5-4e55-b00e-a21359b5ca1a	Royce Johnston	386-109-7154	man	1972-11-25	Russia
936a095a-c5ae-4f1a-91e7-58e930d38700	Reva Dickens	351-027-4891	woman	2006-08-03	Russia
bf6506d5-fc4f-4a3e-914a-5ffac04f487a	Celestine Schuster	127-681-0934	woman	2003-05-25	Russia
0ff2642e-2f6f-42e2-a0f6-3c0eebcd765f	Forrest McDermott	281-014-7395	man	2001-10-15	Russia
bf34227e-cd86-437f-95f5-d48fb096f657	Amira Koss	410-367-1589	woman	1998-11-23	Russia
81419018-a89c-42bb-80c6-3cd70f4fb020	Don Wisozk	481-096-5327	woman	1972-08-03	Russia
4b3e8f5c-f3dc-4338-bfb1-145afeabff33	Suzanne Hilpert	547-628-1931	woman	2002-02-21	Russia
9bec1b18-7ff0-48e8-9f55-ed60e2d4cbfb	Darius Kohler	985-311-0476	man	1984-12-11	Russia
21e9cc9e-88bd-4d9e-a19e-1363d8c97997	Reyna Wintheiser	751-098-3621	man	1990-12-25	Russia
0e8e8e3e-ea1a-4248-9c1e-62850a4bed89	Sonya Johnston	137-810-4295	man	1986-03-01	Russia
6694c4ba-b82a-4ca1-a8b1-cc5d35a7a372	Ramiro Gusikowski	926-541-8731	woman	1970-04-24	Russia
f53c0e7f-7f99-4cbe-924f-4a852f225b50	Gunnar Glover	103-158-4679	man	1990-10-06	Russia
642df5af-cea9-49c1-a820-f60bc0e5f451	Kirk Schaden	863-510-4129	man	1973-10-18	Russia
d8c9f3ac-22ea-42c0-b786-87b0b78bbd21	Mallie Frami	794-361-2851	woman	1970-03-13	Russia
acdfffcf-d93a-4817-87f8-253fc3c4f861	Bridget Larkin	541-098-7621	woman	1983-11-17	Russia
490eae7e-06ca-4506-ad9d-cadbec707dfa	Mavis Mitchell	968-473-5211	man	1967-10-08	Russia
61d282ce-1edd-46d0-8831-801c0f1b82b5	Raoul Heidenreich	291-104-5873	woman	1973-05-18	Russia
15f7316b-4bfc-48e1-b5be-a1b87f731d5f	Arnulfo Beahan	354-981-2107	woman	1996-10-17	Russia
d22988e3-453f-4af2-bed8-6b2805dd330d	Rudolph Prosacco	431-021-6795	man	1995-02-16	Russia
2e964c4a-cedd-4729-9f12-88022618d7bf	Pasquale Lang	362-415-9710	woman	1973-04-27	Russia
32b3c932-48f1-4f6b-9e64-355c7a634b4d	Leslie Hills	567-810-9421	woman	1995-07-09	Russia
abb3ff00-aff7-4ecc-8e19-ed23d9d6eaff	Margarett Rath	311-092-4675	woman	1994-07-13	Russia
c1e1b966-9289-470c-838e-c7d706186871	Rosie Stehr	610-792-1385	man	1989-11-07	Russia
70ca91b6-ad56-4c89-8bc7-983a763077a7	Rosella Ebert	842-357-1016	woman	2000-06-08	Russia
588bcdde-f69e-4aa4-9868-777f659b4d82	Kayley Grant	311-084-7596	woman	2000-01-26	Russia
388d6b07-08fa-4d44-a62b-82f4e570f3f0	Jacques Breitenberg	729-510-1836	man	1984-04-03	Russia
8e0ecf55-df9d-4a5f-a24d-2613cc41be4b	Theo Dicki	421-036-5879	man	1984-09-26	Russia
e9fc1da8-1c27-4c4f-8d2e-ec6e46550d0a	Kiara Hahn	264-510-7931	man	2001-12-21	Russia
15825a85-1d72-452e-9c85-9c281cd2b9ef	Horacio Moen	859-106-3741	woman	1981-08-16	Russia
eb3aaa49-49b9-411e-93ff-3309c3f85033	Ayla Weissnat	718-531-0624	man	1994-09-26	Russia
19eb8f4e-eb7c-4784-ae9c-d992d1e1370a	Kane Hartmann	256-381-0194	man	2001-07-26	Russia
a0d2dc81-9f48-4a61-b622-3ecded01d8d1	Rodolfo Breitenberg	879-610-3214	woman	2001-08-08	Russia
2dd4b7f1-4779-4e95-8276-9a2a5d4db550	Armand DuBuque	210-867-5931	woman	2001-06-04	Russia
99df127a-484d-44c7-a6e9-d7e744c54053	Irma Gutkowski	748-215-9361	woman	1982-07-27	Russia
a24788ba-9862-480a-84b4-0ee112eb7700	Sylvester Wisoky	310-562-4791	man	1999-03-11	Russia
48117389-3c10-4fee-9b35-172558be8086	Zoey Marvin	923-411-0687	man	1972-04-08	Russia
bccc0e62-2471-4133-8392-50732c9ec575	Carissa Herzog	131-072-4958	woman	2000-09-23	Russia
20c856f4-48fa-436a-9e33-b7286b187a93	Torey Gottlieb	910-421-5738	man	1984-03-25	Russia
e0c84fd2-61b3-44c3-96b2-e320099ff540	Heather Waters	109-481-3527	woman	1992-01-19	Russia
663eaf77-4ba3-44a1-a7ef-6414810acb3a	Rebeka McKenzie	106-428-7913	woman	1988-04-01	Russia
d424ad49-c85f-4357-b1e8-5a07ef0049c0	Imelda Schowalter	310-618-2759	woman	1971-10-21	Russia
d105751f-5139-45ae-b658-d321dbf4e961	Mohammad Kohler	107-261-9834	woman	1997-03-06	Russia
648de0b0-332b-4a2a-b6ee-a19b64d20aa7	Franco Lemke	154-697-8310	woman	1987-08-13	Russia
9fbf1314-b152-41e7-bd83-ab909be70c50	Sherwood Swift	947-532-6811	woman	1990-11-20	Russia
52c84561-4233-4b5e-a662-692571935818	Scot Carter	412-861-0597	woman	1988-04-20	Russia
10ac13d6-73ca-4cbf-a5d2-b85403e7faed	Pink Brown	897-215-3461	woman	1969-09-09	Russia
01ce86d4-54d0-40e7-9bdc-db3cd88cf621	Estell Lesch	754-289-6110	man	1987-07-02	Russia
47b41895-741c-4b99-8d93-b7dcf413e66c	Alphonso Ritchie	584-210-9367	woman	1989-07-18	Russia
92a5e639-04f8-4af7-80e1-a7c88cc7f236	Madisyn Wilderman	106-957-3218	man	1973-03-01	Russia
7bd7833c-9ea0-4e04-b9e2-f1bca999de28	Mariela Littel	289-105-4613	man	2006-12-01	Russia
5cf96c40-3094-4999-913a-e378e31c82e6	Mariana Wehner	367-942-8151	man	1998-02-11	Russia
72b17e5a-a0bb-472a-91a3-b5dbd13caaae	Gabe Gutmann	105-289-7463	man	1974-11-13	Russia
ff8a03bd-05cf-4476-9d53-e72527f78b97	Oscar Boehm	328-497-6151	man	1998-06-23	Russia
0eccc020-3ab3-49cf-a218-4bc872002f05	Paxton Windler	278-396-4105	woman	2006-05-12	Russia
3164d8d8-2517-4e9b-ac73-84802e3322cc	Garret Weimann	147-359-1062	man	2001-11-15	Russia
6dcc02b3-c178-48b7-a534-331ac5613eb2	Nelda Lubowitz	110-753-9648	man	1972-02-24	Russia
4d06c317-d321-4dfc-b52d-a354741fb449	Verona Ortiz	183-429-7510	man	1989-08-08	Russia
9980b872-1ad9-414b-93c9-301e39788bd8	Chelsea Padberg	104-576-2918	woman	1975-09-25	Russia
9324c610-8ba9-4c4e-a811-f9a037eef743	Unique Fisher	915-872-6410	woman	1986-11-05	Russia
aea78d3a-2b93-4cd1-9b25-c69d5aeba20b	Hulda Purdy	782-956-1103	woman	1977-01-25	Russia
c3567130-5f32-42dc-85f7-cddd10b583e9	Keaton Champlin	549-108-6372	woman	1973-08-15	Russia
1fc48383-ac44-41aa-93b7-cc350b437e0d	Asia Schowalter	321-108-9465	man	1968-07-26	Russia
dc33737a-36f6-4d37-8e04-9f09279da0f8	Odell Beahan	239-610-4518	woman	1980-02-21	Russia
854e0483-705e-4950-b861-cb3801c7748e	Dean Aufderhar	810-612-4579	man	2000-04-04	Russia
52cf3c15-370d-4e6c-839e-e630a358406a	Fabiola Emard	510-469-3217	man	2006-01-02	Russia
d8855132-907d-4eca-852f-75d40c6402e2	Bette Koch	143-572-6109	woman	1994-12-06	Russia
6cced495-ec1f-4451-9cfa-79303b413ecf	Rigoberto Zemlak	103-461-8295	man	1967-11-07	Russia
7fd94df0-1a06-4540-9042-36e909db2efb	Tatyana Maggio	258-109-4176	woman	1995-07-05	Russia
bee55ca1-cc5d-4e4a-8d4a-249b86a86737	Jake Cormier	610-175-3498	woman	1988-06-21	Russia
fda19059-e00a-4a2d-b68c-d1a7512f1401	Monty Conn	695-710-4182	woman	1983-08-16	Russia
f0fc13f4-13a4-42c2-91f3-d5dffa49d43b	Candace Dickinson	107-524-9816	woman	1996-09-25	Russia
3b6e1bff-a157-4c5d-a200-b2565c7eb172	Jaclyn Parisian	109-263-4178	man	2004-03-08	Russia
ab9a61bf-60ef-4d02-a79a-e16e1eccd8d1	Jeanette Nolan	618-453-2910	woman	1999-01-11	Russia
dbc2bc60-18d7-40a5-b6b5-023999f69c7f	Lori Kub	436-891-2751	man	1972-02-15	Russia
fba1c228-3a75-413e-891e-5bddcffa2007	Florine Klein	811-056-3942	woman	2007-11-02	Russia
e56fad7f-f5b5-45f9-82d9-cfa6b761b8cb	Dessie Beier	184-356-9210	man	1999-03-23	Russia
d9a3e93c-865e-4cf3-9bee-c313bbe57610	Ashtyn Prosacco	542-710-1986	man	1975-03-18	Russia
5afd228f-e289-41e9-ac35-8239149a0eb9	Arlene Collier	761-089-5432	woman	2006-07-25	Russia
9f1bbc93-27a2-440b-8410-115241e1cd6c	Destany Ziemann	291-764-8510	woman	1976-06-09	Russia
8f5ff173-7446-43ca-a127-61e51fb2f744	Murray Kuphal	614-931-0725	woman	1998-09-21	Russia
ab2c6c39-d8f5-4af7-b020-e6eafca298eb	Orlo Borer	597-861-0312	man	1977-11-27	Russia
\.


--
-- Name: athlete_rating athlete_rating_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.athlete_rating
    ADD CONSTRAINT athlete_rating_pkey PRIMARY KEY (id);


--
-- Name: athletes athletes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.athletes
    ADD CONSTRAINT athletes_pkey PRIMARY KEY (athlete_id);


--
-- Name: coach_certifications coach_certifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coach_certifications
    ADD CONSTRAINT coach_certifications_pkey PRIMARY KEY (certification_id);


--
-- Name: coaches coaches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coaches
    ADD CONSTRAINT coaches_pkey PRIMARY KEY (coach_id);


--
-- Name: competition_applications competition_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.competition_applications
    ADD CONSTRAINT competition_applications_pkey PRIMARY KEY (application_id);


--
-- Name: competition_results competition_results_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.competition_results
    ADD CONSTRAINT competition_results_pkey PRIMARY KEY (result_id);


--
-- Name: competitions competitions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.competitions
    ADD CONSTRAINT competitions_pkey PRIMARY KEY (competition_id);


--
-- Name: completed_exercises completed_exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completed_exercises
    ADD CONSTRAINT completed_exercises_pkey PRIMARY KEY (completed_exercise_id);


--
-- Name: completed_sets completed_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completed_sets
    ADD CONSTRAINT completed_sets_pkey PRIMARY KEY (completed_set_id);


--
-- Name: device_data device_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.device_data
    ADD CONSTRAINT device_data_pkey PRIMARY KEY (data_id);


--
-- Name: devices devices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_pkey PRIMARY KEY (device_id);


--
-- Name: exercises exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_pkey PRIMARY KEY (exercise_id);


--
-- Name: favorites favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (favorite_id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: group_chat_members group_chat_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_chat_members
    ADD CONSTRAINT group_chat_members_pkey PRIMARY KEY (member_id);


--
-- Name: group_chats group_chats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_chats
    ADD CONSTRAINT group_chats_pkey PRIMARY KEY (group_chat_id);


--
-- Name: injuries injuries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.injuries
    ADD CONSTRAINT injuries_pkey PRIMARY KEY (injury_id);


--
-- Name: macro_cycles macro_cycles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.macro_cycles
    ADD CONSTRAINT macro_cycles_pkey PRIMARY KEY (macro_cycle_id);


--
-- Name: material_comments material_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material_comments
    ADD CONSTRAINT material_comments_pkey PRIMARY KEY (comment_id);


--
-- Name: materials materials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materials
    ADD CONSTRAINT materials_pkey PRIMARY KEY (material_id);


--
-- Name: medical_indicators medical_indicators_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medical_indicators
    ADD CONSTRAINT medical_indicators_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (message_id);


--
-- Name: micro_cycles micro_cycles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.micro_cycles
    ADD CONSTRAINT micro_cycles_pkey PRIMARY KEY (micro_cycle_id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notification_id);


--
-- Name: organizers organizers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizers
    ADD CONSTRAINT organizers_pkey PRIMARY KEY (organizer_id);


--
-- Name: pulse_zones pulse_zones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pulse_zones
    ADD CONSTRAINT pulse_zones_pkey PRIMARY KEY (zone_id);


--
-- Name: rehabilitation_programs rehabilitation_programs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rehabilitation_programs
    ADD CONSTRAINT rehabilitation_programs_pkey PRIMARY KEY (rehabilitation_program_id);


--
-- Name: schedules schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_pkey PRIMARY KEY (schedule_id);


--
-- Name: training_plans training_plans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_plans
    ADD CONSTRAINT training_plans_pkey PRIMARY KEY (training_plan_id);


--
-- Name: trainings trainings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainings
    ADD CONSTRAINT trainings_pkey PRIMARY KEY (training_id);


--
-- Name: user_credentials user_credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_credentials
    ADD CONSTRAINT user_credentials_pkey PRIMARY KEY (user_credentials_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: idx_athlete_rating_athlete_id_update_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_athlete_rating_athlete_id_update_date ON public.athlete_rating USING btree (athlete_id, update_date DESC);


--
-- Name: idx_athletes_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_athletes_user_id ON public.athletes USING btree (user_id);


--
-- Name: idx_coach_certifications_coach_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_coach_certifications_coach_id ON public.coach_certifications USING btree (coach_id);


--
-- Name: idx_coaches_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_coaches_user_id ON public.coaches USING btree (user_id);


--
-- Name: idx_competition_applications_competition_id_athlete_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_competition_applications_competition_id_athlete_id ON public.competition_applications USING btree (competition_id, athlete_id);


--
-- Name: idx_competitions_organizer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_competitions_organizer_id ON public.competitions USING btree (organizer_id);


--
-- Name: idx_device_data_device_id_timestamp; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_device_data_device_id_timestamp ON public.device_data USING btree (device_id, "timestamp" DESC);


--
-- Name: idx_devices_athlete_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_devices_athlete_id ON public.devices USING btree (athlete_id);


--
-- Name: idx_medical_indicators_athlete_id_measurement_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_medical_indicators_athlete_id_measurement_date ON public.medical_indicators USING btree (athlete_id, measurement_date DESC);


--
-- Name: idx_organizers_organizer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_organizers_organizer_id ON public.organizers USING btree (organizer_id);


--
-- Name: idx_training_plans_coach_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_training_plans_coach_id ON public.training_plans USING btree (coach_id);


--
-- Name: idx_trainings_athlete_id_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_trainings_athlete_id_date ON public.trainings USING btree (athlete_id, date DESC);


--
-- Name: idx_trainings_training_plan_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_trainings_training_plan_id ON public.trainings USING btree (training_plan_id);


--
-- Name: idx_users_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_user_id ON public.users USING btree (user_id);


--
-- Name: athlete_rating athlete_rating_athlete_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.athlete_rating
    ADD CONSTRAINT athlete_rating_athlete_id_fkey FOREIGN KEY (athlete_id) REFERENCES public.athletes(athlete_id);


--
-- Name: athletes athletes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.athletes
    ADD CONSTRAINT athletes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: coach_certifications coach_certifications_coach_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coach_certifications
    ADD CONSTRAINT coach_certifications_coach_id_fkey FOREIGN KEY (coach_id) REFERENCES public.coaches(coach_id);


--
-- Name: coaches coaches_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coaches
    ADD CONSTRAINT coaches_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: competition_applications competition_applications_athlete_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.competition_applications
    ADD CONSTRAINT competition_applications_athlete_id_fkey FOREIGN KEY (athlete_id) REFERENCES public.athletes(athlete_id);


--
-- Name: competition_applications competition_applications_competition_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.competition_applications
    ADD CONSTRAINT competition_applications_competition_id_fkey FOREIGN KEY (competition_id) REFERENCES public.competitions(competition_id);


--
-- Name: competition_results competition_results_athlete_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.competition_results
    ADD CONSTRAINT competition_results_athlete_id_fkey FOREIGN KEY (athlete_id) REFERENCES public.athletes(athlete_id);


--
-- Name: competition_results competition_results_competition_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.competition_results
    ADD CONSTRAINT competition_results_competition_id_fkey FOREIGN KEY (competition_id) REFERENCES public.competitions(competition_id);


--
-- Name: competitions competitions_organizer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.competitions
    ADD CONSTRAINT competitions_organizer_id_fkey FOREIGN KEY (organizer_id) REFERENCES public.organizers(organizer_id);


--
-- Name: completed_exercises completed_exercises_exercise_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completed_exercises
    ADD CONSTRAINT completed_exercises_exercise_id_fkey FOREIGN KEY (exercise_id) REFERENCES public.exercises(exercise_id);


--
-- Name: completed_exercises completed_exercises_training_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completed_exercises
    ADD CONSTRAINT completed_exercises_training_id_fkey FOREIGN KEY (training_id) REFERENCES public.trainings(training_id);


--
-- Name: completed_sets completed_sets_completed_exercise_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completed_sets
    ADD CONSTRAINT completed_sets_completed_exercise_id_fkey FOREIGN KEY (completed_exercise_id) REFERENCES public.completed_exercises(completed_exercise_id);


--
-- Name: device_data device_data_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.device_data
    ADD CONSTRAINT device_data_device_id_fkey FOREIGN KEY (device_id) REFERENCES public.devices(device_id);


--
-- Name: devices devices_athlete_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_athlete_id_fkey FOREIGN KEY (athlete_id) REFERENCES public.athletes(athlete_id);


--
-- Name: exercises exercises_training_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_training_plan_id_fkey FOREIGN KEY (training_plan_id) REFERENCES public.training_plans(training_plan_id);


--
-- Name: favorites favorites_material_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_material_id_fkey FOREIGN KEY (material_id) REFERENCES public.materials(material_id);


--
-- Name: favorites favorites_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: group_chat_members group_chat_members_group_chat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_chat_members
    ADD CONSTRAINT group_chat_members_group_chat_id_fkey FOREIGN KEY (group_chat_id) REFERENCES public.group_chats(group_chat_id);


--
-- Name: group_chat_members group_chat_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_chat_members
    ADD CONSTRAINT group_chat_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: injuries injuries_athlete_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.injuries
    ADD CONSTRAINT injuries_athlete_id_fkey FOREIGN KEY (athlete_id) REFERENCES public.athletes(athlete_id);


--
-- Name: macro_cycles macro_cycles_training_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.macro_cycles
    ADD CONSTRAINT macro_cycles_training_plan_id_fkey FOREIGN KEY (training_plan_id) REFERENCES public.training_plans(training_plan_id);


--
-- Name: material_comments material_comments_material_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material_comments
    ADD CONSTRAINT material_comments_material_id_fkey FOREIGN KEY (material_id) REFERENCES public.materials(material_id);


--
-- Name: material_comments material_comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material_comments
    ADD CONSTRAINT material_comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: medical_indicators medical_indicators_athlete_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medical_indicators
    ADD CONSTRAINT medical_indicators_athlete_id_fkey FOREIGN KEY (athlete_id) REFERENCES public.athletes(athlete_id);


--
-- Name: messages messages_group_chat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_group_chat_id_fkey FOREIGN KEY (group_chat_id) REFERENCES public.group_chats(group_chat_id);


--
-- Name: messages messages_receiver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_receiver_id_fkey FOREIGN KEY (receiver_id) REFERENCES public.users(user_id);


--
-- Name: messages messages_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(user_id);


--
-- Name: micro_cycles micro_cycles_training_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.micro_cycles
    ADD CONSTRAINT micro_cycles_training_plan_id_fkey FOREIGN KEY (training_plan_id) REFERENCES public.training_plans(training_plan_id);


--
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: organizers organizers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizers
    ADD CONSTRAINT organizers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: pulse_zones pulse_zones_training_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pulse_zones
    ADD CONSTRAINT pulse_zones_training_plan_id_fkey FOREIGN KEY (training_plan_id) REFERENCES public.training_plans(training_plan_id);


--
-- Name: rehabilitation_programs rehabilitation_programs_injury_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rehabilitation_programs
    ADD CONSTRAINT rehabilitation_programs_injury_id_fkey FOREIGN KEY (injury_id) REFERENCES public.injuries(injury_id);


--
-- Name: schedules schedules_competition_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_competition_id_fkey FOREIGN KEY (competition_id) REFERENCES public.competitions(competition_id);


--
-- Name: training_plans training_plans_coach_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_plans
    ADD CONSTRAINT training_plans_coach_id_fkey FOREIGN KEY (coach_id) REFERENCES public.coaches(coach_id);


--
-- Name: trainings trainings_athlete_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainings
    ADD CONSTRAINT trainings_athlete_id_fkey FOREIGN KEY (athlete_id) REFERENCES public.athletes(athlete_id);


--
-- Name: trainings trainings_training_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainings
    ADD CONSTRAINT trainings_training_plan_id_fkey FOREIGN KEY (training_plan_id) REFERENCES public.training_plans(training_plan_id);


--
-- Name: user_credentials user_credentials_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_credentials
    ADD CONSTRAINT user_credentials_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: TABLE athlete_rating; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.athlete_rating TO analytic;


--
-- Name: TABLE athletes; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.athletes TO analytic;


--
-- Name: TABLE coach_certifications; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.coach_certifications TO analytic;


--
-- Name: TABLE coaches; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.coaches TO analytic;


--
-- Name: TABLE competition_applications; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.competition_applications TO analytic;


--
-- Name: TABLE competition_results; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.competition_results TO analytic;


--
-- Name: TABLE competitions; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.competitions TO analytic;


--
-- Name: TABLE completed_exercises; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.completed_exercises TO analytic;


--
-- Name: TABLE completed_sets; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.completed_sets TO analytic;


--
-- Name: TABLE device_data; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.device_data TO analytic;


--
-- Name: TABLE devices; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.devices TO analytic;


--
-- Name: TABLE exercises; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.exercises TO analytic;


--
-- Name: TABLE favorites; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.favorites TO analytic;


--
-- Name: TABLE flyway_schema_history; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.flyway_schema_history TO analytic;


--
-- Name: TABLE group_chat_members; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.group_chat_members TO analytic;


--
-- Name: TABLE group_chats; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.group_chats TO analytic;


--
-- Name: TABLE injuries; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.injuries TO analytic;


--
-- Name: TABLE macro_cycles; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.macro_cycles TO analytic;


--
-- Name: TABLE material_comments; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.material_comments TO analytic;


--
-- Name: TABLE materials; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.materials TO analytic;


--
-- Name: TABLE medical_indicators; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.medical_indicators TO analytic;


--
-- Name: TABLE messages; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.messages TO analytic;


--
-- Name: TABLE micro_cycles; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.micro_cycles TO analytic;


--
-- Name: TABLE notifications; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.notifications TO analytic;


--
-- Name: TABLE organizers; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.organizers TO analytic;


--
-- Name: TABLE pulse_zones; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.pulse_zones TO analytic;


--
-- Name: TABLE rehabilitation_programs; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.rehabilitation_programs TO analytic;


--
-- Name: TABLE schedules; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.schedules TO analytic;


--
-- Name: TABLE training_plans; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.training_plans TO analytic;


--
-- Name: TABLE trainings; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.trainings TO analytic;


--
-- Name: TABLE user_credentials; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.user_credentials TO analytic;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.users TO analytic;


--
-- PostgreSQL database dump complete
--

