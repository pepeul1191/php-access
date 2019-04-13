-- migrate:up

CREATE TABLE permissions (
	id	INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name	VARCHAR(40) NOT NULL,
	description VARCHAR(100) NOT NULL,
	system_id INT NOT NULL,
	CONSTRAINT fk_permission_system_id FOREIGN KEY (system_id) REFERENCES systems(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- migrate:down

ALTER TABLE permissions DROP FOREIGN KEY fk_permission_system_id; 
DROP TABLE IF EXISTS permissions;
