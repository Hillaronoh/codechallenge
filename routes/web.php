<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/','AdministrationController@index');
Route::get('login', 'AdministrationController@index')->name('login');
//Auth::routes();
//Route::get('/home', 'HomeController@index')->name('home');

Route::group(['middleware' => ['web']], function () {
    //AdministrationController
    Route::get('getNavigationRoutes', 'AdministrationController@getNavigationRoutes');
    Route::get('createUser', 'AdministrationController@createUser');
    Route::get('getMenus', 'AdministrationController@getMenus');
    Route::get('getSystemUsers', 'AdministrationController@getSystemUsers');
    Route::get('getSystemMenus', 'AdministrationController@getSystemMenus');
    Route::post('saveMenuItem', 'AdministrationController@saveMenuItem');
    Route::get('getAdminModuleParamFromTable', 'AdministrationController@getAdminModuleParamFromTable');
    Route::get('authenticateUserSession', 'AdministrationController@authenticateUserSession');
    Route::delete('deleteRecord/{id}', 'AdministrationController@deleteRecord');
    //AuthController
    Route::post('personalAccessToken', 'AuthController@personalAccessToken');
    Route::get('logoutUser', 'AuthController@logoutUser');
    Route::post('authenticateUser', 'AuthController@authenticateUser');
    Route::get('googleCallback', function(Request $request){
        print_r($request->all());
    });
});

