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
    [NSThread sleepForTimeInterval:3.0];
    UIView * instruction = [[UIView alloc]initWithFrame:CGRectMake(0, 2*self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    [instruction setTag:100];
    UITextView * rules = [[UITextView alloc]initWithFrame:CGRectMake(0, 20, instruction.frame.size.width, instruction.frame.size.height-20)];
    rules.text = @"X always goes first.\n\nPlayers alternate placing Xs and Os on the board until either (a) one player has three in a row, horizontally, vertically or diagonally; or (b) all nine squares are filled.\n\nIf a player is able to draw three Xs or three Os in a row, that player wins.\n\nIf all nine squares are filled and neither player has three in a row, the game is a draw.\n\n";
    
    UIButton *dismiss = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dismiss.frame =CGRectMake(instruction.frame.size.width/2 - 100, instruction.frame.size.height/2, 200, 100);
    [dismiss setTitle:@"dismiss" forState:UIControlStateNormal];
    [dismiss addTarget:self action:@selector(deleteinstruction) forControlEvents:UIControlEventTouchUpInside];
    [instruction addSubview:rules];
    [instruction addSubview:dismiss];
    [self.view addSubview:instruction];
    
    UIButton *instru = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    instru.frame =CGRectMake(self.view.frame.size.width/2 - 100, self.view.frame.size.height/2, 200, 100);
    [instru setTitle:@"instuction" forState:UIControlStateNormal];
    [instru addTarget:self action:@selector(showinstruction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:instru];

    // Do any additional setup after loading the view.
}

-(void) showinstruction{
    UIView * piece = [self.view viewWithTag:100];
    [self showinstructions:piece];
}

- (void)showinstructions : (UIView *)piece{
    [piece setCenter:CGPointMake(self.view.frame.size.width/2, -self.view.frame.size.height)];
    [self.view bringSubviewToFront:piece];
    [UIView animateWithDuration:1
                     animations:^{
                         [piece setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
                     }
     ];
}

- (void)deleteinstruction{
    UIView * tmp = [self.view viewWithTag:100];
    [UIView animateWithDuration:1
                     animations:^{
                         [tmp setCenter:CGPointMake(self.view.frame.size.width/2, 2 * self.view.frame.size.height)];
                     }
     ];
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
