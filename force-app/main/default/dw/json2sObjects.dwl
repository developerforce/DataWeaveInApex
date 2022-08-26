%dw 2.0
input mapping application/json
input incomingJson application/json
output application/json

---
incomingJson map (record) -> (
            record mapObject (value, key, index) -> (
                        ((mapping[key]): value) if mapping[key] != null
    )
)