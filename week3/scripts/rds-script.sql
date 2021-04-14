create user aws_4_dev_user with encrypted password 'qwerty';
create database aws_4_dev;
grant all privileges on database aws_4_dev to aws_4_dev_user;
\c aws_4_dev
CREATE TABLE accounts (
	user_id serial PRIMARY KEY,
	username VARCHAR ( 50 ) UNIQUE NOT NULL,
	email VARCHAR ( 255 ) UNIQUE NOT NULL
);
insert into accounts (username, email) values
('vasya', 'vasya@i.ua'),
('petya', 'petya@i.ua');
select * from accounts;