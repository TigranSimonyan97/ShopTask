//
//  Clothes.h
//  ShopTask
//
//  Created by Tiko on 11/30/17.
//  Copyright © 2017 Tigranakert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClothesModel.h"

@interface Clothes : NSObject
-(ClothesModel *)makeClothesByCategory:(int)isforWoman;
@end
