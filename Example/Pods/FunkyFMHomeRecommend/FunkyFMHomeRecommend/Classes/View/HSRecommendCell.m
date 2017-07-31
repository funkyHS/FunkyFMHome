//
//  HSRecommendCell.m
//  FunkyFMHome
//
//  Created by 胡晟 on 2017/7/31.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import "HSRecommendCell.h"
#import "HSItemCell.h"
#import "HSRecommendTVC.h"
//#import "HSRecommendMoreTVC.h"// 更多
#import "UIView+HSNib.h"
#import "Base.h"
//#import "HomeRecommendDefine.h"

#define kCellCountInRow 3
#define kCellMargin 10

@interface HSRecommendCell()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;



@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation HSRecommendCell

static NSString *const itemID = @"itemID";
static NSString *const cellID = @"CellTypeList3";


+ (instancetype)cellWithTableView: (UITableView *)tableView {
    
    HSRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        
        cell = [[[NSBundle bundleForClass:self] loadNibNamed:@"HSRecommendCell" owner:nil options:nil] firstObject];
    }
    return cell;
    
}



- (IBAction)more:(UIButton *)button {
    
    
}



-(void)setGroupM:(HSGroupModel *)groupM {
    _groupM = groupM;
    self.titleLabel.text = groupM.title;
    [self.collectionView reloadData];
}


-(void)setFrame:(CGRect)frame {
    frame.size.height -= kCellMargin;
    [super setFrame:frame];
}


-(void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat width = (kScreenWidth - (kCellCountInRow + 1) * kCellMargin) / kCellCountInRow;
    CGFloat height = width * 1.6;
    self.flowLayout.itemSize = CGSizeMake(width, height);
    self.flowLayout.minimumInteritemSpacing = kCellMargin - 0.1;
    self.flowLayout.minimumLineSpacing = kCellMargin;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, kCellMargin, 0, kCellMargin);
    
    UINib *nib = [UINib nibWithNibName:@"HSItemCell" bundle:[NSBundle bundleForClass:[self class]]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:itemID];
    
}



#pragma mark - collectionView数据源方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.groupM.list.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HSItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemID forIndexPath:indexPath];
    
    HSItemInCellModel *model = self.groupM.list[indexPath.row];
    cell.itemInCellModel = model;
    
    return cell;
    
}


@end
