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
#import "SectionFooterCRV.h"

@interface ViewController()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property NSArray * images;
@property int womenClothesCount;
@property int menClothesCount;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    _images = @[@"image1",@"image2"];
    _womenClothesCount = 2;
    _menClothesCount = 2;
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return section == 0 ? _womenClothesCount : _menClothesCount;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)     collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    Cell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.clothesImage.image = [UIImage imageNamed:_images[indexPath.row % 2]];
    cell.clothesImage.tag = indexPath.row % 2;
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImageInAllScreen:)];
    [cell.clothesImage addGestureRecognizer:tapGesture];
    
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
    
    
    if (kind == UICollectionElementKindSectionFooter) {
        SectionFooterCRV *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        footerView.showMoreButton.tag = indexPath.section;
        
        reusableView = footerView;
    }
    return reusableView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
    
    return CGSizeMake(collectionView.frame.size.width / 2 - 2 * flowLayout.minimumInteritemSpacing, flowLayout.itemSize.height);
}

- (IBAction)showMoreButtonTouchUP:(UIButton *)sender
{
    NSInteger sectionIndex = sender.tag;
    if (sectionIndex == 0) {
        NSLog(@"section index is: %ld",(long)sectionIndex);
        _womenClothesCount += 2;
        [self.collectionView reloadData];
    } else {
        NSLog(@"section index is: %ld",(long)sectionIndex);
        _menClothesCount += 2;
        [self.collectionView reloadData];
    }
    
}

-(void) showImageInAllScreen:(UITapGestureRecognizer *)gesture
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
    imageView.image = [UIImage imageNamed:_images[gesture.view.tag]];
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissFullScreenImage:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionDown;
    imageView.userInteractionEnabled = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView addGestureRecognizer:swipeGesture];
    [self.view addSubview:imageView];
}


-(void) dismissFullScreenImage:(UISwipeGestureRecognizer *)gesture
{
    [gesture.view removeFromSuperview];
}

@end









