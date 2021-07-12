<?php 
    class BaseDeDatos
    {
        public string $servidor = "";
        public string $usuario = "";
        public string $contraseña = "";
        public string $base_de_datos = "";
        
        public function __construct(string $servidor, string $usuario, string $contraseña, string $db)
        {
            $this->servidor = $servidor;
            $this->usuario = $usuario;
            $this->contraseña = $contraseña;
            $this->base_de_datos = $db;

            $link = @mysqli_connect($servidor, $usuario, $contraseña,$db);

            if (!$link) 
            {
                // En caso de que la conexión sea erronea mostramos un mensaje de error y detenemos la aplicación.
                $m = '<div style="font-family:' . " 'Courier New', Courier, monospace;" . '">';
                $m .= "Ejecución en el contructor de la base de datos.<br>";
                $m .= "- Error con la conexión de la base de datos<br><br>";
                $m .= "- Mensaje de error: " . mysqli_connect_error();
                $m .= "</div>";
                die($m);
            }
        }

        public function ejecutar_consulta(string $comando_sql)
        {
            $conecion = mysqli_connect($this->servidor, $this->usuario, $this->contraseña, $this->base_de_datos);

            $resultado = $conecion->query($comando_sql);
            $conecion->close();
            return $resultado;
        }



    }

?>