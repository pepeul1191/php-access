-- migrate:up

CREATE TABLE roles_permissions (
	id	INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  role_id INT NOT NULL,
  permission_id INT NOT NULL,
  CONSTRAINT fk_role_permission_role_id FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_role_permission_id FOREIGN KEY (permission_id) REFERENCES permissions(id)
);

-- migrate:down

ALTER TABLE roles_permissions DROP FOREIGN KEY fk_role_permission_role_id; 
ALTER TABLE roles_permissions DROP FOREIGN KEY fk_role_permission_id;
DROP TABLE IF EXISTS roles_permissions;
