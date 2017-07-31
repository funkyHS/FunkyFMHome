//
//  UITableView+HSEmptyData.m
//  Pods
//
//  Created by 胡晟 on 2017/6/14.
//
//

#import "UITableView+HSEmptyData.h"

@implementation UITableView (HSEmptyData)


- (void)tableViewDisplayWithMessage:(NSString *)message ifNecessaryForRowCount:(NSUInteger)rowCount {
    
    if (rowCount == 0) {
        
        UILabel *messageLabel = [UILabel new];
        messageLabel.text = message;
        messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        messageLabel.textColor = [UIColor lightGrayColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.numberOfLines = 0;
        [messageLabel sizeToFit];
        self.backgroundView = messageLabel;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    } else {
        self.backgroundView = nil;
    }
    
    
}


@end
