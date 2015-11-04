//
//  NSString+WYExt.m
//  xebest
//
//  Created by ywen on 15/3/11.
//  Copyright (c) 2015年 xianyi. All rights reserved.
//

#import "NSString+WYExt.h"

#define NUMBERS [NSMutableCharacterSet characterSetWithCharactersInString:@"0123456789"]
#define LOWER_LETTERS [NSCharacterSet lowercaseLetterCharacterSet]
#define UPPER_LETTERS [NSCharacterSet uppercaseLetterCharacterSet]


@implementation NSString (WYExt)

- (BOOL) WY_IsMobileNumberStrict {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    
    NSString *mobile = @"^1(3[0-9]|5[0-9]|8[0-9])\\d{8}$";
    NSString *cm = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString *cu = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString *ct = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
    NSPredicate *regCm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cm];
    NSPredicate *regCu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cu];
    NSPredicate *regCt = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ct];
    
    if ([regMobile evaluateWithObject:self] == YES || [regCm evaluateWithObject:self] == YES || [regCt evaluateWithObject:self] == YES || [regCu evaluateWithObject:self] == YES ) {
        return YES;
    }
    else
    {
        return NO;
        
    }
    
}

-(BOOL) WY_IsMobileNumber {
    if ([self WY_IsNumber] && self.length == 11) {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(BOOL) WY_IsNumber {
    if (self.length <= 0) {
        return NO;
    }
    NSCharacterSet *cs = [NUMBERS invertedSet];
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    if ([self isEqualToString:filtered]) {
        return YES;
    }
    else
    {
        return NO;
    }

}

-(BOOL) WY_IsNumberOrLetter {
    if (self.length <= 0) {
        return NO;
    }
    NSMutableCharacterSet *cs = NUMBERS;
    [cs formUnionWithCharacterSet:LOWER_LETTERS];
    [cs formUnionWithCharacterSet:UPPER_LETTERS];
    [cs invert];
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    if ([self isEqualToString:filtered]) {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(BOOL)WY_IsLetter {
    if (self.length <= 0) {
        return NO;
    }
    NSMutableCharacterSet *cs = [[NSMutableCharacterSet alloc] init];
    [cs formUnionWithCharacterSet:LOWER_LETTERS];
    [cs formUnionWithCharacterSet:UPPER_LETTERS];
    [cs invert];
    
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    if ([self isEqualToString:filtered]) {
        return YES;
    }
    else
    {
        return NO;
    }

}

-(BOOL)WY_IsIdCard {
    if (self.length <= 0) {
        return NO;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

-(BOOL)WY_IsEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

-(BOOL)WY_IsBankCard {
    if (self.length <= 0) {
        return NO;
    }
    NSString *regex2 = @"^(\\d{15,30})";
    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [bankCardPredicate evaluateWithObject:self];
}



-(NSString *)WY_MD5 {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

-(BOOL)WY_IsEmpty {
    return ([self isKindOfClass:[NSNull class]] || self.length == 0);
}

+(NSString *) WY_RandomString:(NSInteger)length {
    NSString *alphabet  = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789!@#$%^&*()?<>{}";
    NSMutableString *s = [NSMutableString stringWithCapacity:length];
    for (NSUInteger i = 0U; i < length; i++) {
        u_int32_t r = arc4random() % [alphabet length];
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    return s;
}

-(NSString *)WY_TrimStyle {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"style=\".*?\"" options:NSRegularExpressionCaseInsensitive error:nil];
    return [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:@""];
}

-(BOOL) WY_HasLetter {
    if (self.length <= 0) {
        return NO;
    }
    NSMutableCharacterSet *cs = [[NSMutableCharacterSet alloc] init];
    [cs formUnionWithCharacterSet:LOWER_LETTERS];
    [cs formUnionWithCharacterSet:UPPER_LETTERS];
    
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    if ([self isEqualToString:filtered]) {
        return NO;
    }
    else
    {
        return YES;
    }
}

-(BOOL) WY_HasNumber {
    if (self.length <= 0) {
        return NO;
    }
    
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:NUMBERS] componentsJoinedByString:@""];
    
    if ([self isEqualToString:filtered]) {
        return NO;
    }
    else
    {
        return YES;
    }
}

-(BOOL)WY_IsFixedPhone {
    if (self.length <= 0) {
        return NO;
    }
    NSString *reg = @"^(\\d{3,4}-?)\\d{7,8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",reg];
    return [predicate evaluateWithObject:self];
}

-(BOOL)WY_IsPostalCode {
    if (self.length <= 0) {
        return NO;
    }
    NSString *reg = @"\\d{6}(?!\\d)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",reg];
    return [predicate evaluateWithObject:self];
}

-(NSString *)WY_FirstIndexLetter {
    unichar first = [self characterAtIndex:0];
    if (first < 'z' && first > 'A') {
        return [NSString stringWithFormat:@"%c", first];
    }
    else
    {
        return [NSString stringWithFormat:@"%c", pinyinFirstLetter([self characterAtIndex:0])];
    }
}



@end
