%dw 2.0
input records application/csv
output application/apex
---
records map(record) -> {
 FirstName: record.first_name,
 LastName: record.last_name,
 Company: record.email,
 Address: record.address
} as Object {class: "CsvData"}
