//
//  WTExamplesManager.m
//  WikitudeSDKExamples
//
//  Created by Andreas Schacherbauer on 3/1/13.
//  Copyright (c) 2013 Wikitude. All rights reserved.
//

#import "WTExamplesManager.h"

@interface WTExamplesManager ()

@property (nonatomic, strong) NSArray               *examplesArray;
@property (nonatomic, strong) NSArray               *exampleGroupTitles;
@property (nonatomic, strong) NSDictionary          *exampleViewController;

@end

@implementation WTExamplesManager

- (id)initWithExamplesPlistName:(NSString *)nameForExamplesPlist groupTitlePlistName:(NSString *)nameForTitlePlist viewControllerPlistName:(NSString *)viewControllerPlist
{
    self = [super init];
    if (self) {
        
        self.examplesPlistName = nameForExamplesPlist;
        self.exampleGroupPlistName = nameForTitlePlist;
        self.exampleViewControllerPlistName = viewControllerPlist;
    }
    
    return self;
}

#pragma mark - Example Lifecycle

- (BOOL)loadExamples
{
    BOOL loadedExamples = NO;
    
    if (self.examplesPlistName && self.exampleGroupPlistName && self.exampleViewControllerPlistName) {
        
        NSURL *absoluteExamplePlistURL = [[NSBundle mainBundle] URLForResource:self.examplesPlistName withExtension:@"plist"];
        self.examplesArray = [NSArray arrayWithContentsOfURL:absoluteExamplePlistURL];
        
        NSURL *absoluteGroupTitlePlistURL = [[NSBundle mainBundle] URLForResource:self.exampleGroupPlistName withExtension:@"plist"];
        self.exampleGroupTitles = [NSArray arrayWithContentsOfURL:absoluteGroupTitlePlistURL];
        
        NSURL *absoluteViewControllerPlistURL = [[NSBundle mainBundle]URLForResource:self.exampleViewControllerPlistName withExtension:@"plist"];
        self.exampleViewController = [NSDictionary dictionaryWithContentsOfURL:absoluteViewControllerPlistURL];
        
        
        if (self.examplesArray && self.exampleGroupTitles && self.exampleViewControllerPlistName) {
            
            loadedExamples = YES;
            
        }else {
        
            loadedExamples = NO;
        }
    }
    
    return loadedExamples;
}

#pragma mark - Accessing Example Information

- (NSInteger)numberOfExampleSections
{
    return self.examplesArray.count;
}

- (NSInteger)numberOfExamplesInSection:(NSInteger)section
{
    NSInteger numberOfExamplesInSection = 0;
    
    NSArray *exampleSection = [self.examplesArray objectAtIndex:section];
    if (exampleSection) {
        numberOfExamplesInSection = [exampleSection count];
    }
    
    return numberOfExamplesInSection;
}

- (NSString *)groupTitleForSection:(NSInteger)groupSection
{
    return [self.exampleGroupTitles objectAtIndex:groupSection];
}

- (NSString *)exampleTitleForIndexPath:(NSIndexPath *)indexPath
{
    return [self examplePropertyForName:@"Title" atIndexPath:indexPath];
}

- (NSString *)examplePathForIndexPath:(NSIndexPath *)indexPath
{
    return [self examplePropertyForName:@"Path" atIndexPath:indexPath];
}

- (NSString *)exampleViewControllerForIndexPath:(NSIndexPath *)indexPath
{
    NSString *viewControllerClassString = [self.exampleViewController objectForKey:[NSString stringWithFormat:@"%i%i", indexPath.section +1, indexPath.row +1]]; // +1 because the plist entrys reflect the section/row based on index 1 instead of index 0
    
    return  viewControllerClassString ? viewControllerClassString : @"WTStandardARViewController";
}


#pragma mark - Private worker

- (NSDictionary *)exampleForIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *example = nil;
    
    NSArray *exampleSection = [self.examplesArray objectAtIndex:indexPath.section];
    if (exampleSection) {
        
        example = [exampleSection objectAtIndex:indexPath.row];
    }
    
    return example;
}


- (NSString *)examplePropertyForName:(NSString *)propertyName atIndexPath:(NSIndexPath *)indexPath
{
    NSString *exampleProperty = nil;
    
    NSDictionary *example = [self exampleForIndexPath:indexPath];
    if (example && propertyName) {
        exampleProperty = [example objectForKey:propertyName];
    }
    
    return exampleProperty;
}

@end
