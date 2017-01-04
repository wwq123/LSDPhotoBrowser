//
//  LSDPictureView.h
//  UICollectionView基本使用(照片浏览)
//
//  Created by SelenaWong on 16/12/29.
//  Copyright © 2016年 SelenaWong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSDPicture, LSDPictureView;


@protocol LSDPictureViewDelegate <NSObject>
@optional
- (void)pictureView:(LSDPictureView *)pictureView didSelectedItemPicture:(LSDPicture *)picture;
@end

typedef void(^didSelectedItemBlock)(LSDPicture *pic);

@interface LSDPictureView : UIView
/**模型数组*/
@property (nonatomic, strong) NSArray <LSDPicture *>*pictures;
/**尺寸*/
@property (nonatomic, assign) CGSize itemCellSize;
/**边距*/
@property (nonatomic, assign) UIEdgeInsets edgeInsets;
/**item间距*/
@property (nonatomic, assign) CGFloat itemSpace;
/**block回调*/
@property (nonatomic, strong) didSelectedItemBlock didSelectedItemBlock;
/**代理*/
@property (nonatomic, weak) id<LSDPictureViewDelegate> delegate;

- (instancetype)initWithPictures:(NSArray *)pictures;
+ (instancetype)pictureViewWithPictures:(NSArray *)pictures;
@end
