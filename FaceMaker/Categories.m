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

+ (Categories *)createComponentCategoriesByType:(CType)type
{
    Categories *categories = [[Categories alloc] initWithType:type];
    return categories;
}

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

- (Components *)componentsAtIndex:(NSInteger)index
{
    if (index < 0 || index >= [self.componentsArray count]) return nil;
    return [self.componentsArray objectAtIndex:index];
}

- (NSInteger)countOfComponents
{
    return [self.componentsArray count];
}

- (NSMutableArray *)componentsArray
{
    if (!_componentsArray) {
        _componentsArray = [[NSMutableArray alloc] init];
    }
    return _componentsArray;
}

@end
