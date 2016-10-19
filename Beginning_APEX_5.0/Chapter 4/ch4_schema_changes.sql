-- Update the CREATED_ON and CLOSED_ON values so that they are current
update tickets set 
  created_on = to_date((to_char(sysdate - rownum, 'DD-MON-YY') 
  || ' 12:00PM'),'DD-MON-YY HH:MIPM')
/

update tickets set 
  closed_on = to_date((to_char(sysdate - rownum, 'DD-MON-YY') 
  || ' 12:00PM'),'DD-MON-YY HH:MIPM')
  where closed_on is not null
/

update ticket_details set 
  created_on = to_date((to_char(sysdate - rownum, 'DD-MON-YY') 
  || ' 12:00PM'),'DD-MON-YY HH:MIPM')
/

-- Add a BLOB column and its supporting columns to TICKET_DETAILS
ALTER TABLE ticket_details ADD file_name VARCHAR2(255)
/
ALTER TABLE ticket_details ADD mime_type VARCHAR2(255)
/
ALTER TABLE ticket_details ADD attachment BLOB
/

-- Re-create the sequence for TICKETS and TICKET_DETAILS
drop sequence tickets_seq
/
create sequence tickets_seq start with 21
/
drop sequence ticket_details_seq
/
create sequence ticket_details_seq start with 25
/

-- Re-create the trigger on TICKETS to include CREATED_ON population
CREATE OR REPLACE TRIGGER  "bi_TICKETS" 
  before insert on "TICKETS"              
  for each row 
begin  
  if :new."TICKET_ID" is null then
    select "TICKETS_SEQ".nextval into :new."TICKET_ID" from dual;
  end if;
  :new.created_on := SYSDATE;
end;

/
ALTER TRIGGER  "bi_TICKETS" ENABLE
/

-- Add new function used to return the STATUS_ID for a given STATUS
CREATE OR REPLACE FUNCTION get_status
  (p_status                  IN VARCHAR2)
RETURN NUMBER
IS
  l_status_id                status_lookup.status_id%TYPE;
BEGIN
  SELECT status_id INTO l_status_id FROM status_lookup
    WHERE status = p_status;
  RETURN l_status_id;
END get_status;
/

-- Create a view to be used with the Interactive Reports
CREATE OR REPLACE VIEW tickets_v
AS
SELECT
  t.ticket_id,
  t.subject,
  t.descr description,
  t.assigned_to,
  t.created_on,
  t.created_by,
  t.closed_on,
  sl.status,
  td.number_of_details
FROM
  tickets t,
  (SELECT ticket_id, COUNT(ticket_id) number_of_details 
     FROM ticket_details GROUP BY ticket_id) td,
  status_lookup sl
WHERE
  t.status_id = sl.status_id
  AND t.ticket_id = td.ticket_id(+)
/

-- Create views for the Calendar Report
CREATE OR REPLACE VIEW ticket_activity_v
AS
SELECT
  td.ticket_id,
  td.created_on,
  t.assigned_to,
  td.details
FROM
  ticket_details td,
  tickets t
WHERE
  t.ticket_id = td.ticket_id
UNION
SELECT
  ticket_id,
  created_on,
  assigned_to,
  descr details
FROM 
  tickets
/

CREATE VIEW ticket_activity_summary_v
AS
SELECT
  created_on,
  count(created_on) || ' Events' details
FROM
(
  SELECT
    created_on
  FROM
    ticket_activity_v
)
GROUP BY
  created_on
/

-- Create a wrapper procedure for apex_mail
create or replace procedure contact_us
  (
  p_from IN VARCHAR2,
  p_body IN VARCHAR2
  )
AS
BEGIN
apex_mail.send(
  p_from => p_from,
  p_to => 'info@sumneva.com',
  p_subj => 'Message from the APEX Issue Tracker',
  p_body => p_body,
  p_body_html => p_body);
END contact_us;
/
