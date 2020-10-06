//
//  NSNumber+AixCategory.m
//  AixCategorys
//
//  Created by user on 2017/11/6.
//  Copyright © 2017年 liuhongnian. All rights reserved.
//

#import "NSNumber+AixCategory.h"
#import "NSString+AixCategory.h"

@implementation NSNumber (AixCategory)


+ (nullable NSNumber *)x_numberWithString:(NSString *)string
{
    NSString *str = [[string aix_trimmingWhitespaceAndNewlines] lowercaseString];
    if ([str isEmpty]) {
        return nil;
    }

    static NSDictionary *dic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dic = @{@"true" :   @(YES),
                @"yes" :    @(YES),
                @"false" :  @(NO),
                @"no" :     @(NO),
                @"nil" :    [NSNull null],
                @"null" :   [NSNull null],
                @"<null>" : [NSNull null]};
    });
    NSNumber *num = dic[str];
    if (num != nil) {
        if (num == (id)[NSNull null]) return nil;
        return num;
    }
    
    // hex number
    int sign = 0;
    if ([str hasPrefix:@"0x"]) sign = 1;
    else if ([str hasPrefix:@"-0x"]) sign = -1;
    if (sign != 0) {
        NSScanner *scan = [NSScanner scannerWithString:str];
        unsigned num = -1;
        BOOL suc = [scan scanHexInt:&num];
        if (suc)
            return [NSNumber numberWithLong:((long)num * sign)];
        else
            return nil;
    }
    // normal number
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return [formatter numberFromString:string];
}
@end
