//
//  BRSignInViewController.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/13/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRSigninViewController.h"
#import "BRUserModel.h"

@interface BRSignInViewController ()

@end

@implementation BRSignInViewController

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

    UIImage *image = [UIImage imageNamed:@"sign_in_bg"];
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
        [self signIn:self.signInButton];
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

- (IBAction)signIn:(id)sender
{
    NSDictionary *params = @{
        @"email":self.emailField.text,
        @"password":self.passwordField.text
    };
    
    BRUserModel *user = [BRUserModel sharedManager];
    [user signIn:params
           success:^(NSHTTPURLResponse *response, NSDictionary *result) {
               BRUserModel *user = [BRUserModel sharedManager];
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
           } error:nil];
}

- (IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
