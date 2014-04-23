#import "VPLLocationPromotion.h"

@implementation VPLLocationPromotion

- (instancetype)initWithCity:(NSString *)city
                       state:(NSString *)state
                     country:(NSString *)country
            uniqueIdentifier:(NSString *)identifier
                      action:(VPLPromotionAction)action {
    self = [super init];
    if (self) {
        self.city       = city;
        self.state      = state;
        self.country    = country;
        self.identifier = identifier;
        self.action     = action;
    }
    return self;
}


- (NSString *)nextFireDateDefaultsKey {
    return [NSString stringWithFormat:@"kVPL%@NextFireDate", self.identifier];
}


- (BOOL)shouldTriggerOnDate:(NSDate *)date atLocation:(VPLLocation *)location {
    if (![location isValid]) {
        return NO;
    }
    if (![self shouldTriggerOnDate:date] || ![self shouldTriggerAtLocation:location]) {
        return NO;
    }
    return YES;
}


- (BOOL)shouldTriggerAtLocation:(VPLLocation *)location {
    if (self.city && self.state && self.country) {
        if (![self.city isEqualToString: location.city] && ![self.city isEqualToString:kVPLWildCardLocationAttribute]) {
            return NO;
        }
        else if (![self.state isEqualToString: location.state] && ![self.state isEqualToString:kVPLWildCardLocationAttribute]) {
            return NO;
        }
        else if (![self.country isEqualToString: location.country] && ![self.country isEqualToString:kVPLWildCardLocationAttribute]) {
            return NO;
        }
        return YES;
    }
    return NO;
}


#pragma mark - Setters

- (void)setCity:(NSString *)city {
    _city = ![city isKindOfClass:[NSNull class]] ? [city sanitizeString] : @"";
}


- (void)setState:(NSString *)state {
    _state = ![state isKindOfClass:[NSNull class]] ? [state sanitizeString] : @"";
}


- (void)setCountry:(NSString *)country {
    _country = ![country isKindOfClass:[NSNull class]] ? [country sanitizeString] : @"";
}

@end
