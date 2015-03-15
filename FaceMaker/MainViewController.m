//
//  MainViewController.m
//  FaceMaker
//
//  Created by slim on 15-3-10.
//  Copyright (c) 2015年 UC CS. All rights reserved.
//

#import "MainViewController.h"
#import "PopupUIView.h"

@interface MainViewController ()

@property UILabel *t;
@property UIImageView *bg;
@property UIButton *instru;
@property PopupUIView *popup;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //the launch splash screen will stay for 3 seconds
    [NSThread sleepForTimeInterval:3.0];
    
    //set the label on the main page
    self.t = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height * 0.03, self.view.frame.size.width, self.view.frame.size.height * 0.1)];
    self.t.text = @"Face Maker";
    self.t.backgroundColor = [UIColor clearColor];
    self.t.textAlignment = NSTextAlignmentCenter;
    self.t.textColor = [UIColor blackColor];
    self.t.font = [UIFont fontWithName:@"Noteworthy-Bold" size:48.0];
    [self.view addSubview:self.t];
    
    //set the image on the main page
    self.bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.png"]];
    [self.bg setFrame:CGRectMake(0, self.view.frame.size.height * 0.15, self.view.frame.size.width, self.view.frame.size.height * 0.67)];
    [self.view addSubview:self.bg];
    
    //set the instruction button on the main page
    self.instru = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.instru.frame =CGRectMake(self.view.frame.size.width * 0.3, self.view.frame.size.height * 0.83, self.view.frame.size.width * 0.4, self.view.frame.size.height * 0.05);
    [self.instru setTitle:@"instuction" forState:UIControlStateNormal];
    self.instru.titleLabel.font = [UIFont fontWithName:@"Noteworthy-Bold" size:23.0];
    self.instru.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.instru setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.instru addTarget:self action:@selector(displayInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.instru];
    
    //the code below defines the elements in the main page including:
    //an instruction view(UIView which includes the instructions(UITextView) and the dismiss button)
    //an instruction button
    //and the view of the controller which let the FaceMaker image to be the background
    self.popup = [[PopupUIView alloc] initWithFrame:CGRectMake(0, -(self.view.frame.size.height), self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.popup];
    [self.view bringSubviewToFront:self.popup];


}

//the action after clicking the instruction button(shows the instruction view), change the position of instruction view
- (void) displayInfo {
    NSLog(@"click on instruction button, show instruction.");
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.popup.center = CGPointMake(self.popup.center.x, -(self.popup.center.y));
                     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
