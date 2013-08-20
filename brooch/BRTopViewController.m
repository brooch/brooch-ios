//
//  BRViewController.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/10/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRTopViewController.h"
#import "BRPostDetailViewController.h"
#import "BRUserModel.h"
#import "BRPostModel.h"
#import "BRPostTableViewCell.h"
#import "BRPostTableLoadMoreViewCell.h"
#import "BRPostFormViewController.h"

@interface BRTopViewController ()

@property (nonatomic) NSInteger currentPostPostion;

@end

@implementation BRTopViewController

static NSString *cellIdentifier          = @"postListViewCell";
static NSString *loadMoreCellIdentifier  = @"postLoadMoreViewCell";
static NSString *showPostSegueIdentifier = @"showPostDetail";

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"BRPostTableViewCell" bundle:nil]
         forCellReuseIdentifier:cellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"BRPostTableLoadMoreViewCell" bundle:nil]
         forCellReuseIdentifier:loadMoreCellIdentifier];

    [self loadPosts];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIImage *image         = [UIImage imageNamed:@"home_tag_bg@2x.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, image.size.width, image.size.height)];
    UIView  *view          = [[UIView alloc] init];
    UILabel *label         = [[UILabel alloc] initWithFrame:CGRectMake(16.0, 0.0, 310.0, 40.0)];

    view.backgroundColor = [UIColor colorWithPatternImage:image];

    label.textColor = [UIColor blackColor];
    label.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0];
    label.textColor = [UIColor grayColor];
    label.text = @"all brooches ∵";
    label.backgroundColor = [UIColor clearColor];

    // なんか縦にそろわないのでむりやりframeいじってる…
    CGRect frame = label.frame;
    label.frame = CGRectMake(frame.origin.x, frame.origin.y + 3, frame.size.width, frame.size.height);
    
    [view addSubview:imageView];
    [view addSubview:label];
    [view bringSubviewToFront:label];

    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.posts count] + 1; // 「もっと読む」用に1つプラスする
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{  
    // 通常のセル
    if (indexPath.row < [self.posts count]) {
        BRPostModel *post = self.posts[indexPath.row];
        BRPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

        if (cell == nil) {
            cell = [[BRPostTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }

        cell.delegate       = self;
        cell.post           = post;
        cell.textLabel.text = post.text;

        return cell;
    }
    // 「もっと読む」用のセル
    else {
        BRPostTableLoadMoreViewCell *cell = [tableView dequeueReusableCellWithIdentifier:loadMoreCellIdentifier];
        
        if (cell == nil) {
            cell = [[BRPostTableLoadMoreViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loadMoreCellIdentifier];
        }

        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 通常のセル
    if (indexPath.row < [self.posts count]) {
        BRPostTableViewCell *cell = (BRPostTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [cell hideBackgroundView];

        [self performSegueWithIdentifier:showPostSegueIdentifier sender:self];
    }
    // 「もっと読む」用のセル
    else {
        [self loadPosts];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:showPostSegueIdentifier]) {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        self.currentPostPostion = path.row;
        BRPostModel *post = self.posts[path.row];

        [segue.destinationViewController setCurrentPost:post];
        [segue.destinationViewController setTopVC:self];
    }

    if ([[segue identifier] isEqualToString:@"showPostForm"]) {
        [segue.destinationViewController setTopVC:self];

        BRPostModel *post = [[BRPostModel alloc] initWithDictionary:@{@"author": [@{@"name":@""} mutableCopy]}];
        [segue.destinationViewController setPost:post];
    }
}

- (IBAction)didSwipeToLeft:(UISwipeGestureRecognizer *)swipeRecognizer
{
    CGPoint loc = [swipeRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:loc];
    BRPostTableViewCell* cell = (BRPostTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];

    [cell hideBackgroundView];
}

- (IBAction)didSwipeToRight:(UISwipeGestureRecognizer *)swipeRecognizer
{
    CGPoint loc = [swipeRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:loc];
    BRPostTableViewCell* cell = (BRPostTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    [cell showBackgroundView];
}

-(void)didPushDeletePostButton:(id)sender
                        post:(BRPostModel *)post
{
    BRUserModel *user = [BRUserModel sharedManager];
    [user deletePost:post
             success:^(NSHTTPURLResponse *response, NSDictionary *result){
                 [self.posts removeObject:post];
                 [self.tableView reloadData];
             } failure:^(NSHTTPURLResponse *response, NSDictionary *result){
                 NSLog(@"%@", result);
             } error:nil];
}

- (void)loadPosts
{
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    BRPostTableLoadMoreViewCell *loadMoreCell = (BRPostTableLoadMoreViewCell *)[self.tableView cellForRowAtIndexPath:path];
    [loadMoreCell startLoading];

    BRUserModel *user = [BRUserModel sharedManager];
    [user posts:@{@"offset": [NSNumber numberWithInt:[self.posts count]], @"limit": @20}
        success:^(NSHTTPURLResponse *response, NSArray *result) {
            [loadMoreCell endLoading];

            if ([result count] > 0) {
                // 初回起動時
                if ([self.posts count] == 0) {
                    NSMutableArray *posts = [@[] mutableCopy];
                    
                    for (NSDictionary *post in result) {
                        [posts addObject:[[BRPostModel alloc] initWithDictionary:post]];
                    }
                    
                    self.posts = posts;
                }
                // 「もっと読む」押下時
                else {
                    for (NSDictionary *post in result) {
                        [self.posts addObject:[[BRPostModel alloc] initWithDictionary:post]];
                    }
                }
                
                [self.tableView reloadData];
            }
            else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                    message:@"投稿はもうありません。"
                                                                   delegate:nil
                                                          cancelButtonTitle:nil
                                                          otherButtonTitles:@"OK", nil];
                [alertView show];
            }
        } failure:^(NSHTTPURLResponse *response, NSDictionary *result) {
            NSLog(@"%@", result);
        } error:nil];
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

- (BRPostModel *)nextPost
{
    BRPostModel *post = self.posts[self.currentPostPostion + 1];
    self.currentPostPostion += 1;
    return post;

}

- (BRPostModel *)prevPost
{
    BRPostModel *post = self.posts[self.currentPostPostion - 1];
    self.currentPostPostion -= 1;
    return post;
    
}

@end
