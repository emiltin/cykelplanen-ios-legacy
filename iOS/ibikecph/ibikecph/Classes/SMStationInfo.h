//
//  SMRouteStationInfo.h
//  I Bike CPH
//
//  Created by Nikola Markovic on 7/5/13.
//  Copyright (c) 2013 City of Copenhagen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMStationInfo : NSObject<NSCoding>
-(id)initWithCoordinate:(CLLocationCoordinate2D)coord;
-(id)initWithLongitude:(double)lon latitude:(double)lat;
-(id)initWithLongitude:(double)lon latitude:(double)lat andName:(NSString*)name;

@property(nonatomic, strong) CLLocation* location;
@property(nonatomic, assign, readonly) double longitude;
@property(nonatomic, assign, readonly) double latitude;
@property(nonatomic, strong) NSString* name;

-(BOOL)isValid;
@end
