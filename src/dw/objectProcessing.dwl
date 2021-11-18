%dw 2.0
input records application/java
output application/json
---
{
  users: records map(record) -> {
    firstName: record.FirstName,
    lastName: record.LastName
  }
}