//
//  HistoryViewController.h
//  FaceMaker
//
//  Created by slim on 15-3-7.
//  Copyright (c) 2015年 UC CS. All rights reserved.
//
/*************************
 *This ViewController is written for the third page of FaceMaker(view the history of the created avartars)
 *You can tap the scrollview to hide the navigation bar and tab bar(accomplished by gesture)
 *You can scroll the scroll view to view the history
 ************************/
#import <UIKit/UIKit.h>

@interface HistoryViewController : UIViewController<UIGestureRecognizerDelegate>

@property NSMutableArray *assets;
@property int status;


@end
