create or replace function hash_password
  (p_user_name in varchar2, p_password in varchar2)
return varchar2
is
  l_password        varchar2(255);
  l_salt            varchar2(255) := '2345USFGOJN2T3HW89EFGOBN23R5SDFGAKL';
begin
l_password := 
  utl_raw.cast_to_raw
    (dbms_obfuscation_toolkit.md5
      (input_string => p_password || substr(l_salt,4,14) ||
       p_user_name || substr(l_salt,5,10))
    );
return l_password;
end hash_password;
/

create table users
(
 user_id               number              primary key,
 user_name             varchar2(255)       not null,
 password              varchar2(255)       not null
)
/

create sequence users_seq start with 1
/

create or replace trigger bi_users
  before insert on users
  for each row
begin
  select users_seq.nextval into :new.user_id from dual;
  :new.user_name := upper(:new.user_name);
  :new.password := hash_password(upper(:new.user_name), :new.password);
end;
/

create or replace trigger bu_users
  before update on users
  for each row
begin
  :new.user_name := upper(:new.user_name);
  if :new.password is not null then
    :new.password := hash_password(upper(:new.user_name), :new.password);
  else
    :new.password := :old.password;
  end if;
end;
/

create or replace function authenticate_user
  (p_username in varchar2, p_password in varchar2)
return boolean
is
  l_user_name       users.user_name%type    := upper(p_username);
  l_password        users.password%type;
  l_hashed_password varchar2(1000);
  l_count           number;
begin

-- First, check to see if the user exists
select count(*) into l_count from users
  where user_name = l_user_name;

if l_count > 0 then
  -- Hash the password provided
  l_hashed_password := hash_password(l_user_name, p_password);
 
  -- Get the stored password
  select password into l_password from users where user_name = l_user_name;
  
  -- Compare the two, and if there is a match, return TRUE
  if l_hashed_password = l_password then
    return true;
  else
    return false;
  end if;
  
else
  -- The username does not exist
  return false;
end if;
return true;

end authenticate_user;
/


insert into users (user_name, password) values ('SCOTT', 'apress')
/
insert into users (user_name, password) values ('DOUG', 'apress')
/
insert into users (user_name, password) values ('KAREN', 'apress')
/
insert into users (user_name, password) values ('MARTIN', 'apress')
/
insert into users (user_name, password) values ('PATRICK', 'apress')
/
insert into users (user_name, password) values ('TIM', 'apress')
/
commit
/
