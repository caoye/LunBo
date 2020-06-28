//
//  ViewController.m
//  LunBo
//
//  Created by caoye on 2020/1/6.
//  Copyright © 2020 caoye. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewCell.h"
#import "CustomViewLayout.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *colorArray;
@property (nonatomic, strong) CustomViewLayout *layout;

@end

static NSUInteger multiple = 2;

static NSString *reuseIdentifier = @"MyCollectionViewCell";

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableArray *datas = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    NSMutableArray *colors = [[NSMutableArray alloc] initWithObjects:
                  [UIColor redColor],
                  [UIColor yellowColor],
                  [UIColor blueColor],
                  [UIColor grayColor],
                  [UIColor orangeColor],
                  [UIColor greenColor],
                  [UIColor lightGrayColor],
                  [UIColor cyanColor],
                  [UIColor darkGrayColor],
                  [UIColor magentaColor],

                  nil];

    _dataArray = [datas mutableCopy];

    _colorArray = [colors mutableCopy];

    _layout = [[CustomViewLayout alloc] init];
    _layout.itemSize = CGSizeMake(200, 260);
    _layout.itemCenterSpace = _layout.itemSize.width/4;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 300) collectionViewLayout:_layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
     self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    // 初始化位置
    [_layout scrollToIndex:_dataArray.count*roundf(multiple/2) animated:NO];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.lable.text = _dataArray[indexPath.row%_dataArray.count];
    cell.lable1.text = [NSString stringWithFormat:@"%@", @(indexPath.row%_dataArray.count)];
    
    cell.contentView.backgroundColor = _colorArray[indexPath.row%_dataArray.count];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count*multiple;
}

#pragma mark <UICollectionViewDataSource>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    if (cell.alpha >= 1 && cell.alpha <= 0.9) {
        NSLog(@"click %ld", indexPath.row);
    } else {
        [_layout scrollToIndex:indexPath.row animated:YES];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_layout scrollToIndex:[_layout getPageIndex] animated:YES];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    [_layout scrollToIndex:[_layout getPageIndex] animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat index = roundf((_collectionView.contentOffset.x + _collectionView.contentInset.left) / _layout.itemCenterSpace);
    if (index >= _dataArray.count*multiple-1 || index <=0) {
        [_layout scrollToIndex:_dataArray.count*roundf(multiple/2) animated:NO];
    }
}

@end
