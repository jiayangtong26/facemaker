//
//  MainViewController.m
//  FaceMaker
//
//  Created by slim on 15-3-10.
//  Copyright (c) 2015年 UC CS. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSThread sleepForTimeInterval:3.0];        //the launch image will stay for 3 seconds
    UIImageView * bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.png"]];
    [bg setFrame:CGRectMake(0, self.view.frame.size.height/2 - self.view.frame.size.width/2, self.view.frame.size.width, self.view.frame.size.width)];
    [self.view addSubview:bg];
//the code below defines the elements in the main page including:
    //an instruction view(UIView which includes the instructions(UITextView) and the dismiss button)
    //an instruction button
    //and the view of the controller which let the FaceMaker image to be the background
    UIView * instruction = [[UIView alloc]initWithFrame:CGRectMake(0, 2*self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    [instruction setTag:100];
    UILabel * welcome = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 40)];
    welcome.text = @"Welcome to FaceMaker!";
    [welcome setTextAlignment:NSTextAlignmentCenter];
    UITextView * rules = [[UITextView alloc]initWithFrame:CGRectMake(0, 60, instruction.frame.size.width, instruction.frame.size.height-20)];
    [welcome setBackgroundColor:[UIColor whiteColor]];
    [rules setTextColor:[UIColor purpleColor]];
    [welcome setTextColor:[UIColor redColor]];
    rules.text = @"You can create your own avartar! Tap make in the bottom to start!\n\nAfter you created your own face, you can save it to your photo album by clicking save button on the top right.\n\nYou can also post it to your twitter by clicking the twitter button on the top left.\n\nIf you choose the components by mistake, don't panic! Click it for the second time, the component you just choose by mistake will disappear! You can also choose other components to replace the one that you are not satisfied.\n\nWant to review your avatar? Tap the history bar to review the avartars you created and saved before!\n\nYou can tap the screen in the history view to hide the navigation bar and tab bar to have better experience viewing your history. Dis-hide them in the same way.";
    
    UIButton *dismiss = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dismiss.frame =CGRectMake(instruction.frame.size.width/2 - 100, self.view.frame.size.height - 100 - self.tabBarController.tabBar.frame.size.height, 200, 100);
    [dismiss setTitle:@"dismiss" forState:UIControlStateNormal];
    [dismiss addTarget:self action:@selector(deleteinstruction) forControlEvents:UIControlEventTouchUpInside];
    [instruction addSubview:rules];
    [instruction addSubview:welcome];
    [instruction addSubview:dismiss];
    [self.view addSubview:instruction];
    
    UIButton *instru = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    instru.frame =CGRectMake(self.view.frame.size.width/2 - 100, 0, 200, 100);
    [instru setTitle:@"instuction" forState:UIControlStateNormal];
    [instru addTarget:self action:@selector(showinstruction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:instru];

}
//the action after clicking the instruction button(shows the instruction view)
-(void) showinstruction{
    UIView * piece = [self.view viewWithTag:100];
    NSLog(@"Showing the instructions of FaceMaker!");
    [self showinstructions:piece];
}
//change the position of instruction view, this function is called in the above function
- (void)showinstructions : (UIView *)piece{
    [piece setCenter:CGPointMake(self.view.frame.size.width/2, -self.view.frame.size.height)];
    [self.view bringSubviewToFront:piece];
    [UIView animateWithDuration:1
                     animations:^{
                         [piece setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
                     }
     ];
}
//hide the instruction view(the action after clicking the dismiss button)
- (void)deleteinstruction{
    UIView * tmp = [self.view viewWithTag:100];
    NSLog(@"Dismissing the instructions of FaceMaker!");
    [UIView animateWithDuration:1
                     animations:^{
                         [tmp setCenter:CGPointMake(self.view.frame.size.width/2, 2 * self.view.frame.size.height)];
                     }
     ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
