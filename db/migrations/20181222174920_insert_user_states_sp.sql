-- migrate:up

UPDATE user_states SET sp = '' WHERE id = 1;


UPDATE user_states SET sp = 'activo' WHERE id = 1;
UPDATE user_states SET sp = 'inactivo' WHERE id = 2;
UPDATE user_states SET sp = 'suspendido' WHERE id = 3;
UPDATE user_states SET sp = 'eliminado' WHERE id = 4;
UPDATE user_states SET sp = 'vacionando' WHERE id = 5;
UPDATE user_states SET sp = 'activación pendiente' WHERE id = 6;
UPDATE user_states SET sp = 'incompleto' WHERE id = 7;

-- migrate:down
