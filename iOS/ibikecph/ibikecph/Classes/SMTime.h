//
//  SMTime.h
//  I Bike CPH
//
//  Created by Nikola Markovic on 8/6/13.
//  Copyright (c) 2013 City of Copenhagen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMTime : NSObject

@property(nonatomic, assign) int hour;
@property(nonatomic, assign) int minutes;

-(SMTime*)differenceFrom:(SMTime*)other;

@end