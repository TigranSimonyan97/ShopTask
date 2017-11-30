//
//  Clothes.m
//  ShopTask
//
//  Created by Tiko on 11/30/17.
//  Copyright © 2017 Tigranakert. All rights reserved.
//

#import "Clothes.h"

@implementation Clothes
+(NSString *)randomNameForClothes:(int)clothesCategory index:(int)index
{
    NSArray *womenClothesNames = @[@"woman1",@"woman2",@"woman3",@"woman4"];
    NSArray *menClothesNames = @[@"man1",@"man2",@"man3",@"man4"];
    
    return clothesCategory == 0 ? menClothesNames[index] : womenClothesNames[index];
}

+(NSString *)randomImageNameForClothes:(int)clothesCategory index:(int)index
{
    NSArray *womenClothesImagesNames = @[@"woman_image1",@"woman_image2",@"woman_image3",@"woman_image4"];
    NSArray *menClothesImageNames = @[@"man_image1",@"man_image2",@"man_image3",@"man_image4"];
    
    return clothesCategory == 0 ? menClothesImageNames[index] : womenClothesImagesNames[index];
}

+(NSString *)randomPriceForClothes:(int)index
{
    NSArray *clothesPrices = @[@"$100",@"$200",@"$300",@"$400"];
    
    return clothesPrices[index];
}

-(ClothesModel *)makeClothesByCategory:(int)isForWomen
{
    ClothesModel *clothes = [[ClothesModel alloc] init];
    
    int randomIndex = arc4random_uniform(4);
    
    clothes.clothesName = [Clothes randomNameForClothes:isForWomen index:randomIndex];
    clothes.clothesImageName = [Clothes randomImageNameForClothes:isForWomen index:randomIndex];
    clothes.clothesPrice = [Clothes randomPriceForClothes:randomIndex];
    clothes.clothesCategory = isForWomen ? @"Women" : @"Man";
    
    return clothes;
}

@end
