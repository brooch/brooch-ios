//
//  BRPostViewController.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/22/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRPostViewController.h"
#import "BRPostTextViewController.h"
#import "BRUser.h"

@interface BRPostViewController ()

@end

@implementation BRPostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
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

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    CGPoint scrollPoint = CGPointMake(0.0, 200.0);
    [self.scrollView setContentOffset:scrollPoint animated:YES];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [self.scrollView setContentOffset:CGPointZero animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([@"editText" isEqualToString:segue.identifier]) {
        [[segue destinationViewController] setParentTextField:self.textField];
    }
}

- (IBAction)createPost:(id)sender
{
    BRUser *user = [BRUser sharedManager];
    [user createPost:self.textField.text
              author:self.authorField.text
                tags:@[@"foo"]
             success:^(NSHTTPURLResponse *response, NSDictionary *result) {
                 NSLog(@"%@", result);
             } failure:^(NSHTTPURLResponse *response, NSDictionary *result) {
                 NSLog(@"%@", result);
             } error:^(NSError *error) {
                 NSLog(@"%@", error);
             }];
}

@end