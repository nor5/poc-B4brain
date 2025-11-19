--
-- PostgreSQL database dump
--

\restrict BwfN5xgvRxzqV4aKBNLU14a0tt1iO836ftlAUHjMY2Bi7FgCrrid4l2F9937Omm

-- Dumped from database version 18.1 (Debian 18.1-1.pgdg13+2)
-- Dumped by pg_dump version 18.1 (Debian 18.1-1.pgdg13+2)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak_db_user;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak_db_user;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak_db_user;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak_db_user;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.authenticator_config (
    id character varying(36) CONSTRAINT authenticator_id_not_null NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak_db_user;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) CONSTRAINT authenticator_config_authenticator_id_not_null NOT NULL,
    value text,
    name character varying(255) CONSTRAINT authenticator_config_name_not_null NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak_db_user;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak_db_user;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak_db_user;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO keycloak_db_user;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak_db_user;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak_db_user;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) CONSTRAINT app_node_registrations_application_id_not_null NOT NULL,
    value integer,
    name character varying(255) CONSTRAINT app_node_registrations_name_not_null NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak_db_user;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.client_scope (
    id character varying(36) CONSTRAINT client_template_id_not_null NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak_db_user;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) CONSTRAINT client_template_attributes_template_id_not_null NOT NULL,
    value character varying(2048),
    name character varying(255) CONSTRAINT client_template_attributes_name_not_null NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak_db_user;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak_db_user;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) CONSTRAINT template_scope_mapping_template_id_not_null NOT NULL,
    role_id character varying(36) CONSTRAINT template_scope_mapping_role_id_not_null NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak_db_user;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO keycloak_db_user;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO keycloak_db_user;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO keycloak_db_user;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO keycloak_db_user;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO keycloak_db_user;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO keycloak_db_user;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak_db_user;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO keycloak_db_user;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak_db_user;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO keycloak_db_user;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak_db_user;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak_db_user;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak_db_user;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO keycloak_db_user;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak_db_user;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak_db_user;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak_db_user;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak_db_user;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak_db_user;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak_db_user;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak_db_user;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak_db_user;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak_db_user;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak_db_user;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak_db_user;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO keycloak_db_user;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak_db_user;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak_db_user;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak_db_user;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO keycloak_db_user;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false CONSTRAINT keycloak_role_application_role_not_null NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak_db_user;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak_db_user;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO keycloak_db_user;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO keycloak_db_user;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak_db_user;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak_db_user;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak_db_user;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO keycloak_db_user;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO keycloak_db_user;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak_db_user;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak_db_user;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak_db_user;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO keycloak_db_user;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak_db_user;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak_db_user;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak_db_user;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak_db_user;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak_db_user;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak_db_user;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak_db_user;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak_db_user;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak_db_user;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.resource_server (
    id character varying(36) CONSTRAINT resource_server_client_id_not_null NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak_db_user;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak_db_user;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) CONSTRAINT resource_server_policy_resource_server_client_id_not_null NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak_db_user;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) CONSTRAINT resource_server_resource_resource_server_client_id_not_null NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak_db_user;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) CONSTRAINT resource_server_scope_resource_server_client_id_not_null NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak_db_user;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak_db_user;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak_db_user;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak_db_user;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak_db_user;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO keycloak_db_user;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak_db_user;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak_db_user;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak_db_user;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak_db_user;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak_db_user;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) CONSTRAINT user_federation_mapper_confi_user_federation_mapper_id_not_null NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak_db_user;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak_db_user;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak_db_user;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak_db_user;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak_db_user;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO keycloak_db_user;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO keycloak_db_user;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO keycloak_db_user;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak_db_user
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak_db_user;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
e684e50d-f32c-4470-aa4a-e1f5a25f64df	\N	auth-cookie	466b29ba-5081-488d-9245-7ea9c707034a	6d08abca-278e-4461-ae67-87612ca1e596	2	10	f	\N	\N
85a5f4ea-192a-42ce-8f23-126c4be3d0ea	\N	auth-spnego	466b29ba-5081-488d-9245-7ea9c707034a	6d08abca-278e-4461-ae67-87612ca1e596	3	20	f	\N	\N
60828236-7d06-4e76-9f49-5a8e937df23b	\N	identity-provider-redirector	466b29ba-5081-488d-9245-7ea9c707034a	6d08abca-278e-4461-ae67-87612ca1e596	2	25	f	\N	\N
c7eebab9-5ac7-4c88-8a6e-49a44cd2f4ba	\N	\N	466b29ba-5081-488d-9245-7ea9c707034a	6d08abca-278e-4461-ae67-87612ca1e596	2	30	t	4630cdd7-7722-4004-b53e-79a64cec8423	\N
a12b6ba0-3fc6-4131-9b87-bcf7ed2fa3e9	\N	auth-username-password-form	466b29ba-5081-488d-9245-7ea9c707034a	4630cdd7-7722-4004-b53e-79a64cec8423	0	10	f	\N	\N
7302ff93-77b0-4474-b853-4a4f494f3a9b	\N	\N	466b29ba-5081-488d-9245-7ea9c707034a	4630cdd7-7722-4004-b53e-79a64cec8423	1	20	t	54f29f48-1184-48fc-8408-38f946c597c0	\N
2e16aa29-c4d2-4a75-8cbd-121d491ac2ce	\N	conditional-user-configured	466b29ba-5081-488d-9245-7ea9c707034a	54f29f48-1184-48fc-8408-38f946c597c0	0	10	f	\N	\N
6c95dbf2-3740-4899-947b-803140968436	\N	auth-otp-form	466b29ba-5081-488d-9245-7ea9c707034a	54f29f48-1184-48fc-8408-38f946c597c0	0	20	f	\N	\N
dd806c6b-f6b8-4b06-9456-ae85ff50c3c3	\N	direct-grant-validate-username	466b29ba-5081-488d-9245-7ea9c707034a	9a27eff1-8400-4535-8b30-37c5099e068f	0	10	f	\N	\N
cda53168-c089-4b30-8a6d-04316db699b1	\N	direct-grant-validate-password	466b29ba-5081-488d-9245-7ea9c707034a	9a27eff1-8400-4535-8b30-37c5099e068f	0	20	f	\N	\N
c9582659-25bf-46af-a20f-eeeae136aea6	\N	\N	466b29ba-5081-488d-9245-7ea9c707034a	9a27eff1-8400-4535-8b30-37c5099e068f	1	30	t	0f41b5c7-06ed-4e9c-af39-f74009766c4a	\N
f300ee56-8a25-494a-8ee8-5b1303da75ee	\N	conditional-user-configured	466b29ba-5081-488d-9245-7ea9c707034a	0f41b5c7-06ed-4e9c-af39-f74009766c4a	0	10	f	\N	\N
bea1e3a4-8b83-4d9b-ba11-24aae43b294c	\N	direct-grant-validate-otp	466b29ba-5081-488d-9245-7ea9c707034a	0f41b5c7-06ed-4e9c-af39-f74009766c4a	0	20	f	\N	\N
eb37affa-5949-4e4a-b8dd-ee16ca869bf0	\N	registration-page-form	466b29ba-5081-488d-9245-7ea9c707034a	f5bb0ea1-4069-42c2-b190-009217ae3005	0	10	t	b456c864-fee0-4ee7-ba50-8df50deb7fa7	\N
331d2740-1d24-4beb-a13d-c7a5ea699faf	\N	registration-user-creation	466b29ba-5081-488d-9245-7ea9c707034a	b456c864-fee0-4ee7-ba50-8df50deb7fa7	0	20	f	\N	\N
b989c91f-d048-45d6-88b9-60a425332a49	\N	registration-password-action	466b29ba-5081-488d-9245-7ea9c707034a	b456c864-fee0-4ee7-ba50-8df50deb7fa7	0	50	f	\N	\N
3b28433d-7f07-43ff-a5b7-f91e09f5f172	\N	registration-recaptcha-action	466b29ba-5081-488d-9245-7ea9c707034a	b456c864-fee0-4ee7-ba50-8df50deb7fa7	3	60	f	\N	\N
eb759cdb-086d-403c-a7a1-d20544122b01	\N	registration-terms-and-conditions	466b29ba-5081-488d-9245-7ea9c707034a	b456c864-fee0-4ee7-ba50-8df50deb7fa7	3	70	f	\N	\N
a235bcd9-d5ec-441c-bbab-7b4f3800787d	\N	reset-credentials-choose-user	466b29ba-5081-488d-9245-7ea9c707034a	a4361dd5-075e-45e8-a2c1-6c65826e9b1b	0	10	f	\N	\N
db6121f4-eb09-43d6-b875-36040a7ae340	\N	reset-credential-email	466b29ba-5081-488d-9245-7ea9c707034a	a4361dd5-075e-45e8-a2c1-6c65826e9b1b	0	20	f	\N	\N
8a79e861-49de-4d55-b585-0f8bc75b995f	\N	reset-password	466b29ba-5081-488d-9245-7ea9c707034a	a4361dd5-075e-45e8-a2c1-6c65826e9b1b	0	30	f	\N	\N
ac33f345-ed6c-4ac8-a7a0-c2e76f93de8f	\N	\N	466b29ba-5081-488d-9245-7ea9c707034a	a4361dd5-075e-45e8-a2c1-6c65826e9b1b	1	40	t	ea8f1ad2-2508-4377-9df4-ef1ba1e88e00	\N
635f8401-3e44-4599-95d3-d7f1459721fc	\N	conditional-user-configured	466b29ba-5081-488d-9245-7ea9c707034a	ea8f1ad2-2508-4377-9df4-ef1ba1e88e00	0	10	f	\N	\N
86f445f5-02ae-424f-8718-13bfb306c7e0	\N	reset-otp	466b29ba-5081-488d-9245-7ea9c707034a	ea8f1ad2-2508-4377-9df4-ef1ba1e88e00	0	20	f	\N	\N
ff216602-1f9d-4d4d-8535-2dd3da09582a	\N	client-secret	466b29ba-5081-488d-9245-7ea9c707034a	74aaa948-2100-4708-ad21-a31e3341ff8c	2	10	f	\N	\N
e6aff39f-4a80-4362-b73f-421bdd8d97f7	\N	client-jwt	466b29ba-5081-488d-9245-7ea9c707034a	74aaa948-2100-4708-ad21-a31e3341ff8c	2	20	f	\N	\N
772275fd-370b-49f7-8acf-14d697474be4	\N	client-secret-jwt	466b29ba-5081-488d-9245-7ea9c707034a	74aaa948-2100-4708-ad21-a31e3341ff8c	2	30	f	\N	\N
029e660e-619b-4be9-9486-b1662f628a0b	\N	client-x509	466b29ba-5081-488d-9245-7ea9c707034a	74aaa948-2100-4708-ad21-a31e3341ff8c	2	40	f	\N	\N
df1c49f3-8407-49ff-b4e8-183fa544b1e5	\N	idp-review-profile	466b29ba-5081-488d-9245-7ea9c707034a	a8fa7ce7-4a70-440d-8db2-e20e9d3757b9	0	10	f	\N	73a9ec8e-eb58-402b-bfe7-362ef96ab990
1d358064-27c1-4172-b4a2-6723d7a4dc84	\N	\N	466b29ba-5081-488d-9245-7ea9c707034a	a8fa7ce7-4a70-440d-8db2-e20e9d3757b9	0	20	t	013c6adb-a04b-4b2f-a58c-504d8c810d2c	\N
30f901e5-874e-47a4-9bdc-f842593abe12	\N	idp-create-user-if-unique	466b29ba-5081-488d-9245-7ea9c707034a	013c6adb-a04b-4b2f-a58c-504d8c810d2c	2	10	f	\N	98550f61-b9bb-4fa5-bf17-59899e4c0056
0681dfad-7dec-487c-ae27-ea8fec8d39ab	\N	\N	466b29ba-5081-488d-9245-7ea9c707034a	013c6adb-a04b-4b2f-a58c-504d8c810d2c	2	20	t	df3fc1dd-4187-4534-85b4-3c709b732f06	\N
43253466-3596-4cf9-9918-cc25319fd0bc	\N	idp-confirm-link	466b29ba-5081-488d-9245-7ea9c707034a	df3fc1dd-4187-4534-85b4-3c709b732f06	0	10	f	\N	\N
e5b49f29-fdf4-4ba6-9058-2d12d0817608	\N	\N	466b29ba-5081-488d-9245-7ea9c707034a	df3fc1dd-4187-4534-85b4-3c709b732f06	0	20	t	2f8d1b0e-b594-43d3-ad55-f8ae60780342	\N
03faf056-bb8e-4d78-a56b-262ad3f3196d	\N	idp-email-verification	466b29ba-5081-488d-9245-7ea9c707034a	2f8d1b0e-b594-43d3-ad55-f8ae60780342	2	10	f	\N	\N
c0f38a98-b853-430b-a720-44c8f82b2bc9	\N	\N	466b29ba-5081-488d-9245-7ea9c707034a	2f8d1b0e-b594-43d3-ad55-f8ae60780342	2	20	t	0920090a-eb26-4a97-913e-b570a25f5284	\N
3f1a3980-40f2-4b10-9e0e-b54d253effd2	\N	idp-username-password-form	466b29ba-5081-488d-9245-7ea9c707034a	0920090a-eb26-4a97-913e-b570a25f5284	0	10	f	\N	\N
24b8e5e6-00f2-447e-8682-8b8eb29c35d1	\N	\N	466b29ba-5081-488d-9245-7ea9c707034a	0920090a-eb26-4a97-913e-b570a25f5284	1	20	t	9dfcbe37-49c4-4584-8727-415867659473	\N
10bf603f-d8fb-4966-bd14-abd02db16cab	\N	conditional-user-configured	466b29ba-5081-488d-9245-7ea9c707034a	9dfcbe37-49c4-4584-8727-415867659473	0	10	f	\N	\N
ed794cc3-d900-45bc-978a-001d6f1b048c	\N	auth-otp-form	466b29ba-5081-488d-9245-7ea9c707034a	9dfcbe37-49c4-4584-8727-415867659473	0	20	f	\N	\N
e39464bb-a64a-4f79-85c9-51eceada666d	\N	http-basic-authenticator	466b29ba-5081-488d-9245-7ea9c707034a	3d567686-92db-4b57-9511-16389b9d1879	0	10	f	\N	\N
bb488dc4-9566-49d0-9678-70a2f0475fd3	\N	docker-http-basic-authenticator	466b29ba-5081-488d-9245-7ea9c707034a	1339e4b5-6871-4a64-be8a-fae1eaf6b594	0	10	f	\N	\N
432e5b22-5680-4d42-858a-59afd00d9862	\N	auth-cookie	55e0b680-0bdb-451b-acf8-9c5eacce36dc	582e7173-f038-485f-adbb-fe980c09894d	2	10	f	\N	\N
08ba4c0e-1583-4274-8f06-9a3b051bc880	\N	auth-spnego	55e0b680-0bdb-451b-acf8-9c5eacce36dc	582e7173-f038-485f-adbb-fe980c09894d	3	20	f	\N	\N
8a5da5c8-cd96-4411-a456-be8c47b8853f	\N	identity-provider-redirector	55e0b680-0bdb-451b-acf8-9c5eacce36dc	582e7173-f038-485f-adbb-fe980c09894d	2	25	f	\N	\N
b34fac06-15e0-4c76-84e7-54306b6d84c7	\N	\N	55e0b680-0bdb-451b-acf8-9c5eacce36dc	582e7173-f038-485f-adbb-fe980c09894d	2	30	t	a5fbf71d-3995-43dc-be07-330aef344689	\N
689ef0a9-266e-4bfa-88ee-a8795219dd22	\N	auth-username-password-form	55e0b680-0bdb-451b-acf8-9c5eacce36dc	a5fbf71d-3995-43dc-be07-330aef344689	0	10	f	\N	\N
0dc6b308-bfd5-4155-ab69-583854ffa7bb	\N	\N	55e0b680-0bdb-451b-acf8-9c5eacce36dc	a5fbf71d-3995-43dc-be07-330aef344689	1	20	t	7a6a63f1-cf87-41e9-a565-b3b610a78c05	\N
ea66cd69-5bf7-425e-86bb-5b9924fb9fff	\N	conditional-user-configured	55e0b680-0bdb-451b-acf8-9c5eacce36dc	7a6a63f1-cf87-41e9-a565-b3b610a78c05	0	10	f	\N	\N
0d7346fd-8031-4a7f-8aa0-869c8d076ded	\N	auth-otp-form	55e0b680-0bdb-451b-acf8-9c5eacce36dc	7a6a63f1-cf87-41e9-a565-b3b610a78c05	0	20	f	\N	\N
80eeecdb-4ada-4805-832c-a2af3d4971b8	\N	direct-grant-validate-username	55e0b680-0bdb-451b-acf8-9c5eacce36dc	616201a6-20f2-42ca-92b4-f2e39ee273b6	0	10	f	\N	\N
4685d1d3-ca38-469d-b8a0-f5779f5314b0	\N	direct-grant-validate-password	55e0b680-0bdb-451b-acf8-9c5eacce36dc	616201a6-20f2-42ca-92b4-f2e39ee273b6	0	20	f	\N	\N
abb63a15-6843-4801-a09f-0099cc604748	\N	\N	55e0b680-0bdb-451b-acf8-9c5eacce36dc	616201a6-20f2-42ca-92b4-f2e39ee273b6	1	30	t	e9cad3e6-6531-4452-84ce-30f37a58a884	\N
c039e2ce-0f93-4aab-a335-b81abde6b69e	\N	conditional-user-configured	55e0b680-0bdb-451b-acf8-9c5eacce36dc	e9cad3e6-6531-4452-84ce-30f37a58a884	0	10	f	\N	\N
c82fd641-3bb5-4dab-93c9-92f64c35704f	\N	direct-grant-validate-otp	55e0b680-0bdb-451b-acf8-9c5eacce36dc	e9cad3e6-6531-4452-84ce-30f37a58a884	0	20	f	\N	\N
2534279e-7685-41d3-95ad-01ab6d0bfcfc	\N	registration-page-form	55e0b680-0bdb-451b-acf8-9c5eacce36dc	9f62652d-a70b-44c0-82d4-086ae3837fb2	0	10	t	88cdca22-c311-4a9c-a050-680563b7bb98	\N
1591f869-7cf5-4918-b490-b6e4812cc963	\N	registration-user-creation	55e0b680-0bdb-451b-acf8-9c5eacce36dc	88cdca22-c311-4a9c-a050-680563b7bb98	0	20	f	\N	\N
16276153-e079-4fff-8482-ca25c91eb101	\N	registration-password-action	55e0b680-0bdb-451b-acf8-9c5eacce36dc	88cdca22-c311-4a9c-a050-680563b7bb98	0	50	f	\N	\N
f404d052-0c77-491c-a572-8f74d838ec44	\N	registration-recaptcha-action	55e0b680-0bdb-451b-acf8-9c5eacce36dc	88cdca22-c311-4a9c-a050-680563b7bb98	3	60	f	\N	\N
d545b4d5-22ef-49f9-9a3f-315a581f61f4	\N	registration-terms-and-conditions	55e0b680-0bdb-451b-acf8-9c5eacce36dc	88cdca22-c311-4a9c-a050-680563b7bb98	3	70	f	\N	\N
e12ba107-760a-4623-ae8c-1ea2b7f7355f	\N	reset-credentials-choose-user	55e0b680-0bdb-451b-acf8-9c5eacce36dc	c718cfaf-f006-4740-b908-d473b2c96455	0	10	f	\N	\N
91461037-cbc5-48a0-bc75-15e180641980	\N	reset-credential-email	55e0b680-0bdb-451b-acf8-9c5eacce36dc	c718cfaf-f006-4740-b908-d473b2c96455	0	20	f	\N	\N
95ecfa74-8a99-4aa6-8d6d-5245c1811cf2	\N	reset-password	55e0b680-0bdb-451b-acf8-9c5eacce36dc	c718cfaf-f006-4740-b908-d473b2c96455	0	30	f	\N	\N
0f83308b-95ca-4437-8d1c-a4092fd3355e	\N	\N	55e0b680-0bdb-451b-acf8-9c5eacce36dc	c718cfaf-f006-4740-b908-d473b2c96455	1	40	t	5835fc6e-27cd-4ff5-971d-dd4229684816	\N
9c6a68dc-1012-4965-8d0d-723a532ee247	\N	conditional-user-configured	55e0b680-0bdb-451b-acf8-9c5eacce36dc	5835fc6e-27cd-4ff5-971d-dd4229684816	0	10	f	\N	\N
8aae7b8f-86ba-4b54-8eb4-ab668a3fd1ce	\N	reset-otp	55e0b680-0bdb-451b-acf8-9c5eacce36dc	5835fc6e-27cd-4ff5-971d-dd4229684816	0	20	f	\N	\N
6691f095-25b9-4d6e-8975-b20e591f1ddb	\N	client-secret	55e0b680-0bdb-451b-acf8-9c5eacce36dc	a8a77821-c539-4ec0-be77-9fb443fd5c55	2	10	f	\N	\N
695cdf75-860e-4aff-a72a-6ddb6d4e8138	\N	client-jwt	55e0b680-0bdb-451b-acf8-9c5eacce36dc	a8a77821-c539-4ec0-be77-9fb443fd5c55	2	20	f	\N	\N
2877a43f-2fcf-4deb-9333-e2a0171c5dc5	\N	client-secret-jwt	55e0b680-0bdb-451b-acf8-9c5eacce36dc	a8a77821-c539-4ec0-be77-9fb443fd5c55	2	30	f	\N	\N
745c4470-3f72-4654-8886-4a39a4d206a7	\N	client-x509	55e0b680-0bdb-451b-acf8-9c5eacce36dc	a8a77821-c539-4ec0-be77-9fb443fd5c55	2	40	f	\N	\N
2a1f168e-d78d-4f73-bd17-f83f2efe259f	\N	idp-review-profile	55e0b680-0bdb-451b-acf8-9c5eacce36dc	aaecd8a6-366c-4625-9ea1-d661fe52613c	0	10	f	\N	19cd1125-c933-4153-be39-e2ecc5ced797
dfa541ee-9f7c-4f58-b478-a48fd613f7b2	\N	\N	55e0b680-0bdb-451b-acf8-9c5eacce36dc	aaecd8a6-366c-4625-9ea1-d661fe52613c	0	20	t	78ceb91a-4e51-4357-b841-32d67d558533	\N
9a7f82d0-075e-4ec7-92db-27029492f0c8	\N	idp-create-user-if-unique	55e0b680-0bdb-451b-acf8-9c5eacce36dc	78ceb91a-4e51-4357-b841-32d67d558533	2	10	f	\N	d585ec99-cde9-4e0e-92c2-b9389148d567
802808f2-a37e-47d7-aec2-0d2763543b0b	\N	\N	55e0b680-0bdb-451b-acf8-9c5eacce36dc	78ceb91a-4e51-4357-b841-32d67d558533	2	20	t	5946666a-6a8c-4440-af3b-02c31a17fc81	\N
1e1c8f8e-ae27-42f1-83b5-be73835b8285	\N	idp-confirm-link	55e0b680-0bdb-451b-acf8-9c5eacce36dc	5946666a-6a8c-4440-af3b-02c31a17fc81	0	10	f	\N	\N
79d74152-80db-4346-a94f-37bad28f2127	\N	\N	55e0b680-0bdb-451b-acf8-9c5eacce36dc	5946666a-6a8c-4440-af3b-02c31a17fc81	0	20	t	78a96fb0-7721-48d6-bbec-79c0224b1d0d	\N
5d02782d-fd97-4f2f-ae14-375c1aa3c21c	\N	idp-email-verification	55e0b680-0bdb-451b-acf8-9c5eacce36dc	78a96fb0-7721-48d6-bbec-79c0224b1d0d	2	10	f	\N	\N
6db307a9-74af-49db-b73d-2db51deb5c9d	\N	\N	55e0b680-0bdb-451b-acf8-9c5eacce36dc	78a96fb0-7721-48d6-bbec-79c0224b1d0d	2	20	t	46e4222d-5f1f-49b8-ba74-e75158b68532	\N
580887b0-1360-4896-bfa2-6f20a37d6ffc	\N	idp-username-password-form	55e0b680-0bdb-451b-acf8-9c5eacce36dc	46e4222d-5f1f-49b8-ba74-e75158b68532	0	10	f	\N	\N
a147b6e5-c762-4e08-9817-e6eb318aa1b7	\N	\N	55e0b680-0bdb-451b-acf8-9c5eacce36dc	46e4222d-5f1f-49b8-ba74-e75158b68532	1	20	t	615c4f11-65bb-468a-9aa2-c57618be4d31	\N
48c05ddb-b08a-4d87-a0b4-86c99f10307f	\N	conditional-user-configured	55e0b680-0bdb-451b-acf8-9c5eacce36dc	615c4f11-65bb-468a-9aa2-c57618be4d31	0	10	f	\N	\N
107854d7-7425-4fef-a2e8-c7b25e6738cb	\N	auth-otp-form	55e0b680-0bdb-451b-acf8-9c5eacce36dc	615c4f11-65bb-468a-9aa2-c57618be4d31	0	20	f	\N	\N
379e06ba-2bb3-437c-a0b2-328650b46a8f	\N	http-basic-authenticator	55e0b680-0bdb-451b-acf8-9c5eacce36dc	3833793f-421f-46b9-843c-b1394a6e49e8	0	10	f	\N	\N
01023439-a863-4b78-b7f6-acc078443df2	\N	docker-http-basic-authenticator	55e0b680-0bdb-451b-acf8-9c5eacce36dc	9ef68c06-420e-4793-917e-ce254cbb20b1	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
6d08abca-278e-4461-ae67-87612ca1e596	browser	browser based authentication	466b29ba-5081-488d-9245-7ea9c707034a	basic-flow	t	t
4630cdd7-7722-4004-b53e-79a64cec8423	forms	Username, password, otp and other auth forms.	466b29ba-5081-488d-9245-7ea9c707034a	basic-flow	f	t
54f29f48-1184-48fc-8408-38f946c597c0	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	466b29ba-5081-488d-9245-7ea9c707034a	basic-flow	f	t
9a27eff1-8400-4535-8b30-37c5099e068f	direct grant	OpenID Connect Resource Owner Grant	466b29ba-5081-488d-9245-7ea9c707034a	basic-flow	t	t
0f41b5c7-06ed-4e9c-af39-f74009766c4a	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	466b29ba-5081-488d-9245-7ea9c707034a	basic-flow	f	t
f5bb0ea1-4069-42c2-b190-009217ae3005	registration	registration flow	466b29ba-5081-488d-9245-7ea9c707034a	basic-flow	t	t
b456c864-fee0-4ee7-ba50-8df50deb7fa7	registration form	registration form	466b29ba-5081-488d-9245-7ea9c707034a	form-flow	f	t
a4361dd5-075e-45e8-a2c1-6c65826e9b1b	reset credentials	Reset credentials for a user if they forgot their password or something	466b29ba-5081-488d-9245-7ea9c707034a	basic-flow	t	t
ea8f1ad2-2508-4377-9df4-ef1ba1e88e00	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	466b29ba-5081-488d-9245-7ea9c707034a	basic-flow	f	t
74aaa948-2100-4708-ad21-a31e3341ff8c	clients	Base authentication for clients	466b29ba-5081-488d-9245-7ea9c707034a	client-flow	t	t
a8fa7ce7-4a70-440d-8db2-e20e9d3757b9	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	466b29ba-5081-488d-9245-7ea9c707034a	basic-flow	t	t
013c6adb-a04b-4b2f-a58c-504d8c810d2c	User creation or linking	Flow for the existing/non-existing user alternatives	466b29ba-5081-488d-9245-7ea9c707034a	basic-flow	f	t
df3fc1dd-4187-4534-85b4-3c709b732f06	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	466b29ba-5081-488d-9245-7ea9c707034a	basic-flow	f	t
2f8d1b0e-b594-43d3-ad55-f8ae60780342	Account verification options	Method with which to verity the existing account	466b29ba-5081-488d-9245-7ea9c707034a	basic-flow	f	t
0920090a-eb26-4a97-913e-b570a25f5284	Verify Existing Account by Re-authentication	Reauthentication of existing account	466b29ba-5081-488d-9245-7ea9c707034a	basic-flow	f	t
9dfcbe37-49c4-4584-8727-415867659473	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	466b29ba-5081-488d-9245-7ea9c707034a	basic-flow	f	t
3d567686-92db-4b57-9511-16389b9d1879	saml ecp	SAML ECP Profile Authentication Flow	466b29ba-5081-488d-9245-7ea9c707034a	basic-flow	t	t
1339e4b5-6871-4a64-be8a-fae1eaf6b594	docker auth	Used by Docker clients to authenticate against the IDP	466b29ba-5081-488d-9245-7ea9c707034a	basic-flow	t	t
582e7173-f038-485f-adbb-fe980c09894d	browser	browser based authentication	55e0b680-0bdb-451b-acf8-9c5eacce36dc	basic-flow	t	t
a5fbf71d-3995-43dc-be07-330aef344689	forms	Username, password, otp and other auth forms.	55e0b680-0bdb-451b-acf8-9c5eacce36dc	basic-flow	f	t
7a6a63f1-cf87-41e9-a565-b3b610a78c05	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	55e0b680-0bdb-451b-acf8-9c5eacce36dc	basic-flow	f	t
616201a6-20f2-42ca-92b4-f2e39ee273b6	direct grant	OpenID Connect Resource Owner Grant	55e0b680-0bdb-451b-acf8-9c5eacce36dc	basic-flow	t	t
e9cad3e6-6531-4452-84ce-30f37a58a884	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	55e0b680-0bdb-451b-acf8-9c5eacce36dc	basic-flow	f	t
9f62652d-a70b-44c0-82d4-086ae3837fb2	registration	registration flow	55e0b680-0bdb-451b-acf8-9c5eacce36dc	basic-flow	t	t
88cdca22-c311-4a9c-a050-680563b7bb98	registration form	registration form	55e0b680-0bdb-451b-acf8-9c5eacce36dc	form-flow	f	t
c718cfaf-f006-4740-b908-d473b2c96455	reset credentials	Reset credentials for a user if they forgot their password or something	55e0b680-0bdb-451b-acf8-9c5eacce36dc	basic-flow	t	t
5835fc6e-27cd-4ff5-971d-dd4229684816	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	55e0b680-0bdb-451b-acf8-9c5eacce36dc	basic-flow	f	t
a8a77821-c539-4ec0-be77-9fb443fd5c55	clients	Base authentication for clients	55e0b680-0bdb-451b-acf8-9c5eacce36dc	client-flow	t	t
aaecd8a6-366c-4625-9ea1-d661fe52613c	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	55e0b680-0bdb-451b-acf8-9c5eacce36dc	basic-flow	t	t
78ceb91a-4e51-4357-b841-32d67d558533	User creation or linking	Flow for the existing/non-existing user alternatives	55e0b680-0bdb-451b-acf8-9c5eacce36dc	basic-flow	f	t
5946666a-6a8c-4440-af3b-02c31a17fc81	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	55e0b680-0bdb-451b-acf8-9c5eacce36dc	basic-flow	f	t
78a96fb0-7721-48d6-bbec-79c0224b1d0d	Account verification options	Method with which to verity the existing account	55e0b680-0bdb-451b-acf8-9c5eacce36dc	basic-flow	f	t
46e4222d-5f1f-49b8-ba74-e75158b68532	Verify Existing Account by Re-authentication	Reauthentication of existing account	55e0b680-0bdb-451b-acf8-9c5eacce36dc	basic-flow	f	t
615c4f11-65bb-468a-9aa2-c57618be4d31	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	55e0b680-0bdb-451b-acf8-9c5eacce36dc	basic-flow	f	t
3833793f-421f-46b9-843c-b1394a6e49e8	saml ecp	SAML ECP Profile Authentication Flow	55e0b680-0bdb-451b-acf8-9c5eacce36dc	basic-flow	t	t
9ef68c06-420e-4793-917e-ce254cbb20b1	docker auth	Used by Docker clients to authenticate against the IDP	55e0b680-0bdb-451b-acf8-9c5eacce36dc	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
73a9ec8e-eb58-402b-bfe7-362ef96ab990	review profile config	466b29ba-5081-488d-9245-7ea9c707034a
98550f61-b9bb-4fa5-bf17-59899e4c0056	create unique user config	466b29ba-5081-488d-9245-7ea9c707034a
19cd1125-c933-4153-be39-e2ecc5ced797	review profile config	55e0b680-0bdb-451b-acf8-9c5eacce36dc
d585ec99-cde9-4e0e-92c2-b9389148d567	create unique user config	55e0b680-0bdb-451b-acf8-9c5eacce36dc
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
73a9ec8e-eb58-402b-bfe7-362ef96ab990	missing	update.profile.on.first.login
98550f61-b9bb-4fa5-bf17-59899e4c0056	false	require.password.update.after.registration
19cd1125-c933-4153-be39-e2ecc5ced797	missing	update.profile.on.first.login
d585ec99-cde9-4e0e-92c2-b9389148d567	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
9fad4d62-b215-4051-aff5-be0788d82f32	t	f	master-realm	0	f	\N	\N	t	\N	f	466b29ba-5081-488d-9245-7ea9c707034a	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
e3f22e78-f51f-49d9-9bb8-2e460002128d	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	466b29ba-5081-488d-9245-7ea9c707034a	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
5b617b10-fd84-467d-afbc-991dd9aaff9a	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	466b29ba-5081-488d-9245-7ea9c707034a	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
792c71e0-b797-4be7-85c7-559baaed8447	t	f	broker	0	f	\N	\N	t	\N	f	466b29ba-5081-488d-9245-7ea9c707034a	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
b844a64d-75aa-4b17-bfc2-dc5902d551a5	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	466b29ba-5081-488d-9245-7ea9c707034a	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
55590f36-81e5-45f3-a573-25d83c1612a4	t	f	admin-cli	0	t	\N	\N	f	\N	f	466b29ba-5081-488d-9245-7ea9c707034a	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
03dead48-43e4-4bfb-9178-fb382f9d15d4	t	f	testpoc-realm	0	f	\N	\N	t	\N	f	466b29ba-5081-488d-9245-7ea9c707034a	\N	0	f	f	testpoc Realm	f	client-secret	\N	\N	\N	t	f	f	f
493a3508-9d80-4057-9e08-b35f2471cedd	t	f	realm-management	0	f	\N	\N	t	\N	f	55e0b680-0bdb-451b-acf8-9c5eacce36dc	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	t	f	account	0	t	\N	/realms/testpoc/account/	f	\N	f	55e0b680-0bdb-451b-acf8-9c5eacce36dc	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
7f0a6944-b6cf-463a-a6ab-8eda364e1f8f	t	f	account-console	0	t	\N	/realms/testpoc/account/	f	\N	f	55e0b680-0bdb-451b-acf8-9c5eacce36dc	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
7a567829-1faf-4225-9bd4-b6c464d5d5d4	t	f	broker	0	f	\N	\N	t	\N	f	55e0b680-0bdb-451b-acf8-9c5eacce36dc	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
6f8b1d7b-a0f0-4c1f-8dc7-f81928b2b49b	t	f	security-admin-console	0	t	\N	/admin/testpoc/console/	f	\N	f	55e0b680-0bdb-451b-acf8-9c5eacce36dc	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
6c6cb88d-1232-4632-86f1-fc4e6c373ac9	t	f	admin-cli	0	t	\N	\N	f	\N	f	55e0b680-0bdb-451b-acf8-9c5eacce36dc	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
aa2242aa-87dd-4e31-a399-c8ca37bd0405	t	t	frontend-client	0	t	\N	http://localhost:5173	f		f	55e0b680-0bdb-451b-acf8-9c5eacce36dc	openid-connect	-1	t	f		f	client-secret	http://localhost:5173		\N	t	f	t	f
94e3a758-71cb-4427-be5f-c9ac760664ea	t	t	backend-api	0	f	rk3C8SPOdSTAKQhAZBsl7UbAHeGSJ40I		f		f	55e0b680-0bdb-451b-acf8-9c5eacce36dc	openid-connect	-1	t	f	backend	f	client-secret			\N	f	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
e3f22e78-f51f-49d9-9bb8-2e460002128d	post.logout.redirect.uris	+
5b617b10-fd84-467d-afbc-991dd9aaff9a	post.logout.redirect.uris	+
5b617b10-fd84-467d-afbc-991dd9aaff9a	pkce.code.challenge.method	S256
b844a64d-75aa-4b17-bfc2-dc5902d551a5	post.logout.redirect.uris	+
b844a64d-75aa-4b17-bfc2-dc5902d551a5	pkce.code.challenge.method	S256
33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	post.logout.redirect.uris	+
7f0a6944-b6cf-463a-a6ab-8eda364e1f8f	post.logout.redirect.uris	+
7f0a6944-b6cf-463a-a6ab-8eda364e1f8f	pkce.code.challenge.method	S256
6f8b1d7b-a0f0-4c1f-8dc7-f81928b2b49b	post.logout.redirect.uris	+
6f8b1d7b-a0f0-4c1f-8dc7-f81928b2b49b	pkce.code.challenge.method	S256
aa2242aa-87dd-4e31-a399-c8ca37bd0405	oauth2.device.authorization.grant.enabled	false
aa2242aa-87dd-4e31-a399-c8ca37bd0405	oidc.ciba.grant.enabled	false
aa2242aa-87dd-4e31-a399-c8ca37bd0405	backchannel.logout.session.required	true
aa2242aa-87dd-4e31-a399-c8ca37bd0405	backchannel.logout.revoke.offline.tokens	false
aa2242aa-87dd-4e31-a399-c8ca37bd0405	display.on.consent.screen	false
94e3a758-71cb-4427-be5f-c9ac760664ea	client.secret.creation.time	1763371790
94e3a758-71cb-4427-be5f-c9ac760664ea	oauth2.device.authorization.grant.enabled	false
94e3a758-71cb-4427-be5f-c9ac760664ea	oidc.ciba.grant.enabled	false
94e3a758-71cb-4427-be5f-c9ac760664ea	backchannel.logout.session.required	true
94e3a758-71cb-4427-be5f-c9ac760664ea	backchannel.logout.revoke.offline.tokens	false
94e3a758-71cb-4427-be5f-c9ac760664ea	display.on.consent.screen	false
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
aa62a70e-b1cf-411b-b6d9-0e290636ce40	offline_access	466b29ba-5081-488d-9245-7ea9c707034a	OpenID Connect built-in scope: offline_access	openid-connect
30576962-4def-4979-99fc-82c7164f9453	role_list	466b29ba-5081-488d-9245-7ea9c707034a	SAML role list	saml
52ab5f00-2616-471c-85a5-0be64918687e	profile	466b29ba-5081-488d-9245-7ea9c707034a	OpenID Connect built-in scope: profile	openid-connect
9b74be15-d556-46cb-b042-fe268583e0d5	email	466b29ba-5081-488d-9245-7ea9c707034a	OpenID Connect built-in scope: email	openid-connect
1b108be6-8769-4ec5-a136-abe1cfc2125c	address	466b29ba-5081-488d-9245-7ea9c707034a	OpenID Connect built-in scope: address	openid-connect
ab64eea5-00c7-45eb-bc69-d9da3bd438f4	phone	466b29ba-5081-488d-9245-7ea9c707034a	OpenID Connect built-in scope: phone	openid-connect
7ec16d10-bd47-40bb-aeae-8f2554ce252a	roles	466b29ba-5081-488d-9245-7ea9c707034a	OpenID Connect scope for add user roles to the access token	openid-connect
99063f26-c3cf-4609-b6cf-d38edb6fece6	web-origins	466b29ba-5081-488d-9245-7ea9c707034a	OpenID Connect scope for add allowed web origins to the access token	openid-connect
f6481506-05eb-4981-b743-2d894b1841e0	microprofile-jwt	466b29ba-5081-488d-9245-7ea9c707034a	Microprofile - JWT built-in scope	openid-connect
c7ba7c33-6a71-4299-b6e2-39464593dfd6	acr	466b29ba-5081-488d-9245-7ea9c707034a	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
ec152344-f8a1-4227-9389-b0b0293d0f37	offline_access	55e0b680-0bdb-451b-acf8-9c5eacce36dc	OpenID Connect built-in scope: offline_access	openid-connect
b884ab95-e32a-4485-b03f-396591124a77	role_list	55e0b680-0bdb-451b-acf8-9c5eacce36dc	SAML role list	saml
9a67f87a-34f6-4678-a507-305205a0010d	profile	55e0b680-0bdb-451b-acf8-9c5eacce36dc	OpenID Connect built-in scope: profile	openid-connect
1952b72c-142b-43a5-9926-7ed41f18138b	email	55e0b680-0bdb-451b-acf8-9c5eacce36dc	OpenID Connect built-in scope: email	openid-connect
c1d35745-4206-4261-b433-70f8f64664f5	address	55e0b680-0bdb-451b-acf8-9c5eacce36dc	OpenID Connect built-in scope: address	openid-connect
035adf6d-f934-4ce9-bd10-0dc03f0b90c2	phone	55e0b680-0bdb-451b-acf8-9c5eacce36dc	OpenID Connect built-in scope: phone	openid-connect
bf6ff1b7-7cb1-4962-b438-61026318323e	roles	55e0b680-0bdb-451b-acf8-9c5eacce36dc	OpenID Connect scope for add user roles to the access token	openid-connect
2d45929b-e6d9-404d-84d5-703c0f02b665	web-origins	55e0b680-0bdb-451b-acf8-9c5eacce36dc	OpenID Connect scope for add allowed web origins to the access token	openid-connect
5fb1d6f6-84ac-48a0-ba6e-5d67eb5552c1	microprofile-jwt	55e0b680-0bdb-451b-acf8-9c5eacce36dc	Microprofile - JWT built-in scope	openid-connect
dff8996b-1b63-4ccc-b74c-2324a18a5ca5	acr	55e0b680-0bdb-451b-acf8-9c5eacce36dc	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
8ac1b7b9-7453-4205-a1f3-8cbcbf0abf02	api-backend-scope	55e0b680-0bdb-451b-acf8-9c5eacce36dc		openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
aa62a70e-b1cf-411b-b6d9-0e290636ce40	true	display.on.consent.screen
aa62a70e-b1cf-411b-b6d9-0e290636ce40	${offlineAccessScopeConsentText}	consent.screen.text
30576962-4def-4979-99fc-82c7164f9453	true	display.on.consent.screen
30576962-4def-4979-99fc-82c7164f9453	${samlRoleListScopeConsentText}	consent.screen.text
52ab5f00-2616-471c-85a5-0be64918687e	true	display.on.consent.screen
52ab5f00-2616-471c-85a5-0be64918687e	${profileScopeConsentText}	consent.screen.text
52ab5f00-2616-471c-85a5-0be64918687e	true	include.in.token.scope
9b74be15-d556-46cb-b042-fe268583e0d5	true	display.on.consent.screen
9b74be15-d556-46cb-b042-fe268583e0d5	${emailScopeConsentText}	consent.screen.text
9b74be15-d556-46cb-b042-fe268583e0d5	true	include.in.token.scope
1b108be6-8769-4ec5-a136-abe1cfc2125c	true	display.on.consent.screen
1b108be6-8769-4ec5-a136-abe1cfc2125c	${addressScopeConsentText}	consent.screen.text
1b108be6-8769-4ec5-a136-abe1cfc2125c	true	include.in.token.scope
ab64eea5-00c7-45eb-bc69-d9da3bd438f4	true	display.on.consent.screen
ab64eea5-00c7-45eb-bc69-d9da3bd438f4	${phoneScopeConsentText}	consent.screen.text
ab64eea5-00c7-45eb-bc69-d9da3bd438f4	true	include.in.token.scope
7ec16d10-bd47-40bb-aeae-8f2554ce252a	true	display.on.consent.screen
7ec16d10-bd47-40bb-aeae-8f2554ce252a	${rolesScopeConsentText}	consent.screen.text
7ec16d10-bd47-40bb-aeae-8f2554ce252a	false	include.in.token.scope
99063f26-c3cf-4609-b6cf-d38edb6fece6	false	display.on.consent.screen
99063f26-c3cf-4609-b6cf-d38edb6fece6		consent.screen.text
99063f26-c3cf-4609-b6cf-d38edb6fece6	false	include.in.token.scope
f6481506-05eb-4981-b743-2d894b1841e0	false	display.on.consent.screen
f6481506-05eb-4981-b743-2d894b1841e0	true	include.in.token.scope
c7ba7c33-6a71-4299-b6e2-39464593dfd6	false	display.on.consent.screen
c7ba7c33-6a71-4299-b6e2-39464593dfd6	false	include.in.token.scope
ec152344-f8a1-4227-9389-b0b0293d0f37	true	display.on.consent.screen
ec152344-f8a1-4227-9389-b0b0293d0f37	${offlineAccessScopeConsentText}	consent.screen.text
b884ab95-e32a-4485-b03f-396591124a77	true	display.on.consent.screen
b884ab95-e32a-4485-b03f-396591124a77	${samlRoleListScopeConsentText}	consent.screen.text
9a67f87a-34f6-4678-a507-305205a0010d	true	display.on.consent.screen
9a67f87a-34f6-4678-a507-305205a0010d	${profileScopeConsentText}	consent.screen.text
9a67f87a-34f6-4678-a507-305205a0010d	true	include.in.token.scope
1952b72c-142b-43a5-9926-7ed41f18138b	true	display.on.consent.screen
1952b72c-142b-43a5-9926-7ed41f18138b	${emailScopeConsentText}	consent.screen.text
1952b72c-142b-43a5-9926-7ed41f18138b	true	include.in.token.scope
c1d35745-4206-4261-b433-70f8f64664f5	true	display.on.consent.screen
c1d35745-4206-4261-b433-70f8f64664f5	${addressScopeConsentText}	consent.screen.text
c1d35745-4206-4261-b433-70f8f64664f5	true	include.in.token.scope
035adf6d-f934-4ce9-bd10-0dc03f0b90c2	true	display.on.consent.screen
035adf6d-f934-4ce9-bd10-0dc03f0b90c2	${phoneScopeConsentText}	consent.screen.text
035adf6d-f934-4ce9-bd10-0dc03f0b90c2	true	include.in.token.scope
bf6ff1b7-7cb1-4962-b438-61026318323e	true	display.on.consent.screen
bf6ff1b7-7cb1-4962-b438-61026318323e	${rolesScopeConsentText}	consent.screen.text
bf6ff1b7-7cb1-4962-b438-61026318323e	false	include.in.token.scope
2d45929b-e6d9-404d-84d5-703c0f02b665	false	display.on.consent.screen
2d45929b-e6d9-404d-84d5-703c0f02b665		consent.screen.text
2d45929b-e6d9-404d-84d5-703c0f02b665	false	include.in.token.scope
5fb1d6f6-84ac-48a0-ba6e-5d67eb5552c1	false	display.on.consent.screen
5fb1d6f6-84ac-48a0-ba6e-5d67eb5552c1	true	include.in.token.scope
dff8996b-1b63-4ccc-b74c-2324a18a5ca5	false	display.on.consent.screen
dff8996b-1b63-4ccc-b74c-2324a18a5ca5	false	include.in.token.scope
8ac1b7b9-7453-4205-a1f3-8cbcbf0abf02	true	display.on.consent.screen
8ac1b7b9-7453-4205-a1f3-8cbcbf0abf02		consent.screen.text
8ac1b7b9-7453-4205-a1f3-8cbcbf0abf02	false	include.in.token.scope
8ac1b7b9-7453-4205-a1f3-8cbcbf0abf02		gui.order
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
e3f22e78-f51f-49d9-9bb8-2e460002128d	7ec16d10-bd47-40bb-aeae-8f2554ce252a	t
e3f22e78-f51f-49d9-9bb8-2e460002128d	9b74be15-d556-46cb-b042-fe268583e0d5	t
e3f22e78-f51f-49d9-9bb8-2e460002128d	c7ba7c33-6a71-4299-b6e2-39464593dfd6	t
e3f22e78-f51f-49d9-9bb8-2e460002128d	52ab5f00-2616-471c-85a5-0be64918687e	t
e3f22e78-f51f-49d9-9bb8-2e460002128d	99063f26-c3cf-4609-b6cf-d38edb6fece6	t
e3f22e78-f51f-49d9-9bb8-2e460002128d	ab64eea5-00c7-45eb-bc69-d9da3bd438f4	f
e3f22e78-f51f-49d9-9bb8-2e460002128d	1b108be6-8769-4ec5-a136-abe1cfc2125c	f
e3f22e78-f51f-49d9-9bb8-2e460002128d	aa62a70e-b1cf-411b-b6d9-0e290636ce40	f
e3f22e78-f51f-49d9-9bb8-2e460002128d	f6481506-05eb-4981-b743-2d894b1841e0	f
5b617b10-fd84-467d-afbc-991dd9aaff9a	7ec16d10-bd47-40bb-aeae-8f2554ce252a	t
5b617b10-fd84-467d-afbc-991dd9aaff9a	9b74be15-d556-46cb-b042-fe268583e0d5	t
5b617b10-fd84-467d-afbc-991dd9aaff9a	c7ba7c33-6a71-4299-b6e2-39464593dfd6	t
5b617b10-fd84-467d-afbc-991dd9aaff9a	52ab5f00-2616-471c-85a5-0be64918687e	t
5b617b10-fd84-467d-afbc-991dd9aaff9a	99063f26-c3cf-4609-b6cf-d38edb6fece6	t
5b617b10-fd84-467d-afbc-991dd9aaff9a	ab64eea5-00c7-45eb-bc69-d9da3bd438f4	f
5b617b10-fd84-467d-afbc-991dd9aaff9a	1b108be6-8769-4ec5-a136-abe1cfc2125c	f
5b617b10-fd84-467d-afbc-991dd9aaff9a	aa62a70e-b1cf-411b-b6d9-0e290636ce40	f
5b617b10-fd84-467d-afbc-991dd9aaff9a	f6481506-05eb-4981-b743-2d894b1841e0	f
55590f36-81e5-45f3-a573-25d83c1612a4	7ec16d10-bd47-40bb-aeae-8f2554ce252a	t
55590f36-81e5-45f3-a573-25d83c1612a4	9b74be15-d556-46cb-b042-fe268583e0d5	t
55590f36-81e5-45f3-a573-25d83c1612a4	c7ba7c33-6a71-4299-b6e2-39464593dfd6	t
55590f36-81e5-45f3-a573-25d83c1612a4	52ab5f00-2616-471c-85a5-0be64918687e	t
55590f36-81e5-45f3-a573-25d83c1612a4	99063f26-c3cf-4609-b6cf-d38edb6fece6	t
55590f36-81e5-45f3-a573-25d83c1612a4	ab64eea5-00c7-45eb-bc69-d9da3bd438f4	f
55590f36-81e5-45f3-a573-25d83c1612a4	1b108be6-8769-4ec5-a136-abe1cfc2125c	f
55590f36-81e5-45f3-a573-25d83c1612a4	aa62a70e-b1cf-411b-b6d9-0e290636ce40	f
55590f36-81e5-45f3-a573-25d83c1612a4	f6481506-05eb-4981-b743-2d894b1841e0	f
792c71e0-b797-4be7-85c7-559baaed8447	7ec16d10-bd47-40bb-aeae-8f2554ce252a	t
792c71e0-b797-4be7-85c7-559baaed8447	9b74be15-d556-46cb-b042-fe268583e0d5	t
792c71e0-b797-4be7-85c7-559baaed8447	c7ba7c33-6a71-4299-b6e2-39464593dfd6	t
792c71e0-b797-4be7-85c7-559baaed8447	52ab5f00-2616-471c-85a5-0be64918687e	t
792c71e0-b797-4be7-85c7-559baaed8447	99063f26-c3cf-4609-b6cf-d38edb6fece6	t
792c71e0-b797-4be7-85c7-559baaed8447	ab64eea5-00c7-45eb-bc69-d9da3bd438f4	f
792c71e0-b797-4be7-85c7-559baaed8447	1b108be6-8769-4ec5-a136-abe1cfc2125c	f
792c71e0-b797-4be7-85c7-559baaed8447	aa62a70e-b1cf-411b-b6d9-0e290636ce40	f
792c71e0-b797-4be7-85c7-559baaed8447	f6481506-05eb-4981-b743-2d894b1841e0	f
9fad4d62-b215-4051-aff5-be0788d82f32	7ec16d10-bd47-40bb-aeae-8f2554ce252a	t
9fad4d62-b215-4051-aff5-be0788d82f32	9b74be15-d556-46cb-b042-fe268583e0d5	t
9fad4d62-b215-4051-aff5-be0788d82f32	c7ba7c33-6a71-4299-b6e2-39464593dfd6	t
9fad4d62-b215-4051-aff5-be0788d82f32	52ab5f00-2616-471c-85a5-0be64918687e	t
9fad4d62-b215-4051-aff5-be0788d82f32	99063f26-c3cf-4609-b6cf-d38edb6fece6	t
9fad4d62-b215-4051-aff5-be0788d82f32	ab64eea5-00c7-45eb-bc69-d9da3bd438f4	f
9fad4d62-b215-4051-aff5-be0788d82f32	1b108be6-8769-4ec5-a136-abe1cfc2125c	f
9fad4d62-b215-4051-aff5-be0788d82f32	aa62a70e-b1cf-411b-b6d9-0e290636ce40	f
9fad4d62-b215-4051-aff5-be0788d82f32	f6481506-05eb-4981-b743-2d894b1841e0	f
b844a64d-75aa-4b17-bfc2-dc5902d551a5	7ec16d10-bd47-40bb-aeae-8f2554ce252a	t
b844a64d-75aa-4b17-bfc2-dc5902d551a5	9b74be15-d556-46cb-b042-fe268583e0d5	t
b844a64d-75aa-4b17-bfc2-dc5902d551a5	c7ba7c33-6a71-4299-b6e2-39464593dfd6	t
b844a64d-75aa-4b17-bfc2-dc5902d551a5	52ab5f00-2616-471c-85a5-0be64918687e	t
b844a64d-75aa-4b17-bfc2-dc5902d551a5	99063f26-c3cf-4609-b6cf-d38edb6fece6	t
b844a64d-75aa-4b17-bfc2-dc5902d551a5	ab64eea5-00c7-45eb-bc69-d9da3bd438f4	f
b844a64d-75aa-4b17-bfc2-dc5902d551a5	1b108be6-8769-4ec5-a136-abe1cfc2125c	f
b844a64d-75aa-4b17-bfc2-dc5902d551a5	aa62a70e-b1cf-411b-b6d9-0e290636ce40	f
b844a64d-75aa-4b17-bfc2-dc5902d551a5	f6481506-05eb-4981-b743-2d894b1841e0	f
33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	bf6ff1b7-7cb1-4962-b438-61026318323e	t
33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	2d45929b-e6d9-404d-84d5-703c0f02b665	t
33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	1952b72c-142b-43a5-9926-7ed41f18138b	t
33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	9a67f87a-34f6-4678-a507-305205a0010d	t
33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	dff8996b-1b63-4ccc-b74c-2324a18a5ca5	t
33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	035adf6d-f934-4ce9-bd10-0dc03f0b90c2	f
33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	5fb1d6f6-84ac-48a0-ba6e-5d67eb5552c1	f
33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	ec152344-f8a1-4227-9389-b0b0293d0f37	f
33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	c1d35745-4206-4261-b433-70f8f64664f5	f
7f0a6944-b6cf-463a-a6ab-8eda364e1f8f	bf6ff1b7-7cb1-4962-b438-61026318323e	t
7f0a6944-b6cf-463a-a6ab-8eda364e1f8f	2d45929b-e6d9-404d-84d5-703c0f02b665	t
7f0a6944-b6cf-463a-a6ab-8eda364e1f8f	1952b72c-142b-43a5-9926-7ed41f18138b	t
7f0a6944-b6cf-463a-a6ab-8eda364e1f8f	9a67f87a-34f6-4678-a507-305205a0010d	t
7f0a6944-b6cf-463a-a6ab-8eda364e1f8f	dff8996b-1b63-4ccc-b74c-2324a18a5ca5	t
7f0a6944-b6cf-463a-a6ab-8eda364e1f8f	035adf6d-f934-4ce9-bd10-0dc03f0b90c2	f
7f0a6944-b6cf-463a-a6ab-8eda364e1f8f	5fb1d6f6-84ac-48a0-ba6e-5d67eb5552c1	f
7f0a6944-b6cf-463a-a6ab-8eda364e1f8f	ec152344-f8a1-4227-9389-b0b0293d0f37	f
7f0a6944-b6cf-463a-a6ab-8eda364e1f8f	c1d35745-4206-4261-b433-70f8f64664f5	f
6c6cb88d-1232-4632-86f1-fc4e6c373ac9	bf6ff1b7-7cb1-4962-b438-61026318323e	t
6c6cb88d-1232-4632-86f1-fc4e6c373ac9	2d45929b-e6d9-404d-84d5-703c0f02b665	t
6c6cb88d-1232-4632-86f1-fc4e6c373ac9	1952b72c-142b-43a5-9926-7ed41f18138b	t
6c6cb88d-1232-4632-86f1-fc4e6c373ac9	9a67f87a-34f6-4678-a507-305205a0010d	t
6c6cb88d-1232-4632-86f1-fc4e6c373ac9	dff8996b-1b63-4ccc-b74c-2324a18a5ca5	t
6c6cb88d-1232-4632-86f1-fc4e6c373ac9	035adf6d-f934-4ce9-bd10-0dc03f0b90c2	f
6c6cb88d-1232-4632-86f1-fc4e6c373ac9	5fb1d6f6-84ac-48a0-ba6e-5d67eb5552c1	f
6c6cb88d-1232-4632-86f1-fc4e6c373ac9	ec152344-f8a1-4227-9389-b0b0293d0f37	f
6c6cb88d-1232-4632-86f1-fc4e6c373ac9	c1d35745-4206-4261-b433-70f8f64664f5	f
7a567829-1faf-4225-9bd4-b6c464d5d5d4	bf6ff1b7-7cb1-4962-b438-61026318323e	t
7a567829-1faf-4225-9bd4-b6c464d5d5d4	2d45929b-e6d9-404d-84d5-703c0f02b665	t
7a567829-1faf-4225-9bd4-b6c464d5d5d4	1952b72c-142b-43a5-9926-7ed41f18138b	t
7a567829-1faf-4225-9bd4-b6c464d5d5d4	9a67f87a-34f6-4678-a507-305205a0010d	t
7a567829-1faf-4225-9bd4-b6c464d5d5d4	dff8996b-1b63-4ccc-b74c-2324a18a5ca5	t
7a567829-1faf-4225-9bd4-b6c464d5d5d4	035adf6d-f934-4ce9-bd10-0dc03f0b90c2	f
7a567829-1faf-4225-9bd4-b6c464d5d5d4	5fb1d6f6-84ac-48a0-ba6e-5d67eb5552c1	f
7a567829-1faf-4225-9bd4-b6c464d5d5d4	ec152344-f8a1-4227-9389-b0b0293d0f37	f
7a567829-1faf-4225-9bd4-b6c464d5d5d4	c1d35745-4206-4261-b433-70f8f64664f5	f
493a3508-9d80-4057-9e08-b35f2471cedd	bf6ff1b7-7cb1-4962-b438-61026318323e	t
493a3508-9d80-4057-9e08-b35f2471cedd	2d45929b-e6d9-404d-84d5-703c0f02b665	t
493a3508-9d80-4057-9e08-b35f2471cedd	1952b72c-142b-43a5-9926-7ed41f18138b	t
493a3508-9d80-4057-9e08-b35f2471cedd	9a67f87a-34f6-4678-a507-305205a0010d	t
493a3508-9d80-4057-9e08-b35f2471cedd	dff8996b-1b63-4ccc-b74c-2324a18a5ca5	t
493a3508-9d80-4057-9e08-b35f2471cedd	035adf6d-f934-4ce9-bd10-0dc03f0b90c2	f
493a3508-9d80-4057-9e08-b35f2471cedd	5fb1d6f6-84ac-48a0-ba6e-5d67eb5552c1	f
493a3508-9d80-4057-9e08-b35f2471cedd	ec152344-f8a1-4227-9389-b0b0293d0f37	f
493a3508-9d80-4057-9e08-b35f2471cedd	c1d35745-4206-4261-b433-70f8f64664f5	f
6f8b1d7b-a0f0-4c1f-8dc7-f81928b2b49b	bf6ff1b7-7cb1-4962-b438-61026318323e	t
6f8b1d7b-a0f0-4c1f-8dc7-f81928b2b49b	2d45929b-e6d9-404d-84d5-703c0f02b665	t
6f8b1d7b-a0f0-4c1f-8dc7-f81928b2b49b	1952b72c-142b-43a5-9926-7ed41f18138b	t
6f8b1d7b-a0f0-4c1f-8dc7-f81928b2b49b	9a67f87a-34f6-4678-a507-305205a0010d	t
6f8b1d7b-a0f0-4c1f-8dc7-f81928b2b49b	dff8996b-1b63-4ccc-b74c-2324a18a5ca5	t
6f8b1d7b-a0f0-4c1f-8dc7-f81928b2b49b	035adf6d-f934-4ce9-bd10-0dc03f0b90c2	f
6f8b1d7b-a0f0-4c1f-8dc7-f81928b2b49b	5fb1d6f6-84ac-48a0-ba6e-5d67eb5552c1	f
6f8b1d7b-a0f0-4c1f-8dc7-f81928b2b49b	ec152344-f8a1-4227-9389-b0b0293d0f37	f
6f8b1d7b-a0f0-4c1f-8dc7-f81928b2b49b	c1d35745-4206-4261-b433-70f8f64664f5	f
aa2242aa-87dd-4e31-a399-c8ca37bd0405	bf6ff1b7-7cb1-4962-b438-61026318323e	t
aa2242aa-87dd-4e31-a399-c8ca37bd0405	2d45929b-e6d9-404d-84d5-703c0f02b665	t
aa2242aa-87dd-4e31-a399-c8ca37bd0405	1952b72c-142b-43a5-9926-7ed41f18138b	t
aa2242aa-87dd-4e31-a399-c8ca37bd0405	9a67f87a-34f6-4678-a507-305205a0010d	t
aa2242aa-87dd-4e31-a399-c8ca37bd0405	dff8996b-1b63-4ccc-b74c-2324a18a5ca5	t
aa2242aa-87dd-4e31-a399-c8ca37bd0405	035adf6d-f934-4ce9-bd10-0dc03f0b90c2	f
aa2242aa-87dd-4e31-a399-c8ca37bd0405	5fb1d6f6-84ac-48a0-ba6e-5d67eb5552c1	f
aa2242aa-87dd-4e31-a399-c8ca37bd0405	ec152344-f8a1-4227-9389-b0b0293d0f37	f
aa2242aa-87dd-4e31-a399-c8ca37bd0405	c1d35745-4206-4261-b433-70f8f64664f5	f
94e3a758-71cb-4427-be5f-c9ac760664ea	bf6ff1b7-7cb1-4962-b438-61026318323e	t
94e3a758-71cb-4427-be5f-c9ac760664ea	2d45929b-e6d9-404d-84d5-703c0f02b665	t
94e3a758-71cb-4427-be5f-c9ac760664ea	1952b72c-142b-43a5-9926-7ed41f18138b	t
94e3a758-71cb-4427-be5f-c9ac760664ea	9a67f87a-34f6-4678-a507-305205a0010d	t
94e3a758-71cb-4427-be5f-c9ac760664ea	dff8996b-1b63-4ccc-b74c-2324a18a5ca5	t
94e3a758-71cb-4427-be5f-c9ac760664ea	035adf6d-f934-4ce9-bd10-0dc03f0b90c2	f
94e3a758-71cb-4427-be5f-c9ac760664ea	5fb1d6f6-84ac-48a0-ba6e-5d67eb5552c1	f
94e3a758-71cb-4427-be5f-c9ac760664ea	ec152344-f8a1-4227-9389-b0b0293d0f37	f
94e3a758-71cb-4427-be5f-c9ac760664ea	c1d35745-4206-4261-b433-70f8f64664f5	f
aa2242aa-87dd-4e31-a399-c8ca37bd0405	8ac1b7b9-7453-4205-a1f3-8cbcbf0abf02	t
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
aa62a70e-b1cf-411b-b6d9-0e290636ce40	9e58e758-0643-418c-9cbc-d916c807e8de
ec152344-f8a1-4227-9389-b0b0293d0f37	561e8369-fe98-4aa2-a65b-c4b935e33c2a
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
210bb80e-80b5-42a8-a9f3-49d8b9bbfec4	Trusted Hosts	466b29ba-5081-488d-9245-7ea9c707034a	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	466b29ba-5081-488d-9245-7ea9c707034a	anonymous
d6f35b4a-657d-426f-bea9-130b0094197e	Consent Required	466b29ba-5081-488d-9245-7ea9c707034a	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	466b29ba-5081-488d-9245-7ea9c707034a	anonymous
c1563dbb-47fc-4175-9c46-da142720fcb4	Full Scope Disabled	466b29ba-5081-488d-9245-7ea9c707034a	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	466b29ba-5081-488d-9245-7ea9c707034a	anonymous
65469db3-71f0-470d-bc7b-d2377eea3cf5	Max Clients Limit	466b29ba-5081-488d-9245-7ea9c707034a	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	466b29ba-5081-488d-9245-7ea9c707034a	anonymous
4341444d-5791-453e-bc50-50ad4cb03556	Allowed Protocol Mapper Types	466b29ba-5081-488d-9245-7ea9c707034a	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	466b29ba-5081-488d-9245-7ea9c707034a	anonymous
0de6ad11-f58d-4233-91c7-76a6439f6c57	Allowed Client Scopes	466b29ba-5081-488d-9245-7ea9c707034a	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	466b29ba-5081-488d-9245-7ea9c707034a	anonymous
33d5a00c-24a2-4ba2-8980-28d62235bf0c	Allowed Protocol Mapper Types	466b29ba-5081-488d-9245-7ea9c707034a	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	466b29ba-5081-488d-9245-7ea9c707034a	authenticated
cdbe4885-cd8b-45dc-9dbf-f3bb1731ee90	Allowed Client Scopes	466b29ba-5081-488d-9245-7ea9c707034a	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	466b29ba-5081-488d-9245-7ea9c707034a	authenticated
ea8f2c80-a877-44c5-8eba-e1e3aafe18f6	rsa-generated	466b29ba-5081-488d-9245-7ea9c707034a	rsa-generated	org.keycloak.keys.KeyProvider	466b29ba-5081-488d-9245-7ea9c707034a	\N
3811f2b9-e579-4d4b-956c-48e58fdb3239	rsa-enc-generated	466b29ba-5081-488d-9245-7ea9c707034a	rsa-enc-generated	org.keycloak.keys.KeyProvider	466b29ba-5081-488d-9245-7ea9c707034a	\N
25209993-5f1a-4c63-bc15-5d8761f4180d	hmac-generated-hs512	466b29ba-5081-488d-9245-7ea9c707034a	hmac-generated	org.keycloak.keys.KeyProvider	466b29ba-5081-488d-9245-7ea9c707034a	\N
934bff74-8d16-4b41-bd1b-535aa0e19ce2	aes-generated	466b29ba-5081-488d-9245-7ea9c707034a	aes-generated	org.keycloak.keys.KeyProvider	466b29ba-5081-488d-9245-7ea9c707034a	\N
2481a699-7d99-48f6-8631-b6ef53f99fd5	\N	466b29ba-5081-488d-9245-7ea9c707034a	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	466b29ba-5081-488d-9245-7ea9c707034a	\N
cb3c8952-7991-459e-aef7-60afc8aca88e	rsa-generated	55e0b680-0bdb-451b-acf8-9c5eacce36dc	rsa-generated	org.keycloak.keys.KeyProvider	55e0b680-0bdb-451b-acf8-9c5eacce36dc	\N
76028a0f-c871-4cdf-a113-166486fd342b	rsa-enc-generated	55e0b680-0bdb-451b-acf8-9c5eacce36dc	rsa-enc-generated	org.keycloak.keys.KeyProvider	55e0b680-0bdb-451b-acf8-9c5eacce36dc	\N
e8f60675-644b-4310-b214-7289001d53d8	hmac-generated-hs512	55e0b680-0bdb-451b-acf8-9c5eacce36dc	hmac-generated	org.keycloak.keys.KeyProvider	55e0b680-0bdb-451b-acf8-9c5eacce36dc	\N
1bc00851-c22b-4c25-b521-6beb59c5a802	aes-generated	55e0b680-0bdb-451b-acf8-9c5eacce36dc	aes-generated	org.keycloak.keys.KeyProvider	55e0b680-0bdb-451b-acf8-9c5eacce36dc	\N
71db47f6-bcd7-4f68-8006-54502922e2ae	Trusted Hosts	55e0b680-0bdb-451b-acf8-9c5eacce36dc	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	55e0b680-0bdb-451b-acf8-9c5eacce36dc	anonymous
7645db2a-37d9-4e5c-b9b2-76499e5bc2cd	Consent Required	55e0b680-0bdb-451b-acf8-9c5eacce36dc	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	55e0b680-0bdb-451b-acf8-9c5eacce36dc	anonymous
b65d801a-fec5-45d4-b3f9-8cd3985f1133	Full Scope Disabled	55e0b680-0bdb-451b-acf8-9c5eacce36dc	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	55e0b680-0bdb-451b-acf8-9c5eacce36dc	anonymous
dd236552-4003-47e1-ac9b-a23b6eafaeb7	Max Clients Limit	55e0b680-0bdb-451b-acf8-9c5eacce36dc	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	55e0b680-0bdb-451b-acf8-9c5eacce36dc	anonymous
622f23da-8d01-49b0-9d46-a2ec52511b5e	Allowed Protocol Mapper Types	55e0b680-0bdb-451b-acf8-9c5eacce36dc	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	55e0b680-0bdb-451b-acf8-9c5eacce36dc	anonymous
e8ad3c83-54aa-48a3-a156-14c9f80d5663	Allowed Client Scopes	55e0b680-0bdb-451b-acf8-9c5eacce36dc	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	55e0b680-0bdb-451b-acf8-9c5eacce36dc	anonymous
400cc5b8-9792-4bab-8b19-16bae2872fdb	Allowed Protocol Mapper Types	55e0b680-0bdb-451b-acf8-9c5eacce36dc	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	55e0b680-0bdb-451b-acf8-9c5eacce36dc	authenticated
03b7a09c-e092-473b-9d52-02191f62b72c	Allowed Client Scopes	55e0b680-0bdb-451b-acf8-9c5eacce36dc	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	55e0b680-0bdb-451b-acf8-9c5eacce36dc	authenticated
783f0e8d-31d5-45fe-8fbd-9832083c7f1b	neurospin	55e0b680-0bdb-451b-acf8-9c5eacce36dc	ldap	org.keycloak.storage.UserStorageProvider	55e0b680-0bdb-451b-acf8-9c5eacce36dc	\N
300ca35b-6110-4114-8e7f-2cdffff6f3a3	username	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	55e0b680-0bdb-451b-acf8-9c5eacce36dc	\N
75db323d-3221-4e89-a7ea-b778f03361fc	first name	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	55e0b680-0bdb-451b-acf8-9c5eacce36dc	\N
088dad8d-87a2-4894-8b9f-0b4e5285782b	last name	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	55e0b680-0bdb-451b-acf8-9c5eacce36dc	\N
ca1c3e71-5b4e-4fd5-88c2-2e229c1bede6	email	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	55e0b680-0bdb-451b-acf8-9c5eacce36dc	\N
74b6581f-47ae-470b-bf21-6e2f6be38e2b	creation date	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	55e0b680-0bdb-451b-acf8-9c5eacce36dc	\N
74fd6bca-a1ed-458c-84c5-f64802e99269	modify date	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	user-attribute-ldap-mapper	org.keycloak.storage.ldap.mappers.LDAPStorageMapper	55e0b680-0bdb-451b-acf8-9c5eacce36dc	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
c74f1211-c2c3-489c-9efd-0351a66e0bde	cdbe4885-cd8b-45dc-9dbf-f3bb1731ee90	allow-default-scopes	true
82d4338d-4aaa-4d8a-be5c-2668e156d2f3	65469db3-71f0-470d-bc7b-d2377eea3cf5	max-clients	200
744551a8-e3b2-4795-b031-6c70ceb1436a	4341444d-5791-453e-bc50-50ad4cb03556	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
1ddde7ec-5853-4ca3-9fc7-7fe72f2a68ce	4341444d-5791-453e-bc50-50ad4cb03556	allowed-protocol-mapper-types	oidc-address-mapper
aea3f1ee-ffc8-49fd-8e72-3b875eaa2d32	4341444d-5791-453e-bc50-50ad4cb03556	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
fe791398-21a3-430e-9994-92e0bfff66ca	4341444d-5791-453e-bc50-50ad4cb03556	allowed-protocol-mapper-types	saml-user-attribute-mapper
c06c7642-6fff-45aa-a36f-a22d468e6780	4341444d-5791-453e-bc50-50ad4cb03556	allowed-protocol-mapper-types	oidc-full-name-mapper
4e6150f3-837e-4a6e-8008-6105abf36431	4341444d-5791-453e-bc50-50ad4cb03556	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
9a692b3c-52df-410a-80a4-de2e7bd5ef20	4341444d-5791-453e-bc50-50ad4cb03556	allowed-protocol-mapper-types	saml-role-list-mapper
050d53e1-f4c4-445f-9ffd-acc784177cd7	4341444d-5791-453e-bc50-50ad4cb03556	allowed-protocol-mapper-types	saml-user-property-mapper
ce60fc0a-756c-4a4c-a141-8c9b07442b7a	210bb80e-80b5-42a8-a9f3-49d8b9bbfec4	host-sending-registration-request-must-match	true
b9e09674-1038-40e8-89a5-ea493db28ed4	210bb80e-80b5-42a8-a9f3-49d8b9bbfec4	client-uris-must-match	true
1287d04e-416c-4763-94bd-c20a072a06b2	33d5a00c-24a2-4ba2-8980-28d62235bf0c	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
42a10a04-3d37-42ff-99c4-10486439c824	33d5a00c-24a2-4ba2-8980-28d62235bf0c	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
c2464067-c7c8-42be-8696-9cb6da7522af	33d5a00c-24a2-4ba2-8980-28d62235bf0c	allowed-protocol-mapper-types	saml-user-property-mapper
dd0a81c5-cba1-472e-b858-ac4d795fee63	33d5a00c-24a2-4ba2-8980-28d62235bf0c	allowed-protocol-mapper-types	oidc-full-name-mapper
e73efabf-cd9c-48b9-bd33-c4844f220a74	33d5a00c-24a2-4ba2-8980-28d62235bf0c	allowed-protocol-mapper-types	saml-user-attribute-mapper
aa808f60-f6b2-44f6-ac64-a9df0b8a297c	33d5a00c-24a2-4ba2-8980-28d62235bf0c	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
022c8805-f62d-4630-83c3-967e40051ec4	33d5a00c-24a2-4ba2-8980-28d62235bf0c	allowed-protocol-mapper-types	oidc-address-mapper
b405a403-ee8a-4971-9cbd-f5c7d7f89339	33d5a00c-24a2-4ba2-8980-28d62235bf0c	allowed-protocol-mapper-types	saml-role-list-mapper
2c901796-943a-41b0-bd2a-1688ad7bfba9	0de6ad11-f58d-4233-91c7-76a6439f6c57	allow-default-scopes	true
b117709b-d781-41ff-8c2f-c2542d7d6467	934bff74-8d16-4b41-bd1b-535aa0e19ce2	kid	e6fc5837-7d72-44d7-a3dd-b81f0442de40
c8808e54-5a64-4b4c-af6e-731bc099bc23	934bff74-8d16-4b41-bd1b-535aa0e19ce2	secret	YLn6xQ9P1o-n6QCps0dL8w
3e759c73-601a-4ca3-8726-981797d5d16a	934bff74-8d16-4b41-bd1b-535aa0e19ce2	priority	100
5d2c01e9-4683-41c9-95cf-a8ceb91afb7c	ea8f2c80-a877-44c5-8eba-e1e3aafe18f6	priority	100
bbcf24ec-eff0-410a-a84e-f7034d0799a0	ea8f2c80-a877-44c5-8eba-e1e3aafe18f6	certificate	MIICmzCCAYMCBgGajidYGjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUxMTE2MTkzMDM0WhcNMzUxMTE2MTkzMjE0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCXUhlzS1doA3lmjONcZeDmZvN3vwfedRGVasX1KxmZF4okEFbJ3W5AXwkm6ymppU4luhFEP0+dQOrVmTG1k2MdIPGI7y0W03esthL2fw2mCwKJF2d9fp/KvYFGAHtoboBN4795H4UfwFoicW4OGDILgDCRKFb5/T3vX2E5K5rpCDeqvYjRk2k5NzUUeW2+eAs04pXegCIBnGc22Z/UqXwhNs+ldTqRyE/9YGV7vDHR0kc1E+Hn5pJngsN3kVhq4EHJtoe5wwZ0rfBOrx30Cu/uC2ZdRrjFvurOce4MKppjqvWQM627FsGkV7cJ5bntv8LWhLmp17R42wJuGi93M90HAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAIn0XK8XGcPTf6PLcjhpIq8X9hG0BnwT3BV4EL7vsulGtloTD6IfNZchQckOXAU7+I4Dg5H3UTg1Iv9ETSTgfp0UjxnjGTxUtIzAiwJOOXW20CCh/gPp7EVWGX2ZjK9tyQ01aWUWgvn5swbKUfeu3pS4mScIxTt/vTBtugOdjjYNznckXsYNZtYmETlUlT/FEkReLYhIjMtODzYp3Z771JUPor8pSKA14YRcLUcBnuSGg+d0bM3Ydff1FMdk1jFtryxgshuflthvdW5imox0709SEDYOmce3eEs/+4hnE3I+2u3buWtgzwR+vvwDfmqNfACo4NSXS5fnj1JBfY2qbPw=
c32c4e7b-d742-471b-a4c9-6da6385b3ab0	ea8f2c80-a877-44c5-8eba-e1e3aafe18f6	keyUse	SIG
4d3b730a-24da-4c7b-9bea-8ed0e46b0ac0	ea8f2c80-a877-44c5-8eba-e1e3aafe18f6	privateKey	MIIEpAIBAAKCAQEAl1IZc0tXaAN5ZozjXGXg5mbzd78H3nURlWrF9SsZmReKJBBWyd1uQF8JJuspqaVOJboRRD9PnUDq1ZkxtZNjHSDxiO8tFtN3rLYS9n8NpgsCiRdnfX6fyr2BRgB7aG6ATeO/eR+FH8BaInFuDhgyC4AwkShW+f09719hOSua6Qg3qr2I0ZNpOTc1FHltvngLNOKV3oAiAZxnNtmf1Kl8ITbPpXU6kchP/WBle7wx0dJHNRPh5+aSZ4LDd5FYauBBybaHucMGdK3wTq8d9Arv7gtmXUa4xb7qznHuDCqaY6r1kDOtuxbBpFe3CeW57b/C1oS5qde0eNsCbhovdzPdBwIDAQABAoIBAEJNqvEl1gqxWwRgP09BJKZP/eY+Qghra2T4//xJAlJeSh07O4wABksWWUBAUmUPFYraWK56vzu8MimdknZpOkiNIshJZIxX5Fw8+1oembBjqpy/MI2Aaiu/lWFC3NAJexal8EP2V7Jt6hClev+aAnOfm6g+8L1hBT5ZoJQYUyw/zPVRMU9+zL2UFNx+bBYyOvmrK5k1jyEL3NA80271suIHzEcxgGSUGA2bzCFREPSLDGlnedymFenerrmvAAsEvuuXA9aFV3+5MOGtSbBCCMqjynKyDrqmgaaVhUnkoyc+VBt6Qgvd7cu32M0ucGQKZVeDga7GgFoZr8W3w/MoTKECgYEAys5aXkWmWwq/Yhko+G0RolnIBLLHktRugS4UYyOmTC4Of5N4qnF+L+HNID8+WIqAsDm1j+UHXFIq6Phtnl/MbOKtquBZFgqxufew8M+/NUllBaSKa+gKNOhVQkStJJuwFciN36+qsMzyTweHRa8Q5RfvXnizNbkHFI2fWEAgKXMCgYEAvwKzxOACoJinqFPmJuWm3yO5IkQjLaj2bm5itm9jheRMl/gL1DekaOjMIcffyQoFF2xyJ1NbJByBZD8LP7aFiF/CubX+TPDqMuQUE7PmO4vloNC63HX2EmPa4VhbkvzHUPJ9SDIBiS1/00y51eTwUyeFnqO3EE5pij/Wb2t1aR0CgYEAvgA7q6yHIS5dhPNbbfsJFVgVy0kPLqF08fOQyBzDFQXlMWKhHtX7SbK7caWurFb+H5vBXRFOJxEYAHGWiVTo+W4ZFEjhTYQxY7AJhmKrmamsSnAP+u5GebDdB5u9ttlhS9c8C7/RI5iuvpmoAwHzyx30dUaRZxh06K2SBqT1PL8CgYAs+uzsergDq48ns4IqPMBcIaRyLkt+cCCABtyWC4sLN6TV0KKwed3smo2fktrfE835Ix+KpTV8Pn415ia2/TtazvojE3lsEvuDunQD48Re12XexeiLC/hDgmJD2LPP3FjvdfsMqkH0VNOaJaJJfV0ep9ruba0pWN2/oaLUoCCI/QKBgQClT4q/mHEkv/T/c4/BeopFe76HtTUtSR4PsTJZWHJ+ZA74uobk9GY7xO8BuzMnVrTfzYjK2K5CdqbIKAuXeh9xp/v8RXojtw6V1nC2R1l8WsSCUJChoT8aPmlVbmBCxxqp0XrN1d1GUqwpjAjP0Eo5OX+CTv54WgEmXMwj+fyz0A==
91282e47-dda9-4f87-a53c-55697c3c2273	2481a699-7d99-48f6-8631-b6ef53f99fd5	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
8448f37f-d33e-446b-bbe5-3c206b909965	25209993-5f1a-4c63-bc15-5d8761f4180d	priority	100
3f4faa10-700f-49e3-8c9a-7e5c3785733b	25209993-5f1a-4c63-bc15-5d8761f4180d	kid	8c699f16-8b7c-4451-8a28-087bb2f5664f
96a7e12b-5548-4c78-aceb-26a5d5c60e42	25209993-5f1a-4c63-bc15-5d8761f4180d	algorithm	HS512
85656d98-7e7f-474d-8057-8a183100e483	25209993-5f1a-4c63-bc15-5d8761f4180d	secret	A-li_jtcP31b2wMi-oMtB4vgjkAyCeWqMZNdHzv7SKgosiC1pl2fGRrLWRlnA-S-T8ESRX-meVmomXbzVVtzKUnlG6HDQtYbcW6M0jD4kUv4ga0en0aT1qVq9_56_qUVCDbU_09oavvj1Vh7bwfrdV0kDUoJI0OKm-8Ib84UHew
018811c2-bc6c-4e7a-bc35-c66c3866c59c	3811f2b9-e579-4d4b-956c-48e58fdb3239	privateKey	MIIEogIBAAKCAQEAjjK4yumhn5vpNEZWnBUW02ZpW2A5nhJJXPf5XNPbmGncZc4pX6VwXh0tRkAWXLdFn+hTHMmDxSBT8UfFFSocALo31RLnblYq0qPyO6Dh7HAcaUNeJ14jI1l8BJqzYtkjGuUQOQY+D85T9dowbwjTm5IUIfvrfRWpyez6AQUVjK0LRxOwag7Ks8g7xIhH8brVNfzFGAEOLoh7didzk5ncpHYqmPmmoYYftNsMINYf7YPx0HoyMeY9Oo+wsnpOcIFiIZqrphPYyUjTqCQC3zqlD6FwdcEPT1mUAaQgFdXzSPuinSCAw3f0dxllQ3mY6aSxoVKlFhiU0Gb5B26sgxt8AwIDAQABAoIBADE4LE+MC9Yf1NozyJHRGOwGhExNI9Rrlvo3mRhA+r8oUVHpyNdi/+CLr9qjnznrdA2UEISj2dj3Rib7hSO8xiGYU3AM0Y+XAs6TUerC1sCM08C5wVLWGkqHlE5Rr+r0ptqN1A4w83VsIRK1udMNFpXAO/jBZrMOtwz+WlDVDi75SJfMkPl16KghhOHQql7LTkpfm3t/Zl2PmDQViZxLE5iMkhkG75sKlouhJNGyvs9se/hQArcL0dNMB2hHL9zzm/NeDpwMXUnAhI+6xGhMh/XqwHEc3MgEvvAmhSGhxRZywpDpR553v4pwdtwbdt8AGcxpBVdEzNEdOrrvWGFtFWkCgYEAwZSsmDOxc22QiIc7sn7W032kmeR03BIvufylrW5CDdbDkj/PX9L0hBA5YxKkdyNXA7uAECyjsDsR51ac4+2tWnFaWhr1E25xbnQnW0ZMjmVP2GQOQIeQ/H0JxnAhQOxoNV07sTndP+EwvcEESUY7lApF7S/AVe10rNY6SCXEbKsCgYEAvAydeCuiOBNnX98idDKBoeDQflxw52iVp1A9Xzn1gk4a10G7IHRLxK9fdjS4l1i0aog+pqH7u1EkRn9VVklNUyuJaFr41mIJtP+KbIeaLJlIAM8YXtUJqy8FlE/X3VyPiH7wxc//W72MU5BEiVn3coF1GSzexqkB7e+gEn4m/gkCgYBgVYKGw8LdNHsm1lWpAGIcIXyWcRCOrCZAIjC43BPXGzd8QnEKuMqiJgjI+vAJsfaNjvOuGOjkvKCuRXYSH6eTSLG0AZJQtzePxhIH5DYY7uYLQ8+r4UsPu5HvxMFns74wQFOCYM9wCLre0300kdT4WRxvasIGgQL9OCcM3G6hvQKBgG/KUBKQXe9YGaw0yhapr8a8DzYPXk8zLUQ5v0JNAlZkeDBfMw8oE6LpXqa20MWoRhjOxe/pe+zvX9FJAUI6cW1wBE+1RRitT3f6MiAyvMSmmtdgReyaWRUa7wYsMPe3ftx2Gkx+SiAPnsxOh2/fu+qmayZ8NjODZVI9kbtso2GBAoGAbiZfT7LAitFJ5fNVEtito3n8jR6vaF9KBhwpAeZH2lZHMZ+4HsZRUwM9n1ScI+cwjQ59+Hm2LDTMgmj0FRXWN64nXvdYpfrHcD7A9JBeyJrPy+5tabHKp/kQmw0B6KpYU59DLKEaIkiYWdUQxGt90ry2CeCRlUt1qG6NLPqdwng=
20513911-27d8-4fa7-9cc9-2b41a9a7371e	3811f2b9-e579-4d4b-956c-48e58fdb3239	priority	100
00bab127-8922-4628-8072-e82552e1ee4a	3811f2b9-e579-4d4b-956c-48e58fdb3239	algorithm	RSA-OAEP
3d7a6873-56bd-4c83-ba3a-36e46aea1298	3811f2b9-e579-4d4b-956c-48e58fdb3239	certificate	MIICmzCCAYMCBgGajidZADANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUxMTE2MTkzMDM0WhcNMzUxMTE2MTkzMjE0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCOMrjK6aGfm+k0RlacFRbTZmlbYDmeEklc9/lc09uYadxlzilfpXBeHS1GQBZct0Wf6FMcyYPFIFPxR8UVKhwAujfVEuduVirSo/I7oOHscBxpQ14nXiMjWXwEmrNi2SMa5RA5Bj4PzlP12jBvCNObkhQh++t9FanJ7PoBBRWMrQtHE7BqDsqzyDvEiEfxutU1/MUYAQ4uiHt2J3OTmdykdiqY+aahhh+02wwg1h/tg/HQejIx5j06j7Cyek5wgWIhmqumE9jJSNOoJALfOqUPoXB1wQ9PWZQBpCAV1fNI+6KdIIDDd/R3GWVDeZjppLGhUqUWGJTQZvkHbqyDG3wDAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAG7j9aAeVuaSA+i3jjsP8otJASz69Sj/xXa31CJ8okqf40ApqEpUv2QTVLfy9RByF1X7h0Z54fiWAdk7F/1//aXKI1rqNg1dkuwfxg4unQiGHChtBhX39l2zvD7TlZHg3jyaDroNRihcnjEPfVFFOwMWf3tXSFWhec4zvK1/PerHZqsja6EQ2/SOWZgTwIpTC6vOc4qNHq8UQUPbhYGC6d96cVJZAa1jDT7v3LEhoDZNjzlENzs4tDt153fsis+U+e+brl70BgbnEYfwZ81XcI1pC5HmVRzIWWFZk7F2E4/yQkmRC6z9qm1Mr6a0UM7qu1owz4j+1eq4JWGO1LfNsTM=
c90b835c-faa1-41eb-8104-ba85883e0d8d	3811f2b9-e579-4d4b-956c-48e58fdb3239	keyUse	ENC
9b166227-0a0e-4399-b772-b4104bbe1740	cb3c8952-7991-459e-aef7-60afc8aca88e	priority	100
552e9b8c-a096-4bc0-b177-8bfb020386cb	cb3c8952-7991-459e-aef7-60afc8aca88e	privateKey	MIIEpQIBAAKCAQEAjUslfkmgZlu3MYJpLp8f37jVHv5eG+Xp8Jcc4EAv+PieT2r2V4PkCYcuMrTyOmfIr17xB74stWiizhQZLnD81G9b7jMX7ffPBmaS/DXdVpBeKotqEuVJ1K0w0bVBD+blNn+9uXbn8Ovu0NVQ5DOfFCeDiovT+iAy57qbxl2AYZURJfx8xxhARRDMQTlWQiSuuEF3KJ5/ZqrI2C16L5WNag/HPbdTbXSLE7kka5JP1VJAd8EpCJ36wKVk4IjAjly2ylShlDgePQfz/0fQkZwzvTse8h7THWqdL/MypsKjV1XAsPvQQvFDCOs3UJNSKdKv4hoP4sRyJ6gW+/+zq6vNqQIDAQABAoIBAAxKrUhUlLpS4EJTsLLNml2WxsjwzV8VRp9s21Dm70V0MNGCjKEFvaDWkb5M34W/4ZrgDOKPjh7PVi/Mr87Ket7q5nnNGBfWUbxM0ByrfZs6PqGU30rQMkwThQZkA5+j2+znJVTXyKBnkK8PilSlPlbn2RmvGxHMxfZC1apmwp8P0lYqz3DPstde41Z97803uE9lloLLFzGoQgLvTlzqLg3v77Xz+0DH6Jp4YJrPnCBGuY8NdF1wxsWREOvJKBL3siUDWQKFTImmzXmWmXX91xmeQaseFFArlbPlSrbTCvOKvY60JepVwS8svGKMeoJv5pZ+8MWZ0HqCthL/HXjfVsECgYEAxXtlCEEdFXczgiZiPvzTyFU4WYkhGTg/GMcikqhEB78dUVPr+eURUG3rlmIGpx0DPfZfNkgy9gnWqSzJhOSMAW7a0UfzNAowrMjlF6wsWfVo9oZx6a//oC8MIr5F5BnlVOUGNKqst7/ZEszHOSHYOtigt3mryAY9MTfTfmgvOicCgYEAtylnEZOrf0Lj/jBV+Fs/427dRAq0B7v5xZiG5RBk5/ercRlIx/T3wwrRXj0F9ZjPKrerExIWiJ6/WtsMK8rfkN2BFjNwirHaT5OZL5cKNDUFYMFrUig2wh2gAAmivncjBVsW7VMDm5aD2ox/1kQZLw/uXMG0xP9Ey2g4Znn9q68CgYEAw7jlTEYEhjbK1Q4nxxea6m0T2SFgrXciifMrH8EnE6playpKsTRHcbhPio8C2vOVN/8LJGhwIYtktezOmShOXkk5E7xEnOoQjd7ZtxmMJ2hjrBlZouss5dxbIcAE0uqbcQU/nkkdv0uj388XEFerz77NoqozB56vXS1gLmMhk3cCgYEAkLd4xS188icixuLf+kP2vbcJwkoGppnCJnp2EqSaZaGNZuYIWFzYKdXxSNlETSF4hhLqaz3+aeGr5ZhvDGbVr7sj1Cu+fwc5K2i+PxjCqi8+WY1ZQ2ecpFEN6xmx6XVuSTwIaGkPz63j7hjWpK/XihS3S7iNIJ1keKaW8XjvkecCgYEAnOJriFzlTSpiAXlwiRUs4PKLzg5xVI3UKCPx+pxTz2YhkPPNVTF5lsfwdWrabyLpcxoEd4o8x6D0s0Tgjf1wCFOfyp3DwTenh69exGc/caJTqSvrfXajdvuLHmTXdzRtFVM8P8yZu4sUTJ46riSvc1JAVUgn6EGG3r8migKjWT8=
445d6381-705c-4b2b-9aba-54a356ab9218	cb3c8952-7991-459e-aef7-60afc8aca88e	keyUse	SIG
796f76b1-e582-4ac2-b059-9a95124f1948	cb3c8952-7991-459e-aef7-60afc8aca88e	certificate	MIICnTCCAYUCBgGajkIoDzANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAd0ZXN0cG9jMB4XDTI1MTExNjE5NTk1MVoXDTM1MTExNjIwMDEzMVowEjEQMA4GA1UEAwwHdGVzdHBvYzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAI1LJX5JoGZbtzGCaS6fH9+41R7+Xhvl6fCXHOBAL/j4nk9q9leD5AmHLjK08jpnyK9e8Qe+LLVoos4UGS5w/NRvW+4zF+33zwZmkvw13VaQXiqLahLlSdStMNG1QQ/m5TZ/vbl25/Dr7tDVUOQznxQng4qL0/ogMue6m8ZdgGGVESX8fMcYQEUQzEE5VkIkrrhBdyief2aqyNgtei+VjWoPxz23U210ixO5JGuST9VSQHfBKQid+sClZOCIwI5ctspUoZQ4Hj0H8/9H0JGcM707HvIe0x1qnS/zMqbCo1dVwLD70ELxQwjrN1CTUinSr+IaD+LEcieoFvv/s6urzakCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAQG4CtsPUFxs20nQ+sPYNbMePVdeJD4a96z2I5GSCKNj0am5HEhv7jHve/s80pjiMV+GuoJyt0w7mbUqeS+i91RfCD/zjgIoYUVsaK4xcgUH9iVwN2PLEdxLvjmUkaCCjoDOCnSu3Wf+lQWchyjyLrsrgdt50sDs1FIA+o34blJLM0kfVbUDeDcR9PKBWXxOXnCA2A9BJ1Ec3yqR50jcWEXK+SS9j90xJ7ZvPeA10/OnyyrJ8FCBdqg5Y/kmmb/4Wgp/6aYH+1/HcNh9KHeuHE5fbXLHgLBDtXSgMpiLHv8p3TIyiGNxSIYZd5iurzDLFXPVtdftPfp8zEkZcz5OkPg==
c6684c29-5def-43a2-95e2-8e58d1fe9c99	e8f60675-644b-4310-b214-7289001d53d8	secret	H1EgxUs6s8uEdviqr5KfqS03EBffGVgw-prou8YmVUAL8BV_qcayzu695bO0FLc0pqYDqmzpfLR8OPnWqDrszmfGmCxPWFkn92HHhBYP3fiA5EbqzK_9uC8XaY7r1l2PggvxQkCgkW8AKc2EGUthjK7ztoxD71KDmFuuB0qTCHw
f8c6d4e1-903f-4128-90a2-102598176de2	e8f60675-644b-4310-b214-7289001d53d8	algorithm	HS512
72707dae-43a6-4225-a119-7c26a4f9f535	e8f60675-644b-4310-b214-7289001d53d8	priority	100
22157436-904b-4085-baa5-13bb1df169c1	e8f60675-644b-4310-b214-7289001d53d8	kid	cc880ae1-322d-4426-810d-b6385b332683
89523348-47af-41f8-b36a-4a88d1e96f77	1bc00851-c22b-4c25-b521-6beb59c5a802	kid	073742b8-2943-4e89-98ae-5f9958d57a2f
2b677c95-2701-4554-ac9a-b5f3e4cd20e7	1bc00851-c22b-4c25-b521-6beb59c5a802	secret	KHac8yvU2hXbyL1WMhX8IA
a5c424e7-abaa-4824-837a-98042edab067	1bc00851-c22b-4c25-b521-6beb59c5a802	priority	100
f7fdd15a-bcf7-442c-a9cc-1a686ae4f630	76028a0f-c871-4cdf-a113-166486fd342b	keyUse	ENC
156f21d3-cf4f-49b5-931b-7d742735ecb5	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	pagination	false
6f7256db-9b90-40d5-ac0a-80b8b874215f	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	enabled	true
4ec6c9c5-5510-40ff-b785-d063985e4e4a	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	changedSyncPeriod	-1
2265b2e3-7de1-4ae7-8ad5-7142ee890315	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	authType	simple
91f4f970-84a5-4d5a-ba91-d93c8ca70f7e	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	bindDn	cn=admin,dc=neurospin,dc=com
f2bfa0aa-daf1-47bd-b2a9-41e2a80da834	76028a0f-c871-4cdf-a113-166486fd342b	privateKey	MIIEogIBAAKCAQEA9DwLaTFWTljYgKfe8gpiWsqX+N9r2bTERXRbkDvA9ZOXJuOL5PWj8n7hhnI5kWXMmhAatz75FLKzrAM1CIv4FP3gvtZwR6Hj9ktVHHR3zi12bcVk0YubUbUhqpJRPZEvtyj4Rh6sV/CY35NbyjJloIfd7qgo7/rPQNTfUOcAS+uEYh3SPNuzQzLSxpeU3471DtqXUWsJRR/97VQH9oPfkZ6ymkSLkMqJXKWrwDtK3GI77mTsGHGcLxYWQVhP+U8h3/e2MOKcJlMxpAappbkvX1oKD2DQWPTIPiqeGQhhr6bLQvqBIkvfxZMy95zw7zHcVXgi3SdKexDYe+omN6w4TQIDAQABAoIBACnh1BkdZ033KWVipDZAdp5YKJh6g82pFJFOg1coEA5s2VpHYhmI0C0I+haqptmaqevvgA1VhLQ6cto4EJOfIRNEeBJxxn5aMjPttjIzfMoD/M+VLpVKif+IfrX38muK5rJTmcO4hdhsv2JzrCVv4AKX2gSPnLmOepUFDCic/G2IJ34wydLOjAGz9nj0RO7xY0d7VrhExKK4oX3SVOdRvQ1lV8NvVwp0RM+q79ERoUFGmXoqyIsRBfkTpe2FhTBTEQS4eHYzUQvmxAGCn9Z8JC9OtwRTHGCSwU5UmA0X7TKdX29W1B8+CxLDsOJHU612HwaW7dxiMTyXl+xNOwP2QQcCgYEA/cjc/LV+GGBsHa2A1X2hftGlIT4OfQXipKAFKdr2WgdYXlQ0mlWTEV2wmPjXID7WidNogXmfkC8B3XsXqneYiEKGvJvsjc4OqkwJTOFGVyCyC1VejN4FXJCWd3OrjppXUifnaEPesrOLSKIwo3HetE7kQ2NPSRZUqR90WwGvXocCgYEA9l3W8kMZtJ7INPI2FRsZ0Y/8BRE+TLp9aNOsUAtAVqWWxN/iq3+jI2WSAi8yF1i+2eqwXVIrDeZqdl1SrrxULR/OC4zs3tt6ZDCOenrZxFwoOJtSpUES74I1x+p2dJtoai5IVQmcg8J7Ly70yHoyg7p/UPEOPTc0PZPa0nYpM4sCgYABtS1PggUkMtnnZTh9t0ez68M5swoz6ys4Ql9mhbOsrWn50IU+GJ9RuZirntkLvYCCEuscG+5n8PkJPX/ORNnA6PmxITd5SM6udK6HVui7Q1wPWXa2afQNSGfKy/t2jTFTOzOCbxp7h1vDlFvRbb265uEAVxW8fyr4rF6DEkLU1wKBgBVpkoT70AAizMPNSWYMNPJB0WWfWgrRKpUx0IgkcjMVsUTrMIg3T7aD3WzTLUdaLzxBaZKy0Ysju50N/2GwfKBvYzkdxniYGssabUe35bVrTROebFBwl3S5nHMDrcf0ud6Ap0i8zR2miY5QRnYmKL3KN8aRLOulIKU5dItWOb6BAoGABuwpE8Q0LKU0zRd4qhOwiNCoi2yLusT2ItwDqxDhWOhbYjNvt07imBYr179d+ydh+13xXHDGIaP56TmX8gJcEtjBRrSXU+ES/2xwBQOITDRU1h1jT2XTsa9cbdS9gEDQYwwZOhUaizt4YnF3l/GGzhcmfjJwgI7junMqVjMuoPQ=
2684b61c-87f7-4767-bc2b-b5151c841e76	76028a0f-c871-4cdf-a113-166486fd342b	certificate	MIICnTCCAYUCBgGajkIoTDANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAd0ZXN0cG9jMB4XDTI1MTExNjE5NTk1MVoXDTM1MTExNjIwMDEzMVowEjEQMA4GA1UEAwwHdGVzdHBvYzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAPQ8C2kxVk5Y2ICn3vIKYlrKl/jfa9m0xEV0W5A7wPWTlybji+T1o/J+4YZyOZFlzJoQGrc++RSys6wDNQiL+BT94L7WcEeh4/ZLVRx0d84tdm3FZNGLm1G1IaqSUT2RL7co+EYerFfwmN+TW8oyZaCH3e6oKO/6z0DU31DnAEvrhGId0jzbs0My0saXlN+O9Q7al1FrCUUf/e1UB/aD35GesppEi5DKiVylq8A7StxiO+5k7BhxnC8WFkFYT/lPId/3tjDinCZTMaQGqaW5L19aCg9g0Fj0yD4qnhkIYa+my0L6gSJL38WTMvec8O8x3FV4It0nSnsQ2HvqJjesOE0CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAOHT6sTTTKnCbbNny2SAGAHINXKBIue9izDX+51eh6fDajuUM9g0gmdwoBQKmFlE9Y6MU3B64bTpBJX1aB9W2T+GqGXe3mzJ+Zy5vChK1F1mOMYOA7wrZbgE9JHWYuUbiZpC6w5A9/WE2TFhsWAISZpmR+qH0zjoBNMaJy82ebV3zLaeJtdAE26D4jWEhI/vgFY7ZnL2b5iBOREhh201IBe5CpqRX77JQD3YKWkY0z51N3OJNKfLZ810zGqJHlHQFLQCklWGDxrp2cnl7mAUKAMnwHnW45TLOPogpG3XDMdoD++F4FKtcv2KG3xTqzz1S7syY6UPPHoLjedmCjqm8gw==
5ef66b56-e2e0-4482-b880-c74fa65c607e	76028a0f-c871-4cdf-a113-166486fd342b	algorithm	RSA-OAEP
4ada29dd-fa6d-4de6-a187-3a64bf48f181	76028a0f-c871-4cdf-a113-166486fd342b	priority	100
b4155be9-16cd-4248-8239-f79e6e580604	e8ad3c83-54aa-48a3-a156-14c9f80d5663	allow-default-scopes	true
d5b1906b-67a8-48cd-9d91-0a3cf9b1dc47	71db47f6-bcd7-4f68-8006-54502922e2ae	host-sending-registration-request-must-match	true
33ff0c4e-b26e-428b-9bc0-b610cb7e6f4a	71db47f6-bcd7-4f68-8006-54502922e2ae	client-uris-must-match	true
10f8603d-fa3d-440c-b255-6c641f1acf48	dd236552-4003-47e1-ac9b-a23b6eafaeb7	max-clients	200
fe2edba5-0a67-443c-8b0e-b7016c2e783d	622f23da-8d01-49b0-9d46-a2ec52511b5e	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
01022deb-018c-43f3-9b12-e546217e208b	622f23da-8d01-49b0-9d46-a2ec52511b5e	allowed-protocol-mapper-types	saml-user-attribute-mapper
11fc3f07-a2b9-4fc3-9fc9-1f746c2c1e3b	622f23da-8d01-49b0-9d46-a2ec52511b5e	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
b390fdfb-a26f-4fd2-af1f-5cf74a618a96	622f23da-8d01-49b0-9d46-a2ec52511b5e	allowed-protocol-mapper-types	oidc-full-name-mapper
c88c84f6-b507-4e44-9417-777c371676bb	622f23da-8d01-49b0-9d46-a2ec52511b5e	allowed-protocol-mapper-types	saml-role-list-mapper
b80adaae-dc6c-43db-ae83-3cc3e5235169	622f23da-8d01-49b0-9d46-a2ec52511b5e	allowed-protocol-mapper-types	oidc-address-mapper
21eb6853-7976-4356-90de-eb87e1154be2	622f23da-8d01-49b0-9d46-a2ec52511b5e	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
459957bd-d214-4854-8a3c-18294fb6d6f3	622f23da-8d01-49b0-9d46-a2ec52511b5e	allowed-protocol-mapper-types	saml-user-property-mapper
7682d8e5-fdcf-4932-9b39-6c5ab561f56a	400cc5b8-9792-4bab-8b19-16bae2872fdb	allowed-protocol-mapper-types	oidc-address-mapper
f787c3f6-3ff2-4051-8412-b00b6de0f5dc	400cc5b8-9792-4bab-8b19-16bae2872fdb	allowed-protocol-mapper-types	oidc-full-name-mapper
0ed925dd-dda6-4fe2-8abb-048cb12ac762	400cc5b8-9792-4bab-8b19-16bae2872fdb	allowed-protocol-mapper-types	saml-role-list-mapper
cddda80f-4658-409d-b77d-ab3163fedf9e	400cc5b8-9792-4bab-8b19-16bae2872fdb	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
f304b2b8-48dd-4fae-8a0f-89d63ac95e4e	400cc5b8-9792-4bab-8b19-16bae2872fdb	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
0d3c5ac7-718f-4939-aa4b-f2a91eb773a3	400cc5b8-9792-4bab-8b19-16bae2872fdb	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
55b12052-b900-4f73-bad9-9da958065a44	400cc5b8-9792-4bab-8b19-16bae2872fdb	allowed-protocol-mapper-types	saml-user-property-mapper
e9685165-05a9-4d05-bd81-cef84cd59ea9	400cc5b8-9792-4bab-8b19-16bae2872fdb	allowed-protocol-mapper-types	saml-user-attribute-mapper
5cff9253-fa56-49ed-97ac-2018752fb90e	03b7a09c-e092-473b-9d52-02191f62b72c	allow-default-scopes	true
07f17d24-eedb-4e5f-b3a1-2793431044c1	300ca35b-6110-4114-8e7f-2cdffff6f3a3	user.model.attribute	username
b6f2e1cc-c669-4b04-b310-84e4f132511d	300ca35b-6110-4114-8e7f-2cdffff6f3a3	is.mandatory.in.ldap	true
946cb354-98b8-479e-b030-0c238dc84845	300ca35b-6110-4114-8e7f-2cdffff6f3a3	read.only	true
76c6f77d-e791-4732-b515-1be07e493b0c	300ca35b-6110-4114-8e7f-2cdffff6f3a3	ldap.attribute	uid
ebae0509-dc8a-4fa5-b1f0-8a5117a7c053	300ca35b-6110-4114-8e7f-2cdffff6f3a3	always.read.value.from.ldap	false
f67b57a0-f03c-4951-8dc6-0ed14ae99773	74fd6bca-a1ed-458c-84c5-f64802e99269	always.read.value.from.ldap	true
ea6f2ea9-b5b0-4afe-bdb0-c9c7f50cec03	74fd6bca-a1ed-458c-84c5-f64802e99269	ldap.attribute	modifyTimestamp
c05f320e-a479-40a3-ba3b-7f9d538f16d5	74fd6bca-a1ed-458c-84c5-f64802e99269	read.only	true
d8f20d24-ae5f-442e-8997-876698844cc4	74fd6bca-a1ed-458c-84c5-f64802e99269	user.model.attribute	modifyTimestamp
80609871-e757-4350-8f30-0ceeb3f441ef	74fd6bca-a1ed-458c-84c5-f64802e99269	is.mandatory.in.ldap	false
bf97e4b5-66a7-480e-8ddd-c567b2120ff4	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	useKerberosForPasswordAuthentication	false
295f4a9d-5555-4d23-9d19-a02b30d188dc	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	trustEmail	false
9765db75-5892-414e-ab83-d634d3ba5fdd	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	krbPrincipalAttribute	krb5PrincipalName
8e4ad542-26b5-453a-8443-392538eb681d	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	lastSync	1763401348
07342057-fbf0-463d-ac76-42bf0f322fbe	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	editMode	WRITABLE
771f5a7a-9029-4ee5-8189-c0cd3966ddce	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	usersDn	ou=Users,dc=neurospin,dc=com
f534216f-3675-42cc-9e86-e647d8c34a32	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	cachePolicy	DEFAULT
4158f462-d4a8-4c02-a97c-ccdc26d5c29b	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	fullSyncPeriod	-1
4bfb6dc1-8642-4912-bdab-4de29d9f2c4e	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	connectionPooling	false
746352fb-cf54-41b3-86c8-d9f470d4f7c9	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	usernameLDAPAttribute	uid
c2461fad-8e70-4cd8-965c-2a0fe034e9f6	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	bindCredential	admin_pass
acd6ef06-3bbc-430c-bf8d-450a41f1c46f	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	uuidLDAPAttribute	entryUUID
6d92049b-0d57-4eca-b490-861faa5ff1ca	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	rdnLDAPAttribute	uid
5053e5ad-9923-4484-bfa3-ff3e6c4136fd	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	syncRegistrations	true
efb005eb-1a78-41b7-8b04-7ca65c8aaaa3	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	useTruststoreSpi	always
f2debcda-d0a6-4b1a-aafd-e7f3b9ad9d76	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	connectionUrl	ldap://host.docker.internal:389
d3543542-6b69-49c9-87ac-4d7eae2ecf7c	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	vendor	other
cc80c60e-8e4e-47c8-83e4-a4113eea6277	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	userObjectClasses	inetOrgPerson, organizationalPerson
7339f235-0ca1-43b8-86f1-30159efdd4e4	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	importEnabled	true
bfef5f43-b1c2-404b-a150-2a6e783f8596	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	validatePasswordPolicy	false
b389c00f-4c16-4956-9698-411e3aa92cc5	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	allowKerberosAuthentication	false
795c88fd-71a8-432c-a125-7af04fa28039	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	startTls	false
d9f60ea6-6000-4d23-9f13-e699a3b726de	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	usePasswordModifyExtendedOp	false
771dde69-8cf4-46fc-a96a-bffd39c87a07	74b6581f-47ae-470b-bf21-6e2f6be38e2b	read.only	true
f4154175-cf39-4e4c-8ef5-8ecf73be708e	74b6581f-47ae-470b-bf21-6e2f6be38e2b	user.model.attribute	createTimestamp
e51b62b5-ec01-472a-9af4-f0660bb563c1	74b6581f-47ae-470b-bf21-6e2f6be38e2b	ldap.attribute	createTimestamp
3592a142-2caa-4a0e-a9d6-7555ac120737	74b6581f-47ae-470b-bf21-6e2f6be38e2b	is.mandatory.in.ldap	false
a6f95db9-fc5a-4e3d-88ec-8b929c505c3d	74b6581f-47ae-470b-bf21-6e2f6be38e2b	always.read.value.from.ldap	true
6c031ae6-939b-48c3-83e2-4baccc92fcbb	088dad8d-87a2-4894-8b9f-0b4e5285782b	is.mandatory.in.ldap	true
6f391e85-da4e-4006-8bb2-4890014e913c	088dad8d-87a2-4894-8b9f-0b4e5285782b	ldap.attribute	sn
454e95c7-ab21-43af-ac27-6d4bae0d7566	088dad8d-87a2-4894-8b9f-0b4e5285782b	user.model.attribute	lastName
177155b7-6932-4d3f-b4be-12cdd1080046	088dad8d-87a2-4894-8b9f-0b4e5285782b	read.only	true
d29c719c-bbfa-448d-9745-487a33589ab6	088dad8d-87a2-4894-8b9f-0b4e5285782b	always.read.value.from.ldap	true
d44d7012-88bd-4f94-a721-5ba4179de987	75db323d-3221-4e89-a7ea-b778f03361fc	read.only	true
ab1bf7d9-631e-4cbb-a444-acac2065c87c	75db323d-3221-4e89-a7ea-b778f03361fc	ldap.attribute	cn
29e17e65-301e-46bf-82b1-7f11abcf3455	75db323d-3221-4e89-a7ea-b778f03361fc	is.mandatory.in.ldap	true
996c46fd-6c59-405c-9bf9-a8a04ab14997	75db323d-3221-4e89-a7ea-b778f03361fc	user.model.attribute	firstName
763c67c5-59cc-4776-b771-e86d1f0eed19	75db323d-3221-4e89-a7ea-b778f03361fc	always.read.value.from.ldap	true
873b39a0-96d0-4168-b396-269165f263b3	ca1c3e71-5b4e-4fd5-88c2-2e229c1bede6	ldap.attribute	mail
882d1f94-723d-4337-aaeb-58ce92c05f5e	ca1c3e71-5b4e-4fd5-88c2-2e229c1bede6	always.read.value.from.ldap	false
078df0d9-1f00-49c7-8db1-76608276c2e4	ca1c3e71-5b4e-4fd5-88c2-2e229c1bede6	user.model.attribute	email
e6412801-7d92-4dad-a839-fc9b09692f04	ca1c3e71-5b4e-4fd5-88c2-2e229c1bede6	read.only	true
be5de539-a712-4f1a-8b6f-9af790cdc62b	ca1c3e71-5b4e-4fd5-88c2-2e229c1bede6	is.mandatory.in.ldap	false
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.composite_role (composite, child_role) FROM stdin;
98b40455-6485-43da-bc3e-887552b2a0a1	a10d19d6-c154-4d13-a15b-275d305bad3b
98b40455-6485-43da-bc3e-887552b2a0a1	ed0ffb3c-0f89-4f3e-91e6-f0d98320e1c7
98b40455-6485-43da-bc3e-887552b2a0a1	7a59c853-2454-4e61-afa6-15884e39bd86
98b40455-6485-43da-bc3e-887552b2a0a1	41133eb5-16cb-4dba-8848-3b0d2f6c42eb
98b40455-6485-43da-bc3e-887552b2a0a1	7c8678fa-835d-4c13-8798-eebe484dffd0
98b40455-6485-43da-bc3e-887552b2a0a1	dc34924d-cc03-42f6-9b51-5260e3396c19
98b40455-6485-43da-bc3e-887552b2a0a1	b9ba8bae-d86b-45b2-b90a-883db0c44048
98b40455-6485-43da-bc3e-887552b2a0a1	d63db6e1-b455-412d-a38b-d633788cdce5
98b40455-6485-43da-bc3e-887552b2a0a1	d732ce37-adee-4627-89b8-baef16d32972
98b40455-6485-43da-bc3e-887552b2a0a1	bc547b33-62ba-47b1-aca7-632675d8e242
98b40455-6485-43da-bc3e-887552b2a0a1	9e12209a-4f8d-49f7-a970-4ece3411fb9f
98b40455-6485-43da-bc3e-887552b2a0a1	aa3dae7a-f42f-4c35-ae87-a8162a93682f
98b40455-6485-43da-bc3e-887552b2a0a1	65f2fdcb-6d09-431d-834b-67a3d3f8f8d0
98b40455-6485-43da-bc3e-887552b2a0a1	d9173df8-8f61-45fd-b3d5-cc656c89b17b
98b40455-6485-43da-bc3e-887552b2a0a1	e8d0e267-d829-42ee-bc08-8d38f2012341
98b40455-6485-43da-bc3e-887552b2a0a1	b3703d9a-d0c4-4208-86dd-8daf41f1ac5d
98b40455-6485-43da-bc3e-887552b2a0a1	626fc94c-8259-4950-b8de-b6add30ca4da
98b40455-6485-43da-bc3e-887552b2a0a1	0e43ad13-9672-4bad-b333-fff511a55a67
41133eb5-16cb-4dba-8848-3b0d2f6c42eb	e8d0e267-d829-42ee-bc08-8d38f2012341
41133eb5-16cb-4dba-8848-3b0d2f6c42eb	0e43ad13-9672-4bad-b333-fff511a55a67
7c8678fa-835d-4c13-8798-eebe484dffd0	b3703d9a-d0c4-4208-86dd-8daf41f1ac5d
95daf9e3-ac47-44e0-9caf-b4b403b7f65f	3d6828a2-a18c-46c9-a5c9-5bf19054eb6b
95daf9e3-ac47-44e0-9caf-b4b403b7f65f	bea538db-5505-44ce-b93c-839c2bed7f87
bea538db-5505-44ce-b93c-839c2bed7f87	229783f3-c5a8-4b69-b1b3-8d79cf078a94
abe8506e-f9c4-42e7-ab41-1b509308fddc	ca43b4e2-7647-4afa-bb90-46b4cf1a1123
98b40455-6485-43da-bc3e-887552b2a0a1	f09fe4a4-d007-4839-bfa6-cf9fb365be65
95daf9e3-ac47-44e0-9caf-b4b403b7f65f	9e58e758-0643-418c-9cbc-d916c807e8de
95daf9e3-ac47-44e0-9caf-b4b403b7f65f	6009291a-c0d8-42d8-b0fc-7306311e9b7f
98b40455-6485-43da-bc3e-887552b2a0a1	daebb2ea-7de0-4b4a-9918-aed9faa8abde
98b40455-6485-43da-bc3e-887552b2a0a1	84cf233b-26d3-4c7e-ac15-656901d718f5
98b40455-6485-43da-bc3e-887552b2a0a1	b07de108-91d7-4022-ab55-fe9ff0900cbc
98b40455-6485-43da-bc3e-887552b2a0a1	07732a43-4705-4192-bb7b-3f83b974d060
98b40455-6485-43da-bc3e-887552b2a0a1	a9bff680-8495-4616-abc7-9e14330e8867
98b40455-6485-43da-bc3e-887552b2a0a1	44933f23-875f-4ebe-9c58-2c771ae3767a
98b40455-6485-43da-bc3e-887552b2a0a1	7f34db25-d388-4353-bee8-7d1938c35f1b
98b40455-6485-43da-bc3e-887552b2a0a1	84165bf0-42a5-4775-8214-dc3706f6b4fc
98b40455-6485-43da-bc3e-887552b2a0a1	e8cf2f10-dddb-4126-bdc9-5fd31b90a5fc
98b40455-6485-43da-bc3e-887552b2a0a1	309fadff-0fbf-4c27-ae72-1993b84b03d3
98b40455-6485-43da-bc3e-887552b2a0a1	e3a1f4a0-9c14-4033-8f4d-1c10ed8aa1d4
98b40455-6485-43da-bc3e-887552b2a0a1	7ded0720-b1f7-4511-999c-aa1d55f46a59
98b40455-6485-43da-bc3e-887552b2a0a1	b2273292-4751-4dbd-9788-d080d371b1d9
98b40455-6485-43da-bc3e-887552b2a0a1	e6d9a5d1-3ac1-4940-a999-666eb413d6bb
98b40455-6485-43da-bc3e-887552b2a0a1	4090fc41-137c-4b1d-b63e-cce9a0cd1da0
98b40455-6485-43da-bc3e-887552b2a0a1	de8b271d-18f7-4d91-b47d-e23ee342adcd
98b40455-6485-43da-bc3e-887552b2a0a1	4a741732-5d81-4e00-a0a7-5da821fa3d6c
07732a43-4705-4192-bb7b-3f83b974d060	4090fc41-137c-4b1d-b63e-cce9a0cd1da0
b07de108-91d7-4022-ab55-fe9ff0900cbc	e6d9a5d1-3ac1-4940-a999-666eb413d6bb
b07de108-91d7-4022-ab55-fe9ff0900cbc	4a741732-5d81-4e00-a0a7-5da821fa3d6c
993a1a78-40a2-40a3-99bb-4be5e37fa885	4dca539c-a18b-4634-be0b-946a00251c26
993a1a78-40a2-40a3-99bb-4be5e37fa885	ce1c1184-ec6c-4891-a8a2-fbd17ed5558f
993a1a78-40a2-40a3-99bb-4be5e37fa885	ed2d8e98-f3e5-41ce-b049-649dc096e561
993a1a78-40a2-40a3-99bb-4be5e37fa885	d9cfee49-e578-49f7-b486-3405c7aec65b
993a1a78-40a2-40a3-99bb-4be5e37fa885	0ea193eb-4de3-4406-b5a7-94709f7ea205
993a1a78-40a2-40a3-99bb-4be5e37fa885	a051ecd2-bfeb-462d-ad8a-66fe07da52a1
993a1a78-40a2-40a3-99bb-4be5e37fa885	4ece81ea-fabd-4091-832d-f5ee27eab67a
993a1a78-40a2-40a3-99bb-4be5e37fa885	2853f16c-0ea0-4b03-b160-f91785709c38
993a1a78-40a2-40a3-99bb-4be5e37fa885	030a43f8-6192-41d7-87da-dfe71d56fd09
993a1a78-40a2-40a3-99bb-4be5e37fa885	58a65fdd-5fd1-482c-9c6e-b761fc908c2f
993a1a78-40a2-40a3-99bb-4be5e37fa885	5e4141e0-279c-4847-94ea-35e45160f34c
993a1a78-40a2-40a3-99bb-4be5e37fa885	6b83cbc6-3d46-46a7-89ec-581bc46a121c
993a1a78-40a2-40a3-99bb-4be5e37fa885	9de126ae-41dd-42f2-8955-8da103db4abe
993a1a78-40a2-40a3-99bb-4be5e37fa885	bf683066-a5f9-4a16-8585-d079590964c6
993a1a78-40a2-40a3-99bb-4be5e37fa885	8dc0b80e-32ed-47fd-b88f-39d4b9e00a71
993a1a78-40a2-40a3-99bb-4be5e37fa885	6fbec0d5-d369-4701-8b55-0c7416238a88
993a1a78-40a2-40a3-99bb-4be5e37fa885	ff50d86b-a5b2-441f-a48b-d1bdff69eb10
8765100e-889a-4b65-ba3f-b0a43d8dca76	e7999c5f-a784-432d-8119-81d31bb582cd
d9cfee49-e578-49f7-b486-3405c7aec65b	8dc0b80e-32ed-47fd-b88f-39d4b9e00a71
ed2d8e98-f3e5-41ce-b049-649dc096e561	ff50d86b-a5b2-441f-a48b-d1bdff69eb10
ed2d8e98-f3e5-41ce-b049-649dc096e561	bf683066-a5f9-4a16-8585-d079590964c6
8765100e-889a-4b65-ba3f-b0a43d8dca76	5e8af63e-5655-46d3-805c-64f952756c05
5e8af63e-5655-46d3-805c-64f952756c05	5aff77fd-bf7d-45f1-b8fd-8dc53db50f0d
25dbed35-19a3-431d-bdeb-f9f1059a4f55	c7257217-eb72-40a8-b880-4e01646c6559
98b40455-6485-43da-bc3e-887552b2a0a1	8bae74d9-7c2e-4cd8-9977-c1626fb4efa5
993a1a78-40a2-40a3-99bb-4be5e37fa885	31659f91-7ed6-48b3-a38a-440a70b06e03
8765100e-889a-4b65-ba3f-b0a43d8dca76	561e8369-fe98-4aa2-a65b-c4b935e33c2a
8765100e-889a-4b65-ba3f-b0a43d8dca76	5ce635cb-6c24-4956-9344-994dcc7b2965
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
6c3023a4-439e-4aa1-9701-e1cbc63d5a00	\N	password	30dfe41c-6e58-43ed-baf9-862a080b3786	1763321535455	\N	{"value":"IjNEqMN34/k1zQyyH72gwY/iFJN+beFP3XkkinrWppBO+gNG7leJ14WxRuABXa9LsksH9sahVJk6UQ8XIb4djg==","salt":"7qgLi6DEsClOpWerqkkpKQ==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2025-11-16 19:32:12.378556	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.25.1	\N	\N	3321532081
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2025-11-16 19:32:12.390232	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.25.1	\N	\N	3321532081
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2025-11-16 19:32:12.422823	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.25.1	\N	\N	3321532081
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2025-11-16 19:32:12.429055	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	3321532081
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2025-11-16 19:32:12.482682	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.25.1	\N	\N	3321532081
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2025-11-16 19:32:12.487675	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.25.1	\N	\N	3321532081
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2025-11-16 19:32:12.547015	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.25.1	\N	\N	3321532081
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2025-11-16 19:32:12.55311	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.25.1	\N	\N	3321532081
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2025-11-16 19:32:12.560475	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.25.1	\N	\N	3321532081
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2025-11-16 19:32:12.622224	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.25.1	\N	\N	3321532081
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2025-11-16 19:32:12.659397	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	3321532081
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2025-11-16 19:32:12.664511	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	3321532081
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2025-11-16 19:32:12.724069	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	3321532081
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-11-16 19:32:12.734418	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.25.1	\N	\N	3321532081
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-11-16 19:32:12.736241	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	3321532081
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-11-16 19:32:12.738822	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.25.1	\N	\N	3321532081
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-11-16 19:32:12.741495	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.25.1	\N	\N	3321532081
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2025-11-16 19:32:12.763874	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.25.1	\N	\N	3321532081
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2025-11-16 19:32:12.787616	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.25.1	\N	\N	3321532081
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2025-11-16 19:32:12.792012	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.25.1	\N	\N	3321532081
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-11-16 19:32:13.368305	119	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.25.1	\N	\N	3321532081
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2025-11-16 19:32:12.79492	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.25.1	\N	\N	3321532081
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2025-11-16 19:32:12.79847	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.25.1	\N	\N	3321532081
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2025-11-16 19:32:12.816562	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.25.1	\N	\N	3321532081
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2025-11-16 19:32:12.82242	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.25.1	\N	\N	3321532081
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2025-11-16 19:32:12.824204	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.25.1	\N	\N	3321532081
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2025-11-16 19:32:12.833918	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.25.1	\N	\N	3321532081
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2025-11-16 19:32:12.859086	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.25.1	\N	\N	3321532081
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2025-11-16 19:32:12.862154	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.25.1	\N	\N	3321532081
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2025-11-16 19:32:12.881983	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.25.1	\N	\N	3321532081
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2025-11-16 19:32:12.890768	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.25.1	\N	\N	3321532081
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2025-11-16 19:32:12.902996	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.25.1	\N	\N	3321532081
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2025-11-16 19:32:12.907933	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.25.1	\N	\N	3321532081
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-11-16 19:32:12.914404	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	3321532081
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-11-16 19:32:12.916146	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.25.1	\N	\N	3321532081
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-11-16 19:32:12.929866	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.25.1	\N	\N	3321532081
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2025-11-16 19:32:12.934604	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.25.1	\N	\N	3321532081
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-11-16 19:32:12.937889	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	3321532081
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2025-11-16 19:32:12.941196	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.25.1	\N	\N	3321532081
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2025-11-16 19:32:12.944315	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.25.1	\N	\N	3321532081
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-11-16 19:32:12.945605	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.25.1	\N	\N	3321532081
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-11-16 19:32:12.947262	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.25.1	\N	\N	3321532081
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2025-11-16 19:32:12.951692	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.25.1	\N	\N	3321532081
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-11-16 19:32:12.979521	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.25.1	\N	\N	3321532081
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2025-11-16 19:32:12.983695	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.25.1	\N	\N	3321532081
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-11-16 19:32:12.987417	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.25.1	\N	\N	3321532081
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-11-16 19:32:12.991503	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.25.1	\N	\N	3321532081
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-11-16 19:32:12.993361	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.25.1	\N	\N	3321532081
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-11-16 19:32:13.010132	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.25.1	\N	\N	3321532081
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-11-16 19:32:13.017299	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.25.1	\N	\N	3321532081
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2025-11-16 19:32:13.043813	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.25.1	\N	\N	3321532081
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2025-11-16 19:32:13.054038	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.25.1	\N	\N	3321532081
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2025-11-16 19:32:13.057231	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3321532081
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2025-11-16 19:32:13.059171	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.25.1	\N	\N	3321532081
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2025-11-16 19:32:13.061174	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.25.1	\N	\N	3321532081
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-11-16 19:32:13.064835	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.25.1	\N	\N	3321532081
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-11-16 19:32:13.068066	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.25.1	\N	\N	3321532081
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-11-16 19:32:13.07711	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.25.1	\N	\N	3321532081
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-11-16 19:32:13.125002	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.25.1	\N	\N	3321532081
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2025-11-16 19:32:13.13703	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.25.1	\N	\N	3321532081
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2025-11-16 19:32:13.14167	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.25.1	\N	\N	3321532081
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-11-16 19:32:13.149704	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.25.1	\N	\N	3321532081
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-11-16 19:32:13.152716	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.25.1	\N	\N	3321532081
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2025-11-16 19:32:13.155419	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.25.1	\N	\N	3321532081
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2025-11-16 19:32:13.157342	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.25.1	\N	\N	3321532081
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2025-11-16 19:32:13.159298	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.25.1	\N	\N	3321532081
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2025-11-16 19:32:13.164973	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.25.1	\N	\N	3321532081
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2025-11-16 19:32:13.167695	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.25.1	\N	\N	3321532081
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2025-11-16 19:32:13.170879	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.25.1	\N	\N	3321532081
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2025-11-16 19:32:13.177566	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.25.1	\N	\N	3321532081
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2025-11-16 19:32:13.181118	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.25.1	\N	\N	3321532081
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2025-11-16 19:32:13.183939	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.25.1	\N	\N	3321532081
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-11-16 19:32:13.188028	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	3321532081
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-11-16 19:32:13.191652	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	3321532081
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-11-16 19:32:13.193292	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	3321532081
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-11-16 19:32:13.205049	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.25.1	\N	\N	3321532081
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-11-16 19:32:13.210069	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.25.1	\N	\N	3321532081
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-11-16 19:32:13.213408	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.25.1	\N	\N	3321532081
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-11-16 19:32:13.214763	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.25.1	\N	\N	3321532081
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-11-16 19:32:13.224432	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.25.1	\N	\N	3321532081
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-11-16 19:32:13.226187	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.25.1	\N	\N	3321532081
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-11-16 19:32:13.230227	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.25.1	\N	\N	3321532081
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-11-16 19:32:13.231773	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	3321532081
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-11-16 19:32:13.235003	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	3321532081
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-11-16 19:32:13.236139	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	3321532081
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-11-16 19:32:13.239336	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	3321532081
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2025-11-16 19:32:13.242769	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.25.1	\N	\N	3321532081
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-11-16 19:32:13.249793	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.25.1	\N	\N	3321532081
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-11-16 19:32:13.253698	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.25.1	\N	\N	3321532081
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-11-16 19:32:13.258561	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.25.1	\N	\N	3321532081
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-11-16 19:32:13.263746	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.25.1	\N	\N	3321532081
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-11-16 19:32:13.268138	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	3321532081
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-11-16 19:32:13.273234	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.25.1	\N	\N	3321532081
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-11-16 19:32:13.274478	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.25.1	\N	\N	3321532081
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-11-16 19:32:13.27873	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.25.1	\N	\N	3321532081
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-11-16 19:32:13.279988	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.25.1	\N	\N	3321532081
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-11-16 19:32:13.283683	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.25.1	\N	\N	3321532081
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-11-16 19:32:13.287321	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	3321532081
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-11-16 19:32:13.288674	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3321532081
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-11-16 19:32:13.295371	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3321532081
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-11-16 19:32:13.299714	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3321532081
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-11-16 19:32:13.301249	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3321532081
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-11-16 19:32:13.304577	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.25.1	\N	\N	3321532081
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-11-16 19:32:13.308743	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.25.1	\N	\N	3321532081
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2025-11-16 19:32:13.313961	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.25.1	\N	\N	3321532081
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2025-11-16 19:32:13.318693	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.25.1	\N	\N	3321532081
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2025-11-16 19:32:13.321884	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.25.1	\N	\N	3321532081
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2025-11-16 19:32:13.325718	107	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.25.1	\N	\N	3321532081
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-11-16 19:32:13.329845	108	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.25.1	\N	\N	3321532081
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-11-16 19:32:13.33122	109	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.25.1	\N	\N	3321532081
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-11-16 19:32:13.335319	110	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3321532081
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2025-11-16 19:32:13.339058	111	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.25.1	\N	\N	3321532081
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-11-16 19:32:13.346624	112	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.25.1	\N	\N	3321532081
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-11-16 19:32:13.348246	113	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.25.1	\N	\N	3321532081
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-11-16 19:32:13.352219	114	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.25.1	\N	\N	3321532081
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-11-16 19:32:13.353411	115	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.25.1	\N	\N	3321532081
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-11-16 19:32:13.35704	116	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.25.1	\N	\N	3321532081
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-11-16 19:32:13.359351	117	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	3321532081
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-11-16 19:32:13.36442	118	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.25.1	\N	\N	3321532081
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-11-16 19:32:13.371485	120	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3321532081
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-11-16 19:32:13.374982	121	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3321532081
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-11-16 19:32:13.378239	122	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.25.1	\N	\N	3321532081
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-11-16 19:32:13.379669	123	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3321532081
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-11-16 19:32:13.381077	124	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3321532081
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
466b29ba-5081-488d-9245-7ea9c707034a	aa62a70e-b1cf-411b-b6d9-0e290636ce40	f
466b29ba-5081-488d-9245-7ea9c707034a	30576962-4def-4979-99fc-82c7164f9453	t
466b29ba-5081-488d-9245-7ea9c707034a	52ab5f00-2616-471c-85a5-0be64918687e	t
466b29ba-5081-488d-9245-7ea9c707034a	9b74be15-d556-46cb-b042-fe268583e0d5	t
466b29ba-5081-488d-9245-7ea9c707034a	1b108be6-8769-4ec5-a136-abe1cfc2125c	f
466b29ba-5081-488d-9245-7ea9c707034a	ab64eea5-00c7-45eb-bc69-d9da3bd438f4	f
466b29ba-5081-488d-9245-7ea9c707034a	7ec16d10-bd47-40bb-aeae-8f2554ce252a	t
466b29ba-5081-488d-9245-7ea9c707034a	99063f26-c3cf-4609-b6cf-d38edb6fece6	t
466b29ba-5081-488d-9245-7ea9c707034a	f6481506-05eb-4981-b743-2d894b1841e0	f
466b29ba-5081-488d-9245-7ea9c707034a	c7ba7c33-6a71-4299-b6e2-39464593dfd6	t
55e0b680-0bdb-451b-acf8-9c5eacce36dc	ec152344-f8a1-4227-9389-b0b0293d0f37	f
55e0b680-0bdb-451b-acf8-9c5eacce36dc	b884ab95-e32a-4485-b03f-396591124a77	t
55e0b680-0bdb-451b-acf8-9c5eacce36dc	9a67f87a-34f6-4678-a507-305205a0010d	t
55e0b680-0bdb-451b-acf8-9c5eacce36dc	1952b72c-142b-43a5-9926-7ed41f18138b	t
55e0b680-0bdb-451b-acf8-9c5eacce36dc	c1d35745-4206-4261-b433-70f8f64664f5	f
55e0b680-0bdb-451b-acf8-9c5eacce36dc	035adf6d-f934-4ce9-bd10-0dc03f0b90c2	f
55e0b680-0bdb-451b-acf8-9c5eacce36dc	bf6ff1b7-7cb1-4962-b438-61026318323e	t
55e0b680-0bdb-451b-acf8-9c5eacce36dc	2d45929b-e6d9-404d-84d5-703c0f02b665	t
55e0b680-0bdb-451b-acf8-9c5eacce36dc	5fb1d6f6-84ac-48a0-ba6e-5d67eb5552c1	f
55e0b680-0bdb-451b-acf8-9c5eacce36dc	dff8996b-1b63-4ccc-b74c-2324a18a5ca5	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
95daf9e3-ac47-44e0-9caf-b4b403b7f65f	466b29ba-5081-488d-9245-7ea9c707034a	f	${role_default-roles}	default-roles-master	466b29ba-5081-488d-9245-7ea9c707034a	\N	\N
98b40455-6485-43da-bc3e-887552b2a0a1	466b29ba-5081-488d-9245-7ea9c707034a	f	${role_admin}	admin	466b29ba-5081-488d-9245-7ea9c707034a	\N	\N
a10d19d6-c154-4d13-a15b-275d305bad3b	466b29ba-5081-488d-9245-7ea9c707034a	f	${role_create-realm}	create-realm	466b29ba-5081-488d-9245-7ea9c707034a	\N	\N
ed0ffb3c-0f89-4f3e-91e6-f0d98320e1c7	9fad4d62-b215-4051-aff5-be0788d82f32	t	${role_create-client}	create-client	466b29ba-5081-488d-9245-7ea9c707034a	9fad4d62-b215-4051-aff5-be0788d82f32	\N
7a59c853-2454-4e61-afa6-15884e39bd86	9fad4d62-b215-4051-aff5-be0788d82f32	t	${role_view-realm}	view-realm	466b29ba-5081-488d-9245-7ea9c707034a	9fad4d62-b215-4051-aff5-be0788d82f32	\N
41133eb5-16cb-4dba-8848-3b0d2f6c42eb	9fad4d62-b215-4051-aff5-be0788d82f32	t	${role_view-users}	view-users	466b29ba-5081-488d-9245-7ea9c707034a	9fad4d62-b215-4051-aff5-be0788d82f32	\N
7c8678fa-835d-4c13-8798-eebe484dffd0	9fad4d62-b215-4051-aff5-be0788d82f32	t	${role_view-clients}	view-clients	466b29ba-5081-488d-9245-7ea9c707034a	9fad4d62-b215-4051-aff5-be0788d82f32	\N
dc34924d-cc03-42f6-9b51-5260e3396c19	9fad4d62-b215-4051-aff5-be0788d82f32	t	${role_view-events}	view-events	466b29ba-5081-488d-9245-7ea9c707034a	9fad4d62-b215-4051-aff5-be0788d82f32	\N
b9ba8bae-d86b-45b2-b90a-883db0c44048	9fad4d62-b215-4051-aff5-be0788d82f32	t	${role_view-identity-providers}	view-identity-providers	466b29ba-5081-488d-9245-7ea9c707034a	9fad4d62-b215-4051-aff5-be0788d82f32	\N
d63db6e1-b455-412d-a38b-d633788cdce5	9fad4d62-b215-4051-aff5-be0788d82f32	t	${role_view-authorization}	view-authorization	466b29ba-5081-488d-9245-7ea9c707034a	9fad4d62-b215-4051-aff5-be0788d82f32	\N
d732ce37-adee-4627-89b8-baef16d32972	9fad4d62-b215-4051-aff5-be0788d82f32	t	${role_manage-realm}	manage-realm	466b29ba-5081-488d-9245-7ea9c707034a	9fad4d62-b215-4051-aff5-be0788d82f32	\N
bc547b33-62ba-47b1-aca7-632675d8e242	9fad4d62-b215-4051-aff5-be0788d82f32	t	${role_manage-users}	manage-users	466b29ba-5081-488d-9245-7ea9c707034a	9fad4d62-b215-4051-aff5-be0788d82f32	\N
9e12209a-4f8d-49f7-a970-4ece3411fb9f	9fad4d62-b215-4051-aff5-be0788d82f32	t	${role_manage-clients}	manage-clients	466b29ba-5081-488d-9245-7ea9c707034a	9fad4d62-b215-4051-aff5-be0788d82f32	\N
aa3dae7a-f42f-4c35-ae87-a8162a93682f	9fad4d62-b215-4051-aff5-be0788d82f32	t	${role_manage-events}	manage-events	466b29ba-5081-488d-9245-7ea9c707034a	9fad4d62-b215-4051-aff5-be0788d82f32	\N
65f2fdcb-6d09-431d-834b-67a3d3f8f8d0	9fad4d62-b215-4051-aff5-be0788d82f32	t	${role_manage-identity-providers}	manage-identity-providers	466b29ba-5081-488d-9245-7ea9c707034a	9fad4d62-b215-4051-aff5-be0788d82f32	\N
d9173df8-8f61-45fd-b3d5-cc656c89b17b	9fad4d62-b215-4051-aff5-be0788d82f32	t	${role_manage-authorization}	manage-authorization	466b29ba-5081-488d-9245-7ea9c707034a	9fad4d62-b215-4051-aff5-be0788d82f32	\N
e8d0e267-d829-42ee-bc08-8d38f2012341	9fad4d62-b215-4051-aff5-be0788d82f32	t	${role_query-users}	query-users	466b29ba-5081-488d-9245-7ea9c707034a	9fad4d62-b215-4051-aff5-be0788d82f32	\N
b3703d9a-d0c4-4208-86dd-8daf41f1ac5d	9fad4d62-b215-4051-aff5-be0788d82f32	t	${role_query-clients}	query-clients	466b29ba-5081-488d-9245-7ea9c707034a	9fad4d62-b215-4051-aff5-be0788d82f32	\N
626fc94c-8259-4950-b8de-b6add30ca4da	9fad4d62-b215-4051-aff5-be0788d82f32	t	${role_query-realms}	query-realms	466b29ba-5081-488d-9245-7ea9c707034a	9fad4d62-b215-4051-aff5-be0788d82f32	\N
0e43ad13-9672-4bad-b333-fff511a55a67	9fad4d62-b215-4051-aff5-be0788d82f32	t	${role_query-groups}	query-groups	466b29ba-5081-488d-9245-7ea9c707034a	9fad4d62-b215-4051-aff5-be0788d82f32	\N
3d6828a2-a18c-46c9-a5c9-5bf19054eb6b	e3f22e78-f51f-49d9-9bb8-2e460002128d	t	${role_view-profile}	view-profile	466b29ba-5081-488d-9245-7ea9c707034a	e3f22e78-f51f-49d9-9bb8-2e460002128d	\N
bea538db-5505-44ce-b93c-839c2bed7f87	e3f22e78-f51f-49d9-9bb8-2e460002128d	t	${role_manage-account}	manage-account	466b29ba-5081-488d-9245-7ea9c707034a	e3f22e78-f51f-49d9-9bb8-2e460002128d	\N
229783f3-c5a8-4b69-b1b3-8d79cf078a94	e3f22e78-f51f-49d9-9bb8-2e460002128d	t	${role_manage-account-links}	manage-account-links	466b29ba-5081-488d-9245-7ea9c707034a	e3f22e78-f51f-49d9-9bb8-2e460002128d	\N
de2b7b33-95cb-4c1c-84bf-d1a0171dc17b	e3f22e78-f51f-49d9-9bb8-2e460002128d	t	${role_view-applications}	view-applications	466b29ba-5081-488d-9245-7ea9c707034a	e3f22e78-f51f-49d9-9bb8-2e460002128d	\N
ca43b4e2-7647-4afa-bb90-46b4cf1a1123	e3f22e78-f51f-49d9-9bb8-2e460002128d	t	${role_view-consent}	view-consent	466b29ba-5081-488d-9245-7ea9c707034a	e3f22e78-f51f-49d9-9bb8-2e460002128d	\N
abe8506e-f9c4-42e7-ab41-1b509308fddc	e3f22e78-f51f-49d9-9bb8-2e460002128d	t	${role_manage-consent}	manage-consent	466b29ba-5081-488d-9245-7ea9c707034a	e3f22e78-f51f-49d9-9bb8-2e460002128d	\N
82e2d139-d201-40c0-88a0-8f4a734dd4e2	e3f22e78-f51f-49d9-9bb8-2e460002128d	t	${role_view-groups}	view-groups	466b29ba-5081-488d-9245-7ea9c707034a	e3f22e78-f51f-49d9-9bb8-2e460002128d	\N
8e159666-dbeb-4b59-9946-22f8baefee68	e3f22e78-f51f-49d9-9bb8-2e460002128d	t	${role_delete-account}	delete-account	466b29ba-5081-488d-9245-7ea9c707034a	e3f22e78-f51f-49d9-9bb8-2e460002128d	\N
96bfd497-90f1-4a25-b54f-f2c47b9189c8	792c71e0-b797-4be7-85c7-559baaed8447	t	${role_read-token}	read-token	466b29ba-5081-488d-9245-7ea9c707034a	792c71e0-b797-4be7-85c7-559baaed8447	\N
f09fe4a4-d007-4839-bfa6-cf9fb365be65	9fad4d62-b215-4051-aff5-be0788d82f32	t	${role_impersonation}	impersonation	466b29ba-5081-488d-9245-7ea9c707034a	9fad4d62-b215-4051-aff5-be0788d82f32	\N
9e58e758-0643-418c-9cbc-d916c807e8de	466b29ba-5081-488d-9245-7ea9c707034a	f	${role_offline-access}	offline_access	466b29ba-5081-488d-9245-7ea9c707034a	\N	\N
6009291a-c0d8-42d8-b0fc-7306311e9b7f	466b29ba-5081-488d-9245-7ea9c707034a	f	${role_uma_authorization}	uma_authorization	466b29ba-5081-488d-9245-7ea9c707034a	\N	\N
8765100e-889a-4b65-ba3f-b0a43d8dca76	55e0b680-0bdb-451b-acf8-9c5eacce36dc	f	${role_default-roles}	default-roles-testpoc	55e0b680-0bdb-451b-acf8-9c5eacce36dc	\N	\N
daebb2ea-7de0-4b4a-9918-aed9faa8abde	03dead48-43e4-4bfb-9178-fb382f9d15d4	t	${role_create-client}	create-client	466b29ba-5081-488d-9245-7ea9c707034a	03dead48-43e4-4bfb-9178-fb382f9d15d4	\N
84cf233b-26d3-4c7e-ac15-656901d718f5	03dead48-43e4-4bfb-9178-fb382f9d15d4	t	${role_view-realm}	view-realm	466b29ba-5081-488d-9245-7ea9c707034a	03dead48-43e4-4bfb-9178-fb382f9d15d4	\N
b07de108-91d7-4022-ab55-fe9ff0900cbc	03dead48-43e4-4bfb-9178-fb382f9d15d4	t	${role_view-users}	view-users	466b29ba-5081-488d-9245-7ea9c707034a	03dead48-43e4-4bfb-9178-fb382f9d15d4	\N
07732a43-4705-4192-bb7b-3f83b974d060	03dead48-43e4-4bfb-9178-fb382f9d15d4	t	${role_view-clients}	view-clients	466b29ba-5081-488d-9245-7ea9c707034a	03dead48-43e4-4bfb-9178-fb382f9d15d4	\N
a9bff680-8495-4616-abc7-9e14330e8867	03dead48-43e4-4bfb-9178-fb382f9d15d4	t	${role_view-events}	view-events	466b29ba-5081-488d-9245-7ea9c707034a	03dead48-43e4-4bfb-9178-fb382f9d15d4	\N
44933f23-875f-4ebe-9c58-2c771ae3767a	03dead48-43e4-4bfb-9178-fb382f9d15d4	t	${role_view-identity-providers}	view-identity-providers	466b29ba-5081-488d-9245-7ea9c707034a	03dead48-43e4-4bfb-9178-fb382f9d15d4	\N
7f34db25-d388-4353-bee8-7d1938c35f1b	03dead48-43e4-4bfb-9178-fb382f9d15d4	t	${role_view-authorization}	view-authorization	466b29ba-5081-488d-9245-7ea9c707034a	03dead48-43e4-4bfb-9178-fb382f9d15d4	\N
84165bf0-42a5-4775-8214-dc3706f6b4fc	03dead48-43e4-4bfb-9178-fb382f9d15d4	t	${role_manage-realm}	manage-realm	466b29ba-5081-488d-9245-7ea9c707034a	03dead48-43e4-4bfb-9178-fb382f9d15d4	\N
e8cf2f10-dddb-4126-bdc9-5fd31b90a5fc	03dead48-43e4-4bfb-9178-fb382f9d15d4	t	${role_manage-users}	manage-users	466b29ba-5081-488d-9245-7ea9c707034a	03dead48-43e4-4bfb-9178-fb382f9d15d4	\N
309fadff-0fbf-4c27-ae72-1993b84b03d3	03dead48-43e4-4bfb-9178-fb382f9d15d4	t	${role_manage-clients}	manage-clients	466b29ba-5081-488d-9245-7ea9c707034a	03dead48-43e4-4bfb-9178-fb382f9d15d4	\N
e3a1f4a0-9c14-4033-8f4d-1c10ed8aa1d4	03dead48-43e4-4bfb-9178-fb382f9d15d4	t	${role_manage-events}	manage-events	466b29ba-5081-488d-9245-7ea9c707034a	03dead48-43e4-4bfb-9178-fb382f9d15d4	\N
7ded0720-b1f7-4511-999c-aa1d55f46a59	03dead48-43e4-4bfb-9178-fb382f9d15d4	t	${role_manage-identity-providers}	manage-identity-providers	466b29ba-5081-488d-9245-7ea9c707034a	03dead48-43e4-4bfb-9178-fb382f9d15d4	\N
b2273292-4751-4dbd-9788-d080d371b1d9	03dead48-43e4-4bfb-9178-fb382f9d15d4	t	${role_manage-authorization}	manage-authorization	466b29ba-5081-488d-9245-7ea9c707034a	03dead48-43e4-4bfb-9178-fb382f9d15d4	\N
e6d9a5d1-3ac1-4940-a999-666eb413d6bb	03dead48-43e4-4bfb-9178-fb382f9d15d4	t	${role_query-users}	query-users	466b29ba-5081-488d-9245-7ea9c707034a	03dead48-43e4-4bfb-9178-fb382f9d15d4	\N
4090fc41-137c-4b1d-b63e-cce9a0cd1da0	03dead48-43e4-4bfb-9178-fb382f9d15d4	t	${role_query-clients}	query-clients	466b29ba-5081-488d-9245-7ea9c707034a	03dead48-43e4-4bfb-9178-fb382f9d15d4	\N
de8b271d-18f7-4d91-b47d-e23ee342adcd	03dead48-43e4-4bfb-9178-fb382f9d15d4	t	${role_query-realms}	query-realms	466b29ba-5081-488d-9245-7ea9c707034a	03dead48-43e4-4bfb-9178-fb382f9d15d4	\N
4a741732-5d81-4e00-a0a7-5da821fa3d6c	03dead48-43e4-4bfb-9178-fb382f9d15d4	t	${role_query-groups}	query-groups	466b29ba-5081-488d-9245-7ea9c707034a	03dead48-43e4-4bfb-9178-fb382f9d15d4	\N
993a1a78-40a2-40a3-99bb-4be5e37fa885	493a3508-9d80-4057-9e08-b35f2471cedd	t	${role_realm-admin}	realm-admin	55e0b680-0bdb-451b-acf8-9c5eacce36dc	493a3508-9d80-4057-9e08-b35f2471cedd	\N
4dca539c-a18b-4634-be0b-946a00251c26	493a3508-9d80-4057-9e08-b35f2471cedd	t	${role_create-client}	create-client	55e0b680-0bdb-451b-acf8-9c5eacce36dc	493a3508-9d80-4057-9e08-b35f2471cedd	\N
ce1c1184-ec6c-4891-a8a2-fbd17ed5558f	493a3508-9d80-4057-9e08-b35f2471cedd	t	${role_view-realm}	view-realm	55e0b680-0bdb-451b-acf8-9c5eacce36dc	493a3508-9d80-4057-9e08-b35f2471cedd	\N
ed2d8e98-f3e5-41ce-b049-649dc096e561	493a3508-9d80-4057-9e08-b35f2471cedd	t	${role_view-users}	view-users	55e0b680-0bdb-451b-acf8-9c5eacce36dc	493a3508-9d80-4057-9e08-b35f2471cedd	\N
d9cfee49-e578-49f7-b486-3405c7aec65b	493a3508-9d80-4057-9e08-b35f2471cedd	t	${role_view-clients}	view-clients	55e0b680-0bdb-451b-acf8-9c5eacce36dc	493a3508-9d80-4057-9e08-b35f2471cedd	\N
0ea193eb-4de3-4406-b5a7-94709f7ea205	493a3508-9d80-4057-9e08-b35f2471cedd	t	${role_view-events}	view-events	55e0b680-0bdb-451b-acf8-9c5eacce36dc	493a3508-9d80-4057-9e08-b35f2471cedd	\N
a051ecd2-bfeb-462d-ad8a-66fe07da52a1	493a3508-9d80-4057-9e08-b35f2471cedd	t	${role_view-identity-providers}	view-identity-providers	55e0b680-0bdb-451b-acf8-9c5eacce36dc	493a3508-9d80-4057-9e08-b35f2471cedd	\N
4ece81ea-fabd-4091-832d-f5ee27eab67a	493a3508-9d80-4057-9e08-b35f2471cedd	t	${role_view-authorization}	view-authorization	55e0b680-0bdb-451b-acf8-9c5eacce36dc	493a3508-9d80-4057-9e08-b35f2471cedd	\N
2853f16c-0ea0-4b03-b160-f91785709c38	493a3508-9d80-4057-9e08-b35f2471cedd	t	${role_manage-realm}	manage-realm	55e0b680-0bdb-451b-acf8-9c5eacce36dc	493a3508-9d80-4057-9e08-b35f2471cedd	\N
030a43f8-6192-41d7-87da-dfe71d56fd09	493a3508-9d80-4057-9e08-b35f2471cedd	t	${role_manage-users}	manage-users	55e0b680-0bdb-451b-acf8-9c5eacce36dc	493a3508-9d80-4057-9e08-b35f2471cedd	\N
58a65fdd-5fd1-482c-9c6e-b761fc908c2f	493a3508-9d80-4057-9e08-b35f2471cedd	t	${role_manage-clients}	manage-clients	55e0b680-0bdb-451b-acf8-9c5eacce36dc	493a3508-9d80-4057-9e08-b35f2471cedd	\N
5e4141e0-279c-4847-94ea-35e45160f34c	493a3508-9d80-4057-9e08-b35f2471cedd	t	${role_manage-events}	manage-events	55e0b680-0bdb-451b-acf8-9c5eacce36dc	493a3508-9d80-4057-9e08-b35f2471cedd	\N
6b83cbc6-3d46-46a7-89ec-581bc46a121c	493a3508-9d80-4057-9e08-b35f2471cedd	t	${role_manage-identity-providers}	manage-identity-providers	55e0b680-0bdb-451b-acf8-9c5eacce36dc	493a3508-9d80-4057-9e08-b35f2471cedd	\N
9de126ae-41dd-42f2-8955-8da103db4abe	493a3508-9d80-4057-9e08-b35f2471cedd	t	${role_manage-authorization}	manage-authorization	55e0b680-0bdb-451b-acf8-9c5eacce36dc	493a3508-9d80-4057-9e08-b35f2471cedd	\N
bf683066-a5f9-4a16-8585-d079590964c6	493a3508-9d80-4057-9e08-b35f2471cedd	t	${role_query-users}	query-users	55e0b680-0bdb-451b-acf8-9c5eacce36dc	493a3508-9d80-4057-9e08-b35f2471cedd	\N
8dc0b80e-32ed-47fd-b88f-39d4b9e00a71	493a3508-9d80-4057-9e08-b35f2471cedd	t	${role_query-clients}	query-clients	55e0b680-0bdb-451b-acf8-9c5eacce36dc	493a3508-9d80-4057-9e08-b35f2471cedd	\N
6fbec0d5-d369-4701-8b55-0c7416238a88	493a3508-9d80-4057-9e08-b35f2471cedd	t	${role_query-realms}	query-realms	55e0b680-0bdb-451b-acf8-9c5eacce36dc	493a3508-9d80-4057-9e08-b35f2471cedd	\N
ff50d86b-a5b2-441f-a48b-d1bdff69eb10	493a3508-9d80-4057-9e08-b35f2471cedd	t	${role_query-groups}	query-groups	55e0b680-0bdb-451b-acf8-9c5eacce36dc	493a3508-9d80-4057-9e08-b35f2471cedd	\N
e7999c5f-a784-432d-8119-81d31bb582cd	33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	t	${role_view-profile}	view-profile	55e0b680-0bdb-451b-acf8-9c5eacce36dc	33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	\N
5e8af63e-5655-46d3-805c-64f952756c05	33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	t	${role_manage-account}	manage-account	55e0b680-0bdb-451b-acf8-9c5eacce36dc	33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	\N
5aff77fd-bf7d-45f1-b8fd-8dc53db50f0d	33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	t	${role_manage-account-links}	manage-account-links	55e0b680-0bdb-451b-acf8-9c5eacce36dc	33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	\N
391489dc-1db7-47f9-ae4a-93359e5173ff	33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	t	${role_view-applications}	view-applications	55e0b680-0bdb-451b-acf8-9c5eacce36dc	33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	\N
c7257217-eb72-40a8-b880-4e01646c6559	33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	t	${role_view-consent}	view-consent	55e0b680-0bdb-451b-acf8-9c5eacce36dc	33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	\N
25dbed35-19a3-431d-bdeb-f9f1059a4f55	33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	t	${role_manage-consent}	manage-consent	55e0b680-0bdb-451b-acf8-9c5eacce36dc	33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	\N
1593b9fd-75d6-45e8-b079-b1d3418862fa	33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	t	${role_view-groups}	view-groups	55e0b680-0bdb-451b-acf8-9c5eacce36dc	33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	\N
144f3b5b-d6c3-4bd4-a7ee-d1825caf0789	33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	t	${role_delete-account}	delete-account	55e0b680-0bdb-451b-acf8-9c5eacce36dc	33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	\N
8bae74d9-7c2e-4cd8-9977-c1626fb4efa5	03dead48-43e4-4bfb-9178-fb382f9d15d4	t	${role_impersonation}	impersonation	466b29ba-5081-488d-9245-7ea9c707034a	03dead48-43e4-4bfb-9178-fb382f9d15d4	\N
31659f91-7ed6-48b3-a38a-440a70b06e03	493a3508-9d80-4057-9e08-b35f2471cedd	t	${role_impersonation}	impersonation	55e0b680-0bdb-451b-acf8-9c5eacce36dc	493a3508-9d80-4057-9e08-b35f2471cedd	\N
5c56ece8-2cc3-4746-b986-2d414dd26d70	7a567829-1faf-4225-9bd4-b6c464d5d5d4	t	${role_read-token}	read-token	55e0b680-0bdb-451b-acf8-9c5eacce36dc	7a567829-1faf-4225-9bd4-b6c464d5d5d4	\N
561e8369-fe98-4aa2-a65b-c4b935e33c2a	55e0b680-0bdb-451b-acf8-9c5eacce36dc	f	${role_offline-access}	offline_access	55e0b680-0bdb-451b-acf8-9c5eacce36dc	\N	\N
5ce635cb-6c24-4956-9344-994dcc7b2965	55e0b680-0bdb-451b-acf8-9c5eacce36dc	f	${role_uma_authorization}	uma_authorization	55e0b680-0bdb-451b-acf8-9c5eacce36dc	\N	\N
1847c470-7288-4229-b1bd-8c7ec8068c51	94e3a758-71cb-4427-be5f-c9ac760664ea	t		admin	55e0b680-0bdb-451b-acf8-9c5eacce36dc	94e3a758-71cb-4427-be5f-c9ac760664ea	\N
61d0ccf2-2dd0-456a-9cf8-eeb65150bed6	94e3a758-71cb-4427-be5f-c9ac760664ea	t		user	55e0b680-0bdb-451b-acf8-9c5eacce36dc	94e3a758-71cb-4427-be5f-c9ac760664ea	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.migration_model (id, version, update_time) FROM stdin;
zdvoc	24.0.5	1763321533
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
36674f27-5847-4b62-8a28-ec94585175c8	audience resolve	openid-connect	oidc-audience-resolve-mapper	5b617b10-fd84-467d-afbc-991dd9aaff9a	\N
02b127f2-182f-438a-a3cf-850113ae726b	locale	openid-connect	oidc-usermodel-attribute-mapper	b844a64d-75aa-4b17-bfc2-dc5902d551a5	\N
054cf915-9334-419c-a6cd-d72d58614a9e	role list	saml	saml-role-list-mapper	\N	30576962-4def-4979-99fc-82c7164f9453
4fff4319-d832-4351-bf21-85c5dcf00513	full name	openid-connect	oidc-full-name-mapper	\N	52ab5f00-2616-471c-85a5-0be64918687e
4939a165-46ff-44ff-92e3-82dceb435087	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	52ab5f00-2616-471c-85a5-0be64918687e
09927e0e-c640-4f43-9c87-dccaf0df2438	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	52ab5f00-2616-471c-85a5-0be64918687e
51572fb4-039f-4f1d-b46f-27b545b04538	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	52ab5f00-2616-471c-85a5-0be64918687e
58aeb8f0-a468-40f2-b52c-1b105dfd76c3	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	52ab5f00-2616-471c-85a5-0be64918687e
1552c76a-210a-44e7-a93f-bc86ef983c50	username	openid-connect	oidc-usermodel-attribute-mapper	\N	52ab5f00-2616-471c-85a5-0be64918687e
7f0f00a3-edd6-414e-8222-7b99037af1f5	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	52ab5f00-2616-471c-85a5-0be64918687e
1d4ba437-4f6c-429a-93d4-16683bcd0eb5	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	52ab5f00-2616-471c-85a5-0be64918687e
35104f2b-2409-4af5-8188-635030322925	website	openid-connect	oidc-usermodel-attribute-mapper	\N	52ab5f00-2616-471c-85a5-0be64918687e
1d670ef8-1c47-48ea-9398-dd15fd183765	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	52ab5f00-2616-471c-85a5-0be64918687e
11185d69-365e-4638-807a-6011e2d68656	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	52ab5f00-2616-471c-85a5-0be64918687e
dac5b434-6d56-47bb-b2e7-80fa7eba329a	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	52ab5f00-2616-471c-85a5-0be64918687e
151fff80-3d1d-4a21-b66a-5ac7fefd7526	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	52ab5f00-2616-471c-85a5-0be64918687e
0d595449-e39e-4a7c-b795-53379fcf7d9a	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	52ab5f00-2616-471c-85a5-0be64918687e
2a0ac3a4-829b-4730-a247-dd5c02bedb2e	email	openid-connect	oidc-usermodel-attribute-mapper	\N	9b74be15-d556-46cb-b042-fe268583e0d5
e8166bcb-3d87-44e6-a46e-b10cde1e2316	email verified	openid-connect	oidc-usermodel-property-mapper	\N	9b74be15-d556-46cb-b042-fe268583e0d5
4258c2c3-52cb-4c39-8f39-2a3db22268b6	address	openid-connect	oidc-address-mapper	\N	1b108be6-8769-4ec5-a136-abe1cfc2125c
80f0863e-8b7b-4aa3-9b91-daa53aa42170	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	ab64eea5-00c7-45eb-bc69-d9da3bd438f4
1366ab33-9c35-4800-b6f3-7ac526bab74a	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	ab64eea5-00c7-45eb-bc69-d9da3bd438f4
0d3d4ec8-3966-48a0-8425-c5d0e9b66d21	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	7ec16d10-bd47-40bb-aeae-8f2554ce252a
4212a57e-40c7-4320-9f64-e3fc30701208	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	7ec16d10-bd47-40bb-aeae-8f2554ce252a
d05d5e2c-2f56-439e-83e0-9c6a228a686c	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	7ec16d10-bd47-40bb-aeae-8f2554ce252a
b755458c-3167-486e-a616-96a79d6591c2	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	99063f26-c3cf-4609-b6cf-d38edb6fece6
6ae6f327-caaf-4204-8a7c-cf37274a613c	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	f6481506-05eb-4981-b743-2d894b1841e0
cdb10f04-7948-467d-b1a4-d5563a01bbd0	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	f6481506-05eb-4981-b743-2d894b1841e0
84888e72-2562-4bdc-852e-706fa5f4ddc7	acr loa level	openid-connect	oidc-acr-mapper	\N	c7ba7c33-6a71-4299-b6e2-39464593dfd6
ccf76054-5c0a-4593-88a9-78fde2e725f3	audience resolve	openid-connect	oidc-audience-resolve-mapper	7f0a6944-b6cf-463a-a6ab-8eda364e1f8f	\N
803c42be-314f-465d-8ac8-6d3c7a0f9263	role list	saml	saml-role-list-mapper	\N	b884ab95-e32a-4485-b03f-396591124a77
5131aba3-7758-4dbc-b204-51f44d6d0274	full name	openid-connect	oidc-full-name-mapper	\N	9a67f87a-34f6-4678-a507-305205a0010d
5a2a8b99-d6d2-4ab4-9c83-96a645dd1e46	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	9a67f87a-34f6-4678-a507-305205a0010d
951fe120-42b3-43ef-9de4-aba3cad1b5fd	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	9a67f87a-34f6-4678-a507-305205a0010d
1cbb75fc-8d3b-4470-b2fd-fbe73298c572	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	9a67f87a-34f6-4678-a507-305205a0010d
8cfcfabf-b970-4077-8285-a11cbd7f428f	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	9a67f87a-34f6-4678-a507-305205a0010d
abd76451-416b-458e-873f-94dac142f0ce	username	openid-connect	oidc-usermodel-attribute-mapper	\N	9a67f87a-34f6-4678-a507-305205a0010d
45e610c4-1ec8-4d93-9513-3c79072a0cf2	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	9a67f87a-34f6-4678-a507-305205a0010d
316ffdd1-4eaa-4c88-ace6-cb412bdbb25f	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	9a67f87a-34f6-4678-a507-305205a0010d
d76b1a69-02d2-4013-a65c-591d363b659a	website	openid-connect	oidc-usermodel-attribute-mapper	\N	9a67f87a-34f6-4678-a507-305205a0010d
9e296da8-add6-4d2f-bebb-b49f7c274bae	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	9a67f87a-34f6-4678-a507-305205a0010d
b81a6699-9f87-494f-910b-b527aed6f1fb	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	9a67f87a-34f6-4678-a507-305205a0010d
9a0d216d-036d-4c7d-85ad-a5fd1c139fab	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	9a67f87a-34f6-4678-a507-305205a0010d
966bb60a-2584-4635-a7f0-ab0b203cf1f2	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	9a67f87a-34f6-4678-a507-305205a0010d
f00ab0c7-b3b4-4242-8aa9-48c997851b0b	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	9a67f87a-34f6-4678-a507-305205a0010d
7863fccd-e091-484c-a427-4cf2edcd5c21	email	openid-connect	oidc-usermodel-attribute-mapper	\N	1952b72c-142b-43a5-9926-7ed41f18138b
105e3534-a4aa-435d-8dbf-71fc38cdea8c	email verified	openid-connect	oidc-usermodel-property-mapper	\N	1952b72c-142b-43a5-9926-7ed41f18138b
626e2336-e72b-4c28-885a-632ca0949999	address	openid-connect	oidc-address-mapper	\N	c1d35745-4206-4261-b433-70f8f64664f5
7b3497d7-15e7-43b1-b2a5-6febdfc055c3	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	035adf6d-f934-4ce9-bd10-0dc03f0b90c2
c3767d80-a3a7-4634-b4cb-dddb7418a0a0	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	035adf6d-f934-4ce9-bd10-0dc03f0b90c2
a41a5422-20e4-4cf5-b47e-139342be9768	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	bf6ff1b7-7cb1-4962-b438-61026318323e
f2c25b4b-d40a-475c-a259-62c9dd8fb4ea	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	bf6ff1b7-7cb1-4962-b438-61026318323e
880fb8f4-8767-4e8c-81a6-3d1876687713	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	bf6ff1b7-7cb1-4962-b438-61026318323e
8f9bde15-0801-4b25-876b-c2ced8d7cbb1	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	2d45929b-e6d9-404d-84d5-703c0f02b665
114923c0-480b-467a-8394-995f9b3e36c0	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	5fb1d6f6-84ac-48a0-ba6e-5d67eb5552c1
56d15d47-75d9-4561-a408-2dfb4c74f955	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	5fb1d6f6-84ac-48a0-ba6e-5d67eb5552c1
ed2c66e9-1e80-4994-8c53-5788553c1fde	acr loa level	openid-connect	oidc-acr-mapper	\N	dff8996b-1b63-4ccc-b74c-2324a18a5ca5
1b01dabd-3fcf-4cd8-9222-0b263d61cca0	locale	openid-connect	oidc-usermodel-attribute-mapper	6f8b1d7b-a0f0-4c1f-8dc7-f81928b2b49b	\N
c1e5a923-e6b4-4064-9497-9181f199f341	backend-api	openid-connect	oidc-audience-mapper	\N	8ac1b7b9-7453-4205-a1f3-8cbcbf0abf02
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
02b127f2-182f-438a-a3cf-850113ae726b	true	introspection.token.claim
02b127f2-182f-438a-a3cf-850113ae726b	true	userinfo.token.claim
02b127f2-182f-438a-a3cf-850113ae726b	locale	user.attribute
02b127f2-182f-438a-a3cf-850113ae726b	true	id.token.claim
02b127f2-182f-438a-a3cf-850113ae726b	true	access.token.claim
02b127f2-182f-438a-a3cf-850113ae726b	locale	claim.name
02b127f2-182f-438a-a3cf-850113ae726b	String	jsonType.label
054cf915-9334-419c-a6cd-d72d58614a9e	false	single
054cf915-9334-419c-a6cd-d72d58614a9e	Basic	attribute.nameformat
054cf915-9334-419c-a6cd-d72d58614a9e	Role	attribute.name
09927e0e-c640-4f43-9c87-dccaf0df2438	true	introspection.token.claim
09927e0e-c640-4f43-9c87-dccaf0df2438	true	userinfo.token.claim
09927e0e-c640-4f43-9c87-dccaf0df2438	firstName	user.attribute
09927e0e-c640-4f43-9c87-dccaf0df2438	true	id.token.claim
09927e0e-c640-4f43-9c87-dccaf0df2438	true	access.token.claim
09927e0e-c640-4f43-9c87-dccaf0df2438	given_name	claim.name
09927e0e-c640-4f43-9c87-dccaf0df2438	String	jsonType.label
0d595449-e39e-4a7c-b795-53379fcf7d9a	true	introspection.token.claim
0d595449-e39e-4a7c-b795-53379fcf7d9a	true	userinfo.token.claim
0d595449-e39e-4a7c-b795-53379fcf7d9a	updatedAt	user.attribute
0d595449-e39e-4a7c-b795-53379fcf7d9a	true	id.token.claim
0d595449-e39e-4a7c-b795-53379fcf7d9a	true	access.token.claim
0d595449-e39e-4a7c-b795-53379fcf7d9a	updated_at	claim.name
0d595449-e39e-4a7c-b795-53379fcf7d9a	long	jsonType.label
11185d69-365e-4638-807a-6011e2d68656	true	introspection.token.claim
11185d69-365e-4638-807a-6011e2d68656	true	userinfo.token.claim
11185d69-365e-4638-807a-6011e2d68656	birthdate	user.attribute
11185d69-365e-4638-807a-6011e2d68656	true	id.token.claim
11185d69-365e-4638-807a-6011e2d68656	true	access.token.claim
11185d69-365e-4638-807a-6011e2d68656	birthdate	claim.name
11185d69-365e-4638-807a-6011e2d68656	String	jsonType.label
151fff80-3d1d-4a21-b66a-5ac7fefd7526	true	introspection.token.claim
151fff80-3d1d-4a21-b66a-5ac7fefd7526	true	userinfo.token.claim
151fff80-3d1d-4a21-b66a-5ac7fefd7526	locale	user.attribute
151fff80-3d1d-4a21-b66a-5ac7fefd7526	true	id.token.claim
151fff80-3d1d-4a21-b66a-5ac7fefd7526	true	access.token.claim
151fff80-3d1d-4a21-b66a-5ac7fefd7526	locale	claim.name
151fff80-3d1d-4a21-b66a-5ac7fefd7526	String	jsonType.label
1552c76a-210a-44e7-a93f-bc86ef983c50	true	introspection.token.claim
1552c76a-210a-44e7-a93f-bc86ef983c50	true	userinfo.token.claim
1552c76a-210a-44e7-a93f-bc86ef983c50	username	user.attribute
1552c76a-210a-44e7-a93f-bc86ef983c50	true	id.token.claim
1552c76a-210a-44e7-a93f-bc86ef983c50	true	access.token.claim
1552c76a-210a-44e7-a93f-bc86ef983c50	preferred_username	claim.name
1552c76a-210a-44e7-a93f-bc86ef983c50	String	jsonType.label
1d4ba437-4f6c-429a-93d4-16683bcd0eb5	true	introspection.token.claim
1d4ba437-4f6c-429a-93d4-16683bcd0eb5	true	userinfo.token.claim
1d4ba437-4f6c-429a-93d4-16683bcd0eb5	picture	user.attribute
1d4ba437-4f6c-429a-93d4-16683bcd0eb5	true	id.token.claim
1d4ba437-4f6c-429a-93d4-16683bcd0eb5	true	access.token.claim
1d4ba437-4f6c-429a-93d4-16683bcd0eb5	picture	claim.name
1d4ba437-4f6c-429a-93d4-16683bcd0eb5	String	jsonType.label
1d670ef8-1c47-48ea-9398-dd15fd183765	true	introspection.token.claim
1d670ef8-1c47-48ea-9398-dd15fd183765	true	userinfo.token.claim
1d670ef8-1c47-48ea-9398-dd15fd183765	gender	user.attribute
1d670ef8-1c47-48ea-9398-dd15fd183765	true	id.token.claim
1d670ef8-1c47-48ea-9398-dd15fd183765	true	access.token.claim
1d670ef8-1c47-48ea-9398-dd15fd183765	gender	claim.name
1d670ef8-1c47-48ea-9398-dd15fd183765	String	jsonType.label
35104f2b-2409-4af5-8188-635030322925	true	introspection.token.claim
35104f2b-2409-4af5-8188-635030322925	true	userinfo.token.claim
35104f2b-2409-4af5-8188-635030322925	website	user.attribute
35104f2b-2409-4af5-8188-635030322925	true	id.token.claim
35104f2b-2409-4af5-8188-635030322925	true	access.token.claim
35104f2b-2409-4af5-8188-635030322925	website	claim.name
35104f2b-2409-4af5-8188-635030322925	String	jsonType.label
4939a165-46ff-44ff-92e3-82dceb435087	true	introspection.token.claim
4939a165-46ff-44ff-92e3-82dceb435087	true	userinfo.token.claim
4939a165-46ff-44ff-92e3-82dceb435087	lastName	user.attribute
4939a165-46ff-44ff-92e3-82dceb435087	true	id.token.claim
4939a165-46ff-44ff-92e3-82dceb435087	true	access.token.claim
4939a165-46ff-44ff-92e3-82dceb435087	family_name	claim.name
4939a165-46ff-44ff-92e3-82dceb435087	String	jsonType.label
4fff4319-d832-4351-bf21-85c5dcf00513	true	introspection.token.claim
4fff4319-d832-4351-bf21-85c5dcf00513	true	userinfo.token.claim
4fff4319-d832-4351-bf21-85c5dcf00513	true	id.token.claim
4fff4319-d832-4351-bf21-85c5dcf00513	true	access.token.claim
51572fb4-039f-4f1d-b46f-27b545b04538	true	introspection.token.claim
51572fb4-039f-4f1d-b46f-27b545b04538	true	userinfo.token.claim
51572fb4-039f-4f1d-b46f-27b545b04538	middleName	user.attribute
51572fb4-039f-4f1d-b46f-27b545b04538	true	id.token.claim
51572fb4-039f-4f1d-b46f-27b545b04538	true	access.token.claim
51572fb4-039f-4f1d-b46f-27b545b04538	middle_name	claim.name
51572fb4-039f-4f1d-b46f-27b545b04538	String	jsonType.label
58aeb8f0-a468-40f2-b52c-1b105dfd76c3	true	introspection.token.claim
58aeb8f0-a468-40f2-b52c-1b105dfd76c3	true	userinfo.token.claim
58aeb8f0-a468-40f2-b52c-1b105dfd76c3	nickname	user.attribute
58aeb8f0-a468-40f2-b52c-1b105dfd76c3	true	id.token.claim
58aeb8f0-a468-40f2-b52c-1b105dfd76c3	true	access.token.claim
58aeb8f0-a468-40f2-b52c-1b105dfd76c3	nickname	claim.name
58aeb8f0-a468-40f2-b52c-1b105dfd76c3	String	jsonType.label
7f0f00a3-edd6-414e-8222-7b99037af1f5	true	introspection.token.claim
7f0f00a3-edd6-414e-8222-7b99037af1f5	true	userinfo.token.claim
7f0f00a3-edd6-414e-8222-7b99037af1f5	profile	user.attribute
7f0f00a3-edd6-414e-8222-7b99037af1f5	true	id.token.claim
7f0f00a3-edd6-414e-8222-7b99037af1f5	true	access.token.claim
7f0f00a3-edd6-414e-8222-7b99037af1f5	profile	claim.name
7f0f00a3-edd6-414e-8222-7b99037af1f5	String	jsonType.label
dac5b434-6d56-47bb-b2e7-80fa7eba329a	true	introspection.token.claim
dac5b434-6d56-47bb-b2e7-80fa7eba329a	true	userinfo.token.claim
dac5b434-6d56-47bb-b2e7-80fa7eba329a	zoneinfo	user.attribute
dac5b434-6d56-47bb-b2e7-80fa7eba329a	true	id.token.claim
dac5b434-6d56-47bb-b2e7-80fa7eba329a	true	access.token.claim
dac5b434-6d56-47bb-b2e7-80fa7eba329a	zoneinfo	claim.name
dac5b434-6d56-47bb-b2e7-80fa7eba329a	String	jsonType.label
2a0ac3a4-829b-4730-a247-dd5c02bedb2e	true	introspection.token.claim
2a0ac3a4-829b-4730-a247-dd5c02bedb2e	true	userinfo.token.claim
2a0ac3a4-829b-4730-a247-dd5c02bedb2e	email	user.attribute
2a0ac3a4-829b-4730-a247-dd5c02bedb2e	true	id.token.claim
2a0ac3a4-829b-4730-a247-dd5c02bedb2e	true	access.token.claim
2a0ac3a4-829b-4730-a247-dd5c02bedb2e	email	claim.name
2a0ac3a4-829b-4730-a247-dd5c02bedb2e	String	jsonType.label
e8166bcb-3d87-44e6-a46e-b10cde1e2316	true	introspection.token.claim
e8166bcb-3d87-44e6-a46e-b10cde1e2316	true	userinfo.token.claim
e8166bcb-3d87-44e6-a46e-b10cde1e2316	emailVerified	user.attribute
e8166bcb-3d87-44e6-a46e-b10cde1e2316	true	id.token.claim
e8166bcb-3d87-44e6-a46e-b10cde1e2316	true	access.token.claim
e8166bcb-3d87-44e6-a46e-b10cde1e2316	email_verified	claim.name
e8166bcb-3d87-44e6-a46e-b10cde1e2316	boolean	jsonType.label
4258c2c3-52cb-4c39-8f39-2a3db22268b6	formatted	user.attribute.formatted
4258c2c3-52cb-4c39-8f39-2a3db22268b6	country	user.attribute.country
4258c2c3-52cb-4c39-8f39-2a3db22268b6	true	introspection.token.claim
4258c2c3-52cb-4c39-8f39-2a3db22268b6	postal_code	user.attribute.postal_code
4258c2c3-52cb-4c39-8f39-2a3db22268b6	true	userinfo.token.claim
4258c2c3-52cb-4c39-8f39-2a3db22268b6	street	user.attribute.street
4258c2c3-52cb-4c39-8f39-2a3db22268b6	true	id.token.claim
4258c2c3-52cb-4c39-8f39-2a3db22268b6	region	user.attribute.region
4258c2c3-52cb-4c39-8f39-2a3db22268b6	true	access.token.claim
4258c2c3-52cb-4c39-8f39-2a3db22268b6	locality	user.attribute.locality
1366ab33-9c35-4800-b6f3-7ac526bab74a	true	introspection.token.claim
1366ab33-9c35-4800-b6f3-7ac526bab74a	true	userinfo.token.claim
1366ab33-9c35-4800-b6f3-7ac526bab74a	phoneNumberVerified	user.attribute
1366ab33-9c35-4800-b6f3-7ac526bab74a	true	id.token.claim
1366ab33-9c35-4800-b6f3-7ac526bab74a	true	access.token.claim
1366ab33-9c35-4800-b6f3-7ac526bab74a	phone_number_verified	claim.name
1366ab33-9c35-4800-b6f3-7ac526bab74a	boolean	jsonType.label
80f0863e-8b7b-4aa3-9b91-daa53aa42170	true	introspection.token.claim
80f0863e-8b7b-4aa3-9b91-daa53aa42170	true	userinfo.token.claim
80f0863e-8b7b-4aa3-9b91-daa53aa42170	phoneNumber	user.attribute
80f0863e-8b7b-4aa3-9b91-daa53aa42170	true	id.token.claim
80f0863e-8b7b-4aa3-9b91-daa53aa42170	true	access.token.claim
80f0863e-8b7b-4aa3-9b91-daa53aa42170	phone_number	claim.name
80f0863e-8b7b-4aa3-9b91-daa53aa42170	String	jsonType.label
0d3d4ec8-3966-48a0-8425-c5d0e9b66d21	true	introspection.token.claim
0d3d4ec8-3966-48a0-8425-c5d0e9b66d21	true	multivalued
0d3d4ec8-3966-48a0-8425-c5d0e9b66d21	foo	user.attribute
0d3d4ec8-3966-48a0-8425-c5d0e9b66d21	true	access.token.claim
0d3d4ec8-3966-48a0-8425-c5d0e9b66d21	realm_access.roles	claim.name
0d3d4ec8-3966-48a0-8425-c5d0e9b66d21	String	jsonType.label
4212a57e-40c7-4320-9f64-e3fc30701208	true	introspection.token.claim
4212a57e-40c7-4320-9f64-e3fc30701208	true	multivalued
4212a57e-40c7-4320-9f64-e3fc30701208	foo	user.attribute
4212a57e-40c7-4320-9f64-e3fc30701208	true	access.token.claim
4212a57e-40c7-4320-9f64-e3fc30701208	resource_access.${client_id}.roles	claim.name
4212a57e-40c7-4320-9f64-e3fc30701208	String	jsonType.label
d05d5e2c-2f56-439e-83e0-9c6a228a686c	true	introspection.token.claim
d05d5e2c-2f56-439e-83e0-9c6a228a686c	true	access.token.claim
b755458c-3167-486e-a616-96a79d6591c2	true	introspection.token.claim
b755458c-3167-486e-a616-96a79d6591c2	true	access.token.claim
6ae6f327-caaf-4204-8a7c-cf37274a613c	true	introspection.token.claim
6ae6f327-caaf-4204-8a7c-cf37274a613c	true	userinfo.token.claim
6ae6f327-caaf-4204-8a7c-cf37274a613c	username	user.attribute
6ae6f327-caaf-4204-8a7c-cf37274a613c	true	id.token.claim
6ae6f327-caaf-4204-8a7c-cf37274a613c	true	access.token.claim
6ae6f327-caaf-4204-8a7c-cf37274a613c	upn	claim.name
6ae6f327-caaf-4204-8a7c-cf37274a613c	String	jsonType.label
cdb10f04-7948-467d-b1a4-d5563a01bbd0	true	introspection.token.claim
cdb10f04-7948-467d-b1a4-d5563a01bbd0	true	multivalued
cdb10f04-7948-467d-b1a4-d5563a01bbd0	foo	user.attribute
cdb10f04-7948-467d-b1a4-d5563a01bbd0	true	id.token.claim
cdb10f04-7948-467d-b1a4-d5563a01bbd0	true	access.token.claim
cdb10f04-7948-467d-b1a4-d5563a01bbd0	groups	claim.name
cdb10f04-7948-467d-b1a4-d5563a01bbd0	String	jsonType.label
84888e72-2562-4bdc-852e-706fa5f4ddc7	true	introspection.token.claim
84888e72-2562-4bdc-852e-706fa5f4ddc7	true	id.token.claim
84888e72-2562-4bdc-852e-706fa5f4ddc7	true	access.token.claim
803c42be-314f-465d-8ac8-6d3c7a0f9263	false	single
803c42be-314f-465d-8ac8-6d3c7a0f9263	Basic	attribute.nameformat
803c42be-314f-465d-8ac8-6d3c7a0f9263	Role	attribute.name
1cbb75fc-8d3b-4470-b2fd-fbe73298c572	true	introspection.token.claim
1cbb75fc-8d3b-4470-b2fd-fbe73298c572	true	userinfo.token.claim
1cbb75fc-8d3b-4470-b2fd-fbe73298c572	middleName	user.attribute
1cbb75fc-8d3b-4470-b2fd-fbe73298c572	true	id.token.claim
1cbb75fc-8d3b-4470-b2fd-fbe73298c572	true	access.token.claim
1cbb75fc-8d3b-4470-b2fd-fbe73298c572	middle_name	claim.name
1cbb75fc-8d3b-4470-b2fd-fbe73298c572	String	jsonType.label
316ffdd1-4eaa-4c88-ace6-cb412bdbb25f	true	introspection.token.claim
316ffdd1-4eaa-4c88-ace6-cb412bdbb25f	true	userinfo.token.claim
316ffdd1-4eaa-4c88-ace6-cb412bdbb25f	picture	user.attribute
316ffdd1-4eaa-4c88-ace6-cb412bdbb25f	true	id.token.claim
316ffdd1-4eaa-4c88-ace6-cb412bdbb25f	true	access.token.claim
316ffdd1-4eaa-4c88-ace6-cb412bdbb25f	picture	claim.name
316ffdd1-4eaa-4c88-ace6-cb412bdbb25f	String	jsonType.label
45e610c4-1ec8-4d93-9513-3c79072a0cf2	true	introspection.token.claim
45e610c4-1ec8-4d93-9513-3c79072a0cf2	true	userinfo.token.claim
45e610c4-1ec8-4d93-9513-3c79072a0cf2	profile	user.attribute
45e610c4-1ec8-4d93-9513-3c79072a0cf2	true	id.token.claim
45e610c4-1ec8-4d93-9513-3c79072a0cf2	true	access.token.claim
45e610c4-1ec8-4d93-9513-3c79072a0cf2	profile	claim.name
45e610c4-1ec8-4d93-9513-3c79072a0cf2	String	jsonType.label
5131aba3-7758-4dbc-b204-51f44d6d0274	true	introspection.token.claim
5131aba3-7758-4dbc-b204-51f44d6d0274	true	userinfo.token.claim
5131aba3-7758-4dbc-b204-51f44d6d0274	true	id.token.claim
5131aba3-7758-4dbc-b204-51f44d6d0274	true	access.token.claim
5a2a8b99-d6d2-4ab4-9c83-96a645dd1e46	true	introspection.token.claim
5a2a8b99-d6d2-4ab4-9c83-96a645dd1e46	true	userinfo.token.claim
5a2a8b99-d6d2-4ab4-9c83-96a645dd1e46	lastName	user.attribute
5a2a8b99-d6d2-4ab4-9c83-96a645dd1e46	true	id.token.claim
5a2a8b99-d6d2-4ab4-9c83-96a645dd1e46	true	access.token.claim
5a2a8b99-d6d2-4ab4-9c83-96a645dd1e46	family_name	claim.name
5a2a8b99-d6d2-4ab4-9c83-96a645dd1e46	String	jsonType.label
8cfcfabf-b970-4077-8285-a11cbd7f428f	true	introspection.token.claim
8cfcfabf-b970-4077-8285-a11cbd7f428f	true	userinfo.token.claim
8cfcfabf-b970-4077-8285-a11cbd7f428f	nickname	user.attribute
8cfcfabf-b970-4077-8285-a11cbd7f428f	true	id.token.claim
8cfcfabf-b970-4077-8285-a11cbd7f428f	true	access.token.claim
8cfcfabf-b970-4077-8285-a11cbd7f428f	nickname	claim.name
8cfcfabf-b970-4077-8285-a11cbd7f428f	String	jsonType.label
951fe120-42b3-43ef-9de4-aba3cad1b5fd	true	introspection.token.claim
951fe120-42b3-43ef-9de4-aba3cad1b5fd	true	userinfo.token.claim
951fe120-42b3-43ef-9de4-aba3cad1b5fd	firstName	user.attribute
951fe120-42b3-43ef-9de4-aba3cad1b5fd	true	id.token.claim
951fe120-42b3-43ef-9de4-aba3cad1b5fd	true	access.token.claim
951fe120-42b3-43ef-9de4-aba3cad1b5fd	given_name	claim.name
951fe120-42b3-43ef-9de4-aba3cad1b5fd	String	jsonType.label
966bb60a-2584-4635-a7f0-ab0b203cf1f2	true	introspection.token.claim
966bb60a-2584-4635-a7f0-ab0b203cf1f2	true	userinfo.token.claim
966bb60a-2584-4635-a7f0-ab0b203cf1f2	locale	user.attribute
966bb60a-2584-4635-a7f0-ab0b203cf1f2	true	id.token.claim
966bb60a-2584-4635-a7f0-ab0b203cf1f2	true	access.token.claim
966bb60a-2584-4635-a7f0-ab0b203cf1f2	locale	claim.name
966bb60a-2584-4635-a7f0-ab0b203cf1f2	String	jsonType.label
9a0d216d-036d-4c7d-85ad-a5fd1c139fab	true	introspection.token.claim
9a0d216d-036d-4c7d-85ad-a5fd1c139fab	true	userinfo.token.claim
9a0d216d-036d-4c7d-85ad-a5fd1c139fab	zoneinfo	user.attribute
9a0d216d-036d-4c7d-85ad-a5fd1c139fab	true	id.token.claim
9a0d216d-036d-4c7d-85ad-a5fd1c139fab	true	access.token.claim
9a0d216d-036d-4c7d-85ad-a5fd1c139fab	zoneinfo	claim.name
9a0d216d-036d-4c7d-85ad-a5fd1c139fab	String	jsonType.label
9e296da8-add6-4d2f-bebb-b49f7c274bae	true	introspection.token.claim
9e296da8-add6-4d2f-bebb-b49f7c274bae	true	userinfo.token.claim
9e296da8-add6-4d2f-bebb-b49f7c274bae	gender	user.attribute
9e296da8-add6-4d2f-bebb-b49f7c274bae	true	id.token.claim
9e296da8-add6-4d2f-bebb-b49f7c274bae	true	access.token.claim
9e296da8-add6-4d2f-bebb-b49f7c274bae	gender	claim.name
9e296da8-add6-4d2f-bebb-b49f7c274bae	String	jsonType.label
abd76451-416b-458e-873f-94dac142f0ce	true	introspection.token.claim
abd76451-416b-458e-873f-94dac142f0ce	true	userinfo.token.claim
abd76451-416b-458e-873f-94dac142f0ce	username	user.attribute
abd76451-416b-458e-873f-94dac142f0ce	true	id.token.claim
abd76451-416b-458e-873f-94dac142f0ce	true	access.token.claim
abd76451-416b-458e-873f-94dac142f0ce	preferred_username	claim.name
abd76451-416b-458e-873f-94dac142f0ce	String	jsonType.label
b81a6699-9f87-494f-910b-b527aed6f1fb	true	introspection.token.claim
b81a6699-9f87-494f-910b-b527aed6f1fb	true	userinfo.token.claim
b81a6699-9f87-494f-910b-b527aed6f1fb	birthdate	user.attribute
b81a6699-9f87-494f-910b-b527aed6f1fb	true	id.token.claim
b81a6699-9f87-494f-910b-b527aed6f1fb	true	access.token.claim
b81a6699-9f87-494f-910b-b527aed6f1fb	birthdate	claim.name
b81a6699-9f87-494f-910b-b527aed6f1fb	String	jsonType.label
d76b1a69-02d2-4013-a65c-591d363b659a	true	introspection.token.claim
d76b1a69-02d2-4013-a65c-591d363b659a	true	userinfo.token.claim
d76b1a69-02d2-4013-a65c-591d363b659a	website	user.attribute
d76b1a69-02d2-4013-a65c-591d363b659a	true	id.token.claim
d76b1a69-02d2-4013-a65c-591d363b659a	true	access.token.claim
d76b1a69-02d2-4013-a65c-591d363b659a	website	claim.name
d76b1a69-02d2-4013-a65c-591d363b659a	String	jsonType.label
f00ab0c7-b3b4-4242-8aa9-48c997851b0b	true	introspection.token.claim
f00ab0c7-b3b4-4242-8aa9-48c997851b0b	true	userinfo.token.claim
f00ab0c7-b3b4-4242-8aa9-48c997851b0b	updatedAt	user.attribute
f00ab0c7-b3b4-4242-8aa9-48c997851b0b	true	id.token.claim
f00ab0c7-b3b4-4242-8aa9-48c997851b0b	true	access.token.claim
f00ab0c7-b3b4-4242-8aa9-48c997851b0b	updated_at	claim.name
f00ab0c7-b3b4-4242-8aa9-48c997851b0b	long	jsonType.label
105e3534-a4aa-435d-8dbf-71fc38cdea8c	true	introspection.token.claim
105e3534-a4aa-435d-8dbf-71fc38cdea8c	true	userinfo.token.claim
105e3534-a4aa-435d-8dbf-71fc38cdea8c	emailVerified	user.attribute
105e3534-a4aa-435d-8dbf-71fc38cdea8c	true	id.token.claim
105e3534-a4aa-435d-8dbf-71fc38cdea8c	true	access.token.claim
105e3534-a4aa-435d-8dbf-71fc38cdea8c	email_verified	claim.name
105e3534-a4aa-435d-8dbf-71fc38cdea8c	boolean	jsonType.label
7863fccd-e091-484c-a427-4cf2edcd5c21	true	introspection.token.claim
7863fccd-e091-484c-a427-4cf2edcd5c21	true	userinfo.token.claim
7863fccd-e091-484c-a427-4cf2edcd5c21	email	user.attribute
7863fccd-e091-484c-a427-4cf2edcd5c21	true	id.token.claim
7863fccd-e091-484c-a427-4cf2edcd5c21	true	access.token.claim
7863fccd-e091-484c-a427-4cf2edcd5c21	email	claim.name
7863fccd-e091-484c-a427-4cf2edcd5c21	String	jsonType.label
626e2336-e72b-4c28-885a-632ca0949999	formatted	user.attribute.formatted
626e2336-e72b-4c28-885a-632ca0949999	country	user.attribute.country
626e2336-e72b-4c28-885a-632ca0949999	true	introspection.token.claim
626e2336-e72b-4c28-885a-632ca0949999	postal_code	user.attribute.postal_code
626e2336-e72b-4c28-885a-632ca0949999	true	userinfo.token.claim
626e2336-e72b-4c28-885a-632ca0949999	street	user.attribute.street
626e2336-e72b-4c28-885a-632ca0949999	true	id.token.claim
626e2336-e72b-4c28-885a-632ca0949999	region	user.attribute.region
626e2336-e72b-4c28-885a-632ca0949999	true	access.token.claim
626e2336-e72b-4c28-885a-632ca0949999	locality	user.attribute.locality
7b3497d7-15e7-43b1-b2a5-6febdfc055c3	true	introspection.token.claim
7b3497d7-15e7-43b1-b2a5-6febdfc055c3	true	userinfo.token.claim
7b3497d7-15e7-43b1-b2a5-6febdfc055c3	phoneNumber	user.attribute
7b3497d7-15e7-43b1-b2a5-6febdfc055c3	true	id.token.claim
7b3497d7-15e7-43b1-b2a5-6febdfc055c3	true	access.token.claim
7b3497d7-15e7-43b1-b2a5-6febdfc055c3	phone_number	claim.name
7b3497d7-15e7-43b1-b2a5-6febdfc055c3	String	jsonType.label
c3767d80-a3a7-4634-b4cb-dddb7418a0a0	true	introspection.token.claim
c3767d80-a3a7-4634-b4cb-dddb7418a0a0	true	userinfo.token.claim
c3767d80-a3a7-4634-b4cb-dddb7418a0a0	phoneNumberVerified	user.attribute
c3767d80-a3a7-4634-b4cb-dddb7418a0a0	true	id.token.claim
c3767d80-a3a7-4634-b4cb-dddb7418a0a0	true	access.token.claim
c3767d80-a3a7-4634-b4cb-dddb7418a0a0	phone_number_verified	claim.name
c3767d80-a3a7-4634-b4cb-dddb7418a0a0	boolean	jsonType.label
880fb8f4-8767-4e8c-81a6-3d1876687713	true	introspection.token.claim
880fb8f4-8767-4e8c-81a6-3d1876687713	true	access.token.claim
a41a5422-20e4-4cf5-b47e-139342be9768	true	introspection.token.claim
a41a5422-20e4-4cf5-b47e-139342be9768	true	multivalued
a41a5422-20e4-4cf5-b47e-139342be9768	foo	user.attribute
a41a5422-20e4-4cf5-b47e-139342be9768	true	access.token.claim
a41a5422-20e4-4cf5-b47e-139342be9768	realm_access.roles	claim.name
a41a5422-20e4-4cf5-b47e-139342be9768	String	jsonType.label
f2c25b4b-d40a-475c-a259-62c9dd8fb4ea	true	introspection.token.claim
f2c25b4b-d40a-475c-a259-62c9dd8fb4ea	true	multivalued
f2c25b4b-d40a-475c-a259-62c9dd8fb4ea	foo	user.attribute
f2c25b4b-d40a-475c-a259-62c9dd8fb4ea	true	access.token.claim
f2c25b4b-d40a-475c-a259-62c9dd8fb4ea	resource_access.${client_id}.roles	claim.name
f2c25b4b-d40a-475c-a259-62c9dd8fb4ea	String	jsonType.label
8f9bde15-0801-4b25-876b-c2ced8d7cbb1	true	introspection.token.claim
8f9bde15-0801-4b25-876b-c2ced8d7cbb1	true	access.token.claim
114923c0-480b-467a-8394-995f9b3e36c0	true	introspection.token.claim
114923c0-480b-467a-8394-995f9b3e36c0	true	userinfo.token.claim
114923c0-480b-467a-8394-995f9b3e36c0	username	user.attribute
114923c0-480b-467a-8394-995f9b3e36c0	true	id.token.claim
114923c0-480b-467a-8394-995f9b3e36c0	true	access.token.claim
114923c0-480b-467a-8394-995f9b3e36c0	upn	claim.name
114923c0-480b-467a-8394-995f9b3e36c0	String	jsonType.label
56d15d47-75d9-4561-a408-2dfb4c74f955	true	introspection.token.claim
56d15d47-75d9-4561-a408-2dfb4c74f955	true	multivalued
56d15d47-75d9-4561-a408-2dfb4c74f955	foo	user.attribute
56d15d47-75d9-4561-a408-2dfb4c74f955	true	id.token.claim
56d15d47-75d9-4561-a408-2dfb4c74f955	true	access.token.claim
56d15d47-75d9-4561-a408-2dfb4c74f955	groups	claim.name
56d15d47-75d9-4561-a408-2dfb4c74f955	String	jsonType.label
ed2c66e9-1e80-4994-8c53-5788553c1fde	true	introspection.token.claim
ed2c66e9-1e80-4994-8c53-5788553c1fde	true	id.token.claim
ed2c66e9-1e80-4994-8c53-5788553c1fde	true	access.token.claim
1b01dabd-3fcf-4cd8-9222-0b263d61cca0	true	introspection.token.claim
1b01dabd-3fcf-4cd8-9222-0b263d61cca0	true	userinfo.token.claim
1b01dabd-3fcf-4cd8-9222-0b263d61cca0	locale	user.attribute
1b01dabd-3fcf-4cd8-9222-0b263d61cca0	true	id.token.claim
1b01dabd-3fcf-4cd8-9222-0b263d61cca0	true	access.token.claim
1b01dabd-3fcf-4cd8-9222-0b263d61cca0	locale	claim.name
1b01dabd-3fcf-4cd8-9222-0b263d61cca0	String	jsonType.label
c1e5a923-e6b4-4064-9497-9181f199f341	true	introspection.token.claim
c1e5a923-e6b4-4064-9497-9181f199f341	false	id.token.claim
c1e5a923-e6b4-4064-9497-9181f199f341	false	lightweight.claim
c1e5a923-e6b4-4064-9497-9181f199f341	true	access.token.claim
c1e5a923-e6b4-4064-9497-9181f199f341	backend-api	included.client.audience
c1e5a923-e6b4-4064-9497-9181f199f341	false	userinfo.token.claim
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
466b29ba-5081-488d-9245-7ea9c707034a	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	9fad4d62-b215-4051-aff5-be0788d82f32	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	6d08abca-278e-4461-ae67-87612ca1e596	f5bb0ea1-4069-42c2-b190-009217ae3005	9a27eff1-8400-4535-8b30-37c5099e068f	a4361dd5-075e-45e8-a2c1-6c65826e9b1b	74aaa948-2100-4708-ad21-a31e3341ff8c	2592000	f	900	t	f	1339e4b5-6871-4a64-be8a-fae1eaf6b594	0	f	0	0	95daf9e3-ac47-44e0-9caf-b4b403b7f65f
55e0b680-0bdb-451b-acf8-9c5eacce36dc	60	300	300	\N	\N	\N	t	f	0	\N	testpoc	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	03dead48-43e4-4bfb-9178-fb382f9d15d4	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	582e7173-f038-485f-adbb-fe980c09894d	9f62652d-a70b-44c0-82d4-086ae3837fb2	616201a6-20f2-42ca-92b4-f2e39ee273b6	c718cfaf-f006-4740-b908-d473b2c96455	a8a77821-c539-4ec0-be77-9fb443fd5c55	2592000	f	900	t	f	9ef68c06-420e-4793-917e-ce254cbb20b1	0	f	0	0	8765100e-889a-4b65-ba3f-b0a43d8dca76
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	466b29ba-5081-488d-9245-7ea9c707034a	
_browser_header.xContentTypeOptions	466b29ba-5081-488d-9245-7ea9c707034a	nosniff
_browser_header.referrerPolicy	466b29ba-5081-488d-9245-7ea9c707034a	no-referrer
_browser_header.xRobotsTag	466b29ba-5081-488d-9245-7ea9c707034a	none
_browser_header.xFrameOptions	466b29ba-5081-488d-9245-7ea9c707034a	SAMEORIGIN
_browser_header.contentSecurityPolicy	466b29ba-5081-488d-9245-7ea9c707034a	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	466b29ba-5081-488d-9245-7ea9c707034a	1; mode=block
_browser_header.strictTransportSecurity	466b29ba-5081-488d-9245-7ea9c707034a	max-age=31536000; includeSubDomains
bruteForceProtected	466b29ba-5081-488d-9245-7ea9c707034a	false
permanentLockout	466b29ba-5081-488d-9245-7ea9c707034a	false
maxTemporaryLockouts	466b29ba-5081-488d-9245-7ea9c707034a	0
maxFailureWaitSeconds	466b29ba-5081-488d-9245-7ea9c707034a	900
minimumQuickLoginWaitSeconds	466b29ba-5081-488d-9245-7ea9c707034a	60
waitIncrementSeconds	466b29ba-5081-488d-9245-7ea9c707034a	60
quickLoginCheckMilliSeconds	466b29ba-5081-488d-9245-7ea9c707034a	1000
maxDeltaTimeSeconds	466b29ba-5081-488d-9245-7ea9c707034a	43200
failureFactor	466b29ba-5081-488d-9245-7ea9c707034a	30
realmReusableOtpCode	466b29ba-5081-488d-9245-7ea9c707034a	false
firstBrokerLoginFlowId	466b29ba-5081-488d-9245-7ea9c707034a	a8fa7ce7-4a70-440d-8db2-e20e9d3757b9
displayName	466b29ba-5081-488d-9245-7ea9c707034a	Keycloak
displayNameHtml	466b29ba-5081-488d-9245-7ea9c707034a	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	466b29ba-5081-488d-9245-7ea9c707034a	RS256
offlineSessionMaxLifespanEnabled	466b29ba-5081-488d-9245-7ea9c707034a	false
offlineSessionMaxLifespan	466b29ba-5081-488d-9245-7ea9c707034a	5184000
_browser_header.contentSecurityPolicyReportOnly	55e0b680-0bdb-451b-acf8-9c5eacce36dc	
_browser_header.xContentTypeOptions	55e0b680-0bdb-451b-acf8-9c5eacce36dc	nosniff
_browser_header.referrerPolicy	55e0b680-0bdb-451b-acf8-9c5eacce36dc	no-referrer
_browser_header.xRobotsTag	55e0b680-0bdb-451b-acf8-9c5eacce36dc	none
_browser_header.xFrameOptions	55e0b680-0bdb-451b-acf8-9c5eacce36dc	SAMEORIGIN
_browser_header.contentSecurityPolicy	55e0b680-0bdb-451b-acf8-9c5eacce36dc	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	55e0b680-0bdb-451b-acf8-9c5eacce36dc	1; mode=block
_browser_header.strictTransportSecurity	55e0b680-0bdb-451b-acf8-9c5eacce36dc	max-age=31536000; includeSubDomains
bruteForceProtected	55e0b680-0bdb-451b-acf8-9c5eacce36dc	false
permanentLockout	55e0b680-0bdb-451b-acf8-9c5eacce36dc	false
maxTemporaryLockouts	55e0b680-0bdb-451b-acf8-9c5eacce36dc	0
maxFailureWaitSeconds	55e0b680-0bdb-451b-acf8-9c5eacce36dc	900
minimumQuickLoginWaitSeconds	55e0b680-0bdb-451b-acf8-9c5eacce36dc	60
waitIncrementSeconds	55e0b680-0bdb-451b-acf8-9c5eacce36dc	60
quickLoginCheckMilliSeconds	55e0b680-0bdb-451b-acf8-9c5eacce36dc	1000
maxDeltaTimeSeconds	55e0b680-0bdb-451b-acf8-9c5eacce36dc	43200
failureFactor	55e0b680-0bdb-451b-acf8-9c5eacce36dc	30
realmReusableOtpCode	55e0b680-0bdb-451b-acf8-9c5eacce36dc	false
defaultSignatureAlgorithm	55e0b680-0bdb-451b-acf8-9c5eacce36dc	RS256
offlineSessionMaxLifespanEnabled	55e0b680-0bdb-451b-acf8-9c5eacce36dc	false
offlineSessionMaxLifespan	55e0b680-0bdb-451b-acf8-9c5eacce36dc	5184000
actionTokenGeneratedByAdminLifespan	55e0b680-0bdb-451b-acf8-9c5eacce36dc	43200
actionTokenGeneratedByUserLifespan	55e0b680-0bdb-451b-acf8-9c5eacce36dc	300
oauth2DeviceCodeLifespan	55e0b680-0bdb-451b-acf8-9c5eacce36dc	600
oauth2DevicePollingInterval	55e0b680-0bdb-451b-acf8-9c5eacce36dc	5
webAuthnPolicyRpEntityName	55e0b680-0bdb-451b-acf8-9c5eacce36dc	keycloak
webAuthnPolicySignatureAlgorithms	55e0b680-0bdb-451b-acf8-9c5eacce36dc	ES256
webAuthnPolicyRpId	55e0b680-0bdb-451b-acf8-9c5eacce36dc	
webAuthnPolicyAttestationConveyancePreference	55e0b680-0bdb-451b-acf8-9c5eacce36dc	not specified
webAuthnPolicyAuthenticatorAttachment	55e0b680-0bdb-451b-acf8-9c5eacce36dc	not specified
webAuthnPolicyRequireResidentKey	55e0b680-0bdb-451b-acf8-9c5eacce36dc	not specified
webAuthnPolicyUserVerificationRequirement	55e0b680-0bdb-451b-acf8-9c5eacce36dc	not specified
webAuthnPolicyCreateTimeout	55e0b680-0bdb-451b-acf8-9c5eacce36dc	0
webAuthnPolicyAvoidSameAuthenticatorRegister	55e0b680-0bdb-451b-acf8-9c5eacce36dc	false
webAuthnPolicyRpEntityNamePasswordless	55e0b680-0bdb-451b-acf8-9c5eacce36dc	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	55e0b680-0bdb-451b-acf8-9c5eacce36dc	ES256
webAuthnPolicyRpIdPasswordless	55e0b680-0bdb-451b-acf8-9c5eacce36dc	
webAuthnPolicyAttestationConveyancePreferencePasswordless	55e0b680-0bdb-451b-acf8-9c5eacce36dc	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	55e0b680-0bdb-451b-acf8-9c5eacce36dc	not specified
webAuthnPolicyRequireResidentKeyPasswordless	55e0b680-0bdb-451b-acf8-9c5eacce36dc	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	55e0b680-0bdb-451b-acf8-9c5eacce36dc	not specified
webAuthnPolicyCreateTimeoutPasswordless	55e0b680-0bdb-451b-acf8-9c5eacce36dc	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	55e0b680-0bdb-451b-acf8-9c5eacce36dc	false
cibaBackchannelTokenDeliveryMode	55e0b680-0bdb-451b-acf8-9c5eacce36dc	poll
cibaExpiresIn	55e0b680-0bdb-451b-acf8-9c5eacce36dc	120
cibaInterval	55e0b680-0bdb-451b-acf8-9c5eacce36dc	5
cibaAuthRequestedUserHint	55e0b680-0bdb-451b-acf8-9c5eacce36dc	login_hint
parRequestUriLifespan	55e0b680-0bdb-451b-acf8-9c5eacce36dc	60
firstBrokerLoginFlowId	55e0b680-0bdb-451b-acf8-9c5eacce36dc	aaecd8a6-366c-4625-9ea1-d661fe52613c
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
466b29ba-5081-488d-9245-7ea9c707034a	jboss-logging
55e0b680-0bdb-451b-acf8-9c5eacce36dc	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	466b29ba-5081-488d-9245-7ea9c707034a
password	password	t	t	55e0b680-0bdb-451b-acf8-9c5eacce36dc
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.redirect_uris (client_id, value) FROM stdin;
e3f22e78-f51f-49d9-9bb8-2e460002128d	/realms/master/account/*
5b617b10-fd84-467d-afbc-991dd9aaff9a	/realms/master/account/*
b844a64d-75aa-4b17-bfc2-dc5902d551a5	/admin/master/console/*
33c40cc6-7c03-4f2f-bf76-88a0f61bc39d	/realms/testpoc/account/*
7f0a6944-b6cf-463a-a6ab-8eda364e1f8f	/realms/testpoc/account/*
6f8b1d7b-a0f0-4c1f-8dc7-f81928b2b49b	/admin/testpoc/console/*
aa2242aa-87dd-4e31-a399-c8ca37bd0405	http://localhost:5173/*
94e3a758-71cb-4427-be5f-c9ac760664ea	
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
a17a3274-a639-4f2f-88c2-39b4df179b6c	VERIFY_EMAIL	Verify Email	466b29ba-5081-488d-9245-7ea9c707034a	t	f	VERIFY_EMAIL	50
9cde0d4c-8ed2-4d73-9a53-60267ce998b8	UPDATE_PROFILE	Update Profile	466b29ba-5081-488d-9245-7ea9c707034a	t	f	UPDATE_PROFILE	40
86e4255e-18fe-49e0-84d0-28d85713993e	CONFIGURE_TOTP	Configure OTP	466b29ba-5081-488d-9245-7ea9c707034a	t	f	CONFIGURE_TOTP	10
ffc558ee-89c7-417a-9a5c-6535668f19c0	UPDATE_PASSWORD	Update Password	466b29ba-5081-488d-9245-7ea9c707034a	t	f	UPDATE_PASSWORD	30
fe2df117-354f-4390-b6a4-7e5f5003400b	TERMS_AND_CONDITIONS	Terms and Conditions	466b29ba-5081-488d-9245-7ea9c707034a	f	f	TERMS_AND_CONDITIONS	20
7e3a3d7e-bf65-452f-98c5-ee171010292d	delete_account	Delete Account	466b29ba-5081-488d-9245-7ea9c707034a	f	f	delete_account	60
4a44b28b-3245-4dd2-a80a-9eb5f1a9e089	delete_credential	Delete Credential	466b29ba-5081-488d-9245-7ea9c707034a	t	f	delete_credential	100
3c85015c-588c-4b4b-a124-ae5bf76efd7d	update_user_locale	Update User Locale	466b29ba-5081-488d-9245-7ea9c707034a	t	f	update_user_locale	1000
9239e7ad-4987-4170-8382-19e6237c7a77	webauthn-register	Webauthn Register	466b29ba-5081-488d-9245-7ea9c707034a	t	f	webauthn-register	70
ab260a74-dad7-40d6-9ff6-3d0580c2ea03	webauthn-register-passwordless	Webauthn Register Passwordless	466b29ba-5081-488d-9245-7ea9c707034a	t	f	webauthn-register-passwordless	80
98bc40de-6d8a-4feb-9ac5-989c1b80cf67	VERIFY_PROFILE	Verify Profile	466b29ba-5081-488d-9245-7ea9c707034a	t	f	VERIFY_PROFILE	90
219781ac-697b-4c15-a01c-7a134876b527	VERIFY_EMAIL	Verify Email	55e0b680-0bdb-451b-acf8-9c5eacce36dc	t	f	VERIFY_EMAIL	50
8c76d71e-420a-40fa-8d1e-b75826c935f5	UPDATE_PROFILE	Update Profile	55e0b680-0bdb-451b-acf8-9c5eacce36dc	t	f	UPDATE_PROFILE	40
850f4541-83bd-4d52-9bbe-fd4ff4d7cc17	CONFIGURE_TOTP	Configure OTP	55e0b680-0bdb-451b-acf8-9c5eacce36dc	t	f	CONFIGURE_TOTP	10
f4a70962-d3aa-4f66-9078-d7e586bc05be	UPDATE_PASSWORD	Update Password	55e0b680-0bdb-451b-acf8-9c5eacce36dc	t	f	UPDATE_PASSWORD	30
dd050715-8cc4-4bff-9485-bc7d126167eb	TERMS_AND_CONDITIONS	Terms and Conditions	55e0b680-0bdb-451b-acf8-9c5eacce36dc	f	f	TERMS_AND_CONDITIONS	20
57dc70a3-3b06-4711-bc29-9d5012b4e0ca	delete_account	Delete Account	55e0b680-0bdb-451b-acf8-9c5eacce36dc	f	f	delete_account	60
bf3307f1-3ceb-425f-8f40-d5e31a9d4680	delete_credential	Delete Credential	55e0b680-0bdb-451b-acf8-9c5eacce36dc	t	f	delete_credential	100
604c6465-c00f-4fc5-b8bf-ac9f524d4cb4	update_user_locale	Update User Locale	55e0b680-0bdb-451b-acf8-9c5eacce36dc	t	f	update_user_locale	1000
9420d36d-0ec4-4d3c-9c66-7054961de183	webauthn-register	Webauthn Register	55e0b680-0bdb-451b-acf8-9c5eacce36dc	t	f	webauthn-register	70
1aaf06dd-e3da-4eea-9d59-7747cc2c29a5	webauthn-register-passwordless	Webauthn Register Passwordless	55e0b680-0bdb-451b-acf8-9c5eacce36dc	t	f	webauthn-register-passwordless	80
ffea624c-02e6-41cb-ab40-341a573ab27e	VERIFY_PROFILE	Verify Profile	55e0b680-0bdb-451b-acf8-9c5eacce36dc	t	f	VERIFY_PROFILE	90
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
5b617b10-fd84-467d-afbc-991dd9aaff9a	82e2d139-d201-40c0-88a0-8f4a734dd4e2
5b617b10-fd84-467d-afbc-991dd9aaff9a	bea538db-5505-44ce-b93c-839c2bed7f87
7f0a6944-b6cf-463a-a6ab-8eda364e1f8f	1593b9fd-75d6-45e8-b079-b1d3418862fa
7f0a6944-b6cf-463a-a6ab-8eda364e1f8f	5e8af63e-5655-46d3-805c-64f952756c05
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
LDAP_ID	6b689030-55a3-1040-89cc-0bd10d5eb3d1	76731bc1-a45c-4828-b653-e35bdd10f39a	a22ac93f-7d78-4547-91a6-ea185b57c00d	\N	\N	\N
LDAP_ENTRY_DN	cn=jeanluc,ou=Users,dc=neurospin,dc=com	76731bc1-a45c-4828-b653-e35bdd10f39a	8017d401-f21e-47bb-9e4a-d6341139190e	\N	\N	\N
LDAP_ID	6b68e292-55a3-1040-89cd-0bd10d5eb3d1	4556f801-1e6b-4f63-8b9f-766d27b127b8	ebdb0c67-e413-4069-8340-22d37922090f	\N	\N	\N
LDAP_ENTRY_DN	cn=marie,ou=Users,dc=neurospin,dc=com	4556f801-1e6b-4f63-8b9f-766d27b127b8	ab5e5c46-523c-4925-be94-659a337d7dc7	\N	\N	\N
LDAP_ID	6b695358-55a3-1040-89ce-0bd10d5eb3d1	fefca66c-28f3-4905-9ac2-7b6273f68ead	8350ce39-5d16-4b09-bf25-a5ca25fe0018	\N	\N	\N
LDAP_ENTRY_DN	cn=pierre,ou=Users,dc=neurospin,dc=com	fefca66c-28f3-4905-9ac2-7b6273f68ead	4b75f299-9f09-4795-b135-e1c3c97b4a34	\N	\N	\N
modifyTimestamp	20251114124435Z	76731bc1-a45c-4828-b653-e35bdd10f39a	e6836e2b-e2bd-4dc9-bba9-97b267418304	\N	\N	\N
createTimestamp	20251114124435Z	76731bc1-a45c-4828-b653-e35bdd10f39a	bb0c4cd3-9522-48f5-9e18-fa4e491ba1f0	\N	\N	\N
modifyTimestamp	20251114124435Z	4556f801-1e6b-4f63-8b9f-766d27b127b8	b330c722-efd3-48ed-bb75-6407aabfaf6a	\N	\N	\N
createTimestamp	20251114124435Z	4556f801-1e6b-4f63-8b9f-766d27b127b8	3e2793a5-8bcd-4aee-9fa5-d0cadfc2d48d	\N	\N	\N
modifyTimestamp	20251114124435Z	fefca66c-28f3-4905-9ac2-7b6273f68ead	c38fe659-1412-45a6-806e-860f377909d7	\N	\N	\N
createTimestamp	20251114124435Z	fefca66c-28f3-4905-9ac2-7b6273f68ead	96547158-4261-4192-8173-120b6409c1ab	\N	\N	\N
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
30dfe41c-6e58-43ed-baf9-862a080b3786	\N	22a0161a-6780-4933-a752-a238132d03d2	f	t	\N	\N	\N	466b29ba-5081-488d-9245-7ea9c707034a	admin	1763321535164	\N	0
76731bc1-a45c-4828-b653-e35bdd10f39a	jeanluc@neurospin.com	jeanluc@neurospin.com	f	t	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	jeanluc	Luc	55e0b680-0bdb-451b-acf8-9c5eacce36dc	jeanluc	1763323364971	\N	0
4556f801-1e6b-4f63-8b9f-766d27b127b8	marie@neurospin.com	marie@neurospin.com	f	t	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	marie	Dupont	55e0b680-0bdb-451b-acf8-9c5eacce36dc	marie	1763323364986	\N	0
fefca66c-28f3-4905-9ac2-7b6273f68ead	pierre@neurospin.com	pierre@neurospin.com	f	t	783f0e8d-31d5-45fe-8fbd-9832083c7f1b	pierre	Martin	55e0b680-0bdb-451b-acf8-9c5eacce36dc	pierre	1763323364992	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
95daf9e3-ac47-44e0-9caf-b4b403b7f65f	30dfe41c-6e58-43ed-baf9-862a080b3786
98b40455-6485-43da-bc3e-887552b2a0a1	30dfe41c-6e58-43ed-baf9-862a080b3786
daebb2ea-7de0-4b4a-9918-aed9faa8abde	30dfe41c-6e58-43ed-baf9-862a080b3786
84cf233b-26d3-4c7e-ac15-656901d718f5	30dfe41c-6e58-43ed-baf9-862a080b3786
b07de108-91d7-4022-ab55-fe9ff0900cbc	30dfe41c-6e58-43ed-baf9-862a080b3786
07732a43-4705-4192-bb7b-3f83b974d060	30dfe41c-6e58-43ed-baf9-862a080b3786
a9bff680-8495-4616-abc7-9e14330e8867	30dfe41c-6e58-43ed-baf9-862a080b3786
44933f23-875f-4ebe-9c58-2c771ae3767a	30dfe41c-6e58-43ed-baf9-862a080b3786
7f34db25-d388-4353-bee8-7d1938c35f1b	30dfe41c-6e58-43ed-baf9-862a080b3786
84165bf0-42a5-4775-8214-dc3706f6b4fc	30dfe41c-6e58-43ed-baf9-862a080b3786
e8cf2f10-dddb-4126-bdc9-5fd31b90a5fc	30dfe41c-6e58-43ed-baf9-862a080b3786
309fadff-0fbf-4c27-ae72-1993b84b03d3	30dfe41c-6e58-43ed-baf9-862a080b3786
e3a1f4a0-9c14-4033-8f4d-1c10ed8aa1d4	30dfe41c-6e58-43ed-baf9-862a080b3786
7ded0720-b1f7-4511-999c-aa1d55f46a59	30dfe41c-6e58-43ed-baf9-862a080b3786
b2273292-4751-4dbd-9788-d080d371b1d9	30dfe41c-6e58-43ed-baf9-862a080b3786
e6d9a5d1-3ac1-4940-a999-666eb413d6bb	30dfe41c-6e58-43ed-baf9-862a080b3786
4090fc41-137c-4b1d-b63e-cce9a0cd1da0	30dfe41c-6e58-43ed-baf9-862a080b3786
de8b271d-18f7-4d91-b47d-e23ee342adcd	30dfe41c-6e58-43ed-baf9-862a080b3786
4a741732-5d81-4e00-a0a7-5da821fa3d6c	30dfe41c-6e58-43ed-baf9-862a080b3786
8765100e-889a-4b65-ba3f-b0a43d8dca76	76731bc1-a45c-4828-b653-e35bdd10f39a
8765100e-889a-4b65-ba3f-b0a43d8dca76	4556f801-1e6b-4f63-8b9f-766d27b127b8
8765100e-889a-4b65-ba3f-b0a43d8dca76	fefca66c-28f3-4905-9ac2-7b6273f68ead
1847c470-7288-4229-b1bd-8c7ec8068c51	76731bc1-a45c-4828-b653-e35bdd10f39a
61d0ccf2-2dd0-456a-9cf8-eeb65150bed6	4556f801-1e6b-4f63-8b9f-766d27b127b8
61d0ccf2-2dd0-456a-9cf8-eeb65150bed6	fefca66c-28f3-4905-9ac2-7b6273f68ead
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak_db_user
--

COPY public.web_origins (client_id, value) FROM stdin;
b844a64d-75aa-4b17-bfc2-dc5902d551a5	+
6f8b1d7b-a0f0-4c1f-8dc7-f81928b2b49b	+
aa2242aa-87dd-4e31-a399-c8ca37bd0405	http://localhost:5173
94e3a758-71cb-4427-be5f-c9ac760664ea	http://127.0.0.1:5000/*
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: keycloak_db_user
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak_db_user
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

\unrestrict BwfN5xgvRxzqV4aKBNLU14a0tt1iO836ftlAUHjMY2Bi7FgCrrid4l2F9937Omm

