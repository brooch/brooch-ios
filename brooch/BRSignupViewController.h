//
//  BRSignupViewController.h
//  brooch
//
//  Created by 栗林 健太郎 on 7/13/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BRSignupViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *passwordConfirmationFIeld;
@property (strong, nonatomic) IBOutlet UIButton *signupButton;

- (IBAction)closeSoftwareKeybodard:(id)sender;
- (IBAction)moveToMainScreen:(id)sender;

@end
