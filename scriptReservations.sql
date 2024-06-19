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
    FOR i IN 1..160 LOOP
        
        randomUserId := 38 + (random() * (137 - 38 + 1))::integer; 
        randomWorkspaceId := 167 + (random() * (266 - 167 + 1))::integer;  
        randomSessionId := 15 + (random() * (114 - 15 + 1))::integer;
        randomReservationTime := NOW() + (random() * INTERVAL '30 days'); 
        randomStatus := statuses[1 + (random() * array_length(statuses, 1))::integer];
        randomComments := 'Comentario de reserva ' || i::text;

        IF randomStatus IS NULL THEN
            randomStatus := 'confirmed';
        END IF;

        IF EXISTS (SELECT 1 FROM Users WHERE user_id = randomUserId) AND
           EXISTS (SELECT 1 FROM Workspaces WHERE workspace_id = randomWorkspaceId
                    AND NOT EXISTS (
                        SELECT 1 FROM Reservations
                        WHERE workspace_id = randomWorkspaceId
                        AND session_id = randomSessionId
                        AND (status = 'confirmed' OR status IS NULL)
                    )) AND
           EXISTS (SELECT 1 FROM Sessions WHERE session_id = randomSessionId) THEN
           
            INSERT INTO Reservations (user_id, workspace_id, session_id, reservation_time, status, comments)
            VALUES (randomUserId, randomWorkspaceId, randomSessionId, randomReservationTime, randomStatus, randomComments);
           
        END IF;
        
    END LOOP;
END $$;


SELECT * FROM Reservations