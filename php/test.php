<?php
require_once 'ywen_crypto.php';

function testRsa() {
    echo "test rsa \n";
    $cryptManager = new CryptManager("rsa_public_key.pem", "private_key.pem");
    $encryptStr = $cryptManager->rsaEncrypt("http://wo.yao.cl");
    $decryptStr = $cryptManager->rsaDecrypt($encryptStr);
    echo "encrypt Str is ", $encryptStr;
    echo "\n";
    echo "decrypt str is ", $decryptStr;
    echo "\n";
}

function testRsaWithIos() {
    echo "test rsa with ios\n";
    $iosEncryptStr = "mc50HDojd0M7tMFk2IuirZPiKG8sNOABQshIPJ0awi1/zMHLC3JaLVC1Pwt23UY5CpXQTuUwuaEkX68JGSiUEvREKtnX8u/n+Zf+WcpSwU/RkF8P9LGhscgM2yoy6JHoB3BBHAAJf4Ilt9tW2mu2GKt5v+y5nuP97Kv582XfmvU=";
    $cryptManager = new CryptManager("rsa_public_key.pem", "private_key.pem");
    $decryptStr = $cryptManager->rsaDecrypt($iosEncryptStr);
    
    if ($decryptStr == "1") {
        echo "success\n";
    }
    else
    {
        echo "failed \n";
    }
    echo "decrypt str is ", $decryptStr;
    echo "\n";
}

function testDes() {
     echo "test des \n";
    $cryptManager = new CryptManager("rsa_public_key.pem", "private_key.pem");
    $encryptStr = $cryptManager->desEncrypt("http://wo.yao.cl", "12345678");
    $decryptStr = $cryptManager->desDecrypt($encryptStr, "12345678");
    echo "encrypt Str is ", $encryptStr;
    echo "\n";
    echo "decrypt str is ", $decryptStr;
    echo "\n";
}

//test rsa
testRsa();
testRsaWithIos();

//test des
//testDes();
?>