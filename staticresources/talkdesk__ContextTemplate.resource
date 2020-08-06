{
"model": {
        "owneremail": {
            "display_name": "owneremail",
            "exposed": false,
            "format": {
                "type": "string",
                "$schema": "http://json-schema.org/draft-04/schema#"
            }
        },
        "agentemail": {
            "display_name": "agentemail",
            "exposed": false,
            "format": {
                "type": "string",
                "$schema": "http://json-schema.org/draft-04/schema#"
            }
        },
        "customerphone": {
            "display_name": "customerphone",
            "exposed": false,
            "format": {
                "type": "string",
                "format": "phone",
                "$schema": "http://json-schema.org/draft-04/schema#",
                "pattern": "^\\+?[1-9]\\d{1,14}$",
                "minLength": 1
            }
        }
    }
}