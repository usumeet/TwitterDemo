//
//  TweetsViewController.h
//  Twitter
//
//  Created by Sumeet Ungratwar on 11/1/14.
//  Copyright (c) 2014 Sumeet Ungratwar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CenterViewControllerDelegate <NSObject>

@optional
- (void)movePanelLeft;
- (void)movePanelRight;

@required
- (void)movePanelToOriginalPosition;

@end


@interface TweetsViewController : UIViewController

@property (nonatomic, assign) id<CenterViewControllerDelegate> delegate;

@end
