-- 장르 구독 : 한 사람이 5개씩 장르 구독

DO $$
    DECLARE
user_ids UUID[];
        genre_ids UUID[];
        current_user_id UUID;
        current_genre_id UUID;
        i INT;
BEGIN
        -- user 테이블에서 모든 user_id를 배열에 저장
SELECT ARRAY_AGG(id) INTO user_ids FROM public."users";

-- genre 테이블에서 모든 genre_id를 배열에 저장
SELECT ARRAY_AGG(id) INTO genre_ids FROM public.genre;

-- 각 사용자에 대해 5개의 장르를 구독
FOREACH current_user_id IN ARRAY user_ids LOOP
                i := 1;

                WHILE i <= 5 LOOP
                        -- 랜덤한 장르 선택
                        current_genre_id := genre_ids[FLOOR(1 + RANDOM() * ARRAY_LENGTH(genre_ids, 1))];

                        -- 중복 구독 방지
                        IF NOT EXISTS (
                            SELECT 1
                            FROM genre_subscription
                            WHERE genre_subscription.user_id = current_user_id
                              AND genre_subscription.genre_id = current_genre_id
                        ) THEN
                            -- 데이터 삽입
                            INSERT INTO genre_subscription (id, created_at, updated_at, is_deleted, genre_id, user_id)
                            VALUES (
                                       gen_random_uuid(),
                                       NOW(),
                                       NOW(),
                                       FALSE,
                                       current_genre_id,
                                       current_user_id
                                   );

                            -- 카운터 증가
                            i := i + 1;
END IF;
END LOOP;
END LOOP;

        RAISE NOTICE 'Genre subscriptions created for all users.';
END $$;
