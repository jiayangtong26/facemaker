//
//  PopupUIView.m
//  tic tac snow
//
//  Created by TongJiayang on 2/7/15.
//  Copyright (c) 2015 TongJiayang. All rights reserved.
//

#import "PopupUIView.h"

@interface PopupUIView()

@property UITextView *textfield; // the instruction text
@property NSString *message; // the content of the instruction
@property UIButton *button; // the 'OK' button

@end

@implementation PopupUIView

// init the PopupUIView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0.8;
        self.backgroundColor = [UIColor blackColor];
        //self.userInteractionEnabled = NO;
        
        // init text field
        self.textfield = [[UITextView alloc] initWithFrame:CGRectMake(0, frame.size.height * 0.05, frame.size.width, frame.size.height * 0.75)];
        self.textfield.text = @"You can create your own avartar! Tap make in the bottom to start!\n\nAfter you created your own face, you can save it to your photo album by clicking save button on the top right.\n\nYou can also post it to your twitter by clicking the twitter button on the top left.\n\nIf you choose the components by mistake, don't panic! Click it for the second time, the component you just choose by mistake will disappear! You can also choose other components to replace the one that you are not satisfied.\n\nWant to review your avatar? Tap the history bar to review the avartars you created and saved before!\n\nYou can tap the screen in the history view to hide the navigation bar and tab bar to have better experience viewing your history. Dis-hide them in the same way.";
        self.textfield.backgroundColor = [UIColor clearColor];
        self.textfield.editable = NO;
        self.textfield.textAlignment = NSTextAlignmentCenter;
        self.textfield.textColor = [UIColor whiteColor];
        self.textfield.font = [UIFont fontWithName:@"Noteworthy-Bold" size:17.0];
        [self addSubview:self.textfield];
        
        // init button
        self.button = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width * 0.3, frame.size.height * 0.82, frame.size.width * 0.4, frame.size.height * 0.1)];
        self.button.titleLabel.font = [UIFont fontWithName:@"Noteworthy-Bold" size:21.0];
        [self.button setTitle:@"OK" forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(disappear) forControlEvents:UIControlEventTouchUpInside];
        self.button.backgroundColor = [UIColor clearColor];
        [self addSubview:self.button];
    }
    return self;
}


//hide the instruction view(the action after clicking the dismiss button)
- (void) disappear {
    NSLog(@"click on instruction 'OK' button, dismiss instruction.");
    [UIView animateWithDuration:1.5
                     animations:^{
                         self.center = CGPointMake(self.center.x, -(self.center.y));
                     }];
}

@end
