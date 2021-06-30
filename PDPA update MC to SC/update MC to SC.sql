SELECT 
allsub.SubscriberKey as SubscriberKey,
sfdc.Email as EmailAddress,
allsub.Status as Status,
sfdc.Email__c as Email_Status,   
sfdc.SMS__C as SMS,
sfdc.Call__C as Call,
sfdc.Fax__c as Fax,
sfdc.MobilePhone as MobilePhone,
sfdc.AccountId as AccountId,
allsub.DateUnsubscribed as Unsub_date,
sfdc.LastModifiedDate as Modified_date,
CASE
    WHEN allsub.Status IN ('Unsubscribed') THEN 'False'
END AS Transform_Value    
FROM ent.[Contact_Salesforce] as sfdc
INNER JOIN ent._Subscribers as allsub
ON sfdc.Contact_ID__c = allsub.SubscriberKey
WHERE (allsub.Status IN ('Unsubscribed') AND sfdc.Email__c = 'True')
AND (allsub.DateUnsubscribed > sfdc.LastModifiedDate)