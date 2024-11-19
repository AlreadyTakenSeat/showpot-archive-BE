-- 공연-아티스트 200개 데이터

DO $$
    DECLARE
i INT := 1;
        show_id UUID;
        artist_id UUID;
BEGIN
        WHILE i <= 200 LOOP
                -- 공연과 아티스트를 랜덤하게 선택
                show_id := (SELECT id FROM show ORDER BY RANDOM() LIMIT 1);
                artist_id := (SELECT id FROM artist ORDER BY RANDOM() LIMIT 1);

                -- show_artist 테이블에 데이터 삽입
INSERT INTO show_artist (
    id, created_at, updated_at, is_deleted, artist_id, show_id
) VALUES (
             gen_random_uuid(),
             NOW(), NOW(), FALSE,
             artist_id, show_id
         );

i := i + 1;
END LOOP;

        RAISE NOTICE '200 dummy show_artist records inserted.';
END $$;
