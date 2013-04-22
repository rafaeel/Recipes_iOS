//
//  ShowRecipeDetailViewController.m
//  Recipe_iOS
//
//  Created by Rafael on 4/19/13.
//  Copyright (c) 2013 Rafael. All rights reserved.
//

#import "ShowRecipeDetailViewController.h"
#import "ShowRecipesViewController.h"
#import "AFJSONRequestOperation.h"

@interface ShowRecipeDetailViewController ()

@end

@implementation ShowRecipeDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Show Recipe Details";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSURL * url =[[NSURL alloc] initWithString: @"http://192.168.0.25:3000/prescriptions.json"]; //RubyThree
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    ShowRecipesViewController *showRecipesViewController = [[ShowRecipesViewController alloc] init];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            showRecipesViewController.Transf = self.recipeDetails;
            [self requestSuccessful];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"%@", error.localizedDescription);}];
    
    [operation start];
}

- (void) requestSuccessful
{
    NSLog(@"%@", self.recipeDetails);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
