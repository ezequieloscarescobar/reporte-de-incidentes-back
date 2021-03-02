<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class TecnicoController extends Controller
{
    private static $tabla = 'tecnico';

    /**
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(Request $request)
    {
        if($request->has('tipo_problema_id')){
            $tecnicos = DB::table(self::$tabla)
                ->join('especialidad_tecnico', self::$tabla.'.id', '=', 'especialidad_tecnico.tecnico_id')
                ->join('especialidad_tipo_de_problema', 'especialidad_tecnico.especialidad_id', '=', 'especialidad_tipo_de_problema.especialidad_id')
                ->where(['especialidad_tipo_de_problema.tipo_de_problema_id' => $request->get('tipo_problema_id')])
                ->select([self::$tabla.'.*'])
                ->orderBy(self::$tabla.'.nombre', 'asc')
                ->distinct()
                ->get();
        }
        else {
            $tecnicos = DB::table(self::$tabla)
                ->select('*')
                ->get();
        }
        return response()->json($tecnicos);
    }

    /**
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function show($id)
    {
        $tecnico = DB::table(self::$tabla)
            ->select('*')
            ->where(['id' => $id])
            ->get()[0];
        return response()->json($tecnico);
    }
}
