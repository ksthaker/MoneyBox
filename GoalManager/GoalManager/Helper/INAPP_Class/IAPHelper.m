//
//  IAPHelper.m
//  InAppRage
//
//  Created by Ray Wenderlich on 2/28/11.
//  Copyright 2011 Ray Wenderlich. All rights reserved.
//

#import "IAPHelper.h"

@implementation IAPHelper
@synthesize productIdentifiers = _productIdentifiers;
@synthesize products = _products;
@synthesize purchasedProducts = _purchasedProducts;
@synthesize request = _request;

- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers
{
    if ((self = [super init]))
    {
        
        // Store product identifiers
        _productIdentifiers = [productIdentifiers retain];
        
        // Check for previously purchased products
        NSMutableSet * purchasedProducts = [NSMutableSet set];
        for (NSString * productIdentifier in _productIdentifiers) {
            BOOL productPurchased = [[NSUserDefaults standardUserDefaults] boolForKey:productIdentifier];
            if (productPurchased) {
                [purchasedProducts addObject:productIdentifier];
                NSLog(@"Previously purchased: %@", productIdentifier);
            }
            NSLog(@"Not purchased: %@", productIdentifier);
        }
        self.purchasedProducts = purchasedProducts;
                        
    }
    return self;
}

- (void)requestProducts {//_productIdentifiers
//    
    self.request = [[SKProductsRequest alloc] initWithProductIdentifiers:_productIdentifiers];
    _request.delegate = self;
    [_request start];
//    
//    self.request= [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:_productIdentifiers]];
//    self.request.delegate = self;
//    [self.request start];
    
}
- (void)request:(SKProductsRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"err %@",error);

}
- (void)requestDidFinish:(SKProductsRequest *)request
{
    

}
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{

    NSSortDescriptor *mySortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:YES];
//  
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:response.products];
    
    [tempArray sortUsingDescriptors:[NSArray arrayWithObject:mySortDescriptor]];
    
    
    NSLog(@"Received products results...");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Inapp_Purchase_Price" object:nil];
    self.products = tempArray;
    self.request = nil;    
//    self.products = response.products;    
    [[NSNotificationCenter defaultCenter] postNotificationName:kProductsLoadedNotification object:_products]; 
    [mySortDescriptor release];
    [tempArray release];
    
    
    
}

- (void)recordTransaction:(SKPaymentTransaction *)transaction {    
    // TODO: Record the transaction on the server side...    
}

- (void)provideContent:(NSString *)productIdentifier {
    
    NSLog(@"Toggling flag for: %@", productIdentifier);
//    [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:productIdentifier];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    [_purchasedProducts addObject:productIdentifier];
    
   [[NSNotificationCenter defaultCenter] postNotificationName:kProductPurchasedNotification object:productIdentifier];
//    
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    
    
    [self recordTransaction: transaction];
    [self provideContent: transaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
     
    
}
- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    
    NSLog(@"restoreTransaction...");
    
    [self recordTransaction: transaction];
    [self provideContent: transaction.originalTransaction.payment.productIdentifier];
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        NSLog(@"Transaction error: %@", transaction.error.localizedDescription);
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kProductPurchaseFailedNotification object:transaction];
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
   
    for (SKPaymentTransaction *transaction in transactions)
    {
    NSLog(@"transaction.transactionState=%d",transaction.transactionState);
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
            default:
                break;
        }
    }
}

- (void)buyProductIdentifier:(NSString *)productIdentifier 
{
    
    NSLog(@"Buying %@...", productIdentifier);
    
    SKPayment *payment = [SKPayment paymentWithProductIdentifier:productIdentifier];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}

- (void)dealloc
{
    [_productIdentifiers release];
    _productIdentifiers = nil;
    [_products release];
    _products = nil;
    [_purchasedProducts release];
    _purchasedProducts = nil;
    [_request release];
    _request = nil;
    [super dealloc];
}

@end
