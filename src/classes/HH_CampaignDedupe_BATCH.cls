/*
    Copyright (c) 2014 Salesforce.com Foundation
    All rights reserved.
    
    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:
    
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Salesforce.com Foundation nor the names of
      its contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.
 
    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
    FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE 
    COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
    INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
    BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
    LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN 
    ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
    POSSIBILITY OF SUCH DAMAGE.
*/
/**
* @author Salesforce.com Foundation
* @date 2014
* @group Households
* @description Class provides a batchable wrapper for marking Household duplicates on a Campaign.
*/
public with sharing class HH_CampaignDedupe_BATCH implements Database.Batchable<sObject> {

    /*******************************************************************************************************
    * @description soql query for computing which CampaignMembers to run the batch on.
    */ 
    public String strSoql { get; set; } 

    /*******************************************************************************************************
    * @description the Campaign Id that the results should be stored in.
    */ 
    public ID cmpId { get; set; } 
    
    /*******************************************************************************************************
    * @description Constructor
    * @param Id the campaign's Id
    * @param strQuery the soql query for which CampaignMember records to evaluate
    ********************************************************************************************************/
    public HH_CampaignDedupe_BATCH(ID campaignId, string strQuery) {
        cmpId = campaignId;
        strSoql = strQuery;
    }
    
    /*******************************************************************************************************
    * @description start Method for the Database.Batchable interface
    * @param bc the BatchableContext
    * @return database.Querylocator  
    ********************************************************************************************************/
    public database.Querylocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(strSoql);      
    }
    
    /*******************************************************************************************************
    * @description execute Method for the Database.Batchable interface
    * @param bc the BatchableContext
    * @param result the list of CampaignMembers to process
    * @return void  
    ********************************************************************************************************/
    public void execute(Database.BatchableContext bc, Sobject[] result) {
    	HH_CampaignDedupeBTN_CTRL.MarkDuplicatesFromList(cmpId, (list<CampaignMember>) result);
    }
    
    /*******************************************************************************************************
    * @description finish Method for the Database.Batchable interface
    * @param bc the BatchableContext
    * @return void  
    ********************************************************************************************************/
    public void finish(Database.BatchableContext bc) {
    }
}