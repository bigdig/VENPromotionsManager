#import <Foundation/Foundation.h>
#import "VPLLocationServiceProtocol.h"
#import "VPLPromotionsManager.h"

@interface VPLPromotionLocationGPSService : NSObject <VPLLocationServiceProtocol>

@property (copy) void(^regionFoundCallback)(CLBeaconRegion *region, NSArray *beacons);

- (id)initWithLocationAccuracy:(CLLocationAccuracy)accuracy
  minimumHorizontalAccuracy:(float)horizontalAccuracy;

- (void)startMonitoringForRegion:(CLRegion *)region;

- (void)stopMonitoringForRegion:(CLRegion *)region;


@end
