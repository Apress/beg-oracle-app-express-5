-- Create Users Table
CREATE TABLE tusers
(
  user_id       NUMBER (5, 0) PRIMARY KEY,
  user_name     VARCHAR2 (10) NOT NULL UNIQUE,
  password      VARCHAR2 (10) NOT NULL,
  active_flag   VARCHAR2 (1) NOT NULL
);

-- Create sequence for IDs
CREATE SEQUENCE sn_users;

-- Create Users
-- Note: You should not store passwords in clear text.
-- This was done for demonstration purposes.
INSERT INTO tusers ( user_id, user_name, password, active_flag)
     VALUES (sn_users.NEXTVAL, 'martin', 'martin', 'Y');

INSERT INTO tusers ( user_id, user_name, password, active_flag)
     VALUES (sn_users.NEXTVAL, 'chris', 'chris', 'Y');

INSERT INTO tusers ( user_id, user_name, password, active_flag)
     VALUES (sn_users.NEXTVAL, 'cameron', 'cameron', 'Y');

-- Authentication Function
CREATE OR REPLACE FUNCTION f_login (p_username IN VARCHAR2, p_password IN VARCHAR2)
  RETURN BOOLEAN
AS
  v_count   PLS_INTEGER;
BEGIN
  SELECT COUNT (user_id)
    INTO v_count
    FROM tusers
   WHERE LOWER (user_name) = LOWER (p_username)
     AND password = password
     AND active_flag = 'Y';

  IF v_count = 1 THEN
    RETURN TRUE;
  END IF;

  RETURN FALSE;
END f_login;
/

COMMIT;