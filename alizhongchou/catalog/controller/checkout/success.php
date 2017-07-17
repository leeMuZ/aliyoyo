<?php
/**
 * Created by PhpStorm.
 * User: alice
 * Date: 2017/5/26
 * Time: 18:07
 */
class ControllerCheckoutSuccess extends Controller
{
    public function index()
    {
        $this->session->data['funding_id']=1;
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        $data['order_id']= $this->session->data['order_id'];
        $data['return_home'] = $this->url->link('common/home');
        $data['view_more'] = $this->url->link('common/home');
        $this->load->model('crowdfunding/crowdfunding');
        $data['pick_you'] = $this->model_crowdfunding_crowdfunding->showPick($this->session->data['funding_id']);
        foreach ($data['pick_you'] as $k=>$v)
        {
            $data['pick_you'][$k]['image'] = $this->image_ajax($v['image']);
        }
        $this->response->setOutput($this->load->view('common/success', $data));
    }

    public function image_ajax($image)
    {
        $this->load->model('tool/image');
        if (is_file(DIR_IMAGE.$image)) {
            $image = $this->model_tool_image->resize($image, 100, 100);
        }  else {
            $image = $this->model_tool_image->resize('no_image.png', 100, 100);
        }
        return $image;
    }

}