<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
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

  # Apache Server Information
  #======================
  echo "<h3>Apache Server Information</h3>";
  $host_name = php_uname("n");
  $server_addr = $_SERVER['SERVER_ADDR'];
  $server_port = $_SERVER['SERVER_PORT'];
  $server_proto = $_SERVER['SERVER_PROTOCOL'];

  $server = array(
    "PHP_UNAME:" => "<div class='bold'> $host_name </div>",
    "SERVER_ADDR:" => "<div class='normal'> $server_addr </div>",
    "SERVER_PORT:" => "<div class='normal'> $server_port </div>",
    "SERVER_PROTOCOL:" => "<div class='normal'> $server_proto </div>"
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
  echo "<h3>Remote Information</h3>";
  $remote_addr = $_SERVER['REMOTE_ADDR'];
  $remote_port = $_SERVER['REMOTE_PORT'];

  $remote = array(
    "REMOTE_ADDR:" => "<div class='normal'> $remote_addr </div>",
    "REMOTE_PORT:" => "<div class='normal'> $remote_port </div>"
  );

  echo '<table>';

     foreach ($remote as $parameter  =>  $value) {
       echo '<tr>' .
          '<td>' . $parameter .'</td>' .
          '<td>' . $value . '</td>' .
       '</tr>';
     }

  echo '</table>';
  echo '<br>';


  # Instance Metadata
  #======================
  echo "<h3>Instance Metadata</h3>";
  // get all instance metadata (from kubernetes node)
  $metadata = "http://metadata.google.internal/computeMetadata/v1";
  $header_array = array("Metadata-Flavor: Google");
  $fields = array(
    "SERVICE_ACCOUNT:" => "instance/service-accounts/",
    "INSTANCE_ZONE:" => "instance/zone",
    "INSTANCE_TAGS:" => "instance/tags",
    "CLUSTER_LOCATION:" => "instance/attributes/cluster-location",
    "CLUSTER_NAME:" => "instance/attributes/cluster-name"
  );

  echo '<table>';
     foreach ($fields as $parameter  =>  $value) {
       $ch = curl_init();
       $options = array(CURLOPT_URL => "$metadata/$value");
       curl_setopt($ch, CURLOPT_HTTPHEADER, $header_array);
       curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
       curl_setopt_array($ch, $options);
       $curl_res = curl_exec($ch);

       echo '<tr>' .
          '<td>' . $parameter .'</td>' .
          '<td>' . "<div class='normal'> $curl_res </div>" . '</td>' .
       '</tr>';

       curl_close($ch);
     }

  echo '</table>';
  echo '<br>';

  # Pod Environment Variables
  #======================
  echo "<h3>Pod Environment Variables</h3>";
  $node_ip = $_ENV['NODE_IP'];
  $pod_name = $_ENV['POD_NAME'];
  $pod_ip = $_ENV['POD_IP'];
  $pod_namespace = $_ENV['POD_NAMESPACE'];
  $pod_service_account = $_ENV['POD_SERVICE_ACCOUNT'];
  $pod_uid = $_ENV['POD_UID'];
  $pod_labels = $_ENV['POD_LABELS'];
  $pod_annotations = $_ENV['POD_ANNOTATIONS'];

  $pod = array(
    "NODE_IP:" => "<div class='normal'> $node_ip </div>",
    "POD_IP:" => "<div class='normal'> $pod_ip </div>",
    "POD_NAME:" => "<div class='normal'> $pod_name </div>",
    "POD_NAMESPACE:" => "<div class='normal'> $pod_namespace </div>",
    "POD_SERVICE_ACCOUNT:" => "<div class='normal'> $pod_service_account </div>",
    "POD_UID:" => "<div class='normal'> $pod_uid </div>",
    "POD_LABELS:" => "<div class='normal'> $pod_labels </div>",
    "POD_ANNOTATIONS:" => "<div class='normal'> $pod_annotations </div>"
  );

  echo '<table>';

     foreach ($pod as $parameter  =>  $value) {
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

  # Headers
  #======================
  echo "<h3>Headers</h3>";
  echo '<table>';

     foreach ($headers as $header => $value) {
       echo '<tr>' .
          '<td>' . $header .':</td>' .
          '<td>' . $value . '</td>' .
       '</tr>';
     }

  echo '</table>';
  echo '<br>';

  # kube-env parameters
  #======================
  echo "<h3>kube-env</h3>";
  // get all kube-env parameters
  $metadata = "http://metadata.google.internal/computeMetadata/v1";
  $header_array = array("Metadata-Flavor: Google");
  $field = "instance/attributes/kube-env";
  $ch = curl_init();
  $options = array(CURLOPT_URL => "$metadata/$field");
  curl_setopt($ch, CURLOPT_HTTPHEADER, $header_array);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
  curl_setopt_array($ch, $options);
  $curl_res = curl_exec($ch);
  curl_close($ch);
  echo $curl_res;

?>

</body>
</html>
