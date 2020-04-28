SELECT * FROM 
(select SQL_ID,SQL_fullTEXT,
        (cpu_time/1000000) "CPU_Seconds",
        disk_reads "Disk_Reads",
        buffer_gets "Buffer_Gets",
        executions "Executions",
        case when rows_processed = 0 then null
             else round((buffer_gets/nvl(replace(rows_processed,0,1),1))) 
             end "Buffer_gets/rows_proc",
        round((buffer_gets/nvl(replace(executions,0,1),1))) "Buffer_gets/executions",
        (elapsed_time/1000000) "Elapsed_Seconds",
        module "Module"
  FROM gv$sql s
  WHERE LAST_ACTIVE_TIME BETWEEN '31/01/2017 17:14:00' AND '31/01/2017 17:20:00'
  ORDER BY disk_reads DESC NULLS LAST)
where rownum < 10
