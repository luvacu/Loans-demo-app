#import "LVCLocation.h"

@interface LVCLocation () {
    CLLocationCoordinate2D _internalCoordinate;
}

@end

@implementation LVCLocation

// Custom logic goes here.

- (void)didImport:(id)data {
    if (![data isKindOfClass:NSDictionary.class]) {
        return;
    }
    NSDictionary *dataDictionary = (NSDictionary *)data;
    id geo = dataDictionary[@"geo"];
    if (![geo isKindOfClass:NSDictionary.class]) {
        return;
    }
    
    NSDictionary *geoDictionary = (NSDictionary *)geo;
    id pairs = geoDictionary[@"pairs"];
    if (![pairs isKindOfClass:NSString.class]) {
        return;
    }
    
    NSString *pairsString = (NSString *)pairs;
    NSArray *pairsArray = [pairsString componentsSeparatedByCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
    if (pairsArray && pairsArray.count > 1) {
        self.latitude = @([pairsArray[0] doubleValue]);
        self.longitude = @([pairsArray[1] doubleValue]);
    }
}

#pragma mark - MKAnnotation

- (CLLocationCoordinate2D)coordinate {
    if (_internalCoordinate.latitude == 0
        && _internalCoordinate.longitude == 0) {
        _internalCoordinate = CLLocationCoordinate2DMake(self.latitude.doubleValue, self.longitude.doubleValue);
    }
    return _internalCoordinate;
}

- (NSString *)title {
    if (!self.town || self.town.length < 2) {
        return [self.country copy];
    }
    return [NSString stringWithFormat:@"%@, %@", self.town, self.country];
}

#pragma mark -

@end
