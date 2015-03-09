//
//  CategoryViewController.h
//  FaceMaker
//
//  Created by slim on 15-3-6.
//  Copyright (c) 2015年 UC CS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Components.h"
@protocol CategoriesSelectionDelegate <NSObject>
- (void)didSelectComponentsInCategories:(Components *)selectedComponent type:(CType)type selectionIndex:(NSInteger)index;
@end

@interface CategoryViewController : UIViewController
@property (weak, nonatomic) id <CategoriesSelectionDelegate>delegate;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

+ (CategoryViewController *)createCategoriesViewControllerWithType:(CType)type;

@end
