--variables declaration and initialisation
{%set vPhase_nm = 'Sp02_IW_12_Load_Started'%}
{%set vStep_no = 10%}
{%set vTable_nm = 'All1'%}
{%set vPID = 'Some_ID'%}
{%set vDUP_count = None%}

--calling delete macro for deleting values from a table by passing table name
{{ sp_delete('proc_journal_detail') }}

--calling macro for inserting values in proc_journal table
{{ sp_insert('proc_journal_detail',vStep_no,vTable_nm,vPID,'usernmae1',vPhase_nm) }}

-- repeating steps
{%set vStep_no = 20%}
{%set vTable_nm = 'proc_journal_detail'%}


--deleting from table
{{ sp_delete(vTable_nm) }}


--inserting values into same table as above
--here we are creating a macro, we can also create a model for different tables and using select statement that model can be created in database also
{{ sp_insert_r('sp_table') }}

-- neg key generation macro, we can give variable number of arguments
-- the column names for which we have to enter -1 are being passed as strings 
{{ neg_key_gen(vTable_nm,'v_PID','vPhase_nm') }}

-- setting the vDUP_count variable, here we are assigning a value for demo purpose
-- value of this var is count of integration ids
{% set vDUP_count = 23 %}
-- if vDUP_count is not null we will raise an exception
{% if vDUP_count==null %}
  {{ exceptions.raise_compiler_error("Invalid `number`. Got: " ~ vDUP_count) }}
{% endif %}
select 1

