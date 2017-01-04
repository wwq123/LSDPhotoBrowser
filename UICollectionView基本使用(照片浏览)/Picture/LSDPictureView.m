//
//  LSDPictureView.m
//  UICollectionView基本使用(照片浏览)
//
//  Created by SelenaWong on 16/12/29.
//  Copyright © 2016年 SelenaWong. All rights reserved.
//

#import "LSDPictureView.h"
#import "LSDFlowLayout.h"
#import "LSDPictureCell.h"
#import "LSDPicture.h"
#import "XLPhotoBrowser.h"

@interface LSDPictureView () <UICollectionViewDataSource,UICollectionViewDelegate,XLPhotoBrowserDelegate,XLPhotoBrowserDatasource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) LSDFlowLayout *layout;
@property (nonatomic, strong) NSMutableArray *images;
@end

static NSString *const ID = @"LSDPictureCell";
@implementation LSDPictureView

+ (instancetype)pictureViewWithPictures:(NSArray *)pictures{
    return [[self alloc] initWithPictures:pictures];
}

- (instancetype)initWithPictures:(NSArray *)pictures{
    if (self = [super init]) {
        self.pictures = pictures;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    [self addSubview:self.collectionView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.pictures.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LSDPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    LSDPicture *pic = self.pictures[indexPath.item];
    cell.imageName = pic.name;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LSDPicture *pic = self.pictures[indexPath.item];
    
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    //浏览图片
    XLPhotoBrowser *browser = [XLPhotoBrowser showPhotoBrowserWithImages:self.images currentImageIndex:indexPath.item];
    browser.delegate = self;
    browser.datasource = self;
    browser.browserStyle = XLPhotoBrowserStyleSimple; // 微博样式
    
    //回调
    if ([self.delegate respondsToSelector:@selector(pictureView:didSelectedItemPicture:)]) {
        [_delegate pictureView:self didSelectedItemPicture:pic];
    }
    
    if (self.didSelectedItemBlock) {
        self.didSelectedItemBlock(pic);
    }
}

#pragma mark - XLPhotoBrowserDelegate
/**
 *  返回浏览到哪张图片的索引
 *
 *  @param browser 浏览器
 *  @param index   位置索引
 *
 */
- (void)photoBrowser:(XLPhotoBrowser *)browser didScrollToIndex:(NSInteger)index{
    NSLog(@"scroll --- %ld",index);
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

#pragma mark - XLPhotoBrowserDataSource
/**
 *  返回指定位置图片的UIImageView,用于做图片浏览器弹出放大和消失回缩动画等
 *  如果没有实现这个方法,没有回缩动画,如果传过来的view不正确,可能会影响回缩动画效果
 *
 *  @param browser 浏览器
 *  @param index   位置索引
 *
 *  @return 展示图片的容器视图,如UIImageView等
 */
- (UIView *)photoBrowser:(XLPhotoBrowser *)browser sourceImageViewForIndex:(NSInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    LSDPictureCell *item = (LSDPictureCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    return item.contentImageV;
}

#pragma mark = 懒加载
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor greenColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LSDPictureCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
    }
    return _collectionView;
}

- (LSDFlowLayout *)layout{
    if (_layout == nil) {
        _layout = [[LSDFlowLayout alloc] init];
        _layout.itemSize = CGSizeZero;
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.minimumLineSpacing = 10.f;
        _layout.sectionInset = UIEdgeInsetsZero;
    }
    return _layout;
}

- (NSMutableArray *)images{
    if (_images == nil) {
        _images = [NSMutableArray array];
        for (LSDPicture *pic in self.pictures) {
            UIImage *image = [UIImage imageNamed:pic.name];
            [_images addObject:image];
        }
    }
    return _images;
}

- (void)setItemCellSize:(CGSize)itemCellSize{
    _itemCellSize = itemCellSize;
    self.layout.itemSize = itemCellSize;
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets{
    _edgeInsets = edgeInsets;
    self.layout.sectionInset = edgeInsets;
}

- (void)setItemSpace:(CGFloat)itemSpace{
    _itemSpace= itemSpace;
    self.layout.minimumLineSpacing = itemSpace;
}

- (NSArray <LSDPicture *>*)pictures{
    return _pictures;
}
@end
