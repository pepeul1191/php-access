<?php

namespace Access\Controller;

class SystemController extends \Configs\Controller
{
  public function list($request, $response, $args) {
    # data
    $rpta = '';
    $status = 200;
    # logic
    try {
      $rs = \Model::factory('\Models\Access\System', 'access')
      	->select('id')
      	->select('name')
      	->find_array();
      $rpta = json_encode($rs);
    }catch (Exception $e) {
      $status = 500;
      $rpta = json_encode(
        [
          'tipo_mensaje' => 'error',
          'mensaje' => [
  					'No se ha podido listar los sistemas',
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
    $rpta = []; $array_nuevos = [];
    $status = 200;
    \ORM::get_db('access')->beginTransaction();
    try {
      if(count($nuevos) > 0){
        foreach ($nuevos as &$nuevo) {
          $departamento = \Model::factory('\Models\Access\System', 'access')->create();
          $departamento->name = $nuevo->{'name'};
          $departamento->save();
          $temp = [];
          $temp['temporal'] = $nuevo->{'id'};
          $temp['nuevo_id'] = $departamento->id;
          array_push( $array_nuevos, $temp );
        }
      }
      if(count($editados) > 0){
        foreach ($editados as &$editado) {
          $departamento = \Model::factory('\Models\Access\System', 'access')->find_one($editado->{'id'});
          $departamento->name = $editado->{'name'};
          $departamento->save();
        }
      }
      if(count($eliminados) > 0){
        foreach ($eliminados as &$eliminado) {
          $departamento = \Model::factory('\Models\Access\System', 'access')->find_one($eliminado);
          $departamento->delete();
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
        'Se ha producido un error en guardar la tabla de sistemas',
        $e->getMessage()
      ];
      \ORM::get_db('access')->rollBack();
    }
    return $response->withStatus($status)->write(json_encode($rpta));
  }
}
