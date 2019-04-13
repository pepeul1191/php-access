<?php

namespace Controller;

class SystemController extends \Configs\Controller
{
  public function list($request, $response, $args) {
    # data
    $rpta = '';
    $status = 200;
    # logic
    try {
      $rs = \Model::factory('\Models\System', 'access')
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
          $system = \Model::factory('\Models\System', 'access')->create();
          $system->name = $nuevo->{'name'};
          $system->save();
          $temp = [];
          $temp['temporal'] = $nuevo->{'id'};
          $temp['nuevo_id'] = $system->id;
          array_push( $array_nuevos, $temp );
        }
      }
      if(count($editados) > 0){
        foreach ($editados as &$editado) {
          $system = \Model::factory('\Models\System', 'access')->find_one($editado->{'id'});
          $system->name = $editado->{'name'};
          $system->save();
        }
      }
      if(count($eliminados) > 0){
        foreach ($eliminados as &$eliminado) {
          $system = \Model::factory('\Models\System', 'access')->find_one($eliminado);
          $system->delete();
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
