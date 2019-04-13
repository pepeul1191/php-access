<?php

ORM::configure(array(
  'connection_string' => 'mysql:host=localhost;dbname=access',
  'username' => 'root',
  'password' => '123'
), null, 'access');
ORM::configure('return_result_sets', true);
ORM::configure('error_mode', PDO::ERRMODE_WARNING);
ORM::configure('logging', true);
