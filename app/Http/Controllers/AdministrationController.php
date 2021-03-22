<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

class AdministrationController extends Controller
{

    public function index()
    {
        $data['menus'] = $this->getNavigationItems();
        $data['base_url'] = url('/');
        return view('index', $data);
    }

    public function getAdminModuleParamFromTable(Request $request)
    {

        try {
            $table_name = $request->input('table_name');
            $filters = $request->input('filters');
            $filters = (array)json_decode($filters);
            $qry = DB::table($table_name);
            if (count((array)$filters) > 0) {
                $qry->where($filters);
            }
            $results = $qry->get();
            $res = array(
                'success' => true,
                'results' => $results
            );
        } catch (\Exception $e) {
            $res = array(
                'success' => false,
                'message' => $e->getMessage()
            );
        } catch (\Throwable $throwable) {
            $res = array(
                'success' => false,
                'message' => $throwable->getMessage()
            );
        }
        return response()->json($res);
    }

    public function deleteRecord(Request $request, $id)
    {
        try {
            $table_name = $request->input('table_name');
            DB::table($table_name)
                ->where('id', $id)
                ->delete();
            $res = array(
                'success' => true,
                'message' => 'Record deleted successfully!!'
            );
        } catch (\Exception $e) {
            $res = array(
                'success' => false,
                'message' => $e->getMessage()
            );
        } catch (\Throwable $throwable) {
            $res = array(
                'success' => false,
                'message' => $throwable->getMessage()
            );
        }
        return response()->json($res);
    }

    function getMenu($level = 1, $parent_id = 0)
    {
        $where = array(
            'menus.is_menu' => 1,
            'menus.is_disabled' => 0,
            'menus.level' => $level
        );

        $qry = DB::table('menus')
            ->distinct()
            ->select('menus.*')
            ->where($where);
        $qry = $parent_id == 0 ? $qry->orderBy('menus.order_no') : $qry->where('menus.parent_id', $parent_id)->orderBy('menus.order_no');
        $menus = $qry->get();
        return $menus;
    }

    public function getNavigationItems()
    {
        $row = $this->getMenu(1, 0);
        $menus = '';
        if (count($row)) {
            foreach ($row as $item) {
                $menus .= "<li><a><i class=\"$item->iconCls\"></i> " . $item->name . " <span class=\"fa fa-chevron-down\"></span></a>";
                $children = $this->getMenu(2, $item->id);
                if (count($children) > 0) {
                    $menus .= "<ul class=\"nav child_menu\" style=\"display: none\">";
                    foreach ($children as $child) {
                        $menus .= "<li><a href=\"#/$child->path\">$child->name</a></li>";
                    }
                    $menus .= "</ul>";
                }
                $menus .= "</li>";
            }
        }
        return $menus;
    }

    public function createUser()
    {
        $params = array(
            'email' => 'kip@gmail.com',
            'password' => bcrypt('kip'),
            'name' => 'Kipngetich Hillary'
        );
        DB::table('users')->insert($params);
    }

    public function saveMenuItem(Request $req)
    {
        try {
            $user_id = 4;//Auth::user()->id;
            $post_data = $req->all();
            $level = $post_data['level'];
            $parent_id = 0;
            if ($level === 2) {
                $parent_id = $post_data['parent_id'];
            }
            if ($level > 2) {
                $parent_id = $post_data['child_id'];
            }
            //unset unnecessary values
            unset($post_data['child_id']);
            unset($post_data['parent_id']);
            $table_data = $post_data;
            //add extra params
            $table_data['parent_id'] = $parent_id;
            if (isset($post_data['id'])) {
                $id = $post_data['id'];
                unset($table_data['id']);
                $table_data['updated_at'] = Carbon::now();
                $table_data['updated_by'] = $user_id;
                DB::table('menus')
                    ->where('id', $id)
                    ->update($table_data);
            } else {
                $table_data['created_at'] = Carbon::now();
                $table_data['created_by'] = $user_id;
                $id = DB::table('menus')
                    ->insertGetId($table_data);
            }
            $res = array(
                'success' => true,
                'message' => 'Data saved successfully!!',
                'record_id' => $id
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

    public function getMenus(Request $request)
    {
        try {
            $level = $request->input('level');
            $filters = $request->input('filter');
            $filters = json_decode($filters, true);
            if (isset($filters['parent_id'])) {
                $parent_id = $filters['parent_id'];
            }
            if (isset($filters['level'])) {
                $level = $filters['level'];
            }
            $qry = DB::table('menus');
            if (isset($level)) {
                $qry->where('level', $level);
            }
            if (isset($parent_id)) {
                $qry->where('parent_id', $parent_id);
            }
            $results = $qry->get();
            $res = array(
                'success' => true,
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

    public function getSystemMenus1()
    {
        $row = $this->getMenu(1, 0);
        $menus = '[';
        if (count($row)) {
            $menu_count = count($row);
            $menu_counter = 0;

            foreach ($row as $item) {//top level
                $menu_counter++;
                $id = $item->id;
                $name = $item->name;
                $parent_module_name = $name;
                $icon = $item->iconCls;
                $level = $item->level;
                $order_no = $item->order_no;
                $is_menu = $item->is_menu;
                $is_disabled = $item->is_disabled;

                $menus .= '{';
                $menus .= '"id": ' . $id . ',';
                $menus .= '"menu_id": ' . $id . ',';
                $menus .= '"name": "' . $name . '",';
                $menus .= '"iconCls": "' . $icon . '",';
                $menus .= '"level": ' . $level . ',';
                $menus .= '"order_no": ' . $order_no . ',';
                $menus .= '"is_menu": ' . $is_menu . ',';
                $menus .= '"is_disabled": ' . $is_disabled . ',';

                $children = $this->getMenu(2, $id);
                if (count($children) > 0) {
                    $children_count = count($children);
                    $children_counter = 0;
                    $menus .= '"children": [';
                    foreach ($children as $child) {
                        $children_counter++;
                        $child_id = $child->id;
                        $child_name = $child->name;
                        $child_module_name = $child_name;
                        $module_name = $parent_module_name . ' >> ' . $child_module_name;
                        $child_icon = 'x-fa fa-angle-double-right';//$child['iconCls'];
                        $child_level = $child->level;
                        $child_order_no = $child->order_no;
                        $child_is_menu = $child->is_menu;
                        $child_is_disabled = $child->is_disabled;
                        $child_parent_id = $child->parent_id;

                        $menus .= '{';
                        $menus .= '"id": ' . $child_id . ',';
                        $menus .= '"menu_id": ' . $child_id . ',';
                        $menus .= '"name": "' . $child_name . '",';
                        $menus .= '"iconCls": "' . $child_icon . '",';
                        $menus .= '"level": ' . $child_level . ',';
                        $menus .= '"order_no": ' . $child_order_no . ',';
                        $menus .= '"is_menu": ' . $child_is_menu . ',';
                        $menus .= '"is_disabled": ' . $child_is_disabled . ',';
                        $menus .= '"parent_id": ' . $child_parent_id . ',';

                        //level 2 menu items
                        $grandchildren = $this->getMenu(3, $child_id);
                        if (count($grandchildren) > 0) {
                            $grandchildren_count = count($grandchildren);
                            $grandchildren_counter = 0;
                            $menus .= '"expanded": false,';
                            // $menus .= '"iconCls": "tree-parent",';
                            $menus .= '"children": [';
                            foreach ($grandchildren as $grandchild) {
                                $grandchildren_counter++;
                                $grandchild_id = $grandchild->id;
                                $grandchild_name = $grandchild->name;
                                $module_name = $parent_module_name . ' >> ' . $child_module_name . ' >> ' . $grandchild_name;
                                $grandchild_icon = 'x-fa fa-arrow-circle-right';//$grandchild['iconCls'];
                                $grandchild_level = $grandchild->level;
                                $grandchild_order_no = $grandchild->order_no;
                                $grandchild_is_menu = $grandchild->is_menu;
                                $grandchild_is_disabled = $grandchild->is_disabled;
                                $grandchild_parent_id = $child->parent_id;
                                $grandchild_child_id = $grandchild->parent_id;

                                $menus .= '{';
                                $menus .= '"id": ' . $grandchild_id . ',';
                                $menus .= '"menu_id": ' . $grandchild_id . ',';
                                $menus .= '"name": "' . $grandchild_name . '",';
                                $menus .= '"module_name": "' . $module_name . '",';
                                $menus .= '"iconCls": "' . $grandchild_icon . '",';
                                $menus .= '"level": ' . $grandchild_level . ',';
                                $menus .= '"order_no": ' . $grandchild_order_no . ',';
                                $menus .= '"is_menu": ' . $grandchild_is_menu . ',';
                                $menus .= '"is_disabled": ' . $grandchild_is_disabled . ',';
                                $menus .= '"parent_id": ' . $grandchild_parent_id . ',';
                                $menus .= '"child_id": ' . $grandchild_child_id . ',';
                                $menus .= '"leaf": true';

                                if ($grandchildren_counter == $grandchildren_count) {
                                    //Last Child in this level. Level=2
                                    $menus .= '}';
                                } else {
                                    $menus .= '},';
                                }
                            }
                            $menus .= '],';
                        } else {
                            $menus .= '"leaf": true';
                        }
                        if ($children_counter == $children_count) {
                            //Last Child in this level. Level=1
                            $menus .= '}';
                        } else {
                            $menus .= '},';
                        }
                    }
                    $menus .= ']';

                } else {
                    //$menus.="viewType: '".$viewType."',";
                    $menus .= '"leaf": true';
                }

                if ($menu_counter == $menu_count) {
                    $menus .= '}';
                } else {
                    $menus .= '},';
                }
            }
        }
        $menus .= ']';
        $res = array(
            'results' => $menus
        );
        return $menus;
    }

    public function getSystemUsers()
    {
        try {
            $qry = DB::table('users');
            $results = $qry->get();
            $res = array(
                'success' => true,
                'results' => ['data' => $results, 'totalCount' => $results->count()]
            );
        } catch (\Exception $exception) {
            $res = array(
                'success' => false,
                'results' => $exception->getMessage()
            );
        } catch (\Throwable $throwable) {
            $res = array(
                'success' => false,
                'message' => $throwable->getMessage()
            );
        }
        return response()->json($res);
    }

    public function authenticateUserSession()
    {
        if (!\Auth::check()) {
            $res = array(
                'success' => false,
                'message' => 'Your session has expired. Please reload the application to continue!!'
            );
        } else {
            $res = array(
                'success' => true,
                'message' => 'Session still valid!!'
            );
        }
        return response()->json($res);
    }

}
