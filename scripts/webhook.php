<?php
// This php script receives post requests from the Github webhook, calls the update script, and logs the result
define('SECRET','');
$postBody = file_get_contents('php://input');
$mac  = 'sha1=' . hash_hmac( 'sha1' , $postBody , SECRET);
$output = '';
if ( $mac !== $_SERVER['HTTP_X_HUB_SIGNATURE'] ) {
        $output .= "MAC match failed\n\nRequest:{$_SERVER["HTTP_X_HUB_SIGNATURE"]}\n\nMessage:$mac\n\n";
        $output .= "BODY: $postBody \n";
}
else {
        $output = "MAC Verified\n";
        if ( strstr($_REQUEST["ref"], "master") ) {
                $out = array();
                exec('/usr/local/bin/update-selfhosted-wiki 2>&1', $out, $exitcode);
                $output .= "Exit: $exitcode\n";
                $output .= implode("\n", $out) . "\n";
        }
        else {
                $output .= "Not master branch\n";
        }
}

file_put_contents("/var/log/webhook.log", $output);

?>

