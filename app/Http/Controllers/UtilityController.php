<?php

namespace App\Http\Controllers;

use App\Order;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class UtilityController extends Controller
{

    public function getOrderDetails()
    {
        try {
            $qry = DB::table('order_details as t1')
                ->join('orders as t2', 't1.order_id', '=', 't2.id')
                ->join('products as t3', 't1.product_id', '=', 't3.id')
                ->select('t1.*', 't2.order_number', 't3.name as product_name');
            $results = $qry->get();
            $res = array(
                'success' => true,
                'message' => $results->count() . ' records fetched',
                'totalCount' => $results->count(),
                'results' => $results
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

    public function prepareOrder()
    {
        try {
            $maxId = Order::max('id');
            $order_number = rand(1000, 9999) . (++$maxId);
            $order_id = Order::create([
                'order_number' => $order_number
            ])->id;
            $res = array(
                'success' => true,
                'order_id' => $order_id,
                'order_number' => $order_number,
                'message' => 'Order generated successfully'
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

    public function saveOrderDetails(Request $request)
    {
        try {
            $id = $request->input('id');
            $order_id = $request->input('order_id');
            $product_ids = $request->input('product_id');
            $params = array();
            foreach ($product_ids as $product_id) {
                $params[] = array(
                    'order_id'=>$order_id,
                    'product_id'=>$product_id
                );
            }
            if (isset($id) && $id > 0) {
                DB::table('order_details')
                    ->where('id', '=', $id)
                    ->update(array('product_id' => $product_id, 'updated_at' => Carbon::now()));
            } else {
                DB::table('order_details')
                    ->insert($params);
            }
            $res = array(
                'success' => true,
                'message' => 'Details saved successfully'
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

    public function getSupplierProducts()
    {
        try {
            $qry = DB::table('supplier_products as t1')
                ->join('suppliers as t2', 't1.supplier_id', '=', 't2.id')
                ->join('products as t3', 't1.product_id', '=', 't3.id')
                ->select('t1.*', 't2.name as supplier_name', 't3.name as product_name');
            $results = $qry->get();
            $res = array(
                'success' => true,
                'message' => $results->count() . ' records fetched',
                'totalCount' => $results->count(),
                'results' => $results
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

    public function saveSupplierProductDetails(Request $request)
    {
        try {
            $id = $request->input('id');
            $supplier_id = $request->input('supplier_id');
            $product_id = $request->input('product_id');
            $params = array(
                'supplier_id' => $supplier_id,
                'product_id' => $product_id
            );
            if (isset($id) && $id > 0) {
                $params['updated_at'] = Carbon::now();
                DB::table('supplier_products')
                    ->where('id', '=', $id)
                    ->update($params);
            } else {
                $params['created_at'] = Carbon::now();
                DB::table('supplier_products')
                    ->insert($params);
            }
            $res = array(
                'success' => true,
                'message' => 'Details saved successfully'
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

    public function deleteRecord(Request $request,$id,$table_name)
    {
        try{
            DB::table($table_name)
                ->where('id','=',$id)
                ->delete();
            $res=array(
                'success'=>true,
                'message'=>'Record deleted successfully'
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

}
