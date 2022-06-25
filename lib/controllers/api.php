<?php 

header('Content-Type: application/json');
$return["error"] = false;
$return["msg"] = "";
$return["success"] = false;
//array to return

$getPost = (json_encode(file_get_contents('php://input',true)));
$jsondecoded = utf8_encode($getPost);

echo(json_last_error());
var_dump($getPost);
var_dump($jsondecoded);
var_dump($_FILES['file']);

if(isset($_FILES["file"])){
    //directory to upload file
    $target_dir = "PDFs/"; //create folder files/ to save file
    $filename = $_FILES["file"]["name"]; 
    //name of file
    //$_FILES["file"]["size"] get the size of file
    //you can validate here extension and size to upload file.
    $cripto = md5($filename);
    //rename($filename,$cripto);
    $savefile = "$target_dir/$cripto";
    //complete path to save file

    if(move_uploaded_file($_FILES["file"]["tmp_name"], $savefile)) {
        $return["error"] = false;
        $return["msg"] =  "upload successful $cripto";
    }else{
        $return["error"] = true;
        $return["msg"] =  "Error during saving file. $cripto";
    }
}else{
    $return["error"] = true;
    $return["msg"] =  "No file is sublitted. ";
}
   

// tell browser that its a json data
echo json_encode($return);
//converting array to JSON string
?>


<?php

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === "POST") {
    $json = file_get_contents('php://input');
    $data = json_decode($json);
    
    $desenvolvedor1 = $data->{'desenvolvedor1'};
    $desenvolvedor2 = $data->{'desenvolvedor2'};
    $desenvolvedor3 = $data->{'desenvolvedor3'};
    $curso = $data->{'curso'};
    $ciclo = $data->{'ciclo'};
    $titulo = $data->{'titulo'};
    $orientador = $data->{'orientador'};
    $resumo = $data->{'resumo'};
    
    $pdf = md5($data->{'pdf'});
    $projeto = $data->{'projeto'};
    try {
        $conn = new PDO('mysql:localhost;dbname=id16412277_repo','id16412277_repositorio', '>vC?3FsWY+H#[<r0');
        $stmt = $conn->prepare("INSERT INTO id16412277_repo.trabalhos (dev1, dev2, dev3, curso, ciclo, titulo, orientador, descri, pdf, projeto) VALUES (:dev1, :dev2, :dev3, :curso, :ciclo, :titulo, :orientador, :resumo, :pdf, :projeto)");
        $stmt->execute(array(":dev1" => $desenvolvedor1, ":dev2" => $desenvolvedor2, ":dev3" => $desenvolvedor3, ":curso" => $curso, ":ciclo" => $ciclo, ":titulo" => $titulo, ":orientador" => $orientador, ":resumo" => $resumo, ":pdf" => $pdf, ":projeto"=>$projeto));
    } catch (PDOException $e) {
        echo $e->getMessage();
    }
    
    if ($stmt->rowCount() > 0) {
        http_response_code(200);
        echo json_encode(array("message" => "OK"));
    } else {
        http_response_code(400);
        echo json_encode(array("message" => "FAIL"));
    }
} else {
    http_response_code(400);
    echo json_encode(array("message" => "invalid method request"));
}

    
   
?>