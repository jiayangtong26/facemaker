//
//  CategoryViewController.m
//  FaceMaker
//
//  Created by slim on 15-3-6.
//  Copyright (c) 2015年 UC CS. All rights reserved.
//

#import "CategoryViewController.h"
#import "Categories.h"


@interface CategoryViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property UICollectionViewCell * cselectedcell;
@property (nonatomic, assign) CType type;
@property (nonatomic, strong) Categories *categories;

@end

@implementation CategoryViewController

+ (CategoryViewController *)createCategoriesViewControllerWithType:(CType)type
{
    CategoryViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CategoryViewCotroller"];
    vc.type = type;
    return vc;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   // [self.collectionView registerNib:[UINib nibWithNibName:@"FMCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FMCollectionViewCell"];
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
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FMCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UICollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.height)];
    }
    cell.layer.borderWidth = 2;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    Components *components = [self.categories componentsAtIndex:indexPath.row];
    CALayer * layer = [[CALayer alloc]init];
    layer =[components thumbnailLayer];
    layer.frame = cell.layer.bounds;
    [cell.layer addSublayer:layer];
    
    return cell;
}




- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Components *component = [self.categories componentsAtIndex:indexPath.row];
    [self.delegate didSelectComponentsInCategories:component type:self.categories.type selectionIndex:indexPath.row];
    if(self.cselectedcell){
        [self.cselectedcell.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    }
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell.layer setBorderColor:[UIColor redColor].CGColor];
    self.cselectedcell = cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height, self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height);
}
/*
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 15, 10, 0);
}
*/
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

@end

