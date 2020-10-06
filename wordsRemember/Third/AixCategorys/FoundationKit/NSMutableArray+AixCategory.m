//
//  NSMutableArray+AixCategory.m
//  AixCategorys
//
//  Created by liuhongnian on 10/25/16.
//  Copyright © 2016 liuhongnian. All rights reserved.
//

#import "NSMutableArray+AixCategory.h"

@implementation NSMutableArray (AixCategory)

- (id)aix_safeObjectAtIndex:(NSUInteger)index
{
    if([self count] > 0 && [self count] > index)
        return [self objectAtIndex:index];
    else
        return nil;
}

- (void)aix_moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to
{
    if(to != from)
    {
        if (from > self.count) {
            return;
        }
        
        id obj = [self aix_safeObjectAtIndex:from];
        [self removeObjectAtIndex:from];
        
        if(to >= [self count])
            [self addObject:obj];
        else
            [self insertObject:obj atIndex:to];
    }
}

- (void)aix_safeAddObject:(id)obj
{
    if (obj) {
        [self addObject:obj];
    }
}

- (void)aix_safeInsertObject:(id)obj atIndex:(NSUInteger)index
{
    if (obj) {
        [self insertObject:obj atIndex:index];
    }
}

- (void)x_shuffle
{
    for (NSUInteger i = self.count; i > 1; i--) {
        
        [self exchangeObjectAtIndex:(i -1) withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
                                                                                
    }
}

@end
