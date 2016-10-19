CREATE OR REPLACE VIEW tickets_secure_v
AS
SELECT
  ticket_id,
  subject,
  descr,
  assigned_to,
  created_on,
  closed_on,
  created_by,
  status_id,
  last_updated,
  public_flag
FROM
  tickets
WHERE
  assigned_to = (SELECT v('APP_USER') FROM dual)
  OR assigned_to IS NULL
/

CREATE OR REPLACE VIEW ticket_activity_v
AS
SELECT
  td.ticket_id,
  td.created_on,
  t.assigned_to,
  td.details
FROM
  ticket_details td,
  tickets_secure_v t
WHERE
  t.ticket_id = td.ticket_id
UNION
SELECT
  ticket_id,
  created_on,
  assigned_to,
  descr details
FROM 
  tickets_secure_v
/

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
  tickets_secure_v t,
  (SELECT ticket_id, COUNT(ticket_id) number_of_details 
     FROM ticket_details GROUP BY ticket_id) td,
  status_lookup sl
WHERE
  t.status_id = sl.status_id
  AND t.ticket_id = td.ticket_id(+)
/