//
//  ViewController.m
//  Lesson 31 HW 2
//
//  Created by Alex on 14.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "ViewController.h"
#import "APGroup.h"
#import "APCards.h"

@interface ViewController ()  <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UITableView* tableView;

@property (strong, nonatomic) NSMutableArray* groupsArray;

@end

@implementation ViewController

- (void)loadView {
    
    [super loadView];
    
    CGRect frame = self.view.bounds;
    
    UITableView* tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
    
    //tableView.editing = YES; // this is for YES reduction of rows, but lets make a butoon for it
    
    self.tableView.allowsSelectionDuringEditing = NO; // no celection while editing
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.groupsArray = [NSMutableArray array]; // new variant of alloc init
    
    static NSString* classNames[] = {
        @"Rogue   (Card name, Rarity)                      ManaCost",
        @"Warrior (Card name, Rarity)                      ManaCost",
        @"Shaman  (Card name, Rarity)                     ManaCost",
        @"Warlock (Card name, Rarity)                     ManaCost",
        @"Hunter  (Card name, Rarity)                      ManaCost"
        
    };
    
    
    static int classNamesCount = 5;
    
    for (int i=0; i<classNamesCount; i++) {
        APGroup* group = [[APGroup alloc] init];
        group.decks = classNames[i];
        NSMutableArray* array = [NSMutableArray array];
        for (int j=0; j<arc4random() % 5 +5; j++) {
            [array addObject:[APCards randomCard]];
        }
        group.cards = array;
        
        [self.groupsArray addObject:group];
        
    }
    
    self.navigationItem.title = @"DECKS";
    
    
    UIBarButtonItem* editButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                   target:self
                                   action:@selector(actionEdit:)];
    
    self.navigationItem.rightBarButtonItem = editButton;
    
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self
                                  action:@selector(actionAddSection:)];
    
    self.navigationItem.leftBarButtonItem = addButton;
    
 
   [self.tableView reloadData]; //  важно!
    
    
    

    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions


- (void) actionEdit: (UIBarButtonItem*) sender {
    
    NSLog(@"action Edit - button pressed");
    
    BOOL isEditing = self.tableView.editing;
    
    [self.tableView setEditing:!isEditing animated:YES]; // after repressing - do reverse
    
    UIBarButtonSystemItem itemDoneOrEdit = UIBarButtonSystemItemEdit;
    
    if (self.tableView.editing == YES) {
        itemDoneOrEdit = UIBarButtonSystemItemDone;
    }
    
    UIBarButtonItem* editButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:itemDoneOrEdit
                                   target:self
                                   action:@selector(actionEdit:)];
    
    [self.navigationItem setRightBarButtonItem:editButton animated:YES];
    
}

- (void) actionAddSection: (UIBarButtonItem*) sender {
    
    NSLog(@"actionAddSection - button pressed");
    
    APGroup* group = [[APGroup alloc] init];
    
    static NSString* classNames[] = {
        @"Rogue   (Card name, Rarity)                      ManaCost",
        @"Warrior (Card name, Rarity)                      ManaCost",
        @"Shaman  (Card name, Rarity)                     ManaCost",
        @"Warlock (Card name, Rarity)                     ManaCost",
        @"Hunter  (Card name, Rarity)                      ManaCost"
        
    };
    
    
    group.decks = classNames[arc4random() % 4];
    
    group.cards = @[[APCards randomCard], [APCards randomCard], [APCards randomCard]]; // this is NSARRA massive with objects
    
    NSInteger newSectionIndex = 0;
    
    [self.groupsArray insertObject:group atIndex:newSectionIndex];
    
    // very important to make [self.tableView reloadData]; or smth like this
    
    [self.tableView beginUpdates];
    

     NSIndexSet* insertSections = [NSIndexSet indexSetWithIndex:newSectionIndex];
    
    UITableViewRowAnimation animation = UITableViewRowAnimationFade;
    
    if ([self.groupsArray count] > 1) {
        animation = [self.groupsArray count] % 2 ? UITableViewRowAnimationLeft : UITableViewRowAnimationRight;
    }
    
    [self.tableView insertSections:insertSections
                  withRowAnimation:animation];
    
    [self.tableView endUpdates];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    });
 
    
    
}

#pragma mark - UITableViewDataSource

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CGRect frame = [tableView rectForHeaderInSection:section];
    
    UIView* headerView = [[UIView alloc] initWithFrame:frame];
    
   // RGB(164, 189, 249)
    
    headerView.backgroundColor = [UIColor colorWithRed:0.164 green:0.189 blue:0.249 alpha:1.f];
  
    UILabel* headerTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, frame.size.width, frame.size.height)];
    headerTextLabel.text = [[self.groupsArray objectAtIndex:section] decks];
    
    headerTextLabel.textColor =  [UIColor whiteColor];
    [headerView addSubview:headerTextLabel];
    
  
    
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.groupsArray count];
    
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    
    
    return [[self.groupsArray objectAtIndex:section] decks];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    APGroup* group = [self.groupsArray objectAtIndex:section];
    
    return [group.cards count] +1 ; // +1 - this is for edding cards
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        static NSString* addDeckIdentifier = @"AddDeckCell";
        
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:addDeckIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addDeckIdentifier];
            cell.textLabel.textColor = [UIColor blueColor];
            cell.textLabel.text = @"+ PRESS HERE TO ADD A CARD";
            //cell.backgroundColor = [UIColor lightGrayColor];
            cell.imageView.image = [UIImage imageNamed:@"cardback.jpg"];
        }
        return cell;
    } else {
        static NSString* identifier = @"Cell";
        
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }
        
        APGroup* group = [self.groupsArray objectAtIndex:indexPath.section];
        APCards* card = [group.cards objectAtIndex:indexPath.row-1]; // -1 , cause 1st element is button AddCard
        
        
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@, %@", card.name, card.rarity];
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", card.manaCost];
        
        
        
        
        if ([card.rarity isEqualToString:@"Legend"]) {
            cell.textLabel.textColor = [UIColor orangeColor];
            cell.imageView.image = [UIImage imageNamed:@"l2.jpg"];
        } else if ([card.rarity isEqualToString:@"Epic"]) {
            cell.textLabel.textColor = [UIColor purpleColor];
            cell.imageView.image = [UIImage imageNamed:@"b2.jpg"];
        }else if ([card.rarity isEqualToString:@"Rare"]) {
            cell.textLabel.textColor = [UIColor blueColor];
            cell.imageView.image = [UIImage imageNamed:@"b2.jpg"];
        }else if ([card.rarity isEqualToString:@"Common"]) {
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.imageView.image = [UIImage imageNamed:@"b2.jpg"];
        }
        
        
        
        return cell;
    }
    
    



}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //return YES;
    
    return indexPath.row > 0; // for AddButton - no move
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    APGroup* sourceGroup = [self.groupsArray objectAtIndex:sourceIndexPath.section];
    APCards* card = [sourceGroup.cards objectAtIndex:sourceIndexPath.row-1];
    
    NSMutableArray* tempArray = [NSMutableArray arrayWithArray:sourceGroup.cards];
    
    if (sourceIndexPath.section == destinationIndexPath.section) {
        [tempArray exchangeObjectAtIndex:sourceIndexPath.row-1 withObjectAtIndex:destinationIndexPath.row-1];
        sourceGroup.cards = tempArray;
    } else {
        [tempArray removeObject:card];
        sourceGroup.cards = tempArray;
        
        APGroup* destinatioGroup = [self.groupsArray objectAtIndex:destinationIndexPath.section];
        tempArray = [NSMutableArray arrayWithArray:destinatioGroup.cards];
        [tempArray insertObject:card atIndex:destinationIndexPath.row-1];
        destinatioGroup.cards = tempArray;
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // если подтверждается editing Style for delete - то идет код удаления
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        APGroup* sourceGroup = [self.groupsArray objectAtIndex:indexPath.section];
        APCards* card = [sourceGroup.cards objectAtIndex:indexPath.row -1];
        
        NSMutableArray* tempArray = [NSMutableArray arrayWithArray:sourceGroup.cards];
        
        [tempArray removeObject:card];
        
        sourceGroup.cards = tempArray;
        
        [tableView beginUpdates];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        // @[indexPath] - это массив с нашим единственным индекс пас
        
        [tableView endUpdates];
    }
    
}

#pragma mark - UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 0 ?  UITableViewCellEditingStyleNone : UITableViewCellEditingStyleDelete;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED {
    return @"DROP IT OUT OF DECK";
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO; // чтобы строчки не сдвигались в режиме редактирования
}

// Allows customization of the target row for a particular row as it is being moved/reordered
// делаем так чтобы нельзя было поставить другие строчки на AddCard или выше
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    
    if (proposedDestinationIndexPath.row == 0) {
        return sourceIndexPath  ;
    } else {
        return proposedDestinationIndexPath ;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        NSLog(@"add a card");
        
        APGroup* group = [self.groupsArray objectAtIndex:indexPath.section];
        
        NSMutableArray* tempArray = nil;
        
        if (group.cards) {
            tempArray = [NSMutableArray arrayWithArray:group.cards];
        } else {
            tempArray = [NSMutableArray array]; // just alloc int of a new
        }
        
        NSInteger newCardIndex = 0;
        
        [tempArray insertObject:[APCards randomCard] atIndex:newCardIndex];
        
        group.cards = tempArray ;
        
        [self.tableView beginUpdates];
        
        NSIndexPath* newIndexPath = [NSIndexPath indexPathForItem:newCardIndex+1 inSection:indexPath.section];
        
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        [self.tableView endUpdates];
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            }
        });
        
        
        
    }
    
}

@end
