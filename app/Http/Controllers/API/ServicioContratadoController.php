<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ServicioContratadoController extends Controller
{
    private static $tabla = 'servicio_contratado';

    /**
     * @param $clienteId
     * @return \Illuminate\Http\JsonResponse
     */
    public function index($clienteId)
    {
        $servicios = DB::table(self::$tabla)
            ->where(['cliente_id' => $clienteId])
            ->join('servicio', 'servicio_contratado.servicio_id', '=', 'servicio.id')
            ->select([
                'servicio_contratado.*',
                'servicio.nombre as servicio_nombre',
                ])
            ->get();
        return response()->json($servicios);
    }

    /**
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function show($id)
    {
        $servicioContratado = DB::table(self::$tabla)
            ->where(['id' => $id])
            ->select(['*'])
            ->get();
        return response()->json($servicioContratado);
    }
}
