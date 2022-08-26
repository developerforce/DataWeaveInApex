%dw 2.0 
// https://docs.mulesoft.com/dataweave/2.3/dataweave-formats
input payload application/json
input attributes application/json
input exchangeRate application/json
output application/xml
//https://docs.mulesoft.com/dataweave/2.3/dataweave-cookbook-reference-multiple-inputs
--- 
books: {
  (payload filter ($.properties.year > attributes.publishedAfter) map  (item)   ->  {
    book @(year: item.properties.year): {
      (exchangeRate.USD map {
        price @(currency: $.currency): $.ratio * item.price
      }),
      title: item.properties.title,
      authors: { (item.properties.author map {
        author: $
      }) }
    }
  } )
}