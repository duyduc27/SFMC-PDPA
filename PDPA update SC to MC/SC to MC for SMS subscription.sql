SELECT
a._MobileNumber as MobileNumber,
a._ModifiedDate as MC_ModifiedDate,
b.LastModifiedDate as SC_ModifiedDate,
b._ContactKey as SubscriberKey,
b.SMS__c as SMS__c,
a._OptInStatusID as OptInStatusID,
a._OptOutStatusID as OptOutStatusID,
CASE
    WHEN a._OptInStatusID = 2 THEN 'True'
    WHEN a._OptInStatusID = 0 THEN 'False'
END AS TransformedValue    
FROM
_MobileSubscription as a
INNER JOIN
ent.[Contact_Salesforce] as b
ON
a._MobileNumber = b.MobilePhone
WHERE a._MobileNumber IS NOT NULL
AND b.MobilePhone != ''
AND ((b.SMS__c = 1 AND a._OptInStatusID = 0) OR (b.SMS__c = 0 AND a._OptInStatusID = 2))
AND a._SubscriptionDefinitionID = '907f3409-8da1-4c90-9502-b46f41e66adc'