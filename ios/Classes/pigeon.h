// Autogenerated from Pigeon (v3.2.6), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import <Foundation/Foundation.h>
@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

@class Model;

@interface Model : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithId:(NSNumber *)id
    title:(NSString *)title;
@property(nonatomic, strong) NSNumber * id;
@property(nonatomic, copy) NSString * title;
@end

/// The codec used by ModelApi.
NSObject<FlutterMessageCodec> *ModelApiGetCodec(void);

@protocol ModelApi
- (nullable Model *)getModelId:(NSNumber *)id error:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void ModelApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<ModelApi> *_Nullable api);

NS_ASSUME_NONNULL_END
