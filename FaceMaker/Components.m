//
//  Components.m
//  FaceMaker
//
//  Created by slim on 15-3-6.
//  Copyright (c) 2015年 UC CS. All rights reserved.
//

#import "Components.h"

@interface Components ()
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, strong, readwrite) CALayer *componentLayer;
@property (nonatomic, strong, readwrite) CALayer *thumbnailLayer;
@end

@implementation Components

+ (Components *)createComponentsWithName:(NSString *)name
{
    Components *component = [[Components alloc] init];
    component.imageName = name;
    
    return component;
}

- (CALayer *)componentLayer
{
    if (!_componentLayer) {
        _componentLayer = [CALayer layer];
        _componentLayer.contents = (id)[UIImage imageNamed:[self.imageName stringByAppendingString:@"L"]].CGImage;
    }
    return _componentLayer;
}

- (CALayer *)thumbnailLayer
{
    if (!_thumbnailLayer) {
        _thumbnailLayer = [CALayer layer];
        _thumbnailLayer.contents = (id)[UIImage imageNamed:self.imageName].CGImage;
    }
    return _thumbnailLayer;
}

@end
