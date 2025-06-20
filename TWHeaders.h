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

// Define minimal interface for layout container
@interface UILayoutContainerView : UIView
- (UIViewController *)findTopViewController;
- (void)promptForATTToken;
@end