//
//  ViewController.m
//  UICollectionView基本使用(照片浏览)
//
//  Created by SelenaWong on 16/12/29.
//  Copyright © 2016年 SelenaWong. All rights reserved.
//

#import "ViewController.h"
#import "LSDPictureView.h"
#import "LSDPicture.h"
#define ItemSize CGSizeMake(100, 120)
#define picViewW self.view.bounds.size.width
#define ItemSpace 10.f
@interface ViewController () <LSDPictureViewDelegate>
@property (nonatomic, strong) NSArray *imgs;
@property (nonatomic, weak) LSDPictureView *picView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LSDPictureView *picView = [[LSDPictureView alloc] initWithPictures:[self pictures]];
    picView.center = self.view.center;
    picView.bounds = CGRectMake(0, 0, picViewW, 200);
    picView.itemCellSize = ItemSize;
    CGFloat margin = (picViewW - ItemSize.width)/2.f;
    picView.edgeInsets = UIEdgeInsetsMake(0, margin, 0, margin);
    picView.itemSpace = ItemSpace;
    picView.delegate = self;
    [self.view addSubview:picView];
    self.picView = picView;
}

- (NSMutableArray *)pictures{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<10; i++) {
        LSDPicture *pic = [[LSDPicture alloc] init];
        pic.name = [NSString stringWithFormat:@"%d",i+1];
        pic.index = i;
        [arr addObject:pic];
    }
    return arr;
}

#pragma mark - LSDPictureViewDelegate
- (void)pictureView:(LSDPictureView *)pictureView didSelectedItemPicture:(LSDPicture *)picture{
    NSLog(@"picture : %ld",(long)picture.index);
}
@end
