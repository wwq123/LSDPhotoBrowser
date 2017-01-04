//
//  LSDPictureCell.m
//  UICollectionView基本使用(照片浏览)
//
//  Created by SelenaWong on 16/12/29.
//  Copyright © 2016年 SelenaWong. All rights reserved.
//

#import "LSDPictureCell.h"

@interface LSDPictureCell ()
@end

@implementation LSDPictureCell
- (void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    self.contentImageV.image = [UIImage imageNamed:imageName];
}
@end
