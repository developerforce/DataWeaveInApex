%dw 2.0 
input data application/csv
output application/json
fun renameKey(key: Key) = key match {
    case "first_name" -> "FirstName"
    case "last_name" -> "LastName"
    case "company_name" -> "Company"
    case "phone1" -> "HomePhone"
    case "phone" -> "Phone"
    case "email" -> "Email"
    case "date" -> "DateofBirth"
    case "address" -> "Address"
    case "city" -> "City"
    case "county" -> "Country"
    case "state" -> "State"
    case "zip" -> "Zip"
    else -> (key)
}
--- 
data map (contact) ->
contact mapObject (value, key) -> {
    (renameKey(key)) : value
}