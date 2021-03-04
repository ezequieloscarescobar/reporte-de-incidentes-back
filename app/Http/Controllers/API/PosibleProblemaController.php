<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;

class PosibleProblemaController extends Controller
{
    private static $tabla = 'posible_problema';

    /**
     * @param $tipoDeProblemaId
     * @return \Illuminate\Http\JsonResponse
     */
    public function index($tipoDeProblemaId)
    {
        $posiblesProblemas = DB::table(self::$tabla)
            ->where(['tipo_id' => $tipoDeProblemaId])
            ->select('*')
            ->orderBy('nombre', 'asc')
            ->get();
        return response()->json($posiblesProblemas);
    }

    /**
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function show($id)
    {
        $posibleProblema = DB::table(self::$tabla)
            ->where(['id' => $id])
            ->select('*')
            ->get();
        return response()->json(count($posibleProblema)>0? $posibleProblema[0] : null);
    }
}
