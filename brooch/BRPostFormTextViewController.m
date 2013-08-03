//
//  BRPostTextViewController.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/22/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRPostFormTextViewController.h"

@interface BRPostFormTextViewController ()

@end

@implementation BRPostFormTextViewController

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
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    if ([self.textField.text isEqualToString:@"どんな言葉"]) {
        self.textField.text = @"";
    }

    self.textField.text = self.post.text;
    [self.textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.textField resignFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.post.text = self.textField.text;
}

- (IBAction)cancelForm:(id)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
