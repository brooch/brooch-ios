//
//  BRConfigViewController.m
//  brooch
//
//  Created by 栗林 健太郎 on 8/12/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRConfigViewController.h"
#import "BRConfigWebViewController.h"
#import "BRUserModel.h"

@interface BRConfigViewController ()

@end

@implementation BRConfigViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *url;

    if ([[segue identifier] isEqualToString:@"showTerms"]) {
#ifdef DEBUG
        url = @"http://localhost:3000/terms";
#else
        url = @"https://kentaro-brooch.sqale.jp/terms";
#endif
    }

    if ([[segue identifier] isEqualToString:@"showHomePage"]) {
#ifdef DEBUG
        url = @"http://localhost:3000/";
#else
        url = @"https://kentaro-brooch.sqale.jp/";
#endif    
    }

    [[segue destinationViewController] setUrl:url];
}

//signoutbuttonがクリックされた時に呼ばれるメソッドの実装
- (IBAction)respondToButtonClick:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.delegate = self;
    alert.title = @"サインアウト";
    alert.message = @"実行してもよろしいですか？";
    [alert addButtonWithTitle:@"いいえ"];
    [alert addButtonWithTitle:@"はい"];
    [alert show];
}
//アラートがクリックされた時に呼ばれるメソッドの実装
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            //１番目のボタンが押されたときの処理を記述する
            break;
        case 1:
            //２番目のボタンが押されたときの処理を記述する
    
        {
            BRUserModel *user = [BRUserModel sharedManager];
            [user signOut];
                             
        }

            break;
    }
}



@end
