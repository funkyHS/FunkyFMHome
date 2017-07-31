//
//  UITableView+HSEmptyData.h
//  Pods
//
//  Created by 胡晟 on 2017/6/14.
//
//

#import <UIKit/UIKit.h>

@interface UITableView (HSEmptyData)

- (void)tableViewDisplayWithMessage:(NSString *)message ifNecessaryForRowCount:(NSUInteger)rowCount;

@end
