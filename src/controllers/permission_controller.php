<?php

namespace Controller;

class PermissionController extends \Configs\Controller
{
  public function list($request, $response, $args) {
    # data
    $rpta = '';
    $status = 200;
    $system_id = $args['system_id'];
    # logic
    try {
      $rs = \Model::factory('\Models\Access\Permission', 'access')
        ->where('system_id', $system_id)
      	->find_array();
      $rpta = json_encode($rs);
    }catch (Exception $e) {
      $status = 500;
      $rpta = json_encode(
        [
          'tipo_mensaje' => 'error',
          'mensaje' => [
  					'No se ha podido listar los permisos',
  					$e->getMessage()
  				]
        ]
      );
    }
    return $response->withStatus($status)->write($rpta);
  }

  public function save($request, $response, $args) {
    $data = json_decode($request->getParam('data'));
    $nuevos = $data->{'nuevos'};
    $editados = $data->{'editados'};
    $eliminados = $data->{'eliminados'};
    $system_id = $data->{'extra'}->{'system_id'};
    $rpta = []; $array_nuevos = [];
    $status = 200;
    \ORM::get_db('access')->beginTransaction();
    try {
      if(count($nuevos) > 0){
        foreach ($nuevos as &$nuevo) {
          $permission = \Model::factory('\Models\Access\Permission', 'access')->create();
          $permission->name = $nuevo->{'name'};
          $permission->description = $nuevo->{'description'};
          $permission->system_id = $system_id;
          $permission->save();
          $temp = [];
          $temp['temporal'] = $nuevo->{'id'};
          $temp['nuevo_id'] = $permission->id;
          array_push( $array_nuevos, $temp );
        }
      }
      if(count($editados) > 0){
        foreach ($editados as &$editado) {
          $permission = \Model::factory('\Models\Access\Permission', 'access')->find_one($editado->{'id'});
          $permission->name = $editado->{'name'};
          $permission->description = $editado->{'description'};
          $permission->save();
        }
      }
      if(count($eliminados) > 0){
        foreach ($eliminados as &$eliminado) {
          $permission = \Model::factory('\Models\Access\Permission', 'access')->find_one($eliminado);
          $permission->delete();
        }
      }
      $rpta['tipo_mensaje'] = 'success';
      $rpta['mensaje'] = [
        'Se ha registrado los cambios en los sistemas',
        $array_nuevos
      ];
      \ORM::get_db('access')->commit();
    }catch (Exception $e) {
      $status = 500;
      $rpta['tipo_mensaje'] = 'error';
      $rpta['mensaje'] = [
        'Se ha producido un error en guardar la tabla de permisos',
        $e->getMessage()
      ];
      \ORM::get_db('access')->rollBack();
    }
    return $response->withStatus($status)->write(json_encode($rpta));
  }
}
