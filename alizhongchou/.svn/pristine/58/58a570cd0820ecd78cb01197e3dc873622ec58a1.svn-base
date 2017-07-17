<?php
class ModelToolOptimizer extends Model {
	private $commandlist = array('jpeg'=>array('optimizer'=> 'jpegoptim',
			'options'  =>array(
					'jpegoptim_options' => array('--max=90', '--strip-all', '--all-progressive'),
					'jpegoptim_bin' 	 => '/bin/jpegoptim',
					'ignore_errors' 	 => false)),
			'png' => array('optimizer'=> 'optipng',
					'options'   =>array(
							'optipng_bin' 	     => '/bin/optipng',
							'optipng_options'   => array('-i0', '-o2', '-quiet'),
							'ignore_errors' 	 => false)),
			'gif' => array('optimizer'=>'gifsicle',
					'options'  =>array(
							'gifsicle_bin'      => '/bin/gifsicle',
							'gifsicle_options'	 => array('-b', '-O3'),
							'ignore_errors' 	 => false)));
	public function myoptimizer($filepath)
	{
		$typeguesser = new \ImageOptimizer\TypeGuesser\SmartTypeGuesser();

		if(!$typeguesser->guess($filepath)){
			return;
		}
		$filetype = $typeguesser->guess($filepath);
		
		$factory = new \ImageOptimizer\OptimizerFactory($this->commandlist[$filetype]['options']);
		$optimizer = $factory->get($this->commandlist[$filetype]['optimizer']);
		//when
		try {
			$optimizer->optimize($filepath);
		} catch (CommandNotFound $e) {
			echo sprintf('%s is not executable', $this->commandlist[$filetype]['optimizer']) . '<br>';
			}
	}
	public function scanpath($filepath){
		if(is_dir($filepath)){
			echo 'Path:  ' . $filepath . ' <br>';
			$filepath = substr($filepath, mb_strlen($filepath,'utf-8') - 1) == '/' ? $filepath . '*' : $filepath . '/*';
			$paths = glob($filepath);
			foreach ($paths as $path){
				$this->scanpath($path);
			}
		}else{
			$extension = pathinfo($filepath, PATHINFO_EXTENSION);
			if(!in_array($extension, array('jpg', 'jpeg', 'png', 'gif'))){
				return;
			}
			echo 'File:  ' . $filepath . ' <br>';
			$this->myoptimizer($filepath);
		}
	}
}