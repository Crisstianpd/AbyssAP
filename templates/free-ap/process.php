<?php
session_start();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    exit;
}


if (!isset($_POST['csrf'], $_SESSION['csrf']) || !hash_equals($_SESSION['csrf'], $_POST['csrf'])) {
    http_response_code(403);
    exit('CSRF validation failed');
}
unset($_SESSION['csrf']);


$logFile = __DIR__ . '/private.log';

$ip = $_SERVER['REMOTE_ADDR'] ?? 'unknown';

$hostname = ($ip === '::1' || $ip === '127.0.0.1')
? 'localhost'
: gethostbyaddr($ip);


$mac = null;
if (filter_var($ip, FILTER_VALIDATE_IP)) {
    $file = './devices.json';
    if (is_readable($file)) {

        $devices = json_decode(file_get_contents($file), true);

        if (is_array($devices) && isset($devices[$ip])) {
            if (preg_match('/^[0-9a-f]{2}(:[0-9a-f]{2}){5}$/i', $devices[$ip])) {
                $mac = strtolower($devices[$ip]);
            }
        }
    }
} else {
    $ip = 'unknown';
}


$time = date('Y-m-d H:i:s');

$userAgent = $_SERVER['HTTP_USER_AGENT'] ?? 'unknown';

$nombre = preg_replace('/[^a-zA-ZáéíóúÁÉÍÓÚñÑ]/u', '', $_POST['nombre'] ?? '');
$apellido = preg_replace('/[^a-zA-ZáéíóúÁÉÍÓÚñÑ]/u', '', $_POST['apellido'] ?? '');
$email = trim($_POST['email'] ?? '');
$tel = preg_replace('/[^0-9]/', '', $_POST['tel'] ?? '');

if ($nombre === '' || $apellido === '' || $email === '' || $tel === '') {
    http_response_code(400);
    exit;
}

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    http_response_code(400);
    exit;
}

if (strlen($nombre) > 30 || strlen($apellido) > 30 || strlen($email) > 150 || strlen($tel) > 40) {
    http_response_code(400);
    exit;
}



$log = [
    'time' => $time,
    'hostname' => $hostname,
    'nombre' => $nombre,
    'apellido' => $apellido,
    'email'=> $email,
    'telefono'=> $tel,
    'ip' => $ip,
    'mac' => $mac,
    'user_agent' => $userAgent,
];



file_put_contents(
    $logFile,
    json_encode($log, JSON_UNESCAPED_UNICODE) . PHP_EOL,
    FILE_APPEND | LOCK_EX
);

http_response_code(204);
header("Location: ./success.html");
