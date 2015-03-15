//
//  CategoryViewController.h
//  FaceMaker
//
//  Created by slim on 15-3-6.
//  Copyright (c) 2015年 UC CS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Components.h"


/*************************
 *A delegate for updating the drawing board after the user selected a component under a selection cell
 ************************/

@protocol CategoriesSelectionDelegate <NSObject>
- (void)didSelectComponentsInCategories:(Components *)selectedComponent type:(CType)type selectionIndex:(NSInteger)index;
@end


/*************************
 *This ViewController is written for the collection view in the FMViewController
 ************************/

@interface CategoryViewController : UIViewController
@property (weak, nonatomic) id <CategoriesSelectionDelegate>delegate;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, assign) CType type;

+ (CategoryViewController *)createCategoriesViewControllerWithType:(CType)type;     //init function

@end
