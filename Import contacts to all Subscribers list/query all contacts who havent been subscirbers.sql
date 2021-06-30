SELECT
sfdc._ContactKey as 'Subscriber Key',
sfdc.Email as 'Email Address',
sfdc.SMS__c as SMS,
sfdc.Call__c as Call,
sfdc.Fax__c as Fax,
sfdc.MobilePhone as MobilePhone,
sfdc.Email__c as Email_Status,
sfdc.AccountId as AccountId,
CASE
    WHEN sfdc.Email__c = 'True' THEN 'Active'
    ELSE 'Unsubscribed'
END AS Status
FROM ent.[Contact_Salesforce] as sfdc
WHERE 
sfdc.Email != '' AND
sfdc.Email NOT LIKE '%@example.com%' AND
sfdc._ContactKey NOT IN
(SELECT SubscriberKey FROM ent._Subscribers)

UNION

SELECT
sfdc._ContactKey as 'Subscriber Key',
sfdc.Email as 'Email Address',
sfdc.SMS__c as SMS,
sfdc.Call__c as Call,
sfdc.Fax__c as Fax,
sfdc.MobilePhone as MobilePhone,
sfdc.Email__c as Email_Status,
sfdc.AccountId as AccountId,
allsub.Status as Status
FROM ent.[Contact_Salesforce] as sfdc
INNER JOIN ent._Subscribers as allsub
ON sfdc._ContactKey = allsub.SubscriberKey
WHERE
sfdc.Email != allsub.EmailAddress