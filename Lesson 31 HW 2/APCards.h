//
//  APCards.h
//  Lesson 31 HW 2
//
//  Created by Alex on 14.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface APCards : NSObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* rarity;
@property (assign, nonatomic) NSInteger manaCost;

+ (APCards*) randomCard;

@end
