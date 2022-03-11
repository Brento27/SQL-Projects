CREATE TABLE my_contacts (
    contact_id bigserial CONSTRAINT contact_id_key PRIMARY KEY,
    last_name varchar(20) NOT NULL,
    first_name varchar(100) NOT NULL,
    phone integer NOT NULL,
    email varchar(50) NOT NULL constraint email_constraint unique,
    gender varchar(50) NOT NULL, 
    birthday integer NOT NULL,
    prof_id integer NOT NULL references profession (prof_id),
    zip_code integer NOT NULL references zip_code (zip_code),
   status_id integer NOT NULL references status (status_id)
);

CREATE TABLE profession (
    prof_id bigserial CONSTRAINT prof_id_key PRIMARY KEY,
    profession varchar(25) NOT NULL,
	CONSTRAINT unique_profession UNIQUE (profession)
);

CREATE TABLE zip_code (
    zip_code integer CONSTRAINT zip_code_key PRIMARY KEY,
    city varchar(25) NOT NULL,
    province varchar(25) NOT NULL,
	CONSTRAINT check_zip_code CHECK (lENGTH(zip_code::varchar(100)) < 5)
);

CREATE TABLE status (
    status_id bigserial CONSTRAINT status_id_key PRIMARY KEY,
    status varchar(25) NOT NULL
);

CREATE TABLE contact_intrest (
    contact_id bigserial references my_contacts (contact_id),
    intrest_id integer references intrests (intrest_id)
);

CREATE TABLE contact_seeking (
    contact_id bigserial references my_contacts (contact_id),
    seeking_id integer references seeking (seeking_id)
);

CREATE TABLE intrests (
    intrest_id bigserial CONSTRAINT intrest_id_key PRIMARY KEY,
    intrest varchar(25) NOT NULL
);

CREATE TABLE seeking (
    seeking_id bigserial CONSTRAINT seeking_id_key PRIMARY KEY,
    seeking varchar(25) NOT NULL
);
