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

Route::group(['prefix' => 'v1', 'middleware' => ['auth:api']], function () {
    Route::apiResources(
        [
            'supplier' => 'SuppliersController',
            'product' => 'ProductsController'
        ]
    );
    Route::get('getOrderDetails','UtilityController@getOrderDetails');
    Route::get('prepareOrder','UtilityController@prepareOrder');
    Route::post('saveOrderDetails','UtilityController@saveOrderDetails');
    Route::get('getSupplierProducts','UtilityController@getSupplierProducts');
    Route::post('saveSupplierProductDetails','UtilityController@saveSupplierProductDetails');
    Route::delete('deleteRecord/{id}/{table_name}','UtilityController@deleteRecord');
});



