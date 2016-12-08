SSID  = "put network name here"
PSK   = "put network key here"

print("Initalizing WIFI...")
wifi.setmode(wifi.STATION)
wifi.sta.config(SSID,PSK)
wifi.sta.connect()
print("Your MAC Address is " .. wifi.sta.getmac())
tmr.alarm(1, 1000, 1, function() 
    if wifi.sta.getip()== nil then 
    	gpio.write(3, gpio.HIGH)
    	print("Waiting for IP Address...") 
    else 
    	tmr.stop(1)
    	gpio.write(3, gpio.LOW)
    	print("Connected to " .. SSID)
		print("Your IP Address is " .. wifi.sta.getip())
    	dofile('webtempprobe.lua')
    end 
 end)
