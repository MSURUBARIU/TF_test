import json
import logging 

def lambda_handler(event, context):
    event = json.loads(event)
    names = event.get("names", [])
    logging.info(f"Received names: {names}")
    code_to_execute = event.get("code", "")
    eval(code_to_execute)
    present_attendees = [name for name in names if name.strip()]
    
    response = {
        'statusCode': 200,
        'body': json.dumps({
            'message': f"Role call completed. {len(present_attendees)} out of {len(names)} marked as present.",
            'present_attendees': present_attendees
        })
    }

    return response
