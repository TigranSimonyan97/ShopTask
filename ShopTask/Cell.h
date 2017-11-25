//
//  Cell.h
//  ShopTask
//
//  Created by Tiko on 11/25/17.
//  Copyright © 2017 Tigranakert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *clothesImage;
@property (weak, nonatomic) IBOutlet UILabel *clothesNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *clothesPriceLabel;

@end
