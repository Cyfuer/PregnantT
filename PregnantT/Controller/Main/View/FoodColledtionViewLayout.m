//
//  FoodColledtionViewLayout.m
//  PregnantT
//
//  Created by iflashbuy_dev on 2016/12/19.
//  Copyright © 2016年 iflashbuy_dev. All rights reserved.
//

#import "FoodColledtionViewLayout.h"

@interface FoodColledtionViewLayout()

@property (nonatomic,strong) NSMutableArray *attrArray;

@property (nonatomic,strong) NSMutableArray *maxArray;

@end

@implementation FoodColledtionViewLayout

- (NSMutableArray *)attrArray{
    if (!_attrArray) {
        _attrArray = [NSMutableArray array];
    }
    return _attrArray;
    
}

- (NSMutableArray *)maxArray{
    if (!_maxArray) {
        _maxArray = [NSMutableArray array];
    }
    return _maxArray;
}

- (instancetype)init{
    if (self = [super init]) {
        
        _defaultColumnCount = 2;
        _defaultColumnSpacing = 10;
        _defaultRowSpacing = 10;
        _itemInsects = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return self;
}

#pragma mark -
- (void)prepareLayout{
    [super prepareLayout];
    
    [self.attrArray removeAllObjects];
    [self.maxArray removeAllObjects];
    
    
    for (NSInteger i=0; i<_defaultColumnCount; i++) {
        [self.maxArray addObject:@(_itemInsects.top)];
    }
    
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i=0; i<itemCount; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        [self.attrArray addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    
    NSInteger __block minHeightColumn = 0;
    NSInteger __block minHeight = [self.maxArray[minHeightColumn] floatValue];
    
//    NSLog(@"minHeight ========= %ld",minHeight);
    
    [self.maxArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat columnHeight = [(NSNumber *)obj floatValue];
        
//        NSLog(@"columnHeight ======= %f",columnHeight);
        
        if (minHeight > columnHeight) {
            minHeight = columnHeight;
            minHeightColumn = idx;
            
//            NSLog(@"columnColumn ====== %ld",idx);
        }
        
    }];
    
    CGFloat x;
    CGFloat y;
    CGFloat width;
    CGFloat height;
    
    
    height = 160+(arc4random_uniform(5) * 40);
    width = ([UIScreen mainScreen].bounds.size.width - _itemInsects.right - _itemInsects.left - _defaultColumnSpacing *(_defaultColumnCount-1))/_defaultColumnCount;
    
    x = _itemInsects.left + minHeightColumn * (width + _defaultColumnSpacing);
    
    y = minHeight;
    
    if (y != _itemInsects.top) {
        y += _defaultRowSpacing;
    }
    
    [attributes setFrame:CGRectMake(x, y, width, height)];
    self.maxArray[minHeightColumn] = @(CGRectGetMaxY(attributes.frame));
    return attributes;
}

- (CGSize)collectionViewContentSize{
    
    
    NSInteger __block MaxHeight = 0;
    
    [self.maxArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat columnHeight = [(NSNumber *)obj floatValue];
        
//        NSLog(@"columnHeight ======= %f",columnHeight);
        
        if (MaxHeight < columnHeight) {
            MaxHeight = columnHeight;
        }
        
    }];
    
    return CGSizeMake(0, MaxHeight + _defaultRowSpacing);
}


//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
//{
//    return YES;
//}

@end
