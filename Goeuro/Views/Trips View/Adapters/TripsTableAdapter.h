//
//  TripsTableAdapter.h
//  Goeuro
//
//  Created by Mahmoud Eldesouky on 1/15/17.
//  Copyright © 2017 Mahmoud Eldesouky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "GoEuroEnumerators.h"

@class HomeViewController;

@interface TripsTableAdapter : NSObject<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>


@property (strong, nonatomic) UITableView *tableView;
@property (weak, nonatomic) HomeViewController *delegate;
@property (nonatomic, assign) CGFloat lastContentOffset;
@property Boolean isLoading;
@property Boolean isConnectionError;
@property ViewType viewType;
@property TripType tripType;


-(instancetype)initWithTableViewController :(UITableView*)tableView withTripType:(TripType) tripType withViewType:(ViewType) viewType andDelegate: (HomeViewController*) delegate;
-(void)sortWith: (SortOption)option;

@end
