<?php

class ModelTotalTBDiscount extends Model {

    public function getTotal($total) {
        //$this->load->language('total/discount');

        $discount = $this->cart->getSubTotal();
        $rates = $this->config->get('tb_discount_rate');

        $langugae_id = (int)$this->config->get('config_language_id') ;
        $discount_amount = 0;
        $discount_amt  = 0;
        
        if (isset($rates['from'])) {
            foreach ($rates['from'] as $key => $rate) {
                $from = $rate;
                $to = $rates['to'][$key];

                if ($discount > $from && $discount <= $to) {
                    $discount_amount = $rates['charge'][$key];
                    $discount_amt = $discount_amount;
                    break;
                }
            }
        }

        if (!$this->config->get('tb_discount_type')) {
            $discount_amount /= 100;
            $discount *= - $discount_amount;
            $discount_text = $discount_amt . '%';
        } else {
            $discount = - $discount_amount;
            $discount_text = $this->currency->format($discount_amt,$this->session->data['currency']);
        }



       if (($this->config->get('tb_discount_status')) ) {
            $status = true;
        }
        else
            $status = false;


        if ($status && $discount_amt != 0) {
            $heading_arr  =$this->config->get('tb_discount_heading');
           $total['totals'][] = array(
                'code' => 'tb_discount',
                'title' => $heading_arr[$langugae_id].' (' . $discount_text . ')',
                'text' => $this->currency->format($discount,$this->session->data['currency']),
                'value' => $discount,
                'sort_order' => $this->config->get('discount_sort_order')
            );

            $total['total'] += $discount;
        }
    }

}

?>
