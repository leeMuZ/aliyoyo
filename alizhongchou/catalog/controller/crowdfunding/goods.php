<?php
/**
 * Created by PhpStorm.
 * User: alice
 * Date: 2017/4/6
 * Time: 17:21
 */
class ControllerCrowdfundingGoods extends Controller
{
    public function index()
    {
        $this->load->model('crowdfunding/crowdfunding');
        $my_check = $this->model_crowdfunding_crowdfunding->getSingle(isset($this->request->get['funding_id'])?$this->request->get['funding_id']:0);
        if (!isset($this->request->get['funding_id']) || empty($my_check))
        {
            $this->response->redirect($this->url->link('common/error'));
            exit;
        }
        $id = $this->request->get['funding_id'];
        $data['message'] = $this->model_crowdfunding_crowdfunding->getSingle($id);
        //$data['message']['viedo'] = $this->httpGet($data['message']['viedo'])?$data['message']['viedo']:0;
        if (empty($data['message']))
        {
            $this->response->redirect($this->url->link('common/error'));
            exit;
        }

       //var_dump($test);exit;
        // $data['message']['date_ended'] = strtotime( $data['message']['date_ended']);
        //$data['now'] = time();
       // $data['rest']= ($data['message']['date_ended'] - $data['now'])>0?$data['rest']:0;
        $data['back_link'] = $this->url->link("crowdfunding/back_project", "funding_id=".$id);
       // $data['customer_id'] = $this->session->data['customer_id'];
        return $this->load->view('crowdfunding/goods',$data);
    }

    public function httpGet($url)
    {
        if (!preg_match('/(http|https|ftp):\/\/[\w.]+[\w\/]*[\w.]*\??[\w=&\+\%]*/is',$url))
        {
            return 0;
        }
        if (function_exists('get_headers'))
        {
            $array = get_headers($url);
            if (!preg_match('/200/', $array[0]))
            {
                return 0;
            }else{
                return 1;
            }

        } else {

            return 1;

        }
    }

}