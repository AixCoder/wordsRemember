//
//  UIDevice+AixCategory.h
//  AixCategorys
//
//  Created by liuhongnian on 16/9/30.
//  Copyright © 2016年 liuhongnian. All rights reserved.
//

#import <UIKit/UIKit.h>

#define iOS_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define iOS_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define iOS_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define iOS_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define iOS_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define kUISCREEN_WIDTH          ([UIScreen mainScreen].bounds.size.width)
#define kUISCREEN_HEIGHT         ([UIScreen mainScreen].bounds.size.height)
#define iPhoneX     (kUISCREEN_WIDTH == 375.f && kUISCREEN_HEIGHT == 812.f)

@interface UIDevice (AixCategory)

@property (nonatomic,readonly) BOOL isDevicePhone;
@property (nonatomic,readonly) BOOL isDevicePad;
@property (nonatomic,readonly) BOOL isDevicePod;
@property (nonatomic,readonly) BOOL isSimulator;
@property (nonatomic,readonly) BOOL isAppleWatch;


/**
 e.g. "iPhone6,1"
 https://www.theiphonewiki.com/wiki/Models
 */
@property (nonatomic,readonly) NSString *machineModel;

/**
 e.g. "iPhone 7" "ipad mini"
 */
@property (nonatomic,readonly) NSString *machineModelName;

#pragma mark Disk Info

@property (nonatomic ,readonly) int64_t diskSpace;
@property (nonatomic, readonly) int64_t freeDiskSpace;
@property (nonatomic, readonly) int64_t diskSpaceUsed;

@property (nonatomic,readonly) float CPUUsage;
#pragma mark memory
/// Free memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t memoryFree;

#pragma mark wifi Info
@property (nonatomic, readonly) NSDictionary *wifiInfo;

@end
