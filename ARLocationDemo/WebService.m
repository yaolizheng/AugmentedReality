//
//  WebService.m
//  MapWithXML
//
//  Created by Yaoli Zheng on 11/4/12.
//  Copyright (c) 2012 Yaoli Zheng. All rights reserved.
//

#import "WebService.h"
#import "TouchXML.h"

#import "demo3AppDelegate.h"
#import "Place.h"


@implementation WebService



+ (void) getLocation: (CLLocation *) location withType: (NSString *) type{
    demo3AppDelegate *app=[[UIApplication sharedApplication] delegate];
    if([app.bank isEqualToString:@"ALL"]) {
        app.bank = @"BANK";
    }
       NSString *urlString = [NSString stringWithFormat:@"https://mbankingdev.mfoundry.com/gbws/?mjx_server=mbankingdev"];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];

    
    //set headers
    
    NSString *contentType = [NSString stringWithFormat:@"text/xml"];
    
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    
    //create the body
    
    NSMutableData *postBody = [NSMutableData data];

    NSString *data = [NSString stringWithFormat:@"<searchLocationsRequest xmlns=\"%@\" locale=\"%@\" bankCode=\"%@\" keyWord=\"%@\" page=\"%@\" pageSize=\"%@\" lat=\"%f\" lon=\"%f\" type=\"%@\" />", @"http://www.mfoundry.com/GBML/Schema", @"en",@"usf",app.bank,@"0",@"10",location.coordinate.latitude,location.coordinate.longitude,type];
    
    [postBody appendData:[data dataUsingEncoding:NSUTF8StringEncoding]];


    [request setHTTPBody:postBody];
    
    
    
    //get response
    
    NSHTTPURLResponse* urlResponse = nil;
    
    NSError *error = [[NSError alloc] init];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    //NSLog(@"Response Code: %d", [urlResponse statusCode]);
    
    if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300) {
        
        //NSLog(@"Response: %@", result);

        NSData *XMLData = [result dataUsingEncoding:NSUTF8StringEncoding]; 
        CXMLDocument *document = [[CXMLDocument alloc] initWithData:XMLData
                                                            options:0
                                                              error:nil
                                  ];
        
        NSArray *location = NULL;
        NSDictionary *mappings = [NSDictionary dictionaryWithObject:@"http://www.mfoundry.com/GBML/Schema" forKey:@"gbmluri"];
        location = [document nodesForXPath:@"//gbmluri:searchLocationsResponse/gbmluri:location" namespaceMappings:mappings error:nil];
        NSString *strValue;
        NSString *strName;
                int count = 0;
        for (CXMLElement *element in location)
        {
            if ([element isKindOfClass:[CXMLElement class]])
            {
                count = count + 1;
            }
        }
        //NSLog(@"ahhhh%d", count);
        app.places = [NSMutableArray arrayWithCapacity:count] ;
        int j = 0;
        for (CXMLElement *element in location)
        {
            if ([element isKindOfClass:[CXMLElement class]])
            {
                
                NSMutableDictionary *objectAttributes=[[NSMutableDictionary alloc] init];
                NSArray *arAttr=[element attributes];
                NSUInteger i, countAttr = [arAttr count];
                double lon;
                double lat;
                NSString *name;
                NSString *phone;
                NSString *address;
                NSString *city;
                NSString *state;
                for (i = 0; i < countAttr; i++) {
                    strValue=[[arAttr objectAtIndex:i] stringValue];
                    strName=[[arAttr objectAtIndex:i] name];
                    if(strValue && strName){
                        [objectAttributes setValue:strValue forKey:strName];
                        if(strValue && strName){
                            if([strName isEqualToString:@"lon"] == 1) {
                                lon = [strValue doubleValue];
                            }
                            if([strName isEqualToString:@"lat"] == 1) {
                                lat = [strValue doubleValue];
                            }
                            if([strName isEqualToString: @"name"] == 1) {
                                name = strValue;
                            }
                            if([strName isEqualToString: @"phone"] == 1) {
                                phone = strValue;
                            }
                            if([strName isEqualToString: @"address"] == 1) {
                                address = strValue;
                            }
                            if([strName isEqualToString: @"city"] == 1) {
                                city = strValue;
                            }
                            if([strName isEqualToString: @"state"] == 1) {
                                state = strValue;
                            }                        }
                        
                    }
                }
                
                Place *p = [Place placeAt:[[CLLocation alloc] initWithLatitude:lat longitude:lon] withName:name withAddress:address withPhone:phone withState:state withCity:city];
                NSLog(@"insert index at : %d while array size is : %d",j,app.places.count);
                [app.places insertObject:p atIndex:j];
                j++;
                
            }
        }
        
        
    }


}

@end
