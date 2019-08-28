//
//  ViewController.m
//  瀑布流布局
//
//  Created by LiLei on 28/8/2019.
//  Copyright © 2019 李磊. All rights reserved.
//

#import "ViewController.h"
#import "LCollectionViewPinterestFlowLayout.h"
#import "LCollectionReusableView.h"
#import "CollectionViewCell.h"


#define kScrrenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<LCollectionViewPinterestFlowLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *heightArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   LCollectionViewPinterestFlowLayout *flowLayout = [[LCollectionViewPinterestFlowLayout alloc] init];
    flowLayout.colCount = 3;
    flowLayout.itemSpacing = 10;
    flowLayout.lineSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 10, 0);
    flowLayout.delegate = self;

    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];

    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;

    [_collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"LCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"sectionFooter"];
    [_collectionView registerNib:[UINib nibWithNibName:@"LCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeader"];


    [self.view addSubview:_collectionView];
    
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.heightArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.heightArray[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    CGFloat red = (CGFloat)(arc4random() % 255)/255.0;
    CGFloat green = (CGFloat)(arc4random() % 255)/255.0;
    CGFloat blue = (CGFloat)(arc4random() % 255)/255.0;
    
    UIColor *color = [[UIColor alloc] initWithRed:red green:green blue:blue alpha:0.5];
    cell.backgroundColor = color;
    cell.titleLabel.text = [NSString stringWithFormat:@"%ld区%ld行",(long)indexPath.section,(long)indexPath.row];
    return cell;
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        LCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeader" forIndexPath:indexPath];
        headerView.titleLabel.text = [NSString stringWithFormat:@"Headerheader--%ld",(long)indexPath.section];
        return headerView;
    }else{
        LCollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"sectionFooter" forIndexPath:indexPath];
        footerView.titleLabel.text = [NSString stringWithFormat:@"Footer--%ld",(long)indexPath.section];
        return footerView;
    }
}
#pragma mark - XHWaterfallFlowLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(LCollectionViewPinterestFlowLayout*)collectionViewLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath*)indexPath
{

    CGFloat arc = [self.heightArray[indexPath.section][indexPath.row] floatValue];
    
    return arc;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(LCollectionViewPinterestFlowLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScrrenWidth, 50);
}
//section footer
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(LCollectionViewPinterestFlowLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(kScrrenWidth,50);
}

- (NSMutableArray *)heightArray{
    if (!_heightArray) {
        _heightArray = [[NSMutableArray alloc]init];
        for (int i = 0; i < 2; i++) {
          
            NSMutableArray *array = [[NSMutableArray alloc]init];
            for (int i = 0; i < 35; i++) {
                CGFloat arc = arc4random() % 80  * 1.0 + 100;;
                [array addObject:@(arc)];
            }
            [_heightArray addObject:array];
        }
    }
    return _heightArray;
}


@end
