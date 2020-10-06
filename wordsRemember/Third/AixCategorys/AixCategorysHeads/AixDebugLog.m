//
//  AixDebugLog.m
//  AixCategorys
//
//  Created by liuhongnian on 11/2/16.
//  Copyright © 2016 liuhongnian. All rights reserved.
//

#import "AixDebugLog.h"

@implementation AixDebugLog

void ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...)
{
    va_list ap;
    
    va_start (ap, format);
    
    if (![format hasSuffix: @"\n"])
    {
        format = [format stringByAppendingString: @"\n"];
    }
    
    NSString *body = [[NSString alloc] initWithFormat:format arguments:ap];
    
    va_end (ap);
    
    NSString *fileName = [[NSString stringWithUTF8String:file] lastPathComponent];
    fprintf(stderr, "(%s) (%s:%d) %s", functionName, [fileName UTF8String], lineNumber, [body UTF8String]);
    
}

@end
