-- 공연 - 유저 1000개 데이터 - 공연 하나당 5개

DO $$
    DECLARE
i INT := 1;
        show_id UUID;
        user_id UUID;
BEGIN
        WHILE i <= 200 LOOP
                -- 공연을 랜덤하게 선택
                show_id := (SELECT id FROM show ORDER BY RANDOM() LIMIT 1);

                -- 5명의 랜덤 유저를 선택하여 interest_show에 삽입
FOR user_id IN
                    (SELECT id FROM "users" ORDER BY RANDOM() LIMIT 5)
                    LOOP
                        INSERT INTO interest_show (
                            id, created_at, updated_at, is_deleted, show_id, user_id
                        ) VALUES (
                                     gen_random_uuid(),
                                     NOW(), NOW(), FALSE,
                                     show_id, user_id
                                 );
END LOOP;

                i := i + 1;
END LOOP;

        RAISE NOTICE '1000 dummy interest_show records inserted.';
END $$;
