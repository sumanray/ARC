//
//  WTPoi.m
//  WTSimpleARBrowserExample
//
//  Created by Andreas Schacherbauer on 1/23/12.
//  Copyright (c) 2012 Wikitude GmbH. All rights reserved.
//

#import "WTPoi.h"

@implementation WTPoi


- (NSDictionary*)jsonRepresentation
{
    NSArray *poiObjects = [NSArray arrayWithObjects:[NSNumber numberWithInteger:self.poiId], [NSNumber numberWithDouble:self.latitude], [NSNumber numberWithDouble:self.longitude], [NSNumber numberWithDouble:self.altitude], self.name, self.detailedDescription, nil];
    NSArray *poiKeys = [NSArray arrayWithObjects:@"id", @"latitude", @"longitude", @"altitude", @"name", @"description", nil];

    NSDictionary *jsonRepresentation = [NSDictionary dictionaryWithObjects:poiObjects forKeys:poiKeys];

    return jsonRepresentation;
}

@end
