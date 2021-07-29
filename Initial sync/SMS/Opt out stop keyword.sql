SELECT
CASE
    WHEN a._SubscriptionDefinitionID = '435fb45b-73cb-4d8f-84e8-1a760b7cc25a' THEN 'TEXTUPDATE'
    WHEN a._SubscriptionDefinitionID = 'b0a7990d-94bb-43c8-b976-851086dbbabb' THEN 'FLAGKEY'
    WHEN a._SubscriptionDefinitionID = '907f3409-8da1-4c90-9502-b46f41e66adc' THEN 'JCC'
    WHEN a._SubscriptionDefinitionID = '0d3c70d5-0ba9-49c8-b3b5-e69a614dceb8' THEN 'JCCJOIN'
    WHEN a._SubscriptionDefinitionID = '83e3ff34-4580-4a1b-ac2d-ff8214dc3190' THEN 'JCCSTOP'
END AS SubscriptionDefinitionID,
a._MobileNumber as MobileNumber,
a._ModifiedDate as ModifiedDate,
a._OptOutStatusID as OptOutStatusID,
a._OptInStatusID as OptInStatusID,
dateadd(hh, 14, getdate()) as today
FROM
_MobileSubscription as a
WHERE
(a._SubscriptionDefinitionID = '83e3ff34-4580-4a1b-ac2d-ff8214dc3190'
AND a._OptInStatusID = 2)