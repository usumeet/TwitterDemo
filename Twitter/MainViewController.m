//
//  MainViewController.m
//  Twitter
//
//  Created by Sumeet Ungratwar on 11/8/14.
//  Copyright (c) 2014 Sumeet Ungratwar. All rights reserved.
//

#import "MainViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "TweetsViewController.h"
#import "MenuViewController.h"
#import "DummyViewController.h"

#define CENTER_TAG 1
#define LEFT_TAG 0
#define CORNER_RADIUS 4
#define SLIDE_TIMING .25
#define PANEL_WIDTH 60

@interface MainViewController () <CenterViewControllerDelegate, LeftPanelViewControllerDelegate, UIGestureRecognizerDelegate, CenterViewControllerDelegate>

-(void)onMenu:(id)sender;
-(void)onMain:(id)sender;

@property (nonatomic, strong) UIViewController *centerViewController;
@property (nonatomic, strong) MenuViewController *leftPanelViewController;
@property (nonatomic, assign) BOOL showingLeftPanel;
@property (nonatomic, assign) BOOL showingTimeline;

@property (nonatomic, assign) BOOL showPanel;
@property (nonatomic, assign) CGPoint preVelocity;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showingTimeline = YES;
    [self setupView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showCenterViewWithShadow:(BOOL)value withOffset:(double)offset {
    if (value)
    {
        [_centerViewController.view.layer setCornerRadius:CORNER_RADIUS];
        [_centerViewController.view.layer setShadowColor:[UIColor blackColor].CGColor];
        [_centerViewController.view.layer setShadowOpacity:0.8];
        [_centerViewController.view.layer setShadowOffset:CGSizeMake(offset, offset)];
        
    }
    else
    {
        [_centerViewController.view.layer setCornerRadius:0.0f];
        [_centerViewController.view.layer setShadowOffset:CGSizeMake(offset, offset)];
    }
}

- (void)resetMainView
{
    // remove left view and reset variables, if needed
    if (_leftPanelViewController != nil)
    {
        [self.leftPanelViewController.view removeFromSuperview];
        self.leftPanelViewController = nil;
        
        self.showingLeftPanel = NO;
    }
    
    // remove view shadows
    [self showCenterViewWithShadow:NO withOffset:0];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(onMenu:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.rightBarButtonItem = nil;
}

- (UIView *)getLeftView
{
    // init view if it doesn't already exist
    if (_leftPanelViewController == nil)
    {
        // this is where you define the view for the left panel
        self.leftPanelViewController = [[MenuViewController alloc] init];
        self.leftPanelViewController.view.tag = LEFT_TAG;
        self.leftPanelViewController.delegate = self;
        
        [self.view addSubview:self.leftPanelViewController.view];
        
        [self addChildViewController:_leftPanelViewController];
        [_leftPanelViewController didMoveToParentViewController:self];
        
        _leftPanelViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    self.showingLeftPanel = YES;
    
    // set up view shadows
    [self showCenterViewWithShadow:YES withOffset:-2];
    
    UIView *view = self.leftPanelViewController.view;
    return view;
}

- (UIView *)getRightView
{
    UIView *view = nil;
    return view;
}

#pragma mark -
#pragma mark Swipe Gesture Setup/Actions

#pragma mark - setup

- (void)setupGestures
{
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(movePanel:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    
    [_centerViewController.view addGestureRecognizer:panRecognizer];
}

-(void)movePanel:(id)sender
{
    [[[(UITapGestureRecognizer*)sender view] layer] removeAllAnimations];
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    CGPoint velocity = [(UIPanGestureRecognizer*)sender velocityInView:[sender view]];
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        UIView *childView = nil;
        
        if(velocity.x > 0) {
            if (!_showingLeftPanel) {
                childView = [self getLeftView];
                [self.view sendSubviewToBack:childView];
                [[sender view] bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
            }
        }
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
        if(velocity.x > 0) {
            // NSLog(@"gesture went right");
        } else {
            // NSLog(@"gesture went left");
        }
        
        if (!_showPanel) {
            [self movePanelToOriginalPosition];
        } else {
            [self movePanelRight];
        }
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        if(velocity.x > 0) {
            // NSLog(@"gesture went right");
        } else {
            if (!_showingLeftPanel) {
                return;
            }
        }
        
        // Are you more than halfway? If so, show the panel when done dragging by setting this value to YES (1).
        _showPanel = abs([sender view].center.x - _centerViewController.view.frame.size.width/2) > _centerViewController.view.frame.size.width/2;
        
        NSLog(@"translation point %f %f", translatedPoint.x, translatedPoint.y);
        // Allow dragging only in x-coordinates by only updating the x-coordinate with translation position.
        [sender view].center = CGPointMake([sender view].center.x + translatedPoint.x, [sender view].center.y);
        [(UIPanGestureRecognizer*)sender setTranslation:CGPointMake(0,0) inView:self.view];
        
        // If you needed to check for a change in direction, you could use this code to do so.
        if(velocity.x*_preVelocity.x + velocity.y*_preVelocity.y > 0) {
            // NSLog(@"same direction");
        } else {
            // NSLog(@"opposite direction");
        }
        
        _preVelocity = velocity;
    }
}

#pragma mark Setup View

- (void)setupView
{
    if (self.showingTimeline) {
        self.centerViewController = [[TweetsViewController alloc] init];
    } else {
        DummyViewController *vs = [[DummyViewController alloc] init];
        vs.user = [User currentUser];
        self.centerViewController = vs;
    }
    self.centerViewController.view.frame = self.view.bounds;
    //self.centerViewController.delegate = self;
    
    [self.view addSubview:self.centerViewController.view];
    [self addChildViewController:_centerViewController];
    
    [_centerViewController didMoveToParentViewController:self];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(onMenu:)];
    leftButton.tag = 1;
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.rightBarButtonItem = nil;
    [self setupGestures];
}


#pragma mark - Navifation bar items
- (void)onMenu:(id)sender {
    [self movePanelRight];
}

-(void)onMain:(id)sender {
    [self movePanelToOriginalPosition];
    self.navigationItem.rightBarButtonItem = nil;
}


#pragma mark -
#pragma mark Delegate Actions

- (void)movePanelLeft // to show right panel
{
}

- (void)movePanelRight // to show left panel
{
    UIView *childView = [self getLeftView];
    [self.view sendSubviewToBack:childView];
    
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         _centerViewController.view.frame = CGRectMake(self.view.frame.size.width - PANEL_WIDTH, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             
                             self.navigationItem.leftBarButtonItem = nil;
                             
                             UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Main" style:UIBarButtonItemStylePlain target:self action:@selector(onMain:)];
                             self.navigationItem.rightBarButtonItem = rightButton;
                         }
                     }];
}

- (void)movePanelToOriginalPosition
{
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         _centerViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             
                             [self resetMainView];
                         }
                     }];
}

#pragma mark - LeftPanelViewController delegate methods
- (void)showProfilepage {
    
    
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.centerViewController.view.frame = self.view.bounds;
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             
                             if (_centerViewController != nil)
                             {
                                 [self.centerViewController.view removeFromSuperview];
                                 self.centerViewController = nil;
                             }
                             self.showingTimeline = NO;
                             [self setupView];
                         }
                     }];

    
}

- (void)showTimeline {
    
    
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.centerViewController.view.frame = self.view.bounds;
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             
                             if (_centerViewController != nil)
                             {
                                 [self.centerViewController.view removeFromSuperview];
                                 self.centerViewController = nil;
                             }
                             self.showingTimeline = YES;
                             [self setupView];
                         }
                     }];
    
    
}

@end
