//
//  GLImageCell.m
//  TableViewTest
//
//  Created by zty on 16/8/23.
//  Copyright © 2016年 zty. All rights reserved.
//

#import "GLImageCell.h"

@implementation GLImageCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"GLImageCell" owner:nil options:nil]firstObject];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
