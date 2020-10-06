//
//  AixButton.m
//  AixCategorys
//
//  Created by liuhongnian on 2019/3/27.
//  Copyright © 2019年 liuhongnian. All rights reserved.
//

#import "AixButton.h"

@implementation AixButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if (CGRectIsEmpty(self.titleRect) ||
        CGRectEqualToRect(self.titleRect, CGRectZero)) {
        
        return [super titleRectForContentRect:contentRect];
    }
    
    return self.titleRect;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if (CGRectIsEmpty(self.imageRect) || CGRectEqualToRect(CGRectZero, self.imageRect)) {
        
        return [super imageRectForContentRect:contentRect];
    }
    
    return self.imageRect;
}



@end
