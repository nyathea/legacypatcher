// Define minimal interface for trust evaluator
@interface TNUTLSTrustEvaluator : NSObject
- (BOOL)_isPinnedCertificateChain:(SecTrustRef)trust;
- (void)_cacheValidLeafCertificateFingerprint:(NSString *)fingerprint;
@end

// Define minimal interfaces for timeline filtering
@interface T1URTTimelineUserItemViewModel : NSObject
@property(nonatomic, retain) NSString *scribeComponent;
@end

@interface T1URTFooterViewModel : NSObject
@property(nonatomic, retain) NSURL *url;
@end

@interface TFNTwitterModuleFooter : NSObject
@property(nonatomic, retain) NSURL *url;
@end

@interface TFNItemsDataViewController : NSObject
@property(nonatomic, retain) NSArray *sections;
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
@end

// Define minimal interface for media URLs
@interface TFSTwitterEntityMedia : NSObject
@property(nonatomic, retain) NSString *originalDisplayURL;
@property(nonatomic, retain) NSString *displayURL;
@property(nonatomic, retain) NSString *accessibilityText;
@end

// Define minimal interface for tweet footer
@interface T1TweetDetailsFooterItem : NSObject
@property(nonatomic, retain) NSString *source;
@end

// Define minimal interface for API requests
@interface TFSTwitterAPIEndpointRequest : NSObject
- (id)initWithEndpointPath:(NSString *)endpointPath parameters:(NSDictionary *)parameters;
- (id)initWithEndpointPath:(NSString *)endpointPath parameters:(NSDictionary *)parameters method:(long long)method;
@end

@interface TFSAPISession : NSObject
- (void)tnl_requestOperation:(id)operation hydrateRequest:(id)apiRequest completion:(id)completion;
@end

@interface TFSTwitterAPITranslationsShowRequest : NSObject
+ (NSString *)endpointPath;
+ (unsigned long long)baseURLType;
- (NSDictionary *)parameters;
@end
