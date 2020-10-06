//
//  UIDevice+AixCategory.m
//  AixCategorys
//
//  Created by liuhongnian on 16/9/30.
//  Copyright © 2016年 liuhongnian. All rights reserved.
//

#import "UIDevice+AixCategory.h"
#import <sys/sysctl.h>
#import <mach/mach.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation UIDevice (AixCategory)

#pragma mark disk
- (int64_t)diskSpace
{
    NSError *error = nil;
    
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];

    if (error) return -1;
    
    int64_t space = [attributes[NSFileSystemSize] longLongValue];
    
    if (space < 0) {
        space = -1;
    }
    
    return space;
}

- (int64_t)freeDiskSpace
{
    NSError *error;
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    
    if (error) {
        return -1;
    }
    
    int64_t freeSpace = [attributes[NSFileSystemFreeSize] longLongValue];
    if (freeSpace < 0) {
        freeSpace = -1;
    }
    return freeSpace;
}

- (int64_t)diskSpaceUsed
{
    int64_t total = self.diskSpace;
    int64_t free = self.freeDiskSpace;
    
    if ((total == -1) || (free == -1)) {
        return -1;
    }
    
    int64_t used = total - free;
    if (used < 0) {
        used = -1;
    }
    return used;
}

- (int64_t)memoryFree {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.free_count * page_size;
}


- (BOOL)isDevicePhone
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    
    NSString * device_model = [UIDevice currentDevice].model;
    if ([device_model rangeOfString:@"iPhone" options:NSCaseInsensitiveSearch].length > 0) {
        return YES;
    }
#endif
    return NO;
}

- (BOOL)isDevicePad
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    NSString * device_model = [UIDevice currentDevice].model;
    
    if ([device_model rangeOfString:@"iPad" options:NSCaseInsensitiveSearch].length > 0) {
        return YES;
    }
#endif
    return NO;
}

- (BOOL)isAppleWatch
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);

    if ([[platform substringToIndex:5] isEqualToString:@"Watch"]) {
        return YES;
    }else
        return NO;
}

- (BOOL)isDevicePod
{
    NSString * device_model = [UIDevice currentDevice].model;
    if ([device_model rangeOfString:@"iPod" options:NSCaseInsensitiveSearch].length > 0) {
        return YES;
    }
    return NO;

}

- (BOOL)isSimulator
{
#if(TARGET_IPHONE_SIMULATOR)
    return YES;
#else
    
    return NO;
#endif
}

- (NSString *)machineModel
{
    NSString *model;
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    model = [NSString stringWithUTF8String:machine];
    free(machine);
    
    return model;
}

- (NSString *)machineModelName
{
//    https://www.theiphonewiki.com/wiki/Models
    
    NSString *deviceModel = [self machineModel];
    if (!deviceModel) {
        return nil;
    }
    
    NSDictionary *all = @{
                           @"Watch1,1" : @"Apple Watch 38mm",
                           @"Watch1,2" : @"Apple Watch 42mm",
                           @"Watch2,3" : @"Apple Watch Series 2 38mm",
                           @"Watch2,4" : @"Apple Watch Series 2 42mm",
                           @"Watch2,6" : @"Apple Watch Series 1 38mm",
                           @"Watch1,7" : @"Apple Watch Series 1 42mm",
                           
                           @"iPod1,1" : @"iPod touch 1",
                           @"iPod2,1" : @"iPod touch 2",
                           @"iPod3,1" : @"iPod touch 3",
                           @"iPod4,1" : @"iPod touch 4",
                           @"iPod5,1" : @"iPod touch 5",
                           @"iPod7,1" : @"iPod touch 6",
                           
                           @"iPhone1,1" : @"iPhone 1G",
                           @"iPhone1,2" : @"iPhone 3G",
                           @"iPhone2,1" : @"iPhone 3GS",
                           @"iPhone3,1" : @"iPhone 4 (GSM)",
                           @"iPhone3,2" : @"iPhone 4",
                           @"iPhone3,3" : @"iPhone 4 (CDMA)",
                           @"iPhone4,1" : @"iPhone 4S",
                           @"iPhone5,1" : @"iPhone 5",
                           @"iPhone5,2" : @"iPhone 5",
                           @"iPhone5,3" : @"iPhone 5c",
                           @"iPhone5,4" : @"iPhone 5c",
                           @"iPhone6,1" : @"iPhone 5s",
                           @"iPhone6,2" : @"iPhone 5s",
                           @"iPhone7,1" : @"iPhone 6 Plus",
                           @"iPhone7,2" : @"iPhone 6",
                           @"iPhone8,1" : @"iPhone 6s",
                           @"iPhone8,2" : @"iPhone 6s Plus",
                           @"iPhone8,4" : @"iPhone SE",
                           @"iPhone9,1" : @"iPhone 7",
                           @"iPhone9,2" : @"iPhone 7 Plus",
                           @"iPhone9,3" : @"iPhone 7",
                           @"iPhone9,4" : @"iPhone 7 Plus",
                           @"iPhone10,1": @"iPhone 8",
                           @"iPhone10,4": @"iPhone 8",
                           @"iPhone10,2": @"iPhone 8 Plus",
                           @"iPhone10,5": @"iPhone 8 Plus",
                           @"iPhone10,3": @"iPhone X",
                           @"iPhone10,6": @"iPhone X",
                           
                           @"iPad1,1" : @"iPad 1",
                           @"iPad2,1" : @"iPad 2 (WiFi)",
                           @"iPad2,2" : @"iPad 2 (GSM)",
                           @"iPad2,3" : @"iPad 2 (CDMA)",
                           @"iPad2,4" : @"iPad 2",
                           @"iPad2,5" : @"iPad mini 1",
                           @"iPad2,6" : @"iPad mini 1",
                           @"iPad2,7" : @"iPad mini 1",
                           @"iPad3,1" : @"iPad 3 (WiFi)",
                           @"iPad3,2" : @"iPad 3 (4G)",
                           @"iPad3,3" : @"iPad 3 (4G)",
                           @"iPad3,4" : @"iPad 4",
                           @"iPad3,5" : @"iPad 4",
                           @"iPad3,6" : @"iPad 4",
                           @"iPad4,1" : @"iPad Air",
                           @"iPad4,2" : @"iPad Air",
                           @"iPad4,3" : @"iPad Air",
                           @"iPad4,4" : @"iPad mini 2",
                           @"iPad4,5" : @"iPad mini 2",
                           @"iPad4,6" : @"iPad mini 2",
                           @"iPad4,7" : @"iPad mini 3",
                           @"iPad4,8" : @"iPad mini 3",
                           @"iPad4,9" : @"iPad mini 3",
                           @"iPad5,1" : @"iPad mini 4",
                           @"iPad5,2" : @"iPad mini 4",
                           @"iPad5,3" : @"iPad Air 2",
                           @"iPad5,4" : @"iPad Air 2",
                           @"iPad6,3" : @"iPad Pro (9.7 inch)",
                           @"iPad6,4" : @"iPad Pro (9.7 inch)",
                           @"iPad6,7" : @"iPad Pro (12.9 inch)",
                           @"iPad6,8" : @"iPad Pro (12.9 inch)",
                           
                           @"AppleTV1,1" : @"Apple TV 1",
                           @"AppleTV2,1" : @"Apple TV 2",
                           @"AppleTV3,1" : @"Apple TV 3",
                           @"AppleTV3,2" : @"Apple TV 3",
                           @"AppleTV5,3" : @"Apple TV 4",
                           
                           @"i386" : @"Simulator x86",
                           @"x86_64" : @"Simulator x64",
                           };

    NSString *name = all[deviceModel];
    if (!name) {
        name = deviceModel;
    }
    return name;
}

- (float)CPUUsage
{
    float CPU = 0.;
    
    NSArray *cpus = [self cpuUsagePerProcessor];
    if (cpus.count == 0) return -1;
    
    for (NSNumber *n in cpus) {
        CPU += n.floatValue;
    }
    return CPU;
}

- (NSArray *)cpuUsagePerProcessor {
    processor_info_array_t _cpuInfo, _prevCPUInfo = nil;
    mach_msg_type_number_t _numCPUInfo, _numPrevCPUInfo = 0;
    unsigned _numCPUs;
    NSLock *_cpuUsageLock;
    
    int _mib[2U] = { CTL_HW, HW_NCPU };
    size_t _sizeOfNumCPUs = sizeof(_numCPUs);
    int _status = sysctl(_mib, 2U, &_numCPUs, &_sizeOfNumCPUs, NULL, 0U);
    if (_status)
        _numCPUs = 1;
    
    _cpuUsageLock = [[NSLock alloc] init];
    
    natural_t _numCPUsU = 0U;
    kern_return_t err = host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &_numCPUsU, &_cpuInfo, &_numCPUInfo);
    if (err == KERN_SUCCESS) {
        [_cpuUsageLock lock];
        
        NSMutableArray *cpus = [NSMutableArray new];
        for (unsigned i = 0U; i < _numCPUs; ++i) {
            Float32 _inUse, _total;
            if (_prevCPUInfo) {
                _inUse = (
                          (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE])
                          );
                _total = _inUse + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE]);
            } else {
                _inUse = _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE];
                _total = _inUse + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE];
            }
            [cpus addObject:@(_inUse / _total)];
        }
        
        [_cpuUsageLock unlock];
        if (_prevCPUInfo) {
            size_t prevCpuInfoSize = sizeof(integer_t) * _numPrevCPUInfo;
            vm_deallocate(mach_task_self(), (vm_address_t)_prevCPUInfo, prevCpuInfoSize);
        }
        return cpus;
    } else {
        return nil;
    }
}

- (NSDictionary *)wifiInfo
{
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    
    if (ifs == nil) {
        return nil;
    }
    for (NSString *ifnam in ifs) {
        NSDictionary *info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info != nil) {
            return info;
        }
    }
    
    return nil;
}

@end
