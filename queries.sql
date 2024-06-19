/*View the list of available workspaces for a room in a
session x.*/

SELECT w.workspace_id, w.row_number, w.column_number, w.workspace_type, w.has_power_outlet
FROM Workspaces w
LEFT JOIN Reservations r ON w.workspace_id = r.workspace_id
WHERE r.session_id = 72 
  AND (r.reservation_id IS NULL OR r.status = 'cancelled'); 

/*View the list of occupied workspaces for a room in a
session x.*/

SELECT w.workspace_id, w.row_number, w.column_number, w.workspace_type, w.has_power_outlet
FROM Workspaces w
LEFT JOIN Reservations r ON w.workspace_id = r.workspace_id
WHERE r.session_id = 72 
  AND (r.status = 'confirmed'); 


/*View the sessions in order of the busiest.*/
SELECT s.session_id, s.session_name, s.start_time, s.end_time, s.max_capacity,
       COUNT(r.reservation_id) AS total_persons
FROM Sessions s
LEFT JOIN Reservations r ON s.session_id = r.session_id AND r.status = 'confirmed'
GROUP BY s.session_id, s.session_name, s.start_time, s.end_time, s.max_capacity
ORDER BY total_persons DESC;

/*View the sessions in order by the most available.*/

SELECT s.session_id, s.session_name, s.start_time, s.end_time, s.max_capacity,
       s.max_capacity - COUNT(r.reservation_id) AS available_capacity
FROM Sessions s
LEFT JOIN Reservations r ON s.session_id = r.session_id AND r.status = 'confirmed'
GROUP BY s.session_id, s.session_name, s.start_time, s.end_time, s.max_capacity
ORDER BY available_capacity DESC;

/*View the list of workspaces assigned to a user.*/

SELECT u.user_id, u.username, w.workspace_id, w.row_number, w.column_number, w.workspace_type
FROM Users u
JOIN Reservations r ON u.user_id = r.user_id
JOIN Workspaces w ON r.workspace_id = w.workspace_id
WHERE u.user_id = 50;

/*View the list of workspaces assigned to a session.*/

SELECT s.session_id, s.session_name, w.workspace_id, w.row_number, w.column_number, w.workspace_type
FROM Sessions s
JOIN Reservations r ON s.session_id = r.session_id
JOIN Workspaces w ON r.workspace_id = w.workspace_id
WHERE s.session_id = 72;
