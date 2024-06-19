
DO $$
DECLARE
    statuses TEXT[] := ARRAY['confirmed', 'cancelled'];
    i INTEGER;
    randomUserId INTEGER;
    randomWorkspaceId INTEGER;
    randomSessionId INTEGER;
    randomReservationTime TIMESTAMP;
    randomStatus VARCHAR(20);
    randomComments TEXT;
BEGIN
    FOR i IN 1..100 LOOP
        
        randomUserId := 1 + (random() * 120)::integer; 
        randomWorkspaceId := 1 + (random() * 120)::integer;  
        randomSessionId := 1 + (random() * 150)::integer;
        randomReservationTime := NOW() + (random() * INTERVAL '30 days'); 
        randomStatus := statuses[1 + (random() * array_length(statuses, 1))::integer];
        randomComments := 'Comentario de reserva ' || i::text;

        IF EXISTS (SELECT 1 FROM Users WHERE user_id = randomUserId) AND
           EXISTS (SELECT 1 FROM Workspaces WHERE workspace_id = randomWorkspaceId) AND
           EXISTS (SELECT 1 FROM Sessions WHERE session_id = randomSessionId) THEN
           
            INSERT INTO Reservations (user_id, workspace_id, session_id, reservation_time, status, comments)
            VALUES (randomUserId, randomWorkspaceId, randomSessionId, randomReservationTime, randomStatus, randomComments);
        
        ELSE
            RAISE NOTICE 'No se pueden generar reservas con IDs no existentes.';
           
        END IF;
        
    END LOOP;
END $$;
