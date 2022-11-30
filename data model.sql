--create time: 20221024
-- database C##RA_DM
-- set primary key 
-- set index 
-- not null // null 



--==========person==========--

create table C##RA_DM.person(
	person_id	NUMBER NOT NULL,
	gender_concept_id	NUMBER NULL,
	year_of_birth	NUMBER NULL,
	month_of_birth	NUMBER NULL,
	day_of_birth	NUMBER NULL,
	birth_datetime	DATE NULL,
	death_datetime	DATE NULL,
	race_concept_id	NUMBER NULL,
	ethnicity_concept_id	NUMBER NULL,
	location_id	NUMBER NULL,
	provider_id	NUMBER NULL,
	care_site_id	NUMBER NULL,
	person_source_value	VARCHAR2(50) NULL,
	gender_source_value	VARCHAR2(50) NULL,
	gender_source_concept_id	NUMBER NULL,
	race_source_value	VARCHAR2(50) NULL,
	race_source_concept_id	NUMBER NULL,
	ethnicity_source_value	VARCHAR2(50) NULL,
	ethnicity_source_concept_id	NUMBER NULL,
	CONSTRAINT pk_person PRIMARY KEY （person_id）
);
CREATE INDEX C##RA_DM.PERSON_PID_IDX on C##RA_DM.PERSON(PERSON_ID) nologging;

--==========visit_occurrence==========--

create table C##RA_DM.visit_occurrence(
	visit_occurrence_id	NUMBER NOT NULL,
	person_id	NUMBER NOT NULL,
	visit_concept_id	NUMBER NULL,
	visit_start_date	DATE NULL,
	visit_start_datetime	DATE NULL,
	visit_end_date	DATE NULL,
	visit_end_datetime	DATE NULL,
	visit_type_concept_id	NUMBER NULL,
	provider_id	NUMBER NULL,
	care_site_id	NUMBER NULL,
	visit_source_value	VARCHAR2(50) NULL,
	visit_source_concept_id	NUMBER NULL,
	admitting_source_concept_id	NUMBER NULL,
	admitting_source_value	VARCHAR2(50) NULL,
	discharge_to_concept_id	NUMBER NULL,
	discharge_to_source_value	VARCHAR2(50) NULL,
	preceding_visit_occurrence_id	NUMBER NULL,
	CONSTRAINT pk_visit_occurrence PRIMARY KEY (visit_occurrence_id),
	CONSTRAINT fk_visit_occurrence_person FOREIGN KEY (person_id) REFERENCES C##RA_DM.person(person_id)
)
create index C##RA_DM.VISIT_VID_IDX on C##RA_DM.visit_occurrence(visit_occurrence_id) nologging;
create index C##RA_DM.VISIT_PID_IDX on C##RA_DM.visit_occurrence(person_id) nologging;


--==========observation==========--

create table C##RA_DM.observation(
	observation_id	NUMBER NOT NULL,
	person_id	NUMBER NOT NULL,
	observation_concept_id	NUMBER NULL,
	observation_date	DATE NULL,
	observation_datetime	DATE NULL,
	observation_type_concept_id	NUMBER NULL,
	value_as_number	FLOAT NULL,
	value_as_string	VARCHAR2(60) NULL,
	value_as_concept_id	NUMBER NULL,
	qualifier_concept_id	NUMBER NULL,
	unit_concept_id	NUMBER NULL,
	provider_id	NUMBER NULL,
	visit_occurrence_id	NUMBER NOT NULL,
	visit_detail_id	NUMBER NULL,
	observation_source_value	VARCHAR2(50) NULL,
	observation_source_concept_id	NUMBER NULL,
	unit_source_value	VARCHAR2(50) NULL,
	qualifier_source_value	VARCHAR2(50) NULL,
	observation_event_id	NUMBER NULL,
	obs_event_field_concept_id	NUMBER NULL,
	value_as_datetime	NUMBER NULL,
	CONSTRAINT pk_observation PRIMARY KEY (observation_id),
	CONSTRAINT fk_observation_person FOREIGN KEY (person_id) REFERENCES C##RA_DM.person(person_id),
	CONSTRAINT fk_observation_visit_occurrence FOREIGN KEY (visit_occurrence_id) REFERENCES C##RA_DM.visit_occurrence(visit_occurrence_id) -- 需要确认表名
);
create index C##RA_DM.OBSERVATION_OID_IDX on C##RA_DM.OBSERVATION(OBSERVATION_ID) nologging;
create index C##RA_DM.OBSERVATION_PID_IDX on C##RA_DM.OBSERVATION(PERSON_ID) nologging;
create index C##RA_DM.OBSERVATION_VID_IDX on C##RA_DM.OBSERVATION(VISIT_OCCURRENCE_ID) nologging;

--==========measurement==========--

create table C##RA_DM.measurement(
	measurement_id	NUMBER NOT NULL,
	person_id	NUMBER NOT NULL ,
	measurement_concept_id	NUMBER NULL,
	measurement_date	DATE NULL,
	measurement_datetime	DATE NULL,
	measurement_time	VARCHAR2(10) NULL,
	measurement_type_concept_id	NUMBER NULL,
	operator_concept_id	NUMBER NULL,
	value_as_number	FLOAT NULL,
	value_as_concept_id	NUMBER NULL,
	unit_concept_id	NUMBER NULL,
	range_low	FLOAT NULL,
	range_high	FLOAT NULL,
	provider_id	NUMBER NULL,
	visit_occurrence_id	NUMBER NOT NULL,
	visit_detail_id	NUMBER NULL, 
	measurement_source_value	VARCHAR2(50) NULL,
	measurement_source_concept_id	NUMBER NULL,
	unit_source_value	VARCHAR2(50) NULL,
	value_source_value	VARCHAR2(50) NULL,
	CONSTRAINT pk_measurement PRIMARY KEY (measurement_id),
	CONSTRAINT fk_measurement_person FOREIGN KEY (person_id) REFERENCES C##RA_DM.person(person_id),
	CONSTRAINT fk_measurement_visit_occurrence FOREIGN KEY (visit_occurrence_id) REFERENCES C##RA_DM.visit_occurrence(visit_occurrence_id) -- 需要确认表名
);
create index C##RA_DM.MEASUREMENT_PK_IDX on C##RA_DM.MEASUREMENT(MEASUREMENT_ID) nologging;
create index C##RA_DM.MEASUREMENT_PID_IDX on C##RA_DM.MEASUREMENT(PERSON_ID) nologging;
create index C##RA_DM.MEASUREMENT_VID_IDX on C##RA_DM.MEASUREMENT(VISIT_OCCURRENCE_ID) nologging;
create index C##RA_DM.MEASUREMENT_CID_IDX on C##RA_DM.MEASUREMENT(MEASUREMENT_CONCEPT_ID) nologging;
create index C##RA_DM.MEASUREMENT_DATE1_IDX on C##RA_DM.MEASUREMENT(MEASUREMENT_DATE) nologging;
create index C##RA_DM.MEASUREMENT_VACID_IDX on C##RA_DM.MEASUREMENT(VALUE_AS_CONCEPT_ID) nologging;
create index C##RA_DM.MEASUREMENT_TCID_IDX on C##RA_DM.MEASUREMENT(MEASUREMENT_TYPE_CONCEPT_ID) nologging;
create index C##RA_DM.MEASUREMENT_UCID_IDX on C##RA_DM.MEASUREMENT(UNIT_CONCEPT_ID) nologging;
create index C##RA_DM.MEASUREMENT_OCID_IDX on C##RA_DM.MEASUREMENT(OPERATOR_CONCEPT_ID) nologging;
create index C##RA_DM.MEASUREMENT_SVID_IDX on C##RA_DM.MEASUREMENT(MEASUREMENT_SOURCE_VALUE) nologging;

--==========survey_conduct==========--

create table C##RA_DM.survey_conduct(
	survey_conduct_id	NUMBER NOT NULL,
	person_id	NUMBER NOT NULL,
	survey_concept_id	NUMBER NULL,
	survey_start_date	DATE NULL,
	survey_start_datetime	DATE NULL,
	survey_end_date	DATE NULL,
	survey_end_datetime	DATE NULL,
	provider_id	NUMBER NULL,
	assisted_concept_id	NUMBER NULL,
	respondent_type_concept_id	NUMBER NULL,
	timing_concept_id	NUMBER NULL,
	collection_method_concept_id	NUMBER NULL,
	assisted_source_value	VARCHAR2(50) NULL,
	respondent_type_source_value	VARCHAR2(100) NULL,
	timing_source_value	VARCHAR2(100) NULL,
	collection_method_source_value	VARCHAR2(100) NULL,
	survey_source_value	VARCHAR2(100) NULL,
	survey_source_concept_id	NUMBER NULL,
	survey_source_identifier	VARCHAR2(100) NULL,
	validated_survey_concept_id	NUMBER NULL,
	validated_survey_source_value	NUMBER NULL,
	survey_version_number	VARCHAR2(20) NULL,
	visit_occurrence_id	NUMBER NOT NULL,
	response_visit_occurrence_id	NUMBER NULL,
	CONSTRAINT pk_survery_conduct PRIMARY KEY (survey_conduct_id)，
	CONSTRAINT fk_survery_conduct_person FOREIGN KEY (person_id) REFERENCES C##RA_DM.person(person_id),
	CONSTRAINT fk_survery_conduct_visit_occurrence FOREIGN KEY (visit_occurrence_id) REFERENCES C##RA_DM.visit_occurrence(visit_occurrence_id) -- 需要确认表名
);
create index C##RA_DM.SURVERY_SCID_IDX on C##RA_DM.survey_conduct(survey_conduct_id) nologging;
create index C##RA_DM.SURVERY_PID_IDX on C##RA_DM.survey_conduct(person_id) nologging;
create index C##RA_DM.SURVERY_VID_IDX on C##RA_DM.survey_conduct(visit_occurrence_id) nologging;

--==========drug_exposure==========--

create table C##RA_DM.drug_exposure(
	drug_exposure_id	NUMBER NOT NULL,
	person_id	NUMBER NOT NULL ,
	drug_concept_id	NUMBER NULL,
	drug_exposure_start_date	DATE NULL,
	drug_exposure_start_datetime	DATE NULL,
	drug_exposure_end_date	DATE NULL,
	drug_exposure_end_datetime	DATE NULL,
	verbatim_end_date	DATE NULL,
	drug_type_concept_id	NUMBER NULL,
	stop_reason	VARCHAR2(20) NULL,
	refills	NUMBER NULL,
	quantity	FLOAT NULL,
	days_supply	NUMBER NULL,
	sig	VARCHAR2(500) NULL,
	route_concept_id	NUMBER NULL,
	lot_number	VARCHAR2(50) NULL,
	provider_id	NUMBER NULL,
	visit_occurrence_id	NUMBER NOT NULL,
	visit_detail_id	NUMBER NULL,
	drug_source_value	VARCHAR2(50) NULL,
	drug_source_concept_id	NUMBER NULL,
	route_source_value	VARCHAR2(50) NULL,
	dose_unit_source_value	VARCHAR2(50) NULL,
	CONSTRAINT pk_drug_exposure PRIMARY KEY (drug_exposure_id)，
	CONSTRAINT fk_drug_exposure_person FOREIGN KEY (person_id) REFERENCES C##RA_DM.person(person_id),
	CONSTRAINT fk_drug_exposure_visit_occurrence FOREIGN KEY (visit_occurrence_id) REFERENCES C##RA_DM.visit_occurrence(visit_occurrence_id) -- 需要确认表名
);
create index C##RA_DM.DRUG_PK_IDX on C##RA_DM.DRUG_EXPOSURE(DRUG_EXPOSURE_ID) nologging;
create index C##RA_DM.DRUG_PID_IDX on C##RA_DM.DRUG_EXPOSURE(PERSON_ID) nologging;
create index C##RA_DM.DRUG_VID_IDX on C##RA_DM.DRUG_EXPOSURE(VISIT_OCCURRENCE_ID) nologging;
create index C##RA_DM.DRUG_CID_IDX on C##RA_DM.DRUG_EXPOSURE(DRUG_CONCEPT_ID) nologging;
create index C##RA_DM.DRUG_DATE1_IDX on C##RA_DM.DRUG_EXPOSURE(DRUG_EXPOSURE_START_DATE) nologging;
create index C##RA_DM.DRUG_DATE2_IDX on C##RA_DM.DRUG_EXPOSURE(DRUG_EXPOSURE_END_DATE) nologging;
create index C##RA_DM.DRUG_SCID_IDX on C##RA_DM.DRUG_EXPOSURE(DRUG_SOURCE_CONCEPT_ID) nologging;

--==========specimen==========--

create table C##RA_DM.specimen(
	specimen_id	NUMBER NOT NULL,
	person_id	NUMBER NOT NULL,
	specimen_concept_id	NUMBER NULL,
	specimen_type_concept_id	NUMBER NULL,
	specimen_date	DATE NULL,
	specimen_datetime	DATE NULL,
	quantity	FLOAT NULL,
	unit_concept_id	NUMBER NULL,
	anatomic_site_concept_id	NUMBER NULL,
	disease_status_concept_id	NUMBER NULL,
	specimen_source_id	VARCHAR2(50) NULL,
	specimen_source_value	VARCHAR2(50) NULL,
	unit_source_value	VARCHAR2(50) NULL,
	anatomic_site_source_value	VARCHAR2(50) NULL,
	disease_status_source_value	VARCHAR2(50) NULL,
	exp_id VARCHAR2(50) NOT NULL, -- 新增的字段
	CONSTRAINT pk_specimen PRIMARY KEY (specimen_id),
	CONSTRAINT fk_specimen_person FOREIGN KEY (person_id) REFERENCES C##RA_DM.person(person_id),
	CONSTRAINT fk_specimen_exp FOREIGN KEY (exp_id) REFERENCES C##RA_DM.experiment(exp_id)
);
create index C##RA_DM.SPECIMEN_SID_IDX on C##RA_DM.specimen(specimen_id) nologging;
create index C##RA_DM.SPECIMEN_PID_IDX on C##RA_DM.specimen(person_id) nologging;
create index C##RA_DM.SPECIMEN_VID_IDX on C##RA_DM.specimen(visit_occurrence_id) nologging;
create index C##RA_DM.SPECIMEN_EID_IDX on C##RA_DM.specimen(exp_id) nologging;


--==========evaluation==========--

create table C##RA_DM.evaluation(
	person_id NUMBER NOT NULL,
	visit_occurrence_id NUMBER NOT NULL,
	evaluation_id NUMBER NOT NULL,
	evaluation_datetime DATE NULL,
	evaluation_name VARCHAR2(50) NULL,
	evaluation_value VARCHAR2(50) NULL,
	CONSTRAINT pk_evaluation PRIMARY KEY (evaluation_id),
	CONSTRAINT fk_evaluation_person FOREIGN KEY (person_id) REFERENCES C##RA_DM.person(person_id),
	CONSTRAINT fk_evaluation_visit_occurrence FOREIGN KEY (visit_occurrence_id) REFERENCES C##RA_DM.visit_occurrence(visit_occurrence_id) -- 需要确认表名
);

create index C##RA_DM.EVALUATION_PID_IDX on C##RA_DM.evaluation(person_id) nologging;
create index C##RA_DM.EVALUATION_VID_IDX on C##RA_DM.evaluation(visit_occurrence_id) nologging;
create index C##RA_DM.EVALUATION_EID_IDX on C##RA_DM.evaluation(evaluation_id) nologging;


--==========adverse_event==========--

create table C##RA_DM.adverse_event(
	person_id NUMBER NOT NULL,
	visit_occurrence_id NUMBER NOT NULL,
	adverse_event_id NUMBER NOT NULL,
	adverse_event_start_datetime DATE NULL,
	adverse_event_end_datetime DATE NULL,
	adverse_event_name VARCHAR2(50) NULL,
	CONSTRAINT pk_adverse_event PRIMARY KEY (adverse_event_id),
	CONSTRAINT fk_adverse_event_person FOREIGN KEY (person_id) REFERENCES C##RA_DM.person(person_id),
	CONSTRAINT fk_adverse_event_visit_occurrence FOREIGN KEY (visit_occurrence_id) REFERENCES C##RA_DM.visit_occurrence(visit_occurrence_id) -- 需要确认表名	
);

create index C##RA_DM.ADVERSE_PID_IDX on C##RA_DM.adverse_event(person_id) nologging;
create index C##RA_DM.ADVERSE_VID_IDX on C##RA_DM.adverse_event(visit_occurrence_id) nologging;
create index C##RA_DM.ADVERSE_AEID_IDX on C##RA_DM.adverse_event(adverse_event_id) nologging;

--==========multimodal_examination==========--

create table C##RA_DM.multimodal_examination( 
	person_id NUMBER NOT NULL,
	visit_occurrence_id NUMBER NOT NULL,
	examination_id VARCHAR2(50) NOT NULL,
	examination_datetime DATE NULL,
	examination_type VARCHAR2(50) NULL,
	examination_name VARCHAR2(50) NULL,
	examination_image_id VARCHAR2(50) NULL,
	examination_image_address	VARCHAR2(50) NULL,
	CONSTRAINT pk_multi_exam PRIMARY KEY (examination_id),
	CONSTRAINT fk_multi_exam_person FOREIGN KEY (person_id) REFERENCES C##RA_DM.person(person_id),
	CONSTRAINT fk_multi_exam_visit_occurrence FOREIGN KEY (visit_occurrence_id) REFERENCES C##RA_DM.visit_occurrence(visit_occurrence_id) -- 需要确认表名
);
create index C##RA_DM.MULTIMODAL_PID_IDX on C##RA_DM.multimodal_examination( person_id) nologging;
create index C##RA_DM.MULTIMODAL_VID_IDX on C##RA_DM.multimodal_examination(visit_occurrence_id) nologging;
create index C##RA_DM.MULTIMODAL_EID_IDX on C##RA_DM.multimodal_examination(examination_id) nologging;
create index C##RA_DM.MULTIMODAL_EIID_IDX on C##RA_DM.multimodal_examination(examination_image_id) nologging; 

--==========experiment==========--
create table C##RA_DM.experiment(
	exp_id	VARCHAR2(100) NOT NULL,
	exp_type	VARCHAR2(100)  NULL,
	specimen_id	VARCHAR2(100) NOT NULL,
	parameter_id	VARCHAR2(100) NOT NULL,
	CONSTRAINT pk_experiment_exp PRIMARY KEY (exp_id),
	CONSTRAINT fk_experiment_specimen PRIMARY KEY (specimen_id),
	CONSTRAINT fk_experiment_parameter FOREIGN KEY (parameter_id) REFERENCES C##RA_DM.parameter(parameter_id)
);
create index C##RA_DM.experiment_eid_idx on C##RA_DM.experiment(experiment_id) nologging;
create index C##RA_DM.experiment_sid_idx on C##RA_DM.experiment(specimen_id) nologging;
create index C##RA_DM.experiment_pid_idx on C##RA_DM.experiment(parameter_id) nologging;

--==========analysis==========--
create table C##RA_DM.analysis(
	analysis_id	VARCHAR2(100) NOT NULL,
	analysis_type	VARCHAR2(100) NULL,
	group_id	VARCHAR2(100) NOT NULL,
	exp_id	VARCHAR2(100) NOT NULL,
	parameter_id	VARCHAR2(100) NOT NULL,
	CONSTRAINT pk_analysis PRIMARY KEY (analysis_id),
	CONSTRAINT fk_analysis_group FOREIGN KEY (group_id) REFERENCES C##RA_DM.group(group_id),
	CONSTRAINT fk_analysis_exp FOREIGN KEY (exp_id) REFERENCES C##RA_DM.experiment(exp_id),
	CONSTRAINT fk_analysis_parameter FOREIGN KEY (parameter_id) REFERENCES C##RA_DM.parameter(parameter_id)
);
create index C##RA_DM.analysis_aid_idx on C##RA_DM.analysis(analysis_id) nologging;
create index C##RA_DM.analysis_gid_idx on C##RA_DM.analysis(group_id) nologging;
create index C##RA_DM.analysis_eid_idx on C##RA_DM.analysis(exp_id) nologging;
create index C##RA_DM.analysis_pid_idx on C##RA_DM.analysis(parameter_id) nologging;

--==========group==========--
create table C##RA_DM.group(
	group_id VARCHAR2(100) NOT NULL,
	group_name VARCHAR2(100) NULL,
	specimen_id VARCHAR2(100) NOT NULL,
	analysis_id VARCHAR2(100) NOT NULL,
	exp_id VARCHAR2(100) NOT NULL,
	person_id VARCHAR2(100) NOT NULL,
	CONSTRAINT pk_group PRIMARY KEY (group_id),
	CONSTRAINT fk_group_specimen PRIMARY KEY (specimen_id) REFERENCES C##RA_DM.specimen(specimen_id),
	CONSTRAINT fk_group_analysis FOREIGN KEY (analysis_id) REFERENCES C##RA_DM.analysis(analysis_id),
	CONSTRAINT fk_group_exp FOREIGN KEY (exp_id) REFERENCES C##RA_DM.experiment(exp_id),
	CONSTRAINT fk_group_person FOREIGN KEY (person_id) REFERENCES C##RA_DM.person(person_id)
);
create index C##RA_DM.group_gid_idx on C##RA_DM.group(group_id) nologging;
create index C##RA_DM.group_sid_idx on C##RA_DM.group(specimen_id) nologging;
create index C##RA_DM.group_aid_idx on C##RA_DM.group(analysis_id) nologging;
create index C##RA_DM.group_eid_idx on C##RA_DM.group(exp_id) nologging;
create index C##RA_DM.group_pid_idx on C##RA_DM.group(person_id) nologging;


--==========parameter==========--
create table C##RA_DM.parameter(
	parameter_id VARCHAR2(100) NOT NULL,
	parameter_file VARCHAR2(100) NULL,
	parameter_file_address VARCHAR2(200)  NULL,
	analysis_id VARCHAR2(100) NOT NULL,
	exp_id VARCHAR2(100) NOT NULL,
	CONSTRAINT pk_parameter PRIMARY KEY (parameter_id),
	CONSTRAINT fk_parameter_analysis FOREIGN KEY (analysis_id) REFERENCES C##RA_DM.analysis(analysis_id),
	CONSTRAINT fk_parameter_exp FOREIGN KEY (exp_id) REFERENCES C##RA_DM.experiment(exp_id)
);
create index C##RA_DM.parameter_pid_idx on C##RA_DM.parameter(parameter_id) nologging;
create index C##RA_DM.parameter_aid_idx on C##RA_DM.parameter(analysis_id) nologging;
create index C##RA_DM.parameter_eid_idx on C##RA_DM.parameter(exp_id) nologging;

--==========mz_raw_data==========--
create table C##RA_DM.mz_raw_data(
	raw_ms_file_name	VARCHAR2(100) NOT NULL,
	raw_ms_data_f_address	VARCHAR2(200) NULL,
	exp_type	VARCHAR2(50) NULL,
	specimen_id	VARCHAR2(100) NOT NULL,
	exp_id	VARCHAR2(100) NOT NULL,
	CONSTRAINT pk_mz_raw_data PRIMARY KEY(raw_ms_file_name),
	CONSTRAINT fk_mz_raw_data_specimen FOREIGN KEY (analysis_id) REFERENCES C##RA_DM.specimen(specimen_id),
	CONSTRAINT fk_mz_raw_data_exp FOREIGN KEY (exp_id) REFERENCES C##RA_DM.experiment(exp_id)
);
create index C##RA_DM.mz_raw_data_fn_idx on C##RA_DM.mz_raw_data(raw_ms_file_name) nologging;
create index C##RA_DM.mz_raw_data_sid on C##RA_DM.mz_raw_data(specimen_id) nologging;
create index C##RA_DM.mz_raw_data_eid on C##RA_DM.mz_raw_data(exp_id) nologging;


--==========metabo_molecular==========--
create table C##RA_DM.metabo_molecular(
	metabo_molecular_id	number NOT NULL,
	molecular	VARCHAR2(100) NULL,
	molecular_id	VARCHAR2(50) NOT NULL,
	ion_charge	VARCHAR2(50) NULL,
	adducts	VARCHAR2(50) NULL,
	formula	VARCHAR2(50) NULL,
	mz	number NULL,
	intensity	number NULL,
	retention_time	number NULL,
	fold_change	number NULL,
	fdr	number NULL,
	vip_score	number NULL,
	exp_id	VARCHAR2(100) NOT NULL,
	exp_type	VARCHAR2(100) NULL,
	group_name	VARCHAR2(100) NOT NULL,
	analysis_id	VARCHAR2(100) NOT NULL,
	CONSTRAINT pk_metabo_molecular PRIMARY KEY (metabo_molecular_id),
	CONSTRAINT fk_metabo_molecular_analysis FOREIGN KEY  (analysis_id) REFERENCES C##RA_DM.analysis(analysis_id),
	CONSTRAINT fk_metabo_molecular_exp FOREIGN KEY (exp_id) REFERENCES C##RA_DM.experiment(exp_id),
	CONSTRAINT fk_metabo_molecular_group FOREIGN KEY (group_name) REFERENCES C##RA_DM.group(group_name)

);
create index C##RA_DM.metabo_molecular_mid_idx on C##RA_DM.metabo_molecular(molecular_id) nologging;
create index C##RA_DM.metabo_molecular_aid_idx on C##RA_DM.metabo_molecular(analysis_id) nologging;
create index C##RA_DM.metabo_molecular_eid_idx on C##RA_DM.metabo_molecular(exp_id) nologging;

--==========metabo_enrichment==========--
create table C##RA_DM.metabo_enrichment(
	metabo_enrichment_id	number NOT NULL,
	enrichment_id	VARCHAR2(100),
	pathway_id	VARCHAR2(100) ,
	pathway	VARCHAR2(100),
	molecular_id	VARCHAR2(100) NOT NULL,
	molecular	VARCHAR2(100),
	fdr	number,
	adjust_fdr	number,
	exp_id	VARCHAR2(100) NOT NULL,
	group_name	VARCHAR2(100) NOT NULL,
	analysis_id	VARCHAR2(100) NOT NULL,
	CONSTRAINT pk_metabo_enrichment PRIMARY KEY (metabo_enrichment_id),
	CONSTRAINT fk_metabo_enrichment_molecular FOREIGN KEY (molecular_id) REFERENCES C##RA_DM.metabo_molecular(molecular_id),
	CONSTRAINT fk_metabo_enrichment_exp FOREIGN KEY (exp_id) REFERENCES C##RA_DM.experiment(exp_id),
	CONSTRAINT fk_metabo_enrichment_group FOREIGN KEY (group_name) REFERENCES C##RA_DM.group(group_name),
	CONSTRAINT fk_metabo_enrichment_analysis FOREIGN KEY (analysis_id) REFERENCES C##RA_DM.analysis(analysis_id)
);
create index C##RA_DM.metabo_enrichment_eid_idx on C##RA_DM.metabo_enrichment(metabo_enrichment_id) nologging;
create index C##RA_DM.metabo_enrichment_mol_idx on C##RA_DM.metabo_enrichment(molecular_id) nologging;
create index C##RA_DM.metabo_enrichment_eid_idx on C##RA_DM.metabo_enrichment(exp_id) nologging;
create index C##RA_DM.metabo_enrichment_gn_idx on C##RA_DM.metabo_enrichment(group_name) nologging;
create index C##RA_DM.metabo_enrichment_aid_idx on C##RA_DM.metabo_enrichment(analysis_id) nologging;



--==========sig_cell_trans_seq==========--
create table C##RA_DM.sig_cell_trans_seq(
	sig_cell_trans_seq_id	number NOT NULL,
	seq_id	VARCHAR2(100),
	seq_file_name	VARCHAR2(100),
	specimen_id	VARCHAR2(100) NOT NULL,
	cell_id	VARCHAR2(100),
	ncount_rna	number,
	nfeature_rna	number,
	percent_mt	number,
	percent_hb	number,
	percent_rps	number,
	percent_rpl	number,
	percent_rrna	number,
	seq_address	VARCHAR2(100),
	exp_id	VARCHAR2(100) NOT NULL,
	CONSTRAINT pk_sig_cell_trans_seq PRIMARY KEY (sig_cell_trans_seq_id),
	CONSTRAINT fk_sig_cell_trans_seq_specimen FOREIGN KEY (specimen_id) REFERENCES C##RA_DM.specimen(specimen_id),
	CONSTRAINT fk_sig_cell_trans_seq_exp FOREIGN KEY (exp_id) REFERENCES C##RA_DM.experiment(exp_id)
);

create index C##RA_DM.sig_cell_trans_seq_sid_idx on C##RA_DM.sig_cell_trans_seq(sig_cell_trans_seq_id) nologging;
create index C##RA_DM.sig_cell_trans_seq_spec_idx on C##RA_DM.sig_cell_trans_seq(specimen_id) nologging;
create index C##RA_DM.sig_cell_trans_seq_eid_idx on C##RA_DM.sig_cell_trans_seq(exp_id) nologging;


--==========sig_cell_trans_raw_count==========--
create table C##RA_DM.sig_cell_trans_raw_count(
	sig_cell_trans_raw_count_id	number NOT NULL,
	gene	VARCHAR2(100),
	gene_id	VARCHAR2(100),
	cell_type	VARCHAR2(100),
	cell_id	VARCHAR2(100),
	specimen_id	VARCHAR2(100),
	reads_row_count	number,
	row_count_type	VARCHAR2(100),
	exp_id	VARCHAR2(100) NOT NULL,
	analysis_id	VARCHAR2(100) NOT NULL,
	CONSTRAINT pk_sig_cell_trans_raw_count PRIMARY KEY (sig_cell_trans_raw_count_id),
	CONSTRAINT fk_sig_cell_trans_raw_count_exp FOREIGN KEY (exp_id) REFERENCES C##RA_DM.experiment(exp_id),
	CONSTRAINT fk_sig_cell_trans_raw_count_analysis FOREIGN KEY (analysis_id) REFERENCES C##RA_DM.analysis(analysis_id)
);
create index C##RA_DM.sig_cell_trans_raw_count_sidx on C##RA_DM.sig_cell_trans_raw_count(sig_cell_trans_raw_count_id) nologging;
create index C##RA_DM.sig_cell_trans_raw_count_eidx on C##RA_DM.sig_cell_trans_raw_count(exp_id) nologging;
create index C##RA_DM.sig_cell_trans_raw_count_aidx on C##RA_DM.sig_cell_trans_raw_count(analysis_id) nologging;



--==========sig_cell_trans_cluster==========--
create table C##RA_DM.sig_cell_trans_cluster(
	sig_cell_trans_cluster_id	number NOT NULL,
	cluster_id	VARCHAR2(100),
	seq_id	VARCHAR2(100),
	cell_type	VARCHAR2(100),
	cell_id	VARCHAR2(100),
	coordinate_x	number,
	coordinate_y	number,
	exp_id	VARCHAR2(100) NOT NULL,
	group_name	VARCHAR2(100) NOT NULL,
	analysis_id	VARCHAR2(100) NOT NULL,
	CONSTRAINT pk_sig_cell_trans_cluster PRIMARY KEY (sig_cell_trans_cluster_id),
	CONSTRAINT fk_sig_cell_trans_cluster_exp FOREIGN KEY (exp_id) REFERENCES C##RA_DM.experiment(exp_id),
	CONSTRAINT fk_sig_cell_trans_cluster_group FOREIGN KEY (group_name) REFERENCES C##RA_DM.group(group_name),
	CONSTRAINT fk_sig_cell_trans_cluster_analysis FOREIGN KEY (analysis_id) REFERENCES C##RA_DM.analysis(analysis_id)
);
create index C##RA_DM.sig_cell_trans_cluster_sidx on C##RA_DM.sig_cell_trans_cluster(sig_cell_trans_cluster_id) nologging;
create index C##RA_DM.sig_cell_trans_cluster_eidx on C##RA_DM.sig_cell_trans_cluster(exp_id) nologging;
create index C##RA_DM.sig_cell_trans_cluster_gidx on C##RA_DM.sig_cell_trans_cluster(group_name) nologging;
create index C##RA_DM.sig_cell_trans_cluster_aidx on C##RA_DM.sig_cell_trans_cluster(analysis_id) nologging;



--==========trans_diff_analysis==========--
create table C##RA_DM.trans_diff_analysis(
	sig_cell_trans_diff_analysis	number NOT NULL,
	diff_analysis_id	VARCHAR2(100),
	cluster_id	VARCHAR2(100) NOT NULL,
	gene_id	VARCHAR2(100),
	p_value	number,
	p_value_adj	number,
	avg_log_fold_change	number,
	percent_1	number,
	percent_2	number,
	exp_id	VARCHAR2(100) NOT NULL,
	group_name	VARCHAR2(100) NOT NULL,
	analysis_id	VARCHAR2(100) NOT NULL,
	CONSTRAINT pk_trans_diff_analysis PRIMARY KEY(sig_cell_trans_diff_analysis),
	CONSTRAINT fk_trans_diff_analysis_cluster FOREIGN KEY (cluster_id) REFERENCES C##RA_DM.sig_cell_trans_cluster(cluster_id),
	CONSTRAINT fk_trans_diff_analysis_exp FOREIGN KEY (exp_id) REFERENCES C##RA_DM.experiment(exp_id),
	CONSTRAINT fk_trans_diff_analysis_group FOREIGN KEY (group_name) REFERENCES C##RA_DM.group(group_name),
	CONSTRAINT fk_trans_diff_analysis_analysis FOREIGN KEY (analysis_id) REFERENCES C##RA_DM.analysis(analysis_id)
);
create index C##RA_DM.trans_diff_analysis_sidx on C##RA_DM.trans_diff_analysis(sig_cell_trans_diff_analysis) nologging;
create index C##RA_DM.trans_diff_analysis_cidx on C##RA_DM.trans_diff_analysis(cluster_id) nologging;
create index C##RA_DM.trans_diff_analysis_eidx on C##RA_DM.trans_diff_analysis(exp_id) nologging;
create index C##RA_DM.trans_diff_analysis_gidx on C##RA_DM.trans_diff_analysis(group_name) nologging;
create index C##RA_DM.trans_diff_analysis_aidx on C##RA_DM.trans_diff_analysis(analysis_id) nologging;



--==========proteo_proteingroup==========--
create table C##RA_DM.proteo_proteingroup(
	proteo_proteingroup_id	number NOT NULL,
	protein_group_id	VARCHAR2(100),
	majority_protein_id	VARCHAR2(100),
	protein_name	VARCHAR2(100),
	gene_id	VARCHAR2(100),
	gene_name	VARCHAR2(100),
	fasta_headers	VARCHAR2(100),
	peptide_counts_all	number,
	specimen_id_a	number,
	specimen_id_b	number,
	count_item	VARCHAR2(100),
	count	number,
	count_type	number,
	identification_item	VARCHAR2(100),
	identification_type	VARCHAR2(100),
	other_id_item	VARCHAR2(100),
	other_id	VARCHAR2(100),
	exp_id	VARCHAR2(100) NOT NULL,
	exp_type	VARCHAR2(100),
	group_name	VARCHAR2(100) NOT NULL,
	analysis_id	VARCHAR2(100) NOT NULL,
	CONSTRAINT pk_proteo_proteingroup PRIMARY KEY(proteo_proteingroup_id),
	CONSTRAINT fk_proteo_proteingroup_exp FOREIGN KEY (exp_id) REFERENCES C##RA_DM.experiment(exp_id),
	CONSTRAINT fk_proteo_proteingroup_group FOREIGN KEY (group_name) REFERENCES C##RA_DM.group(group_name),
	CONSTRAINT fk_proteo_proteingroup_analysis FOREIGN KEY (analysis_id) REFERENCES C##RA_DM.analysis(analysis_id)
);

create index C##RA_DM.proteo_proteingroup_pidx on C##RA_DM.proteo_proteingroup(proteo_proteingroup_id) nologging;
create index C##RA_DM.proteo_proteingroup_eidx on C##RA_DM.proteo_proteingroup(exp_id) nologging;
create index C##RA_DM.proteo_proteingroup_gnidx on C##RA_DM.proteo_proteingroup(group_name) nologging;
create index C##RA_DM.proteo_proteingroup_aidx on C##RA_DM.proteo_proteingroup(analysis_id) nologging;




--==========proteo_diff_analysis==========--
create table C##RA_DM.proteo_diff_analysis(
	proteo_diff_analysis_id	number NOT NULL,
	diff_analysis_id	VARCHAR2(100),
	protein_id	VARCHAR2(100),
	protein	VARCHAR2(100),
	refseq_id	VARCHAR2(100),
	peptide_seq	VARCHAR2(100),
	seq_start	number,
	seq_end	number,
	logfc	number,
	aveexpr	number,
	t_statistic	number,
	p_value	number,
	adj_p_value	number,
	b	number,
	specimen_id	VARCHAR2(100),
	group_name	VARCHAR2(100)  NOT NULL,
	exp_id	VARCHAR2(100) NOT NULL,
	exp_type	VARCHAR2(100),
	analysis_id	VARCHAR2(100) NOT NULL,
	CONSTRAINT pk_proteo_diff_analysis PRIMARY KEY(proteo_diff_analysis_id),
	CONSTRAINT fk_proteo_diff_analysis_group FOREIGN KEY (group_name) REFERENCES C##RA_DM.group(group_name),
	CONSTRAINT fk_proteo_diff_analysis_exp FOREIGN KEY (exp_id) REFERENCES C##RA_DM.experiment(exp_id),
	CONSTRAINT fk_proteo_diff_analysis_analysis FOREIGN KEY (analysis_id) REFERENCES C##RA_DM.analysis(analysis_id)
);
create index C##RA_DM.proteo_diff_analysis_pidx on C##RA_DM.proteo_diff_analysis(proteo_diff_analysis_id) nologging;
create index C##RA_DM.proteo_diff_analysis_gnidx on C##RA_DM.proteo_diff_analysis(group_name) nologging;
create index C##RA_DM.proteo_diff_analysis_eidx on C##RA_DM.proteo_diff_analysis(exp_id) nologging;
create index C##RA_DM.proteo_diff_analysis_aidx on C##RA_DM.proteo_diff_analysis(analysis_id) nologging;

--==========proteo_enrichment==========--
create table C##RA_DM.proteo_enrichment(
	proteo_enrichment_id	number NOT NULL,
	enrichment_id	VARCHAR2(100),
	enrichment_type	VARCHAR2(100),
	term_id	VARCHAR2(100),
	term_name	VARCHAR2(100),
	uniprot_id	VARCHAR2(100),
	gene_id	VARCHAR2(100),
	protein	VARCHAR2(100),
	gene	VARCHAR2(100),
	generatio	number,
	bgration	number,
	p_value	number,
	adjust_p_value	number,
	q_value	number,
	count	number,
	exp_id	VARCHAR2(100)  NOT NULL,
	group_name	VARCHAR2(100)  NOT NULL,
	analysis_id	VARCHAR2(100)  NOT NULL,
	CONSTRAINT pk_proteo_enrichment PRIMARY KEY(proteo_enrichment_id),
	CONSTRAINT fk_proteo_enrichment_group FOREIGN KEY (group_name) REFERENCES C##RA_DM.group(group_name),
	CONSTRAINT fk_proteo_enrichment_exp FOREIGN KEY (exp_id) REFERENCES C##RA_DM.experiment(exp_id),
	CONSTRAINT fk_proteo_enrichment_analysis FOREIGN KEY (analysis_id) REFERENCES C##RA_DM.analysis(analysis_id)
);
create index C##RA_DM.proteo_enrichment_pidx on C##RA_DM.proteo_enrichment(proteo_enrichment_id) nologging;
create index C##RA_DM.proteo_enrichment_eidx on C##RA_DM.proteo_enrichment(exp_id) nologging;
create index C##RA_DM.proteo_enrichment_gnidx on C##RA_DM.proteo_enrichment(group_name) nologging;
create index C##RA_DM.proteo_enrichment_aidx on C##RA_DM.proteo_enrichment(analysis_id) nologging;

--==========interactome_db==========--
create table C##RA_DM.interactome_db(
	interactome_db_id	number NOT NULL,
	interactor_a_id	VARCHAR2(100),
	interactor_name_a	VARCHAR2(100),
	interactor_b_id	VARCHAR2(100),
	interactor_name_b	VARCHAR2(100),
	subcell_localization	VARCHAR2(100),
	resource_db	VARCHAR2(100),
	confidence	VARCHAR2(100),
	type	VARCHAR2(100),
	CONSTRAINT pk_interactome_db PRIMARY KEY(interactome_db_id)
);
create index C##RA_DM.interactome_db_ididx on C##RA_DM.interactome_db(interactome_db_id) nologging;

--==========interactome_analysis==========--
create table C##RA_DM.interactome_analysis(
	interactome_analysis_id	number NOT NULL,
	interactor_a_id	VARCHAR2(100),
	interactor_name_a	VARCHAR2(100),
	interactor_b_id	VARCHAR2(100),
	interactor_name_b	VARCHAR2(100),
	analysis_id	VARCHAR2(100) NOT NULL,
	CONSTRAINT pk_interactome_analysis PRIMARY KEY(interactome_analysis_id),
	CONSTRAINT fk_interactome_analysis FOREIGN KEY (analysis_id) REFERENCES C##RA_DM.analysis(analysis_id)
);
create index C##RA_DM.interactome_analysis_iaidx on C##RA_DM.interactome_analysis(interactome_analysis_id) nologging;
create index C##RA_DM.interactome_analysis_aidx on C##RA_DM.interactome_analysis(analysis_id) nologging;

--==========genomic_seq==========--
create table C##RA_DM.genomic_seq(
	genomic_seq_id	number NOT NULL,
	seq_id	VARCHAR2(100),
	seq_file_name	VARCHAR2(100),
	specimen_id	VARCHAR2(100),
	seq_address	VARCHAR2(100),
	ref_genome_version	VARCHAR2(100),
	specimen_id	number NOT NULL,
	exp_id	VARCHAR2(100) NOT NULL,
	CONSTRAINT pk_genomic_seq PRIMARY KEY(genomic_seq_id),
	CONSTRAINT fk_genomic_seq_specimen FOREIGN KEY (specimen_id) REFERENCES C##RA_DM.specimen(specimen_id),
	CONSTRAINT fk_genomic_seq_exp FOREIGN KEY (exp_id) REFERENCES C##RA_DM.experiment(exp_id),
);
create index C##RA_DM.genomic_seq_gsidx on C##RA_DM.genomic_seq(genomic_seq_id) nologging;
create index C##RA_DM.genomic_seq_sidx on C##RA_DM.genomic_seq(specimen_id) nologging;
create index C##RA_DM.genomic_seq_eidx on C##RA_DM.genomic_seq(exp_id) nologging;

--==========genomic_count==========--
create table C##RA_DM.genomic_count(
	genomic_count_id	number NOT NULL,
	gene_id	VARCHAR2(100),
	specimen_id	number,
	gene_name	VARCHAR2(100),
	reads_count	number,
	var_count	number,
	exp_id	VARCHAR2(100) NOT NULL,
	CONSTRAINT pk_genomic_count PRIMARY KEY(genomic_count_id),
	CONSTRAINT fk_genomic_count_exp FOREIGN KEY (exp_id) REFERENCES C##RA_DM.experiment(exp_id)
);
create index C##RA_DM.genomic_count_gcidx on C##RA_DM.genomic_count(genomic_count_id) nologging;
create index C##RA_DM.genomic_count_eidx on C##RA_DM.genomic_count(exp_id) nologging;


--==========variation==========--
create table C##RA_DM.variation(
	variation_id	number NOT NULL,
	specimen_id	number,
	gene_id	VARCHAR2(100),
	variation	VARCHAR2(100),
	chrom	VARCHAR2(100),
	pos	VARCHAR2(100),
	ref	VARCHAR2(100),
	alt	VARCHAR2(100),
	var_type	VARCHAR2(100),
	qual	number,
	info	VARCHAR2(100),
	exp_id	VARCHAR2(100) NOT NULL,
	analysis_id	VARCHAR2(100) NOT NULL,
	CONSTRAINT pk_variation PRIMARY KEY(variation_id),
	CONSTRAINT fk_variation_analysis FOREIGN KEY (analysis_id) REFERENCES C##RA_DM.analysis(analysis_id),
	CONSTRAINT fk_variation_exp FOREIGN KEY (exp_id) REFERENCES C##RA_DM.experiment(exp_id)
);

create index C##RA_DM.variation_vidx on C##RA_DM.variation(variation_id) nologging;
create index C##RA_DM.variation_eidx on C##RA_DM.variation(exp_id) nologging;
create index C##RA_DM.variation_aidx  on C##RA_DM.variation(analysis_id) nologging;

--==========epige_seq==========--
create table C##RA_DM.epige_seq(
	epige_seq_id	number NOT NULL,
	seq_id	VARCHAR2(100),
	seq_file_name	VARCHAR2(100),
	specimen_id	VARCHAR2(100),
	seq_address	VARCHAR2(100),
	ref_genome_version	VARCHAR2(100),
	specimen_id	VARCHAR2(100) NOT NULL,
	exp_id	VARCHAR2(100) NOT NULL,
	CONSTRAINT pk_epige_seq PRIMARY KEY(epige_seq_id),
	CONSTRAINT fk_epige_seq_specimen FOREIGN KEY (specimen_id) REFERENCES C##RA_DM.specimen(specimen_id),
	CONSTRAINT fk_epige_seq_exp FOREIGN KEY (exp_id) REFERENCES C##RA_DM.experiment(exp_id)
);
create index C##RA_DM.epige_seq_esidx on C##RA_DM.epige_seq(epige_seq_id) nologging;
create index C##RA_DM.epige_seq_sidx on C##RA_DM.epige_seq(specimen_id) nologging;
create index C##RA_DM.epige_seq_eidx on C##RA_DM.epige_seq(exp_id) nologging;

--==========epige_count==========--
create table C##RA_DM.epige_count(
	epige_count_id	number NOT NULL,
	chromosome	VARCHAR2(100),
	pos	number,
	total_reads_count	VARCHAR2(100),
	methy_reads	number,
	specimen_id	VARCHAR2(100) NOT NULL,
	exp_id	VARCHAR2(100) NOT NULL,
	CONSTRAINT pk_epige_count PRIMARY KEY(epige_count_id),
	CONSTRAINT fk_epige_count_specimen FOREIGN KEY (specimen_id) REFERENCES C##RA_DM.specimen(specimen_id),
	CONSTRAINT fk_epige_count_exp FOREIGN KEY (exp_id) REFERENCES C##RA_DM.experiment(exp_id)
);
create index C##RA_DM.epige_count_ecidx on C##RA_DM.epige_count(epige_count_id) nologging;
create index C##RA_DM.epige_count_sidx on C##RA_DM.epige_count(specimen_id) nologging;
create index C##RA_DM.epige_count_eidx on C##RA_DM.epige_count(exp_id) nologging;

--==========epige_diff_analysis_dml==========--
create table C##RA_DM.epige_diff_analysis_dml(
	epige_diff_analysis_dml_id	number NOT NULL,
	chromosome	VARCHAR2(100),
	pos	number,
	group_a	VARCHAR2(100),
	group_b	VARCHAR2(100),
	methy_mean_a	number,
	methy_mean_b	number,
	diff	number,
	diff_se	number,
	stat	number,
	phi_a	number,
	phi_b	number,
	p_value	number,
	fdr	number,
	postprob_overthreshold	number,
	analysis_id	VARCHAR2(100) NOT NULL,
	CONSTRAINT pk_epige_diff_analysis_dml PRIMARY KEY(epige_diff_analysis_dml_id),
	CONSTRAINT fk_epige_diff_analysis_dml_analysis FOREIGN KEY (analysis_id) REFERENCES C##RA_DM.analysis(analysis_id)
);
create index C##RA_DM.epige_diff_analysis_dml_edadidx on C##RA_DM.epige_diff_analysis_dml(epige_diff_analysis_dml_id) nologging;
create index C##RA_DM.epige_diff_analysis_dml_aidx on C##RA_DM.epige_diff_analysis_dml(analysis_id) nologging;


--==========epige_diff_analysis_dmr==========--
create table C##RA_DM.epige_diff_analysis_dmr(
	epige_diff_analysis_dmr_id	number NOT NULL,
	chromosome	VARCHAR2(100),
	pos_start	number,
	pos_end	number,
	group_a	VARCHAR2(100),
	group_b	VARCHAR2(100),
	length	number,
	ncg	number,
	methy_mean_a	number,
	methy_mean_b	number,
	diff	number,
	areastat	number,
	analysis_id	VARCHAR2(100) NOT NULL,
	CONSTRAINT pk_epige_diff_analysis_dmr PRIMARY KEY(epige_diff_analysis_dmr_id),
	CONSTRAINT fk_epige_diff_analysis_dmr_analysis FOREIGN KEY (analysis_id) REFERENCES C##RA_DM.analysis(analysis_id)
);
create index C##RA_DM.epige_diff_analysis_dmr_edaidx on C##RA_DM.epige_diff_analysis_dmr(epige_diff_analysis_dmr_id) nologging;
create index C##RA_DM.epige_diff_analysis_dmr_aidx on C##RA_DM.epige_diff_analysis_dmr(analysis_id) nologging;


