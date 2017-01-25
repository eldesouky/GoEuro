//
//  GoEuroTableViewCell.m
//  Goeuro
//
//  Created by Mahmoud Eldesouky on 1/15/17.
//  Copyright © 2017 Mahmoud Eldesouky. All rights reserved.
//

#import "GoEuroTableViewCell.h"
#import "GoEuro-swift.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>

@implementation GoEuroTableViewCell

#pragma- mark init
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

#pragma- mark Setup Cell Data
-(void)setCellFor: (TripModel*)trip {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.tripDuration.text = trip.durationToString;
        self.tripPrice.attributedText = [self AttributedPriceFor:trip.priceWholeNumberToString and:trip.priceFractionalNumberToString];
        
        [trip.priceWholeNumberToString stringByAppendingString:trip.priceFractionalNumberToString];
        self.tripStart_End.text = trip.arrival_departureToString;
        self.tripNoOfStops.text = trip.numberOfStopsToString;
    });
    
    [self.tripProviderLogo setImageWithURL:[NSURL URLWithString:trip.providerImageURLString]  completed:nil usingActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
}

#pragma- mark Setup Attributed Price
-(NSAttributedString*)AttributedPriceFor:(NSString*)wholeNumber and:(NSString*)fractionalNumber {
    
    UIColor *priceColor = [UIColor colorWithRed:66.0f/255.0f green:70.0f/255.0f blue:66.0f/255.0f alpha:1];
    NSDictionary *wholeNumberAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"NeutraTextTF-DemiAlt" size:18.0f],
                                    NSForegroundColorAttributeName: priceColor};
    NSDictionary *fractionalNumberAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"NeutraTextTF-DemiAlt" size:13.0f],
                                            NSForegroundColorAttributeName: priceColor};
    NSMutableAttributedString* wholeNumberPart = [[NSMutableAttributedString alloc] initWithString:wholeNumber attributes:wholeNumberAttributes];
    NSAttributedString* fractionalNumberPart = [[NSAttributedString alloc] initWithString:fractionalNumber attributes:fractionalNumberAttributes];
    [wholeNumberPart appendAttributedString:fractionalNumberPart];
    return wholeNumberPart;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
