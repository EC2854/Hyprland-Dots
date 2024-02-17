import { Widget } from "../../imports.js";
const { Window, Box, CenterBox } = Widget;

// Widgets
import { Workspaces } from "./workspaces.js";
import { Clock } from "./clock.js";
import { Media } from "./media.js";
import { Notification } from "./notification.js"
import { Title } from "./title.js";
import { SysInfo } from "./sysinfo/sysinfo.js";
import { sysTray } from "./tray.js";

const Left = () => Box({
    children: [Workspaces(), Title()],
});

const Center = () => Box({
    children: [Media()],
});

const Right = () => Box({
    hpack: "end",
    children: [Notification(), sysTray(), SysInfo(), Clock()],
});

export const Bar = () => Window({
    name: "bar",
    anchor: ["top", "right", "left"],
    exclusivity: "exclusive",
    margins: [10, 15, 0],
    child: CenterBox({
        className: "bar",
        start_widget: Left(),
        center_widget: Center(),
        end_widget: Right(),
    }),
});
