//
//  FMViewController.m
//  FaceMaker
//
//  Created by slim on 15-3-6.
//  Copyright (c) 2015年 UC CS. All rights reserved.
//

#import "FMViewController.h"
#import "CategoryViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface FMViewController ()<CategoriesSelectionDelegate>
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSMutableArray *images;   //saves each collection view controlled by buttons
@property (nonatomic, assign) CType currentCategories;  //indicates the current type you just chosed
@property (nonatomic, strong) CALayer *indicator;       //indicates which button you just clicked

- (void)configureCategoriesView;        //configure the category view(collection view)
- (void)configureButtons;               //configure the button view(scroll view)
- (void)configureNavigationbar;         //configure the navigation bar button(twitter and save)

@end

@implementation FMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.faceview = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height * 1.3, self.view.frame.size.width, self.view.frame.size.height*3/5)];
    self.funcview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height * 1.3 + self.view.frame.size.height*3/5, self.view.frame.size.width, self.view.frame.size.height/15)];
    [self.view addSubview:self.faceview];
    [self.view addSubview:self.funcview];
    [self.view bringSubviewToFront:self.faceview];
    [self.view bringSubviewToFront:self.funcview];
    [self configureCategoriesView];
    [self configureButtons];
    [self configureNavigationbar];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
//load collection view data(15 types of collection view)
- (void)configureCategoriesView
{
    self.images = [[NSMutableArray alloc]init];
    for (CType type = CTypeBackground; type <= CTypeDecoration; type++) {
        @autoreleasepool {
            CategoryViewController *vc = [CategoryViewController createCategoriesViewControllerWithType:type];
            [vc.view setFrame:CGRectMake(0,
                                         self.view.frame.size.height*2/3 + self.navigationController.navigationBar.frame.size.height * 1.3,
                                         self.view.frame.size.width,
                                         self.view.frame.size.height/5)];
            vc.delegate = self;
            [self.images addObject:vc.view];
            [self addChildViewController:vc];
            
        }
    }
    
    [self.images addObject:[[UIView alloc]initWithFrame:CGRectMake(0,
                                                                   self.view.frame.size.height*2/3 + self.navigationController.navigationBar.frame.size.height * 1.3,
                                                                   self.view.frame.size.width,
                                                                   self.view.frame.size.height/5)] ];
    [self.view addSubview:[self.images objectAtIndex:15]];
    
    self.currentCategories = 15;
}
//load the buttons in navigation bar
- (void)configureNavigationbar
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"save" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"twitter" style:UIBarButtonItemStylePlain target:self action:@selector(twitter)];
}
//save the avartar to the photo album in the IOS device(called by save)
- (void)saveToAlbumWithMetadata:(NSDictionary *)metadata
                      imageData:(NSData *)imageData
                customAlbumName:(NSString *)customAlbumName
                completionBlock:(void (^)(void))completionBlock
                   failureBlock:(void (^)(NSError *error))failureBlock
{
    
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    void (^AddAsset)(ALAssetsLibrary *, NSURL *) = ^(ALAssetsLibrary *assetsLibrary, NSURL *assetURL) {
        [assetsLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
            [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                
                if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:customAlbumName]) {
                    [group addAsset:asset];
                    if (completionBlock) {
                        completionBlock();
                    }
                }
            } failureBlock:^(NSError *error) {
                if (failureBlock) {
                    failureBlock(error);
                }
            }];
        } failureBlock:^(NSError *error) {
            if (failureBlock) {
                failureBlock(error);
            }
        }];
    };
    ALAssetsLibrary *tmp = assetsLibrary;
    [assetsLibrary writeImageDataToSavedPhotosAlbum:imageData metadata:metadata completionBlock:^(NSURL *assetURL, NSError *error) {
        if (customAlbumName) {
            [assetsLibrary addAssetsGroupAlbumWithName:customAlbumName resultBlock:^(ALAssetsGroup *group) {
                if (group) {
                    [tmp assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                        [group addAsset:asset];
                        if (completionBlock) {
                            completionBlock();
                        }
                    } failureBlock:^(NSError *error) {
                        if (failureBlock) {
                            failureBlock(error);
                        }
                    }];
                } else {
                    AddAsset(tmp, assetURL);
                }
            } failureBlock:^(NSError *error) {
                AddAsset(tmp, assetURL);
            }];
        } else {
            if (completionBlock) {
                completionBlock();
            }
        }
    }];
}
//post the avartar you just make to your twitter
- (void)twitter{
    for(int type = 0; type < 15; type++){
        CALayer *layer = [self.faceview.layer valueForKey:[self stringFromType:type]];
        if (layer) {
            [layer removeFromSuperlayer];
            [self.faceview.layer setValue:layer forKey:[self stringFromType:type]];
            [self.faceview.layer addSublayer:layer];
            self.currentCategories = type;
        }
    }
    NSLog(@"Twitter Request!");
    UIGraphicsBeginImageContext(self.faceview.bounds.size);
    [self.faceview.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    SLComposeViewController *tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [tweet setInitialText:[[NSString alloc] initWithFormat:@"I make my own face!\n"]];
    [self presentViewController:tweet animated:YES completion:nil];
    
    [tweet addImage:image];
}
//save the avartar to the photo album after clicking the save button
- (void)save
{
    for(int type = 0; type < 15; type++){
        CALayer *layer = [self.faceview.layer valueForKey:[self stringFromType:type]];
        if (layer) {
            [layer removeFromSuperlayer];
            [self.faceview.layer setValue:layer forKey:[self stringFromType:type]];
            [self.faceview.layer addSublayer:layer];
            self.currentCategories = type;
        }
    }
    NSLog(@"Saving the photo!");
    UIGraphicsBeginImageContext(self.faceview.bounds.size);
    [self.faceview.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    NSMutableArray *groups=[[NSMutableArray alloc]init];
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop)
    {
        if (group)
        {
            [groups addObject:group];
        }
        
        else
        {
            BOOL haveHDRGroup = NO;
            
            for (ALAssetsGroup *gp in groups)
            {
                NSString *name =[gp valueForProperty:ALAssetsGroupPropertyName];
                
                if ([name isEqualToString:@"FaceMaker"])
                {
                    haveHDRGroup = YES;
                }
            }
            
            if (!haveHDRGroup)
            {
                [assetsLibrary addAssetsGroupAlbumWithName:@"FaceMaker"
                                               resultBlock:^(ALAssetsGroup *group)
                 {
                     [groups addObject:group];
                     NSLog(@"Creating the FaceMaker Album");
                     
                 }
                                              failureBlock:nil];
                haveHDRGroup = YES;
            }
        }
        
    };
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:listGroupBlock failureBlock:nil];
    [self saveToAlbumWithMetadata:nil imageData:UIImagePNGRepresentation(image) customAlbumName:@"FaceMaker" completionBlock:^
     {
         NSLog(@"successfully saving the photo!");
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"save" message:@"Save Successfully" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
         
         [alert show];
         
     }
                     failureBlock:^(NSError *error)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             
             if([error.localizedDescription rangeOfString:@"User denied access"].location != NSNotFound){
                 
                 UIAlertView *alert=[[UIAlertView alloc]initWithTitle:error.localizedDescription message:error.localizedFailureReason delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles: nil];
                 
                 [alert show];
                 
             }
         });
     }];
}

//turn the Integer enum type CType to the NSString it matches

- (NSString *)stringFromType:(CType)type
{
    if (type == CTypeBackground) return @"BGD";
    if (type == CTypeFace) return @"Face";
    if (type == CTypeBody) return @"Body";
    if (type == CTypeBrow) return @"Brow";
    if (type == CTypeEye)  return @"Eye";
    if (type == CTypeNose) return @"Nose";
    if (type == CTypeMouth)return @"Mouth";
    if (type == CTypeEar)  return @"Ear";
    if (type == CTypeHair) return @"Hair";
    if (type == CTypeBeard)return @"Beard";
    if (type == CTypeInjured) return @"Injured";
    if (type == CTypeGlass)return @"Glass";
    if (type == CTypeNecklace)return @"Necklace";
    if (type == CTypeCloth)return @"Cloth";
    if (type == CTypeDecoration) return @"Decoration";
    
    return nil;
}


//configure the scroll view which consist of buttons and one indicator
//These buttons helps to choose type(like face or nose or hair etc.)
- (void)configureButtons
{
    self.buttons = [[NSMutableArray alloc] init];
    self.indicator = [CALayer layer];
    self.indicator.backgroundColor = [UIColor blueColor].CGColor;
    
    for (CType type = CTypeBackground; type <= CTypeDecoration; type++) {
        @autoreleasepool {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:[self stringFromType:type] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor clearColor]];
            button.tag = type;
            
            [button setFrame:CGRectMake(type * 100, 0, 100, CGRectGetHeight(self.funcview.frame))];
            [button.titleLabel setTextAlignment: NSTextAlignmentCenter];
            [self.funcview addSubview:button];
            [self.buttons addObject:button];
        }
    }
    self.indicator.frame = CGRectMake(-100, CGRectGetHeight(self.funcview.frame) - 5, 100, 5);
    [self.funcview.layer addSublayer:self.indicator];
    [self.funcview setContentSize:CGSizeMake(100 * ([self.buttons count] + 1), CGRectGetHeight(self.funcview.frame))];
    [self.view bringSubviewToFront:self.funcview];
    [self.view bringSubviewToFront:self.faceview];
}

//If click the button on the scrollview, the category view(collection view) should change to the type that the button refers
- (void)didClickButton:(UIButton *)sender
{
    if (sender.tag == self.currentCategories) return;
    NSLog(@"Changing the type!");
    [[self.images objectAtIndex:self.currentCategories]removeFromSuperview];
    [self.view addSubview:[self.images objectAtIndex:sender.tag]];
    self.currentCategories = (CType)sender.tag;
    self.indicator.frame = CGRectMake(sender.tag * 100 ,
                                      CGRectGetMinY(self.indicator.frame),
                                      CGRectGetWidth(self.indicator.frame),
                                      CGRectGetHeight(self.indicator.frame));
}
//If select the item in collection view, it should change the faceview(reflecting the editing avartar)
- (void)didSelectComponentsInCategories:(Components *)selectedComponent type:(CType)type selectionIndex:(NSInteger)index
{
    NSLog(@"Changing your selection!");
    CALayer *layer = [selectedComponent componentLayer];
    layer.zPosition = type;
    layer.contentsScale = self.faceview.bounds.size.width / 500.0f;
    layer.frame = self.faceview.layer.bounds;
    
    CALayer *layer2 = [self.faceview.layer valueForKey:[self stringFromType:type]];
    if (layer2) {
        [layer2 removeFromSuperlayer];
    }
    if(layer2 != layer){
    [self.faceview.layer setValue:layer forKey:[self stringFromType:type]];
    [self.faceview.layer addSublayer:layer];
    self.currentCategories = type;
    }
    else{
        [self.faceview.layer setValue:nil forKey:[self stringFromType:type]];
    }
}


@end
