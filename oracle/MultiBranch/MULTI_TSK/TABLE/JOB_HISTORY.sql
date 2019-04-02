CREATE TABLE "HR"."JOB_HISTORY" 
   (	"EMPLOYEE_ID" NUMBER(6,0), 
	"START_DATE" DATE, 
	"END_DATE" DATE, 
	"JOB_ID" VARCHAR2(10), 
	"DEPARTMENT_ID" NUMBER(4,0),
	"LEFT_IN_DISGUST" NUMBER(1,0)
   ) ;
   COMMENT ON COLUMN "HR"."JOB_HISTORY"."EMPLOYEE_ID" IS 'A not null column in the complex primary key employee_id+start_date.
Foreign key to employee_id column of the employee table';
   COMMENT ON COLUMN "HR"."JOB_HISTORY"."START_DATE" IS 'A not null column in the complex primary key employee_id+start_date.
Must be less than the end_date of the job_history table. (enforced by
constraint jhist_date_interval)';
   COMMENT ON COLUMN "HR"."JOB_HISTORY"."END_DATE" IS 'Last day of the employee in this job role. A not null column. Must be
greater than the start_date of the job_history table.
(enforced by constraint jhist_date_interval)';
   COMMENT ON COLUMN "HR"."JOB_HISTORY"."JOB_ID" IS 'Job role in which the employee worked in the past; foreign key to
job_id column in the jobs table. A not null column.';
   COMMENT ON COLUMN "HR"."JOB_HISTORY"."DEPARTMENT_ID" IS 'Department id in which the employee worked in the past; foreign key to deparment_id column in the departments table';
   COMMENT ON TABLE "HR"."JOB_HISTORY"  IS 'Table that stores job history of the employees. If an employee
changes departments within the job or changes jobs within the department,
new rows get inserted into this table with old job information of the
employee. Contains a complex primary key: employee_id+start_date.
Contains 25 rows. References with jobs, employees, and departments tables.';

  CREATE INDEX "HR"."JHIST_DEPARTMENT_IX" ON "HR"."JOB_HISTORY" ("DEPARTMENT_ID") 
  ;
  CREATE INDEX "HR"."JHIST_EMPLOYEE_IX" ON "HR"."JOB_HISTORY" ("EMPLOYEE_ID") 
  ;
  CREATE INDEX "HR"."JHIST_JOB_IX" ON "HR"."JOB_HISTORY" ("JOB_ID") 
  ; 
  ALTER TABLE "HR"."JOB_HISTORY" ADD CONSTRAINT "JHIST_DEPT_FK" FOREIGN KEY ("DEPARTMENT_ID")
	  REFERENCES "HR"."DEPARTMENTS" ("DEPARTMENT_ID") ENABLE;
  ALTER TABLE "HR"."JOB_HISTORY" ADD CONSTRAINT "JHIST_EMP_FK" FOREIGN KEY ("EMPLOYEE_ID")
	  REFERENCES "HR"."EMPLOYEES" ("EMPLOYEE_ID") ENABLE;
  ALTER TABLE "HR"."JOB_HISTORY" ADD CONSTRAINT "JHIST_JOB_FK" FOREIGN KEY ("JOB_ID")
	  REFERENCES "HR"."JOBS" ("JOB_ID") ENABLE; 
  ALTER TABLE "HR"."JOB_HISTORY" MODIFY ("EMPLOYEE_ID" CONSTRAINT "JHIST_EMPLOYEE_NN" NOT NULL ENABLE);
  ALTER TABLE "HR"."JOB_HISTORY" MODIFY ("START_DATE" CONSTRAINT "JHIST_START_DATE_NN" NOT NULL ENABLE);
  ALTER TABLE "HR"."JOB_HISTORY" ADD CONSTRAINT "JHIST_DATE_INTERVAL" CHECK (end_date > start_date) ENABLE;
  ALTER TABLE "HR"."JOB_HISTORY" MODIFY ("END_DATE" CONSTRAINT "JHIST_END_DATE_NN" NOT NULL ENABLE);
  ALTER TABLE "HR"."JOB_HISTORY" MODIFY ("JOB_ID" CONSTRAINT "JHIST_JOB_NN" NOT NULL ENABLE);
  ALTER TABLE "HR"."JOB_HISTORY" ADD CONSTRAINT "JHIST_EMP_ID_ST_DATE_PK" PRIMARY KEY ("EMPLOYEE_ID", "START_DATE")
  USING INDEX  ENABLE; 