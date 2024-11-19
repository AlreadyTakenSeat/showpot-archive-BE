-- 사용자 100명

do $$
begin
        -- Insert 100 dummy users
for i in 1..100 loop
                insert into users (
                    id, created_at, updated_at, is_deleted, birth, fcm_token, gender, nickname, role
                ) values (
                            gen_random_uuid (),
                             now() - (random() * interval '10 years'),  -- Random created_at
                             now() - (random() * interval '5 years'),   -- Random updated_at
                             false,                                     -- is_deleted
                             date '1970-01-01' + trunc(random() * 20000)::int, -- Random birth date
                             md5(random()::text),                      -- Random FCM token
                             'MAN',                                      -- Random gender
                             'User_' || i,                             -- Unique nickname
                             'USER'                                    -- Random role
                         );
end loop;

        -- Insert 100 dummy social_login entries
for i in 1..100 loop
                insert into social_login (
                    id, created_at, updated_at, is_deleted, user_id, identifier, social_login_type
                ) values (
                             gen_random_uuid(),
                             now() - (random() * interval '10 years'),  -- Random created_at
                             now() - (random() * interval '5 years'),   -- Random updated_at
                             false,                                     -- is_deleted
                             (select id from users order by random() limit 1), -- Random user_id from users table
                             md5(random()::text),                      -- Random identifier
                             case when random() < 0.33 then 'GOOGLE'
                                  when random() < 0.66 then 'KAKAO'
                                  else 'APPLE'
                                 end                                       -- Random social_login_type
                         );
end loop;
end $$;
