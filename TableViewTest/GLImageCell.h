//
//  GLImageCell.h
//  TableViewTest
//
//  Created by zty on 16/8/23.
//  Copyright © 2016年 zty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLImageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIImageView *OtherImage;
@property (weak, nonatomic) IBOutlet UIImageView *myImage;
@property (weak, nonatomic) IBOutlet UILabel *labelText;

@end
