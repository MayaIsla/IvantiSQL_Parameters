SELECT  TOP 1  ServiceReq.CreatedDateTime, ProfileFullName as Customer, Status as ServiceRequestStatus,ServiceReqTemplateParam.DisplayName,
ParameterValue, ServiceRequestParameters.*
FROM ServiceReq 
INNER JOIN ServiceReqTemplateParam ON (ServiceReq.SvcReqTmplLink_RecID = ServiceReqTemplateParam.ParentLink_RecID)
LEFT OUTER JOIN ServiceReqParam ON (
  ServiceReqParam.ParentLink_RecID = ServiceReq.RecId
  AND ServiceReqParam.ParameterName = ServiceReqTemplateParam.NAME
  )
--LEFT JOIN [FusionAttachments] att ON att.RecID = ServiceReqParam.ParameterValue (probably not needed as it's for attachments)
OUTER APPLY (
	SELECT [Requester]
				,[employee_list_textarea] as "employee list"
				,[Requester_Title]
	FROM (
		SELECT ParameterValue
			,ParameterName
		FROM ServiceReqParam srp with (NOLOCK)
		WHERE srp.ParentLink_RecID = servicereq.RecID
		) AllParams
	pivot(max(ParameterValue) FOR ParameterName IN (
				[Requester]
				,[employee_list_textarea] 
				,[requester_title]
				)) PivotedParams
	) ServiceRequestParameters
	LEFT JOIN [Frs_def_validation_lists] val ON val.RecID = ServiceReqTemplateParam.ValidationList_RecID
WHERE (ServiceReqParam.ParentLink_RecID = ('98022849CE194109B68035BB29A75843')) AND (ParameterValue IS NOT NULL) AND (ParameterValue NOT LIKE '%<%') AND (ServiceReqTemplateParam.DisplayName IS NOT NULL) -- Will be replaced by '@RecId'
ORDER BY ServiceReqTemplateParam.SequenceNum
