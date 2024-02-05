import { Widget } from "../../../imports.js";
import{ Volume } from "./volume.js"
import{ BluetoothWidget } from "./bluetooth.js"
import{ NetworkWidget } from "./network.js"
const { Box } = Widget;

const sysinfo = () => Widget.Button({
    class_name: 'sysinfo',
    child: Box({
        children: [
            NetworkWidget(),
            BluetoothWidget(),
            Volume(), 
        ]
    }),
});

export const SysInfo = () => Box({
    children: [sysinfo()],
});
