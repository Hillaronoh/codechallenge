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

}
