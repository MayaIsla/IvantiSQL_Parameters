
select 
ParameterName,
ParameterValue
from ServiceReqParam  where ParentLink_RecID in (SELECT recid  FROM ServiceReq where recid = @RecID)

SELECT
DisplayName
FROM ServiceReqTemplateParam where ParentLink_RecID in (SELECT recid  FROM ServiceReq where servicereqnumber = )

-- I SPENT 3 HOURS TO FIGURE OUT THEY ARE NOT EVEN RELATED AHHHHH ServiceReqParam.ParentLink_RecId != ServiceReqTemplateParam.ParentLink_RecId

SELECT 
DisplayName,
ParameterValue
FROM ServiceReqParam INNER JOIN ServiceReqTemplateParam ON ServiceReqParam.ParentLink_RecId = ServiceReqTemplateParam.ParentLink_RecId
WHERE ServiceReqParam.ParentLink_RecID in (SELECT recid @RecID) 
AND ServiceReqTemplateParam.ParentLink_RecID in (SELECT recid FROM ServiceReq where servicereqnumber = )

-- Service Req Param Values + Name of field.

SELECT
ParameterName, 
ParameterValue
FROM ServiceReqParam where ParentLink_RecID in (SELECT recid  FROM ServiceReq where servicereqnumber = ) AND ParameterName NOT LIKE '%label_%'
--SELECT * FROM ServiceReqParam WHERE ParameterName LIKE 'profile_combo' (Trying to find a way to have it only view the non-HTML queries)


SELECT 
subject,
details,
OwnerTeam,
status
FROM Task where ParentLink_RecID in (SELECT recid  FROM ServiceReq where servicereqnumber = ) AND OwnerTeam = '' 

--Successfully queried only Tasks from Service Req

SELECT 
OwnerFullName,
Status,
VotedDateTime,
VotedBy
FROM FRS_ApprovalVoteTracking WHERE PrimaryParentID in (SELECT ServiceReqNumber FROM serviceReq WHERE ServiceReqNumber = )
--Queried all approval reqeust in that service request


Select recid from Incident where recid In (@RecID)


SELECT
ParameterName,
ParameterValue
FROM ServiceReqParam where ParentLink_RecID in (SELECt recid FROM ServiceReq WHERE recid IN (@RecID)) AND ParameterName NOT LIKE '%label_%'


SELECT        Ext.DisplayName, Ext.LoginID, Ext.PrimaryEmail, Ext.CreatedBy, COUNT(Ext.RecId) AS IncCount
FROM            ExternalContact AS Ext INNER JOIN
                         Incident AS Inc ON Ext.RecId = Inc.ProfileLink_RecID
WHERE        (Ext.CreatedBy <> 'InternalServices')
GROUP BY Ext.RecId, Ext.DisplayName, Ext.LoginID, Ext.PrimaryEmail, Ext.CreatedBy
ORDER BY IncCount DESC, Ext.DisplayName DESC

--ServiceReqTemplateParam.ParentLink_RecId

SELECT 
ServiceReqTemplateParam.DisplayName,
ParameterValue
FROM ServiceReq
INNER JOIN ServiceReqTemplateParam ON (ServiceReq.SvcReqTmplLink_RecID = ServiceReqTemplateParam.ParentLink_RecID)
LEFT OUTER JOIN ServiceReqParam ON (
  ServiceReqParam.ParentLink_RecID = ServiceReq.RecId
  AND ServiceReqParam.ParameterName = ServiceReqTemplateParam.NAME
  )
LEFT JOIN [FusionAttachments] att ON att.RecID = ServiceReqParam.ParameterValue
LEFT JOIN [Frs_def_validation_lists] val ON val.RecID = ServiceReqTemplateParam.ValidationList_RecID
AND ServiceReqTemplateParam.ValidationList_RecID IS NOT NULL
WHERE (ServiceReq.ServiceReqNumber = (''))



SELECT 
ServiceReqTemplateParam.DisplayName,
ParameterValue
FROM ServiceReq
INNER JOIN ServiceReqTemplateParam ON (ServiceReq.SvcReqTmplLink_RecID = ServiceReqTemplateParam.ParentLink_RecID)
LEFT OUTER JOIN ServiceReqParam ON (
  ServiceReqParam.ParentLink_RecID = ServiceReq.RecId
  AND ServiceReqParam.ParameterName = ServiceReqTemplateParam.NAME
  )
LEFT JOIN [FusionAttachments] att ON att.RecID = ServiceReqParam.ParameterValue
LEFT JOIN [Frs_def_validation_lists] val ON val.RecID = ServiceReqTemplateParam.ValidationList_RecID
WHERE (ServiceReq.ServiceReqNumber = ('')) AND ParameterValue IS NOT NULL
WHERE (ServiceReqTemplateParam.DisplayName IS NOT NULL) AND ParameterName NOT LIKE '%label_%'




SELECT 
ServiceReqTemplateParam.DisplayName,
ParameterValue
FROM ServiceReq
INNER JOIN ServiceReqTemplateParam ON (ServiceReq.SvcReqTmplLink_RecID = ServiceReqTemplateParam.ParentLink_RecID)
LEFT OUTER JOIN ServiceReqParam ON (
  ServiceReqParam.ParentLink_RecID = ServiceReq.RecId
  AND ServiceReqParam.ParameterName = ServiceReqTemplateParam.NAME
  )
LEFT JOIN [FusionAttachments] att ON att.RecID = ServiceReqParam.ParameterValue
AND ParameterValue NOT LIKE '%<style%'
LEFT JOIN [Frs_def_validation_lists] val ON val.RecID = ServiceReqTemplateParam.ValidationList_RecID
WHERE (ServiceReqParam.ParentLink_RecID = (@RecID)) AND (ParameterValue IS NOT NULL) AND (ParameterValue NOT LIKE '%<%') AND (ServiceReqTemplateParam.DisplayName IS NOT NULL)
ORDER BY ServiceReqTemplateParam.SequenceNum
