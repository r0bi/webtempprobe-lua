require('ds18b20')
ds18b20.setup(4)
print("Starting web server...")
srv = net.createServer(net.TCP, 30)
print("Waiting for web requests...")
srv:listen(80, function(conn)
    conn:on("receive", function(sck, payload)
        print(payload)
        if (ds18b20.read() == nil) then
        	sck:send("HTTP/1.0 200 OK\r\nContent-Type: text/plain\r\n\r\n" .. "Error - Probe not detected")
        elseif (ds18b20.read() == 85) then
            print("Waiting for probe to initialize...")
            tmr.delay(1000000)
            sck:send("HTTP/1.0 200 OK\r\nContent-Type: text/plain\r\n\r\n" .. "Probe 1|" .. string.format("%.1f", ds18b20.readNumber(nil,'F')))
        else
            sck:send("HTTP/1.0 200 OK\r\nContent-Type: text/plain\r\n\r\n" .. "Probe 1|" .. string.format("%.1f", ds18b20.readNumber(nil,'F')))
        end
    end)
    conn:on("sent", function(sck) sck:close() end)
end)
