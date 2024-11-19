-- 아티스트 구독 - 한 사람당 5명의 아티스트를 구독

DO $$
    DECLARE
user_ids UUID[];
        artist_ids UUID[];
        current_user_id UUID;
        current_artist_id UUID;
        i INT;
BEGIN
        -- user 테이블에서 모든 user_id를 배열에 저장
SELECT ARRAY_AGG(id) INTO user_ids FROM public."users";

-- artist 테이블에서 모든 artist_id를 배열에 저장
SELECT ARRAY_AGG(id) INTO artist_ids FROM artist;

-- 각 사용자에 대해 5명의 아티스트를 구독
FOREACH current_user_id IN ARRAY user_ids LOOP
                i := 1;

                WHILE i <= 5 LOOP
                        -- 랜덤한 아티스트 선택
                        current_artist_id := artist_ids[FLOOR(1 + RANDOM() * ARRAY_LENGTH(artist_ids, 1))];

                        -- 중복 구독 방지
                        IF NOT EXISTS (
                            SELECT 1
                            FROM artist_subscription
                            WHERE artist_subscription.user_id = current_user_id
                              AND artist_subscription.artist_id = current_artist_id
                        ) THEN
                            -- 데이터 삽입
                            INSERT INTO artist_subscription (id, created_at, updated_at, is_deleted, user_id, artist_id)
                            VALUES (
                                       gen_random_uuid(),
                                       NOW(),
                                       NOW(),
                                       FALSE,
                                       current_user_id,
                                       current_artist_id
                                   );

                            -- 카운터 증가
                            i := i + 1;
END IF;
END LOOP;
END LOOP;

        RAISE NOTICE 'Subscriptions created for all users.';
END $$;
