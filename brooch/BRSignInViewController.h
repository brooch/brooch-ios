//
//  BRSignInViewController.h
//  brooch
//
//  Created by 栗林 健太郎 on 7/13/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BRSignInViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UIButton *signInButton;

@end
