CREATE TABLE course (
  id int(11) NOT NULL AUTO_INCREMENT,
  course_id varchar(20) unique NOT NULL,
  course_name varchar(20) unique NOT NULL,
  course_descr varchar(60) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE course_duplicate (
  id int(11) NOT NULL AUTO_INCREMENT,
  course_id varchar(20) unique NOT NULL,
  course_name varchar(20) unique NOT NULL,
  course_descr varchar(60) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE course_events (
  id int(11) NOT NULL AUTO_INCREMENT,
  course_id varchar(20) unique NOT NULL,
  course_name varchar(20) unique NOT NULL,
  course_descr varchar(60) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE subject (
  id int(11) NOT NULL AUTO_INCREMENT,
  subject_id varchar(20) unique NOT NULL,
  subject_name varchar(20) unique NOT NULL,
  subject_descr varchar(60) NOT NULL,
  course_id varchar(20) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  KEY course_id (course_id),
  FOREIGN KEY (iduser) REFERENCES users (id),
  FOREIGN KEY (course_id) REFERENCES course (course_id)
);
CREATE TABLE subject_duplicate (
  id int(11) NOT NULL AUTO_INCREMENT,
  subject_id varchar(20) unique NOT NULL,
  subject_name varchar(20) unique NOT NULL,
  subject_descr varchar(60) NOT NULL,
  course_id varchar(20) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  KEY course_id (course_id),
  FOREIGN KEY (iduser) REFERENCES users (id),
  FOREIGN KEY (course_id) REFERENCES course (course_id)
);
CREATE TABLE subject_events (
  id int(11) NOT NULL AUTO_INCREMENT,
  subject_id varchar(20) unique NOT NULL,
  subject_name varchar(20) unique NOT NULL,
  subject_descr varchar(60) NOT NULL,
  course_id varchar(20) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  KEY course_id (course_id),
  FOREIGN KEY (iduser) REFERENCES users (id),
  FOREIGN KEY (course_id) REFERENCES course (course_id)
);
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE enrolled_students (
  id int(11) NOT NULL AUTO_INCREMENT,
  student_id varchar(20) unique NOT NULL,
  student_name varchar(20) unique NOT NULL,
  stundent_surname varchar(60) NOT NULL,
  birth_date date NOT NULL,
  residence varchar(100) NOT NULL,
  phone_1 varchar(20) NULL,  
  phone_2 varchar(20) NULL, 
  email varchar(40) NULL, 
  course_id varchar(40) NOT NULL, 
  course_level varchar(40) NOT NULL, 
  enroll_date datetime NOT NULL, 
  last_reenroll_date datetime NOT NULL, 
  student_status  varchar(40) NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  KEY course_id (course_id),
  FOREIGN KEY (iduser) REFERENCES users (id),
  FOREIGN KEY (course_id) REFERENCES courses (course_id)
);
CREATE TABLE enrolled_students_duplicate (
  id int(11) NOT NULL AUTO_INCREMENT,
  student_id varchar(20) unique NOT NULL,
  student_name varchar(20) unique NOT NULL,
  stundent_surname varchar(60) NOT NULL,
  birth_date date NOT NULL,
  residence varchar(100) NOT NULL,
  phone_1 varchar(20) NULL,  
  phone_2 varchar(20) NULL, 
  email varchar(40) NULL, 
  course_id varchar(40) NOT NULL, 
  course_level varchar(40) NOT NULL, 
  enroll_date datetime NOT NULL, 
  last_reenroll_date datetime NOT NULL, 
  student_status  varchar(40) NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  KEY course_id (course_id),
  FOREIGN KEY (iduser) REFERENCES users (id),
  FOREIGN KEY (course_id) REFERENCES courses (course_id)
);
CREATE TABLE enrolled_students_events (
  id int(11) NOT NULL AUTO_INCREMENT,
  student_id varchar(20) unique NOT NULL,
  student_name varchar(20) unique NOT NULL,
  stundent_surname varchar(60) NOT NULL,
  birth_date date NOT NULL,
  residence varchar(100) NOT NULL,
  phone_1 varchar(20) NULL,  
  phone_2 varchar(20) NULL, 
  email varchar(40) NULL, 
  course_id varchar(40) NOT NULL, 
  course_level varchar(40) NOT NULL, 
  enroll_date datetime NOT NULL, 
  last_reenroll_date datetime NOT NULL, 
  student_status  varchar(40) NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  KEY course_id (course_id),
  FOREIGN KEY (iduser) REFERENCES users (id),
  FOREIGN KEY (course_id) REFERENCES courses (course_id)
);

estudante
codigo_est,nome,apelido,data_nasc,morada,telfone1,telfone2,email,curso,ano_nivel,data_ins,data_ren,situacao

pagamentos
pag_nr,codigo_est,ref_pagamento,valor_div,valor_pag,mes,ano_nivel,tipo,talao,banco,tipo_descricao,apagado,apagado_descricao,aberto_ed
CREATE TABLE payments (
  id int(11) NOT NULL AUTO_INCREMENT,
  payment_nr varchar(20) unique NOT NULL,
  payment_ref varchar(60) NOT NULL,
  debt date NOT NULL,
  paymento_due varchar(100) NOT NULL,
  payment_month varchar(20) NULL,  
  level_year varchar(20) NULL, 
  pymnt_type varchar(40) NULL, 
  proof_of_payment varchar(40) NOT NULL, 
  deposit_bank varchar(40) NOT NULL, 
  description varchar(100) NULL, 
  removed varchar(50) NULL, 
  removed_description varchar(100) NULL,
  student_id varchar(20) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  KEY student_id (student_id),
  FOREIGN KEY (iduser) REFERENCES users (id),
  FOREIGN KEY (student_id) REFERENCES enrolled_students (student_id)
);
CREATE TABLE payments_duplicate (
  id int(11) NOT NULL AUTO_INCREMENT,
  payment_nr varchar(20) unique NOT NULL,
  payment_ref varchar(60) NOT NULL,
  debt date NOT NULL,
  paymento_due varchar(100) NOT NULL,
  payment_month varchar(20) NULL,  
  level_year varchar(20) NULL, 
  pymnt_type varchar(40) NULL, 
  proof_of_payment varchar(40) NOT NULL, 
  deposit_bank varchar(40) NOT NULL, 
  description varchar(100) NULL, 
  removed varchar(50) NULL, 
  removed_description varchar(100) NULL,
  student_id varchar(20) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  KEY student_id (student_id),
  FOREIGN KEY (iduser) REFERENCES users (id),
  FOREIGN KEY (student_id) REFERENCES enrolled_students (student_id)
);
CREATE TABLE payments_events (
  id int(11) NOT NULL AUTO_INCREMENT,
  payment_nr varchar(20) unique NOT NULL,
  payment_ref varchar(60) NOT NULL,
  debt date NOT NULL,
  paymento_due varchar(100) NOT NULL,
  payment_month varchar(20) NULL,  
  level_year varchar(20) NULL, 
  pymnt_type varchar(40) NULL, 
  proof_of_payment varchar(40) NOT NULL, 
  deposit_bank varchar(40) NOT NULL, 
  description varchar(100) NULL, 
  removed varchar(50) NULL, 
  removed_description varchar(100) NULL,
  student_id varchar(20) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  KEY student_id (student_id),
  FOREIGN KEY (iduser) REFERENCES users (id),
  FOREIGN KEY (student_id) REFERENCES enrolled_students (student_id)
);
cadeiras_estudante
id,codigo_est,cadeira,staff,staff_ed,dia_dig,dia_dig_ed,hora_dig,hora_dig_ed,username,username_ed,hostname,hostname_ed,macc,macc_ed
CREATE TABLE student_subjects (
  id int(11) NOT NULL AUTO_INCREMENT,
  subject_id varchar(60) NOT NULL,
  subject_name varchar(20) NOT NULL,
  student_id varchar(20) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY subject_id (subject_id),
  KEY iduser (iduser),
  KEY student_id (student_id),
  FOREIGN KEY (iduser) REFERENCES users (id),
  FOREIGN KEY (student_id) REFERENCES enrolled_students (student_id),
  FOREIGN KEY (subject_id) REFERENCES subjects (subject_id)
);

CREATE TABLE student_subjects_duplicate (
  id int(11) NOT NULL AUTO_INCREMENT,
  subject_id varchar(60) NOT NULL,
  subject_name varchar(20) NOT NULL,
  student_id varchar(20) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY subject_id (subject_id),
  KEY iduser (iduser),
  KEY student_id (student_id),
  FOREIGN KEY (iduser) REFERENCES users (id),
  FOREIGN KEY (student_id) REFERENCES enrolled_students (student_id),
  FOREIGN KEY (subject_id) REFERENCES subjects (subject_id)
);

CREATE TABLE student_subjects_events (
  id int(11) NOT NULL AUTO_INCREMENT,
  subject_id varchar(60) NOT NULL,
  subject_name varchar(20) NOT NULL,
  student_id varchar(20) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY subject_id (subject_id),
  KEY iduser (iduser),
  KEY student_id (student_id),
  FOREIGN KEY (iduser) REFERENCES users (id),
  FOREIGN KEY (student_id) REFERENCES enrolled_students (student_id),
  FOREIGN KEY (subject_id) REFERENCES subjects (subject_id)
);



