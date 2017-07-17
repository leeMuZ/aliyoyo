<?php
/**
 * Created by PhpStorm.
 * User: alice
 * Date: 2017/4/13
 * Time: 11:19
 */
class ControllerCrowdfundingPayment extends Controller
{
    public function index()
    {
        if (empty($this->session->data['customer_id'])) {
            echo "<script>alert('You haven not logged in!');</script>";
            $this->response->redirect($this->url->link('account/login', '', true));
            exit;
        }
        if (!isset($this->request->post['funding_id']) || !isset($this->request->post['support_price'])) {
            echo "<script>alert('Please select the product you want to support!');</script>";
            $data['continue'] = $this->url->link('common/home');
            $this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');
            $this->response->setOutput($this->load->view('error/not_found', $data));

        } else{
            if (isset($this->session->data['coupon']))
            {
                unset($this->session->data['coupon']);
            }
            if (isset($this->session->data['order_id']))
            {
                unset($this->session->data['order_id']);
            }
            $this->session->data['funding_id'] = $this->request->post['funding_id'];
            $data['funding_id_links'] = $this->url->link('crowdfunding/campaign', 'funding_id='.$this->request->post['funding_id']);
            //先进行对是否有限制条件是否限制数量
            $this->load->model('crowdfunding/crowdfunding');
            $check = $this->model_crowdfunding_crowdfunding->getAloneOrder($this->session->data['customer_id'], $this->request->post['funding_id'], $this->request->post['reward_id']);
            if ($check == 0)
            {
                echo "<script>alert('You have exceeded the limit');history.go(-1);</script>";
                exit;
            }
            if ($this->request->post['input_post']=="0")
            {
                $data['input_post'] = 0;
            } else {
                if (!empty($this->request->post['input_post']) && is_numeric($this->request->post['input_post'])) {
                    $data['my_input_post'] = $this->model_crowdfunding_crowdfunding->takePost($this->request->post['input_post']);
                    $data['input_post'] = $data['my_input_post']['Postage'];
                    $data['belong_country_id'] = $data['my_input_post']['country_id'];

                } elseif (!empty($this->request->post['input_post']) && is_string($this->request->post['input_post'])) {
                    $data['input_post'] = $this->model_crowdfunding_crowdfunding->getPostage($this->request->post['reward_id']);
                    $checkPost = $this->request->post['input_post'];
                    $checkPost = preg_match_all('/\d+/', $checkPost,$country);
                    $data['belong_country_id']= $country[0][0];
                }
            }
            $data['reward_id'] = isset($this->request->post['reward_id'])?$this->request->post['reward_id']:0;
            if ($data['reward_id']!=0)
            {
                $this->session->data['reward_id'] = $data['reward_id'];
            }
            $data['customer_id'] = $this->session->data['customer_id'];
            $data['funding_id']   = $this->request->post['funding_id'];
            $data['support_price']= $this->request->post['support_price'];
            $data['total']        =   $data['input_post']+$data['support_price'];
            $data['deal_link']    = $this->url->link("crowdfunding/payment/deal_order");
            $data['ticket']       = $this->url->link("crowdfunding/payment/ticket");
            if ($data['reward_id'] == 0)
            {
                $data['pay_message'] = $this->model_crowdfunding_crowdfunding->selectGoodMessage($data['funding_id']);
                if (isset($data['pay_message']['image']))
                {
                    $data['pay_message']['image'] = $this->image_ajax($data['pay_message']['image']);
                }
            }else{
                $data['pay_message'] = $this->model_crowdfunding_crowdfunding->selectGoodMessage($data['funding_id'], $data['reward_id']);
                $data['pay_message']['image'] = $this->image_ajax($data['pay_message']['image']);
            }


            $this->session->data['order_id'] = $this->make_order();
            //费率先按 美元来处理
            $MoneyCode = $this->model_crowdfunding_crowdfunding->SelectMoneyCode(2);
            $email     = $this->model_crowdfunding_crowdfunding->getLoginEmail($data['customer_id']);
            $array = array(
                'order_id'      => $this->session->data['order_id'],
                'customer_id'   =>$data['customer_id'],
                'email'         =>$email,
                'total'         =>$data['total'],
                'date_added'    =>date('Y-m-d H:i:s',time()),
                'currency_id'   =>$MoneyCode['currency_id'],
                'currency_code' =>$MoneyCode['code'],
                'currency_value'=>$MoneyCode['value']
            );
            $priceArray = array(
                'order_id'   => $this->session->data['order_id'],
                'rewards_id'    => $this->request->post['reward_id'],
                'funding_id'    => $this->request->post['funding_id'],
                'back_price'    => $data['support_price'],
                'shipping_price'=> $data['input_post'],
                'total'         => $data['total'],
                'mycoupon_id'   => 0,
                'discount'      => 0
            );
            $this->model_crowdfunding_crowdfunding->insertOrderBasic($array);
            $this->model_crowdfunding_crowdfunding->insertOrderMoney($priceArray);
            $data['address_post'] = $this->url->link('crowdfunding/payment/add_address');

            //find this man's address
            if (isset($data['belong_country_id']))
            {
                $data['addresses'] = $this->model_crowdfunding_crowdfunding->select_my_address($data['customer_id'], $data['belong_country_id']);
            } else {
                $data['addresses'] = $this->model_crowdfunding_crowdfunding->select_all_address($data['customer_id']);
            }
            $data['checkout_post'] = $this->url->link('crowdfunding/payment/checkout');
            $data['add_address'] = $this->url->link('crowdfunding/payment/add_address');
            //select countries
            $data['countries'] = json_encode($this->model_crowdfunding_crowdfunding->select_counties());
            //查询现在的个人优惠卷
            $data['my_coupon'] = $this->model_crowdfunding_crowdfunding->select_my_coupon($this->session->data['customer_id'], $data['total']);

            $document_message = array(
                "title"       => "payment",
                "description" => "payment",
                "keywords"    => "payment"
            );
            $this->document->setTitle($document_message['title']);
            $this->document->setDescription($document_message['description']);
            $this->document->setKeywords($document_message['keywords']);
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');
            $this->response->setOutput($this->load->view('crowdfunding/payment', $data));

        }

    }

    public function add_address()
    {
        $data['customer_id'] = $this->session->data['customer_id'];
        $data['firstname'] = $this->request->post['firstname'];
        $data['lastname']  = $this->request->post['lastname'];
        $data['telephone'] = $this->request->post['telephone'];
        $data['company']   = $this->request->post['company'];
        $data['address_1'] = $this->request->post['address_1'];
        $data['city']      = $this->request->post['city'];
        $data['postcode']  = $this->request->post['postcode'];
        $data['country_id']= $this->request->post['country_id'];
        $data['zone_id']   = $this->request->post['zone_id'];
        $data['address_2'] = $this->request->post['custom_field'];
        $this->load->model('crowdfunding/crowdfunding');
        $result = $this->model_crowdfunding_crowdfunding->insertAddress($data);
        if ($result)
        {
            echo $result;
        }else{
            echo '0';
        }

    }

    public function make_order()
    {
        return  time().mt_rand(0, 9);
    }

    public function deal_order()
    {
       $data['address_id'] = $this->request->post['address_id'];
       $this->load->model('crowdfunding/crowdfunding');
       //get address
       $data = $this->model_crowdfunding_crowdfunding->show_request_address($data['address_id']);
       //$data['payment'] = $this->request->post['payment'];
       if (!empty($this->session->data['coupon']))
       {
           $result = $this->model_crowdfunding_crowdfunding->byYouCoupon($this->session->data['order_id'], $this->session->data['coupon']);
       }
       $data['order_status_id'] = 0;
       $data['ip'] = $this->get_client_ip();
       $this->load->model('crowdfunding/crowdfunding');
       $this->model_crowdfunding_crowdfunding->updateOrderMessage($data,$this->session->data['order_id']);//更新订单表信息
       //$this->model_crowdfunding_crowdfunding->insert_final_checkout($array);//插入order_total的信息
       //先判断改方案的当前剩余量，如有有余先删除1
        if (isset($this->session->data['reward_id']))
        {
            $result = $this->model_crowdfunding_crowdfunding->selectSortReward($this->session->data['reward_id']);
            if ($result==0)
            {
                echo "<script>alert('Unauthorized Modification!');</script>";
                $this->response->redirect($this->url->link('common/error'));
                exit;
            }
        }
        if ($this->request->post['payment']==3)
        {
            $this->load->controller('payment/creditcard');
            $this->load->controller('payment/creditcard/creditcardiframe');
        }else if($this->request->post['payment']==1){
            $this->load->controller('payment/pp_standard');
        }

    }

    public function get_client_ip($type = 0) {
        $type       =  $type ? 1 : 0;
        static $ip  =   NULL;
        if ($ip !== NULL) return $ip[$type];
        if (isset($_SERVER['HTTP_X_FORWARDED_FOR'])) {
            $arr    =   explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']);
            $pos    =   array_search('unknown',$arr);
            if(false !== $pos) unset($arr[$pos]);
            $ip     =   trim($arr[0]);
        }elseif (isset($_SERVER['HTTP_CLIENT_IP'])) {
            $ip     =   $_SERVER['HTTP_CLIENT_IP'];
        }elseif (isset($_SERVER['REMOTE_ADDR'])) {
            $ip     =   $_SERVER['REMOTE_ADDR'];
        }
        // IP地址合法验证
        $long = sprintf("%u",ip2long($ip));
        $ip   = $long ? array($ip, $long) : array('0.0.0.0', 0);
        return $ip[$type];
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