//
//  WTPoi.h
//  WTSimpleARBrowserExample
//
//  Created by Andreas Schacherbauer on 1/23/12.
//  Copyright (c) 2012 Wikitude GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTPoi : NSObject

@property (nonatomic, assign) double                        latitude;
@property (nonatomic, assign) double                        longitude;
@property (nonatomic, assign) double                        altitude;

@property (nonatomic, assign) NSInteger                     type;
@property (nonatomic, assign) NSInteger                     poiId;
@property (nonatomic, strong) NSString                      *name;
@property (nonatomic, strong) NSString                      *detailedDescription;


- (NSDictionary*)jsonRepresentation;

@end
