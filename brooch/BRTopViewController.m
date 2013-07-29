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

@property (nonatomic) NSInteger currentPostPostion;

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showPostDetail"]) {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        self.currentPostPostion = path.row;
        [segue.destinationViewController setCurrentPost:[self.posts objectAtIndex:path.row]];
    }
}

// TODO: ダサいのでiteratorパタンにする
- (BOOL)hasNextPost
{
    return self.currentPostPostion != [self.posts count] - 1;
}

- (BOOL)hasPrevPost
{
    return self.currentPostPostion > 0;
}

- (NSDictionary *)nextPost
{
    NSDictionary *post = self.posts[self.currentPostPostion + 1];
    self.currentPostPostion += 1;
    return post;

}

- (NSDictionary *)prevPost
{
    NSDictionary *post = self.posts[self.currentPostPostion - 1];
    self.currentPostPostion -= 1;
    return post;
    
}

@end
