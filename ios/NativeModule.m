//
//  NativeModule.m
//  NativeModuleExample
//
//  Created by Hoang Doan on 10/31/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface RCT_EXTERN_MODULE(NativeModule, NSObject)

RCT_EXTERN_METHOD(getString:(NSString *)str)
RCT_EXTERN_METHOD(startGetLocation)
RCT_EXTERN_METHOD(stopGetLocation)



@end
