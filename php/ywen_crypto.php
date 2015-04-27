<?php

/**
 *
 */
class CryptManager
{
    private static $pubKey;
    private static $privateKey;
    
    public static function getKeys($pubPath, $privatePath) {
        $pubFile = fopen($pubPath, "r");
        $privateFile = fopen($privatePath, "r");
        
        $pubStr = fread($pubFile, filesize($pubPath));
        $privateStr = fread($privateFile, filesize($privatePath));
        fclose($pubFile);
        fclose($privateFile);
        
        self::$pubKey = openssl_pkey_get_public($pubStr);
        self::$privateKey = openssl_pkey_get_private($privateStr, "");
    }
    function CryptManager($pubPath, $privatePath) {
        self::getKeys($pubPath, $privatePath);
    }

    
    public static function rsaEncrypt($str) {
        if (openssl_public_encrypt($str, $encryptData, self::$pubKey)) {
            return base64_encode($encryptData);
        }
    }
    
    public static function rsaDecrypt($str) {
        if (openssl_private_decrypt(base64_decode($str), $decryptStr, self::$privateKey)) {
            return $decryptStr;
        }
    }
    
    /**加密*/
    public static function desEncrypt($str, $key) {
        $size = mcrypt_get_block_size(MCRYPT_DES, MCRYPT_MODE_CBC);
        $str = $this->pkcs5Pad($str, $size);
        $iv = array(1, 2, 3, 4, 5, 6, 7, 8);
        $data = mcrypt_cbc(MCRYPT_DES, $key, $str, MCRYPT_ENCRYPT, $iv);

        return base64_encode($data);
    }
    
    /**解密*/
    public static function desDecrypt($str, $key) {
        $str = base64_decode($str);
        $iv = array(1, 2, 3, 4, 5, 6, 7, 8);
        $str = mcrypt_cbc(MCRYPT_DES, $key, $str, MCRYPT_DECRYPT, $iv);
        $str = $this->pkcs5Unpad($str);
        return $str;
    }
    function pkcs5Pad($text, $blocksize) {
        $pad = $blocksize - (strlen($text) % $blocksize);
        return $text . str_repeat(chr($pad), $pad);
    }
    function pkcs5Unpad($text) {
        $pad = ord($text{strlen($text) - 1});
        if ($pad > strlen($text)) return false;
        if (strspn($text, chr($pad), strlen($text) - $pad) != $pad) return false;
        return substr($text, 0, -1 * $pad);
    }
}
?>
