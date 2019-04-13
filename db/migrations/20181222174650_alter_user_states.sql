-- migrate:up

ALTER TABLE user_states
ADD COLUMN sp VARCHAR(30) AFTER name;

-- migrate:down

ALTER TABLE user_states DROP COLUMN sp;
