-- 1. OPERATIONAL GAPS
-- 1.1. Calculate average wait time by department and triage levels
SELECT  department, 
		triage_level,
		ROUND(AVG(wait_time_min),0) AS avg_wait_time_min,
		COUNT (*) AS num_encounters
FROM outpatient_tbl ot 
WHERE ot.encounter_date IS NOT NULL 
GROUP BY ot.department ,ot.triage_level
ORDER BY avg_wait_time_min;

--1.2. No-Show rate(percentage) by referral sources and transport mode
SELECT 	referral_source,
		transport_mode,
		COUNT(*) AS total_appointments,
		SUM(CASE WHEN no_show = "Y" THEN 1 ELSE 0 END) AS num_no_show,
		ROUND(100.0 * SUM(CASE WHEN no_show = "Y" THEN 1 ELSE 0 END)/COUNT(*), 1) AS no_show_rate_pct
FROM outpatient_tbl ot 
GROUP BY ot.referral_source, ot.transport_mode 
ORDER BY no_show_rate_pct DESC;

--1.3. Average department TAT by whether labs or imaging were ordered
SELECT	ot.department,
		ot.labs_ordered,
		ot.imaging_ordered,
		ROUND(AVG(ot.results_tat_days),2) AS avg_tat_days,
		COUNT(*) AS num_cases
FROM outpatient_tbl ot 
WHERE ot.results_tat_days IS NOT NULL
GROUP BY ot.department, ot.labs_ordered, ot.imaging_ordered 
ORDER BY avg_tat_days DESC;

--2. ACCESS AND EQUITY GAPS
--2.1 Average distance and wait time by residence and income
SELECT 	residence,
		COALESCE(income_bracket, "Unknown") AS income_bracket,
		ROUND(AVG(distance_km),2) AS avg_distance_km,
		ROUND(AVG(wait_time_min),2) AS avg_wait_time_min,
		COUNT(*) AS num_patients
FROM outpatient_tbl
GROUP BY residence, income_bracket
ORDER BY avg_distance_km;

--2.2 Encounter counts and no-show rates by literacy and language 
SELECT 	ot.literacy_level,
		ot."language" ,
		COUNT(*) AS total_encounters,
		SUM(CASE WHEN no_show = "Y" THEN 1 ELSE 0 END) AS num_no_show,
		ROUND(100.0 * SUM(CASE WHEN no_show = "Y" THEN 1 ELSE 0 END)/COUNT(*), 1) AS no_show_rate_pct
FROM outpatient_tbl ot 
GROUP BY literacy_level,"language" 
ORDER BY no_show_rate_pct DESC;

--2.3 Insurance and department access by age bracket and gender
SELECT 	ot.sex AS Gender,
		CASE
			WHEN age < 18 THEN "Child"
			WHEN age BETWEEN 18 AND 64 THEN "Adult"
			ELSE "Senior"
		END AS age_group,
		ot.insurance_type,
		ot.department,
		COUNT(*) AS num_encounters
FROM outpatient_tbl ot 
WHERE age IS NOT NULL 
GROUP BY Gender,age_group,insurance_type,department 
ORDER BY num_encounters DESC;

--3. TREATMENT EFFECTIVENESS GAPS
--3.1 Calculate readmission rates by departments and chronic condition count
SELECT	department,
		chronic_conditions_count ,
		COUNT(*) AS total_encounters,
		SUM(CASE WHEN readmitted_30d = "Y" THEN 1 ELSE 0 END) AS num_readmission,
		ROUND(100.0 * SUM(CASE WHEN readmitted_30d = "Y" THEN 1 ELSE 0 END)/COUNT(*),0) AS readmission_rate
FROM outpatient_tbl
GROUP BY department,chronic_conditions_count 
ORDER BY readmission_rate DESC;

--3.2 Follow-up and no-show link bt diagnosis and referral source
SELECT	dt.description,
		ot.referral_source,
		ROUND(AVG(ot.follow_up_days),0) AS avg_follow_up_days,
		SUM(CASE WHEN no_show = "Y" THEN 1 ELSE 0 END) AS num_no_show,
		COUNT(*) AS total_cases
FROM outpatient_tbl ot 
INNER JOIN diagnosis_tbl dt 
		ON dt.code = ot.diagnosis_icd10 
GROUP BY diagnosis_icd10,referral_source 
ORDER BY avg_follow_up_days DESC;

--3.3 Examine Readmissions by procedure code and lab/imaging ordered
SELECT 	pt.description,
		ot.labs_ordered || '-' || ot.imaging_ordered AS tests_ordered,
		COUNT(*) AS total_procedure,
		SUM(CASE WHEN readmitted_30d = "Y" THEN 1 ELSE 0 END) AS num_readmission,
		ROUND(100.0 * SUM(CASE WHEN readmitted_30d = "Y" THEN 1 ELSE 0 END)/COUNT(*),0) AS readmission_rate
FROM outpatient_tbl ot 
INNER JOIN procedures_tbl pt 
		ON pt.code = ot.procedure_code 
GROUP BY procedure_code, tests_ordered
ORDER BY readmission_rate DESC;

--4. FINANCIAL GAPS
--4.1 Analyse billing amounts and payment satus by insurance
SELECT 	ot.insurance_type,
		ROUND(AVG(ot.billing_amount),2) AS avg_billing_amount,
		COUNT(*) AS total_bills,
		SUM(CASE 
				WHEN payment_status = "Denied" 
				OR payment_status = "Pending" 
				THEN 1 ELSE 0 END
				) AS num_unpaid_bills,
		ROUND(100.0 * SUM(CASE 
				WHEN payment_status = "Denied" 
				OR payment_status = "Pending" 
				THEN 1 ELSE 0 END
				)/ COUNT(*)) AS unpaid_rate_pct
FROM outpatient_tbl ot 
GROUP BY insurance_type 
ORDER BY num_unpaid_bills DESC ;

--4.2 Compare Billing amount and unpaid rate by income and residence
SELECT 	ot.income_bracket ,
		ot.residence,
		ROUND(AVG(ot.billing_amount),2) AS avg_billing_amount,
		COUNT(*) AS total_bills,
		SUM(CASE 
				WHEN payment_status != "Paid" 
				THEN 1 ELSE 0 END
				) AS num_unpaid_bills,
		ROUND(100.0 * SUM(CASE 
				WHEN payment_status != "Paid" 
				THEN 1 ELSE 0 END
				)/ COUNT(*)) AS unpaid_rate_pct
FROM outpatient_tbl ot 
GROUP BY income_bracket ,ot.residence  
ORDER BY unpaid_rate_pct DESC ;

--4.3 Examine denied payments by department and payer
SELECT 	ot.department ,
		ot.payer ,
		COUNT(*) AS total_bills,
				SUM(CASE 
				WHEN payment_status = "Denied" 
				THEN 1 ELSE 0 END
				) AS num_denied,
		ROUND(100.0 * SUM(CASE 
				WHEN payment_status = "Denied" 
				THEN 1 ELSE 0 END
				)/ COUNT(*)) AS denied_rate_pct
FROM outpatient_tbl ot 
GROUP BY ot.department ,ot.payer;















