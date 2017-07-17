<?php
class  ModelToolTime extends Model
{
    public function getdelay($time){
        
       // var_dump(explode("-",explode(" ",$time)[0]));
        $time = strtotime($time);
        $year=((int)substr($time,0,4));//get year
        
        $month=((int)substr($time,5,2));//get month
        
        $day=((int)substr($time,8,2));//get day
        $time  = time()-$time;
        $year   = floor($time / 60 / 60 / 24 / 365);
        $time  -= $year * 60 * 60 * 24 * 365;
        $month  = floor($time / 60 / 60 / 24 / 30);
        $time  -= $month * 60 * 60 * 24 * 30;
        $week   = floor($time / 60 / 60 / 24 / 7);
        $time  -= $week * 60 * 60 * 24 * 7;
        $day    = floor($time / 60 / 60 / 24);
        $time  -= $day * 60 * 60 * 24;
        $hour   = floor($time / 60 / 60);
        $time  -= $hour * 60 * 60;
        $minute = floor($time / 60);
        $time  -= $minute * 60;
        $second = $time;
        $elapse = '';
        
        $unitArr = array('year'  =>'year', 'month'=>'month',  'week'=>'week', 'day'=>'day',
            'hour'=>'hour', 'minute'=>'minute', 'second'=>'second'
        );
        
        foreach ( $unitArr as $cn => $u )
        {
            if ( $$u > 0 )
            {
                $elapse = $$u ." ". $cn . " ago";
                if ( $$u > 1 ){
                    $elapse = $$u ." ". $cn."s ago";
                }
                break;
            }
        }
        
        return $elapse;
    }
    
    /**
     * @start time
     */
    function proStartTime() {
        global $startTime;
        $mtime1 = explode(" ", microtime());
        $startTime = $mtime1[1] + $mtime1[0];
    }
    
    /**
     * @End time
     */
    function proEndTime() {
        global $startTime,$set;
        $mtime2 = explode(" ", microtime());
        $endtime = $mtime2[1] + $mtime2[0];
        $totaltime = ($endtime - $startTime);
        $totaltime = number_format($totaltime, 7);
        echo "<br/>process time: ".$totaltime;
    }
    
}

?>