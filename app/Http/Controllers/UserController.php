<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;

class UserController extends Controller
{
    /**
     * @OA\GET(
     *     path="/user",
     *     tags={"User"},
     *     security={
     *        {"passport": {}},
     *     },
     *     summary="Read users",
     *     operationId="index",
     *     description=" ",
     *     @OA\Response(
     *          response="200",
     *          description="Number of records fetched"
     *      ),
     *     @OA\Response(
     *          response="default",
     *          description="an ""unexpected"" error"
     *      )
     * )
     */
    public function index()
    {
        try{
            $results=User::latest()->get();
            $res = array(
                'success' => true,
                'message' => $results->count().' records fetched',
                'totalCount' => $results->count(),
                'results' => $results
            );
        }catch (\Exception $exception) {
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

    /**
     * @OA\POST(
     *     path="/user",
     *     tags={"User"},
     *     security={
     *        {"passport": {}},
     *     },
     *     summary="Create user",
     *     operationId="store",
     *     description=" ",
     *     @OA\Parameter(
     *          name="name",
     *          description="Name of the user",
     *          required=true,
     *          in="query",
     *          @OA\Schema(
     *              type="string"
     *          )
     *      ),
     *     @OA\Parameter(
     *          name="email",
     *          description="Email address of the user",
     *          required=true,
     *          in="query",
     *          @OA\Schema(
     *              type="string"
     *          )
     *      ),
     *     @OA\Parameter(
     *          name="password",
     *          description="Password of the user",
     *          required=true,
     *          in="query",
     *          @OA\Schema(
     *              type="string"
     *          )
     *      ),
     *     @OA\Response(
     *          response="200",
     *          description="Records fetched successfully"
     *      ),
     *     @OA\Response(
     *          response="default",
     *          description="an ""unexpected"" error"
     *      )
     * )
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        try {
            $this->validate($request, [
                'name' => 'required',
                'email' => 'required',
                'password' => 'required'
            ]);

            User::create([
                'name' => $request['name'],
                'email' => $request['email'],
                'password' => \Hash::make($request['password'])
            ]);
            $res = array(
                'success' => true,
                'message' => 'User created successfully!!'
            );
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

    /**
     * @OA\GET(
     *     path="/user/{user_id}",
     *     tags={"User"},
     *     security={
     *        {"passport": {}},
     *     },
     *     summary="Read specified user",
     *     operationId="show",
     *     description=" ",
     *      @OA\Parameter(
     *          name="user_id",
     *          description="Unique identifier of the user",
     *          required=true,
     *          in="path",
     *          @OA\Schema(
     *              type="integer"
     *          )
     *      ),
     *     @OA\Response(
     *          response="200",
     *          description="Records fetched successfully"
     *      ),
     *     @OA\Response(
     *          response="default",
     *          description="an ""unexpected"" error"
     *      )
     * )
     */
    public function show($id)
    {
        try {
            $user = User::findOrFail($id);
            $res = array(
                'success' => true,
                'message' => 'Retrieved successfully',
                'user' => $user
            );
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

    /**
     * @OA\PUT(
     *     path="/user/{user_id}",
     *     tags={"User"},
     *     security={
     *        {"passport": {}},
     *     },
     *     summary="Update user",
     *     operationId="update",
     *     description=" ",
     *     @OA\Parameter(
     *          name="user_id",
     *          description="Unique identifier of the user",
     *          required=true,
     *          in="path",
     *          @OA\Schema(
     *              type="integer"
     *          )
     *      ),
     *     @OA\Parameter(
     *          name="name",
     *          description="Name of the user",
     *          required=true,
     *          in="query",
     *          @OA\Schema(
     *              type="string"
     *          )
     *      ),
     *     @OA\Parameter(
     *          name="email",
     *          description="Email address of the user",
     *          required=true,
     *          in="query",
     *          @OA\Schema(
     *              type="string"
     *          )
     *      ),
     *     @OA\Response(
     *          response="200",
     *          description="Records fetched successfully"
     *      ),
     *     @OA\Response(
     *          response="default",
     *          description="an ""unexpected"" error"
     *      )
     * )
     * @param Request $request
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Request $request, $id)
    {
        try {
            $this->validate($request, [
                'name' => 'required',
                'email' => 'required'
            ]);
            $user = User::findOrFail($id);
            $user->update($request->all());
            $res = array(
                'success' => true,
                'message' => 'User details updated successfully!!'
            );
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

    /**
     * @OA\DELETE(
     *     path="/user/{user_id}",
     *     tags={"User"},
     *     security={
     *        {"passport": {}},
     *     },
     *     summary="Delete user",
     *     operationId="destroy",
     *     description=" ",
     *     @OA\Parameter(
     *          name="user_id",
     *          description="Unique identifier of the user",
     *          required=true,
     *          in="path",
     *          @OA\Schema(
     *              type="integer"
     *          )
     *      ),
     *     @OA\Response(
     *          response="200",
     *          description="Records fetched successfully"
     *      ),
     *     @OA\Response(
     *          response="default",
     *          description="an ""unexpected"" error"
     *      )
     * )
     */
    public function destroy($id)
    {
        try {
            $user = User::findOrFail($id);
            $user->delete();
            $res = array(
                'success' => true,
                'message' => 'User deleted successfully!!'
            );
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
}
