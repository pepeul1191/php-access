-- migrate:up

CREATE TABLE roles (
	id	INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name	VARCHAR(40) NOT NULL,
	system_id INT NOT NULL,
	CONSTRAINT fk_role_system_id FOREIGN KEY (system_id) REFERENCES systems(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- migrate:down

ALTER TABLE roles DROP FOREIGN KEY fk_role_system_id; 
DROP TABLE IF EXISTS roles;
