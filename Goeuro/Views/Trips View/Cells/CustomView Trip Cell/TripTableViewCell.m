//
//  TripTableViewCell.m
//  Goeuro
//
//  Created by Mahmoud Eldesouky on 1/15/17.
//  Copyright © 2017 Mahmoud Eldesouky. All rights reserved.
//

#import "TripTableViewCell.h"


@implementation TripTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupView];

}

- (void)setupView{
    self.containerView.layer.borderWidth = 1;
    self.containerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.containerView.layer.cornerRadius = 7;
    self.containerView.clipsToBounds = YES;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
