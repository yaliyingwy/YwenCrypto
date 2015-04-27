//
//  TestDes.m
//  YwenCrypto
//
//  Created by ywen on 15/4/16.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "YwenCrypto.h"

@interface TestDes : XCTestCase

@end

@implementation TestDes

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

-(void) testDes {
    CryptoManager *cryptoManager = [CryptoManager sharedInstance];
    NSString *encryptStr = [cryptoManager desEncryt:@"1" key:@"12345678"];
    NSLog(@"encrypted string is %@", encryptStr);
    NSString *decryptStr = [cryptoManager desDecryt:encryptStr key:@"12345678"];
    NSLog(@"decrypted string is %@", decryptStr);
    XCTAssertEqualObjects(@"1", decryptStr);
    
}

-(void) testDESWithJava {
    CryptoManager *cryptoManager = [CryptoManager sharedInstance];
    NSString *encryptStr = @"JGY15Y2I+6TPCvoNsOvIe03lLjhV82Tn";
    NSString *decryptStr = [cryptoManager desDecryt:encryptStr key:@"12345678"];
    NSLog(@"decrypted string is %@", decryptStr);
    XCTAssertEqualObjects(@"http://wo.yao.cl", decryptStr);
}

-(void) testDESWithNodejs {
    CryptoManager *cryptoManager = [CryptoManager sharedInstance];
    NSString *encryptStr = @"JGY15Y2I+6TPCvoNsOvIe03lLjhV82Tn";
    NSString *decryptStr = [cryptoManager desDecryt:encryptStr key:@"12345678"];
    NSLog(@"decrypted string is %@", decryptStr);
    XCTAssertEqualObjects(@"http://wo.yao.cl", decryptStr);
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
       
    }];
}

@end
