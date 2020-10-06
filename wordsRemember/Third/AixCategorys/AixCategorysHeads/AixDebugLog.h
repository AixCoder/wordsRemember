//
//  AixDebugLog.h
//  AixCategorys
//
//  Created by liuhongnian on 11/2/16.
//  Copyright © 2016 liuhongnian. All rights reserved.
//

#import <Foundation/Foundation.h>


void ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...);

@interface AixDebugLog : NSObject

#ifdef DEBUG
#define AixDebugLog(...) ExtendNSLog(__FILE__,__LINE__,__PRETTY_FUNCTION__,__VA_ARGS__);
#else
#define AixDebugLog(...)
#endif

@end
