
DO $$
DECLARE
    session_names TEXT[] := ARRAY['Team Meeting', 'Conference Call', 'Training Session', 'Board Meeting', 'Project Review', 'Seminar', 'Workshop', 'Webinar', 'Product Launch', 'Brainstorming Session'];
    i INTEGER;
    randomSessionName TEXT;
    randomStartTime TIMESTAMP;
    randomEndTime TIMESTAMP;
    randomMaxCapacity INTEGER;
BEGIN
    FOR i IN 1..150 LOOP
        randomSessionName := session_names[1 + (random() * array_length(session_names, 1))::integer];
        IF randomSessionName IS NULL THEN
            RAISE NOTICE 'Nombre de sesión generado es nulo. Generando uno alternativo.';
            randomSessionName := 'Sesión sin nombre'; 
        END IF;
        randomStartTime := NOW() + (random() * INTERVAL '30 days');  
        randomEndTime := randomStartTime + (random() * INTERVAL '6 hours'); 
        randomMaxCapacity := 10 + (random() * 50)::integer; 
        
        INSERT INTO Sessions (session_name, start_time, end_time, max_capacity)
        VALUES (randomSessionName, randomStartTime, randomEndTime, randomMaxCapacity);
    END LOOP;
END $$;
