#import <Foundation/Foundation.h>
#import <Security/Security.h>
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface TNUTLSTrustEvaluator : NSObject
- (BOOL)_isPinnedCertificateChain:(SecTrustRef)trust;
@end

// Define minimal interface for media URLs
@interface TFSTwitterEntityMedia : NSObject
@property(nonatomic, retain) NSString *originalDisplayURL;
@property(nonatomic, retain) NSString *displayURL;
@property(nonatomic, retain) NSString *accessibilityText;
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

// MARK: bypass certificate check
%hook TNUTLSTrustEvaluator

- (BOOL)_isPinnedCertificateChain:(SecTrustRef)trust {
    return YES;
}

%end

// MARK: spoofing app version
%hook NSBundle

- (NSDictionary *)infoDictionary {
    NSDictionary *originalDict = %orig;
    NSMutableDictionary *modifiedDict = [originalDict mutableCopy];
    
    if (modifiedDict[@"CFBundleShortVersionString"]) {
        modifiedDict[@"CFBundleShortVersionString"] = @"9.44";
    }
    if (modifiedDict[@"CFBundleVersion"]) {
        modifiedDict[@"CFBundleVersion"] = @"9.44";
    }
    
    return [modifiedDict copy];
}

%end

// MARK: Remove useless fleet bar
%hook T1HomeTimelineItemsViewController
- (void)_t1_initializeFleets {
    return;
}
%end

// MARK: Hide ads, promoted content, and unwanted timeline items
%hook TFNItemsDataViewController

- (UITableViewCell *)tableViewCellForItem:(id)arg1 atIndexPath:(NSIndexPath *)arg2 {
    UITableViewCell *tbvCell = %orig;
    id item = [self itemAtIndexPath:arg2];
    
    // Hide promoted tweets/ads
    if ([item respondsToSelector:@selector(isPromoted)] && [item performSelector:@selector(isPromoted)]) {
        [tbvCell setHidden:YES];
        return tbvCell;
    }
    
    NSString *itemClassName = NSStringFromClass([item classForCoder]);
    
    // Hide news and trending
    if ([itemClassName isEqualToString:@"T1Twitter.URTTimelineTrendViewModel"] ||
        [itemClassName isEqualToString:@"T1Twitter.URTTimelineEventSummaryViewModel"] ||
        [itemClassName isEqualToString:@"T1URTTimelineMessageItemViewModel"]) {
        [tbvCell setHidden:YES];
        return tbvCell;
    }
    
    // Hide who to follow suggestions
    if ([itemClassName isEqualToString:@"TFNTwitterUser"] && 
        [NSStringFromClass([self class]) isEqualToString:@"T1HomeTimelineItemsViewController"]) {
        [tbvCell setHidden:YES];
        return tbvCell;
    }
    
    if ([itemClassName isEqualToString:@"T1URTTimelineUserItemViewModel"] && 
        [((T1URTTimelineUserItemViewModel *)item).scribeComponent isEqualToString:@"suggest_who_to_follow"]) {
        [tbvCell setHidden:YES];
        return tbvCell;
    }
    
    if ([itemClassName isEqualToString:@"T1Twitter.URTModuleHeaderViewModel"]) {
        [tbvCell setHidden:YES];
        return tbvCell;
    }
    
    if ([itemClassName isEqualToString:@"T1Twitter.URTTimelineCarouselViewModel"]) {
        [tbvCell setHidden:YES];
        return tbvCell;
    }
    
    if ([itemClassName isEqualToString:@"T1URTFooterViewModel"] && 
        [((T1URTFooterViewModel *)item).url.absoluteString containsString:@"connect_people"]) {
        [tbvCell setHidden:YES];
        return tbvCell;
    }
    
    if ([itemClassName isEqualToString:@"TFNTwitterModuleFooter"] && 
        [((TFNTwitterModuleFooter *)item).url.absoluteString containsString:@"connect_people"]) {
        [tbvCell setHidden:YES];
        return tbvCell;
    }
    
    return tbvCell;
}

- (double)tableView:(id)arg1 heightForRowAtIndexPath:(NSIndexPath *)arg2 {
    id item = [self itemAtIndexPath:arg2];
    
    // Hide promoted tweets/ads
    if ([item respondsToSelector:@selector(isPromoted)] && [item performSelector:@selector(isPromoted)]) {
        return 0;
    }
    
    NSString *itemClassName = NSStringFromClass([item classForCoder]);
    
    // Hide news and trending
    if ([itemClassName isEqualToString:@"T1Twitter.URTTimelineTrendViewModel"] ||
        [itemClassName isEqualToString:@"T1Twitter.URTTimelineEventSummaryViewModel"] ||
        [itemClassName isEqualToString:@"T1URTTimelineMessageItemViewModel"]) {
        return 0;
    }
    
    // Hide who to follow suggestions
    if ([itemClassName isEqualToString:@"TFNTwitterUser"] && 
        [NSStringFromClass([self class]) isEqualToString:@"T1HomeTimelineItemsViewController"]) {
        return 0;
    }
    
    if ([itemClassName isEqualToString:@"T1URTTimelineUserItemViewModel"] && 
        [((T1URTTimelineUserItemViewModel *)item).scribeComponent isEqualToString:@"suggest_who_to_follow"]) {
        return 0;
    }
    
    if ([itemClassName isEqualToString:@"T1Twitter.URTModuleHeaderViewModel"]) {
        return 0;
    }
    
    if ([itemClassName isEqualToString:@"T1Twitter.URTTimelineCarouselViewModel"]) {
        return 0;
    }
    
    if ([itemClassName isEqualToString:@"T1URTFooterViewModel"] && 
        [((T1URTFooterViewModel *)item).url.absoluteString containsString:@"connect_people"]) {
        return 0;
    }
    
    if ([itemClassName isEqualToString:@"TFNTwitterModuleFooter"] && 
        [((TFNTwitterModuleFooter *)item).url.absoluteString containsString:@"connect_people"]) {
        return 0;
    }
    
    return %orig;
}

- (double)tableView:(id)arg1 heightForHeaderInSection:(long long)arg2 {
    if (self.sections && 
        self.sections[arg2] && 
        ((NSArray *)self.sections[arg2]).count && 
        self.sections[arg2][0]) {
        NSString *sectionClassName = NSStringFromClass([self.sections[arg2][0] classForCoder]);
        if ([sectionClassName isEqualToString:@"TFNTwitterUser"]) {
            return 0;
        }
    }
    return %orig;
}

%end

// MARK: fix image urls
%hook TFSTwitterEntityMedia

- (NSString *)originalDisplayURL {
    NSString *originalURL = %orig;
    if (originalURL && [originalURL containsString:@"pic.x.com"]) {
        return [originalURL stringByReplacingOccurrencesOfString:@"pic.x.com" withString:@"pic.twitter.com"];
    }
    return originalURL;
}

- (NSString *)displayURL {
    NSString *originalURL = %orig;
    if (originalURL && [originalURL containsString:@"pic.x.com"]) {
        return [originalURL stringByReplacingOccurrencesOfString:@"pic.x.com" withString:@"pic.twitter.com"];
    }
    return originalURL;
}

- (NSString *)accessibilityText {
    NSString *originalText = %orig;
    if (originalText && [originalText containsString:@"pic.x.com"]) {
        return [originalText stringByReplacingOccurrencesOfString:@"pic.x.com" withString:@"pic.twitter.com"];
    }
    return originalText;
}

%end
