<?php
    require_once 'libs/base-de-datos.php';


    $d = new BaseDeDatos('LocalHost', 'root' , '', 'traductor');

    $R =  $d->ejecutar_consulta("Select * from tb_diccionario");

?>