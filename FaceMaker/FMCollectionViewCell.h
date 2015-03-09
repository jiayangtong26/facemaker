//
//  FMCollectionViewCell.h
//  FaceMaker
//
//  Created by slim on 15-3-6.
//  Copyright (c) 2015年 UC CS. All rights reserved.
//

#import <UIKit/UIKit.h>
#define FMCollectionViewCellSize 120
@interface FMCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *containerView;
- (void)addImageLayer:(CALayer *)layer;
@end
