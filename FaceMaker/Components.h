//
//  Components.h
//  FaceMaker
//
//  Created by slim on 15-3-6.
//  Copyright (c) 2015年 UC CS. All rights reserved.
//
/*************************
*Declare the components of a face.
*componentLayer contains the original images of components while thumbnailLayer contains the thumbnail images. 
 ************************/
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

typedef enum {
    CTypeBackground = 0,
    CTypeBody = 1,
    CTypeFace = 2,
    CTypeBrow = 3,
    CTypeEye  = 4,
    CTypeNose = 5,
    CTypeMouth = 6,
    CTypeEar = 7,
    CTypeHair  = 8,
    CTypeBeard = 9,
    CTypeInjured = 10,
    CTypeGlass = 11,
    CTypeNecklace = 12,
    CTypeCloth = 13,
    CTypeDecoration = 14,
} CType;


@interface Components : NSObject
@property (nonatomic, strong, readonly)CALayer *componentLayer;
@property (nonatomic, strong, readonly)CALayer *thumbnailLayer;

+ (Components *)createComponentsWithName:(NSString *)name;

@end
