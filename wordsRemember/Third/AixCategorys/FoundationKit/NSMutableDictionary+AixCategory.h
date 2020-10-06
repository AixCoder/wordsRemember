//
//  NSMutableDictionary+AixCategory.h
//  AixCategorys
//
//  Created by liuhongnian on 10/25/16.
//  Copyright © 2016 liuhongnian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (AixCategory)

- (void)aix_safeSetObject:(id)obj forKey:(NSString*)key;

@end
