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
#import "Clothes.h"
#import "ClothesModel.h"

@interface ViewController()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property NSMutableArray *womenClothes;;
@property NSMutableArray *menClothes;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    _womenClothes = [[NSMutableArray alloc] init];
    _menClothes = [[NSMutableArray alloc] init];
    
    Clothes *clothes = [[Clothes alloc] init];

    for(int i = 0; i < 2; i++) {
        
        int isForWoman = 1;//For Woman
        ClothesModel *womanClothesModel = [[ClothesModel alloc] init];
        womanClothesModel = [clothes makeClothesByCategory:isForWoman];
        [_womenClothes addObject:womanClothesModel];

        isForWoman = 0;//For Man
        ClothesModel *manClothesModel = [[ClothesModel alloc] init];
        manClothesModel = [clothes makeClothesByCategory:isForWoman];
        [_menClothes addObject:manClothesModel];
        
    }
    
    [self.collectionView reloadData];
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return section == 0 ? [_womenClothes count] : [_menClothes count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)     collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    Cell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        ClothesModel *womanClothes = _womenClothes[indexPath.row];
        cell.clothesImage.image = [UIImage imageNamed:womanClothes.clothesImageName];
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImageInAllScreen:)];
        [cell.clothesImage addGestureRecognizer:tapGesture];
        cell.clothesNameLabel.text = womanClothes.clothesName;
        cell.clothesPriceLabel.text = womanClothes.clothesPrice;
    } else {
        ClothesModel *manClothes = _menClothes[indexPath.row];
        cell.clothesImage.image = [UIImage imageNamed:manClothes.clothesImageName];
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImageInAllScreen:)];
        [cell.clothesImage addGestureRecognizer:tapGesture];
        cell.clothesNameLabel.text = manClothes.clothesName;
        cell.clothesPriceLabel.text = manClothes.clothesPrice;
    }
    
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

    Clothes *clothes = [[Clothes alloc] init];

    if (sectionIndex == 0) {
        for(int i = 0; i < 2; i++) {
            int forWoman = 1;//For Woman
            ClothesModel *womanClothesModel = [[ClothesModel alloc] init];
            womanClothesModel = [clothes makeClothesByCategory:forWoman];
            [_womenClothes addObject:womanClothesModel];
        }
        
        [self.collectionView reloadData];
    } else {
        for(int i = 0; i < 2; i++) {
            int forMan = 0;//For Man
            ClothesModel *manClothesModel = [[ClothesModel alloc] init];
            manClothesModel = [clothes makeClothesByCategory:forMan];
            [_menClothes addObject:manClothesModel];
        }
        [self.collectionView reloadData];
    }
    
}

-(void) showImageInAllScreen:(UITapGestureRecognizer *)gesture
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, self.view.frame.origin.y + self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    imageView.image = ((UIImageView *)gesture.view).image;
    
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









