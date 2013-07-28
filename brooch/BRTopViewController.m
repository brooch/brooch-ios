//
//  BRViewController.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/10/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRTopViewController.h"
#import "BRPostDetailViewController.h"
#import "BRUser.h"

@interface BRTopViewController ()

@end

@implementation BRTopViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    BRUser *user = [BRUser sharedManager];
    [user posts:@{@"offset": @0, @"limit": @10}
        success:^(NSHTTPURLResponse *response, NSArray *result) {
            self.posts = [result mutableCopy];
            [self.tableView reloadData];
        } failure:^(NSHTTPURLResponse *response, NSDictionary *result) {
            NSLog(@"%@", result);
        } error:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)firstViewReturnActionForSegue:(UIStoryboardSegue *)segue
{
    NSLog(@"First view return action invoked.");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.posts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"listViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [[self.posts objectAtIndex:indexPath.row] objectForKey:@"text"];
    return cell;
}

- (void)showPostForm
{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showPostDetail"]) {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        [segue.destinationViewController setPost:[self.posts objectAtIndex:path.row]];
    }
}

@end
