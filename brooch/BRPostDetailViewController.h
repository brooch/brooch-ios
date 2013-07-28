//
//  BRPostDetailViewController.h
//  brooch
//
//  Created by 栗林 健太郎 on 7/27/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BRPostDetailViewController : UIViewController

@property (nonatomic, strong) NSDictionary *post;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UILabel *authorView;

- (void)updateViewWith:(NSDictionary *)post;

@end
