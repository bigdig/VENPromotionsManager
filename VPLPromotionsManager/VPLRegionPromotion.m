#import "VPLRegionPromotion.h"

@implementation VPLRegionPromotion

- (instancetype)initWithRegion:(CLRegion *)region
                      repeatInterval:(NSInteger)repeatInterval
                              enterAction:(VPLPromotionAction)action {
    self = [super init];
    if (self) {
        self.region             = region;
        self.identifier         = region.identifier;
        self.repeatInterval     = repeatInterval;
        self.nextFireDate       = [[NSUserDefaults standardUserDefaults]
                                   objectForKey:[self nextFireDateDefaultsKey]];
        if (self.repeatInterval == NSIntegerMax) {
            self.showOnce = YES;
        }
        self.action = action;
    }
    return self;
}

- (NSString *)nextFireDateDefaultsKey {
    return [NSString stringWithFormat:@"kVPL%@NextFireDate", self.region.identifier];
}

- (BOOL)shouldTriggerOnDate:(NSDate *)date {
    if (![super shouldTriggerOnDate:date]) {
        return NO;
    }
    if (self.nextFireDate) {
        if ([date compare:self.nextFireDate] == NSOrderedAscending) {
            return NO;
        }
    }
    return YES;
}

- (void)triggerPromotion {
    [super triggerPromotion];
    self.nextFireDate = [[NSDate date] dateByAddingTimeInterval:self.repeatInterval];
    [self saveNextFireDate];
}

- (void) saveNextFireDate {
    [[NSUserDefaults standardUserDefaults] setObject:self.nextFireDate forKey:[self nextFireDateDefaultsKey]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma Custom Setters

- (void)setStartDate:(NSDate *)startDate {
    [super setStartDate:startDate];
    if ([[NSDate date] compare: startDate] ==  NSOrderedAscending && !self.nextFireDate) {
        self.nextFireDate = startDate;
        [self saveNextFireDate];
    }
}

@end
