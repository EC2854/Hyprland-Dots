const { Box } = Widget;

import{ NetworkWidget } from "./network.js"
import{ BluetoothWidget } from "./bluetooth.js"
import{ Volume } from "./volume.js"
import{ BatteryWidget } from "./battery.js"

export const SysInfo = () => Widget.Button({
    class_name: 'sysinfo',
    onClicked: () => App.toggleWindow("dashboard"),
    child: Box({
        children: [
            NetworkWidget(),
            BluetoothWidget(),
            Volume(), 
            // BatteryWidget(),
        ]
    }),
});
