<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{

    public function authenticateUser(Request $request)
    {
        try {
            $authParams = array(
                'email' => $request->input('email'),
                'password' => $request->input('password')
            );
            if (Auth::attempt($authParams)) {
                $loggedInUser = Auth::user();
                $apiTokenResult = $loggedInUser->createToken('Solutech', ['create-supplier', 'read-suppliers', 'update-supplier', 'delete-supplier']);
                $access_token = $apiTokenResult->accessToken;

                $res = array(
                    'success' => true,
                    'message' => 'Login Successful. Redirecting...',
                    'user' => $loggedInUser,
                    'token' => $access_token
                );
            } else {
                $res = array(
                    'success' => false,
                    'message' => 'Incorrect login credentials!!'
                );
            }
        } catch (\Exception $exception) {
            $res = array(
                'success' => false,
                'message' => $exception->getMessage()
            );
        } catch (\Throwable $throwable) {
            $res = array(
                'success' => false,
                'message' => $throwable->getMessage()
            );
        }
        return response()->json($res);
    }

    public function logoutUser(Request $request)
    {
        $loggedInUser = Auth::user();
        if ($loggedInUser) {
            $userTokens = $loggedInUser->tokens();
            foreach ($userTokens as $token) {
                $token->revoke();
                $token->delete();
            }
        }
        Auth::logout();
    }

}
