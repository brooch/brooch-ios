//
//  BRSignUpViewController.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/13/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRSignupViewController.h"
#import "BRAPIClient.h"
#import "BRUser.h"

@interface BRSignUpViewController ()

@end

@implementation BRSignUpViewController

- (UITextField *)password_confirmationField
{
    return self.passwordConfirmationFIeld;
}

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

- (IBAction)signUp:(id)sender
{
    NSDictionary *params = @{
        @"name":self.nameField.text,
        @"email":self.emailField.text,
        @"password":self.passwordField.text,
        @"password_confirmation":self.passwordConfirmationFIeld.text
    };

    BRAPIClient *client = [[BRAPIClient alloc] init];
    [client signUp:params
            success:^(NSHTTPURLResponse *response, NSDictionary *result) {
                BRUser *user = [BRUser sharedManager];
                [user saveUserData:result];

                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]];
                UIViewController *initialViewController = [storyboard instantiateInitialViewController];
               
                [self presentViewController:initialViewController animated:NO completion:nil];
            } failure:^(NSHTTPURLResponse *response, NSDictionary *result) {
                for (NSString * key in @[@"name", @"email", @"password", @"password_confirmation"]) {
                    SEL sel = NSSelectorFromString([NSString stringWithFormat:@"%@Field", key]);

// 警告"PerformSelector may cause a leak because its selector is unknown"への対処
// http://captainshadow.hatenablog.com/entry/20121114/1352834276
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                    if ([result objectForKey:key] &&
                        [[[self performSelector:sel] text] length] > 0) {
                        [[self performSelector:sel] setTextColor:[UIColor redColor]];
                    }
                    else {
                        [[self performSelector:sel] setTextColor:[UIColor blackColor]];
                    }
#pragma clang diagnostic pop
                   
                }

                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:@"ユーザー登録できません"
                                          message:@"入力内容を見直してください"
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

- (IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
