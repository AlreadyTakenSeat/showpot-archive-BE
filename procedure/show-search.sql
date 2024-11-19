-- 공연 검색 - 200개 데이터

DO $$
    DECLARE
show_id UUID;
        cur_title VARCHAR(255);
BEGIN
FOR show_id IN (SELECT id FROM show LIMIT 200) LOOP
                -- show 테이블에서 title을 가져옵니다
SELECT title INTO cur_title FROM show WHERE id = show_id;

-- show_search 테이블에 데이터 삽입 (title에서 공백을 제거한 name으로 삽입)
INSERT INTO show_search (
    id, created_at, updated_at, is_deleted, show_id, name
) VALUES (
             gen_random_uuid(),  -- uuid 생성
             NOW(), NOW(), FALSE, -- 생성 및 수정 시간
             show_id,             -- show_id
             REPLACE(cur_title, ' ', '')  -- title에서 공백을 제거하여 name에 삽입
         );
END LOOP;

        RAISE NOTICE '200 dummy show_search records inserted.';
END $$;
