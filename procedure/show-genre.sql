-- 공연- 장르 400개 데이터 - 공연 하나당 장르 데이터 2개

DO $$
    DECLARE
i INT := 1;
        show_id UUID;
        genre_id UUID;
BEGIN
        WHILE i <= 200 LOOP
                -- 공연을 랜덤하게 선택
                show_id := (SELECT id FROM show ORDER BY RANDOM() LIMIT 1);

                -- 2개의 랜덤 장르를 선택하여 show_genre에 삽입
FOR genre_id IN
                    (SELECT id FROM genre ORDER BY RANDOM() LIMIT 2)
                    LOOP
                        INSERT INTO show_genre (
                            id, created_at, updated_at, is_deleted, genre_id, show_id
                        ) VALUES (
                                     gen_random_uuid(),
                                     NOW(), NOW(), FALSE,
                                     genre_id, show_id
                                 );
END LOOP;

                i := i + 1;
END LOOP;

        RAISE NOTICE '400 dummy show_genre records inserted.';
END $$;
