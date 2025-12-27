Tests folder code
=============

{% test value_check(model,column_name) %}


select * from
{{ model }}
where {{ column_name }} < 10000


{% endtest %}


Yml file code
==========

version: 2


models:
  - name: employee
    description: "DBT Model for employee table"
    columns:
      - name: emp_id
        tests:
          - unique
          - not_null
          - accepted_values:
              values: ['1','2','3','4','5']
              config:
                severity: warn
      - name: emp_salary
        tests:
          - value_check
   
sources:
  - name: employee
    database: DBT_DB
    schema: PUBLIC
    tables:
      - name: EMPLOYEE_RAW
