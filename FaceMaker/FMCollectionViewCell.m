//
//  FMCollectionViewCell.m
//  FaceMaker
//
//  Created by slim on 15-3-6.
//  Copyright (c) 2015年 UC CS. All rights reserved.
//

#import "FMCollectionViewCell.h"
@interface FMCollectionViewCell()
@property (nonatomic, strong) CALayer *currentLayer;
@end
@implementation FMCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.borderWidth = 2.0f;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)addImageLayer:(CALayer *)layer
{
    if (layer == nil) return;
    
    if (self.currentLayer) {
        [self.currentLayer removeFromSuperlayer];
        self.currentLayer = nil;
    }
    
    layer.frame = self.containerView.layer.bounds;
    [self.containerView.layer addSublayer:layer];
    self.currentLayer = layer;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected) {
        self.layer.borderColor = [UIColor redColor].CGColor;
    } else {
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
}

@end
