//
//  BRSignUpViewController.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/13/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRSignupViewController.h"
#import "BRAPIClient.h"
#import "BRUserModel.h"

@interface BRSignUpViewController ()

@end

@implementation BRSignUpViewController


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

    UIImage *image = [UIImage imageNamed:@"sign_up_bg"];
    self.imageView.image = image;

    [self registerForKeyboardNotifications];
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
        [self signUp:self.signUpButton];
    }

    return NO;
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification*)aNotification
{
    CGRect keyboardRect = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [[self.view superview] convertRect:keyboardRect fromView:nil];
    
    CGPoint scrollPoint = CGPointMake(0.0, keyboardRect.size.height / 2);
    [self.scrollView setContentOffset:scrollPoint animated:YES];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [self.scrollView setContentOffset:CGPointZero animated:YES];
}

- (IBAction)signUp:(id)sender
{
    NSDictionary *params = @{
        @"name":     self.nameField.text,
        @"email":    self.emailField.text,
        @"password": self.passwordField.text
    };

    BRAPIClient *client = [[BRAPIClient alloc] init];
    [client signUp:params
            success:^(NSHTTPURLResponse *response, NSDictionary *result) {
                BRUserModel *user = [BRUserModel sharedManager];
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
            } error:nil];
}

- (IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
