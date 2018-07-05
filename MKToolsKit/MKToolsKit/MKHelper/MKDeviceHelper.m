//
//  MKDeviceHelper.m
//  MKToolsKit
//
//  Created by xiaomk on 16/5/15.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import "MKDeviceHelper.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import <AVFoundation/AVFoundation.h>
#import <sys/utsname.h>
#import "SAMKeychain.h"

@implementation MKDeviceHelper

+ (NSString *)getUUID{
    NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
    NSString *uuid = [SAMKeychain passwordForService:bundleId account:@"user"];
    if (uuid == nil || uuid == NULL || uuid.length == 0) {
        CFUUIDRef uuidRef = CFUUIDCreate(NULL);
        CFStringRef uuidStr = CFUUIDCreateString(NULL, uuidRef);
        uuid = [NSString stringWithFormat:@"%@", uuidStr];
        [SAMKeychain setPassword:uuid forService:bundleId account:@"user"];
        CFRelease(uuidRef);
        CFRelease(uuidStr);
    }
    return uuid;
}

#pragma mark - ***** app 版本号 ******

+ (NSString *)appBundleShortVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBundleVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (int)appIntVersion{
    NSString *nowShotV = [self appBundleVersion];
    NSArray *numArray = [nowShotV componentsSeparatedByString:@"."];
    int versionInt = 0;
    if (numArray.count > 0) {
        for (NSInteger i = 0; i < numArray.count; i++) {
            NSString *numStr = numArray[i];
            versionInt = versionInt*10 + numStr.intValue;
        }
    }
    return versionInt;
}

#pragma mark - ***** 系统信息 ******
+ (float)systemVersion{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (NSString *)systemVersionString{
    return [[UIDevice currentDevice] systemVersion];
}

+ (BOOL)systemIs7Later{
    return [self systemVersion] >= 7.0;
}

+ (BOOL)systemIs8Later{
    return [self systemVersion] >= 8.0;
}

+ (BOOL)systemIs9Later{
    return [self systemVersion] >= 9.0;
}

+ (BOOL)systemIs10Later{
    return [self systemVersion] >= 10.0;
}

+ (BOOL)systemIs11Later{
    return [self systemVersion] >= 11.0;
}

+ (NSString *)deviceType{
    NSString *platform = [self devicePlatform];
    if (!platform) return nil;
    
    static NSString *name;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *dic = @{
                              //iPhone
                              @"iPhone1,1": @"iPhone 1G",
                              @"iPhone1,2": @"iPhone 3G",
                              @"iPhone2,1": @"iPhone 3GS",
                              @"iPhone3,1": @"iPhone 4",
                              @"iPhone3,2": @"iPhone 4",
                              @"iPhone3,3": @"Verizon iPhone 4",
                              @"iPhone4,1": @"iPhone 4S",
                              @"iPhone4,2": @"iPhone 4S",
                              @"iPhone4,3": @"iPhone 4S",
                              @"iPhone5,1": @"iPhone 5 (GSM)",
                              @"iPhone5,2": @"iPhone 5 (GSM+CDMA)",
                              @"iPhone5,3": @"iPhone 5C (GSM)",
                              @"iPhone5,4": @"iPhone 5C (GSM+CDMA)",
                              @"iPhone6,1": @"iPhone 5S (GSM)",
                              @"iPhone6,2": @"iPhone 5S (GSM+CDMA)",
                              @"iPhone7,1": @"iPhone 6 Plus",
                              @"iPhone7,2": @"iPhone 6",
                              @"iPhone8,1": @"iPhone 6S",
                              @"iPhone8,2": @"iPhone 6S Plus",
                              @"iPhone8,4": @"iPhone SE",
                              @"iPhone9,1": @"iPhone 7",
                              @"iPhone9,2": @"iPhone 7 Plus",
                              @"iPhone9,3": @"iPhone 7",
                              @"iPhone9,4": @"iPhone 7 Plus",
                              @"iPhone10,1": @"iPhone 8 (A1863,A1906)",
                              @"iPhone10,2": @"iPhone 8 Plus (A1864,A1898)",
                              @"iPhone10,3": @"iPhone X (A1865,A1902)",
                              @"iPhone10,4": @"iPhone 8 (Global/A1905)",
                              @"iPhone10,5": @"iPhone 8 Plus ((Global/A1897))",
                              @"iPhone10,6": @"iPhone X (Global/A1901)",
                              
                              //iPad
                              @"iPad1,1": @"iPad",
                              @"iPad2,1": @"iPad 2 (WiFi)",
                              @"iPad2,2": @"iPad 2 (GSM)",
                              @"iPad2,3": @"iPad 2 (CDMA)",
                              @"iPad2,4": @"iPad 2 (WiFi)",
                              @"iPad2,5": @"iPad Mini 1(WiFi)",
                              @"iPad2,6": @"iPad Mini 1(GSM)",
                              @"iPad2,7": @"iPad Mini 1(GSM+CDMA)",
                              
                              @"iPad3,1": @"iPad 3 (WiFi)",
                              @"iPad3,2": @"iPad 3 (GSM+CDMA)",
                              @"iPad3,3": @"iPad 3 (GSM)",
                              @"iPad3,4": @"iPad 4 (WiFi)",
                              @"iPad3,5": @"iPad 4 (GSM)",
                              @"iPad3,6": @"iPad 4 (GSM+CDMA)",
                              
                              @"iPad4,1": @"iPad Air (WiFi)",
                              @"iPad4,2": @"iPad Air (Cellular)",
                              @"iPad4,3": @"iPad Air",
                              @"iPad4,4": @"iPad Mini 2 (WiFi)",
                              @"iPad4,5": @"iPad Mini 2 (Cellular)",
                              @"iPad4,6": @"iPad Mini 2",
                              @"iPad4,7": @"iPad Mini 3",
                              @"iPad4,8": @"iPad Mini 3",
                              @"iPad4,9": @"iPad Mini 3",
                              
                              @"iPad5,1": @"iPad Mini 4(WiFi)",
                              @"iPad5,2": @"iPad Mini 4(Cellular)",
                              @"iPad5,3": @"iPad Air 2",
                              @"iPad5,4": @"iPad Air 2(WiFi)",
                              @"iPad5,5": @"iPad Air 2(Cellular)",
                              
                              @"iPad6,3": @"iPad Pro(WiFi) 9.7-inch",
                              @"iPad6,4": @"iPad Pro(Cellular) 9.7-inch",
                              @"iPad6,7": @"iPad Pro(WiFi) 12.9-inch",
                              @"iPad6,8": @"iPad Pro(Cellular) 12.9-inch",
                              
                              //watch
                              @"Watch1,1" : @"Apple Watch 38mm",
                              @"Watch1,2" : @"Apple Watch 42mm",
                              @"Watch2,3" : @"Apple Watch Series 2 38mm",
                              @"Watch2,4" : @"Apple Watch Series 2 42mm",
                              @"Watch2,6" : @"Apple Watch Series 1 38mm",
                              @"Watch1,7" : @"Apple Watch Series 1 42mm",
                              
                              //apple TV
                              @"AppleTV2,1" : @"Apple TV 2",
                              @"AppleTV3,1" : @"Apple TV 3",
                              @"AppleTV3,2" : @"Apple TV 3",
                              @"AppleTV5,3" : @"Apple TV 4",
                              
                              //iPod
                              @"iPod1,1": @"iPod Touch 1G",
                              @"iPod2,1": @"iPod Touch 2G",
                              @"iPod3,1": @"iPod Touch 3G",
                              @"iPod4,1": @"iPod Touch 4G",
                              @"iPod5,1": @"iPod Touch 5G",
                              @"iPod7,1": @"iPod Touch 6G",
                              
                              //Simulator
                              @"i386"   : @"iPhone Simulator",
                              @"x86_64" : @"iPhone Simulator",
                              };
        name = dic[platform];
    });
    if (name) return name;
    if ([platform hasPrefix:@"iPad"])   return @"iPad";
    if ([platform hasPrefix:@"iPod"])   return @"iPod";
    if ([platform hasPrefix:@"iPhone"]) return @"iPhone";
    return platform;
}

+ (BOOL)isSimulator {
#if TARGET_OS_SIMULATOR
    return YES;
#else
    return NO;
#endif
}

+ (NSString *)devicePlatform{
    static NSString *platform;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        platform = [NSString stringWithUTF8String:machine];
        free(machine);
    });
    return platform;

//    struct utsname DT;
//    // Get the system information
//    uname(&DT);
//    // Set the device type to the machine type
//    NSString *deviceType = [NSString stringWithFormat:@"%s", DT.machine];
//    return deviceType
}


#pragma mark - ***** 手机信息 ******
+ (NSString *)phoneName{
    return [[UIDevice currentDevice] name];
}

+ (NSString *)phoneModel{
    return [[UIDevice currentDevice] model];
}

+ (float)screenBrightness {
    return [UIScreen mainScreen].brightness;
}

+ (float)batteryLevel {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    float BatteryLevel = -1;
    
    float BatteryCharge = [UIDevice currentDevice].batteryLevel;
    if (BatteryCharge >= 0.0f) {
        BatteryLevel = BatteryCharge * 100;
    }
    return BatteryLevel;
}

// Charging?
+ (BOOL)charging{
    UIDevice *Device = [UIDevice currentDevice];
    Device.batteryMonitoringEnabled = YES;
    
    // Check the battery state
    if ([Device batteryState] == UIDeviceBatteryStateCharging || [Device batteryState] == UIDeviceBatteryStateFull) {
        return true;
    } else {
        return false;
    }
}

@end


