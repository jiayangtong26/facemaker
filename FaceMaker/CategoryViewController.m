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
@property (nonatomic, strong) Categories *categories;

@end

@implementation CategoryViewController

//init function with parameter CType
+ (CategoryViewController *)createCategoriesViewControllerWithType:(CType)type
{
    CategoryViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CategoryViewCotroller"];
    vc.type = type;
    return vc;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//init the categories
- (Categories *)categories
{
    if (!_categories) {
        _categories = [Categories createComponentCategoriesByType:self.type];
    }
    return _categories;
}


// CollectionView SDK method, return number of items in a collection section
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.categories countOfComponents];
}


// CollectionView SDK method, return number of sections in a collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


// CollectionView SDK method, return the collection view cell at the specific index
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FMCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UICollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.height)];
        //cell = [[UICollectionViewCell alloc]init];
    }
    cell.layer.borderWidth = 2;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    Components *components = [self.categories componentsAtIndex:indexPath.row];
    CALayer * layer = [[CALayer alloc]init];
    layer = [components thumbnailLayer];
    layer.frame = cell.layer.bounds;
    [cell.layer addSublayer:layer];
    [self.view bringSubviewToFront:cell];
    return cell;
}


// CollectionView SDK method, after user clicks on a certain selection cell, let its delegate (FMViewController) insert corresponding layer component picture into the drawing board. Also change the boarder color of the cell.
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


// CollectionView SDK method
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height, self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height);
}


// CollectionView SDK method
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 15, 10, 0);
}


// CollectionView SDK method
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

@end

