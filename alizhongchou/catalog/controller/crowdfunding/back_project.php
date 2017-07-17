<?php
class ControllerCrowdfundingBackProject extends Controller
{
    public function index()
    {
        $this->load->model('crowdfunding/crowdfunding');
        $my_check = $this->model_crowdfunding_crowdfunding->getSingle(isset($this->request->get['funding_id'])?$this->request->get['funding_id']:0);
        if (!isset($this->request->get['funding_id']) || empty($my_check))
        {
            $data['continue'] = $this->url->link('common/home');
            $this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');
            $this->response->setOutput($this->load->view('error/not_found', $data));
        }else{
            $data['funding_id'] = $this->request->get['funding_id'];
            // $data['customer_id']= 1;//登陆后获取用户id
            if (isset($this->session->data['customer_id'])){
                $data['customer_id'] = $this->session->data['customer_id'];
            }
            $data['payment'] = $this->url->link('crowdfunding/payment');
            $data['reward'] = $this->model_crowdfunding_crowdfunding->take_reward($data['funding_id']);
            //var_dump( $data['reward']);exit;
            foreach ( $data['reward'] as $k=>$v) {
                $data['reward'][$k]['estimated_delivery'] = $this->model_crowdfunding_crowdfunding->changeTime($v['estimated_delivery']);
                $data['reward'][$k]['estimated_delivery'] = explode(" ", $v['estimated_delivery']);
                $data['reward'][$k]['estimated_delivery'] = $v['estimated_delivery'][0] . " " . date("Y", time());
                if ($data['reward'][$k]['shipping_method']==2)
                {
                    $data['reward'][$k]['my_post'] = $this->model_crowdfunding_crowdfunding->getPost($v['rewards_id'], 2);

                }elseif($data['reward'][$k]['shipping_method']==0){

                    $data['reward'][$k]['my_post'] = $this->model_crowdfunding_crowdfunding->getPost($v['rewards_id']);

                }elseif ($data['reward'][$k]['shipping_method']==1){

                    $data['reward'][$k]['my_post'] = $this->model_crowdfunding_crowdfunding->getPost($v['rewards_id'], 1);

                }
            }
            //var_dump($data['reward']);exit;
            $document_message = array(
                "title"       => "back Project",
                "description" => "back Project",
                "keywords"    => "back Project"
            );
            $this->document->setTitle($document_message['title']);
            $this->document->setDescription($document_message['description']);
            $this->document->setKeywords($document_message['keywords']);
            $data['index_js']     = $this->load->controller('common/js');
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');
            $this->response->setOutput($this->load->view('crowdfunding/back_project', $data));
        }

    }
}