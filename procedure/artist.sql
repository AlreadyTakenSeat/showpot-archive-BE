-- 아티스트 500명  아티스트 장르 - 아티스트 당 2개의 장르
DO $$
DECLARE
artist_index INT := 1;
    artist_id UUID;
    genre_ids UUID[] := ARRAY[
        '017f20d0-4f3c-8f4d-9e15-7ff0c3a876d1',
        '017f20d0-4f3c-8f4d-9e15-7ff0c3a876d2',
        '017f20d0-4f3c-8f4d-9e15-7ff0c3a876d3',
        '017f20d0-4f3c-8f4d-9e15-7ff0c3a876d4',
        '017f20d0-4f3c-8f4d-9e15-7ff0c3a876d5',
        '017f20d0-4f3c-8f4d-9e15-7ff0c3a876d6',
        '017f20d0-4f3c-8f4d-9e15-7ff0c3a876d7',
        '017f20d0-4f3c-8f4d-9e15-7ff0c3a876d8',
        '017f20d0-4f3c-8f4d-9e15-7ff0c3a876d9',
        '017f20d0-4f3c-8f4d-9e15-7ff0c3a876da',
        '017f20d0-4f3c-8f4d-9e15-7ff0c3a876db',
        '017f20d0-4f3c-8f4d-9e15-7ff0c3a876dc',
        '017f20d0-4f3c-8f4d-9e15-7ff0c3a876dd'
    ];
BEGIN
FOR artist_index IN 1..500 LOOP
        -- 생성된 UUID 저장
        artist_id := gen_random_uuid();

        -- Artist 테이블에 데이터 추가
INSERT INTO artist (id, created_at, updated_at, is_deleted, name, image, spotify_id)
VALUES (
           artist_id,
           NOW(),
           NOW(),
           FALSE,
           CONCAT('Artist ', artist_index),
           CONCAT('https://example.com/image', artist_index, '.jpg'),
           CONCAT('spotify_id_', artist_index)
       );

-- 장르 2개 랜덤 선택 및 artist_genre에 데이터 추가
INSERT INTO artist_genre (id, created_at, updated_at, is_deleted, artist_id, genre_id)
VALUES
    (
        gen_random_uuid(),
        NOW(),
        NOW(),
        FALSE,
        artist_id,
        genre_ids[FLOOR(1 + RANDOM() * 13)] -- 첫 번째 랜덤 장르
    ),
    (
        gen_random_uuid(),
        NOW(),
        NOW(),
        FALSE,
        artist_id,
        genre_ids[FLOOR(1 + RANDOM() * 13)] -- 두 번째 랜덤 장르
    );
END LOOP;
END $$;
