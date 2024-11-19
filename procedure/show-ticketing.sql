-- 공연 티켓팅 타임 - 200

DO $$
    DECLARE
show_id UUID;
BEGIN
FOR show_id IN (SELECT id FROM show LIMIT 200) LOOP
                -- show_ticketing_time 테이블에 데이터 삽입
                INSERT INTO show_ticketing_time (
                    id, created_at, updated_at, is_deleted, ticketing_at, show_id, type
                ) VALUES (
                             gen_random_uuid(),  -- uuid 생성
                             NOW(), NOW(), FALSE, -- 생성 및 수정 시간
                             NOW(),               -- ticketing_at 시간 (현재 시간)
                             show_id,             -- show_id
                             'NORMAL'             -- type은 모두 NORMAL로 설정
                         );
END LOOP;

        RAISE NOTICE '200 dummy show_ticketing_time records inserted.';
END $$;
