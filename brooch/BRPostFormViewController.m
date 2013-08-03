//
//  BRPostViewController.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/22/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRPostFormViewController.h"
#import "BRTopViewController.h"
#import "BRPostFormTextViewController.h"
#import "BRPostFormImageViewController.h"
#import "BRUserModel.h"
#import "BRPostModel.h"

@interface BRPostFormViewController ()

@end

@implementation BRPostFormViewController

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
    self.textField.text   = self.post.text;
    self.authorField.text = self.post.author[@"name"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeSoftwareKeybodard:(id)sender
{
    self.post.author[@"name"] = self.authorField.text;
    [self.view endEditing: YES];
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

    // 「だれ?」の下にあわさるように
    CGPoint scrollPoint = CGPointMake(0.0, keyboardRect.size.height - 46);
    [self.scrollView setContentOffset:scrollPoint animated:YES];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [self.scrollView setContentOffset:CGPointZero animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([@"showPostTextForm" isEqualToString:segue.identifier]) {
        [[segue destinationViewController] setPost:self.post];
    }

    if ([@"showPostImageForm" isEqualToString:segue.identifier]) {
        [[segue destinationViewController] setPost:self.post];
    }
}

- (IBAction)cancelForm:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)submitPost:(id)sender
{
    if (self.post.postId) {
        [self updatePost];
    }
    else {
        [self createPost];
    }
}

- (void)createPost
{
    BRUserModel *user = [BRUserModel sharedManager];
    [user createPost:self.post
             success:^(NSHTTPURLResponse *response, NSDictionary *result) {
                 [self.topVC.posts insertObject:[[BRPostModel alloc] initWithDictionary:result] atIndex:0];
                 [self.topVC.tableView reloadData];

                 [self dismissViewControllerAnimated:NO completion:nil];
             } failure:^(NSHTTPURLResponse *response, NSDictionary *result) {
                 NSLog(@"%@", result);
             } error:nil];
}

- (void)updatePost
{
    BRUserModel *user = [BRUserModel sharedManager];
    [user updatePost:self.post
             success:^(NSHTTPURLResponse *response, NSDictionary *result) {
                 [self.topVC.tableView reloadData];
                 [self dismissViewControllerAnimated:NO completion:nil];
             } failure:^(NSHTTPURLResponse *response, NSDictionary *result) {
                 NSLog(@"%@", result);
             } error:nil];
}

@end
