#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(MazadatImagePicker6, NSObject)

RCT_EXTERN_METHOD(multiply:(float)a b:(float)b
                 resolve:(RCTPromiseResolveBlock)resolve
                 reject:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(openCamera:(NSString *)title_ aspect_ratio_x:(float)aspect_ratio_x 
                 aspect_ratio_y:(float)aspect_ratio_y
                 resolve:(RCTPromiseResolveBlock)resolve
                 reject:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(openGallery:(NSString *)title_ aspect_ratio_x:(float)aspect_ratio_x 
                 aspect_ratio_y:(float)aspect_ratio_y
                 resolve:(RCTPromiseResolveBlock)resolve
                 reject:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(editPhoto:(NSString *)title_ image_:(NSString *)image_                                   aspect_ratio_x:(float)aspect_ratio_x
                 aspect_ratio_y:(float)aspect_ratio_y
                 resolve:(RCTPromiseResolveBlock)resolve
                 reject:(RCTPromiseRejectBlock)reject)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
