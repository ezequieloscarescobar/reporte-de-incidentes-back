<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class IncidenteController extends Controller
{
    private static $tabla = 'incidente';

    /**
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        $incidentes = DB::table(self::$tabla)
            ->select('*')
            ->join('servicio_contratado', self::$tabla.'.servicio_contratado_id', '=', 'servicio_contratado.id')
            ->join('cliente', 'servicio_contratado.cliente_id', '=', 'cliente.id')
            ->get();
        return response()->json($incidentes);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        $fechaDeAlta = new \DateTime('now');
        $result = DB::table(self::$tabla)
            ->insert([
                "servicio_contratado_id"    => $request->post('servicio_contratado_id'),
                "tecnico_id"                => $request->post('tecnico_id'),
                "posible_problema_id"       => $request->post('posible_problema_id'),
                "estado_id"                 => 1,
                "fecha_alta"                => $fechaDeAlta->format("Y-m-d"),
                "posible_fecha_resolucion"  => $this->calcularFechaPosibleDeResolucion(new \DateTime('now'), $request->post('posible_problema_id')),
                "descripcion_del_problema"  => $request->post('descripcion_del_problema'),
            ]);
        return response()->json($result);
    }

    /**
     * @param \DateTime $fechaDeAlta
     * @param $posibleProblemaId
     * @return string
     */
    private function calcularFechaPosibleDeResolucion(\DateTime $fechaDeAlta, $posibleProblemaId)
    {
        $posibleProblema = DB::table('posible_problema')
            ->select('*')
            ->where(['id' => $posibleProblemaId])
            ->get()[0];
        $tiempoDeResolucionEnHoras = $posibleProblema->tiempo_de_resolucion_estimado_en_horas;
        return $fechaDeAlta->add(new \DateInterval("PT{$tiempoDeResolucionEnHoras}H"))->format("Y-m-d");
    }

    /**
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function show($id)
    {
        $incidente = DB::table(self::$tabla)
            ->select('*')
            ->join('servicio_contratado', self::$tabla.'.servicio_contratado_id', '=', 'servicio_contratado.id')
            ->join('cliente', 'servicio_contratado.cliente_id', '=', 'cliente.id')
            ->where([self::$tabla.'.id' => $id])
            ->get();
        return response()->json(count($incidente)>0? $incidente[0]: null);
    }

    /**
     * @param Request $request
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Request $request, $id)
    {
        $fechaCerrado = new \DateTime('now');
        $estado = DB::table('estado_incidente')
            ->where(['id' => $request->post('estado_id')])
            ->select('*')
            ->get()[0];
        $fechaCerrado = $estado->final == 1? $fechaCerrado->format("Y-m-d") : null;
        $result = DB::table(self::$tabla)
            ->where(['id' => $id])
            ->update([
                "estado_id"         => $request->post('estado_id'),
                "consideraciones"   => $request->post('consideraciones', null),
                "fecha_cerrado"     => $fechaCerrado
            ]);
        return response()->json($result > 0);
    }
}
