//
//  UIActionSheet+AixCategory.h
//  AixCategorys
//
//  Created by liuhongnian on 11/2/16.
//  Copyright © 2016 liuhongnian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (AixCategory)



/**
 Present a UIActionSheet on a specific view
 
 Note: On this shorthand version the cancel button always displayed "Cancel" as the text. If you require a custom cancel text, use the longer method below.


 @param view The view on which the UIActionSheet will be displayed
 @param title The title of the UIActionSheet
 @param otherStrings An array containing strings of other buttons
 @param cancelBlock Cancel block - Called when the user pressed the cancel button, or the UIActionSheet has been manually dismissed
 @param clickBlock Clicked button at index block - Called when the user presses any button other then Cancel
 @return The generated UIActionSheet
 */
+(UIActionSheet *)x_presentOnView: (UIView *)view
                         withTitle: (NSString *)title
                      otherButtons: (NSArray *)otherStrings
                          onCancel: (void (^)(UIActionSheet *))cancelBlock
                   onClickedButton: (void (^)(UIActionSheet *, NSUInteger))clickBlock;

/**
 Present a UIActionSheet on a specific view
 
 @param view The view on which the UIActionSheet will be displayed
 @param title The title of the UIActionSheet
 @param cancelString The string shown on the Cancel button
 @param destructiveString The string shown on the Destructive button
 @param otherStrings An array containing strings of other buttons
 @param cancelBlock Cancel block - Called when the user pressed the cancel button, or the UIActionSheet has been manually dismissed
 @param destroyBlock Destructive block - Called when the user presses the destructive button
 @param clickBlock Clicked button at index block - Called when the user presses any button other then Cancel/Destructive
 
 @return The generated UIActionSheet
 */
+(UIActionSheet *)x_presentOnView: (UIView *)view
                         withTitle: (NSString *)title
                      cancelButton: (NSString *)cancelString
                 destructiveButton: (NSString *)destructiveString
                      otherButtons: (NSArray *)otherStrings
                          onCancel: (void (^)(UIActionSheet *))cancelBlock
                     onDestructive: (void (^)(UIActionSheet *))destroyBlock
                   onClickedButton: (void (^)(UIActionSheet *, NSUInteger))clickBlock;

@end
