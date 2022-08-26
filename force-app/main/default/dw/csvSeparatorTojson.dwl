%dw 2.0 
// CSV Reader properties https://docs.mulesoft.com/dataweave/2.2/dataweave-formats#format_csv
input records application/csv separator=';'
output application/json 
--- 
records