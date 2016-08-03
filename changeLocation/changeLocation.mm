//
//  changeLocation.m
//  changeLocation
//
//  Created by pingyandong on 16/8/1.
//  Copyright (c) 2016年 __MyCompanyName__. All rights reserved.
//

#import "CaptainHook.h"
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

// Objective-C runtime hooking using CaptainHook:
//   1. declare class using CHDeclareClass()
//   2. load class using CHLoadClass() or CHLoadLateClass() in CHConstructor
//   3. hook method using CHOptimizedMethod()
//   4. register hook using CHHook() in CHConstructor
//   5. (optionally) call old method using CHSuper()
@interface CLLocation(Swizzle)

@end

@implementation CLLocation(Swizzle)


//这边设置默认的签到地址
static float x = 31.279867;
static float y = 120.666084;

+ (void) load {
    Method m1 = class_getInstanceMethod(self, @selector(coordinate));
    Method m2 = class_getInstanceMethod(self, @selector(coordinate_));
    
    method_exchangeImplementations(m1, m2);
    
    //    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"_fake_x"]) {
    //        x = [[[NSUserDefaults standardUserDefaults] valueForKey:@"_fake_x"] floatValue];
    //    };
    //
    //    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"_fake_y"]) {
    //        y = [[[NSUserDefaults standardUserDefaults] valueForKey:@"_fake_y"] floatValue];
    //    };
}

- (CLLocationCoordinate2D) coordinate_ {
    
    CLLocationCoordinate2D pos = [self coordinate_];
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"_fake_x"]) {
        x = [[[NSUserDefaults standardUserDefaults] valueForKey:@"_fake_x"] floatValue];
    };
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"_fake_y"]) {
        y = [[[NSUserDefaults standardUserDefaults] valueForKey:@"_fake_y"] floatValue];
    };
    
    return CLLocationCoordinate2DMake(x, y);
    //    return CLLocationCoordinate2DMake(pos.latitude-x, pos.longitude-y);
}


@end



CHDeclareClass(LocationManager)

CHMethod3(void, LocationManager, locationManager, id, arg1, didUpdateToLocation, id, arg2, fromLocation, id, arg3){
    CHSuper3(LocationManager, locationManager, arg1, didUpdateToLocation, arg2, fromLocation, arg3);
    
//    CLLocationCoordinate2D posLL = * (CLLocationCoordinate2D *)[(CLLocation *)arg2 coordinate];
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:31.279867 longitude:120.666084];
    arg2 = loc;
    
//    [[NSUserDefaults standardUserDefaults] setValue:@(posLL.latitude) forKey:@"_fake_x"];
//    [[NSUserDefaults standardUserDefaults] setValue:@(posLL.longitude) forKey:@"_fake_y"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
}


__attribute__((constructor)) static void entry()
{
    NSLog(@"Hello, Danny Hooked WX WORK!");
    CHLoadLateClass(LocationManager);
    CHClassHook(3, LocationManager,locationManager,didUpdateToLocation,fromLocation);
}















