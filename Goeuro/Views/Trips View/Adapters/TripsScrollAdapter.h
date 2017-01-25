//
//  TripsScrollAdapter.h
//  Goeuro
//
//  Created by Mahmoud Eldesouky on 1/15/17.
//  Copyright © 2017 Mahmoud Eldesouky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoEuroEnumerators.h"

@class HomeViewController;


@interface TripsScrollAdapter : NSObject<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) HomeViewController *delegate;
@property (nonatomic, assign) CGFloat lastContentOffset;
@property ViewType viewType;


-(instancetype)initWithTableViewController :(UIScrollView*)scrollView withType:(ViewType) viewType andDelegate: (HomeViewController*) delegate;
-(void)scrollToPage:(int)page;

@end

typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
    ScrollDirectionCrazy,
} ScrollDirection;
