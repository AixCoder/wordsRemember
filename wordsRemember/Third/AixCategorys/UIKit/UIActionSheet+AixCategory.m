//
//  UIActionSheet+AixCategory.m
//  AixCategorys
//
//  Created by liuhongnian on 11/2/16.
//  Copyright © 2016 liuhongnian. All rights reserved.
//

#import "UIActionSheet+AixCategory.h"

static void (^__clickedBlock)(UIActionSheet *sheet, NSUInteger index);
static void (^__cancelBlock)(UIActionSheet *sheet);
static void (^__destroyBlock)(UIActionSheet *sheet);

@implementation UIActionSheet (AixCategory)

+ (UIActionSheet *)x_presentOnView:(UIView *)view withTitle:(NSString *)title otherButtons:(NSArray *)otherStrings onCancel:(void (^)(UIActionSheet *))cancelBlock onClickedButton:(void (^)(UIActionSheet *, NSUInteger))clickBlock
{
    return [self x_presentOnView:view withTitle:title cancelButton:NSLocalizedString(@"Cancel", @"") destructiveButton:nil otherButtons:otherStrings onCancel:cancelBlock onDestructive:nil onClickedButton:clickBlock];
}

+ (UIActionSheet *)x_presentOnView:(UIView *)view withTitle:(NSString *)title cancelButton:(NSString *)cancelString destructiveButton:(NSString *)destructiveString otherButtons:(NSArray *)otherStrings onCancel:(void (^)(UIActionSheet *))cancelBlock onDestructive:(void (^)(UIActionSheet *))destroyBlock onClickedButton:(void (^)(UIActionSheet *, NSUInteger))clickBlock
{
    __cancelBlock           = cancelBlock;
    __clickedBlock          = clickBlock;
    __destroyBlock          = destroyBlock;
    
    UIActionSheet *sheet    = [[UIActionSheet alloc] initWithTitle:title
                                                          delegate:(id) [self class]
                                                 cancelButtonTitle:nil
                                            destructiveButtonTitle:destructiveString
                                                 otherButtonTitles:nil];
    
    for(NSString *other in otherStrings)
        [sheet addButtonWithTitle: other];
    
    if (cancelString) {
        [sheet setCancelButtonIndex:[sheet addButtonWithTitle:cancelString]];
    }
    
    [sheet showInView: view];
    
    return sheet;
    
}

@end
