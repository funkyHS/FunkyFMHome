//
//  HSMenuCell.m
//  Pods
//
//  Created by 胡晟 on 2017/6/18.
//
//

#import "HSMenuCell.h"

@implementation HSMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 2;
    self.clipsToBounds = YES;
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected) {
        self.menuLabel.textColor = [UIColor redColor];
        self.layer.borderColor = [UIColor redColor].CGColor;

        //self.backgroundColor = [UIColor redColor];
    }else {
        
        self.menuLabel.textColor = [UIColor lightGrayColor];
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        //self.backgroundColor = [UIColor colorWithRed:160 / 255.0 green:160 / 255.0 blue:160 / 255.0 alpha:0.4];
    }
    
}

@end
