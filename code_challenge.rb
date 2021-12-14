data_input = {
  "events": [
       {
           "url": "/pages/a-big-river",
           "visitorId": "d1177368-2310-11e8-9e2a-9b860a0d9039",
           "timestamp": 1512754583000
       },
       {
           "url": "/pages/a-small-dog",
           "visitorId": "d1177368-2310-11e8-9e2a-9b860a0d9039",
           "timestamp": 1512754631000
       },
      {
          "url": "/pages/a-big-talk",
          "visitorId": "f877b96c-9969-4abc-bbe2-54b17d030f8b",
          "timestamp": 1512709065294
      },
      {
          "url": "/pages/a-sad-story",
          "visitorId": "f877b96c-9969-4abc-bbe2-54b17d030f8b",
          "timestamp": 1512711000000
      },
      {
          "url": "/pages/a-big-river",
          "visitorId": "d1177368-2310-11e8-9e2a-9b860a0d9039",
          "timestamp": 1512754436000
      },
      {
          "url": "/pages/a-sad-story",
          "visitorId": "f877b96c-9969-4abc-bbe2-54b17d030f8b",
          "timestamp": 1512709024000
      }
  ]
}

result = { "sessionsByUser": {} }

data_input[:events].sort_by! {|event| event[:timestamp]}

data_input[:events].each do |event|
   if result[:sessionsByUser][event[:visitorId]] == nil
        result[:sessionsByUser][event[:visitorId]] = []
        result[:sessionsByUser][event[:visitorId]].push({
            "duration": 0, 
            "pages": [event[:url]],
            "startTime": event[:timestamp]
        })

    else 
        if event[:timestamp] - result[:sessionsByUser][event[:visitorId]].last[:startTime] < 600000
            result[:sessionsByUser][event[:visitorId]].last[:duration] = (event[:timestamp] - result[:sessionsByUser][event[:visitorId]].last[:startTime])
            result[:sessionsByUser][event[:visitorId]].last[:pages].push(event[:url])        

        else
            result[:sessionsByUser][event[:visitorId]].push({
            "duration": 0, 
            "pages": [event[:url]],
            "startTime": event[:timestamp]
        })
        end
   end 
   
       
end

puts result
