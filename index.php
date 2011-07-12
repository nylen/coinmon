<?php
error_reporting(E_ALL & ~E_NOTICE);

exec('DISPLAY=:0 aticonfig --lsa', $adapters_info);
$adapters = array();

for($i = 0; $i < count($adapters_info); $i++) {
  if(!trim($adapters_info[$i])) {
    break;
  }

  $this_adapter_info = preg_replace('@^[ *]+@', '', $adapters_info[$i]);
  $this_adapter_info = explode(' ', $this_adapter_info);

  $adapter_index = floor($this_adapter_info[0]);

  $adapter_name = '';
  for($j = 1; $j < count($this_adapter_info); $j++) {
    if(preg_match('@^([0-9]+|Series)$@i', $this_adapter_info[$j])) {
      $adapter_name .= "$this_adapter_info[$j] ";
    }
  }

  $adapters[$adapter_index] = strtolower(trim($adapter_name));
}

?>
<html>
  <head>
    <title>Bitcoin mining status</title>
    <script type="text/javascript" src="jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="jquery.tools.min.js"></script>
    <script type="text/javascript" src="script.js"></script>
    <link rel="stylesheet" type="text/css" href="style.css">
  </head>
  <body>
    <ul id="tab-links">
<?php foreach($adapters as $index => $name) {
  echo <<<HTML
      <li>
        <a class="tab-link" id="link-miner$index" href="#miner$index">
          Miner $index: $name
        </a>
      </li>

HTML;
}
?>
      <li>
        <a class="tab-link" id="link-processes" href="#processes">
          Processes
        </a>
      </li>
      <li>
        <a class="tab-link" id="link-pool" href="#pool">
          Pool info
        </a>
      </li>
    </ul>
    <div id="tabs">
<?php foreach($adapters as $index => $name) {
  echo <<<HTML
      <div class="tab">
        <fieldset>
          <legend>Miner log</legend>
          <div class="file" data-file="miner$index"></div>
        </fieldset>
        <fieldset>
          <legend>Temperature</legend>
          <div class="file" data-file="temp$index"></div>
        </fieldset>
        <fieldset>
          <legend>Clock info</legend>
          <div class="file" data-file="clock$index"></div>
        </fieldset>
        <fieldset>
          <legend>Fan speed</legend>
          <div class="file" data-file="fan$index"></div>
        </fieldset>
      </div>

HTML;
} ?>
      <div class="tab">
        <div class="file" data-file="processes"></div>
      </div>
      <div class="tab">(TODO: pool info)</div>
    </div>
  </body>
</html>

