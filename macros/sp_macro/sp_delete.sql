{% macro sp_delete(table_name) %}
    {% set sql1 -%}
      
          delete from {{target.schema+'_stored_proc'}}.{{table_name}}
    {%- endset %}

    {% do run_query(sql1) %}

{% endmacro %}
