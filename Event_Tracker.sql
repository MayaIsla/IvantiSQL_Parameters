SELECT  TOP 1  ServiceReq.CreatedDateTime, ProfileFullName as Customer, Status as ServiceRequestStatus, ServiceRequestParameters.*
FROM ServiceReq 
INNER JOIN ServiceReqTemplateParam ON (ServiceReq.SvcReqTmplLink_RecID = ServiceReqTemplateParam.ParentLink_RecID)
LEFT OUTER JOIN ServiceReqParam ON (
  ServiceReqParam.ParentLink_RecID = ServiceReq.RecId
  AND ServiceReqParam.ParameterName = ServiceReqTemplateParam.NAME
  )
--LEFT JOIN [FusionAttachments] att ON att.RecID = ServiceReqParam.ParameterValue
OUTER APPLY (
			SELECT [event_type_combo] as "Event Type"
				,[event_name_text] as "Event Name"
				,[event_description_textarea] as "Event Description"
                ,[event_format_datetime] as "Event Date"
                ,[event_contact_textarea] as "Primary Contact"
                ,[event_seccontact_textarea] as "Secondary Contact"
                ,[event_branch_textarea] "Branch(es)"
                ,[division_combo] as "Division"
                ,[region_combo] as "Region"
                ,[district_listing_textarea] as "District"
                ,[event_incentive_checkbox] as "Customer Incentive Available"
                ,[profile_limit_checkbox] as "More than 5 Profiles"
                ,[events_incentives_combo] as "Number of Profiles"
                ,[event_profile_text] as "Profile #1"
                ,[event_PNamount_text] as "Profile Amount #1"
                ,[event_profile1_text] as "Profile #2"
                ,[event_PNamount1_text] as "Profile Amount #2"
                ,[event_profile2_text] as "Profile #3"
                ,[event_PNamount2_text] as "Profile Amount #3"
                ,[event_profile3_text] as "Profile #4"
                ,[event_PNamount3_text] as "Profile Amount #4"
                ,[event_profile4_tex] as "Profile #5"
                ,[event_PNamount4_text] as "Profile Amount #5"
                ,[event_funding_checkbox] as "Vendor Funding Available"
                ,[vendor_checkbox] as "More than 5 Vendors"
                ,[event_vendor_combo] as "Number of Vendors"
                ,[event_vendor_text] as "Vendor #1"
                ,[vendor_Eamount_text] as "Vendor Amount #1"
                ,[event_vendor1_text] as "Vendor #2"
                ,[vendor_Eamount1_text] as "Vendor Amount #2"
                ,[event_vendor2_text] as "Vendor #3"
                ,[vendor_Eamount2_text] as "Vendor Amount #3"
                ,[event_vendor3_text] as "Vendor #4"
                ,[vendor_Eamount3_text] as "Vendor Amount #4"
                ,[event_vendor4_text] as "Vendor #5"
                ,[vendor_Eamount4_text] as "Vendor Amount #5"
                ,[credit_total_text] as "Total Credits"
                ,[expense_checkbox] as "Expenses Available"
                ,[expense_limit_checkbox] as "More than 5 Expenses"
                ,[num_exp_combo] as "Number of Expenses"
                ,[event_requested_text] as "Estimated Total Credits"
                ,[event_esttotal_text] as "Estimated Total Expenses"
                ,[event_expense_text] as "Expense #1"
                ,[events_Eamount_text] as "Amount #1"
                ,[events_FOP_combo] as "Form of Payment #1"
                ,[events_payee_text] as "Payee #1"
                ,[events_CHName_text] as "Cardholder Name #1"
                ,[event_expense1_text] as "Expense #2"
                ,[events_Eamount1_text] as "Amount #2"
                ,[events_FOP_combo_1] as "Form of Payment #2"
                ,[events_payee1_text] as "Payee #2"
                ,[events_CHName1_text] as "Cardholder Name #2"
                ,[event_expense2_text] as "Expense #3"
                ,[events_Eamount2_text] as "Amount #3"
                ,[events_FOP_combo_2] as "Form of Payment #3"
                ,[events_payee2_text] as "Payee #3"
                ,[events_CHName2_text] as "Cardholder Name #3"
                ,[event_expense3_text] as "Expense #4"
                ,[events_Eamount3_text] as "Amount #4"
                ,[events_FOP_combo_3] as "Form of Payment #4"
                ,[events_payee3_text] as "Payee #4"
                ,[events_CHName3_text] as "Cardholder Name #4"
                ,[event_expense4_text] as "Expense #5"
                ,[events_Eamount4_text] as "Amount #5"
                ,[events_FOP_combo_4] as "Form of Payment #5"
                ,[events_payee4_text] as "Payee #5"
                ,[events_CHName4_text] as "Cardholder Name #5"
                ,[event_total_text] as "Total Expenses"
                ,[final_total_text] as "Final Total"
                ,[event_info_textarea] as "Additional Notes"
	FROM (
		SELECT ParameterValue
			,ParameterName
		FROM ServiceReqParam srp with (NOLOCK)
		WHERE srp.ParentLink_RecID = servicereq.RecID
		) AllParams
	pivot(max(ParameterValue) FOR ParameterName IN (
				[event_type_combo]
				,[event_name_text] 
				,[event_description_textarea] 
                ,[event_format_datetime] 
                ,[event_contact_textarea] 
                ,[event_seccontact_textarea] 
                ,[event_branch_textarea]
                ,[division_combo]
                ,[region_combo]
                ,[district_listing_textarea]
                ,[event_incentive_checkbox]
                ,[profile_limit_checkbox]
                ,[events_incentives_combo]
                ,[event_profile_text]
                ,[event_PNamount_text]
                ,[event_profile1_text]
                ,[event_PNamount1_text]
                ,[event_profile2_text]
                ,[event_PNamount2_text]
                ,[event_profile3_text]
                ,[event_PNamount3_text]
                ,[event_profile4_tex]
                ,[event_PNamount4_text]
                ,[event_funding_checkbox]
                ,[vendor_checkbox]
                ,[event_vendor_combo]
                ,[event_vendor_text]
                ,[vendor_Eamount_text]
                ,[event_vendor1_text]
                ,[vendor_Eamount1_text]
                ,[event_vendor2_text]
                ,[vendor_Eamount2_text]
                ,[event_vendor3_text]
                ,[vendor_Eamount3_text]
                ,[event_vendor4_text]
                ,[vendor_Eamount4_text]
                ,[credit_total_text]
                ,[expense_checkbox]
                ,[expense_limit_checkbox]
                ,[num_exp_combo]
                ,[event_requested_text]
                ,[event_esttotal_text]
                ,[event_expense_text]
                ,[events_Eamount_text]
                ,[events_FOP_combo]
                ,[events_payee_text]
                ,[events_CHName_text]
                ,[event_expense1_text]
                ,[events_Eamount1_text]
                ,[events_FOP_combo_1]
                ,[events_payee1_text]
                ,[events_CHName1_text]
                ,[event_expense2_text]
                ,[events_Eamount2_text]
                ,[events_FOP_combo_2]
                ,[events_payee2_text]
                ,[events_CHName2_text]
                ,[event_expense3_text]
                ,[events_Eamount3_text]
                ,[events_FOP_combo_3]
                ,[events_payee3_text]
                ,[events_CHName3_text]
                ,[event_expense4_text]
                ,[events_Eamount4_text]
                ,[events_FOP_combo_4]
                ,[events_payee4_text]
                ,[events_CHName4_text] 
                ,[event_total_text]
                ,[final_total_text]
                ,[event_info_textarea]
				)) PivotedParams
	) ServiceRequestParameters
	LEFT JOIN [Frs_def_validation_lists] val ON val.RecID = ServiceReqTemplateParam.ValidationList_RecID
WHERE (ServiceReqParam.ParentLink_RecID = (@RecId)) AND (ParameterValue IS NOT NULL) AND (ParameterValue NOT LIKE '%<%') AND (ServiceReqTemplateParam.DisplayName IS NOT NULL)
ORDER BY ServiceReqTemplateParam.SequenceNum
