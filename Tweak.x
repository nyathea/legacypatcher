#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "TWHeaders.h"

// MARK: bypass certificate check
%hook TNUTLSTrustEvaluator

- (BOOL)_isPinnedCertificateChain:(SecTrustRef)trust {
    return YES;
}

%end

static NSString *originalAppVersion = nil;

// MARK: Detect original app version
%hook NSBundle
- (NSDictionary *)infoDictionary {
    NSDictionary *dict = %orig;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        // Only capture the original version, don't modify it
        if (dict[@"CFBundleShortVersionString"] && !originalAppVersion) {
            originalAppVersion = [dict[@"CFBundleShortVersionString"] copy];
            NSLog(@"BHT_LOG: Detected Original App Version: %@", originalAppVersion);
        }
    });
    return dict;
}
%end

// Some QOL features

// MARK: Remove useless fleet bar
%hook T1HomeTimelineItemsViewController
- (void)_t1_initializeFleets {
    if (originalAppVersion && [originalAppVersion compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending) {
        return;
    }
    %orig;
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

// MARK: various enhancements enable birdwatch, video zoom, disable video captions, disables verified tab in notifications
%hook TFNTwitterAccount
- (BOOL)hasBirdwatchNotes {
    return true;
}
- (BOOL)isBirdwatchPivotEnabled {
    return true;
}
- (BOOL)isBirdwatchConsumptionEnabled {
    return true;
}
- (BOOL)isVideoDynamicAdEnabled {
    return false;
}
- (BOOL)isVideoZoomEnabled {
    return true;
}
- (BOOL)isVODCaptionsEnabled {
    return false;
}
- (BOOL)isEditProfileUsernameEnabled {
    return true;
}
- (BOOL)isVitScopedNotificationsEnabled {
    return false;
}
- (BOOL)isVitNotificationsFilteringEnabled {
    return false;
}
- (BOOL)isDMVoiceCreationEnabled {
    return true;
}
- (NSUInteger)unretweetRequestMode {
    return 2;
}
- (NSUInteger)retweetRequestMode {
    return 2;
}
- (NSUInteger)destroyStatusRequestMode {
    return 2;
}
- (NSUInteger)updateStatusRequestMode {
    return 2;
}
- (NSUInteger)unfavoriteRequestMode {
    return 2;
}
- (NSUInteger)favoriteRequestMode {
    return 2;
}
%end

// MARK: Enable voice button in composer
%hook T1PhotoMediaRailViewController
- (BOOL)isVoiceButtonHidden {
    return false;
}
%end

// MARK: fix for affiliate badges showing up on profiles on v8.x
%hook TTACoreAnatomyFeatures
- (BOOL)isAffiliateBadgeEnabled {
    return false;
}
- (BOOL)isVerificationV2AffiliateBadgingEnabled {
    return false;
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

// MARK: Enable undo tweet
%hook TFNTwitterToastNudgeExperimentModel
- (BOOL)shouldShowShowUndoTweetSentToast {
    if (originalAppVersion && [originalAppVersion compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending) {
        return true;
    }
    return %orig;
}
%end

// Helper function to check if we're in the T1ConversationContainerViewController hierarchy
static BOOL BHT_isInConversationContainerHierarchy(UIViewController *viewController) {
    if (!viewController) return NO;
    
    // Check all view controllers up the hierarchy
    UIViewController *currentVC = viewController;
    while (currentVC) {
        NSString *className = NSStringFromClass([currentVC class]);
        
        // Check for T1ConversationContainerViewController
        if ([className isEqualToString:@"T1ConversationContainerViewController"]) {
            return YES;
        }
        
        // Move up the hierarchy
        if (currentVC.parentViewController) {
            currentVC = currentVC.parentViewController;
        } else if (currentVC.navigationController) {
            currentVC = currentVC.navigationController;
        } else if (currentVC.presentingViewController) {
            currentVC = currentVC.presentingViewController;
        } else {
            break;
        }
    }
    
    return NO;
}

// MARK : Remove "Discover More" section
%hook T1URTViewController

- (void)setSections:(NSArray *)sections {
    if (originalAppVersion && [originalAppVersion compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending) {
        // Only filter if we're in the T1ConversationContainerViewController hierarchy
        BOOL inConversationHierarchy = BHT_isInConversationContainerHierarchy((UIViewController *)self);
        
        if (inConversationHierarchy) {
            // Remove entry 1 (index 1) from sections array
            if (sections.count > 1) {
                NSMutableArray *filteredSections = [NSMutableArray arrayWithArray:sections];
                [filteredSections removeObjectAtIndex:1];
                sections = [filteredSections copy];
            }
        }
    }
    
    %orig(sections);
}

%end

%hook T1TFNUIConfiguration
- (BOOL)isChirpFontEnabled {
    if (originalAppVersion && [originalAppVersion compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending) {
        return true;
    }
    return %orig;
}
// - (BOOL)isNestedActionButtonEnabled {
//    if (originalAppVersion && [originalAppVersion compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending) {
//        return true;
//    }
//    return %orig;
//}
%end

// MARK: force highest quality for media
%hook TFNTwitterMediaUploadConfiguration
- (_Bool)photoUploadHighQualityImagesSettingIsVisible {
    return true;
}
%end

%hook T1SlideshowViewController
- (_Bool)_t1_shouldDisplayLoadHighQualityImageItemForImageDisplayView:(id)arg1 highestQuality:(_Bool)arg2 {
    return true;
}
- (id)_t1_loadHighQualityActionItemWithTitle:(id)arg1 forImageDisplayView:(id)arg2 highestQuality:(_Bool)arg3 {
            arg3 = true; {
    }
    return %orig(arg1, arg2, arg3);
}
%end

%hook T1ImageDisplayView
- (_Bool)_tfn_shouldUseHighestQualityImage {
    return true;
}
- (_Bool)_tfn_shouldUseHighQualityImage {
    return true;
}
%end

%hook T1HighQualityImagesUploadSettings
- (_Bool)shouldUploadHighQualityImages {
    return true;
}
%end

// MARK: Fix Translate button endpoint
%hook TFSTwitterAPITranslationsShowRequest

+ (NSString *)endpointPath {
    return @"/graphql/UKHMx2KR1yByLE3fcs4Sbw/TranslateTweetResults";
}

+ (unsigned long long)baseURLType {
    return 0;
}

- (NSDictionary *)parameters {
    NSDictionary *originalParameters = %orig;
    if (!originalParameters) {
        return nil;
    }

    NSString *tweetID = originalParameters[@"id"];
    if (!tweetID) {
        return originalParameters;
    }

    NSDictionary *variables = @{
        @"rest_id": tweetID,
        @"translation_source": @"Google"
    };
    NSDictionary *features = @{
        @"immersive_video_status_linkable_timestamps": @(YES)
    };
    
    NSData *variablesData = [NSJSONSerialization dataWithJSONObject:variables options:0 error:nil];
    NSData *featuresData = [NSJSONSerialization dataWithJSONObject:features options:0 error:nil];
    
    if (variablesData && featuresData) {
        NSString *variablesString = [[NSString alloc] initWithData:variablesData encoding:NSUTF8StringEncoding];
        NSString *featuresString = [[NSString alloc] initWithData:featuresData encoding:NSUTF8StringEncoding];

        if (variablesString && featuresString) {
            return @{
                @"variables": variablesString,
                @"features": featuresString
            };
        }
    }
    return originalParameters;
}

%end

%hook NSJSONSerialization
+ (id)JSONObjectWithData:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError **)error {
    id JSONObject = %orig(data, opt, error);

    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([jsonString containsString:@"Fatigue"]) {
        return @{};
    }

    if (JSONObject && [JSONObject isKindOfClass:[NSDictionary class]]) {
        id tweetResults = [JSONObject valueForKeyPath:@"data.tweet_results.result.translate_tweet"];
        if (tweetResults && [tweetResults isKindOfClass:[NSDictionary class]]) {
            NSString *translationText = tweetResults[@"translation"];
            NSString *translationState = tweetResults[@"translation_state"];
            
            if (translationText && [translationState isEqualToString:@"Success"]) {
                NSString *tweetID = [JSONObject valueForKeyPath:@"data.tweet_results.rest_id"];
                
                return @{
                    @"id_str": tweetID ?: @"",
                    @"text": translationText,
                    @"translation": translationText,
                    @"dest": tweetResults[@"destination_language"] ?: @"en",
                    @"source_language": tweetResults[@"source_language"] ?: @"",
                    @"localized_source_language": tweetResults[@"localized_source_language"] ?: @"",
                    @"entities": tweetResults[@"entities"] ?: @{}
                };
            }
        }
    }
    
    return JSONObject;
}
%end

// MARK: About Settings extended info
%hook T1AboutSettingsViewController

- (void)setSections:(NSArray *)sections {
    if (originalAppVersion && sections.count > 0) {
        NSMutableArray *modifiedSections = [NSMutableArray arrayWithArray:sections];
        
        // Get the first section and add our custom items
        if (modifiedSections[0] && [modifiedSections[0] isKindOfClass:[NSArray class]]) {
            NSMutableArray *firstSection = [NSMutableArray arrayWithArray:modifiedSections[0]];
            
            // Insert our custom items at indices 1-4 (after the original version)
            [firstSection insertObject:@"PatcherVersion" atIndex:1];
#ifndef FINALPACKAGE
            [firstSection insertObject:@"BranchInfo" atIndex:2];
            [firstSection insertObject:@"CommitInfo" atIndex:3];
#endif
            
            // Replace the first section
            [modifiedSections replaceObjectAtIndex:0 withObject:[firstSection copy]];
        }
        
        sections = [modifiedSections copy];
    }
    
    %orig(sections);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"BHT_LOG: cellForRowAtIndexPath - section: %ld, row: %ld", (long)indexPath.section, (long)indexPath.row);
    
    if (originalAppVersion && indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSLog(@"BHT_LOG: Modifying original version cell");
            // Modify the existing version cell to show original version
            UITableViewCell *cell = %orig;
            if (cell.textLabel) {
                cell.textLabel.text = @"App Version";
                if (cell.detailTextLabel) {
                    cell.detailTextLabel.text = originalAppVersion;
                }
            }
            return cell;
        } else if (indexPath.row == 1) {
            NSLog(@"BHT_LOG: Creating patcher version cell");
            // Create patcher version cell
            TFNTextCell *patcherCell = [%c(TFNTextCell) value1CellForTableView:tableView
                                                                     indexPath:indexPath
                                                                      withText:@"Patcher Version"
                                                                    detailText:@PATCHER_VERSION
                                                                 accessoryType:0];
            patcherCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return patcherCell;
#ifndef FINALPACKAGE
        } else if (indexPath.row == 2) {
            NSLog(@"BHT_LOG: Creating branch info cell");
            // Create branch info cell
            TFNTextCell *branchCell = [%c(TFNTextCell) value1CellForTableView:tableView 
                                                                     indexPath:indexPath 
                                                                      withText:@"Branch" 
                                                                    detailText:@GIT_BRANCH 
                                                                 accessoryType:0];
            branchCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return branchCell;
        } else if (indexPath.row == 3) {
            NSLog(@"BHT_LOG: Creating commit info cell");
            // Create commit info cell
            TFNTextCell *commitCell = [%c(TFNTextCell) value1CellForTableView:tableView 
                                                                      indexPath:indexPath 
                                                                       withText:@"Commit" 
                                                                     detailText:@GIT_COMMIT_HASH 
                                                                  accessoryType:0];
            commitCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return commitCell;
#endif
        }
    }
    
    return %orig;
}

%end

static NSString *spoofedVersion = @"9.67";

%hook NSMutableURLRequest
- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    if ([field isEqualToString:@"X-Twitter-Client-Version"] && 
        self.URL && 
        [self.URL.absoluteString containsString:@"/1.1/onboarding/"]) {
        
        %orig(spoofedVersion, field);
        return;
    }
    
    if ([field isEqualToString:@"User-Agent"] && 
        self.URL && 
        [self.URL.absoluteString containsString:@"/1.1/onboarding/"]) {
        
        NSError *error = nil;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(Twitter-[^/]+/)[0-9.]+" 
                                                                               options:0 
                                                                                 error:&error];
        if (regex && !error) {
            NSString *modifiedAgent = [regex stringByReplacingMatchesInString:value 
                                                                      options:0 
                                                                        range:NSMakeRange(0, value.length) 
                                                                 withTemplate:[NSString stringWithFormat:@"$1%@", spoofedVersion]];
            %orig(modifiedAgent, field);
            return;
        }
    }
    
    %orig(value, field);
}
%end

// MARK: fix source labels and other issues on 8.x
%hook T1GraphQLFeatures
- (BOOL)isUrtConversationTimelineEnabled {
   return true;
}
%end
