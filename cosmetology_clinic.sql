--
-- PostgreSQL database dump
--

-- Dumped from database version 17rc1
-- Dumped by pg_dump version 17rc1

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
-- Name: deduct_product_quantity(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.deduct_product_quantity() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  UPDATE products
  SET quantity = quantity - NEW.quantity
  WHERE id_product = NEW.id_product;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.deduct_product_quantity() OWNER TO postgres;

--
-- Name: set_request_date(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_request_date() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.request_date := now();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.set_request_date() OWNER TO postgres;

--
-- Name: update_last_modified(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_last_modified() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.last_update := now();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_last_modified() OWNER TO postgres;

--
-- Name: seq_call_requests; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_call_requests
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_call_requests OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: call_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.call_requests (
    id_request integer DEFAULT nextval('public.seq_call_requests'::regclass) NOT NULL,
    id_user integer NOT NULL,
    name character varying(50) NOT NULL,
    phone character varying(20) NOT NULL,
    comment character varying(500),
    request_date timestamp(0) without time zone NOT NULL,
    status character varying(50) NOT NULL,
    CONSTRAINT chk_status_valid CHECK (((status)::text = ANY ((ARRAY['новий'::character varying, 'оброблено'::character varying])::text[])))
);


ALTER TABLE public.call_requests OWNER TO postgres;

--
-- Name: seq_client; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_client
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_client OWNER TO postgres;

--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id_client integer DEFAULT nextval('public.seq_client'::regclass) NOT NULL,
    name character varying(50) NOT NULL,
    surname character varying(50) NOT NULL,
    patronymic character varying(50) NOT NULL,
    phone character varying(20) NOT NULL,
    birth_date date,
    id_user integer NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: seq_doctor; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_doctor
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_doctor OWNER TO postgres;

--
-- Name: doctor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doctor (
    id_doctor integer DEFAULT nextval('public.seq_doctor'::regclass) NOT NULL,
    id_user integer NOT NULL,
    name character varying(50) NOT NULL,
    surname character varying(50) NOT NULL,
    patronymic character varying(50) NOT NULL,
    phone character varying(20) NOT NULL,
    specialization character varying(250) NOT NULL,
    description character varying(500),
    experience integer NOT NULL,
    email character varying(30),
    address character varying(200) NOT NULL,
    diplomas character varying(500),
    photo character varying(500) NOT NULL,
    birth_date date
);


ALTER TABLE public.doctor OWNER TO postgres;

--
-- Name: seq_products; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_products
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_products OWNER TO postgres;

--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id_product integer DEFAULT nextval('public.seq_products'::regclass) NOT NULL,
    id_user integer NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(500),
    price integer NOT NULL,
    quantity integer NOT NULL,
    photo character varying(500) NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: seq_records; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_records
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_records OWNER TO postgres;

--
-- Name: records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.records (
    id_record integer DEFAULT nextval('public.seq_records'::regclass) NOT NULL,
    id_service integer NOT NULL,
    id_client integer NOT NULL,
    id_doctor integer NOT NULL,
    id_request integer NOT NULL,
    id_user integer NOT NULL,
    status character varying(50) NOT NULL,
    "date&time" timestamp(0) without time zone NOT NULL,
    comment character varying(500),
    payment_stat character varying(50) NOT NULL,
    CONSTRAINT chk_records_payment_stat CHECK (((payment_stat)::text = ANY ((ARRAY['оплачено'::character varying, 'не оплачено'::character varying])::text[]))),
    CONSTRAINT chk_records_status CHECK (((status)::text = ANY ((ARRAY['заплановано'::character varying, 'завершено'::character varying, 'скасовано'::character varying])::text[])))
);


ALTER TABLE public.records OWNER TO postgres;

--
-- Name: seq_reviews; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_reviews
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_reviews OWNER TO postgres;

--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    id_review integer DEFAULT nextval('public.seq_reviews'::regclass) NOT NULL,
    id_record integer NOT NULL,
    id_user integer NOT NULL,
    text character varying(500),
    rating integer NOT NULL,
    "dateRec" date
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- Name: seq_service_categories; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_service_categories
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_service_categories OWNER TO postgres;

--
-- Name: seq_services; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_services
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_services OWNER TO postgres;

--
-- Name: seq_used_products; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_used_products
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_used_products OWNER TO postgres;

--
-- Name: seq_user; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_user
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_user OWNER TO postgres;

--
-- Name: service_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service_categories (
    id_category integer DEFAULT nextval('public.seq_service_categories'::regclass) NOT NULL,
    id_user integer NOT NULL,
    name character varying(80) NOT NULL,
    type character varying(50) NOT NULL
);


ALTER TABLE public.service_categories OWNER TO postgres;

--
-- Name: services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.services (
    id_service integer DEFAULT nextval('public.seq_services'::regclass) NOT NULL,
    id_user integer NOT NULL,
    id_category integer NOT NULL,
    name character varying(50) NOT NULL,
    price integer NOT NULL,
    duration time(0) without time zone NOT NULL,
    description character varying(500)
);


ALTER TABLE public.services OWNER TO postgres;

--
-- Name: used_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.used_products (
    id_used integer DEFAULT nextval('public.seq_used_products'::regclass) NOT NULL,
    id_user integer NOT NULL,
    id_record integer NOT NULL,
    id_product integer NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.used_products OWNER TO postgres;

--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id_user integer DEFAULT nextval('public.seq_user'::regclass) NOT NULL,
    ip_user integer NOT NULL,
    last_update timestamp(0) without time zone
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: view_record_summary; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_record_summary AS
 SELECT r.id_record,
    (((cl.name)::text || ' '::text) || (cl.surname)::text) AS client,
    (((d.name)::text || ' '::text) || (d.surname)::text) AS doctor,
    s.name AS service,
    r."date&time" AS appointment_time,
    r.status,
    r.payment_stat
   FROM (((public.records r
     JOIN public.client cl ON ((r.id_client = cl.id_client)))
     JOIN public.doctor d ON ((r.id_doctor = d.id_doctor)))
     JOIN public.services s ON ((r.id_service = s.id_service)));


ALTER VIEW public.view_record_summary OWNER TO postgres;

--
-- Name: view_reviews_detailed; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_reviews_detailed AS
 SELECT rv.id_review,
    s.name AS service_name,
    (((cl.name)::text || ' '::text) || (cl.surname)::text) AS client_name,
    rv.text,
    rv.rating,
    rv."dateRec"
   FROM (((public.reviews rv
     JOIN public.records r ON ((rv.id_record = r.id_record)))
     JOIN public.client cl ON ((r.id_client = cl.id_client)))
     JOIN public.services s ON ((r.id_service = s.id_service)));


ALTER VIEW public.view_reviews_detailed OWNER TO postgres;

--
-- Data for Name: call_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.call_requests (id_request, id_user, name, phone, comment, request_date, status) FROM stdin;
1	1	Ірина	+380961234567	Хочу записатися на ботокс	2025-05-23 15:47:13	новий
2	3	Оксана	+380931112233	Запис на консультацію	2025-05-23 18:02:07	новий
3	4	Андрій	+380991234567	Хочу зробити ботокс	2025-05-23 18:02:07	новий
4	5	Юлія	+380931111222	Цікавить епіляція	2025-05-23 18:02:07	новий
5	6	Ігор	+380931115511	Шкіра після процедури свербить	2025-05-23 18:02:07	оброблено
6	7	Наталя	+380981113311	Контурна пластика губ	2025-05-23 18:02:07	новий
7	8	Тетяна	+380991234990	Фотолікування	2025-05-23 18:02:07	новий
8	1	Оксана	+380987654321	Запис на процедуру	2025-05-25 23:23:30	новий
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id_client, name, surname, patronymic, phone, birth_date, id_user) FROM stdin;
1	Марія	Коваленко	Іванівна	+380971112233	1990-05-15	1
2	Оксана	Іваненко	Юріївна	+380931112233	1987-03-10	3
3	Андрій	Мельник	Олександрович	+380991234567	1992-12-21	4
4	Юлія	Стельмах	Петрівна	+380931111222	1995-07-18	5
5	Ігор	Кравченко	Богданович	+380931115511	1991-02-28	6
6	Наталя	Гаврилюк	Олексіївна	+380981113311	1990-10-10	7
7	Тетяна	Романенко	Сергіївна	+380991234990	1989-08-15	8
\.


--
-- Data for Name: doctor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.doctor (id_doctor, id_user, name, surname, patronymic, phone, specialization, description, experience, email, address, diplomas, photo, birth_date) FROM stdin;
1	2	Олег	Петренко	Сергійович	+380981112233	Дерматолог	Досвідчений спеціаліст з лазерної терапії	12	oleg@clinic.com	Київ, вул. Лазерна, 10	https://drive.google.com/uc?id=dip1	https://drive.google.com/uc?id=1AbCDefGhIjKlmnOpQrStuVwXyZ	1985-04-22
2	3	Наталія	Захарова	Валеріївна	+380991239999	Косметолог	Фахівець з контурної пластики	8	natalia@clinic.com	Київ, вул. Краси, 12	https://drive.google.com/uc?id=dip2	https://drive.google.com/uc?id=example1	1987-06-17
3	4	Ігор	Самойленко	Ігорович	+380971239911	Трихолог	Досвід в лікуванні волосся	10	samoylenko@clinic.com	Львів, вул. Клінічна, 5	https://drive.google.com/uc?id=dip3	https://drive.google.com/uc?id=example2	1984-11-11
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id_product, id_user, name, description, price, quantity, photo) FROM stdin;
1	1	Гель для шкіри	Заспокійливий гель після лазерної епіляції	200	13	https://drive.google.com/uc?id=1AbCDefGhIjKlmn
\.


--
-- Data for Name: records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.records (id_record, id_service, id_client, id_doctor, id_request, id_user, status, "date&time", comment, payment_stat) FROM stdin;
1	2	1	1	1	1	заплановано	2025-06-01 14:00:00	Побажання: знеболення	не оплачено
2	1	2	1	2	3	завершено	2025-06-03 10:00:00	Все вчасно	оплачено
3	2	3	2	3	4	заплановано	2025-06-05 13:30:00	Прошу без анестезії	не оплачено
4	1	4	1	4	5	заплановано	2025-06-06 15:00:00	\N	не оплачено
5	2	6	3	6	7	завершено	2025-06-07 11:30:00	Дякую за консультацію	оплачено
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (id_review, id_record, id_user, text, rating, "dateRec") FROM stdin;
1	1	1	Дуже вдячна лікарю Олегу! Все пройшло чудово!	5	2025-06-02
2	2	3	Сервіс чудовий, результат видно відразу!	5	2025-06-04
3	5	7	Процедура пройшла швидко й безболісно	4	2025-06-08
5	2	2	aaa	5	\N
7	2	3	aaa	5	\N
\.


--
-- Data for Name: service_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.service_categories (id_category, id_user, name, type) FROM stdin;
1	1	Лазерні процедури	Апаратні
2	1	Ін`єкційні процедури	Ін`єкційні
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.services (id_service, id_user, id_category, name, price, duration, description) FROM stdin;
1	1	1	Лазерна епіляція	1000	00:30:00	Процедура видалення волосся лазером
2	1	2	Ботокс	1500	00:20:00	Ін`єкція ботоксу для розгладження зморшок
\.


--
-- Data for Name: used_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.used_products (id_used, id_user, id_record, id_product, quantity) FROM stdin;
1	1	1	1	1
2	3	2	1	1
3	4	3	1	1
4	7	5	1	2
5	1	1	1	2
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id_user, ip_user, last_update) FROM stdin;
2	987654321	2025-05-23 15:44:35
3	111222333	2025-05-23 18:01:41
4	222333444	2025-05-23 18:01:41
5	333444555	2025-05-23 18:01:41
6	444555666	2025-05-23 18:01:41
7	555666777	2025-05-23 18:01:41
8	666777888	2025-05-23 18:01:41
1	111111111	2025-05-25 23:13:40
\.


--
-- Name: seq_call_requests; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_call_requests', 8, true);


--
-- Name: seq_client; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_client', 7, true);


--
-- Name: seq_doctor; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_doctor', 3, true);


--
-- Name: seq_products; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_products', 1, true);


--
-- Name: seq_records; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_records', 5, true);


--
-- Name: seq_reviews; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_reviews', 7, true);


--
-- Name: seq_service_categories; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_service_categories', 2, true);


--
-- Name: seq_services; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_services', 2, true);


--
-- Name: seq_used_products; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_used_products', 5, true);


--
-- Name: seq_user; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_user', 8, true);


--
-- Name: call_requests call_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.call_requests
    ADD CONSTRAINT call_requests_pkey PRIMARY KEY (id_request);


--
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id_client);


--
-- Name: doctor doctor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_pkey PRIMARY KEY (id_doctor);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id_product);


--
-- Name: records records_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.records
    ADD CONSTRAINT records_pkey PRIMARY KEY (id_record);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id_review);


--
-- Name: service_categories service_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_categories
    ADD CONSTRAINT service_categories_pkey PRIMARY KEY (id_category);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id_service);


--
-- Name: records unique_id_request; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.records
    ADD CONSTRAINT unique_id_request UNIQUE (id_request);


--
-- Name: used_products used_products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.used_products
    ADD CONSTRAINT used_products_pkey PRIMARY KEY (id_used);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id_user);


--
-- Name: fki_fk_category_services; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_category_services ON public.services USING btree (id_category);


--
-- Name: fki_fk_client_records; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_client_records ON public.records USING btree (id_client);


--
-- Name: fki_fk_doctor_records; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_doctor_records ON public.records USING btree (id_doctor);


--
-- Name: fki_fk_products_used; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_products_used ON public.used_products USING btree (id_product);


--
-- Name: fki_fk_record_used; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_record_used ON public.used_products USING btree (id_record);


--
-- Name: fki_fk_requests_records; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_requests_records ON public.records USING btree (id_request);


--
-- Name: fki_fk_service_records; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_service_records ON public.records USING btree (id_service);


--
-- Name: fki_fk_user_category; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_user_category ON public.service_categories USING btree (id_user);


--
-- Name: fki_fk_user_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_user_client ON public.client USING btree (id_user);


--
-- Name: fki_fk_user_doctor; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_user_doctor ON public.doctor USING btree (id_user);


--
-- Name: fki_fk_user_products; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_user_products ON public.products USING btree (id_user);


--
-- Name: fki_fk_user_records; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_user_records ON public.records USING btree (id_user);


--
-- Name: fki_fk_user_request; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_user_request ON public.call_requests USING btree (id_user);


--
-- Name: fki_fk_user_reviews; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_user_reviews ON public.reviews USING btree (id_user);


--
-- Name: fki_fk_user_services; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_user_services ON public.services USING btree (id_user);


--
-- Name: fki_fk_user_used; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_user_used ON public.used_products USING btree (id_user);


--
-- Name: used_products trg_deduct_product_quantity; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_deduct_product_quantity AFTER INSERT ON public.used_products FOR EACH ROW EXECUTE FUNCTION public.deduct_product_quantity();


--
-- Name: call_requests trg_set_request_date; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_set_request_date BEFORE INSERT ON public.call_requests FOR EACH ROW EXECUTE FUNCTION public.set_request_date();


--
-- Name: user trg_update_user; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_update_user BEFORE UPDATE ON public."user" FOR EACH ROW EXECUTE FUNCTION public.update_last_modified();


--
-- Name: services fk_category_services; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT fk_category_services FOREIGN KEY (id_category) REFERENCES public.service_categories(id_category) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: records fk_client_records; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.records
    ADD CONSTRAINT fk_client_records FOREIGN KEY (id_client) REFERENCES public.client(id_client) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: records fk_doctor_records; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.records
    ADD CONSTRAINT fk_doctor_records FOREIGN KEY (id_doctor) REFERENCES public.doctor(id_doctor) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: used_products fk_products_used; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.used_products
    ADD CONSTRAINT fk_products_used FOREIGN KEY (id_product) REFERENCES public.products(id_product) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: used_products fk_record_used; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.used_products
    ADD CONSTRAINT fk_record_used FOREIGN KEY (id_record) REFERENCES public.records(id_record) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: reviews fk_records_reviews; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_records_reviews FOREIGN KEY (id_record) REFERENCES public.records(id_record) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: records fk_requests_records; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.records
    ADD CONSTRAINT fk_requests_records FOREIGN KEY (id_request) REFERENCES public.call_requests(id_request) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: records fk_service_records; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.records
    ADD CONSTRAINT fk_service_records FOREIGN KEY (id_service) REFERENCES public.services(id_service) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: service_categories fk_user_category; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_categories
    ADD CONSTRAINT fk_user_category FOREIGN KEY (id_user) REFERENCES public."user"(id_user) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: client fk_user_client; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT fk_user_client FOREIGN KEY (id_user) REFERENCES public."user"(id_user) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: doctor fk_user_doctor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT fk_user_doctor FOREIGN KEY (id_user) REFERENCES public."user"(id_user) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: products fk_user_products; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk_user_products FOREIGN KEY (id_user) REFERENCES public."user"(id_user) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: records fk_user_records; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.records
    ADD CONSTRAINT fk_user_records FOREIGN KEY (id_user) REFERENCES public."user"(id_user) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: call_requests fk_user_request; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.call_requests
    ADD CONSTRAINT fk_user_request FOREIGN KEY (id_user) REFERENCES public."user"(id_user) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: reviews fk_user_reviews; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_user_reviews FOREIGN KEY (id_user) REFERENCES public."user"(id_user) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: services fk_user_services; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT fk_user_services FOREIGN KEY (id_user) REFERENCES public."user"(id_user) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: used_products fk_user_used; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.used_products
    ADD CONSTRAINT fk_user_used FOREIGN KEY (id_user) REFERENCES public."user"(id_user) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

