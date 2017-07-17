<?php
/**
 * Created by PhpStorm.
 * User: alice
 * Date: 2017/3/27
 * Time: 18:23
 */
class ControllerModuleDiscoverRecommend extends Controller
{
    public function index()
    {
        $this->load->language('customer/recommend');

        $this->document->setTitle($this->language->get('heading_title'));

        //$this->load->model('customer/recommend');

        $this->getPage();

    }

    public function getPage()
    {
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');
        $data['page_link'] = $this->url->link('module/discover_recommend/recommend', 'token=' . $this->session->data['token'], true);

        $data['recommend_list'] = $this->getList();
        $data['ajax_link']      = $this->url->link('module/discover_recommend/my_ajax', 'token=' . $this->session->data['token'], true);
        $data['recommend_link'] = $this->url->link('module/discover_recommend/deal', 'token=' . $this->session->data['token'], true);
        $data['recommend_post'] = $this->url->link('module/discover_recommend/delInsert', 'token=' . $this->session->data['token'], "SSL");
        $data['token'] = $this->session->data['token'];
        $this->response->setOutPut($this->load->view('module/discover_recommend', $data));
    }

    public function getList()
    {
        $this->load->model('customer/recommend');
        $result = $this->model_customer_recommend->get_recommend_list();

        foreach ($result as $k=>$v)
        {
            $result[$k]['recommend_image'] = $this->image_ajax($v['recommend_image']);
        }
        return $result;

    }

    public function delInsert()
    {
        $data['recommend_name'] = $this->request->post['recommend_name'];
        $data['recommend_link'] = $this->request->post['recommend_link'];
        $data['recommend_type'] = $this->request->post['recommend_type'];
        if (isset($this->request->post['image'])) {
            $data['image'] = $this->request->post['image'];
        } elseif (!empty($operator_info)) {
            $data['image'] = $operator_info['image'];
        } else {
            $data['image'] = '';
        }
        $this->load->model('tool/image');
        $data['recommend_image'] = $data['image'];

        //$web_path = "http://".$_SERVER['HTTP_HOST'].'/image';
        //$this->request->post['image'] = substr($this->request->post['image'], (strlen(DIR_IMAGE)+2));
        //$this->request->post['image'] = substr($this->request->post['image'], (strrpos($this->request->post['image'], $web_path)+strlen($web_path)));
        //var_dump( $this->request->post['image']);exit;
      /* if (isset($this->request->post['image']) && is_file(DIR_IMAGE.$this->request->post['image'])) {
            $data['recommend_image'] = $this->model_tool_image->resize($this->request->post['image'], 100, 100);
        } elseif (!empty($operator_info) && is_file(DIR_IMAGE . $operator_info['image'])) {
            $data['recommend_image'] = $this->model_tool_image->resize($operator_info['image'], 100, 100);
        } else {
            $data['recommend_image'] = $this->model_tool_image->resize('no_image.png', 100, 100);
        }*/
        //$data[''] = $this->model_tool_image->resize('no_image.png', 100, 100);
        $this->load->model('customer/recommend');
        $result = $this->model_customer_recommend->insert_recommend($data);
        if ($result)
        {
            $this->response->redirect($this->url->link('module/discover_recommend', 'token=' .$this->session->data['token'], true));
        }else{
            exit("添加失败请返回...");
        }
    }

    public function imageDeal($image)
    {
        $name = $image['name'];
        $type = strtolower(substr($name,strrpos($name, '.')+1));
        $allow_type = array('jpg', 'jpeg', 'gif', 'png');
        if (!in_array($type, $allow_type))
        {
            return;
        }

        if (!is_uploaded_file($image['tmp_name']))
        {
            return;
        }

        $web_path = "http://".$_SERVER['HTTP_HOST']."/image/recommend/";
        $upload_path = "../image/recommend/";
        $new_name = "yo_yo".md5(time().mt_rand(0,999));
        if(move_uploaded_file($image['tmp_name'],$upload_path.$new_name.'.'.$type)){
            return $web_path.$new_name.'.'.$type;
        }else{
            return "Failed!";
        }
    }

    public function deal()
    {
        $this->load->model('customer/recommend');
        $id = $this->request->get['id'];
        switch ($this->request->get['deal']){
            case 'delete':
                $result = $this->model_customer_recommend->delete_recommend_single($id);
                $this->response->redirect($this->url->link('module/discover_recommend', 'token=' .$this->session->data['token'], true));
                break;
            case 'edit':
                $data['recommend_type'] = $this->request->post['type'];
                $data['recommend_link'] = $this->request->post['link'];
                $data['recommend_name'] = $this->request->post['name'];
                $this->model_customer_recommend->update_recommend_single($data, $id);
                exit("1");
                break;
            case 'edit_message':
                $image  = $_FILES['recommend_image'];
                $data['recommend_image']= $this->imageDeal($image);
                $this->model_customer_recommend->update_recommend_single($data, $id);
                $this->response->redirect($this->url->link('module/discover_recommend', 'token=' .$this->session->data['token'], true));
                break;

        }
    }

    public function my_ajax()
    {
        $this->load->model('recommend/search');
        $id  = $this->request->post['num'];
        $type= $this->request->post['type'];
        switch ($type)
        {
            case 1:
            $result = $this->model_recommend_search->personal($id);
            $result['image_show'] = $this->image_ajax($result['image']);
            echo json_encode($result);
            break;
            case 2;
            $result = $this->model_recommend_search->aggregate($id);
            $result[0]['image_show'] = $this->image_ajax($result[0]['image']);
            echo json_encode($result[0]);
            break;
            case 4:
            $result = $this->model_recommend_search->personal($id);
            $result['image_show'] = $this->image_ajax($result['image']);
            echo json_encode($result);
            break;
        }
    }

    public function product_ajax()
    {
        $product_id = $this->request->get['product_id'];
        $this->load->model('recommend/search');
        $this->load->model('tool/image');
        $result = $this->model_recommend_search->find_product($product_id);
        $url    = $this->model_recommend_search->find_product_url($product_id);
        $array  = array(
            'url'  => "http://".$_SERVER['HTTP_HOST'].'/'.$url['keyword'].".html",
            'image'=> $result['image']
        );
        $array['image_show'] = $this->image_ajax($array['image']);
        echo json_encode($array);
    }

    public function category_ajax()
    {
        header("Content-type: text/html; charset=utf-8");
        $category_id = $this->request->get['category_id'];
        $this->load->model('recommend/search');
        $result = $this->model_recommend_search->find_category_product($category_id);
        if (count($result)>=1 && isset($result[0]['category_id']))
        {
            $url = $this->model_recommend_search->find_category_url($result[0]['category_id']);
            $array = array(
                'url'  => "http://".$_SERVER['HTTP_HOST'].'/'.$url['keyword'].".html",
                'image'=> $result[0]['image'],
                'name' => $result[0]['name']
            );
            $array['image_show'] = $this->image_ajax($array['image']);
            echo json_encode($array);
        }
    }

    public function image_ajax($image)
    {
        $this->load->model('tool/image');
        if (is_file(DIR_IMAGE . $image)) {
            $image = $this->model_tool_image->resize($image, 100, 100);
        }  else {
            $image = $this->model_tool_image->resize('no_image.png', 100, 100);
        }
        return $image;

    }

}