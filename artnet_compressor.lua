#!/usr/bin/env luajit

local LEDsController = require "lib.LEDsController.LEDsController"

local FPS = 25
local LED_NB = 512
local ctn = 0
local send = false

local controller = LEDsController:new(LED_NB, "BRO888", "192.168.1.198")
-- controller:start_dump("RGB888")

while ctn < 300 do
	local receive_data, remote_ip, remote_port = controller.udp:receivefrom()
	if receive_data then
		-- print(remote_ip, remote_port, #receive_data)
		local opp = controller:receiveArtnet(receive_data, remote_ip, remote_port)
		if opp == "sync" then send = true end
		-- print(inspect(input))
	end

	local delay_pqt	= 1/FPS

	if send then
		--controller:dump()
		ctn = ctn + 1
		controller:send(0)
		send = false
	end
	-- socket.sleep(0.01)
end
