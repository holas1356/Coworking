DO $$
DECLARE
    room_names TEXT[] := ARRAY['Meeting Room', 'Conference Room', 'Board Room', 'Training Room', 'Presentation Room', 'Seminar Room'];
    locations TEXT[] := ARRAY['Floor 1', 'Floor 2', 'Floor 3', 'Floor 4', 'Basement', 'Attic', 'Penthouse'];
    i INTEGER;
    randomRoomName TEXT;
    randomLocation TEXT;
    randomRows INTEGER;
    randomColumns INTEGER;
    randomHasProjector BOOLEAN;
    randomHasWhiteboard BOOLEAN;
BEGIN
    FOR i IN 1..100 LOOP
        randomRoomName := room_names[1 + (random() * array_length(room_names, 1))::integer];
        IF randomRoomName IS NULL THEN
            RAISE NOTICE 'Room name generado es nulo. Generando uno alternativo.';
            randomRoomName := 'Default Room Name';
        END IF;
        randomLocation := locations[1 + (random() * array_length(locations, 1))::integer];
        randomRows := 5 + (random() * 10)::integer; 
        randomColumns := 5 + (random() * 10)::integer;  
        randomHasProjector := (random() < 0.5);  
        randomHasWhiteboard := (random() < 0.7); 
        
        INSERT INTO Rooms (room_name, rows, columns, location, has_projector, has_whiteboard)
        VALUES (randomRoomName, randomRows, randomColumns, randomLocation, randomHasProjector, randomHasWhiteboard);
    END LOOP;
END $$;

SELECT * FROM Rooms;
SELECT COUNT(*) FROM Rooms;
