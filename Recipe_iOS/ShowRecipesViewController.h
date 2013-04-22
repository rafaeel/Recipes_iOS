//
//  ShowRecipesViewController.h
//  Recipe_iOS
//
//  Created by Rafael on 4/19/13.
//  Copyright (c) 2013 Rafael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowRecipesViewController : UITableViewController


@property (weak, nonatomic) IBOutlet UITableView *TableView;
@property (strong, nonatomic) NSArray *nameOfArray;
@property (strong, nonatomic) NSDictionary *Transf;
@property (strong, nonatomic) NSArray *recipes;

@end
