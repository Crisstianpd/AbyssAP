<?php
session_start();
if (empty($_SESSION['csrf'])) {
    $_SESSION['csrf'] = bin2hex(random_bytes(32));
}
?>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
</head>

<body>
    <form action="process.php" method="post">
        <h2>Login Form Test</h2>
        <div>
            <p for="username">Username</p>
            <input type="text" id="username" name="username" required>
        </div>
        <div>
            <p for="password">Password</p>
            <input type="password" id="password" name="password" required>
        </div>
        <input type="hidden" name="csrf" value="<?= $_SESSION['csrf'] ?>">
        <input class="button-send" type="submit" value="Send">
    </form>
</body>

<style>
    * {
        font-family: sans-serif;
    }
    form {
        margin: auto;
        margin-top: 100px;
        background-color: rgb(203, 203, 203);
        border-radius: 10px;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        gap: 20px;
        width: 50%;
        max-width: 400px;
        min-width: 200px;
        padding: 30px 10px;
        position: relative;
        top: calc(50% - 218px);

        & * {
            margin: 0;
        }
    }

    .button-send {
        width: 50px;
    }
</style>

</html>