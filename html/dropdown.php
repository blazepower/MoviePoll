<!DOCTYPE html>
<html>
<head>
<title>PHP!</title>
</head>
<body>
<label for="movie">Select a movie from the Dropdown dial:</label>
<form method="POST">
<select name="movie">
	<option value="Adam">Adam</option>
	<option value="Bob">Bob</option>
	<option value="Primo1">Primo1</option>
	<option value="Primo">Primo</option>
	<option value="Kaneko">Kaneko</option>
</select>

</br>
<label for="Uname">Enter your name:</label>
<input  type="text" name="q">
</br>
<label for="Enter"> Click select to cast your vote:</label>
 <input type="submit" name="submit" value="Select" />
 </form> 
 <?php 
     if( isset($_POST['submit'])) 
     { 
           $getmovie = $_POST['movie']; 
           $getname = $_POST['q']; 
	   $var = $getmovie;
	  $usename = $getname; 
	  if( strlen($usename) <=0 ){ 
		echo "Please Enter username"; 
		return " "; 
	  } 
	  $filename = "./Data/Names.txt" ; 
	  if(file_exists($filename)){ 
	  	$fname = fopen("./Data/Names.txt","r") or die("Unable to open write file!"); 
		while( !feof($fname) ){ 
			$readn = fgets($fname,20); 
			$readn = str_replace(array("
", ""), '', $readn);
			if( strcmp( $usename, $readn) == 0 ){ 
				fclose($fname); 
				echo "Already voted"; 
				return " "; 
			} 
		} 
		fclose($fname); 
	  	$fname  = fopen("./Data/Names.txt","a") or die("Unable to open write file!"); 
		fwrite($fname,"\n"); 
		fwrite($fname,$usename); 
		fclose($fname); 
	  }else{ 
	  	$fname  = fopen("./Data/Names.txt","w") or die("Unable to open write file!"); 
		fwrite($fname,$usename); 
		fclose($fname); 
	  } 
 
 
	   $json = file_get_contents('./Data/tf.json'); 
	   $json_data = json_decode($json,true); 
	   $outfile = fopen("./Data/Option.txt","w") or die("Unable to open write file!"); 
 $data = fopen("./Data/data.txt","w") or die("Unable to open write file!");
 $i = 0;
	   foreach ($json_data as $key1 => $value1 ) { 
		   if( strcmp($json_data[$key1]["name"], $var)== 0 ) 
			$json_data[$key1]["Poll"] = $json_data[$key1]["Poll"] + 1; 
              	   fwrite($outfile,$json_data[$key1]["name"]);
	           fwrite($outfile,",");
		   fwrite($outfile,$json_data[$key1]["Poll"]);
		   fwrite($outfile,"\n");
		   if( $i == 0 ) 
		   	fwrite($data,'{ label: "'); 
		   else{ 
		   	fwrite($data,",\n"); 
			fwrite($data,'{ label: "'); 
		   } 
		   fwrite($data,$json_data[$key1]["name"]); 
		   fwrite($data,'",   y:'); 
		   fwrite($data,$json_data[$key1]["Poll"]); 
		   fwrite($data,"}"); 
 	   $i = $i + 1;
	   } 
	   fclose($outfile);
	   $json = json_encode( $json_data );
	   fclose($outfile);
	   file_put_contents( './Data/tf.json', $json );
    exec('cat ./Data/d1.txt ./Data/data.txt ./Data/d2.txt > ./Data/plt.html ');
       }
?>
<h2></h2>
                <iframe src="Data/plt.html" width=600 height=400></iframe>
 </body>
 
