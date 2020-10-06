//
//  NSBundle+AixCategory.m
//  AixCategorys
//
//  Created by liuhongnian on 10/25/16.
//  Copyright © 2016 liuhongnian. All rights reserved.
//

#import "NSBundle+AixCategory.h"

@implementation NSBundle (AixCategory)

- (NSString*)aix_appIconPath
{
    NSString *iconFileName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIconFile"];
    NSString *iconBaseName = [iconFileName stringByDeletingPathExtension];
    NSString *iconExtension = [iconFileName pathExtension];
    
    return [[NSBundle mainBundle] pathForResource:iconBaseName
                                           ofType:iconExtension];
}

- (UIImage *)aix_appIcon
{
    NSString *path = [self aix_appIconPath];
    UIImage *appIcon = [[UIImage alloc] initWithContentsOfFile:path];
    return appIcon;
}

@end
