//
//  ViewController.m
//  Recipe_iOS
//
//  Created by Rafael on 4/19/13.
//  Copyright (c) 2013 Rafael. All rights reserved.
//

#import "ViewController.h"
#import "AddRecipeViewController.h"
#import "ShowRecipesViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Recipes iOS";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIButton *addRecipeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addRecipeButton.frame = CGRectMake(0, 320, 100, 44);
    [addRecipeButton setTitle:@"Add Recipe" forState:UIControlStateNormal];
    [self.view addSubview:addRecipeButton];
    [addRecipeButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *showRecipesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    showRecipesButton.frame = CGRectMake(200, 320, 120, 44);
    [showRecipesButton setTitle:@"Show Recipes" forState:UIControlStateNormal];
    [self.view addSubview:showRecipesButton];
    [showRecipesButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void) buttonPressed:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"Add Recipe"]) {
        NSLog(@"Add Recipe Button was pressed");
        AddRecipeViewController *addRecipeViewController = [[AddRecipeViewController alloc] init];
        [self.navigationController pushViewController:addRecipeViewController animated:YES];
    } else if ([sender.titleLabel.text isEqualToString:@"Show Recipes"]){
        NSLog(@"Show Recipes Button was pressed");
        ShowRecipesViewController *showRecipesViewController = [[ShowRecipesViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:showRecipesViewController animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
