<?php

use Slim\Http\Request;
use Slim\Http\Response;
use Controller\ErrorController;
use Controller\HomeController;
use Controller\LoginController;

// Routes
$app->get('/demo/[{name}]', function (Request $request, Response $response, array $args) {
  // Sample log message
  $this->logger->info("Slim-Skeleton '/' route");
  // Render index view
  return $this->renderer->render($response, 'index.phtml', $args);
});
//login
$app->get('/login', LoginController::class . ':view')->add($mw_session_false);
$app->post('/login', LoginController::class . ':access');
$app->get('/login/ver', LoginController::class . ':ver');
$app->get('/login/cerrar', LoginController::class . ':cerrar');
//error
$app->get('/error/access/{numero}', ErrorController::class . ':access');
//home
$app->get('/', HomeController::class . ':view')->add($mw_session_true);
//servicios REST
// system
$app->get('/access/system/list', Controller\SystemController::class . ':list');
$app->post('/access/system/save', Controller\SystemController::class . ':save');
// permission
$app->get('/access/permission/list/{system_id}', Controller\PermissionController::class . ':list');
$app->post('/access/permission/save', Controller\PermissionController::class . ':save');
