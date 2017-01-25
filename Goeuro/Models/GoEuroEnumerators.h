//
//  GoEuroEnumerators.h
//  Goeuro
//
//  Created by Mahmoud Eldesouky on 1/15/17.
//  Copyright © 2017 Mahmoud Eldesouky. All rights reserved.
//


#import <UIKit/UIKit.h>

#pragma All the Enums used in the app

typedef enum ViewType : NSUInteger {
    DefaultView,
    CustomView
} ViewType;

typedef enum TripType : NSUInteger {
    Train = 0,
    Bus = 1,
    Flight = 2
} TripType;

typedef enum SortType : NSUInteger {
    ascending,
    descending,
} SortType;

typedef enum SortOption : NSUInteger {
    Departure,
    Arrival,
    Period,
    Price
} SortOption;