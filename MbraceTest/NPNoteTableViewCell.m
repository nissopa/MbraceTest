//
//  NPNoteTableViewCell.m
//  MbraceTest
//
//  Created by Nissim Pardo on 7/8/14.
//  Copyright (c) 2014 androdogs. All rights reserved.
//

#import "NPNoteTableViewCell.h"

@implementation NPNoteTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
