package com.ywen;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import javax.crypto.Cipher;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.IvParameterSpec;
import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;


/**
 * Created by wenyun on 15/4/22.
 */
public class CryptoManager {
    private RSAPrivateKey privateKey;
    private RSAPublicKey publicKey;

    public RSAPublicKey getPublicKey() {
        return publicKey;
    }

    public CryptoManager(String privateKeyStr, String publicKeyStr) {
        try {
            this.setPrivateKey(privateKeyStr);
            this.setPublicKey(publicKeyStr);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setPublicKey(String publicKeyStr) throws Exception {
        try {
            BASE64Decoder decoder = new BASE64Decoder();
            byte[] buffer = decoder.decodeBuffer(publicKeyStr);
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
            X509EncodedKeySpec keySpec = new X509EncodedKeySpec(buffer);
            this.publicKey = (RSAPublicKey)keyFactory.generatePublic(keySpec);
        }
        catch (NoSuchAlgorithmException e) {
            throw new Exception("无此加密算法");
        } catch (InvalidKeySpecException e) {
            e.printStackTrace();
            throw new Exception("私钥非法");
        } catch (IOException e) {
            e.printStackTrace();
            throw new Exception("私钥字符串读取出错");
        }
    }

    public RSAPrivateKey getPrivateKey() {
        return privateKey;
    }

    public void setPrivateKey(String privateKeyStr) throws  Exception {
        try {
            BASE64Decoder decoder = new BASE64Decoder();
            byte[] buffer = decoder.decodeBuffer(privateKeyStr);
            PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(buffer);
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
            this.privateKey = (RSAPrivateKey)keyFactory.generatePrivate(keySpec);
        }
        catch (NoSuchAlgorithmException e) {
            throw new Exception("无此加密算法");
        } catch (InvalidKeySpecException e) {
            e.printStackTrace();
            throw new Exception("私钥非法");
        } catch (IOException e) {
            e.printStackTrace();
            throw new Exception("私钥字符串读取出错");
        }
    }

    public String rsaEncrypt(String text) throws Exception {
        if (this.publicKey == null) {
            throw new Exception("请先设置公钥");
        }
        Cipher cipher = null;
        String encryptStr = null;
        try {
            cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
            cipher.init(Cipher.ENCRYPT_MODE, this.publicKey);
            byte[] textData = text.getBytes("utf-8");
            byte[] encryptData = cipher.doFinal(text.getBytes("utf-8"));
            encryptStr =  new BASE64Encoder().encodeBuffer(encryptData);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (NoSuchPaddingException e) {
            e.printStackTrace();
        } catch (InvalidKeyException e) {
            e.printStackTrace();
        }
        return encryptStr;
    }

    public String rsaDecrypt(String text) throws  Exception {
        if (this.privateKey == null) {
            throw new Exception("请先设置私钥");
        }
        Cipher cipher = null;
        String decryptStr = null;
        try {
            cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
            cipher.init(Cipher.DECRYPT_MODE, this.privateKey);
            byte[] encryptData = new BASE64Decoder().decodeBuffer(text);
            byte[] decryptData = cipher.doFinal(encryptData);
            decryptStr =  new String(decryptData);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (NoSuchPaddingException e) {
            e.printStackTrace();
        } catch (InvalidKeyException e) {
            e.printStackTrace();
        }
        return decryptStr;

    }

    public static String desEncrypt(String text, String key) throws Exception {
        Cipher cipher = null;
        String encryptStr = null;
        try {
            byte[] iv = {1, 2, 3, 4, 5, 6, 7, 8};
            IvParameterSpec ivParameterSpec = new IvParameterSpec(iv);
            cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
            DESKeySpec desKeySpec = new DESKeySpec(key.getBytes());
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
            SecretKey secretKey = keyFactory.generateSecret(desKeySpec);
            cipher.init(Cipher.ENCRYPT_MODE, secretKey, ivParameterSpec);
            byte[] encryptData = cipher.doFinal(text.getBytes());
            encryptStr = new BASE64Encoder().encode(encryptData);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return encryptStr;

    }

    public static String desDecrypt(String text, String key) throws Exception {
        Cipher cipher = null;
        String decryptStr = null;
        try {
            byte[] iv = {1, 2, 3, 4, 5, 6, 7, 8};
            IvParameterSpec ivParameterSpec = new IvParameterSpec(iv);
            cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
            DESKeySpec desKeySpec = new DESKeySpec(key.getBytes());
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
            SecretKey secretKey = keyFactory.generateSecret(desKeySpec);
            cipher.init(Cipher.DECRYPT_MODE, secretKey, ivParameterSpec);
            byte[] encryptData = new BASE64Decoder().decodeBuffer(text);
            byte[] decryptData = cipher.doFinal(encryptData);
            decryptStr = new String(decryptData);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return decryptStr;

    }
}
