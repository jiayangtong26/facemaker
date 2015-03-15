//
//  Categories.m
//  FaceMaker
//
//  Created by slim on 15-3-6.
//  Copyright (c) 2015年 UC CS. All rights reserved.
//

#import "Categories.h"
#import "ImageResource.h"
@interface Categories()
@property (nonatomic, assign, readwrite) CType type;
@property (nonatomic, strong) NSMutableArray *componentsArray;
@end
@implementation Categories

// return a certain type of Category instance
+ (Categories *)createComponentCategoriesByType:(CType)type
{
    Categories *categories = [[Categories alloc] initWithType:type];
    return categories;
}


// init the Category with certain type
- (instancetype)initWithType:(CType)type
{
    self = [super init];
    
    if (self) {
        self.type = type;
        
        NSArray *imageArray = [[ImageResource resourceArray] objectAtIndex:self.type];
        for (NSString *name in imageArray) {
            @autoreleasepool {
                Components *component = [Components createComponentsWithName:name];
                [self.componentsArray addObject:component];
            }
        }
    }
    
    return self;
}


// get a component under this category based on the index position
- (Components *)componentsAtIndex:(NSInteger)index
{
    if (index < 0 || index >= [self.componentsArray count]) return nil;
    return [self.componentsArray objectAtIndex:index];
}


// return the total number of components in this category
- (NSInteger)countOfComponents
{
    return [self.componentsArray count];
}


// return an array of all components in this category
- (NSMutableArray *)componentsArray
{
    if (!_componentsArray) {
        _componentsArray = [[NSMutableArray alloc] init];
    }
    return _componentsArray;
}

@end
