drop database if exists mhp;

create database if not exists mhp;

use mhp;

drop table if exists patient;
create table patient
(
	patient_id int primary key auto_increment,
    patient_first_name varchar(75) not null,
    patient_last_name varchar(75) not null,
    patient_dob date not null,
    is_diagnosed tinyint not null default 0
);

drop table if exists provider;
create table provider
(
	provider_id int primary key auto_increment,
    provider_first_name varchar(75) not null,
    provider_last_name varchar(75) not null,
    provider_specialty ENUM("Anxiety", "Trauma", "Depressive", "Psychotic", "Mood", "Eating", "Personality"),
    provider_type ENUM("Therapist", "Doctor", "Psychiatrist", "Psychologist", "Child Psychologist", "Psychotherapist") not null
);

drop table if exists disorder;
create table disorder
(
	disorder_id int primary key auto_increment,
    disorder_name varchar(75) not null,
    disorder_class ENUM("Anxiety", "Trauma", "Psychotic", "Mood", "Eating", "Personality", "Depressive") not null
);

drop table if exists symptom;
create table symptom 
(
	symptom_id int primary key auto_increment,
    symptom_name varchar(45) not null
);

drop table if exists disorder_has_symptom;
create table disorder_has_symptom
(
	symptom_id int,
    disorder_id int,
    constraint symptom_id foreign key (symptom_id) references symptom(symptom_id),
    constraint disorder_id_4 foreign key (disorder_id) references disorder(disorder_id),
    primary key (symptom_id, disorder_id)
);

drop table if exists treatment;
create table treatment
(
	treatment_id int primary key auto_increment,
    treatment_name varchar(75) not null,
    treatment_type ENUM("Pharmaceutical", "Therapy") not null
);

drop table if exists diagnosis;
create table diagnosis
(
	patient_id int,
    disorder_id int,
    constraint patient_id foreign key (patient_id) references patient(patient_id),
    constraint disorder_id foreign key (disorder_id) references disorder(disorder_id),
    primary key(patient_id, disorder_id)
);

drop table if exists appointment;
create table appointment
(
	appointment_id int primary key auto_increment,
    appointment_date datetime not null,
    appointment_notes varchar(250) not null,
    patient_id int,
    provider_id int,
    constraint patient_id_2 foreign key (patient_id) references patient(patient_id),
    constraint provider_id foreign key (provider_id) references provider(provider_id)
);

drop table if exists treatment_for_disorder;
create table treatment_for_disorder
(
	treatment_id int,
    disorder_id int,
    constraint treatment_id foreign key (treatment_id) references treatment(treatment_id),
	constraint disorder_id_2 foreign key (disorder_id) references disorder(disorder_id),
    primary key (treatment_id, disorder_id)
);

drop table if exists prescribed_treatment;
create table prescribed_treatment
(
    patient_id int,
    provider_id int,
    treatment_id int,
    disorder_id int,
    constraint patient_id_3 foreign key (patient_id) references patient(patient_id),
    constraint provider_id_2 foreign key (provider_id) references provider(provider_id),
    constraint treatment_id_2 foreign key (treatment_id) references treatment(treatment_id),
	constraint disorder_id_3 foreign key (disorder_id) references disorder(disorder_id),
    primary key (patient_id, provider_id, treatment_id, disorder_id)
);

-- populating the tables

INSERT INTO patient (patient_first_name, patient_last_name, patient_dob) VALUES
("John", "Rachlin", "2000-01-01"),
("Anna", "Ryan", "2005-05-16"),
("Casey", "Benzing", "2004-09-18"),
("Camille", "Dupuy", "2007-02-03"),
("Zachariah", "Rasheed", "2004-11-27"),
("Dijon", "MacFarlane", "1990-06-05"),
("Leonardo", "DaVinci", "1987-12-10"),
("Matthew", "Murdock", "1985-10-21"),
("Theodore", "Rasheed", "2015-08-08");

INSERT INTO provider (provider_first_name, provider_last_name, provider_specialty, provider_type) VALUES
("Singed", "Revik", "Anxiety", "Therapist"),
("Cecil", "Heimerdinger", "Depressive", "Doctor"),
("Junger", "Rampe", "Mood", "Psychiatrist"),
("Violet", "Kiramann", "Trauma", "Child Psychologist"),
("Ekko", "Powder", "Personality", "Psychologist"),
("Mel", "Medarda", null, "Psychotherapist");


INSERT INTO disorder (disorder_name, disorder_class) VALUES
("Generalized Anxiety Disorder", "Anxiety"),
("Major Depressive Disorder", "Depressive"),
("Post-Traumatic Stress Disorder", "Trauma"),
("Schizophrenia", "Psychotic"),
("Bipolar Disorder", "Mood"),
("Obsessive Compulsive Disorder", "Anxiety"),
("Anorexia Nervosa", "Eating"),
("Panic Disorder", "Anxiety"),
("Antisocial Personality Disorder", "Personality"),
("Dependent Personality Disorder", "Personality");

INSERT INTO symptom (symptom_name) VALUES
("Worrying"), ("Restlessness"), ("Fatigue"),
("Headaches"), ("Sweating"), ("Panic"),
("Persistent Low Mood"), ("Loss of Interest"), 
("Change in Sleep"), ("Change in Appetite"),
("High Reactivity"), ("Feeling on Edge"),
("Avoidance"), ("Social Isolation"), ("Hallucinations"),
("Delusions"), ("Disorganized Behavior"), ("Cognitive Impairment"),
("Manic Episode"), ("Depressive Episodes"), ("Change in Mood"),
("Uncontrollable Thoughts and Urges"), ("Persistent Fearful Imagery"),
("Obsessions"), ("Compulsions"), ("Low Body Weight"), ("Fear of Weight Gain"),
("Body Dysmorphia"), ("Food Fixation"), ("Chronic Panic Attacks"), ("Sweating"),
("Trembling"), ("Fear of Future Panic Attacks"), ("Manipulation"), ("Aggression"),
("Lack of Remorse"), ("Disregard for Others"), ("Difficulty Making Decisions"),
("Fear of Abandonment"), ("Low Self Esteem"), ("Passive Behavior");

INSERT INTO disorder_has_symptom (disorder_id, symptom_id) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (2, 7), (2, 8), 
(2, 9), (2, 10), (3, 11), (3, 12), (3, 13), (3, 14), (3, 8),
(4, 15), (4, 16), (4, 17), (4, 18), (4, 14), (5, 19), (5, 20),
(5, 21), (5, 9), (6, 22), (6, 23), (6, 24), (6, 25), (7, 26),
(7, 27), (7, 28), (7, 29), (7, 40), (8, 30), (8, 31), (8, 32), 
(8, 33),(8, 13), (9, 34), (9, 35), (9, 36), (9, 37), (10, 38), 
(10, 39),(10, 40), (10, 41);

INSERT INTO treatment (treatment_name, treatment_type) VALUES
("SSRI", "Pharmaceutical"),
("Dialectical Behavioral Therapy", "Therapy"),
("Adderall", "Pharmaceutical"),
("Cognitive Behavioral Therapy", "Therapy"),
("Exposure Therapy", "Therapy"),
("Mood Stabilizers", "Pharmaceutical");

INSERT INTO treatment_for_disorder (treatment_id, disorder_id) VALUES
(1, 2),
(4, 1),
(6, 5),
(4, 6),
(5, 8),
(4, 2),
(4, 3),
(5, 3);

INSERT INTO appointment (appointment_date, appointment_notes, provider_id, patient_id) VALUES
("2024-11-25 13:35:00", "Patient feeling anxious", 4, 4),
("2024-11-25 15:15:00", "Patient experiencing stress", 4, 2),
("2024-12-29 15:15:00", "follow up on 11/25 appointment", 4, 2),
("2024-11-25 11:00:00", "Therapy appointment", 1, 3);

INSERT INTO diagnosis (patient_id, disorder_id) VALUES
(4, 3);

INSERT INTO prescribed_treatment (patient_id, provider_id, treatment_id, disorder_id) VALUES
(4, 4, 4, 3),
(4, 4, 5, 3);

-- Querying the Database

-- List all disorders and their symptoms
select 
	disorder_name, symptom_name
from disorder dis
join disorder_has_symptom dhs on dis.disorder_id = dhs.disorder_id
join symptom s on dhs.symptom_id = s.symptom_id;

-- what disorders might a patient with symptom: "Loss of Interest" have?
select 
	disorder_name
from disorder dis
join disorder_has_symptom dhs on dis.disorder_id = dhs.disorder_id
join symptom s on dhs.symptom_id = s.symptom_id
where s.symptom_name = "Loss of Interest";

-- what class of disorders tends to cause the symptom "Change in sleep"?
select 
	disorder_class, count(*) as num_disorders
from disorder dis
join disorder_has_symptom dhs on dis.disorder_id = dhs.disorder_id
join symptom s on dhs.symptom_id = s.symptom_id
where s.symptom_name = "Change in sleep"
group by disorder_class;

-- how many disorders are in each class?
select 
	disorder_class, count(*) as num_disorders
from disorder
group by disorder_class;

-- if someone had generalized anxiety disorder, what provider might be useful to them?
select 
	provider_first_name,
    provider_last_name,
    provider_specialty,
    provider_type
from disorder dis join provider prv on dis.disorder_class = prv.provider_specialty
where dis.disorder_name = "Generalized Anxiety Disorder";

-- what treatments are available for someone with MDD?
select 
	treatment_name,
    treatment_type
from disorder dis
join treatment_for_disorder trdis on dis.disorder_id = trdis.disorder_id
join treatment tr on tr.treatment_id = trdis.treatment_id
where dis.disorder_name = "Major Depressive Disorder";

-- is there an association between disorder class and treatment type?
select
	disorder_class,
    treatment_type,
	count(*) as "associations"
from disorder dis
join treatment_for_disorder trdis on dis.disorder_id = trdis.disorder_id
join treatment tr on tr.treatment_id = trdis.treatment_id
group by disorder_class, treatment_type;

-- what is the schedule on 11/25
select 
	TIME(appointment_date) as time,
    appointment_notes,
    provider_first_name,
    provider_last_name,
    patient_first_name,
    patient_last_name
from appointment a
join patient pat on pat.patient_id = a.patient_id 
join provider prv on prv.provider_id = a.provider_id
where DATE(appointment_date) = "2024-11-25"
order by provider_last_name, provider_first_name, time;

-- what treatments have been prescribed to patient "Camille Dupuy", by what providers and for what
select 
	treatment_name,
    disorder_name,
	provider_first_name,
    provider_last_name
from prescribed_treatment prtr
join patient pat on pat.patient_id = prtr.patient_id
join provider prv on prv.provider_id = prtr.provider_id
join treatment tr on tr.treatment_id = prtr.treatment_id
join disorder dis on dis.disorder_id = prtr.disorder_id
where pat.patient_first_name = "Camille" and pat.patient_last_name = "Dupuy";

-- what patients have diagnoses?
select
	pat.patient_id,
	patient_first_name,
    patient_last_name
from patient pat
join diagnosis dis on dis.patient_id = pat.patient_id;

-- list all upcoming appointments
select
	*
from appointment
where appointment_date > NOW();

-- A stored procedure that screens a potential client for any mental health disorders
-- The procedure then creates an appointment for the patient based on the results of their screening


DROP PROCEDURE IF EXISTS screening;

delimiter //
CREATE PROCEDURE screening
(
	IN patient_first_name_param VARCHAR(75),
	IN patient_last_name_param VARCHAR(75),
    IN symptom_param VARCHAR(75),
    IN appointment_date_param DATETIME
)
BEGIN

	-- declaring variables

	DECLARE patient_id_var INT;
    DECLARE provider_id_var INT;
    DECLARE potential_disorder_class_var VARCHAR(75);
    DECLARE potential_disorder_name_var VARCHAR(75);
    DECLARE appointment_notes_var VARCHAR(250);
    DECLARE provider_name_var VARCHAR(150);
    DECLARE patient_age_var DATE;
    
    -- declare potential_disorder_name_var2 varchar(50);
    -- declare potential_disorder_name_var3 varchar(50);
    
    -- selecting relevant data
    
    SELECT
		pat.patient_id,
        d.disorder_name,
        d.disorder_class,
        pat.patient_dob
    INTO
		patient_id_var,
        potential_disorder_name_var,
        potential_disorder_class_var,
        patient_age_var
	FROM disorder_has_symptom ds
		JOIN disorder d USING (disorder_id)
		JOIN symptom s USING (symptom_id)
		JOIN patient pat
	WHERE s.symptom_name = (symptom_param)
    AND pat.patient_last_name = patient_last_name_param
    AND pat.patient_first_name = patient_first_name_param
    LIMIT 1;
    
    -- finding the proper provider for someone with the inputted symptoms
    
    SET provider_id_var = find_best_provider(potential_disorder_class_var);
    SET provider_name_var = find_provider_name(provider_id_var);

    -- checking that the proper provider is appropriate for the patient's age
    -- if they are not, the patient is sent to a general psychotherapist
    
    IF TIMESTAMPDIFF(year, patient_age_var, now()) > 18 AND (provider_name_var = "Child Psychologist Kiramann") THEN
		SELECT CONCAT(patient_first_name_param, " ", patient_last_name_param, " is too old to be seen by ", provider_name_var, 
        " so they have been referred to a general psychotherapist!") as message;
        SET provider_id_var = 6;
        SET provider_name_var = find_provider_name(6);
	END IF;
    
    -- concatenating the appointment notes based on the potential diagnosis
    
    SET appointment_notes_var = CONCAT(patient_first_name_param, " ", patient_last_name_param, " has screened positive for " 
									,potential_disorder_name_var, " and has been scheduled to see "
                                    ,provider_name_var);
    SELECT appointment_notes_var AS "message";
    
    -- creating the appointment at the time provided, using notes based on the potential diagnosis
    
    INSERT INTO appointment (appointment_date, appointment_notes, patient_id, provider_id) 
    VALUES (appointment_date_param, appointment_notes_var, patient_id_var, provider_id_var);

END//

DELIMITER ;

-- This function is used to find the best provider based on a given disorder class.
-- If there is no provider that specializes in that type of disorder, they are
-- assigned to a general psychotherapist.

DROP FUNCTION IF EXISTS find_best_provider;

DELIMITER //

CREATE FUNCTION find_best_provider
(
	disorder_class_input VARCHAR(50)
)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE output INT;
    
    SELECT 
		prov.provider_id
    INTO output
    FROM provider prov
		JOIN disorder d
	WHERE prov.provider_specialty = disorder_class_input
    LIMIT 1;

	IF output IS NULL THEN
		RETURN 6;
    END IF;
    
    RETURN output;
    
END //

DELIMITER ;

-- this function is used to take a provider's id and return their name
-- It is required for the screening function since this selection must
-- run after the initial select, which is responsible for finding a 
-- possible diagnosis

DROP FUNCTION IF EXISTS find_provider_name;

DELIMITER //

CREATE FUNCTION find_provider_name
(
	provider_id_input INT
)
RETURNS VARCHAR(150)
DETERMINISTIC
BEGIN
	DECLARE provider_last_name_var VARCHAR(75);
    DECLARE provider_type_var VARCHAR(75);
    
    SELECT 
		prov.provider_last_name,
        prov.provider_type
    INTO 
		provider_last_name_var,
        provider_type_var
    FROM provider prov
	WHERE prov.provider_id = provider_id_input;
    
    RETURN CONCAT(provider_type_var, " " ,provider_last_name_var);
    
END //

DELIMITER ;

-- creating the trigger that updates a patient's diagnosis status and appointment notes when they are diagnosed with a disorder

DROP TRIGGER IF EXISTS patient_update_after_diagnosis;

DELIMITER //
	
CREATE TRIGGER patient_update_after_diagnosis 
	AFTER INSERT ON diagnosis
	FOR EACH ROW
BEGIN
    
	-- The patient has been diagnosed with a disorder
    -- This trigger will update their diagnosis status
    -- as well as update their appointment notes

    -- IF NEW.patient_id IS NOT NULL AND OLD.patient_id IS NULL THEN
		UPDATE patient p
        SET p.is_diagnosed = 1
        WHERE p.patient_id = NEW.patient_id;
        
        UPDATE appointment a
        SET a.appointment_notes = CONCAT(a.appointment_notes, ". Update: Successful diagnosis was made.")
        WHERE a.patient_id = NEW.patient_id;
    -- END IF;

END //

DELIMITER ;

-- TESTING THE SCREENING PROCEDURE --

-- this patient should screen positive for Major Depressive Disorder (and be assigned to the corresponding specialist)
CALL screening("Matthew", "Murdock", "Loss of interest", "2025-01-01 13:30:00");

-- this patient should screen positive for Obsessive Compulsive Disorder (and be assigned to the corresponding specialist)
CALL screening("Leonardo", "Davinci", "Compulsions", "2025-02-02 14:45:00");

-- this patient should screen positive for Antisocial Personality Disorder (and be assigned to the corresponding specialist)
CALL screening("Dijon", "MacFarlane", "Disregard for Others", "2025-03-03 09:00:00");

-- this patient should screen positive for Schizophrenia (and be assigned to a general psychotherapist)
CALL screening("Zachariah", "Rasheed", "Hallucinations", "2024-12-31 11:59:59");

-- this patient should screen positive for Anorexia Nervosa (and be assigned to a general psychotherapist)
CALL screening("Anna", "Ryan", "Food fixation", "2025-04-04 17:16:15");

-- this patient should screen positive for PTSD (and be assigned to the corresponding specialist)
CALL screening("Theodore", "Rasheed", "High reactivity", "2025-05-05 05:05:05");

-- this patient should screen positive for PTSD, but is too old to be assigned to a child psychologist,
-- so they are deferred to a general psychotherapist
CALL screening("Zachariah", "Rasheed", "High reactivity", "2025-08-08 08:08:08");

-- TESTING THE TRIGGER -- 

-- a diagnosis is made for Dijon Macfarlane after his appointment
INSERT INTO diagnosis ()
VALUES (6, 9);

SELECT a.appointment_notes
FROM appointment a
WHERE patient_id = 6;

SELECT *
FROM patient
WHERE patient_id = 6;


-- code to reset Dijon's diagnosis (for testing purposes)
UPDATE patient p
SET p.is_diagnosed = 0
WHERE patient_id = 6;

truncate diagnosis;

-- code to truncate appointment  (to reset Dijon's appointment notes)
truncate appointment;


