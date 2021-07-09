SELECT DISTINCT
a._ContactID as contactid,
b.SubscriberKey as subscriberkey,
a._MobileNumber as mobilenumber,
c.SMS__c as SMS,
a._Status as status,
a._CountryCode as countrycode
FROM
_MobileAddress as a
INNER JOIN
_smsmessagetracking as b
ON a._ContactID = b.SubscriberID
INNER JOIN
ent.[Contact_Salesforce] as c
ON b.SubscriberKey = c._ContactKey
WHERE
(a._Status = 1  AND c.SMS__c != 1)
OR
(a._Status !=1 AND c.SMS__c=1)
