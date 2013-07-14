//
//  BRSignupViewController.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/13/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRSignupViewController.h"
#import "BRAPIClient.h"
#import "BRUser.h"

@interface BRSignupViewController ()

@end

@implementation BRSignupViewController

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

- (IBAction)register:(id)sender
{
    NSDictionary *params = @{
        @"name":self.nameField.text,
        @"email":self.emailField.text,
        @"password":self.passwordField.text,
        @"password_confirmation":self.passwordConfirmationFIeld.text
    };

    BRAPIClient *client = [[BRAPIClient alloc] init];
    [client request:@"POST"
              path:@"/v1/users"
             params:params
            success:^(NSHTTPURLResponse *response, NSDictionary *result) {
                BRUser *user = [BRUser sharedManager];
                [user saveUserData:result];

                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]];
                UIViewController *initialViewController = [storyboard instantiateInitialViewController];
               
                [self presentViewController:initialViewController animated:NO completion:nil];
            } failure:^(NSHTTPURLResponse *response, NSDictionary *result) {
                NSLog(@"%d", [response statusCode]);
                NSLog(@"%@", result);
            } error:^(NSError *error) {
                NSLog(@"%@", error);
            }];
}

@end
