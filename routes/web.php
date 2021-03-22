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

Route::group(['middleware' => ['web']], function () {
    Route::get('authenticateUserSession', 'AdministrationController@authenticateUserSession');
    Route::get('logoutUser', 'AuthController@logoutUser');
    Route::post('authenticateUser', 'AuthController@authenticateUser');
});

