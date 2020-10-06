//
//  NSMutableDictionary+AixCategory.m
//  AixCategorys
//
//  Created by liuhongnian on 10/25/16.
//  Copyright © 2016 liuhongnian. All rights reserved.
//

#import "NSMutableDictionary+AixCategory.h"

@implementation NSMutableDictionary (AixCategory)

- (void)aix_safeSetObject:(id)obj forKey:(NSString *)key
{
    if (obj) {
        self[key] = obj;
    }
}

@end
