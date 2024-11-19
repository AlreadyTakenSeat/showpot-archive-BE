-- 공연 생성 - 200개

DO $$
    DECLARE
i INT := 1;
        start_date DATE;
        end_date DATE;
        ticketing_date TIMESTAMP;
        seat_prices JSONB;
        ticketing_sites JSONB;
BEGIN
        WHILE i <= 200 LOOP
                -- 랜덤한 날짜 생성
                start_date := DATE '2025-01-01' + (RANDOM() * 365)::INT;
                end_date := start_date + INTERVAL '1 day' * (RANDOM() * 10)::INT;
                ticketing_date := start_date - INTERVAL '7 days';

                -- 랜덤한 좌석 가격 JSON 생성
                seat_prices := JSONB_BUILD_OBJECT(
                        'VIP', (50000 + (RANDOM() * 50000)::INT)::TEXT,
                        'R', (30000 + (RANDOM() * 30000)::INT)::TEXT,
                        'S', (20000 + (RANDOM() * 20000)::INT)::TEXT,
                        'A', (10000 + (RANDOM() * 10000)::INT)::TEXT
                               );

                -- 랜덤한 예매 사이트 JSON 생성
                ticketing_sites :=
                        JSONB_BUILD_OBJECT('Interpark', 'https://interpark.com/show/' || i);


                -- 데이터 삽입
INSERT INTO show (
    id, created_at, updated_at, is_deleted,
    start_date, end_date, title, content, location, image,
    last_ticketing_at, view_count, seat_prices, ticketing_sites
) VALUES (
             gen_random_uuid(),
             NOW(), NOW(), FALSE,
             start_date, end_date,
             'Show Title ' || i,
             'Content for Show ' || i,
             'Location ' || (i % 10 + 1),
             'https://example.com/image/' || i || '.jpg',
             ticketing_date,
             (RANDOM() * 1000)::INT,
             seat_prices,
             ticketing_sites
         );

i := i + 1;
END LOOP;

        RAISE NOTICE '100 dummy shows inserted into the show table.';
END $$;
