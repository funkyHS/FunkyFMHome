//
//  HSSpecialColumnCell.m
//  FunkyFMHome
//
//  Created by 胡晟 on 2017/7/31.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import "HSSpecialColumnCell.h"
#import "HSCellInCell.h"

#define kCellMargin 10

@interface HSSpecialColumnCell()<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HSSpecialColumnCell

static NSString *const cellID = @"CellTypeList2";


+ (instancetype)cellWithTableView: (UITableView *)tableView {
    
    HSSpecialColumnCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        
        cell = [[NSBundle bundleForClass:self] loadNibNamed:@"HSSpecialColumnCell" owner:nil options:nil].firstObject;
    }
    return cell;
    
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= kCellMargin;
    [super setFrame:frame];
}


-(void)awakeFromNib
{
    [super awakeFromNib];
    self.tableView.rowHeight = 80;
    self.tableView.scrollEnabled = NO;
}

-(void)setGroupM:(HSGroupModel *)groupM
{
    _groupM = groupM;
    self.titleLabel.text = groupM.title;
    [self.tableView reloadData];
    
}

- (IBAction)more {
}



#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groupM.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HSCellInCell *cell = [HSCellInCell cellWithTableView:tableView];
    
    HSSpecialColumnModel *specialM = self.groupM.list[indexPath.row];
    if (![specialM isKindOfClass:[HSSpecialColumnModel class]]) {
        return nil;
    }
    
    cell.specialColumnM = specialM;
    
    return cell;
    
}


@end
