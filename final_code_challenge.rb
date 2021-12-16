require 'json'

file = File.read('events.json')
data_input = JSON.parse(file)

result = { }
session_duration = 600000

data_input['events'].sort_by! {|event| event['timestamp']}

data_input['events'].each do |event|      
    
   if result[event['visitorId']] == nil
        result[event['visitorId']] = []
        result[event['visitorId']].push({
            "duration": 0, 
            "pages": [event['url']],
            "startTime": event['timestamp']
        })
                
    else 
        if (event['timestamp'] - result[event['visitorId']].last[:startTime]) <= session_duration
            result[event['visitorId']].last[:duration] = (event['timestamp'] - result[event['visitorId']].last[:startTime])
            result[event['visitorId']].last[:pages].push(event['url'])        

        else
            result[event['visitorId']].push({
            "duration": 0, 
            "pages": [event['url']],
            "startTime": event['timestamp']
        })
        end
   end       
end

json_output = {
  array_nl: "\n",
  object_nl: "\n",
  indent: '  ',
  space_before: ' ',
  space: ' '
}
result_json = JSON.generate({'sessionByUser': result}, json_output)
puts result_json

File.write('sessionByUsers.json', result_json)