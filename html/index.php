<!DOCTYPE html>
<html>
<head>
<title>PHP!</title>
</head>
<body>

</body>

<?php
$json = file_get_contents('./Data/tf.json');

//Decode JSON
$json_data = json_decode($json,true);

exec('rm -rf ./Data/Option.txt ./Data/plt.html dropdown.php');
$outfile = fopen("./Data/Option.txt","w") or die("Unable to open write file!");

foreach ($json_data as $key1 => $value1) {
		fwrite($outfile,$json_data[$key1]["name"]);
		fwrite($outfile,",");
		fwrite($outfile,$json_data[$key1]["Poll"]);
		fwrite($outfile,"\n");
	}
        fclose($outfile);

	$command = "awk -f ./Data/dropdown.awk ./Data/Option.txt";
	exec($command);
?>

<iframe src="search.php" width=650 height=600> </iframe>

<iframe src="dropdown.php" width=650 height=600> </iframe>

</html>

