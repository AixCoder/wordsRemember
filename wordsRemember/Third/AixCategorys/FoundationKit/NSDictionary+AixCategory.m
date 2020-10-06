//
//  NSDictionary+AixCategory.m
//  AixCategorys
//
//  Created by liuhongnian on 12/1/16.
//  Copyright © 2016 liuhongnian. All rights reserved.
//

#import "NSDictionary+AixCategory.h"

@implementation NSDictionary (AixCategory)

- (NSString *)toJsonString
{
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error ;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        if (!error) {
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            return jsonString;
        }
    }
    return nil;
}

- (BOOL)x_containsObjectForKey:(id)key
{
    if (key) {
        return self[key] != nil;
    }
    return NO;
}

- (NSString *)x_stringValueForKey:(id)key
{
    NSString *stringValue = self[key];
    
    if (![self _isNull:stringValue] && stringValue) {
        if ([stringValue isKindOfClass:[NSString class]] || [stringValue isKindOfClass:[NSNumber class]]) {
            return [NSString stringWithFormat:@"%@",stringValue];
        }else{
            return @"";
        }
    }
    
    NSLog(@"dictionary not have key:%@",key);

    return @"";
}

- (NSNumber *)x_numberForKey:(id)key
{
    id value = self[key];
    if (!value || [self _isNull:value]) {
        return nil;
    }
    
    if ([value isKindOfClass:[NSNumber class]]) {
        return value;
    }
    
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString*)value];
    }
    
    return nil;
}

- (NSArray *)x_arrayValueForKey:(id)key
{
    NSArray *array = self[key];
    if (array && ![self _isNull:array]) {
        if ([array isKindOfClass:[NSArray class]]) {
            return array;
        }else{
            return @[];
        }
    }
    NSLog(@"dictionary not have key:%@",key);
    return @[];
    
}

- (NSDictionary *)x_dictionaryValueForKey:(id)key
{
    NSDictionary *dic = self[key];
    if (dic &&
        ![self _isNull:dic] ) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            return dic;
        }else{
            return @{};
        }
    }
    NSLog(@"dictionary not have key:%@",key);
    return @{};
}

- (BOOL)x_boolForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value boolValue];
    }
    return NO;
}

- (BOOL)_isNull:(id)object
{
    if ([object isEqual:[NSNull null]]) {
        return YES;
    }
    return NO;
}

@end
