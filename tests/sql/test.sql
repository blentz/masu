--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 10.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: testcustomer; Type: SCHEMA; Schema: -; Owner: kokuadmin
--

CREATE SCHEMA testcustomer;


ALTER SCHEMA testcustomer OWNER TO kokuadmin;

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
-- Name: api_customer; Type: TABLE; Schema: public; Owner: kokuadmin
--

CREATE TABLE api_customer (
    group_ptr_id integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    owner_id integer,
    uuid uuid NOT NULL,
    schema_name text NOT NULL
);


ALTER TABLE api_customer OWNER TO kokuadmin;

--
-- Name: api_provider; Type: TABLE; Schema: public; Owner: kokuadmin
--

CREATE TABLE api_provider (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    name character varying(256) NOT NULL,
    type character varying(50) NOT NULL,
    authentication_id integer,
    billing_source_id integer,
    created_by_id integer,
    customer_id integer
);


ALTER TABLE api_provider OWNER TO kokuadmin;

--
-- Name: api_provider_id_seq; Type: SEQUENCE; Schema: public; Owner: kokuadmin
--

CREATE SEQUENCE api_provider_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE api_provider_id_seq OWNER TO kokuadmin;

--
-- Name: api_provider_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kokuadmin
--

ALTER SEQUENCE api_provider_id_seq OWNED BY api_provider.id;


--
-- Name: api_providerauthentication; Type: TABLE; Schema: public; Owner: kokuadmin
--

CREATE TABLE api_providerauthentication (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    provider_resource_name text NOT NULL
);


ALTER TABLE api_providerauthentication OWNER TO kokuadmin;

--
-- Name: api_providerauthentication_id_seq; Type: SEQUENCE; Schema: public; Owner: kokuadmin
--

CREATE SEQUENCE api_providerauthentication_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE api_providerauthentication_id_seq OWNER TO kokuadmin;

--
-- Name: api_providerauthentication_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kokuadmin
--

ALTER SEQUENCE api_providerauthentication_id_seq OWNED BY api_providerauthentication.id;


--
-- Name: api_providerbillingsource; Type: TABLE; Schema: public; Owner: kokuadmin
--

CREATE TABLE api_providerbillingsource (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    bucket character varying(63) NOT NULL
);


ALTER TABLE api_providerbillingsource OWNER TO kokuadmin;

--
-- Name: api_providerbillingsource_id_seq; Type: SEQUENCE; Schema: public; Owner: kokuadmin
--

CREATE SEQUENCE api_providerbillingsource_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE api_providerbillingsource_id_seq OWNER TO kokuadmin;

--
-- Name: api_providerbillingsource_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kokuadmin
--

ALTER SEQUENCE api_providerbillingsource_id_seq OWNED BY api_providerbillingsource.id;


--
-- Name: api_resettoken; Type: TABLE; Schema: public; Owner: kokuadmin
--

CREATE TABLE api_resettoken (
    id integer NOT NULL,
    token uuid NOT NULL,
    expiration_date timestamp with time zone NOT NULL,
    used boolean NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE api_resettoken OWNER TO kokuadmin;

--
-- Name: api_resettoken_id_seq; Type: SEQUENCE; Schema: public; Owner: kokuadmin
--

CREATE SEQUENCE api_resettoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE api_resettoken_id_seq OWNER TO kokuadmin;

--
-- Name: api_resettoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kokuadmin
--

ALTER SEQUENCE api_resettoken_id_seq OWNED BY api_resettoken.id;


--
-- Name: api_status; Type: TABLE; Schema: public; Owner: kokuadmin
--

CREATE TABLE api_status (
    id integer NOT NULL,
    server_id uuid NOT NULL
);


ALTER TABLE api_status OWNER TO kokuadmin;

--
-- Name: api_status_id_seq; Type: SEQUENCE; Schema: public; Owner: kokuadmin
--

CREATE SEQUENCE api_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE api_status_id_seq OWNER TO kokuadmin;

--
-- Name: api_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kokuadmin
--

ALTER SEQUENCE api_status_id_seq OWNED BY api_status.id;


--
-- Name: api_tenant; Type: TABLE; Schema: public; Owner: kokuadmin
--

CREATE TABLE api_tenant (
    id integer NOT NULL,
    schema_name character varying(63) NOT NULL
);


ALTER TABLE api_tenant OWNER TO kokuadmin;

--
-- Name: api_tenant_id_seq; Type: SEQUENCE; Schema: public; Owner: kokuadmin
--

CREATE SEQUENCE api_tenant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE api_tenant_id_seq OWNER TO kokuadmin;

--
-- Name: api_tenant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kokuadmin
--

ALTER SEQUENCE api_tenant_id_seq OWNED BY api_tenant.id;


--
-- Name: api_user; Type: TABLE; Schema: public; Owner: kokuadmin
--

CREATE TABLE api_user (
    user_ptr_id integer NOT NULL,
    uuid uuid NOT NULL
);


ALTER TABLE api_user OWNER TO kokuadmin;

--
-- Name: api_userpreference; Type: TABLE; Schema: public; Owner: kokuadmin
--

CREATE TABLE api_userpreference (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    preference jsonb NOT NULL,
    user_id integer NOT NULL,
    description character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE api_userpreference OWNER TO kokuadmin;

--
-- Name: api_userpreference_id_seq; Type: SEQUENCE; Schema: public; Owner: kokuadmin
--

CREATE SEQUENCE api_userpreference_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE api_userpreference_id_seq OWNER TO kokuadmin;

--
-- Name: api_userpreference_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kokuadmin
--

ALTER SEQUENCE api_userpreference_id_seq OWNED BY api_userpreference.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: kokuadmin
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE auth_group OWNER TO kokuadmin;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: kokuadmin
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_id_seq OWNER TO kokuadmin;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kokuadmin
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: kokuadmin
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_group_permissions OWNER TO kokuadmin;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: kokuadmin
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_permissions_id_seq OWNER TO kokuadmin;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kokuadmin
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: kokuadmin
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE auth_permission OWNER TO kokuadmin;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: kokuadmin
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_permission_id_seq OWNER TO kokuadmin;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kokuadmin
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: kokuadmin
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE auth_user OWNER TO kokuadmin;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: kokuadmin
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE auth_user_groups OWNER TO kokuadmin;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: kokuadmin
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_groups_id_seq OWNER TO kokuadmin;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kokuadmin
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: kokuadmin
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_id_seq OWNER TO kokuadmin;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kokuadmin
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: kokuadmin
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_user_user_permissions OWNER TO kokuadmin;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: kokuadmin
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_user_permissions_id_seq OWNER TO kokuadmin;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kokuadmin
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: kokuadmin
--

CREATE TABLE authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE authtoken_token OWNER TO kokuadmin;

--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: kokuadmin
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE django_admin_log OWNER TO kokuadmin;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: kokuadmin
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_admin_log_id_seq OWNER TO kokuadmin;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kokuadmin
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: kokuadmin
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE django_content_type OWNER TO kokuadmin;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: kokuadmin
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_content_type_id_seq OWNER TO kokuadmin;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kokuadmin
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: kokuadmin
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE django_migrations OWNER TO kokuadmin;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: kokuadmin
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_migrations_id_seq OWNER TO kokuadmin;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kokuadmin
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: kokuadmin
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE django_session OWNER TO kokuadmin;

SET search_path = testcustomer, pg_catalog;

--
-- Name: django_migrations; Type: TABLE; Schema: testcustomer; Owner: kokuadmin
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE django_migrations OWNER TO kokuadmin;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: testcustomer; Owner: kokuadmin
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_migrations_id_seq OWNER TO kokuadmin;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: testcustomer; Owner: kokuadmin
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: reporting_awscostentry; Type: TABLE; Schema: testcustomer; Owner: kokuadmin
--

CREATE TABLE reporting_awscostentry (
    id integer NOT NULL,
    interval_start timestamp with time zone NOT NULL,
    interval_end timestamp with time zone NOT NULL,
    bill_id integer NOT NULL
);


ALTER TABLE reporting_awscostentry OWNER TO kokuadmin;

--
-- Name: reporting_awscostentry_id_seq; Type: SEQUENCE; Schema: testcustomer; Owner: kokuadmin
--

CREATE SEQUENCE reporting_awscostentry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reporting_awscostentry_id_seq OWNER TO kokuadmin;

--
-- Name: reporting_awscostentry_id_seq; Type: SEQUENCE OWNED BY; Schema: testcustomer; Owner: kokuadmin
--

ALTER SEQUENCE reporting_awscostentry_id_seq OWNED BY reporting_awscostentry.id;


--
-- Name: reporting_awscostentrybill; Type: TABLE; Schema: testcustomer; Owner: kokuadmin
--

CREATE TABLE reporting_awscostentrybill (
    id integer NOT NULL,
    billing_resource character varying(50) NOT NULL,
    bill_type character varying(50) NOT NULL,
    payer_account_id character varying(50) NOT NULL,
    billing_period_start timestamp with time zone NOT NULL,
    billing_period_end timestamp with time zone NOT NULL
);


ALTER TABLE reporting_awscostentrybill OWNER TO kokuadmin;

--
-- Name: reporting_awscostentrybill_id_seq; Type: SEQUENCE; Schema: testcustomer; Owner: kokuadmin
--

CREATE SEQUENCE reporting_awscostentrybill_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reporting_awscostentrybill_id_seq OWNER TO kokuadmin;

--
-- Name: reporting_awscostentrybill_id_seq; Type: SEQUENCE OWNED BY; Schema: testcustomer; Owner: kokuadmin
--

ALTER SEQUENCE reporting_awscostentrybill_id_seq OWNED BY reporting_awscostentrybill.id;


--
-- Name: reporting_awscostentrylineitem; Type: TABLE; Schema: testcustomer; Owner: kokuadmin
--

CREATE TABLE reporting_awscostentrylineitem (
    id bigint NOT NULL,
    tags jsonb NOT NULL,
    invoice_id character varying(63) NOT NULL,
    line_item_type character varying(50) NOT NULL,
    usage_account_id character varying(50) NOT NULL,
    usage_start timestamp with time zone NOT NULL,
    usage_end timestamp with time zone NOT NULL,
    product_code character varying(50) NOT NULL,
    usage_type character varying(50) NOT NULL,
    operation character varying(50) NOT NULL,
    availability_zone character varying(50) NOT NULL,
    resource_id character varying(50) NOT NULL,
    usage_amount integer NOT NULL,
    normalization_factor integer NOT NULL,
    normalized_usage_amount integer NOT NULL,
    currency_code character varying(10) NOT NULL,
    unblended_rate double precision NOT NULL,
    unblended_cost double precision NOT NULL,
    blended_rate double precision NOT NULL,
    blended_cost double precision NOT NULL,
    tax_type text NOT NULL,
    cost_entry_id integer NOT NULL,
    cost_entry_bill_id integer NOT NULL,
    cost_entry_pricing_id integer NOT NULL,
    cost_entry_product_id integer NOT NULL,
    cost_entry_reservation_id integer NOT NULL,
    CONSTRAINT reporting_awscostentrylineitem_normalization_factor_check CHECK ((normalization_factor >= 0)),
    CONSTRAINT reporting_awscostentrylineitem_normalized_usage_amount_check CHECK ((normalized_usage_amount >= 0)),
    CONSTRAINT reporting_awscostentrylineitem_usage_amount_check CHECK ((usage_amount >= 0))
);


ALTER TABLE reporting_awscostentrylineitem OWNER TO kokuadmin;

--
-- Name: reporting_awscostentrylineitem_id_seq; Type: SEQUENCE; Schema: testcustomer; Owner: kokuadmin
--

CREATE SEQUENCE reporting_awscostentrylineitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reporting_awscostentrylineitem_id_seq OWNER TO kokuadmin;

--
-- Name: reporting_awscostentrylineitem_id_seq; Type: SEQUENCE OWNED BY; Schema: testcustomer; Owner: kokuadmin
--

ALTER SEQUENCE reporting_awscostentrylineitem_id_seq OWNED BY reporting_awscostentrylineitem.id;


--
-- Name: reporting_awscostentrypricing; Type: TABLE; Schema: testcustomer; Owner: kokuadmin
--

CREATE TABLE reporting_awscostentrypricing (
    id integer NOT NULL,
    public_on_demand_cost double precision NOT NULL,
    public_on_demand_rate double precision NOT NULL,
    term character varying(50) NOT NULL,
    unit character varying(24) NOT NULL,
    line_item_id bigint NOT NULL
);


ALTER TABLE reporting_awscostentrypricing OWNER TO kokuadmin;

--
-- Name: reporting_awscostentrypricing_id_seq; Type: SEQUENCE; Schema: testcustomer; Owner: kokuadmin
--

CREATE SEQUENCE reporting_awscostentrypricing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reporting_awscostentrypricing_id_seq OWNER TO kokuadmin;

--
-- Name: reporting_awscostentrypricing_id_seq; Type: SEQUENCE OWNED BY; Schema: testcustomer; Owner: kokuadmin
--

ALTER SEQUENCE reporting_awscostentrypricing_id_seq OWNED BY reporting_awscostentrypricing.id;


--
-- Name: reporting_awscostentryproduct; Type: TABLE; Schema: testcustomer; Owner: kokuadmin
--

CREATE TABLE reporting_awscostentryproduct (
    id integer NOT NULL,
    sku character varying(128) NOT NULL,
    product_name character varying(63) NOT NULL,
    product_family character varying(150) NOT NULL,
    service_code character varying(50) NOT NULL,
    region character varying(50) NOT NULL,
    instance_type character varying(50) NOT NULL,
    memory integer NOT NULL,
    vcpu integer NOT NULL,
    CONSTRAINT reporting_awscostentryproduct_memory_check CHECK ((memory >= 0)),
    CONSTRAINT reporting_awscostentryproduct_vcpu_check CHECK ((vcpu >= 0))
);


ALTER TABLE reporting_awscostentryproduct OWNER TO kokuadmin;

--
-- Name: reporting_awscostentryproduct_id_seq; Type: SEQUENCE; Schema: testcustomer; Owner: kokuadmin
--

CREATE SEQUENCE reporting_awscostentryproduct_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reporting_awscostentryproduct_id_seq OWNER TO kokuadmin;

--
-- Name: reporting_awscostentryproduct_id_seq; Type: SEQUENCE OWNED BY; Schema: testcustomer; Owner: kokuadmin
--

ALTER SEQUENCE reporting_awscostentryproduct_id_seq OWNED BY reporting_awscostentryproduct.id;


--
-- Name: reporting_awscostentryreservation; Type: TABLE; Schema: testcustomer; Owner: kokuadmin
--

CREATE TABLE reporting_awscostentryreservation (
    id integer NOT NULL,
    reservation_arn text NOT NULL,
    availability_zone character varying(50) NOT NULL,
    number_of_reservations integer NOT NULL,
    units_per_reservation integer NOT NULL,
    amortized_upfront_fee double precision NOT NULL,
    amortized_upfront_cost_for_usage double precision NOT NULL,
    recurring_fee_for_usage double precision NOT NULL,
    unused_quantity integer NOT NULL,
    unused_recurring_fee double precision NOT NULL,
    CONSTRAINT reporting_awscostentryreservation_number_of_reservations_check CHECK ((number_of_reservations >= 0)),
    CONSTRAINT reporting_awscostentryreservation_units_per_reservation_check CHECK ((units_per_reservation >= 0)),
    CONSTRAINT reporting_awscostentryreservation_unused_quantity_check CHECK ((unused_quantity >= 0))
);


ALTER TABLE reporting_awscostentryreservation OWNER TO kokuadmin;

--
-- Name: reporting_awscostentryreservation_id_seq; Type: SEQUENCE; Schema: testcustomer; Owner: kokuadmin
--

CREATE SEQUENCE reporting_awscostentryreservation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reporting_awscostentryreservation_id_seq OWNER TO kokuadmin;

--
-- Name: reporting_awscostentryreservation_id_seq; Type: SEQUENCE OWNED BY; Schema: testcustomer; Owner: kokuadmin
--

ALTER SEQUENCE reporting_awscostentryreservation_id_seq OWNED BY reporting_awscostentryreservation.id;


SET search_path = public, pg_catalog;

--
-- Name: api_provider id; Type: DEFAULT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_provider ALTER COLUMN id SET DEFAULT nextval('api_provider_id_seq'::regclass);


--
-- Name: api_providerauthentication id; Type: DEFAULT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_providerauthentication ALTER COLUMN id SET DEFAULT nextval('api_providerauthentication_id_seq'::regclass);


--
-- Name: api_providerbillingsource id; Type: DEFAULT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_providerbillingsource ALTER COLUMN id SET DEFAULT nextval('api_providerbillingsource_id_seq'::regclass);


--
-- Name: api_resettoken id; Type: DEFAULT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_resettoken ALTER COLUMN id SET DEFAULT nextval('api_resettoken_id_seq'::regclass);


--
-- Name: api_status id; Type: DEFAULT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_status ALTER COLUMN id SET DEFAULT nextval('api_status_id_seq'::regclass);


--
-- Name: api_tenant id; Type: DEFAULT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_tenant ALTER COLUMN id SET DEFAULT nextval('api_tenant_id_seq'::regclass);


--
-- Name: api_userpreference id; Type: DEFAULT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_userpreference ALTER COLUMN id SET DEFAULT nextval('api_userpreference_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


SET search_path = testcustomer, pg_catalog;

--
-- Name: django_migrations id; Type: DEFAULT; Schema: testcustomer; Owner: kokuadmin
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: reporting_awscostentry id; Type: DEFAULT; Schema: testcustomer; Owner: kokuadmin
--

ALTER TABLE ONLY reporting_awscostentry ALTER COLUMN id SET DEFAULT nextval('reporting_awscostentry_id_seq'::regclass);


--
-- Name: reporting_awscostentrybill id; Type: DEFAULT; Schema: testcustomer; Owner: kokuadmin
--

ALTER TABLE ONLY reporting_awscostentrybill ALTER COLUMN id SET DEFAULT nextval('reporting_awscostentrybill_id_seq'::regclass);


--
-- Name: reporting_awscostentrylineitem id; Type: DEFAULT; Schema: testcustomer; Owner: kokuadmin
--

ALTER TABLE ONLY reporting_awscostentrylineitem ALTER COLUMN id SET DEFAULT nextval('reporting_awscostentrylineitem_id_seq'::regclass);


--
-- Name: reporting_awscostentrypricing id; Type: DEFAULT; Schema: testcustomer; Owner: kokuadmin
--

ALTER TABLE ONLY reporting_awscostentrypricing ALTER COLUMN id SET DEFAULT nextval('reporting_awscostentrypricing_id_seq'::regclass);


--
-- Name: reporting_awscostentryproduct id; Type: DEFAULT; Schema: testcustomer; Owner: kokuadmin
--

ALTER TABLE ONLY reporting_awscostentryproduct ALTER COLUMN id SET DEFAULT nextval('reporting_awscostentryproduct_id_seq'::regclass);


--
-- Name: reporting_awscostentryreservation id; Type: DEFAULT; Schema: testcustomer; Owner: kokuadmin
--

ALTER TABLE ONLY reporting_awscostentryreservation ALTER COLUMN id SET DEFAULT nextval('reporting_awscostentryreservation_id_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- Data for Name: api_customer; Type: TABLE DATA; Schema: public; Owner: kokuadmin
--

COPY api_customer (group_ptr_id, date_created, owner_id, uuid, schema_name) FROM stdin;
1	2018-06-07 13:44:02.612434+00	2	edf94475-235e-4b64-ba18-0b81f2de9c9e	testcustomer
\.


--
-- Data for Name: api_provider; Type: TABLE DATA; Schema: public; Owner: kokuadmin
--

COPY api_provider (id, uuid, name, type, authentication_id, billing_source_id, created_by_id, customer_id) FROM stdin;
\.


--
-- Data for Name: api_providerauthentication; Type: TABLE DATA; Schema: public; Owner: kokuadmin
--

COPY api_providerauthentication (id, uuid, provider_resource_name) FROM stdin;
\.


--
-- Data for Name: api_providerbillingsource; Type: TABLE DATA; Schema: public; Owner: kokuadmin
--

COPY api_providerbillingsource (id, uuid, bucket) FROM stdin;
\.


--
-- Data for Name: api_resettoken; Type: TABLE DATA; Schema: public; Owner: kokuadmin
--

COPY api_resettoken (id, token, expiration_date, used, user_id) FROM stdin;
1	f150f5bf-dc1d-4f63-bed2-4f4da334f39e	2018-06-08 13:44:02.398458+00	f	2
\.


--
-- Data for Name: api_status; Type: TABLE DATA; Schema: public; Owner: kokuadmin
--

COPY api_status (id, server_id) FROM stdin;
1	9bbbdff1-7456-4f33-a084-57351d423c2f
\.


--
-- Data for Name: api_tenant; Type: TABLE DATA; Schema: public; Owner: kokuadmin
--

COPY api_tenant (id, schema_name) FROM stdin;
1	public
2	testcustomer
\.


--
-- Data for Name: api_user; Type: TABLE DATA; Schema: public; Owner: kokuadmin
--

COPY api_user (user_ptr_id, uuid) FROM stdin;
1	6920184c-02a0-43b7-838e-09d4cd744ffd
2	3990c197-caba-4f8f-a551-63c764b8c122
\.


--
-- Data for Name: api_userpreference; Type: TABLE DATA; Schema: public; Owner: kokuadmin
--

COPY api_userpreference (id, uuid, preference, user_id, description, name) FROM stdin;
1	382830d7-b53f-4d31-910b-3bd49d166a9b	{"currency": "USD"}	2	default preference	currency
2	b873fc37-1dff-457d-9b22-ae115f5cc2dc	{"timezone": "UTC"}	2	default preference	timezone
3	4ebded82-9497-4ecf-a16c-6b52ddef58f4	{"locale": "en_US.UTF-8"}	2	default preference	locale
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: kokuadmin
--

COPY auth_group (id, name) FROM stdin;
1	Test Customer
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: kokuadmin
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: kokuadmin
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can add permission	2	add_permission
5	Can change permission	2	change_permission
6	Can delete permission	2	delete_permission
7	Can add group	3	add_group
8	Can change group	3	change_group
9	Can delete group	3	delete_group
10	Can add user	4	add_user
11	Can change user	4	change_user
12	Can delete user	4	delete_user
13	Can add content type	5	add_contenttype
14	Can change content type	5	change_contenttype
15	Can delete content type	5	delete_contenttype
16	Can add session	6	add_session
17	Can change session	6	change_session
18	Can delete session	6	delete_session
19	Can add Token	7	add_token
20	Can change Token	7	change_token
21	Can delete Token	7	delete_token
22	Can add status	8	add_status
23	Can change status	8	change_status
24	Can delete status	8	delete_status
25	Can add customer	9	add_customer
26	Can change customer	9	change_customer
27	Can delete customer	9	delete_customer
28	Can add user	10	add_user
29	Can change user	10	change_user
30	Can delete user	10	delete_user
31	Can add reset token	11	add_resettoken
32	Can change reset token	11	change_resettoken
33	Can delete reset token	11	delete_resettoken
34	Can add user preference	12	add_userpreference
35	Can change user preference	12	change_userpreference
36	Can delete user preference	12	delete_userpreference
37	Can add provider	13	add_provider
38	Can change provider	13	change_provider
39	Can delete provider	13	delete_provider
40	Can add provider authentication	14	add_providerauthentication
41	Can change provider authentication	14	change_providerauthentication
42	Can delete provider authentication	14	delete_providerauthentication
43	Can add provider billing source	15	add_providerbillingsource
44	Can change provider billing source	15	change_providerbillingsource
45	Can delete provider billing source	15	delete_providerbillingsource
46	Can add tenant	16	add_tenant
47	Can change tenant	16	change_tenant
48	Can delete tenant	16	delete_tenant
49	Can add aws cost entry	17	add_awscostentry
50	Can change aws cost entry	17	change_awscostentry
51	Can delete aws cost entry	17	delete_awscostentry
52	Can add aws cost entry bill	18	add_awscostentrybill
53	Can change aws cost entry bill	18	change_awscostentrybill
54	Can delete aws cost entry bill	18	delete_awscostentrybill
55	Can add aws cost entry line item	19	add_awscostentrylineitem
56	Can change aws cost entry line item	19	change_awscostentrylineitem
57	Can delete aws cost entry line item	19	delete_awscostentrylineitem
58	Can add aws cost entry pricing	20	add_awscostentrypricing
59	Can change aws cost entry pricing	20	change_awscostentrypricing
60	Can delete aws cost entry pricing	20	delete_awscostentrypricing
61	Can add aws cost entry product	21	add_awscostentryproduct
62	Can change aws cost entry product	21	change_awscostentryproduct
63	Can delete aws cost entry product	21	delete_awscostentryproduct
64	Can add aws cost entry reservation	22	add_awscostentryreservation
65	Can change aws cost entry reservation	22	change_awscostentryreservation
66	Can delete aws cost entry reservation	22	delete_awscostentryreservation
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: kokuadmin
--

COPY auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$100000$qFSFWKBNUBEL$mlvEhvfBfmLTgayVFSYYbuhELsfVQaipQiKFjU/A+48=	\N	t	admin			admin@example.com	t	t	2018-06-07 13:42:24.508908+00
2	pbkdf2_sha256$100000$tTIOFK3IqaG9$sgB3xo3Zfa7vWnxKogGD9XRPxdTkUf0Br60Y3Fcd+EM=	\N	f	test_customer			test@example.com	f	t	2018-06-07 13:44:02.234995+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: kokuadmin
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
1	2	1
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: kokuadmin
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: authtoken_token; Type: TABLE DATA; Schema: public; Owner: kokuadmin
--

COPY authtoken_token (key, created, user_id) FROM stdin;
fc50f3a4b9840725720bb43a272a43f035f4d3c5	2018-06-07 13:43:27.76804+00	1
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: kokuadmin
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: kokuadmin
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	authtoken	token
8	api	status
9	api	customer
10	api	user
11	api	resettoken
12	api	userpreference
13	api	provider
14	api	providerauthentication
15	api	providerbillingsource
16	api	tenant
17	reporting	awscostentry
18	reporting	awscostentrybill
19	reporting	awscostentrylineitem
20	reporting	awscostentrypricing
21	reporting	awscostentryproduct
22	reporting	awscostentryreservation
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: kokuadmin
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2018-06-07 13:42:21.177075+00
2	auth	0001_initial	2018-06-07 13:42:21.729165+00
3	admin	0001_initial	2018-06-07 13:42:21.876385+00
4	admin	0002_logentry_remove_auto_add	2018-06-07 13:42:21.931878+00
5	contenttypes	0002_remove_content_type_name	2018-06-07 13:42:22.037739+00
6	auth	0002_alter_permission_name_max_length	2018-06-07 13:42:22.080228+00
7	auth	0003_alter_user_email_max_length	2018-06-07 13:42:22.136333+00
8	auth	0004_alter_user_username_opts	2018-06-07 13:42:22.172298+00
9	auth	0005_alter_user_last_login_null	2018-06-07 13:42:22.233641+00
10	auth	0006_require_contenttypes_0002	2018-06-07 13:42:22.307539+00
11	auth	0007_alter_validators_add_error_messages	2018-06-07 13:42:22.33353+00
12	auth	0008_alter_user_username_max_length	2018-06-07 13:42:22.391424+00
13	auth	0009_alter_user_last_name_max_length	2018-06-07 13:42:22.470899+00
14	api	0001_initial	2018-06-07 13:42:22.550563+00
15	api	0002_auto_20180509_1400	2018-06-07 13:42:22.875441+00
16	api	0003_auto_20180509_1849	2018-06-07 13:42:23.135812+00
17	api	0004_auto_20180510_1824	2018-06-07 13:42:23.39875+00
18	api	0005_auto_20180511_1445	2018-06-07 13:42:23.458134+00
19	api	0006_resettoken	2018-06-07 13:42:23.604421+00
20	api	0007_userpreference	2018-06-07 13:42:23.675976+00
21	api	0008_provider	2018-06-07 13:42:23.92672+00
22	api	0009_auto_20180523_0045	2018-06-07 13:42:24.048068+00
23	api	0010_auto_20180523_1540	2018-06-07 13:42:24.179926+00
24	api	0011_auto_20180524_1838	2018-06-07 13:42:24.341536+00
25	api	0012_auto_20180529_1526	2018-06-07 13:42:24.595437+00
26	api	0013_auto_20180531_1921	2018-06-07 13:42:24.639211+00
27	authtoken	0001_initial	2018-06-07 13:42:24.773058+00
28	authtoken	0002_auto_20160226_1747	2018-06-07 13:42:24.95443+00
29	reporting	0001_initial	2018-06-07 13:42:25.033504+00
30	sessions	0001_initial	2018-06-07 13:42:25.073564+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: kokuadmin
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
\.


SET search_path = testcustomer, pg_catalog;

--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: testcustomer; Owner: kokuadmin
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2018-06-07 13:44:02.694744+00
2	auth	0001_initial	2018-06-07 13:44:02.721467+00
3	admin	0001_initial	2018-06-07 13:44:02.740045+00
4	admin	0002_logentry_remove_auto_add	2018-06-07 13:44:02.759302+00
5	contenttypes	0002_remove_content_type_name	2018-06-07 13:44:02.779458+00
6	auth	0002_alter_permission_name_max_length	2018-06-07 13:44:02.793816+00
7	auth	0003_alter_user_email_max_length	2018-06-07 13:44:02.81103+00
8	auth	0004_alter_user_username_opts	2018-06-07 13:44:02.829404+00
9	auth	0005_alter_user_last_login_null	2018-06-07 13:44:02.846826+00
10	auth	0006_require_contenttypes_0002	2018-06-07 13:44:02.855775+00
11	auth	0007_alter_validators_add_error_messages	2018-06-07 13:44:02.871813+00
12	auth	0008_alter_user_username_max_length	2018-06-07 13:44:02.892874+00
13	auth	0009_alter_user_last_name_max_length	2018-06-07 13:44:02.910349+00
14	api	0001_initial	2018-06-07 13:44:02.924218+00
15	api	0002_auto_20180509_1400	2018-06-07 13:44:02.982823+00
16	api	0003_auto_20180509_1849	2018-06-07 13:44:03.015961+00
17	api	0004_auto_20180510_1824	2018-06-07 13:44:03.05463+00
18	api	0005_auto_20180511_1445	2018-06-07 13:44:03.125628+00
19	api	0006_resettoken	2018-06-07 13:44:03.14756+00
20	api	0007_userpreference	2018-06-07 13:44:03.16845+00
21	api	0008_provider	2018-06-07 13:44:03.213128+00
22	api	0009_auto_20180523_0045	2018-06-07 13:44:03.235737+00
23	api	0010_auto_20180523_1540	2018-06-07 13:44:03.283582+00
24	api	0011_auto_20180524_1838	2018-06-07 13:44:03.30727+00
25	api	0012_auto_20180529_1526	2018-06-07 13:44:03.320718+00
26	api	0013_auto_20180531_1921	2018-06-07 13:44:03.331821+00
27	authtoken	0001_initial	2018-06-07 13:44:03.355322+00
28	authtoken	0002_auto_20160226_1747	2018-06-07 13:44:03.395865+00
29	reporting	0001_initial	2018-06-07 13:44:03.580568+00
30	sessions	0001_initial	2018-06-07 13:44:03.591154+00
\.


--
-- Data for Name: reporting_awscostentry; Type: TABLE DATA; Schema: testcustomer; Owner: kokuadmin
--

COPY reporting_awscostentry (id, interval_start, interval_end, bill_id) FROM stdin;
\.


--
-- Data for Name: reporting_awscostentrybill; Type: TABLE DATA; Schema: testcustomer; Owner: kokuadmin
--

COPY reporting_awscostentrybill (id, billing_resource, bill_type, payer_account_id, billing_period_start, billing_period_end) FROM stdin;
\.


--
-- Data for Name: reporting_awscostentrylineitem; Type: TABLE DATA; Schema: testcustomer; Owner: kokuadmin
--

COPY reporting_awscostentrylineitem (id, tags, invoice_id, line_item_type, usage_account_id, usage_start, usage_end, product_code, usage_type, operation, availability_zone, resource_id, usage_amount, normalization_factor, normalized_usage_amount, currency_code, unblended_rate, unblended_cost, blended_rate, blended_cost, tax_type, cost_entry_id, cost_entry_bill_id, cost_entry_pricing_id, cost_entry_product_id, cost_entry_reservation_id) FROM stdin;
\.


--
-- Data for Name: reporting_awscostentrypricing; Type: TABLE DATA; Schema: testcustomer; Owner: kokuadmin
--

COPY reporting_awscostentrypricing (id, public_on_demand_cost, public_on_demand_rate, term, unit, line_item_id) FROM stdin;
\.


--
-- Data for Name: reporting_awscostentryproduct; Type: TABLE DATA; Schema: testcustomer; Owner: kokuadmin
--

COPY reporting_awscostentryproduct (id, sku, product_name, product_family, service_code, region, instance_type, memory, vcpu) FROM stdin;
\.


--
-- Data for Name: reporting_awscostentryreservation; Type: TABLE DATA; Schema: testcustomer; Owner: kokuadmin
--

COPY reporting_awscostentryreservation (id, reservation_arn, availability_zone, number_of_reservations, units_per_reservation, amortized_upfront_fee, amortized_upfront_cost_for_usage, recurring_fee_for_usage, unused_quantity, unused_recurring_fee) FROM stdin;
\.


SET search_path = public, pg_catalog;

--
-- Name: api_provider_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kokuadmin
--

SELECT pg_catalog.setval('api_provider_id_seq', 1, false);


--
-- Name: api_providerauthentication_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kokuadmin
--

SELECT pg_catalog.setval('api_providerauthentication_id_seq', 1, false);


--
-- Name: api_providerbillingsource_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kokuadmin
--

SELECT pg_catalog.setval('api_providerbillingsource_id_seq', 1, false);


--
-- Name: api_resettoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kokuadmin
--

SELECT pg_catalog.setval('api_resettoken_id_seq', 1, true);


--
-- Name: api_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kokuadmin
--

SELECT pg_catalog.setval('api_status_id_seq', 1, true);


--
-- Name: api_tenant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kokuadmin
--

SELECT pg_catalog.setval('api_tenant_id_seq', 2, true);


--
-- Name: api_userpreference_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kokuadmin
--

SELECT pg_catalog.setval('api_userpreference_id_seq', 3, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kokuadmin
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kokuadmin
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kokuadmin
--

SELECT pg_catalog.setval('auth_permission_id_seq', 66, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kokuadmin
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, true);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kokuadmin
--

SELECT pg_catalog.setval('auth_user_id_seq', 2, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kokuadmin
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kokuadmin
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kokuadmin
--

SELECT pg_catalog.setval('django_content_type_id_seq', 22, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kokuadmin
--

SELECT pg_catalog.setval('django_migrations_id_seq', 30, true);


SET search_path = testcustomer, pg_catalog;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: testcustomer; Owner: kokuadmin
--

SELECT pg_catalog.setval('django_migrations_id_seq', 30, true);


--
-- Name: reporting_awscostentry_id_seq; Type: SEQUENCE SET; Schema: testcustomer; Owner: kokuadmin
--

SELECT pg_catalog.setval('reporting_awscostentry_id_seq', 1, false);


--
-- Name: reporting_awscostentrybill_id_seq; Type: SEQUENCE SET; Schema: testcustomer; Owner: kokuadmin
--

SELECT pg_catalog.setval('reporting_awscostentrybill_id_seq', 1, false);


--
-- Name: reporting_awscostentrylineitem_id_seq; Type: SEQUENCE SET; Schema: testcustomer; Owner: kokuadmin
--

SELECT pg_catalog.setval('reporting_awscostentrylineitem_id_seq', 1, false);


--
-- Name: reporting_awscostentrypricing_id_seq; Type: SEQUENCE SET; Schema: testcustomer; Owner: kokuadmin
--

SELECT pg_catalog.setval('reporting_awscostentrypricing_id_seq', 1, false);


--
-- Name: reporting_awscostentryproduct_id_seq; Type: SEQUENCE SET; Schema: testcustomer; Owner: kokuadmin
--

SELECT pg_catalog.setval('reporting_awscostentryproduct_id_seq', 1, false);


--
-- Name: reporting_awscostentryreservation_id_seq; Type: SEQUENCE SET; Schema: testcustomer; Owner: kokuadmin
--

SELECT pg_catalog.setval('reporting_awscostentryreservation_id_seq', 1, false);


SET search_path = public, pg_catalog;

--
-- Name: api_customer api_customer_pkey; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_customer
    ADD CONSTRAINT api_customer_pkey PRIMARY KEY (group_ptr_id);


--
-- Name: api_customer api_customer_schema_name_key; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_customer
    ADD CONSTRAINT api_customer_schema_name_key UNIQUE (schema_name);


--
-- Name: api_customer api_customer_uuid_key; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_customer
    ADD CONSTRAINT api_customer_uuid_key UNIQUE (uuid);


--
-- Name: api_provider api_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_provider
    ADD CONSTRAINT api_provider_pkey PRIMARY KEY (id);


--
-- Name: api_provider api_provider_uuid_key; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_provider
    ADD CONSTRAINT api_provider_uuid_key UNIQUE (uuid);


--
-- Name: api_providerauthentication api_providerauthentication_pkey; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_providerauthentication
    ADD CONSTRAINT api_providerauthentication_pkey PRIMARY KEY (id);


--
-- Name: api_providerauthentication api_providerauthentication_provider_resource_name_fa7deecb_uniq; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_providerauthentication
    ADD CONSTRAINT api_providerauthentication_provider_resource_name_fa7deecb_uniq UNIQUE (provider_resource_name);


--
-- Name: api_providerauthentication api_providerauthentication_uuid_key; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_providerauthentication
    ADD CONSTRAINT api_providerauthentication_uuid_key UNIQUE (uuid);


--
-- Name: api_providerbillingsource api_providerbillingsource_pkey; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_providerbillingsource
    ADD CONSTRAINT api_providerbillingsource_pkey PRIMARY KEY (id);


--
-- Name: api_providerbillingsource api_providerbillingsource_uuid_key; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_providerbillingsource
    ADD CONSTRAINT api_providerbillingsource_uuid_key UNIQUE (uuid);


--
-- Name: api_resettoken api_resettoken_pkey; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_resettoken
    ADD CONSTRAINT api_resettoken_pkey PRIMARY KEY (id);


--
-- Name: api_resettoken api_resettoken_token_key; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_resettoken
    ADD CONSTRAINT api_resettoken_token_key UNIQUE (token);


--
-- Name: api_status api_status_pkey; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_status
    ADD CONSTRAINT api_status_pkey PRIMARY KEY (id);


--
-- Name: api_tenant api_tenant_pkey; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_tenant
    ADD CONSTRAINT api_tenant_pkey PRIMARY KEY (id);


--
-- Name: api_tenant api_tenant_schema_name_key; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_tenant
    ADD CONSTRAINT api_tenant_schema_name_key UNIQUE (schema_name);


--
-- Name: api_user api_user_pkey; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_user
    ADD CONSTRAINT api_user_pkey PRIMARY KEY (user_ptr_id);


--
-- Name: api_user api_user_uuid_key; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_user
    ADD CONSTRAINT api_user_uuid_key UNIQUE (uuid);


--
-- Name: api_userpreference api_userpreference_pkey; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_userpreference
    ADD CONSTRAINT api_userpreference_pkey PRIMARY KEY (id);


--
-- Name: api_userpreference api_userpreference_uuid_key; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_userpreference
    ADD CONSTRAINT api_userpreference_uuid_key UNIQUE (uuid);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: authtoken_token authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);


--
-- Name: authtoken_token authtoken_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


SET search_path = testcustomer, pg_catalog;

--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: testcustomer; Owner: kokuadmin
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: reporting_awscostentry reporting_awscostentry_pkey; Type: CONSTRAINT; Schema: testcustomer; Owner: kokuadmin
--

ALTER TABLE ONLY reporting_awscostentry
    ADD CONSTRAINT reporting_awscostentry_pkey PRIMARY KEY (id);


--
-- Name: reporting_awscostentrybill reporting_awscostentrybill_pkey; Type: CONSTRAINT; Schema: testcustomer; Owner: kokuadmin
--

ALTER TABLE ONLY reporting_awscostentrybill
    ADD CONSTRAINT reporting_awscostentrybill_pkey PRIMARY KEY (id);


--
-- Name: reporting_awscostentrylineitem reporting_awscostentrylineitem_pkey; Type: CONSTRAINT; Schema: testcustomer; Owner: kokuadmin
--

ALTER TABLE ONLY reporting_awscostentrylineitem
    ADD CONSTRAINT reporting_awscostentrylineitem_pkey PRIMARY KEY (id);


--
-- Name: reporting_awscostentrypricing reporting_awscostentrypricing_pkey; Type: CONSTRAINT; Schema: testcustomer; Owner: kokuadmin
--

ALTER TABLE ONLY reporting_awscostentrypricing
    ADD CONSTRAINT reporting_awscostentrypricing_pkey PRIMARY KEY (id);


--
-- Name: reporting_awscostentryproduct reporting_awscostentryproduct_pkey; Type: CONSTRAINT; Schema: testcustomer; Owner: kokuadmin
--

ALTER TABLE ONLY reporting_awscostentryproduct
    ADD CONSTRAINT reporting_awscostentryproduct_pkey PRIMARY KEY (id);


--
-- Name: reporting_awscostentryproduct reporting_awscostentryproduct_sku_key; Type: CONSTRAINT; Schema: testcustomer; Owner: kokuadmin
--

ALTER TABLE ONLY reporting_awscostentryproduct
    ADD CONSTRAINT reporting_awscostentryproduct_sku_key UNIQUE (sku);


--
-- Name: reporting_awscostentryreservation reporting_awscostentryreservation_pkey; Type: CONSTRAINT; Schema: testcustomer; Owner: kokuadmin
--

ALTER TABLE ONLY reporting_awscostentryreservation
    ADD CONSTRAINT reporting_awscostentryreservation_pkey PRIMARY KEY (id);


--
-- Name: reporting_awscostentryreservation reporting_awscostentryreservation_reservation_arn_key; Type: CONSTRAINT; Schema: testcustomer; Owner: kokuadmin
--

ALTER TABLE ONLY reporting_awscostentryreservation
    ADD CONSTRAINT reporting_awscostentryreservation_reservation_arn_key UNIQUE (reservation_arn);


SET search_path = public, pg_catalog;

--
-- Name: api_customer_owner_id_c1534767; Type: INDEX; Schema: public; Owner: kokuadmin
--

CREATE INDEX api_customer_owner_id_c1534767 ON api_customer USING btree (owner_id);


--
-- Name: api_customer_schema_name_6b716c4b_like; Type: INDEX; Schema: public; Owner: kokuadmin
--

CREATE INDEX api_customer_schema_name_6b716c4b_like ON api_customer USING btree (schema_name text_pattern_ops);


--
-- Name: api_provider_authentication_id_201fd4b9; Type: INDEX; Schema: public; Owner: kokuadmin
--

CREATE INDEX api_provider_authentication_id_201fd4b9 ON api_provider USING btree (authentication_id);


--
-- Name: api_provider_billing_source_id_cb6b5a6f; Type: INDEX; Schema: public; Owner: kokuadmin
--

CREATE INDEX api_provider_billing_source_id_cb6b5a6f ON api_provider USING btree (billing_source_id);


--
-- Name: api_provider_created_by_id_e740fc35; Type: INDEX; Schema: public; Owner: kokuadmin
--

CREATE INDEX api_provider_created_by_id_e740fc35 ON api_provider USING btree (created_by_id);


--
-- Name: api_provider_customer_id_87062290; Type: INDEX; Schema: public; Owner: kokuadmin
--

CREATE INDEX api_provider_customer_id_87062290 ON api_provider USING btree (customer_id);


--
-- Name: api_providerauthentication_provider_resource_name_fa7deecb_like; Type: INDEX; Schema: public; Owner: kokuadmin
--

CREATE INDEX api_providerauthentication_provider_resource_name_fa7deecb_like ON api_providerauthentication USING btree (provider_resource_name text_pattern_ops);


--
-- Name: api_resettoken_user_id_4b3d42c0; Type: INDEX; Schema: public; Owner: kokuadmin
--

CREATE INDEX api_resettoken_user_id_4b3d42c0 ON api_resettoken USING btree (user_id);


--
-- Name: api_tenant_schema_name_733d339b_like; Type: INDEX; Schema: public; Owner: kokuadmin
--

CREATE INDEX api_tenant_schema_name_733d339b_like ON api_tenant USING btree (schema_name varchar_pattern_ops);


--
-- Name: api_userpreference_user_id_e62eaffa; Type: INDEX; Schema: public; Owner: kokuadmin
--

CREATE INDEX api_userpreference_user_id_e62eaffa ON api_userpreference USING btree (user_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: kokuadmin
--

CREATE INDEX auth_group_name_a6ea08ec_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: kokuadmin
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: kokuadmin
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: kokuadmin
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: kokuadmin
--

CREATE INDEX auth_user_groups_group_id_97559544 ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: kokuadmin
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: kokuadmin
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: kokuadmin
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: kokuadmin
--

CREATE INDEX auth_user_username_6821ab7c_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- Name: authtoken_token_key_10f0b77e_like; Type: INDEX; Schema: public; Owner: kokuadmin
--

CREATE INDEX authtoken_token_key_10f0b77e_like ON authtoken_token USING btree (key varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: kokuadmin
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: kokuadmin
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: kokuadmin
--

CREATE INDEX django_session_expire_date_a5c62663 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: kokuadmin
--

CREATE INDEX django_session_session_key_c0390e0f_like ON django_session USING btree (session_key varchar_pattern_ops);


SET search_path = testcustomer, pg_catalog;

--
-- Name: reporting_awscostentry_bill_id_017f27a3; Type: INDEX; Schema: testcustomer; Owner: kokuadmin
--

CREATE INDEX reporting_awscostentry_bill_id_017f27a3 ON reporting_awscostentry USING btree (bill_id);


--
-- Name: reporting_awscostentryline_cost_entry_reservation_id_9332b371; Type: INDEX; Schema: testcustomer; Owner: kokuadmin
--

CREATE INDEX reporting_awscostentryline_cost_entry_reservation_id_9332b371 ON reporting_awscostentrylineitem USING btree (cost_entry_reservation_id);


--
-- Name: reporting_awscostentrylineitem_cost_entry_bill_id_5ae74e09; Type: INDEX; Schema: testcustomer; Owner: kokuadmin
--

CREATE INDEX reporting_awscostentrylineitem_cost_entry_bill_id_5ae74e09 ON reporting_awscostentrylineitem USING btree (cost_entry_bill_id);


--
-- Name: reporting_awscostentrylineitem_cost_entry_id_4d1a7fc4; Type: INDEX; Schema: testcustomer; Owner: kokuadmin
--

CREATE INDEX reporting_awscostentrylineitem_cost_entry_id_4d1a7fc4 ON reporting_awscostentrylineitem USING btree (cost_entry_id);


--
-- Name: reporting_awscostentrylineitem_cost_entry_pricing_id_a654a7e3; Type: INDEX; Schema: testcustomer; Owner: kokuadmin
--

CREATE INDEX reporting_awscostentrylineitem_cost_entry_pricing_id_a654a7e3 ON reporting_awscostentrylineitem USING btree (cost_entry_pricing_id);


--
-- Name: reporting_awscostentrylineitem_cost_entry_product_id_29c80210; Type: INDEX; Schema: testcustomer; Owner: kokuadmin
--

CREATE INDEX reporting_awscostentrylineitem_cost_entry_product_id_29c80210 ON reporting_awscostentrylineitem USING btree (cost_entry_product_id);


--
-- Name: reporting_awscostentrypricing_line_item_id_a2499e5d; Type: INDEX; Schema: testcustomer; Owner: kokuadmin
--

CREATE INDEX reporting_awscostentrypricing_line_item_id_a2499e5d ON reporting_awscostentrypricing USING btree (line_item_id);


--
-- Name: reporting_awscostentryproduct_sku_9beaacae_like; Type: INDEX; Schema: testcustomer; Owner: kokuadmin
--

CREATE INDEX reporting_awscostentryproduct_sku_9beaacae_like ON reporting_awscostentryproduct USING btree (sku varchar_pattern_ops);


--
-- Name: reporting_awscostentryreservation_reservation_arn_e387aa5b_like; Type: INDEX; Schema: testcustomer; Owner: kokuadmin
--

CREATE INDEX reporting_awscostentryreservation_reservation_arn_e387aa5b_like ON reporting_awscostentryreservation USING btree (reservation_arn text_pattern_ops);


SET search_path = public, pg_catalog;

--
-- Name: api_customer api_customer_group_ptr_id_fe96eec5_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_customer
    ADD CONSTRAINT api_customer_group_ptr_id_fe96eec5_fk_auth_group_id FOREIGN KEY (group_ptr_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_customer api_customer_owner_id_c1534767_fk_api_user_user_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_customer
    ADD CONSTRAINT api_customer_owner_id_c1534767_fk_api_user_user_ptr_id FOREIGN KEY (owner_id) REFERENCES api_user(user_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_provider api_provider_authentication_id_201fd4b9_fk_api_provi; Type: FK CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_provider
    ADD CONSTRAINT api_provider_authentication_id_201fd4b9_fk_api_provi FOREIGN KEY (authentication_id) REFERENCES api_providerauthentication(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_provider api_provider_billing_source_id_cb6b5a6f_fk_api_provi; Type: FK CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_provider
    ADD CONSTRAINT api_provider_billing_source_id_cb6b5a6f_fk_api_provi FOREIGN KEY (billing_source_id) REFERENCES api_providerbillingsource(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_provider api_provider_created_by_id_e740fc35_fk_api_user_user_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_provider
    ADD CONSTRAINT api_provider_created_by_id_e740fc35_fk_api_user_user_ptr_id FOREIGN KEY (created_by_id) REFERENCES api_user(user_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_provider api_provider_customer_id_87062290_fk_api_customer_group_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_provider
    ADD CONSTRAINT api_provider_customer_id_87062290_fk_api_customer_group_ptr_id FOREIGN KEY (customer_id) REFERENCES api_customer(group_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_resettoken api_resettoken_user_id_4b3d42c0_fk_api_user_user_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_resettoken
    ADD CONSTRAINT api_resettoken_user_id_4b3d42c0_fk_api_user_user_ptr_id FOREIGN KEY (user_id) REFERENCES api_user(user_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_user api_user_user_ptr_id_5a766ead_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_user
    ADD CONSTRAINT api_user_user_ptr_id_5a766ead_fk_auth_user_id FOREIGN KEY (user_ptr_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_userpreference api_userpreference_user_id_e62eaffa_fk_api_user_user_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY api_userpreference
    ADD CONSTRAINT api_userpreference_user_id_e62eaffa_fk_api_user_user_ptr_id FOREIGN KEY (user_id) REFERENCES api_user(user_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authtoken_token authtoken_token_user_id_35299eff_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_35299eff_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kokuadmin
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


SET search_path = testcustomer, pg_catalog;

--
-- Name: reporting_awscostentry reporting_awscostent_bill_id_017f27a3_fk_reporting; Type: FK CONSTRAINT; Schema: testcustomer; Owner: kokuadmin
--

ALTER TABLE ONLY reporting_awscostentry
    ADD CONSTRAINT reporting_awscostent_bill_id_017f27a3_fk_reporting FOREIGN KEY (bill_id) REFERENCES reporting_awscostentrybill(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reporting_awscostentrylineitem reporting_awscostent_cost_entry_bill_id_5ae74e09_fk_reporting; Type: FK CONSTRAINT; Schema: testcustomer; Owner: kokuadmin
--

ALTER TABLE ONLY reporting_awscostentrylineitem
    ADD CONSTRAINT reporting_awscostent_cost_entry_bill_id_5ae74e09_fk_reporting FOREIGN KEY (cost_entry_bill_id) REFERENCES reporting_awscostentrybill(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reporting_awscostentrylineitem reporting_awscostent_cost_entry_id_4d1a7fc4_fk_reporting; Type: FK CONSTRAINT; Schema: testcustomer; Owner: kokuadmin
--

ALTER TABLE ONLY reporting_awscostentrylineitem
    ADD CONSTRAINT reporting_awscostent_cost_entry_id_4d1a7fc4_fk_reporting FOREIGN KEY (cost_entry_id) REFERENCES reporting_awscostentry(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reporting_awscostentrylineitem reporting_awscostent_cost_entry_pricing_i_a654a7e3_fk_reporting; Type: FK CONSTRAINT; Schema: testcustomer; Owner: kokuadmin
--

ALTER TABLE ONLY reporting_awscostentrylineitem
    ADD CONSTRAINT reporting_awscostent_cost_entry_pricing_i_a654a7e3_fk_reporting FOREIGN KEY (cost_entry_pricing_id) REFERENCES reporting_awscostentrypricing(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reporting_awscostentrylineitem reporting_awscostent_cost_entry_product_i_29c80210_fk_reporting; Type: FK CONSTRAINT; Schema: testcustomer; Owner: kokuadmin
--

ALTER TABLE ONLY reporting_awscostentrylineitem
    ADD CONSTRAINT reporting_awscostent_cost_entry_product_i_29c80210_fk_reporting FOREIGN KEY (cost_entry_product_id) REFERENCES reporting_awscostentryproduct(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reporting_awscostentrylineitem reporting_awscostent_cost_entry_reservati_9332b371_fk_reporting; Type: FK CONSTRAINT; Schema: testcustomer; Owner: kokuadmin
--

ALTER TABLE ONLY reporting_awscostentrylineitem
    ADD CONSTRAINT reporting_awscostent_cost_entry_reservati_9332b371_fk_reporting FOREIGN KEY (cost_entry_reservation_id) REFERENCES reporting_awscostentryreservation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reporting_awscostentrypricing reporting_awscostent_line_item_id_a2499e5d_fk_reporting; Type: FK CONSTRAINT; Schema: testcustomer; Owner: kokuadmin
--

ALTER TABLE ONLY reporting_awscostentrypricing
    ADD CONSTRAINT reporting_awscostent_line_item_id_a2499e5d_fk_reporting FOREIGN KEY (line_item_id) REFERENCES reporting_awscostentrylineitem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--
