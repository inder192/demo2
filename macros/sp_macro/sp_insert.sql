/* insert like this '{{vTable_nm}}'*/
{% macro sp_insert(table_name,vStep_no,vTable_nm,vPID,user_var,vPhase_nm) %}

     {% set dest_cols = adapter.get_columns_in_relation(ref(table_name)) %}

    {% set dest_cols_csv = dest_cols | map(attribute='quoted') | join(', ') %}

    {% set sql1 -%}
        insert into {{target.schema+'_stored_proc'}}.{{table_name}}
         ({{ dest_cols_csv }}) values
           ({{vStep_no}},'tbl_nme','{{vPID}}','{{user_var}}','{{vPhase_nm}}')
          
         /* values (990,'table name','p id','user name','phase anme')*/
   
    {%- endset %}

    {% do run_query(sql1) %}

{% endmacro %}
