//
//  HSSegmentBar.m
//  FunkySegmentBar
//
//  Created by 胡晟 on 2017/6/12.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import "HSSegmentBar.h"
#import "UIView+HSLayout.h"
#import "HSMenuBarShowDetailVC.h"
#import "HSSegmentRightLeftBtn.h"

//#define kShowMoreBtnW (self.bounds.size.height + 30)


@interface HSSegmentBar ()<UICollectionViewDelegate>
{
    // 记录最后一次点击的按钮
    UIButton *_lastBtn;
}
/** 内容承载视图 */
@property (nonatomic, weak) UIScrollView *contentView;

/** 添加的按钮数据 */
@property (nonatomic, strong) NSMutableArray <UIButton *>*itemBtns;

/** 指示器 */
@property (nonatomic, weak) UIView *indicatorView;

/** 选项卡显示配置 */
@property (nonatomic, strong) HSSegmentBarConfig *config;

@property (nonatomic, strong) HSSegmentRightLeftBtn *showMoreBtn;
@property (nonatomic, nonnull, strong) UIView *coverView;
@property (nonatomic, strong) HSMenuBarShowDetailVC *showDetailVC;


@end

@implementation HSSegmentBar


#pragma mark - 布局
- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
    
    
    if (!self.config.isShowMore) {
        self.contentView.frame = self.bounds;
        self.showMoreBtn.width = -1;
    }else {
        self.contentView.frame = CGRectMake(0, 0, self.width - self.config.showMoreBtnW, self.height);
        self.showMoreBtn.frame = CGRectMake(self.width - self.config.showMoreBtnW, 0, self.config.showMoreBtnW, self.height);
    }
    
    
    
    CGFloat totalBtnWidth = 0;// 所有按钮的宽度总和
    CGFloat lastX = 0; // 记录按钮与间隙的总长度
    
    
    if (self.config.barBtnW != 0) {
        // 外界规定了按钮的宽度
        
        for (UIButton *btn in self.itemBtns) {
            
            [btn sizeToFit];
            btn.height = self.height - self.config.indicatorHeight;
            btn.width = self.config.barBtnW;
            
            btn.y = 0;
            btn.x = lastX;
            lastX += btn.width;
        }
        
        
    }else{
        // 按钮的宽度根据title自适应
        
        for (UIButton *btn in self.itemBtns) {
            [btn sizeToFit];
            totalBtnWidth += btn.width;
        }
        
        // 计算margin
        CGFloat caculateMargin = (self.width - totalBtnWidth) / (self.items.count + 1);
        if (caculateMargin < self.config.limitMargin) {
            caculateMargin = self.config.limitMargin;
        }
        
        lastX = caculateMargin;
        
        for (UIButton *btn in self.itemBtns) {
            // w, h
            [btn sizeToFit];
            // y 0
            // x, y,
            btn.y = 0;
            
            btn.x = lastX;
            
            lastX += btn.width + caculateMargin;
            
            btn.height = self.height - self.config.indicatorHeight;
            
            btn.width += 3;
        }
    }
    
    
    
    self.contentView.contentSize = CGSizeMake(lastX, 0);
    
    if (self.itemBtns.count == 0) {
        return;
    }
    UIButton *btn = self.itemBtns[self.selectIndex];
    self.indicatorView.width = btn.width + self.config.indicatorExtraW * 2;
    self.indicatorView.centerX = btn.centerX;
    self.indicatorView.height = self.config.indicatorHeight;
    self.indicatorView.y = self.height - self.indicatorView.height;
}

#pragma mark - UI视图
// 快速创建选项卡控件
+ (instancetype)segmentBarWithFrame: (CGRect)frame {
    
    HSSegmentBar *segmentBar = [[HSSegmentBar alloc] initWithFrame:frame];
    
    // 添加内容承载视图
    return segmentBar;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = self.config.segmentBarBackColor;
    }
    return self;
}


// 更改选项卡的样式
- (void)updateWithConfig: (void(^)(HSSegmentBarConfig *config))configBlock {
    
    if (configBlock) {
        configBlock(self.config);
    }
    
    // 按照当前的 self.config 进行刷新
    self.backgroundColor = self.config.segmentBarBackColor;
    
    for (UIButton *btn in self.itemBtns) {
        [btn setTitleColor:self.config.itemNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemSelectColor forState:UIControlStateSelected];
        if (btn != _lastBtn) {
            btn.titleLabel.font = self.config.segNormalFont;
        }else {
            btn.titleLabel.font = self.config.segSelectedFont;
        }
    }
    
    // 指示器
    self.indicatorView.backgroundColor = self.config.indicatorColor;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    
    if (self.config.isShowMore) {
        self.showDetailVC.items = _items;
        self.showDetailVC.collectionView.height = 0;
        self.selectIndex = 0;
        self.showMoreBtn.hidden = NO;
    }
}


#pragma mark - event response
- (void)btnClick: (UIButton *)btn {
    
    if ([self.delegate respondsToSelector:@selector(segmentBar:didSelectIndex:fromIndex:)]) {
        [self.delegate segmentBar:self didSelectIndex:btn.tag fromIndex:_lastBtn.tag];
    }
    
    _selectIndex = btn.tag;
    
    _lastBtn.selected = NO;
    _lastBtn.titleLabel.font = self.config.segNormalFont;
    btn.selected = YES;
    _lastBtn = btn;
    btn.titleLabel.font = self.config.segSelectedFont;
    //[btn sizeToFit];
    
    
    if (self.config.isShowMore) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_lastBtn.tag inSection:0];
        [self.showDetailVC.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        [self hideDetailPane];
    }
    
    
    [UIView animateWithDuration:0.1 animations:^{
        self.indicatorView.width = btn.width + self.config.indicatorExtraW * 2;
        self.indicatorView.centerX = btn.centerX;
    }];
    
    
    // 1. 县滚动到btn的位置
    
    CGFloat scrollX = btn.centerX - self.contentView.width * 0.5;
    
    if (scrollX < 0) {
        scrollX = 0;
    }
    if (scrollX > self.contentView.contentSize.width - self.contentView.width) {
        scrollX = self.contentView.contentSize.width - self.contentView.width;
    }
    
    [self.contentView setContentOffset:CGPointMake(scrollX, 0) animated:YES];
    
}

- (void)showOrHide: (UIButton *)btn {
    
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self showDetailPane];
    }else {
        [self hideDetailPane];
    }
    
}

- (void)showDetailPane {
    
    self.showMoreBtn.selected = YES;
    self.showDetailVC.collectionView.hidden = NO;
    self.coverView.hidden = NO;
    self.coverView.height = [UIScreen mainScreen].bounds.size.height;

    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.showDetailVC.collectionView.height = self.showDetailVC.expectedHeight + 30;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 animations:^{
            self.showDetailVC.collectionView.height = self.showDetailVC.expectedHeight;
        }];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_lastBtn.tag inSection:0];
        [self.showDetailVC.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    }];

    
}

- (void)hideDetailPane {
    
    self.showMoreBtn.selected = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.showDetailVC.collectionView.height = 0;
    } completion:^(BOOL finished) {
        self.coverView.height = 0;
        self.coverView.hidden = YES;
        self.showDetailVC.collectionView.hidden = YES;
    }];
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectIndex = indexPath.row;
    [self hideDetailPane];
    
}


#pragma mark - setters & getters
- (void)setSelectIndex:(NSInteger)selectIndex {
    // 数据过滤
    if (self.itemBtns.count == 0 || selectIndex < 0 || selectIndex > self.itemBtns.count - 1) {
        return;
    }
    _selectIndex = selectIndex;
    UIButton *btn = self.itemBtns[selectIndex];
    [self btnClick:btn];
}

// 根据外界设置的数据源，动态创建并加载bar视图
- (void)setItems:(NSArray<NSString *> *)items {
    
    _items = items;
    
    
    if (self.config.isShowMore) {
        self.showDetailVC.items = _items;
        self.showDetailVC.collectionView.height = 0;
    }
    
    // 删除之前添加过多额组件
    [self.itemBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemBtns = nil;
    
    
    // 根据所有的选项数据源， 创建Button, 添加到内容视图
    for (NSString *item in items) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = self.itemBtns.count;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [btn setTitleColor:self.config.itemNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.config.segNormalFont;
        [btn setTitle:item forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        [self.itemBtns addObject:btn];
    }
    
    // 手动刷新布局
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    
}

- (NSMutableArray<UIButton *> *)itemBtns {
    if (!_itemBtns) {
        _itemBtns = [NSMutableArray array];
    }
    return _itemBtns;
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        CGFloat indicatorH = self.config.indicatorHeight;
        UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - indicatorH, 0, indicatorH)];
        indicatorView.backgroundColor = self.config.indicatorColor;
        [self.contentView addSubview:indicatorView];
        _indicatorView = indicatorView;
    }
    return _indicatorView;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        //scrollView.backgroundColor = [UIColor blueColor];
        [self addSubview:scrollView];
        _contentView = scrollView;
    }
    return _contentView;
}
// 选项卡的配置项
- (HSSegmentBarConfig *)config {
    if (!_config) {
        _config = [HSSegmentBarConfig defaultConfig];
    }
    return _config;
}

- (HSMenuBarShowDetailVC *)showDetailVC {
    if (!_showDetailVC) {
        _showDetailVC = [[HSMenuBarShowDetailVC alloc] init];
        _showDetailVC.collectionView.delegate = self;
    }
    if (_showDetailVC.collectionView.superview != self.superview) {
        _showDetailVC.collectionView.frame = CGRectMake(0, self.y + self.height, [UIScreen mainScreen].bounds.size.width, 0);
        [self.superview addSubview:_showDetailVC.collectionView];
    }
    
    return _showDetailVC;
}

- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, self.y + self.height, [UIScreen mainScreen].bounds.size.width, 0)];
        _coverView.backgroundColor = [UIColor colorWithRed:55 / 255.0 green:55 / 255.0 blue:55 / 255.0 alpha:0.4];
        UITapGestureRecognizer *gester = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideDetailPane)];
        [_coverView addGestureRecognizer:gester];
    }
    if (!_coverView.superview) {
        [self.superview insertSubview:_coverView belowSubview:self.showDetailVC.collectionView];
    }
    return _coverView;
}

- (HSSegmentRightLeftBtn *)showMoreBtn {
    if (!_showMoreBtn) {
        
        NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
        NSString *sourcePath = [currentBundle.infoDictionary[@"CFBundleName"] stringByAppendingString:@".bundle"];
        NSString *showImgPath = [currentBundle pathForResource:@"icon_radio_show@2x" ofType:@".png" inDirectory:sourcePath];
        UIImage *showImage = [UIImage imageWithContentsOfFile:showImgPath];
        
        NSString *hideImgPath = [currentBundle pathForResource:@"icon_radio_hide@2x" ofType:@".png" inDirectory:sourcePath];
        UIImage *hideImage = [UIImage imageWithContentsOfFile:hideImgPath];
        
        _showMoreBtn = [[HSSegmentRightLeftBtn alloc] init];
        [_showMoreBtn setTitle:@"更多" forState:UIControlStateNormal];
        [_showMoreBtn setImage:showImage forState:UIControlStateNormal];
        //        _showMoreBtn.layer.borderColor = [[UIColor grayColor] CGColor];
        //        _showMoreBtn.layer.borderWidth = 1;
        [_showMoreBtn setTitle:@"收起" forState:UIControlStateSelected];
        [_showMoreBtn setImage:hideImage forState:UIControlStateSelected];
        _showMoreBtn.imageView.contentMode = UIViewContentModeCenter;
        [_showMoreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        //        _showMoreBtn.backgroundColor = [UIColor greenColor];
        _showMoreBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        // 添加分割线
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 8, 1, 20)];
        line.backgroundColor = [UIColor lightGrayColor];
        [_showMoreBtn addSubview:line];
        _showMoreBtn.hidden = YES;

        
        [_showMoreBtn addTarget:self action:@selector(showOrHide:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_showMoreBtn];
    }
    return _showMoreBtn;
}

@end
