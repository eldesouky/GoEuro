//
//  GoEuroTableViewCell.h
//  Goeuro
//
//  Created by Mahmoud Eldesouky on 1/15/17.
//  Copyright © 2017 Mahmoud Eldesouky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoEuro-swift.h"

@interface GoEuroTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;
//@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (weak, nonatomic) IBOutlet UILabel *tripPrice;
@property (weak, nonatomic) IBOutlet UILabel *tripNoOfStops;
@property (weak, nonatomic) IBOutlet UILabel *tripDuration;
@property (weak, nonatomic) IBOutlet UIImageView *tripProviderLogo;
@property (weak, nonatomic) IBOutlet UILabel *tripStart_End;
-(void)setCellFor: (TripModel*)trip;

@end
