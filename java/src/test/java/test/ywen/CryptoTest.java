package test.ywen;

import com.ywen.CryptoManager;
import org.junit.Assert;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import sun.misc.BASE64Decoder;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by wenyun on 15/4/22.
 */
public class CryptoTest {

    private static CryptoManager cryptoManager;
    private final Logger logger = LoggerFactory.getLogger(CryptoTest.class);

    private  String getKeyFromFile(String filePath) {
        String key = null;
        try {
            URL url = this.getClass().getResource(filePath);
            BufferedReader bufferedReader = new BufferedReader(new FileReader(url.getFile()));
            List<String> list = new ArrayList<String>();
            String line = null;
            while ((line = bufferedReader.readLine()) != null) {
                list.add(line);
            }
            StringBuilder stringBuilder = new StringBuilder();
            //去掉第一行和最后一行
            for (int i = 1; i < list.size() - 1; i++) {
               stringBuilder.append(list.get(i)).append("\r");
            }
            key = stringBuilder.toString();
        } catch (FileNotFoundException e) {
            logger.error("{}", e);
        } catch (IOException e) {
            logger.error("{}", e);
        }
        return key;
    }

    @Before public void setCryptoManager() {
        String pubKeyStr = getKeyFromFile("/rsa_public_key.pem");
        Assert.assertNotNull(pubKeyStr);
        String privateKeyStr = getKeyFromFile("/pkcs8_private_key.pem");
        Assert.assertNotNull(privateKeyStr);
        cryptoManager = new CryptoManager(privateKeyStr, pubKeyStr);
    }

    @Test
    public  void  testJavaRSA() {
        try {
            String plainText = "http://wo.yao.cl";
            String encryptStr = cryptoManager.rsaEncrypt(plainText);
            String decryptStr = cryptoManager.rsaDecrypt(encryptStr);
            logger.info("encrypt string is " + encryptStr);
            logger.info("decrypt string is " + decryptStr);
            Assert.assertEquals(plainText, decryptStr);
        } catch (Exception e) {
            logger.error("{}", e);
        }

    }

    @Test
    public void testRSAWithIos() {
        //使用的key文件夹下预先生成的密钥文件，把ios那边的结果作为期望结果
        String plainText = "1";
        String expectStr = "bxFq9YjfFs3l1VbRktfNSb5omvO5SQLxsRhBxNX73Ig9qebOim40VFSRTvmSzhjI" +
                "sNpreVfg+JQxxxLMPx6bDRf4y5CpZRwk+MsLjbolCO396LpsMT/cS7m7XT/60pWH" +
                "IZGg2YVZT63UO5aozf9mT8eCVBa1Nk46u4AoJ9BCCfA=";
        try {
            String decryptStr = cryptoManager.rsaDecrypt(expectStr);
            logger.info("decrypt string is " + decryptStr);
            Assert.assertEquals(plainText, decryptStr);
        } catch (Exception e) {
            logger.error("{}", e);
        }

    }

    @Test
    public void testJavaDES() {
        try {
            String plainText = "http://wo.yao.cl";
            String key = "12345678";
            String encryptStr = CryptoManager.desEncrypt(plainText, key);
            String decryptStr = CryptoManager.desDecrypt(encryptStr, key);
            logger.info("encrypt string is " + encryptStr);
            logger.info("decrypt string is " + decryptStr);
            Assert.assertEquals(plainText, decryptStr);
        } catch (Exception e) {
            logger.error("{}", e);
        }
    }

    @Test
    public void  testDESWithIos() {
        try {
            String encryptStr = "zS5Gry+KJqs=";
            String expectStr = "1";
            String key = "12345678";
            String decryptStr = CryptoManager.desDecrypt(encryptStr, key);
            logger.info("decrypt string is " + decryptStr);
            Assert.assertEquals(expectStr, decryptStr);
        } catch (Exception e) {
            logger.error("{}", e);
        }
    }


}
