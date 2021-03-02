<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class TipoDeProblemaController extends Controller
{
    private static $tabla = 'tipo_de_problema';

    /**
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        $tiposDeProblema = DB::table(self::$tabla)
            ->select('*')
            ->orderBy('nombre', 'asc')
            ->get();
        return response()->json($tiposDeProblema);
    }

    /**
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function show($id)
    {
        $tipoDeProblema = DB::table(self::$tabla)
            ->where(['id' => $id])
            ->select('*')
            ->get();
        return response()->json($tipoDeProblema);
    }
}
