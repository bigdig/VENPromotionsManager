#import "VPLPromotion.h"
#import <CoreLocation/CoreLocation.h>

@interface VPLRegionPromotion : VPLPromotion

///The region that should trigger this promotion
@property (nonatomic, strong) CLRegion *region;

///The minimum number of seconds before this promotion can reappear. If repeatInterval is equal to NSIntegerMax, showOnce will default to YES.
@property (nonatomic, assign) NSInteger repeatInterval;

///This next date this promotion is triggerable. This should not be set manually. Instead, use startDate.
@property (nonatomic, strong) NSDate* nextFireDate;


/**
 Creates a promotion object instance. If you are creating a singleton object use startWithPromotions: instead.
 @param region the region for which this promotion should fire. The region's identifier will also become the promotion's identifier, so it should be unique and must not match the identifier of any other promotion.
 @param repeatInterval minimum number of seconds before this promotion can reappear
 @param enterAction The action that should occur when the device enters the region
 @return An `VPLRegionPromotion` instance
 */
- (instancetype)initWithRegion:(CLRegion *)region
                      repeatInterval:(NSInteger)repeatInterval
                              enterAction:(VPLPromotionAction)enterAction;

@end