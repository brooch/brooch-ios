//
//  BRSignupViewController.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/13/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRSignupViewController.h"
#import "BRAPIClient.h"

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

- (IBAction)moveToMainScreen:(id)sender
{
    BRAPIClient *client = [[BRAPIClient alloc] init];
    [client request:@"POST"
              path:@"/v1/users"
             params:@{@"name":@"antipop", @"email":@"kentarok@gmail.com", @"password":@"password", @"password_confirmation":@"password"}
            success:^(NSHTTPURLResponse *response, NSDictionary *result) {
                NSLog(@"%d", [response statusCode]);
                NSLog(@"%@", result);

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
