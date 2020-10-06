//
//  UIBarButtonItem+AixCatrgory.m
//  AixCategorys
//
//  Created by liuhongnian on 16/10/7.
//  Copyright © 2016年 liuhongnian. All rights reserved.
//

#import "UIBarButtonItem+AixCatrgory.h"
#import <objc/runtime.h>

static const void *AixBarButtonItemBlockKey = &AixBarButtonItemBlockKey;

@implementation UIBarButtonItem (AixCatrgory)

-(instancetype)aix_initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style handler:(void (^)(id))action
{
    self = [self initWithImage:image style:style target:self action:@selector(aixAction:)];
    
    if (!self) {
        return nil;
    }
    
    objc_setAssociatedObject(self, AixBarButtonItemBlockKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return self;
}

- (void)aixAction:(UIBarButtonItem *)sender
{
    void (^block)(id) = objc_getAssociatedObject(self, AixBarButtonItemBlockKey);
    
    if (block) {
        block(self);
    }
}

@end
