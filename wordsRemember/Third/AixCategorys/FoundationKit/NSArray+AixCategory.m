//
//  NSArray+AixCategory.m
//  AixCategorys
//
//  Created by liuhongnian on 10/25/16.
//  Copyright © 2016 liuhongnian. All rights reserved.
//

#import "NSArray+AixCategory.h"

@implementation NSArray (AixCategory)

- (id)x_safeObjectAtIndex:(NSUInteger)index
{
    if([self count] > 0 && [self count] > index)
        return [self objectAtIndex:index];
    else
        return nil;
}

- (id)x_randomObject
{
    if (self.count) {
        return self[arc4random_uniform((uint32_t)self.count)];
    }
    return nil;
}

- (NSString *)x_toJSONString
{
    
    if ([NSJSONSerialization isValidJSONObject:self]) {
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        
        if (error) {
            NSLog(@"对象转成data出错");
            return nil;
        }
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonStr;
        
        
    }
    return nil;
}

@end
