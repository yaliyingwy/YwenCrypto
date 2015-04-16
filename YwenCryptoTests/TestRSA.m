//
//  TestRSA.m
//  
//
//  Created by ywen on 15/4/16.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "YwenCrypto.h"

@interface TestRSA : XCTestCase

@end

@implementation TestRSA

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void) testRsa {
    CryptoManager *cryptoManager = [CryptoManager sharedInstance];
    NSString *der = [[NSBundle bundleForClass:[self class]] pathForResource:@"public_key" ofType:@"der"];
    XCTAssertNotNil(der, @"der does not exist");
    BOOL pubResult = [cryptoManager setUpRsaPubkey: der];
    XCTAssertTrue(pubResult, @"setup rsa public key failed");
    NSString *encryptStr = [cryptoManager rsaEncrypt:@"1"];
    NSLog(@"encrypted string is %@", encryptStr);
    
    NSString *p12 = [[NSBundle bundleForClass:[self class]] pathForResource:@"private_key" ofType:@"p12"];
    XCTAssertNotNil(p12, @"p12 does not exist");
    BOOL privateResult = [cryptoManager setUpRsaPrivatekey:p12 passwd:@""];
    XCTAssertTrue(privateResult, @"setup rsa private key failed");
    NSString *decryptStr = [cryptoManager rsaDecrypt:encryptStr];
    NSLog(@"decrypted string is %@", decryptStr);
    
    XCTAssertEqualObjects(@"1", decryptStr);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
