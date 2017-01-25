//
//  HomeViewController.m
//  Goeuro
//
//  Created by Mahmoud Eldesouky on 1/15/17.
//  Copyright © 2017 Mahmoud Eldesouky. All rights reserved.
//

#import "HomeViewController.h"
#import "GoEuro-swift.h"
#import "GoEuroEnumerators.h"


@interface HomeViewController()
{
    TripsScrollAdapter* scrollViewAdapter;
    TripsTableAdapter* trainTableViewAdapter;
    TripsTableAdapter* busTableViewAdapter;
    TripsTableAdapter* flightTableViewAdapter;
    TripType currentIndex;
    CGFloat GoEuroSegmentedControl_Height;

}
@end

@implementation HomeViewController

CGFloat SortSegmentedControl_Height = 35;

-(instancetype)initWithType :(ViewType)viewType{
    self.viewType = viewType;
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupView];
    [self setNeedsStatusBarAppearanceUpdate];

}

#pragma- mark setupView
-(void)setupView{
    [self setupCorrespondingView];
    [self setupAdapters];
    [self setupSegmentControl];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
-(void)setupCorrespondingView{
    [self setupColors];
}

-(void) setupColors{
    
    switch (self.viewType) {
        case DefaultView:
            self.mainColor =  [UIColor colorWithRed:(16.0f/255.0f) green:(76.0f/255.0f) blue:(146.0f/255.0f) alpha:1];
            self.segmentedControl_BackgroundColor = self.mainColor;
            self.segmentedControlCell_selectedFontColor = [UIColor whiteColor];
            self.segmentedControlCell_deselectedFontColor = [UIColor whiteColor];
            self.tripDetailsView.backgroundColor = self.mainColor;
            self.tripDetailsViewHeight.constant = 50;
            self->GoEuroSegmentedControl_Height = 80;
            break;
        case CustomView:
            self.mainColor = [UIColor colorWithRed:(248.0f/255.0f) green:(188.0f/255.0f) blue:(49.0f/255.0f) alpha:1];
            self.segmentedControl_BackgroundColor = [UIColor whiteColor];
            self.segmentedControlCell_selectedFontColor = self.mainColor;
            self.segmentedControlCell_deselectedFontColor = [UIColor blackColor];
            self.tripDetailsView.backgroundColor = self.mainColor;
            self->GoEuroSegmentedControl_Height = 40;
            [self.dismissButton setHidden:YES];
            [self.sortButton setHidden:YES];
            [self setupNavigationController];
            break;
    }
    self.sortSegmentedControl.tintColor = self.mainColor;
    self.segmentedControlHeightConstraint.constant = self->GoEuroSegmentedControl_Height;
  }

-(void)setupAdapters{
    scrollViewAdapter = [[TripsScrollAdapter alloc] initWithTableViewController:self.scrollView withType:self.viewType andDelegate:self];
    scrollViewAdapter.delegate = self;
    
    trainTableViewAdapter = [[TripsTableAdapter alloc] initWithTableViewController:self.trainTableView withTripType: Train withViewType:self.viewType andDelegate:self];
    busTableViewAdapter =[[TripsTableAdapter alloc] initWithTableViewController:self.busTableView withTripType: Bus withViewType:self.viewType andDelegate:self];
    flightTableViewAdapter = [[TripsTableAdapter alloc] initWithTableViewController:self.flightTableView withTripType: Flight withViewType:self.viewType andDelegate:self];
    
}
-(void)setupSegmentControl{
    
    self.options = @[@"Train",@"Bus",@"Flight"];
    [self.headerView layoutIfNeeded];
    CGFloat segmentWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat segmentYPostion =  self.headerView.frame.size.height - GoEuroSegmentedControl_Height;
    CGRect segmentFrame =  CGRectMake(0, segmentYPostion, segmentWidth, GoEuroSegmentedControl_Height);
    

    self.segmentedControl = [[GoEuroSegmentedControl alloc] initWithFrame:segmentFrame options:self.options backgroundColor:self.segmentedControl_BackgroundColor fontColor:self.segmentedControlCell_selectedFontColor deselectCellFontColor:self.segmentedControlCell_deselectedFontColor];
    
    (self.segmentedControl).viewController = self;
    [self.headerView addSubview: self.segmentedControl];

}

-(void)setupNavigationController {
  
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.navigationController.navigationBar.topItem setTitle:@"Trips"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName: [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0],
                                                                      NSFontAttributeName: [UIFont fontWithName:@"NeutraTextTF-DemiAlt" size:22.0]
                                                                      }];
   
    UIImage *backButtonImage = [[UIImage imageNamed:@"back_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImage *sortButtonImage = [[UIImage imageNamed:@"sort_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage: backButtonImage style:UIBarButtonItemStyleBordered target:self action:@selector(dismissView:)];
    UIBarButtonItem *sortButton = [[UIBarButtonItem alloc] initWithImage: sortButtonImage style:UIBarButtonItemStyleBordered target:self action:@selector(showHideSortView)];

    backButton.tintColor = [UIColor whiteColor];
    sortButton.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.rightBarButtonItem = sortButton;
    
    [[UINavigationBar appearance] setBarTintColor:self.mainColor];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackTranslucent];
    self.navigationController.hidesBarsOnSwipe = YES;

}


#pragma- Scroll Animation
-(void)animateHeader{
    
    
    [self.headerView layoutIfNeeded];
    [self.scrollView layoutIfNeeded];
    self.segmentedControl.frame = CGRectMake(self.segmentedControl.frame.origin.x, (self.headerView.frame.size.height - GoEuroSegmentedControl_Height), self.segmentedControl.frame.size.width, self.segmentedControl.frame.size.height);
    [self.sortView layoutIfNeeded];
    [self.segmentedControl layoutIfNeeded];
    
}

#pragma- mark IBActions
-(IBAction)showHideSortView {
    if (self.sortSegmentedControl.isHidden) {
        self.sortViewHeightConstraint.constant = SortSegmentedControl_Height;
        [self.sortSegmentedControl  setHidden:NO];
        
        [UIView animateWithDuration:0.75 animations:^{
            [self animateHeader];
        }];

    }
    else{
        self.sortViewHeightConstraint.constant = 0;
        
        [UIView animateWithDuration:0.75 animations:^{
            [self animateHeader];
        } completion:^(BOOL finished) {
            [self.sortSegmentedControl  setHidden:YES];
        }];
    }
}

- (void)segmentedControlValueDidChangeTo:(int) index fromScrollingAction:(Boolean)isScrolled{
    
    if (isScrolled) {
        [self.segmentedControl scrollHorizontalBarToSelectedSegmentCell:index];
    }
    else{
        [scrollViewAdapter scrollToPage: index];
    }
    currentIndex = index;
}

- (IBAction)sortSegmentedControlDidChange:(UISegmentedControl*)sender {
    
    if (currentIndex == Train) {
        [trainTableViewAdapter sortWith: (int)sender.selectedSegmentIndex];
    }
    
   else  if (currentIndex == Bus) {
        [busTableViewAdapter sortWith: (int)sender.selectedSegmentIndex];
    }
    if (currentIndex == Flight) {
        [flightTableViewAdapter sortWith: (int)sender.selectedSegmentIndex];
    }
    [self showHideSortView];

}
- (void) dismissView:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)dismissButtonIsClicked:(id)sender {
    [self dismissView:sender];
}

- (IBAction)sortButtonIsClicked:(id)sender {
    [self showHideSortView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
