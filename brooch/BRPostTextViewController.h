//
//  BRPostTextViewController.h
//  brooch
//
//  Created by 栗林 健太郎 on 7/22/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BRPostTextViewController : UIViewController

@property (strong, nonatomic) UITextView *parentTextField;
@property (strong, nonatomic) IBOutlet UITextView *textField;

@end
