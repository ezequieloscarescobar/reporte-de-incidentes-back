<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class EstadoIncidenteController extends Controller
{
    private static $tabla = 'estado_incidente';

    /**
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        $estadosDeIncidentes = DB::table(self::$tabla)
            ->select('*')
            ->get();
        return response()->json($estadosDeIncidentes);
    }
}
