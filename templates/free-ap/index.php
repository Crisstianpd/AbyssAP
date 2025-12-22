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
    <title>FreeAP | Login</title>
</head>

<body>
    <form action="process.php" method="post">
        <h2 class="desc">BIENVENIDOS A FREEAP</h2>
        <p class="desc">Completa tus datos para <br> darte acceso a la red</p>
        <div class="textInput">
            <label for="nombre">Nombre</label>
            <input type="text" id="nombre" name="nombre" required>
        </div>
        <div class="textInput">
            <label for="apellido">Apellido</label>
            <input type="text" id="apellido" name="apellido" required>
        </div>
        <div class="textInput">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" placeholder="example@gmail.com" required>
        </div>
        <div class="textInput">
            <label for="tel">Teléfono</label>
            <div class="telContainer">
                <select id="countryCode">
                    <option value="+34">🇪🇸</option>
                    <option value="+507">🇵🇦</option>
                    <option value="+52">🇲🇽</option>
                    <option value="+1">🇺🇸</option>
                    <option value="+33">🇫🇷</option>
                </select>
                <input type="tel" id="tel" name="tel" inputmode="numeric" pattern="[0-9]*" required>
            </div>
        </div>
        <div class="termCont">
            <input type="radio" id="termC" name="termC" required>
            <label for="termC">Acepto <a href="./terminos_y_condiciones.html">Términos y condiciones</a></label>
        </div>
        <input type="hidden" name="csrf" value="<?= $_SESSION['csrf'] ?>">
        <input class="button-send" type="submit" value="SIGUIENTE">
    </form>
    <footer>
        <p>© FreeAP – Todos los derechos reservados</p>
    </footer>
</body>

<style>
    * {
        font-family: sans-serif;
        margin: 0;
        padding: 0;
    }

    footer {
        color: gray;
        display: flex;
        width: 100%;
        justify-content: center;
        margin-top: 50px;
    }

    label {
        color: white;
    }

    h2 {
        text-shadow: 0 0 30px rgba(173, 170, 96, 1);
    }

    .desc {
        text-align: center;
    }

    form {
        margin: auto;
        margin-top: 30px;
        background-color: rgb(34, 167, 255);
        border-radius: 10px;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        gap: 30px;
        width: 40%;
        min-width: 300px;
        padding: 30px 20px;
        & h2 {
            color: rgb(255, 218, 116);
        }

        & p {
            color: white;
        }
    }

    .textInput {
        display: flex;
        flex-direction: column;
        width: 100%;
        justify-content: center;
        gap: 5px;

        & label {
            font-weight: bold;
        }

        & input,
        select {
            height: 40px;
            border: 0;
            border-radius: 5px;
            padding: 0 10px;
        }
    }

    .telContainer {
        display: flex;
        width: 100%;

        & input {
            width: 100%;
            border-radius: 0 5px 5px 0;
        }

        & select {
            width: max-content;
            border-radius: 5px 0 0 5px;
        }
    }

    .termCont {
        display: flex;
        flex-direction: row;
        align-items: center;
        gap: 10px;

        & label a {
            font-weight: bold;
            color: white;
        }

        & input {
            width: 20px;
            height: 20px;
        }
    }

    .button-send {
        height: 40px;
        border: 0;
        border-radius: 5px;
        padding: 0 30px;
        font-size: 17px;
        font-weight: bold;
        background-color: rgb(0, 124, 191);
        color: white;
        cursor: pointer;

        &:hover {
            background-color: rgb(0, 95, 147);
            transition: 0.3s;
        }
    }
</style>

</html>