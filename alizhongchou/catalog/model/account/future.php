<?php
/**
 * Created by PhpStorm.
 * User: alice
 * Date: 2017/4/26
 * Time: 12:14
 */
class ModelAccountFuture extends Controller
{
    public function GetModuleFuture($key)
    {
        $query = $this->db->query("SELECT value FROM ".DB_PREFIX."setting AS s WHERE s.key= '".$this->db->escape($key)."'");
        return $query->row;
    }

}