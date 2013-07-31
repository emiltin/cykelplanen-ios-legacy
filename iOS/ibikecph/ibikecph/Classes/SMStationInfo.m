//
//  SMRouteStationInfo.m
//  I Bike CPH
//
//  Created by Nikola Markovic on 7/5/13.
//  Copyright (c) 2013 City of Copenhagen. All rights reserved.
//

#import "SMStationInfo.h"
#import "SMGeocoder.h"
#import "SMTransportation.h"
#define KEY_LONGITUDE @"KeyLongitude"
#define KEY_LATITUDE @"KeyLatitude"
#define KEY_STATION_NAME @"KeyStationName"

@implementation SMStationInfo

-(id)initWithCoordinate:(CLLocationCoordinate2D)coord{
    if(self= [self initWithLongitude:coord.longitude latitude:coord.latitude]){}
    return self;
}

-(id)initWithLongitude:(double)lon latitude:(double)lat{
    if(self= [super init]){
        self.location= [[CLLocation alloc] initWithLatitude:lat longitude:lon];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeDouble:self.longitude forKey:KEY_LONGITUDE];
    [aCoder encodeDouble:self.latitude forKey:KEY_LATITUDE];
    [aCoder encodeObject:self.name forKey:KEY_STATION_NAME];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self= [super init]){
        self.name= [aDecoder decodeObjectForKey:KEY_STATION_NAME];
        double lat= [aDecoder decodeDoubleForKey:KEY_LATITUDE];
        double lng= [aDecoder decodeDoubleForKey:KEY_LONGITUDE];
        self.location= [[CLLocation alloc] initWithLatitude:lat longitude:lng];
    }
    return self;
}

-(id)initWithLongitude:(double)lon latitude:(double)lat andName:(NSString*)name {
    if(self= [super init]){
        self.name = name;
        self.location = [[CLLocation alloc] initWithLatitude:lat longitude:lon];

    }
    return self;
}

-(void)setLocation:(CLLocation *)pLocation{
    _location= pLocation;
    _longitude= pLocation.coordinate.longitude;
    _latitude= pLocation.coordinate.latitude;

    [[NSOperationQueue mainQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        [self fetchName];
    }]];

}

-(void)fetchName{

    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(_latitude, _longitude);
    __weak SMStationInfo* selfRef= self;
    [SMGeocoder reverseGeocode:coord completionHandler:^(NSDictionary *response, NSError *error) {
        
        NSString* streetName = [response objectForKey:@"title"];
        if (!streetName || [streetName isEqual:[NSNull null]] || [streetName isEqualToString:@""]) {
            streetName = [NSString stringWithFormat:@"Station %f, %f", coord.latitude, coord.longitude];

        }
        selfRef.name= streetName;
        
    }];

}

-(BOOL)isEqual:(id)object{
    SMStationInfo* other= object;

    return [self.location isEqual:other.location];
}

-(BOOL)isValid{
    return self.name;
}
@end
