//
//  HSAdPicTextCell.m
//  FunkyFMHome
//
//  Created by 胡晟 on 2017/7/31.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import "HSAdPicTextCell.h"
#import "HSScrollPicView.h"
#import "UIImageView+HSExtension.h"
#import "HSAdPicModel.h"


#define kCellMargin 10

@interface HSAdPicTextCell ()<HSScrollPicViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet HSScrollPicView *adPicView;
@property (weak, nonatomic) IBOutlet UILabel *upTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightTitleLabel;


@end

@implementation HSAdPicTextCell

static NSString *const cellID = @"CellTypeList1";

+ (instancetype)cellWithTableView: (UITableView *)tableView {
    
    HSAdPicTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        
        cell =  [[NSBundle bundleForClass:self] loadNibNamed:@"HSAdPicTextCell" owner:nil options:nil].firstObject;
    }
    return cell;
    
}

-(void)awakeFromNib {
    [super awakeFromNib];
    
    [self.adPicView setLoadBlock:^(UIImageView *imageView, NSURL *url){
        [imageView setURLImageWithURL:url progress:nil complete:nil];
        
    }];
    self.adPicView.delegate = self;
}

-(void)setGroupM:(HSGroupModel *)groupM
{
    _groupM = groupM;
    self.titleLabel.text = groupM.title;
    
    NSMutableArray *picMs = [NSMutableArray array];
    
    NSLog(@"%@", groupM.liveMs);
    
    if (groupM.liveMs.count > 0) {
        for (HSLiveModel *liveM in groupM.liveMs) {
            HSAdPicModel *picM = [[HSAdPicModel alloc] init];
            picM.liveM = liveM;
            [picMs addObject:picM];
        }
    }else if (groupM.tuiguangMs.count > 0)
    {
        for (HSTuiguangModel *tuiguangM in groupM.tuiguangMs) {
            HSAdPicModel *picM = [[HSAdPicModel alloc] init];
            picM.tuiguangM = tuiguangM;
            [picMs addObject:picM];
        }
    }
    
    
    
    self.adPicView.picModels = picMs;
    
}
-(void)setFrame:(CGRect)frame
{
    frame.size.height -= kCellMargin;
    [super setFrame:frame];
}

- (IBAction)more {
    
}

-(void)adPicViewDidSelectedPicModel:(HSAdPicModel *)picM
{
    
    
    HSLiveModel *liveM = picM.liveM;
    if (liveM != nil) {
        self.upTitleLabel.text = liveM.name;
        self.detailTitleLabel.text = liveM.shortDescription;
        double count = [liveM.playCount doubleValue];
        if (count > 10000) {
            count = count / 10000.0;
            self.rightTitleLabel.text = [NSString stringWithFormat:@"%.01f万人参与", count];
        }else {
            self.rightTitleLabel.text = [NSString stringWithFormat:@"%zd人参与", count];
        }
    }
    
    HSTuiguangModel *tuiguangM = picM.tuiguangM;
    if (tuiguangM != nil) {
        self.upTitleLabel.text = tuiguangM.name;
        self.detailTitleLabel.text = tuiguangM.Description;
        
    }
    
    
}


@end
