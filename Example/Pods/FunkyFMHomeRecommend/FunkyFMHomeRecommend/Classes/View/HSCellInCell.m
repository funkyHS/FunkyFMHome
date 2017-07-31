//
//  HSCellInCell.m
//  FunkyFMHome
//
//  Created by 胡晟 on 2017/7/31.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import "HSCellInCell.h"
#import "UIImageView+WebCache.h"

@interface HSCellInCell()

@property (weak, nonatomic) IBOutlet UIImageView *specialIcon;
@property (weak, nonatomic) IBOutlet UILabel *topTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *middleTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomTitleLabel;

@end

@implementation HSCellInCell

static NSString *const cellID = @"cellInCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    HSCellInCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        
        cell = [[NSBundle bundleForClass:self] loadNibNamed:@"HSCellInCell" owner:nil options:nil].firstObject;
    }
    return cell;
}

-(void)setSpecialColumnM:(HSSpecialColumnModel *)specialColumnM {
    
    _specialColumnM = specialColumnM;
    NSURL *url = [NSURL URLWithString:specialColumnM.coverPath];
    [self.specialIcon sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]];
    self.topTitleLabel.text = specialColumnM.title;
    self.middleTitleLabel.text = specialColumnM.subtitle;
    self.bottomTitleLabel.text = specialColumnM.footnote;
    
}

@end
