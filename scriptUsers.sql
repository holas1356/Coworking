DO $$
DECLARE
    names TEXT[] := ARRAY['John', 'Jane', 'Alice', 'Bob', 'Charlie', 'David', 'Eva', 'Frank', 'Grace', 'Hannah', 'Michael', 'Olivia', 'William', 'Sophia', 'James', 'Isabella', 'Alexander', 'Emily', 'Jacob', 'Emma'];
    lastNames TEXT[] := ARRAY['Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Garcia', 'Miller', 'Davis', 'Rodriguez', 'Martinez', 'Martín', 'Anderson', 'Taylor', 'Moore', 'Wilson', 'Hernández', 'King', 'Scott', 'Green', 'Walker'];
    roles TEXT[] := ARRAY['admin', 'member', 'guest'];
    i INTEGER;
    randomName TEXT;
    randomLastName TEXT;
    randomUsername TEXT;
    randomEmail TEXT;
    randomPassword TEXT;
    randomFullName TEXT;
    randomPhoneNumber VARCHAR(15);
    randomRole TEXT;
BEGIN
    FOR i IN 1..200 LOOP
        randomUsername := 'user_' || i::text;
        randomName := names[1 + (random() * array_length(names, 1))::integer];
        randomLastName := lastNames[1 + (random() * array_length(lastNames, 1))::integer];
        randomFullName := randomName || ' ' || randomLastName;
        randomEmail := lower(randomName || '.' || randomLastName || '@example.com');
        IF randomEmail IS NULL THEN
            RAISE NOTICE 'Email generado es nulo. Generando uno alternativo.';
            randomEmail := lower(randomUsername || '@example.com');
        END IF;
        randomPassword := substr(md5(random()::text), 1, 10);
        randomPhoneNumber := '+1234567890';
        randomRole := roles[1 + (random() * array_length(roles, 1))::integer];

        IF randomRole IS NULL THEN
            RAISE NOTICE 'Random role es NULL. Asignando valor por defecto.';
            randomRole := 'guest';  
        END IF;
        
        INSERT INTO Users (username, email, password, full_name, phone_number, role)
        VALUES (randomUsername, randomEmail, randomPassword, randomFullName, randomPhoneNumber, randomRole);
    END LOOP;
END $$;

SELECT * FROM Users;
SELECT COUNT(*) FROM Users;
