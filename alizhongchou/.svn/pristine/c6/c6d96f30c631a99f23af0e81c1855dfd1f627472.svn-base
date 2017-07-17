<?php
class ControllerCatalogModel extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('catalog/model');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/model');

		$this->getList();
	}

	public function add() {}

	public function edit() {}

	public function delete() {}



	protected function getList() {
	    if (isset($this->request->get['filter_name'])) {
	        $filter_name = $this->request->get['filter_name'];
	    } else {
	        $filter_name = null;
	    }
	    if (isset($this->request->get['filter_status'])) {
	        $filter_status = $this->request->get['filter_status'];
	    } else {
	        $filter_status = null;
	    }
	    if (isset($this->request->get['filter_category'])) {
	        $filter_category = $this->request->get['filter_category'];
	    } else {
	        $filter_category = null;
	    }
	    
	    if (isset($this->request->get['sort'])) {
	        $sort = $this->request->get['sort'];
	    } else {
	        $sort = 'p.date_added';
	    }
	    if (isset($this->request->get['order'])) {
	        $order = $this->request->get['order'];
	    } else {
	        $order = 'DESC';
	    }
	    
	    if (isset($this->request->get['page'])) {
	        $page = $this->request->get['page'];
	    } else {
	        $page = 1;
	    }
	    
	    $url = '';
	    
	    if (isset($this->request->get['filter_name'])) {
	        $url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
	    }
	    
	    if (isset($this->request->get['filter_status'])) {
	        $url .= '&filter_status=' . urlencode(html_entity_decode($this->request->get['filter_status'], ENT_QUOTES, 'UTF-8'));
	    }
	     
	    if (isset($this->request->get['filter_category'])) {
	        $url .= '&filter_category=' . urlencode(html_entity_decode($this->request->get['filter_category'], ENT_QUOTES, 'UTF-8'));
	    }
	    
	    if (isset($this->request->get['sort'])) {
	        $url .= '&sort=' . $this->request->get['sort'];
	    }
	    
	    if (isset($this->request->get['order'])) {
	        $url .= '&order=' . $this->request->get['order'];
	    }
	    
	    if (isset($this->request->get['page'])) {
	        $url .= '&page=' . $this->request->get['page'];
	    }
	    
	    $data['breadcrumbs'] = array();
	    
	    $data['breadcrumbs'][] = array(
	        'text' => $this->language->get('text_home'),
	        'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
	    );
	    
	    $data['breadcrumbs'][] = array(
	        'text' => $this->language->get('heading_title'),
	        'href' => $this->url->link('catalog/model', 'token=' . $this->session->data['token'] . $url, true)
	    );
	    
	    $data['add'] = $this->url->link('catalog/model/add', 'token=' . $this->session->data['token'] . $url, true);
	    $data['delete'] = $this->url->link('catalog/model/delete', 'token=' . $this->session->data['token'] . $url, true);
	    
	    $data['models'] = array();
	    
	    $filter_data = array(
	        'filter_name'	  => $filter_name,
	        'filter_category' => $filter_category,
	        'filter_status'   => $filter_status,
	        'sort'            => $sort,
	        'order'           => $order,
	        'start'           => ($page - 1) * $this->config->get('config_limit_admin'),
	        'limit'           => $this->config->get('config_limit_admin')
	    );
	    
	    $this->load->model('tool/image');
	    
	    $model_total = $this->model_catalog_model->getTotalModels($filter_data);
	    $results = $this->model_catalog_model->getModels($filter_data);
	    foreach ($results as $result) {
	        if (is_file(DIR_IMAGE . $result['image'])) {
	            $image = $this->model_tool_image->resize($result['image'], 40, 40);
	        } else {
	            $image = $this->model_tool_image->resize('no_image.png', 40, 40);
	        }
	    
	        $data['models'][] = array(
	            'model_id' => $result['model_id'],
	            'image'      => $image,
	            'name'       => $result['name'],
	            'category_name'      => $result['category_name'],
	            'price'      => $result['price'],
	            'status'     => ($result['status']) ? $this->language->get('text_enabled') : $this->language->get('text_disabled'),
	            'edit'       => $this->url->link('catalog/model/edit', 'token=' . $this->session->data['token'] . '&model_id=' . $result['model_id'] . $url, true)
	        );
	    }
	    $data['heading_title'] = $this->language->get('heading_title');
	    
	    $data['text_list'] = $this->language->get('text_list');
	    $data['text_enabled'] = $this->language->get('text_enabled');
	    $data['text_disabled'] = $this->language->get('text_disabled');
	    $data['text_no_results'] = $this->language->get('text_no_results');
	    $data['text_confirm'] = $this->language->get('text_confirm');
	    
	    $data['column_image'] = $this->language->get('column_image');
	    $data['column_name'] = $this->language->get('column_name');
	    $data['column_category'] = $this->language->get('column_category');
	    $data['column_price'] = $this->language->get('column_price');
	    $data['column_status'] = $this->language->get('column_status');
	    $data['column_action'] = $this->language->get('column_action');
	    
	    $data['entry_name'] = $this->language->get('entry_name');
	    $data['entry_model'] = $this->language->get('entry_model');
	    $data['entry_price'] = $this->language->get('entry_price');
	    $data['entry_category'] = $this->language->get('entry_category');
	    $data['entry_status'] = $this->language->get('entry_status');
	    
	    $data['button_copy'] = $this->language->get('button_copy');
	    $data['button_add'] = $this->language->get('button_add');
	    $data['button_edit'] = $this->language->get('button_edit');
	    $data['button_delete'] = $this->language->get('button_delete');
	    $data['button_filter'] = $this->language->get('button_filter');
	    
	    $data['token'] = $this->session->data['token'];
	    
	    if (isset($this->error['warning'])) {
	        $data['error_warning'] = $this->error['warning'];
	    } else {
	        $data['error_warning'] = '';
	    }
	    
	    if (isset($this->session->data['success'])) {
	        $data['success'] = $this->session->data['success'];
	    
	        unset($this->session->data['success']);
	    } else {
	        $data['success'] = '';
	    }
	    
	    if (isset($this->request->post['selected'])) {
	        $data['selected'] = (array)$this->request->post['selected'];
	    } else {
	        $data['selected'] = array();
	    }
	    
	    $url = '';
	    
	    if (isset($this->request->get['filter_name'])) {
	        $url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
	    }
	    
	    if (isset($this->request->get['filter_category'])) {
	        $url .= '&filter_category=' . urlencode(html_entity_decode($this->request->get['filter_category'], ENT_QUOTES, 'UTF-8'));
	    }
	    
	    
	    if (isset($this->request->get['filter_status'])) {
	        $url .= '&filter_status=' . $this->request->get['filter_status'];
	    }
	    
	    if ($order == 'ASC') {
	        $url .= '&order=DESC';
	    } else {
	        $url .= '&order=ASC';
	    }
	    
	    if (isset($this->request->get['page'])) {
	        $url .= '&page=' . $this->request->get['page'];
	    }
	    
	    $data['sort_name'] = $this->url->link('catalog/model', 'token=' . $this->session->data['token'] . '&sort=m.name' . $url, true);
	    $data['sort_category'] = $this->url->link('catalog/model', 'token=' . $this->session->data['token'] . '&sort=m.model_category_id' . $url, true);
	    $data['sort_price'] = $this->url->link('catalog/model', 'token=' . $this->session->data['token'] . '&sort=m.price' . $url, true);
	    $data['sort_status'] = $this->url->link('catalog/model', 'token=' . $this->session->data['token'] . '&sort=m.status' . $url, true);
	    $data['sort_order'] = $this->url->link('catalog/model', 'token=' . $this->session->data['token'] . '&sort=m.sort_order' . $url, true);
	    
	    $url = '';
	    
	    if (isset($this->request->get['filter_name'])) {
	        $url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
	    }
	    
	    if (isset($this->request->get['filter_category'])) {
	        $url .= '&filter_category=' . urlencode(html_entity_decode($this->request->get['filter_category'], ENT_QUOTES, 'UTF-8'));
	    }
	    
	    
	    if (isset($this->request->get['filter_status'])) {
	        $url .= '&filter_status=' . $this->request->get['filter_status'];
	    }
	    
	    if (isset($this->request->get['sort'])) {
	        $url .= '&sort=' . $this->request->get['sort'];
	    }
	    
	    if (isset($this->request->get['order'])) {
	        $url .= '&order=' . $this->request->get['order'];
	    }
	    $pagination = new Pagination();
	    $pagination->total = $model_total;
	    $pagination->page = $page;
	    $pagination->limit = $this->config->get('config_limit_admin');
	    $pagination->url = $this->url->link('catalog/model', 'token=' . $this->session->data['token'] . $url . '&page={page}', true);
	    $data['pagination'] = $pagination->render();
	    
	    $data['results'] = sprintf($this->language->get('text_pagination'), ($model_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($model_total - $this->config->get('config_limit_admin'))) ? $model_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $model_total, ceil($model_total / $this->config->get('config_limit_admin')));
	    
	    $data['filter_name'] = $filter_name;
	    $data['filter_category'] = $filter_category;
	    $data['filter_status'] = $filter_status;
	    
	    $data['sort'] = $sort;
	    $data['order'] = $order;
	    
	    $data['header'] = $this->load->controller('common/header');
	    $data['column_left'] = $this->load->controller('common/column_left');
	    $data['footer'] = $this->load->controller('common/footer');
	    
	    $this->response->setOutput($this->load->view('catalog/model_list', $data));
	     
	}

	protected function getForm() {}

	protected function validateForm() {}

	protected function validateDelete() {}


	public function autocomplete() {
        $json = array();
        if (isset($this->request->get['filter_name'])) {
            $this->load->model('catalog/model');

            if (isset($this->request->get['filter_name'])) {
                $filter_name = $this->request->get['filter_name'];
            } else {
                $filter_name = '';
            }

            if (isset($this->request->get['limit'])) {
                $limit = $this->request->get['limit'];
            } else {
                $limit = 10;
            }

            $filter_data = array(
                'filter_name'  => $filter_name,
                'start'        => 0,
                'limit'        => $limit
            );

            $results = $this->model_catalog_model->getModels($filter_data);
            foreach ($results as $result) {

                $json[] = array(
                    'model_id' => $result['model_id'],
                    'name'       => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8')),
                );
            }
        }
        $this->response->addHeader('Content-Type: application/json');
        //$this->response->setOutput(json_encode($json));
        exit(json_encode($json));
    }
    
    public function autocompleteCategory() {
        $json = array();
        if ( isset($this->request->get['filter_category'])) {
            $this->load->model('catalog/model');
    
            if (isset($this->request->get['filter_category'])) {
                $filter_category = $this->request->get['filter_category'];
            } else {
                $filter_category = '';
            }
    
            if (isset($this->request->get['limit'])) {
                $limit = $this->request->get['limit'];
            } else {
                $limit = 10;
            }
    
            $filter_data = array(
                'filter_category' => $filter_category,
                'start'        => 0,
                'limit'        => $limit
            );
    
            $results = $this->model_catalog_model->getCategory($filter_data);
            foreach ($results as $result) {
    
                $json[] = array(
                    'model_category_id' => $result['model_category_id'],
                    'category_name'      => $result['category_name'],
                );
            }
        }
        $this->response->addHeader('Content-Type: application/json');
        //$this->response->setOutput(json_encode($json));
        exit(json_encode($json));
    }
}
