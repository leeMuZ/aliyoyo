<?php
/**
 * Created by PhpStorm.
 * User: alice
 * Date: 2017/4/7
 * Time: 11:34
 */
class ControllerCrowdfundingCommunity extends Controller
{
    public function index()
    {
        //$id = 1;//项目id
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
            $document_message = array(
                "title"       => "community",
                "description" => "community",
                "keywords"    => "community"
            );
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

            //find this persons
            $data['person']=$this->model_crowdfunding_crowdfunding->findPerson( $data['funding_id']);
            if (!empty($data))
            {
                foreach ($data['person'] as $k=>$v)
                {
                    $data['person'][$k]['image'] = $this->image_ajax($v['image']);
                }
            }
            $this->response->setOutput($this->load->view('crowdfunding/community', $data));

        }

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