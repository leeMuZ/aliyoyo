<?php

class ModelRecommendSearch extends Model
{
    public function personal($customer_id)
    {
        $query = $this->db->query("SELECT firstname, lastname, image FROM ". DB_SHARE_PREFIX ."customer WHERE customer_id=".$customer_id);
        return $query->row;
    }

    public function aggregate($collection_id)
    {
        $query = $this->db->query("SELECT cc.collection_name AS name, p.image FROM ".DB_SHARE_PREFIX.
                                  "customer_collection AS cc INNER JOIN ".DB_SHARE_PREFIX."product_to_collection AS ptc ON cc.collection_id=ptc.collection_id INNER JOIN ".DB_SHARE_PREFIX.
                                  "product AS p ON ptc.product_id=p.product_id WHERE cc.collection_id =".$collection_id);
        return $query->rows;
    }

    public function find_product($product_id)
    {
        $query = $this->db->query("SELECT image FROM " . DB_SHARE_PREFIX ."product WHERE product_id=".$product_id);
        return $query->row;
    }

    public function find_product_url($product_id)
    {
        $query = $this->db->query("SELECT keyword FROM " . DB_SHARE_PREFIX ."url_alias WHERE query='product_id={$product_id}'");
        return $query->row;
    }

    public function find_category_url($category_id)
    {
        $query = $this->db->query("SELECT keyword FROM " . DB_SHARE_PREFIX ."url_alias WHERE query='category_id={$category_id}'");
        return $query->row;
    }

    public function find_category_product($category_id)
    {
        $query = $this->db->query("SELECT cd.name, c.image, c.category_id FROM ".DB_SHARE_PREFIX."category AS c INNER JOIN ".DB_SHARE_PREFIX.
                                  "category_description AS cd ON cd.category_id=c.category_id".
                                  " WHERE c.category_id=".$category_id);
        return $query->rows;
    }

}