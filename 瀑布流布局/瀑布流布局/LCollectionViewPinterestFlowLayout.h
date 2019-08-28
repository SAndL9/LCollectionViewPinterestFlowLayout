//
//  LCollectionViewPinterestFlowLayout.h
//  瀑布流布局
//
//  Created by LiLei on 28/8/2019.
//  Copyright © 2019 李磊. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const UICollectionElementKindSectionHeader;
UIKIT_EXTERN NSString *const UICollectionElementKindSectionFooter;

@protocol LCollectionViewPinterestFlowLayoutDelegate;

@interface LCollectionViewPinterestFlowLayout : UICollectionViewLayout

//sectionInset 默认 UIEdgeInsetsMake(0, 0, 0, 0)
@property(nonatomic, assign)UIEdgeInsets sectionInset;
//lineSpacing 默认10
@property(nonatomic, assign)CGFloat lineSpacing;
// item space 默认10
@property(nonatomic, assign)CGFloat itemSpacing;
// column count 默认3
@property(nonatomic, assign)NSInteger colCount;

@property (nonatomic, weak) id<LCollectionViewPinterestFlowLayoutDelegate> delegate;

@end


@protocol LCollectionViewPinterestFlowLayoutDelegate <NSObject>

//行高
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(LCollectionViewPinterestFlowLayout*)collectionViewLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath*)indexPath;

@optional

//区头size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(LCollectionViewPinterestFlowLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;

//区尾size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(LCollectionViewPinterestFlowLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;

@end


