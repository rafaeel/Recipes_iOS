//
//  ShowRecipesViewController.m
//  Recipe_iOS
//
//  Created by Rafael on 4/19/13.
//  Copyright (c) 2013 Rafael. All rights reserved.
//

#import "ShowRecipesViewController.h"
#import "ShowRecipeDetailViewController.h"

@interface ShowRecipesViewController ()<UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>

@end

@implementation ShowRecipesViewController
@synthesize nameOfArray;
@synthesize Transf;
@synthesize recipes;
@synthesize webData;
@synthesize con;
@synthesize array;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        self.title = @"Show Recipes";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    recipes = @[];
    
    //NSURL * url =[[NSURL alloc] initWithString: @"http://192.168.1.101:3000/prescriptions.json"]; //casa
    //NSURL * url =[[NSURL alloc] initWithString: @"http://192.168.0.25:3000/prescriptions.json"]; //RubyThree
    NSURL * url =[[NSURL alloc] initWithString: @"http://127.0.0.1:3000/prescriptions.json"]; //RubyThree
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    con = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if (con) {
        webData = [[NSMutableData alloc]init];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
}
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"FAILED");
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    recipes = [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    NSLog(@"Finished loading: %d elements", [recipes count]);
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Got to number of rows: %d", [recipes count]);
    return [recipes count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *recipe = [[recipes objectAtIndex:indexPath.row] objectForKey:@"prescription"];
    cell.textLabel.text = [recipe objectForKey:@"name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    ShowRecipeDetailViewController *recipeDetailViewController = [[ShowRecipeDetailViewController alloc]init];
    recipeDetailViewController.recipeDetails = self.nameOfArray[indexPath.row];
    Transf = nameOfArray[indexPath.row];
    
    NSLog(@"Erro: %@", Transf);
    [self.navigationController pushViewController:recipeDetailViewController animated:YES];
    
}

@end
