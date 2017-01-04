//
//  LSDPictureCell.h
//  UICollectionView基本使用(照片浏览)
//
//  Created by SelenaWong on 16/12/29.
//  Copyright © 2016年 SelenaWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSDPictureCell : UICollectionViewCell
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, weak) IBOutlet UIImageView *contentImageV;

@end
