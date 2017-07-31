//
//  HSMenuBarShowDetailVC.m
//  Pods
//
//  Created by 胡晟 on 2017/6/18.
//
//

#import "HSMenuBarShowDetailVC.h"
#import "HSMenuCell.h"
#import "UIView+HSLayout.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kRowCount 3
#define kMargin 20
#define kCellH 30

@interface HSMenuBarShowDetailVC ()

@end

@implementation HSMenuBarShowDetailVC

static NSString * const reuseIdentifier = @"HSMenuCell";

-(void)setItems:(NSArray *)items
{
    
    _items = items;
    
    NSInteger rows = (_items.count + (kRowCount - 1)) / kRowCount;
    CGFloat height = rows * (kCellH + kMargin);
    self.collectionView.height = height;
    self.expectedHeight = height+kMargin-1;
    [self.collectionView reloadData];
}


-(instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = (kScreenWidth - kMargin * (kRowCount + 1)) / kRowCount;
    CGFloat height = kCellH;
    // 每一个items的默认大小
    flowLayout.itemSize = CGSizeMake(width, height);
    // 每行之间最小的距离
    flowLayout.minimumLineSpacing = kMargin;
    // 每一行中每个item间的最小的距离
    flowLayout.minimumInteritemSpacing = kMargin;
    // section里面内容的页边空白
    flowLayout.sectionInset = UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin);
    
    return [super initWithCollectionViewLayout:flowLayout];
    
}
-(instancetype)init
{
    return [self initWithCollectionViewLayout:[UICollectionViewLayout new]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
    UINib *nib = [UINib nibWithNibName:@"HSMenuCell" bundle:currentBundle];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
}



#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HSMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.menuLabel.text = (NSString *)self.items[indexPath.row];
    
    return cell;
}

@end
