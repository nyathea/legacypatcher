#import <Foundation/Foundation.h>

@interface TNUTLSTrustEvaluator : NSObject
- (BOOL)_isPinnedCertificateChain:(SecTrustRef)trust;
@end

// MARK: bypass certificate check
%hook TNUTLSTrustEvaluator

- (BOOL)_isPinnedCertificateChain:(SecTrustRef)trust {
    return YES;
}

%end

// MARK: spoofing app version
%hook NSBundle

- (id)objectForInfoDictionaryKey:(NSString *)key {
    if ([key isEqualToString:@"CFBundleShortVersionString"]) {
        return @"9.44";
    }
    if ([key isEqualToString:@"CFBundleVersion"]) {
        return @"9.44";
    }
    return %orig;
}

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