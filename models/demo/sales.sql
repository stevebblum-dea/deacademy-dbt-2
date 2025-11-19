{{
    config
    (
        materialized='incremental',
        incremental_strategy = 'append'
    )
}}

with sales_src as 
(
        select
        SALE_ID,
        SALE_DATE,
        CUSTOMER_ID,
        PRODUCT_ID,
        QUANTITY,
        TOTAL_AMOUNT,
        CREATED_AT,
        CURRENT_TIMESTAMP AS INSERT_DTS
        FROM {{source('sales','SALES_SRC')}}

        {% if is_incremental() %}
        WHERE CREATED_AT > (SELECT COALESCE(MAX(CREATED_AT),'1/1/1900') FROM {{this}})
        {% endif %}
)

SELECT * FROM sales_src