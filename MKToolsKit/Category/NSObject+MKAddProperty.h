//
//  NSObject+MKAddProperty.h
//  MKToolsKit
//
//  Created by xiaomk on 16/5/19.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(MKAddProperty)

/**
 *  Bind property to a instance With key-value pair.
 *
 *  @param aKey   the key to search the property.
 *  @param aValue the object to bind to the instance.
 */
- (void)mk_bindPropertyWithKey:(NSString *)aKey value:(id)aValue;

/**
 *  Get the object which is bind to a instance With key-value pair.
 *
 *  @param aKey the key to search the property.
 *
 *  @return: the object to bind to the instance.
 */
- (id)mk_propertyValueForKey:(NSString *)aKey;

/**
 *  Delete the property which is bind to the instance with the key.
 *
 *  @param aKey the key to search the property.
 */
- (void)mk_removePropertyWithKey:(NSString *)aKey;

/**
 *  Delete all properties which are bind to the instance.
 */
- (void)mk_removeAllBindProperty;

/**
 *  @return:  the object which is bind to the instance.
 */
- (id)mk_tagObj;

/**
 *  Bind the object to the instance.
 *
 *  @param aTagObj the object which had binded to the instance.
 */
- (void)setMk_tagObj:(id)aTagObj;

@end
