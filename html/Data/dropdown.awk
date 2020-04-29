BEGIN {
	  FS = ","
      }
NR{
	max_nf = 0;
	man_nr = 0;
	if(max_nf < NF )
		max_nf = NF
	max_nr = NR
	for( x=1; x<=NF; x++)
		vector[x,NR] = $x
}

END {
  outf = "dropdown.php" ;
  print "<!DOCTYPE html>" > outf
  print "<html>" > outf
  print "<head>" > outf
  print "<title>PHP!</title>" > outf
  print "</head>" > outf
  print "<body>" > outf

  printf "<label for=\"movie\">Select a movie from the Dropdown dial:</label>\n" > outf
  print  "<form method=\"POST\">" > outf
  print  "<select name=\"movie\">" > outf
     for (x = 1; x <= max_nr; x++) {
	print "\t<option value=\"" vector[1,x] "\">"  vector[1,x] "</option>"   > outf
     }
  print "</select>\n" > outf
  print "</br>" > outf
  printf "<label for=\"Uname\">Enter your name:</label>\n" > outf
  print "<input  type=\"text\" name=\"q\">" > outf
  print "</br>" > outf
  print "<label for=\"Enter\"> Click select to cast your vote:</label>" > outf

  print " <input type=\"submit\" name=\"submit\" value=\"Select\" />" > outf
  print " </form> " > outf

  
print " <?php " > outf
print "     if( isset($_POST['submit'])) " > outf
print "     { " > outf
print "           $getmovie = $_POST['movie']; " > outf
print "           $getname = $_POST['q']; " > outf
print "	   $var = $getmovie;" > outf

print "	  $usename = $getname; " > outf
print "	  if( strlen($usename) <=0 ){ " > outf
print "		echo \"Please Enter username\"; " > outf
print "		return \" \"; " > outf
print "	  } " > outf
print "	  $filename = \"./Data/Names.txt\" ; " > outf
print "	  if(file_exists($filename)){ " > outf
print "	  	$fname = fopen(\"./Data/Names.txt\",\"r\") or die(\"Unable to open write file!\"); " > outf
print "		while( !feof($fname) ){ " > outf
print "			$readn = fgets($fname,20); " > outf
print "			$readn = str_replace(array(\"\n\", \"\r\"), '', $readn);"> outf
print "			if( strcmp( $usename, $readn) == 0 ){ " > outf
print "				fclose($fname); " > outf
print "				echo \"Already voted\"; " > outf
print "				return \" \"; " > outf
print "			} " > outf
print "		} " > outf
print "		fclose($fname); " > outf
print "	  	$fname  = fopen(\"./Data/Names.txt\",\"a\") or die(\"Unable to open write file!\"); " > outf
print "		fwrite($fname,\"\\n\"); " > outf
print "		fwrite($fname,$usename); " > outf
print "		fclose($fname); " > outf
print "	  }else{ " > outf
print "	  	$fname  = fopen(\"./Data/Names.txt\",\"w\") or die(\"Unable to open write file!\"); " > outf
print "		fwrite($fname,$usename); " > outf
print "		fclose($fname); " > outf
print "	  } " > outf
print " " > outf
print " " > outf


print "	   $json = file_get_contents('./Data/tf.json'); " > outf
print "	   $json_data = json_decode($json,true); " > outf
print "	   $outfile = fopen(\"./Data/Option.txt\",\"w\") or die(\"Unable to open write file!\"); " > outf
print " $data = fopen(\"./Data/data.txt\",\"w\") or die(\"Unable to open write file!\");" > outf
print " $i = 0;" > outf

print "	   foreach ($json_data as $key1 => $value1 ) { " > outf
print "		   if( strcmp($json_data[$key1][\"name\"], $var)== 0 ) " > outf
print "			$json_data[$key1][\"Poll\"] = $json_data[$key1][\"Poll\"] + 1; " > outf
print "              	   fwrite($outfile,$json_data[$key1][\"name\"]);" > outf
print "	           fwrite($outfile,\",\");" > outf
print "		   fwrite($outfile,$json_data[$key1][\"Poll\"]);" > outf
print "		   fwrite($outfile,\"\\n\");" > outf

print "		   if( $i == 0 ) " > outf
print "		   	fwrite($data,'{ label: \"'); " > outf
print "		   else{ " > outf
print "		   	fwrite($data,\",\\n\"); " > outf
print "			fwrite($data,'{ label: \"'); " > outf
print "		   } " > outf
print "		   fwrite($data,$json_data[$key1][\"name\"]); " > outf
print "		   fwrite($data,'\",   y:'); " > outf
print "		   fwrite($data,$json_data[$key1][\"Poll\"]); " > outf
print "		   fwrite($data,\"}\"); " > outf
print " 	   $i = $i + 1;" > outf
print "	   } " > outf
print "	   fclose($outfile);" > outf
print "	   $json = json_encode( $json_data );" > outf
print "	   fclose($outfile);" > outf
print "	   file_put_contents( './Data/tf.json', $json );" > outf
print "    exec('cat ./Data/d1.txt ./Data/data.txt ./Data/d2.txt > ./Data/plt.html ');" > outf
print "       }" > outf
print "?>" > outf
print "<h2></h2>" > outf
print "                <iframe src=\"Data/plt.html\" width=600 height=400></iframe>" > outf
print " </body>" > outf
print " " > outf
}
