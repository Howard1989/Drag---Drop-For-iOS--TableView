//
//  DDTableViewCell.m
//  DragDrop
//
//  Created by Haodan Huang on 9/2/13.
//  Copyright (c) 2013 Haodan Huang. All rights reserved.
//

#import "DDTableViewCell.h"

@implementation DDTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
