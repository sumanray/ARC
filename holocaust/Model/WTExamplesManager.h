//
//  WTExamplesManager.h
//  WikitudeSDKExamples
//
//  Created by Andreas Schacherbauer on 3/1/13.
//  Copyright (c) 2013 Wikitude. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTExamplesManager : NSObject

@property (nonatomic, strong) NSString                 *examplesPlistName;
@property (nonatomic, strong) NSString                 *exampleGroupPlistName;
@property (nonatomic, strong) NSString                 *exampleViewControllerPlistName;

- (id)initWithExamplesPlistName:(NSString *)nameForExamplesPlist groupTitlePlistName:(NSString *)nameForTitlePlist viewControllerPlistName:(NSString *)viewControllerPlist;
- (BOOL)loadExamples;

- (NSInteger)numberOfExampleSections;
- (NSInteger)numberOfExamplesInSection:(NSInteger)section;

- (NSString *)groupTitleForSection:(NSInteger)groupSection;

- (NSString *)exampleTitleForIndexPath:(NSIndexPath *)indexPath;
- (NSString *)examplePathForIndexPath:(NSIndexPath *)indexPath;
- (NSString *)exampleViewControllerForIndexPath:(NSIndexPath *)indexPath;

@end
