// Autogenerated from Pigeon (v1.0.19), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import <Foundation/Foundation.h>
@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

@class EventRequest;
@class EventResponse;

@interface EventRequest : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithName:(NSString *)name
    id:(NSString *)id
    type:(NSString *)type;
@property(nonatomic, copy) NSString * name;
@property(nonatomic, copy) NSString * id;
@property(nonatomic, copy) NSString * type;
@end

@interface EventResponse : NSObject
+ (instancetype)makeWithData:(nullable NSString *)data
    code:(nullable NSNumber *)code
    desc:(nullable NSString *)desc;
@property(nonatomic, copy, nullable) NSString * data;
@property(nonatomic, strong, nullable) NSNumber * code;
@property(nonatomic, copy, nullable) NSString * desc;
@end

/// The codec used by YandexAdsApi.
NSObject<FlutterMessageCodec> *YandexAdsApiGetCodec(void);

@protocol YandexAdsApi
/// @return `nil` only when `error != nil`.
- (void)initializeWithError:(FlutterError *_Nullable *_Nonnull)error;
/// @return `nil` only when `error != nil`.
- (void)onAdLoadedRequest:(nullable EventRequest *)request completion:(void(^)(EventResponse *_Nullable, FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)onAdFailedToLoadRequest:(nullable EventRequest *)request completion:(void(^)(EventResponse *_Nullable, FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)onImpressionRequest:(nullable EventRequest *)request completion:(void(^)(EventResponse *_Nullable, FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)onAdClickedRequest:(nullable EventRequest *)request completion:(void(^)(EventResponse *_Nullable, FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)onLeftApplicationRequest:(nullable EventRequest *)request completion:(void(^)(EventResponse *_Nullable, FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)onReturnedToApplicationRequest:(nullable EventRequest *)request completion:(void(^)(EventResponse *_Nullable, FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)onAdShownRequest:(nullable EventRequest *)request completion:(void(^)(EventResponse *_Nullable, FlutterError *_Nullable))completion;
/// @return `nil` only when `error != nil`.
- (void)onAdDismissedRequest:(nullable EventRequest *)request completion:(void(^)(EventResponse *_Nullable, FlutterError *_Nullable))completion;
@end

extern void YandexAdsApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<YandexAdsApi> *_Nullable api);

NS_ASSUME_NONNULL_END
