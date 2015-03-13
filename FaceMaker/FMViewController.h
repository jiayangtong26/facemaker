//
//  FMViewController.h
//  FaceMaker
//
//  Created by slim on 15-3-6.
//  Copyright (c) 2015年 UC CS. All rights reserved.
//
/*************************
 *This ViewController is written for the second page of FaceMaker(the "making" page)
 *In this view controller, users can do the creation of their own avartar
 *After finishing editing, users can save it into the photo album of the IOS device and upload it to twitter(just click the buttons in the nagivation bar)
 *users can cancel the selected items by clicking it again
 ************************/
#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface FMViewController : UIViewController
@property UIView *faceview;         //the view that reflects the avartar you are editing
@property UIScrollView *funcview;   //the scroll view that consist of several buttons for choosing types

@end
