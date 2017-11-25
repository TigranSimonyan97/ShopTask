//
//  ViewController.m
//  ShopTask
//
//  Created by Tiko on 11/25/17.
//  Copyright © 2017 Tigranakert. All rights reserved.
//

#import "ViewController.h"
#import "Cell.h"
#import "SectionHeaderCRV.h"

@interface ViewController()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return section ==0 ? 2 : 2;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray * images = @[@"image1",@"image2"];
    Cell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.clothesImage.image = [UIImage imageNamed:images[indexPath.row]];
    cell.clothesNameLabel.text = @"Done";
    cell.clothesPriceLabel.text = @"$225";
    
    return cell;

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        SectionHeaderCRV *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        NSString * title = indexPath.section == 0 ? @"Women" : @"Men";
        headerView.sectionNameLabel.text = title;
        
        reusableView = headerView;
     }
    
//    if (kind == UICollectionElementKindSectionFooter){
//        
//    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        
        reusableView = footerview;
    }
    return reusableView;
}
@end









