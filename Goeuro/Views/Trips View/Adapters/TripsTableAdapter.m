//
//  TripsTableAdapter.m
//  Goeuro
//
//  Created by Mahmoud Eldesouky on 1/15/17.
//  Copyright © 2017 Mahmoud Eldesouky. All rights reserved.
//

#import "TripsTableAdapter.h"
#import "GoEuroTableViewCell.h"
#import "TripTableViewCell.h"
#import "DefaultTableViewCell.h"
#import "HomeViewController.h"
#import "GoEuro-swift.h"
#import <SIAlertView.h>

@interface TripsTableAdapter(){
    
    NSArray<TripModel*> *trips;
    double tableViewCell_Height;
}

@end

@implementation TripsTableAdapter

#pragma- mark Init
-(instancetype)initWithTableViewController :(UITableView*)tableView withTripType:(TripType) tripType withViewType:(ViewType) viewType andDelegate: (HomeViewController*) delegate
{
    self  = [super init];
    if(self)
    {
        self.tableView = tableView;
        self.delegate = delegate;
        self.viewType = viewType;
        self.tripType = tripType;
        [self setupView];
    }
    
    return self;
}

#pragma- mark SetupViews
-(void)setupView{
    
    [self setupTableViewDelegates];
    [self configureCorrespondingView];
    [self regesiterCells];
    [self fetchTrips:self.tripType];
}

-(void)setupTableViewDelegates {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.isLoading = YES;
    self.isConnectionError = NO;

}

-(void)configureCorrespondingView{
    switch (self.viewType) {
        case DefaultView:
            tableViewCell_Height =  89.5;
            break;
        case CustomView:
            tableViewCell_Height =  125.5;
            break;
    }

}

-(void)regesiterCells {
    UINib *nib;
    NSString* identifier;
    
    switch (self.viewType) {
        case DefaultView:
            nib = [UINib nibWithNibName:@"DefaultTableViewCell" bundle:nil];
            identifier = @"DefaultTableViewCell";
            break;
        case CustomView:
            nib = [UINib nibWithNibName:@"TripTableViewCell" bundle:nil];
            identifier = @"TripTableViewCell";

            break;
    }
    
    [[self tableView] registerNib:nib forCellReuseIdentifier: identifier];

}

#pragma- mark Trips
-(void)fetchTrips: (TripType) type{

        [APIService fetchTripsFor:type completion:^(NSArray<TripModel *> *trips, BOOL error) {
            
            if(error)
                self.isConnectionError = YES;
            else{
                self.isConnectionError = NO;
                if ([trips count] > 0 || self->trips == nil) {
                    self->trips = trips;
                }
            }
            [self didFetchTrips];
            
        }];
}

-(void)sortTripsWith: (int)option withType: (NSComparisonResult) type {
    [self.tableView reloadData];
}

-(void)didFetchTrips{
    self.isLoading = NO;
    [self sortWith:Departure];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma -mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return trips.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoEuroTableViewCell *cell;
    switch (self.viewType) {
        case DefaultView:
            cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultTableViewCell"];
            break;
        case CustomView:
            cell = [tableView dequeueReusableCellWithIdentifier:@"TripTableViewCell"];
            break;
    }

    [cell setCellFor:trips[indexPath.row]];
    return cell;
    
}

#pragma- mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableViewCell_Height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    [self showAlert];
}

#pragma- mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    if (self.viewType == DefaultView) {
        return;
    }
    
    if (self.lastContentOffset > scrollView.contentOffset.y){
        [self.delegate.navigationController setNavigationBarHidden:false animated:true];
        self.delegate.tripDetailsViewHeight.constant = 35;
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5 animations:^{
                [self.delegate.tripDetailsView  layoutIfNeeded];
                [self.delegate animateHeader];
            }];
        });
        
    }
    else if (self.lastContentOffset < scrollView.contentOffset.y){
        [self.delegate.navigationController setNavigationBarHidden:true animated:true];
        self.delegate.tripDetailsViewHeight.constant = 50;
        self.delegate.sortViewHeightConstraint.constant = 0;
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 animations:^{
                [self.delegate animateHeader];
                [self.delegate.tripDetailsView  layoutIfNeeded];
                
            } completion:^(BOOL finished) {
                [self.delegate.sortSegmentedControl  setHidden:YES];
                
            }];
        });
    }
    self.lastContentOffset = scrollView.contentOffset.x;
}

#pragma- mark DZNEmptyDataSet
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"GoEuroLogo"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
     NSString *emptyDataMessage;
    if (self.isConnectionError) {
        emptyDataMessage = @"Connection Error \n Please Make Sure Your Phone Has Internet Connection";
    }
    else if (self.isLoading){
        emptyDataMessage = @"Loading \n Please Wait";
    }
    else {
        emptyDataMessage = @"No Data For Current Trip \n Please Check Later";
    }
   
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:emptyDataMessage attributes:attributes];
}
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.isLoading){
        return [UIColor lightGrayColor];
    }
    else {
        return [UIColor whiteColor];
    }
}

#pragma- mark Sort Helper
-(void)sortWith: (SortOption)option{
    
    switch (option) {
        case Departure:
            self->trips = [self-> trips sortedArrayWithOptions:NSOrderedAscending usingComparator:^NSComparisonResult(TripModel*  obj1, TripModel* obj2) {
                return [obj1.departureTime compare:obj2.departureTime];
            }];
            break;
        case Arrival:
            self->trips = [self-> trips sortedArrayWithOptions:NSOrderedAscending usingComparator:^NSComparisonResult(TripModel*  obj1, TripModel* obj2) {
                return [obj1.arrivalTime compare:obj2.arrivalTime];
            }];
            break;
        case Period:
            self->trips = [self-> trips sortedArrayWithOptions:NSOrderedAscending usingComparator:^NSComparisonResult(TripModel*  obj1, TripModel* obj2) {
                return [obj1.durationInSecondsToNSNumber compare:obj2.durationInSecondsToNSNumber];
            }];
        default:
            break;
    }
    [self.tableView reloadData];
}

#pragma- mark UIAlert
-(void) showAlert{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Oops!" andMessage:@"Offer details are not yet implemented!"];
    [alertView addButtonWithTitle:@"OK"
                             type:SIAlertViewButtonTypeDefault
                          handler:nil];
    if (self.viewType == DefaultView)
        alertView.transitionStyle = SIAlertViewTransitionStyleFade;
    else
        alertView.transitionStyle = SIAlertViewTransitionStyleDropDown;
    
    [alertView show];
}

@end