//
//  APCards.m
//  Lesson 31 HW 2
//
//  Created by Alex on 14.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "APCards.h"
#import <UIKit/UIKit.h>

@implementation APCards

static NSString* names[] = {
    @"NorthSeaKraken",
    @"ForceTankMAX",
    @"FossilizedDevilsaur",
    @"CapturedJormungar",
    @"CoreHound",
    @"StormwindChampion",
    @"WarGolem",
    @"Archmage",
    @"DrakonidCrusher",
    @"FrostElemental",
    @"LordoftheArena",
    @"PriestessofElune",
    @"VolcanicDrake",
    @"AntiqueHealbot",
    @"AnubisathSentinel",
    @"BlackwingCorruptor",
    @"BootyBayBodyguard",
    @"ClockworkKnight",
    @"DarkscaleHealer",
    @"FenCreeper",
    @"FrostwolfWarlord",
    @"GurubashiBerserker",
    @"KvaldirRaider",
    @"PitFighter",
    @"SaltyDog",
    @"SilverHandKnight",
    @"SpectralKnight",
    @"SpitefulSmith",
    @"StormpikeCommando",
    @"StranglethornTiger",
    @"VentureCoMercenary",
    @"AncientBrewmaster",
    @"BurlyRockjawTrogg",
    @"ChillwindYeti",
    @"CultMaster",
    @"DarkIronDwarf",
    @"DragonkinSorcerer",
    @"DragonlingMechanic",
    @"DreadCorsair",
    @"EvilHeckler",
};

static int namesCount = 40;

static NSString* rarity[] = {
    @"Rare", @"Epic", @"Legend", @"Common"
    
};


static int classRarityCount = 4;


+ (APCards*) randomCard {
    
    APCards* card = [[APCards alloc] init];
    
    card.name = names[arc4random() % namesCount];
    card.rarity = rarity[arc4random() % classRarityCount];
    card.manaCost = arc4random()%10;
    
    return card;
    
}



@end
