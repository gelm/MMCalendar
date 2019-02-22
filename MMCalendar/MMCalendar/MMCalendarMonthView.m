//
//  MMCalendarMonthView.m
//  MMCalendar
//
//  Created by 各连明 on 2019/2/21.
//  Copyright © 2019年 GELM. All rights reserved.
//

#import "MMCalendarMonthView.h"
#import "MMCalendarDayCell.h"
#import "MMCalendarDayItem.h"

@interface MMCalendarMonthView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *rows;

@end

@implementation MMCalendarMonthView

+ (instancetype)initWithFrame:(CGRect)frame dataSource:(id<MMCalendarMonthDataSource>)dataSource {
    MMCalendarMonthView *monthView = [[MMCalendarMonthView alloc]initWithFrame:frame];
    monthView.dataSource = dataSource;
    return monthView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _rows = [NSMutableArray array];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat itemWidth = CGRectGetWidth(self.bounds)/7;
        flowLayout.itemSize = CGSizeMake(itemWidth, 44);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[MMCalendarDayCell class] forCellWithReuseIdentifier:@"MMCalendarDayCell"];
        [self addSubview:_collectionView];
    }
    return self;
}

- (void)setCurrentDate:(NSDate *)currentDate {
    _currentDate = currentDate;
    if(_dataSource && [_dataSource respondsToSelector:@selector(calendarMonthView:itemsWithDate:)]){
        [_rows setArray:[_dataSource calendarMonthView:self itemsWithDate:currentDate]];
        [_collectionView reloadData];
    }
}

- (void)reloadData {
    if(_delegate && [_delegate respondsToSelector:@selector(calendarMonthView:refreshWithItems:)]){
        [_delegate calendarMonthView:self refreshWithItems:_rows];
        [_collectionView reloadData];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _rows.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MMCalendarDayCell *cell = (MMCalendarDayCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MMCalendarDayCell" forIndexPath:indexPath];
    cell.item = _rows[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MMCalendarDayItem *item = _rows[indexPath.item];
    if(_delegate && [_delegate respondsToSelector:@selector(calendarMonthView:didSelectedItem:)]){
        [_delegate calendarMonthView:self didSelectedItem:item];
    }
}

@end
