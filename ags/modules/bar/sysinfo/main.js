import { Widget } from "../../../imports.js"
import{ Volume } from "./volume.js"
import{ BluetoothWidget } from "./bluetooth.js"
import{ NetworkWidget } from "./network.js"
import{ BatteryWidget } from "./battery.js"
const { Box } = Widget;

const sysinfo = () => Widget.Button({
    class_name: 'sysinfo',
    onClicked: () => App.toggleWindow("dashboard"),
    child: Box({
        children: [
            NetworkWidget(),
            BluetoothWidget(),
            Volume(), 
            BatteryWidget(),

        ]
    }),
});

export const SysInfo = () => Box({
    children: [sysinfo()],
});
