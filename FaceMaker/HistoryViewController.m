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
    self.status = 0;
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    self.scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height * 3, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height * 3 - self.tabBarController.tabBar.frame.size.height * 2)];
    [self.scrollview setPagingEnabled:YES];
    [self.scrollview setScrollEnabled:YES];
    [self.scrollview setBounces:YES];
    [self.view addSubview:self.scrollview];
    UITapGestureRecognizer *tscroll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handlescroll:)];
    [tscroll setNumberOfTouchesRequired:1];
    [tscroll setDelegate:self];
    [self.scrollview addGestureRecognizer:tscroll];
    self.automaticallyAdjustsScrollViewInsets = NO;

}
//function about gesture to hide and dishide the navigation bar and tab bar
- (void) handlescroll: (UITapGestureRecognizer *)sender{
    if(self.status == 0){
        self.status = 1;
        [self.tabBarController.tabBar setHidden:YES];
        [self.navigationController.navigationBar setHidden:YES];
        NSLog(@"Hiding the tab bar and navigation bar!");
    }
    else{
        self.status = 0;
        [self.tabBarController.tabBar setHidden:NO];
        [self.navigationController.navigationBar setHidden:NO];
        NSLog(@"Tab bar and navigation bar appear!");
    }

}
//read photos from the album
- (void)viewWillAppear:(BOOL)animated {

    [self.view bringSubviewToFront:self.scrollview];
    
    self.assets = [[NSMutableArray alloc] init];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    NSLog(@"Reading photos from the FaceMaker Album!");
    void (^assetEnumerator)(ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        	if(result != NULL) {
            		NSLog(@"See Asset: %@", result);
                [self.assets addObject:result];
            	}
            else{
                self.scrollview.contentSize = CGSizeMake(self.assets.count *self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height * 3 - self.tabBarController.tabBar.frame.size.height * 2);
                for(int i = 0; i < self.assets.count; i++){
                    ALAsset *asset = [self.assets objectAtIndex:i];
                    UIImage* image = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
                    UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height * 3 - self.navigationController.navigationBar.frame.size.height * 2)];
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

@end
