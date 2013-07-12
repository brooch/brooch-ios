//
//  BRTutorialViewController.h
//  brooch
//
//  Created by 栗林 健太郎 on 7/12/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BRTutorialViewController : UIViewController  <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControll;
@property (strong, nonatomic) NSArray *tutorialImages;

@end
