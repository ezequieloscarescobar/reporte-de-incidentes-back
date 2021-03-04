<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::resource('clientes', \App\Http\Controllers\API\ClienteController::class)
    ->only(['show', 'index']);

Route::resource('clientes.servicios-contratados', \App\Http\Controllers\API\ServicioContratadoController::class)
    ->only(['show', 'index'])
    ->shallow();

Route::resource('tipos-de-problemas', \App\Http\Controllers\API\TipoDeProblemaController::class)
    ->only(['show', 'index']);

Route::resource('tipos-de-problemas.posibles-problemas', \App\Http\Controllers\API\PosibleProblemaController::class)
    ->only(['show', 'index'])
    ->shallow();

Route::resource('incidentes', \App\Http\Controllers\API\IncidenteController::class)
    ->except(['destroy']);

Route::resource('tecnicos', \App\Http\Controllers\API\TecnicoController::class)
    ->only(['show', 'index'])
    ->shallow();

Route::resource('estados-de-incidentes', \App\Http\Controllers\API\EstadoIncidenteController::class)
    ->only(['index']);
