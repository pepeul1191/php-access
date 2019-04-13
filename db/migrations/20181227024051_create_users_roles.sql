-- migrate:up

CREATE TABLE users_roles (
	id	INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  role_id INT NOT NULL,
  CONSTRAINT fk_user_role_user_id FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_user_role_id FOREIGN KEY (role_id) REFERENCES roles(id)
);

-- migrate:down

ALTER TABLE users_roles DROP FOREIGN KEY fk_user_role_user_id; 
ALTER TABLE users_roles DROP FOREIGN KEY fk_user_role_id; 
DROP TABLE IF EXISTS users_roles;
