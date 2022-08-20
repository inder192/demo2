{% macro neg_key_gen(table_name) %}
{% set sql1 %}
    insert into {{target.schema+'_stored_proc'}}.{{table_name}} 
    (
 {% for v in varargs %}
    {{v}} {% if not loop.last %},{% endif %}
    {%endfor%}
    )
    values(
    {% for v in varargs %}
    -1 {% if not loop.last %},{% endif %}
    {%endfor%}
    )
    -- we need extra _stored_proc becs  dbtProject file we have defined different schema for model under storeprocedure folder
    
    {% endset %}

    {% do run_query(sql1) %}
{%endmacro%}
