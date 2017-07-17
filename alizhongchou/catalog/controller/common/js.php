<?php
/**
 * Created by PhpStorm.
 * User: alice
 * Date: 2017/4/7
 * Time: 10:51
 */
class ControllerCommonJs extends Controller
{
    public function index()
    {
        $id = isset($this->request->get['funding_id'])?$this->request->get['funding_id']:$this->request->post['funding_id'];
        $this->load->model('crowdfunding/crowdfunding');
        $data['message'] = $this->model_crowdfunding_crowdfunding->getSingle($id);
        if ($data['message']['total_goal']!=0)
        {
            $data['max'] = ($data['message']['current_goal']/$data['message']['total_goal'])*100;
        }
        return $this->load->view('common/js', $data);
    }
}