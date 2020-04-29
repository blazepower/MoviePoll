<!DOCTYPE  HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"  "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <p><body>
    <h3>Search  For your Favorite Movie</h3>
    <p>Movie title</p>
    <form  method="POST" action="search.php">
      <input  type="text" name="q">
      <input  type="submit" name="submit" value="Search">
    </form>
  </body>
</html>
<?php
  if ( isset($_POST['submit'])){
	  $getmovie = $_POST['q'];
	  echo $getmovie ;
  }
?>
</p>
