DO $$
DECLARE
    workspace_types TEXT[] := ARRAY['desk', 'cabin', 'open_space'];
    i INTEGER;
    randomRoomId INTEGER;
    randomRowNumber INTEGER;
    randomColumnNumber INTEGER;
    randomWorkspaceType TEXT;
    randomHasPowerOutlet BOOLEAN;
BEGIN
    FOR i IN 1..120 LOOP
       
        randomRoomId := 13 + (random() * 100)::integer;  
        randomRowNumber := 1 + (random() * 20)::integer; 
        randomColumnNumber := 1 + (random() * 10)::integer; 
        randomWorkspaceType := workspace_types[1 + (random() * array_length(workspace_types, 1))::integer];
        randomHasPowerOutlet := (random() < 0.8);  
        IF EXISTS (SELECT 1 FROM Rooms WHERE room_id = randomRoomId) THEN
            INSERT INTO Workspaces (room_id, row_number, column_number, workspace_type, has_power_outlet)
            VALUES (randomRoomId, randomRowNumber, randomColumnNumber, randomWorkspaceType, randomHasPowerOutlet);
        ELSE
            RAISE NOTICE 'room_id % no existe en la tabla Rooms. Generando uno nuevo.', randomRoomId;
          
        END IF;
    END LOOP;
END $$;
