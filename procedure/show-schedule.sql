-- 공연 하나당 유저 2개의 알림 설정

DO $$
DECLARE
show_id UUID;
    user_id UUID;
BEGIN
    -- 공연마다 알림을 생성하기 위해 공연 ID를 순차적으로 가져옴
FOR show_id IN (SELECT id FROM show LIMIT 200) LOOP
        -- 공연 하나에 대해 2명의 사용자에게 알림을 생성
        FOR user_id IN (SELECT id FROM "user" LIMIT 2) LOOP
            -- ticketing_alert 테이블에 데이터 삽입
            INSERT INTO ticketing_alert (
                id, created_at, updated_at, is_deleted, name, schedule_alert_time, show_id, user_id
            ) VALUES (
                gen_random_uuid(),         -- UUID 생성
                NOW(), NOW(), FALSE,       -- 생성 및 수정 시간
                CONCAT('Alert for ', show_id),  -- 알림 이름 (예: "Alert for <show_id>")
                NOW() + INTERVAL '1 hour', -- schedule_alert_time (현재 시간에서 1시간 뒤)
                show_id,                   -- show_id (현재 공연 ID)
                user_id                    -- user_id (현재 사용자 ID)
            );
END LOOP;
END LOOP;

    RAISE NOTICE '400 dummy ticketing_alert records inserted.';
END $$;
