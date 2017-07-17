<?php
class ControllerCommonError extends Controller
{
    public function index()
    {
        $data['continue'] = $this->url->link('common/home');
        $this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        $this->response->setOutput($this->load->view('error/not_found', $data));
    }

}