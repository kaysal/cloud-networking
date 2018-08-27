<!DOCTYPE html>
<html>
<head>
  <style type="text/css">
  <!--
  .bold {
    color:black;
    font-weight:bold;
    font-size: x-large;
  }
  .normal {
    color:blue;
  }
  -->
  </style>
</head>
<body>
<div>
  <img src="image-here" />
</div>
<?php

  $headers = apache_request_headers();

  # Server Information
  #======================
  $host_name = php_uname("n");
  $server_addr = $_SERVER['SERVER_ADDR'];
  $server_port = $_SERVER['SERVER_PORT'];
  $server_proto = $_SERVER['SERVER_PROTOCOL'];

  $server = array(
    "GCE Hostname:" => "<div class='bold'> $host_name </div>",
    "GCE Zone:" => "<div class='bold'> region-here </div>",
    "Server IP Address:" => "<div class='normal'> $server_addr </div>",
    "Server Port:" => "<div class='normal'> $server_port </div>",
    "Server Protocol:" => "<div class='normal'> $server_proto </div>"
  );

  echo '<table>';

     foreach ($server as $parameter  =>  $value) {
       echo '<tr>' .
          '<td>' . $parameter .'</td>' .
          '<td>' . $value . '</td>' .
       '</tr>';
     }

  echo '</table>';
  echo '<br>';

  # Remote Information
  #======================
  $remote_addr = $_SERVER['REMOTE_ADDR'];
  $remote_port = $_SERVER['REMOTE_PORT'];

  echo "<h3>Remote Information</h3>";

  $client = array(
    "Remote Address:" => "<div class='normal'> $remote_addr </div>",
    "Remote Port:" => "<div class='normal'> $remote_port </div>"
  );

  echo '<table>';

     foreach ($client as $parameter  =>  $value) {
       echo '<tr>' .
          '<td>' . $parameter .'</td>' .
          '<td>' . $value . '</td>' .
       '</tr>';
     }

  echo '</table>';
  echo '<br>';

  # Custom Headers
  #======================
  $rtt = $headers['X-Client-RTT-msec'];
  $geo = $headers['X-Client-Geo-Location'];
  $region = $headers['X-Client-Region-Subdivision'];
  $lat_long = $headers['X-Client-Lat-Long'];
  $sni_host = $headers['X-TLS-SNI-Hostname'];
  $tls_ver = $headers['X-TLS-Version'];
  $tls_cipher = $headers['X-TLS-Cipher-Suite'];

  echo "<h3>GCLB Custom Headers</h3>";

  $request_context = array(
    "X-Client-RTT-msec" => "<div class='normal'> $rtt </div>",
    "X-Client-Geo-Location" => "<div class='normal'> $geo </div>",
    "X-Client-Region-Subdivision"  =>  "<div class='normal'> $region </div>",
    "X-Client-Lat-Long" => "<div class='normal'> $lat_long </div>",
    "X-TLS-SNI-Hostname" => "<div class='normal'> $sni_host </div>",
    "X-TLS-Version" => "<div class='normal'> $tls_ver </div>",
    "X-TLS-Cipher-Suite" => "<div class='normal'> $tls_cipher </div>"
  );

  echo '<table border="1" style="border-collapse:collapse";>' .
     '<tr>' .
       '<th> Header </th>' .
       '<th> Value </th>' .
     '</tr>';

     foreach ($request_context as $header => $value) {
       echo '<tr>' .
          '<td>' . $header .'</td>' .
          '<td>' . $value . '</td>' .
       '</tr>';
     }

  echo '</table><br>';

  echo "<h3>All Headers</h3>";
  echo '<table>';

     foreach ($headers as $header => $value) {
       echo '<tr>' .
          '<td>' . $header .':</td>' .
          '<td>' . $value . '</td>' .
       '</tr>';
     }

  echo '</table>';
  echo '<br>';

?>

</body>
</html>
