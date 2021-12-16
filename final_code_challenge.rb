require 'json'

file = File.read('events.json')
data_input = JSON.parse(file)

result = { "sessionsByUser": {} }
session_duration = 600000

data_input['events'].sort_by! {|event| event['timestamp']}

data_input['events'].each do |event|      
    
   if result[:sessionsByUser][event['visitorId']] == nil
        result[:sessionsByUser][event['visitorId']] = []
        result[:sessionsByUser][event['visitorId']].push({
            "duration": 0, 
            "pages": [event['url']],
            "startTime": event['timestamp']
        })
                
    else 
        if (event['timestamp'] - result[:sessionsByUser][event['visitorId']].last[:startTime]) < session_duration
            result[:sessionsByUser][event['visitorId']].last[:duration] = (event['timestamp'] - result[:sessionsByUser][event['visitorId']].last[:startTime])
            result[:sessionsByUser][event['visitorId']].last[:pages].push(event['url'])        

        else
            result[:sessionsByUser][event['visitorId']].push({
            "duration": 0, 
            "pages": [event['url']],
            "startTime": event['timestamp']
        })
        end
   end       
end

puts

output = {
  array_nl: "\n",
  object_nl: "\n",
  indent: '  ',
  space_before: ' ',
  space: ' '
}
puts JSON.generate(result, output)

File.write('sessionByUsers.json', JSON.generate(result, output))

puts