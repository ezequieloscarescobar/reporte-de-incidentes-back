<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ClienteController extends Controller
{
    private static $tabla = 'cliente';

    /**
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(Request $request)
    {
        if($request->has('razon_social') && $request->has('cuit')){
            $registros = DB::table(self::$tabla)
                ->where([
                    'razon_social'  => $request->get('razon_social'),
                    'cuit'          => $request->get('cuit')
                ])
                ->select('*')
                ->limit(1)
                ->get();
        }
        else{
            $registros = DB::table(self::$tabla)
                ->select('*')
                ->get();
        }
        return response()->json($registros);
    }

    /**
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function show($id)
    {
        $cliente = DB::table(self::$tabla)
            ->where(['id' => $id])
            ->select('*')
            ->get();
        return response()->json($cliente);
    }
}
