<?php

$file = $_GET['file'];

if(preg_match('@^[a-z]+[0-9]*$@', $file)) {
  $file = "/tmp/bc-$file.txt";
} else {
  die('Invalid file requested');
}

if(is_file($file)) {
  $mtime = date('m/d/Y g:i:s a', filemtime($file));
  $contents = trim(file_get_contents($file));
  echo <<<HTML
<div class="mtime">Last updated: $mtime</div>
<pre class="contents">$contents</pre>
HTML;
} else {
  echo 'File not found';
}
?>
