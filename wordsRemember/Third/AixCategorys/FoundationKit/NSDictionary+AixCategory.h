//
//  NSDictionary+AixCategory.h
//  AixCategorys
//
//  Created by liuhongnian on 12/1/16.
//  Copyright © 2016 liuhongnian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (AixCategory)

- (nullable NSString *)toJsonString;

- (BOOL)x_containsObjectForKey:(id _Nullable )key;

- (NSString *_Nonnull)x_stringValueForKey:(id _Nullable )key;

- (NSNumber *_Nullable)x_numberForKey:(id _Nullable )key;

- (NSArray *_Nonnull)x_arrayValueForKey:(id _Nullable )key;

- (NSDictionary *_Nonnull)x_dictionaryValueForKey:(id _Nullable )key;

- (BOOL)x_boolForKey:(id _Nullable )key;


@end





