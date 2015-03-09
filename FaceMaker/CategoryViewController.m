//
//  CategoryViewController.m
//  FaceMaker
//
//  Created by slim on 15-3-6.
//  Copyright (c) 2015年 UC CS. All rights reserved.
//

#import "CategoryViewController.h"
#import "Categories.h"
#import "FMCollectionViewCell.h"

#define CategoryVCIdentifier @"CategoryViewCotroller"

@interface CategoryViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, assign) CType type;
@property (nonatomic, strong) Categories *categories;

@end

@implementation CategoryViewController

+ (CategoryViewController *)createCategoriesViewControllerWithType:(CType)type
{
    CategoryViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:CategoryVCIdentifier];
    vc.type = type;
    return vc;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"FMCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FMCollectionViewCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (Categories *)categories
{
    if (!_categories) {
        _categories = [Categories createComponentCategoriesByType:self.type];
    }
    return _categories;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.categories countOfComponents];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    FMCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FMCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[FMCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, FMCollectionViewCellSize, FMCollectionViewCellSize)];
    }
    
    Components *components = [self.categories componentsAtIndex:indexPath.row];
    [cell addImageLayer:[components thumbnailLayer]];
    
    return cell;
}

static bool hasDelegateAndItsMethod = false;
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!hasDelegateAndItsMethod) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectComponentsInCategories:type:selectionIndex:)]) {
            hasDelegateAndItsMethod = true;
        }
    }
    
    if (hasDelegateAndItsMethod) {
        Components *component = [self.categories componentsAtIndex:indexPath.row];
        [self.delegate didSelectComponentsInCategories:component type:self.categories.type selectionIndex:indexPath.row];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(FMCollectionViewCellSize, FMCollectionViewCellSize);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 15, 10, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15.0f;
}

@end

