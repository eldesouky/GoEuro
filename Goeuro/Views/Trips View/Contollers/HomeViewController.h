//
//  HomeViewController.h
//  Goeuro
//
//  Created by Mahmoud Eldesouky on 1/15/17.
//  Copyright © 2017 Mahmoud Eldesouky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TripsScrollAdapter.h"
#import "TripsTableAdapter.h"
#import "GoEuroEnumerators.h"

@class GoEuroSegmentedControl;


@interface HomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *trainView;
@property (weak, nonatomic) IBOutlet UIView *busView;
@property (weak, nonatomic) IBOutlet UIView *flightView;

@property (weak, nonatomic) IBOutlet UITableView *trainTableView;
@property (weak, nonatomic) IBOutlet UITableView *busTableView;
@property (weak, nonatomic) IBOutlet UITableView *flightTableView;
@property (weak, nonatomic) IBOutlet UIView *sortView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sortSegmentedControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sortViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *tripDetailsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tripDetailsViewHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segmentedControlHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;

@property (weak, nonatomic) IBOutlet UIButton *sortButton;
@property (strong, nonatomic)  GoEuroSegmentedControl *segmentedControl;

@property int currentIndex;
@property UIColor *mainColor;
@property UIColor *segmentedControl_BackgroundColor;

@property UIColor *segmentedControlCell_deselectedFontColor;
@property UIColor *segmentedControlCell_selectedFontColor;
@property NSArray *options;
@property ViewType viewType;

-(instancetype)initWithType :(ViewType)viewType;
-(void)animateHeader;
- (void)segmentedControlValueDidChangeTo:(int) index fromScrollingAction:(Boolean)isScrolled;
- (IBAction)sortSegmentedControlDidChange:(UISegmentedControl*)sender;

@end
