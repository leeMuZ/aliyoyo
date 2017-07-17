<?php
require DIR_SYSTEM . '../vendor/aws.phar';

class AmazonS3 {
    private $db;
    private $config;
    private $accessKey;
    private $secretKey;
    private $region;
    private $bucket;
    private $client;

    public function __construct($registry) {
        $this->db = $registry->get('db');
        $this->config = $registry->get('config');
        $this->accessKey = $this->config->get('amazon_s3_access_key');
        $this->secretKey = $this->config->get('amazon_s3_secret_key');
        $this->region = $this->config->get('amazon_s3_region');
        $this->bucket = $this->config->get('amazon_s3_bucket');
        $this->client = Aws\S3\S3Client::factory([
            'version' => 'latest',
            'region'  => $this->region,
            'key'     => $this->accessKey,
            'secret'  => $this->secretKey,
        ]);
    }

    public function getDownloadLink($file) {
        $result = $this->db->query("
            SELECT `filename_remote` FROM `" . DB_PREFIX . "amazon_s3_download`
            WHERE `filename_local` = '" . $this->db->escape($file) . "'")->row;
        if (!isset($result['filename_remote']) || empty($result['filename_remote'])) {
            return false;
        }

        $remoteFilename = $result['filename_remote'];
        return $this->client->getObjectUrl($this->bucket, 'download/' . $remoteFilename, '+30 seconds');
    }

    public function deleteFile($filename, $type) {
        $file = utf8_substr($filename, 0, utf8_strrpos($filename, '.'));

        if ($type == 'image') {
            $this->db->query("
                DELETE FROM `" . DB_PREFIX . "amazon_s3_image`
                WHERE `filename` LIKE '" . $this->db->escape($file) . "%'
            ");

        } elseif ($type == 'download') {
            $this->db->query("
                DELETE FROM `" . DB_PREFIX . "amazon_s3_download`
                WHERE `filename_local` LIKE '" . $this->db->escape($file) . "%'
            ");
        }
    }
    //original source
    public function deleteS3File($data, $type) {
    $path = $data['path'];
    $this->db->query("
                DELETE FROM `" . DB_PREFIX . "amazon_s3_source`
                WHERE `filename` = '" . substr($path,strripos($path,"/")+1) . "' AND `directory`='".substr($path,0,strripos($path,"/"))."'");
        if ($type == 'dir') {
            $this->db->query("
                DELETE FROM `" . DB_PREFIX . "amazon_s3_source`
                WHERE `directory`='".$path."'");
            $path = $path."/";
        }
        $result =  $this->client->deleteObject(array(
            'Bucket' => $this->bucket,
            'Key' => $path,
        ));
        
    }
    public function upload($data, $type) {
        if (!$this->config->get('amazon_s3_status')) {
            $log = new Log('amazon_s3.log');
            $log->write('Amazon S3 module is disabled.');

            return false;
        }

        $bucketPath = $data['path'];

        if (!$this->accessKey || !$this->secretKey || !$this->bucket || !$bucketPath) {
            $log = new Log('amazon_s3.log');
            $log->write('Missing Amazon S3 setting(s).');

            return false;
        }

        $fileContents = $data['content'];

        $fileName = isset($data['name_remote']) ? $data['name_remote'] : $data['name'];

        $acl = '';

        if ($type == 'download') {
            if ($this->config->get('amazon_s3_cloudfront_status') == '1') {
                $acl = 'public-read';
            } else {
                $acl = 'authenticated-read';
            }
        } elseif ($type == 'image') {
            $acl = 'public-read';
        } elseif ($type == 'folder') {
            $acl = 'public-read-write';
        }elseif ($type == 'sourceFile') {
            $acl = 'public-read';
        }
if($type == 'folder'){
    
$this->client->putObject([
            'Bucket' => $this->bucket,
            'Key' => $bucketPath . $fileName."/",
            'Body' => $fileContents,
            'ACL' => $acl
        ]);
            
}elseif($type == 'sourceFile'){
    $this->client->putObject([
        'Bucket' => $this->bucket,
        'Key' => $bucketPath . $fileName,
        'SourceFile' => $fileContents,
        'ACL' => $acl
    ]);
}else{
    
        $this->client->putObject([
            'Bucket' => $this->bucket,
            'Key' => $bucketPath . $fileName,
            'Body' => $fileContents,
            'ACL' => $acl
        ]);
}
        if ($type == 'image') {
            $this->db->query("
                REPLACE INTO `" . DB_PREFIX . "amazon_s3_image` (`filename`)
                VALUES ('" . $this->db->escape($data['name']) . "')");
        } elseif ($type == 'download') {
            $this->db->query("
                REPLACE INTO `" . DB_PREFIX . "amazon_s3_download` (`filename_local`, `filename_remote`)
                VALUES ('" . $this->db->escape($data['name']) . "', '" . $this->db->escape($data['name_remote']) . "')");
        }elseif($type == 'folder'){
                $this->db->query("
                REPLACE INTO `" . DB_PREFIX . "amazon_s3_source` (`filename`, `directory`,`type`)
                VALUES ('" . substr($this->db->escape($data['name']),strripos($this->db->escape($data['name']),"/")+1) . "','image/".substr($this->db->escape($data['name']),0,strripos($this->db->escape($data['name']),"/"))."','dir')");
            
        }elseif ($type == 'sourceFile') {
            $this->db->query("
                REPLACE INTO `" . DB_PREFIX . "amazon_s3_source` (`filename`, `directory`,`type`)
                VALUES ('" . substr($this->db->escape($data['name']),strripos($this->db->escape($data['name']),"/")+1) . "','image/".substr($this->db->escape($data['name']),0,strripos($this->db->escape($data['name']),"/"))."','file')");
                        }

        return true;
    }

    public function fileExists($file) {
        return $this->db->query("
            SELECT SUM(`count`) AS 'count'
            FROM (
                SELECT COUNT(*) AS `count`
                FROM `" . DB_PREFIX . "amazon_s3_image`
                WHERE `filename` = '" . $this->db->escape($file) . "'

                UNION ALL

                SELECT COUNT(*)
                FROM `" . DB_PREFIX . "amazon_s3_download`
                WHERE `filename_local` = '" . $this->db->escape($file) . "'
            ) AS `counts`")->row['count'] == 1;
    }
    
    public function s3FileExists($file) {
        //no_image.jpg
        if(strripos($file,"/")){
            $filename = substr($file,strripos($file,"/")+1);
            $directory = "image/".substr($file,0,strripos($file,"/"));
        }else{
            $filename = $file;
            $directory = "image";
            
        }
        return $this->db->query("SELECT COUNT(*) AS `count`
                FROM `" . DB_PREFIX . "amazon_s3_source`
                WHERE `filename` = '" .$filename."' AND `directory` = '".$directory."'")->row['count'] == 1;
    }
    public function isFile($file) {
        //catalog/bannerall.jpg
        $filename = substr($file,strripos($file,"/")+1);
        $directory = substr($file,0,strripos($file,"/"));
        $query = $this->db->query("SELECT type  FROM `" . DB_PREFIX . "amazon_s3_source` WHERE `filename` = '" .$filename."' AND `directory` = '".$directory."'");
        if($query->row['type'] == "file"){
            return 1;
        }else{
            return 0;
        }
    }
    
    
    
    public function getIterator() {
         //$iterator = $this->client->listBuckets();
        $iterator = $this->client->getIterator('ListObjects', array(
            'Bucket' => $this->bucket,
            'Prefix' => "image/catalog/"
        ));
    
        $urls = $iterator->toArray();
         foreach ($urls as $url){
           // var_dump(strpos($url['Key'],"image/catalog/"));
                $directory = substr($url['Key'],0,strripos($url['Key'],"/"));
                $filename = substr($url['Key'],strripos($url['Key'],"/")+1);
                $type = "file";
               // var_dump(substr($url['Key'],-1,1) == "/" );
                 if(substr($url['Key'],-1,1) == "/"){
                   $sub_url = substr($url['Key'],0,-1);
                   $filename = substr($sub_url,strripos($sub_url,"/")+1);
                   $type = "dir";
                    if($url['Key']=="image/catalog/"){
                        $directory = "/";
                    }else{
                      $directory = substr($url['Key'],0,strripos($sub_url,"/")) ;
                    }
                    
                }
                
                 $this->db->query("
                REPLACE INTO `" . DB_PREFIX . "amazon_s3_source`
                 SET filename ='" . $this->db->escape($filename) ."', directory='".$this->db->escape($directory)."', type='".$type."'");
        } 
        
    }
    
    public function getDirectories($data){
        $sql = "SELECT * FROM `" . DB_PREFIX . "amazon_s3_source` WHERE directory='".$data['directory']."'";
        if(!empty($data['filter_name'])){
            $sql .= "AND filename like'%".$data['filter_name']."%'";
        }
        if (isset($data['start']) || isset($data['limit'])) {
            if ($data['start'] < 0) {
                $data['start'] = 0;
            }
        
            if ($data['limit'] < 1) {
                $data['limit'] = 15;
            }
        
            $sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
        }
        return $this->db->query($sql)->rows;
    }
    public function getDirectoriesTotal($data){
        $sql = "SELECT COUNT(*) as total FROM `" . DB_PREFIX . "amazon_s3_source` WHERE directory='".$data['directory']."'";
        if(!empty($data['filter_name'])){
            $sql .= "AND filename like'%".$data['filter_name']."%'";
        }
        return $this->db->query($sql)->row['total'];
    }
    
}
