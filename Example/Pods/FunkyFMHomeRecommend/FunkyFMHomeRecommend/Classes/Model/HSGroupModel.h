//
//  HSGroupModel.h
//  FunkyFMHome
//
//  Created by 胡晟 on 2017/7/31.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSItemInCellModel.h"
#import "HSSpecialColumnModel.h"

@class HSLiveModel;
@class HSTuiguangModel;



typedef enum{
    CellTypeList3,
    CellTypeList2,
    CellTypeList1
}CellType;

@interface HSGroupModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL hasMore;

@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) NSArray <HSLiveModel *>*liveMs;
@property (nonatomic, strong) NSArray <HSTuiguangModel *>*tuiguangMs;

@property (nonatomic, assign) CellType cellType;
@property (nonatomic, assign) NSInteger sortID;

@end
