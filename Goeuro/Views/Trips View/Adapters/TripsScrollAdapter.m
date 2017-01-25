//
//  TripsScrollAdapter.m
//  Goeuro
//
//  Created by Mahmoud Eldesouky on 1/15/17.
//  Copyright © 2017 Mahmoud Eldesouky. All rights reserved.
//

#import "TripsScrollAdapter.h"
#import "GoEuro-swift.h"
#import "HomeViewController.h"
#import "GoEuroEnumerators.h"

@implementation TripsScrollAdapter

-(instancetype)initWithTableViewController :(UIScrollView*)scrollView withType:(ViewType) viewType andDelegate: (HomeViewController*) delegate
{
    self.scrollView = scrollView;
    self.delegate = delegate;
    self.viewType = viewType;
    self.scrollView.delegate = self;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.directionalLockEnabled = YES;
    
    self.lastContentOffset = 0.0;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    return self;
}
#pragma- mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    static NSInteger previousPage = 0;

    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);

    if (previousPage != page) {
        [self.delegate  segmentedControlValueDidChangeTo: (int)page fromScrollingAction:true];
        previousPage = page;
    }
}

#pragma- mark UIScrollView Helper Method
-(void)scrollToPage:(int)page{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat xPostion = page * screenWidth;
    [self.scrollView setContentOffset:CGPointMake(xPostion, 0) animated:YES];
}


@end
