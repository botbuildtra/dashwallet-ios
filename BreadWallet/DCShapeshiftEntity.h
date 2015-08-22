//
//  DCShapeshiftEntity.h
//  DashWallet
//
//  Created by  Quantum Exploreron 8/22/15.
//  Copyright (c) 2015 Aaron Voisine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef enum eShapeshiftAddressStatus {
    eShapeshiftAddressStatus_NoDeposits = 0,
    eShapeshiftAddressStatus_Received = 1,
    eShapeshiftAddressStatus_Complete = 2,
    eShapeshiftAddressStatus_Failed = 4,
} eShapeshiftAddressStatus;

@class BRTransactionEntity;

@interface DCShapeshiftEntity : NSManagedObject

@property (nonatomic, retain) NSString * withdrawalAddress;
@property (nonatomic, retain) NSString * inputAddress;
@property (nonatomic, retain) NSString * inputCoin;
@property (nonatomic, retain) NSString * outputCoin;
@property (nonatomic, retain) NSString * outputTransactionId;
@property (nonatomic, retain) NSNumber * shapeshiftStatus;
@property (nonatomic, retain) BRTransactionEntity *transaction;

+(DCShapeshiftEntity*)shapeshiftHavingWithdrawalAddress:(NSString*)withdrawalAddress;
+(DCShapeshiftEntity*)registerShapeshiftWithInputAddress:(NSString*)inputAddress andWithdrawalAddress:(NSString*)withdrawalAddress;

@end