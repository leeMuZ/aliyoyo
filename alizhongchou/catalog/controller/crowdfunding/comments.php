<?php
/**
 * Created by PhpStorm.
 * User: alice
 * Date: 2017/4/7
 * Time: 11:58
 */
class ControllerCrowdfundingComments extends Controller
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
            if (!empty($this->session->data['customer_id'])){
                $data['customer_id'] = $this->session->data['customer_id'];
            }
            //$data['id'] = 1;
            $data['funding_id'] = $this->request->get['funding_id'];
            $data['id'] = $data['funding_id'];
            $document_message = array(
                "title"       => "comments",
                "description" => "comments",
                "keywords"    => "comments"
            );
            $data['login'] = $this->url->link("account/login");
            $data['link'] = array(
                'campaign' => $this->url->link('crowdfunding/campaign', "funding_id=".$data['funding_id']),
                'updates'  => $this->url->link('crowdfunding/updates', "funding_id=".$data['funding_id']),
                'comments' => $this->url->link('crowdfunding/comments', "funding_id=".$data['funding_id']),
                'community'=> $this->url->link('crowdfunding/community', "funding_id=".$data['funding_id'])
            );
            $this->document->setTitle($document_message['title']);
            $this->document->setDescription($document_message['description']);
            $this->document->setKeywords($document_message['keywords']);
            $data['index_goods']  = $this->load->controller('crowdfunding/goods');
            $data['index_js']     = $this->load->controller('common/js');
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');

            $this->load->model('crowdfunding/crowdfunding');
            $this->load->model('tool/time');
            //寻找关于该项目的所有评论
            $data['owner'] = $this->model_crowdfunding_crowdfunding->getOwner($data['funding_id']);
            $data['index_comments'] = $this->model_crowdfunding_crowdfunding->getBackers($data['funding_id']);
            //var_dump($data['index_comments']);exit;
            if (!empty($data['index_comments']))
            {
                foreach ($data['index_comments'] as $k=>$v)
                {
                    $data['index_comments'][$k]['date_added'] = $this->model_tool_time->getdelay($v['date_added']);
                    if($v['target_comment_id'] != 0)
                    {
                        $data['reply'][] = $data['index_comments'][$k];
                        unset($data['index_comments'][$k]);
                    }
                }

            }
            sort($data['index_comments']);
            //post地址
            $data["comment_post"] = $this->url->link("crowdfunding/comments/insert");
            $this->response->setOutput($this->load->view('crowdfunding/comments', $data));
        }

    }

    public function insert()
    {
        $data['customer_id'] = $this->request->post['customer'];
        $data['funding_id']  = $this->request->post['funding'];
        //查询当前登录用户是否是支持用户
        $this->load->model('crowdfunding/crowdfunding');
        $data['content']     = $this->request->post['content'];
        if (isset($this->request->post['comment_id']))
        {
            $data['target_comment_id'] = $this->request->post['comment_id'];
            $result = 1;
        }else{
            $result = $this->model_crowdfunding_crowdfunding->checkCustomer($data['customer_id'], $data['funding_id']);
        }
        if ($result)
        {
            $this->model_crowdfunding_crowdfunding->insertSelfComment($data);

            exit("1");
        }else{
            exit("0");
        }
    }

}