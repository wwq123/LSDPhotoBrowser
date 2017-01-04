//
//  LSDFlowLayout.m
//  UICollectionView基本使用(照片浏览)
//
//  Created by SelenaWong on 16/12/29.
//  Copyright © 2016年 SelenaWong. All rights reserved.
//

#import "LSDFlowLayout.h"

@implementation LSDFlowLayout
/*
 自定义流水布局，常用的5个方法:
 
 //collectionView第一次布局,collectionView刷新的时候也会调用(比如当方法3返回YES)
1. - (void)prepareLayout;
 
 //可以一次性返回所有cell的尺寸，也可以返回指定区域的cell尺寸
 //UICollectionViewLayoutAttributes:确定cell的尺寸
 //一个UICollectionViewLayoutAttributes对象对应一个cell，拿到UICollectionViewLayoutAttributes对象就相当于拿到cell
2. - (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect;
 
 //刷新布局,在滚动过程中是否重新刷新布局,默认是NO
3. - (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds;
 
 //确定最终偏移量，当用户手指一松开就会调用
4. - (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity;
 
 //计算collectionView滚动范围
5. - (CGSize)collectionViewContentSize;
 */

- (void)prepareLayout{
    [super prepareLayout];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *array =  [super layoutAttributesForElementsInRect:self.collectionView.bounds];
    
    for (UICollectionViewLayoutAttributes *attr in array) {
        // 2.计算中心点距离
        CGFloat delta = fabs((attr.center.x - self.collectionView.contentOffset.x) - self.collectionView.bounds.size.width * 0.5);
        // 3.计算比例
        CGFloat scale = 1 - delta / (self.collectionView.bounds.size.width * 0.5) * 0.25;
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return array;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    // 拖动比较快 最终偏移量 不等于 手指离开时偏移量
    CGFloat collectionW = self.collectionView.bounds.size.width;
    // 最终偏移量
    CGPoint targetP = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    // 0.获取最终显示的区域
    CGRect targetRect = CGRectMake(targetP.x, 0, collectionW, MAXFLOAT);
    // 1.获取最终显示的cell
    NSArray *attrs = [super layoutAttributesForElementsInRect:targetRect];
    // 获取最小间距
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        // 获取距离中心点距离:注意:应该用最终的x
        CGFloat delta = (attr.center.x - targetP.x) - self.collectionView.bounds.size.width * 0.5;
        if (fabs(delta) < fabs(minDelta)) {
            minDelta = delta;
        }
    }
    // 移动间距
    targetP.x += minDelta;
    if (targetP.x < 0) {
        targetP.x = 0;
    }    
    return targetP;
}

- (CGSize)collectionViewContentSize{
   return  [super collectionViewContentSize];
}
@end
