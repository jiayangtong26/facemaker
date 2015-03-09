//
//  HistoryViewController.m
//  FaceMaker
//
//  Created by slim on 15-3-7.
//  Copyright (c) 2015年 UC CS. All rights reserved.
//

#import "HistoryViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>


@interface HistoryViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated {

    [self.view bringSubviewToFront:self.scrollview];
    
    self.assets = [[NSMutableArray alloc] init];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    void (^assetEnumerator)(ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        	if(result != NULL) {
            		NSLog(@"See Asset: %@", result);
                [self.assets addObject:result];
            	}
            else{
                NSLog(@"%d", self.assets.count);
                
                self.scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height * 1.5, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height * 1.5 - self.tabBarController.tabBar.frame.size.height)];
                [self.scrollview setPagingEnabled:YES];
                [self.scrollview setScrollEnabled:YES];
                [self.scrollview setBounces:YES];
                [self.view addSubview:self.scrollview];
                // Width constraint
                [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollview
                                                                      attribute:NSLayoutAttributeWidth
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:nil
                                                                      attribute:NSLayoutAttributeWidth
                                                                     multiplier:1.0
                                                                       constant:self.view.frame.size.width]];
                
                // Height constraint
                [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollview
                                                                      attribute:NSLayoutAttributeHeight
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:nil
                                                                      attribute:NSLayoutAttributeHeight
                                                                     multiplier:1.0
                                                                       constant:self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height * 1.5 - self.tabBarController.tabBar.frame.size.height]];
                // Center horizontally
                [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollview
                                                                      attribute:NSLayoutAttributeCenterX
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.view
                                                                      attribute:NSLayoutAttributeCenterX
                                                                     multiplier:1.0
                                                                       constant:0.0]];
                
                // Center vertically
                [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollview
                                                                      attribute:NSLayoutAttributeCenterY
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.view
                                                                      attribute:NSLayoutAttributeCenterY
                                                                     multiplier:1.0
                                                                       constant:0.0]];
                self.scrollview.contentSize = CGSizeMake(self.assets.count *self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height * 1.5 - self.tabBarController.tabBar.frame.size.height);
                self.automaticallyAdjustsScrollViewInsets = NO;
                NSLog(@"width: %f", self.view.frame.size.width);
                NSLog(@"width: %f", self.view.frame.size.height);
                NSLog(@"width - : %f", self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height);
                NSLog(@"top y: %f", self.navigationController.navigationBar.frame.size.height);
                for(int i = 0; i < self.assets.count; i++){
                    ALAsset *asset = [self.assets objectAtIndex:i];
                    UIImage* image = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
                    UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height - self.navigationController.navigationBar.frame.size.height)];
                    [imageview setImage:image];
                    [self.scrollview addSubview:imageview];
                    [self.scrollview bringSubviewToFront:imageview];
                }
            }
            };
    
    void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) =  ^(ALAssetsGroup *group, BOOL *stop) {
        if(group != nil) {
            NSString *name =[group valueForProperty:ALAssetsGroupPropertyName];
            if ([name isEqualToString:@"FaceMaker"]){
                [group enumerateAssetsUsingBlock:assetEnumerator];
            }
        }
        
    };
    
    [library enumerateGroupsWithTypes:ALAssetsGroupAlbum
                            usingBlock:assetGroupEnumerator
           					 failureBlock: ^(NSError *error) {
               						 NSLog(@"Failure");
               					 }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
