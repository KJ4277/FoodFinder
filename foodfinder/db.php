<?php
// One place that connects to the database, used by every page.
require_once __DIR__ . '/config.php';

// Never show raw PHP or database errors to visitors on a live site.
ini_set('display_errors', '0');

function db(): mysqli {
    static $conn = null;
    if ($conn === null) {
        mysqli_report(MYSQLI_REPORT_OFF);
        $conn = @new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
        if ($conn->connect_error) {
            http_response_code(500);
            die('Sorry, the site cannot reach its database right now.');
        }
        $conn->set_charset('utf8mb4');
    }
    return $conn;
}

// Fetch a URL (used for TheMealDB). Uses cURL when available, because some
// free hosts switch off file_get_contents for web addresses.
function fetch_url(string $url) {
    if (function_exists('curl_init')) {
        $ch = curl_init($url);
        curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_TIMEOUT => 8, CURLOPT_FOLLOWLOCATION => true]);
        $out = curl_exec($ch);
        curl_close($ch);
        return $out;
    }
    return @file_get_contents($url);
}
