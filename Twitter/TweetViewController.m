//
//  TweetViewController.m
//  Twitter
//
//  Created by Sumeet Ungratwar on 11/2/14.
//  Copyright (c) 2014 Sumeet Ungratwar. All rights reserved.
//

#import "TweetViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"

@interface TweetViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screennameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *favouritesCountLabel;
@property (weak, nonatomic) IBOutlet UITextView *replyView;

@end

@implementation TweetViewController

- (IBAction)onTap:(id)sender {
    [self.replyView resignFirstResponder];
    [self.view endEditing:YES];
}

- (IBAction)onReply:(id)sender {
    self.replyView.hidden = NO;
    self.replyView.text = @"@";
    self.replyView.text = [self.replyView.text stringByAppendingString:self.tweet.user.screenname];
    self.replyView.text = [self.replyView.text stringByAppendingString:@":"];
    [self.replyView becomeFirstResponder];
}

- (void)onSendReply {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"status"] = self.replyView.text;
    dictionary[@"in_reply_to_status_id"] = self.tweet.identifier;
    [[TwitterClient sharedInstance] postTweetWithParams:dictionary completion:^(id response, NSError *error) {
        if (error == nil) {
            NSLog(@"Got response after replying");
            self.replyView.hidden = YES;
        } else {
            NSLog(@"Error in replying and error is %@", error);
        }
    }];
}

- (IBAction)onRetweet:(id)sender {
    [[TwitterClient sharedInstance] retweetWithParams:self.tweet.identifier completion:^(id response, NSError *error) {
        //NSLog(@"Got by retweet response %@ %@", response, error);
        if (error != nil) {
            NSLog(@"Error in retweeting");
        } else {
            NSLog(@"Retweeted successfully");
        }
    }];
}

- (IBAction)onFavourite:(id)sender {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"id"] = self.tweet.identifier;
    [[TwitterClient sharedInstance] markFavourites:dictionary completion:^(id response, NSError *error) {
        if (error != nil) {
            NSLog(@"Error in Favouriting");
        } else {
            NSLog(@"Marked favourites successfully");
        }
    }];
}

- (void)onHome {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Tweet";
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Reply" style:UIBarButtonItemStylePlain target:self action:@selector(onSendReply)];
    self.navigationItem.rightBarButtonItem = rightButton;
    //self.navigationItem.rightBarButtonItem = rightButton;
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self action:@selector(onHome)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    [self.posterView setImageWithURL:[NSURL URLWithString:self.tweet.user.profileImageUrl]];
    self.nameLabel.text = self.tweet.user.name;
    self.screennameLabel.text = @"@";
    self.screennameLabel.text = [self.screennameLabel.text stringByAppendingString:self.tweet.user.screenname];
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
    timeFormatter.dateFormat = @"MM/dd/yy HH:mm:ss";
    self.createdAtLabel.text = [timeFormatter stringFromDate:self.tweet.createdAt];
    
    self.descriptionLabel.text = self.tweet.text;
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%ld", self.tweet.retweetCount];
    self.favouritesCountLabel.text = [NSString stringWithFormat:@"%ld", self.tweet.favouritesCount];
    
    self.replyView.hidden = YES;
    self.replyView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
