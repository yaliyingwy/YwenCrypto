var ywenCrypto = require('./ywen-crypto');
var fs = require('fs');
require('should');

var pubKey = fs.readFileSync('rsa_public_key.pem');
var privateKey = fs.readFileSync('private_key.pem');
var desKey = "12345678";
describe('rsa', function() {
    var plainText = "http://wo.yao.cl";
    var encryptStr, decryptStr;
    var iosEncryptStr = "E/YXJq9zGh3pC955wao5r3JjYpnrt7yNTZzfFMoazRug3/XJROJKT2VR2UHmgSEhHJe4747LjnrI1WGwje4xiIrGnGGv2UR0GhTDv9UwrKuZtYaS22UkpkLyEcADU0/bkYgQ5Ll29VCjU0AwkMVrXazrhgtPElMG8PCpsvHYJ3Y="; 
    var iosPlainText = plainText;
    it('decryptStr should equal plainText', function() {
        encryptStr = ywenCrypto.rsaEncrypt(pubKey, plainText);
        decryptStr = ywenCrypto.rsaDecrypt(privateKey, encryptStr);
        console.log('plainText is ', plainText);
        console.log('encryptStr is ', encryptStr);
        console.log('decryptStr is ', decryptStr);
        plainText.should.eql(decryptStr);
    });
    it('decryptStr should be the same with ios plainText', function() {
        decryptStr = ywenCrypto.rsaDecrypt(privateKey, iosEncryptStr);
        decryptStr.should.eql(iosPlainText);
    });
});

describe('des', function() {
    var plainText = "http://wo.yao.cl";
    var encryptStr, decryptStr;
    var iosEncryptStr = "zS5Gry+KJqs="; 
    var iosPlainText = "1";
    it('decryptStr should equal plainText', function() {
        encryptStr = ywenCrypto.desEncrypt(desKey, new Array(1,2,3,4,5,6,7,8), plainText);
        decryptStr = ywenCrypto.desDecrypt(desKey, new Array(1,2,3,4,5,6,7,8), encryptStr);
        console.log('plainText is ', plainText);
        console.log('encryptStr is ', encryptStr);
        console.log('decryptStr is ', decryptStr);
        plainText.should.eql(decryptStr);
    });
    it('decryptStr should be the same with ios plainText', function() {
        decryptStr = ywenCrypto.desDecrypt(desKey, new Array(1,2,3,4,5,6,7,8), iosEncryptStr);
        console.log('descript str is', decryptStr);
        decryptStr.should.eql(iosPlainText);
    });
});