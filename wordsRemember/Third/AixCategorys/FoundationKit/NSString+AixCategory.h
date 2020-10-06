//
//  NSString+AixCategory.h
//  AixCategorys
//
//  Created by liuhongnian on 16/10/7.
//  Copyright © 2016年 liuhongnian. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface NSString (AixCategory)

@property (nonatomic, readonly) NSData   * data;
@property (nonatomic, readonly) NSDate   * date;

@property (nonatomic, readonly) NSString * MD5;

@property (nonatomic, readonly) NSString * SHA1;
@property (nonatomic,readonly ) NSString * SHA256;
@property (nonatomic,readonly ) NSString * SHA512;

@property (nonatomic,readonly) NSString *APPBundleID;
@property (nonatomic,readonly) NSString *APPVersion;
@property (nonatomic,readonly) NSString *APPBuildVersion;

- (BOOL)isEmpty;
- (BOOL)isNotEmpty;
- (BOOL)isNormal;
- (BOOL)x_isPureInt;
- (BOOL)x_isPureFloat;
- (BOOL)isPureNumberCharacters;
- (BOOL)isTelephone;    // match telephone
- (BOOL)x_isMobilephone;//手机号判断，粗略判断
- (BOOL)x_isRealMobilephone;  //手机号判断（精确判断真实性）
- (BOOL)isUserName;     // match alphabet 3-20
- (BOOL)isChineseUserName;  // match alphabet and chinese characters, 3-20
- (BOOL)isPureChineseName;// match just chinese characters 2-16
- (BOOL)isPassword;
- (BOOL)isEmail;
- (BOOL)isWebURL;
- (BOOL)isValidPostalcode;// *  邮政编码
- (BOOL)x_isCarNumberPlate;//车牌号
- (BOOL)isIPAddress;
- (BOOL)x_isIDCardNumber;//验证身份证号码
- (BOOL)x_isBankCardNumber;//银行卡号码

/**
 获得汉字的拼音
 
 @param chinese 汉字
 @return 拼音
 */
+ (NSString *)x_transform:(NSString *)chinese;

//验证身份证号码是否有效
+ (BOOL)aix_judgeIdCardNumberStringValid:(NSString*)identityString;

- (NSString *)aix_encodeToBase64;
- (NSString *)aix_decodeBase64;

- (NSString *)x_encodeToGMBase64;//用Google的base64,因为系统提供的base64发现加密后的数据有时候有换行

- (NSString*)aix_URLEncode;
- (NSString*)aix_URLDecode;

/**
 过滤掉空格

 @return 过滤后的结果
 */
- (NSString*)aix_trimmingWhitespace;
- (NSString*)aix_trimmingWhitespaceAndNewlines;

- (CGFloat)x_heightForFont:(UIFont*)font width:(CGFloat)width;
- (CGFloat)x_widthForFont:(UIFont *)font height:(CGFloat)height;//算出字体的宽度

//反转字符串
+ (NSString *)x_reverseString:(NSString*)string;

@end

@interface NSString (FilePath)

+ (NSURL *)documentsURL;
+ (NSString *)documentsPath;
+ (NSString *)xTemporaryPath;
@property (nonatomic,readonly) NSURL *cachesURL;
@property (nonatomic,readonly) NSString *cachesPath;

@end

@interface NSString (AixJson)
//json字符串转换为字典
- (NSDictionary *)x_toJsonDictionary;

@end


