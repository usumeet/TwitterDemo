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
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

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
    NSLog(@"Is retweeted: %d", self.tweet.retweeted);
    if (!self.tweet.retweeted) {
        [[TwitterClient sharedInstance] retweetWithParams:self.tweet.identifier completion:^(id response, NSError *error) {
            //NSLog(@"Got by retweet response %@ %@", response, error);
            if (error != nil) {
                NSLog(@"Error in retweeting");
            } else {
                NSLog(@"Retweeted successfully");
                long retweetCount = self.tweet.retweetCount + 1;
                self.retweetCountLabel.text = [NSString stringWithFormat:@"%ld", (long)retweetCount];
                self.tweet.retweeted = YES;
                UIImage *btnImage = [UIImage imageNamed:@"retweet_on.png"];
                [self.retweetButton setImage:btnImage forState:UIControlStateNormal];
            }
        }];
    } else {
        NSLog(@"Already retweeted");
    }
}

- (IBAction)onFavourite:(id)sender {
    if (!self.tweet.favourited) {
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        dictionary[@"id"] = self.tweet.identifier;
        [[TwitterClient sharedInstance] markFavourites:dictionary completion:^(id response, NSError *error) {
            if (error != nil) {
                NSLog(@"Error in Favouriting");
            } else {
                NSLog(@"Marked favourites successfully");
                self.tweet.favourited = YES;
                long favouritedCount = self.tweet.favouritesCount + 1;
                self.favouritesCountLabel.text = [NSString stringWithFormat:@"%ld", (long)favouritedCount];
                UIImage *btnImage = [UIImage imageNamed:@"favorite_on.png"];
                [self.favoriteButton setImage:btnImage forState:UIControlStateNormal];
                
            }
        }];
    } else {
        NSLog(@"Alraedy a favorite");
    }
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
    
    if (self.tweet.retweeted) {
        //[self.retweetButton setImage:[UIImage imageNamed:@"retweet_on.png"]];
        UIImage *btnImage = [UIImage imageNamed:@"retweet_on.png"];
        [self.retweetButton setImage:btnImage forState:UIControlStateNormal];
    }
    if (self.tweet.favourited) {
        UIImage *btnImage = [UIImage imageNamed:@"favorite_on.png"];
        [self.favoriteButton setImage:btnImage forState:UIControlStateNormal];
    }
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
