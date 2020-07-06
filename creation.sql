CREATE TABLE ARTIST (
	name		VARCHAR2(100),
	CONSTRAINT PK_ARTIST PRIMARY KEY (name));

CREATE TABLE MEMBER (
	name		VARCHAR2(100),
	role		VARCHAR2(100),
	nationality	VARCHAR2(100),
	language	VARCHAR2(100),
	artist		VARCHAR2(100),
	CONSTRAINT PK_MEMBER PRIMARY KEY(name, role),
	CONSTRAINT FK_MEMBER FOREIGN KEY(artist) REFERENCES ARTIST ON DELETE CASCADE,
	CONSTRAINT UQ_MEMBER UNIQUE (name, artist));

CREATE TABLE RECORD_COMPANY (
	name		VARCHAR2(100),
	phone		NUMBER(9),
	CONSTRAINT CQ_RCPHONE CHECK (phone>=100000000 AND phone<1000000000),
	CONSTRAINT PK_COMPANY PRIMARY KEY (name));

CREATE TABLE MANAGER (
	name		VARCHAR2(100),
	surname1	VARCHAR2(100),
	surname2	VARCHAR2(100),
	phone		NUMBER(9),
	CONSTRAINT CQ_MGPHONE CHECK (phone>=100000000 AND phone<1000000000),
	CONSTRAINT PK_MANAGER PRIMARY KEY (phone));

CREATE TABLE RECORDING_STUDIO (
	name		VARCHAR2(100),
	address		VARCHAR2(200),
	tech_name	VARCHAR2(100),
	tech_surn1	VARCHAR2(100),
	tech_surn2	VARCHAR2(100),
	CONSTRAINT PK_STUDIO PRIMARY KEY (name, tech_name, tech_surn1));

CREATE TABLE COVER (
	company		VARCHAR2(100),
	address		VARCHAR2(100),
	CONSTRAINT PK_COVER PRIMARY KEY (company));

CREATE TABLE BACK_COVER (
	company		VARCHAR2(100),
	address		VARCHAR2(100),
	CONSTRAINT PK_BCOVER PRIMARY KEY (company));

CREATE TABLE ALBUM_SINGLE (
	isvn		NUMBER(8),
	name		VARCHAR2(100) NOT NULL,
	rot_speed	VARCHAR2(100),
	hole_size	VARCHAR2(100),
	artist		VARCHAR2(100) NOT NULL,
	company		VARCHAR2(100),
	launch_date	DATE,
	peak		NUMBER(3),
	weeks_peak	NUMBER(2),
	man_phone	NUMBER(9),
	studio_name	VARCHAR2(100),
	name_tech	VARCHAR2(100),
	surname_tech	VARCHAR2(100),
	cover_comp	VARCHAR2(100),
	cover_photogr	VARCHAR2(100),
	cover_drafts	VARCHAR2(100),
	cover_layout	VARCHAR2(100),
	back_comp	VARCHAR2(100),
	back_photogr	VARCHAR2(100),
	back_drafts	VARCHAR2(100),
	back_layout	VARCHAR2(100),
	CONSTRAINT CQ_PHONEASIN CHECK (man_phone>=100000000 AND man_phone<1000000000),
	CONSTRAINT PK_SIN PRIMARY KEY (isvn, peak, weeks_peak),
	CONSTRAINT FK_SIN1 FOREIGN KEY (artist) REFERENCES ARTIST ON DELETE CASCADE,
	CONSTRAINT FK_SIN2 FOREIGN KEY (company) REFERENCES RECORD_COMPANY,
	CONSTRAINT FK_SIN3 FOREIGN KEY (man_phone) REFERENCES MANAGER,
	CONSTRAINT FK_SIN4 FOREIGN KEY (studio_name, name_tech, surname_tech) REFERENCES RECORDING_STUDIO,
	CONSTRAINT FK_SIN5 FOREIGN KEY (cover_comp) REFERENCES COVER,
	CONSTRAINT FK_SIN6 FOREIGN KEY (back_comp) REFERENCES BACK_COVER);

CREATE TABLE ALBUM_LP (
	isvn		NUMBER(8),
	name		VARCHAR2(100) NOT NULL,
	rot_speed	VARCHAR2(100),
	hole_size	VARCHAR2(100),
	artist		VARCHAR2(100) NOT NULL,
	company		VARCHAR2(100),
	launch_date	DATE,
	copies_launch	NUMBER (8),
	copies_total	NUMBER (8),
	man_phone	NUMBER(9),
	studio_name	VARCHAR2(100),
	name_tech	VARCHAR2(100),
	surname_tech	VARCHAR2(100),
	cover_comp	VARCHAR2(100),
	cover_photogr	VARCHAR2(100),
	cover_drafts	VARCHAR2(100),
	cover_layout	VARCHAR2(100),
	back_comp	VARCHAR2(100),
	back_photogr	VARCHAR2(100),
	back_drafts	VARCHAR2(100),
	back_layout	VARCHAR2(100),
	CONSTRAINT CQ_PHONEALP CHECK (man_phone>=100000000 AND man_phone<1000000000),
	CONSTRAINT PK_LP PRIMARY KEY (isvn),
	CONSTRAINT FK_LP1 FOREIGN KEY (artist) REFERENCES ARTIST ON DELETE CASCADE,
	CONSTRAINT FK_LP2 FOREIGN KEY (company) REFERENCES RECORD_COMPANY,
	CONSTRAINT FK_LP3 FOREIGN KEY (man_phone) REFERENCES MANAGER,
	CONSTRAINT FK_LP4 FOREIGN KEY (studio_name, name_tech, surname_tech) REFERENCES RECORDING_STUDIO,
	CONSTRAINT FK_LP5 FOREIGN KEY (cover_comp) REFERENCES COVER,
	CONSTRAINT FK_LP6 FOREIGN KEY (back_comp) REFERENCES BACK_COVER);

CREATE TABLE SONG_LP (
	title		VARCHAR2(500),
	side		VARCHAR2(6), 
	track		NUMBER(2),
	length		VARCHAR(5), 
	author		VARCHAR2(100),
	album		NUMBER(8),
	CONSTRAINT CQ_SIDELP CHECK (side IN ('Side A', 'Side B')),
	CONSTRAINT PK_SONGLP PRIMARY KEY (title, album, side, track),
	CONSTRAINT FK_SONGLP FOREIGN KEY (album) REFERENCES ALBUM_LP);

CREATE TABLE SONG_SINGLE (
	title		VARCHAR2(500),
	side		VARCHAR2(6), 
	track		NUMBER(2),
	length		VARCHAR(5), 
	author		VARCHAR2(100),
	album		NUMBER(8),
	peak		NUMBER(3),
	weeks_peak	NUMBER(2),
	CONSTRAINT CQ_SIDESIN CHECK (side IN ('Side A', 'Side B')),
	CONSTRAINT PK_SONGSIN PRIMARY KEY (title, album, side, track),
	CONSTRAINT FK_SONGSIN FOREIGN KEY (album, peak, weeks_peak) REFERENCES ALBUM_SINGLE);

CREATE TABLE RADIO_STATION (
	name		VARCHAR2(100),
	address		VARCHAR2(100),
	url		VARCHAR2(200),
	email		VARCHAR2(100),
	phone		VARCHAR2(100),
	CONSTRAINT PK_RAD PRIMARY KEY (name));

CREATE TABLE RADIO_HITS (
	title		VARCHAR2(500) DEFAULT 'Moments',
	interpreter	VARCHAR2(100) DEFAULT 'Golondrinajes',	
	isvn		NUMBER(8),
	peak		NUMBER(3),
	weeks_peak	NUMBER(2),
	emission	DATE,
	time		VARCHAR2(5),
	radio		VARCHAR2(100),
	CONSTRAINT PK_HITS PRIMARY KEY (title, isvn, peak, weeks_peak, interpreter, emission, time),
	CONSTRAINT FK_HITS1 FOREIGN KEY (isvn, peak, weeks_peak) REFERENCES ALBUM_SINGLE,
	CONSTRAINT FK_HITS2 FOREIGN KEY (radio) REFERENCES RADIO_STATION);

CREATE TABLE CLIENT (
	name		VARCHAR2(100),
	surn1		VARCHAR2(100),
	surn2		VARCHAR2(100),
	id		NUMBER(8),
	birth		DATE,
	phone		NUMBER(9),
	email		VARCHAR2(100),
	address		VARCHAR2(100),
	CONSTRAINT CQ_CLPHONE CHECK (phone>=100000000 AND phone<1000000000),
	CONSTRAINT PK_CLIENT PRIMARY KEY (id, phone));

CREATE TABLE PURCH (
	dni		NUMBER(8),
	phone		NUMBER(9),
	isvn		NUMBER(8),
	artist 		VARCHAR2(100),
	date_order	DATE,
	date_del	DATE, 
	CONSTRAINT CQ_PURCHPHONE CHECK (phone>=100000000 AND phone<1000000000),
	CONSTRAINT CQ_DATE CHECK (date_del >= date_order),
	CONSTRAINT PK_PURCH PRIMARY KEY (dni, phone, isvn, artist, date_order, date_del),
	CONSTRAINT FK_PURCH1 FOREIGN KEY (dni, phone) REFERENCES CLIENT,
	CONSTRAINT FK_PURCH2 FOREIGN KEY (isvn) REFERENCES ALBUM_LP);
