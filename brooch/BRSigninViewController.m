//
//  BRSigninViewController.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/13/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRSigninViewController.h"
#import "BRAPIClient.h"
#import "BRUser.h"

@interface BRSigninViewController ()

@end

@implementation BRSigninViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeSoftwareKeybodard:(id)sender
{
    [self.view endEditing: YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.textColor = [UIColor blackColor];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    NSInteger nextTag = textField.tag + 1;
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return NO;
}

- (IBAction)signIn:(id)sender
{
    NSDictionary *params = @{
        @"email":self.emailField.text,
        @"password":self.passwordField.text
    };
    
    BRAPIClient *client = [[BRAPIClient alloc] init];
    [client signIn:params
           success:^(NSHTTPURLResponse *response, NSDictionary *result) {
               BRUser *user = [BRUser sharedManager];
               [user saveUserData:result];
               
               UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]];
               UIViewController *initialViewController = [storyboard instantiateInitialViewController];
               
               [self presentViewController:initialViewController animated:NO completion:nil];
           } failure:^(NSHTTPURLResponse *response, NSDictionary *result) {
               NSString *errorMessage = [[result objectForKey:@"sign_in_error"] objectAtIndex:0];
               
               UIAlertView *alertView = [[UIAlertView alloc]
                                         initWithTitle:@"ログインできません"
                                         message:errorMessage
                                         delegate:nil
                                         cancelButtonTitle:nil
                                         otherButtonTitles:@"もう一度", nil];
               [alertView show];
           } error:^(NSError *error) {
               UIAlertView *alertView = [[UIAlertView alloc]
                                         initWithTitle:@"エラー"
                                         message:@"通信中に問題が発生しました"
                                         delegate:nil
                                         cancelButtonTitle:nil
                                         otherButtonTitles:@"もう一度", nil];
               [alertView show];
           }];
}

@end
